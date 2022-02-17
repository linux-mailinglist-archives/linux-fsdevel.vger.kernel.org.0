Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9650A4BAD59
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 00:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiBQXrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Feb 2022 18:47:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBQXrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:02 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F0637840F;
        Thu, 17 Feb 2022 15:46:31 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKqP5-002bWO-Bw; Thu, 17 Feb 2022 23:41:39 +0000
Date:   Thu, 17 Feb 2022 23:41:39 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org
Subject: Re: [PATCH v2] ksmbd: fix racy issue from using ->d_parent and
 ->d_name
Message-ID: <Yg7dMwEebkITEMI+@zeniv-ca.linux.org.uk>
References: <20220216230319.6436-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216230319.6436-1-linkinjeon@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 08:03:19AM +0900, Namjae Jeon wrote:
> Al pointed out that ksmbd has racy issue from using ->d_parent and ->d_name
> in ksmbd_vfs_unlink and smb2_vfs_rename(). and he suggested changing from
> the way it start with dget_parent(), which can cause retry loop and
> unexpected errors, to find the parent of child, lock it and then look for
> a child in locked directory.
> 
> This patch introduce a new helper(vfs_path_parent_lookup()) to avoid
> out of share access and export vfs functions like the following ones to use
> vfs_path_parent_lookup() and filename_parentat().
>  - __lookup_hash().
>  - getname_kernel() and putname().
>  - filename_parentat()

First of all, your vfs_path_parent_lookup() calling conventions are wrong.
You have 3 callers:
	err = vfs_path_parent_lookup(share->vfs_path.dentry,
				     share->vfs_path.mnt, filename_struct,
				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
				     &path, &last, &type);
	err = vfs_path_parent_lookup(share_conf->vfs_path.dentry,
				     share_conf->vfs_path.mnt, to,
				     lookup_flags | LOOKUP_BENEATH,
				     &new_path, &new_last, &new_type);
	err = vfs_path_parent_lookup(share->vfs_path.dentry,
				     share->vfs_path.mnt, filename_struct,
				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
				     &path, &last, &type);
Note that in all of them the first two arguments come from ->dentry and
->mnt of the same struct path instance.  Now, look at the function itself:

int vfs_path_parent_lookup(struct dentry *dentry, struct vfsmount *mnt,
			   struct filename *filename, unsigned int flags,
			   struct path *parent, struct qstr *last, int *type)
{
	struct path root = {.mnt = mnt, .dentry = dentry};

	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
				    type, &root);
}

What about the __filename_parentat() last argument?  It's declared as
struct path *root and passed to set_nameidata().  No other uses.  And
set_nameidata() gets it via const struct path *root argument.  IOW,
it's not going to modify the contents of that struct path.  Since
you __filename_parentat() doesn't do anything else with its root
argument, there's no reason not to make _that_ const struct path *,
is there?

Now, if you do that, you can safely turn vfs_path_parent_lookup()
take const struct path * instead of dentry/vfsmount pair of arguments
and drop the local struct path instance in the vfs_path_parent_lookup()
itself.

The fact that vfs_path_lookup() passes vfsmount and dentry separately
doesn't mean you need to do the same - look at the existing callers
of vfs_path_lookup() (outside of ksmbd itself) and you'll see the
difference.  Incidentally, this
fs/ksmbd/vfs.c:22:#include "../internal.h"      /* for vfs_path_lookup */
had been a really bad idea.  And no, nfsd doing the same is not a good
thing either...

General rule: if it's exported, it's *NOT* internal.


Next:

> index 077b8761d099..b094cd1d4951 100644
> --- a/fs/ksmbd/oplock.c
> +++ b/fs/ksmbd/oplock.c
> @@ -1713,11 +1713,14 @@ int smb2_check_durable_oplock(struct ksmbd_file *fp,
>  			ret = -EBADF;
>  			goto out;
>  		}
> +		down_read(&fp->filename_lock);
>  		if (name && strcmp(fp->filename, name)) {
> +			up_read(&fp->filename_lock);
>  			pr_err("invalid name reconnect %s\n", name);
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +		up_read(&fp->filename_lock);

What assumptions do you make about those strings?  Note that opened file
is *NOT* guaranteed to have its pathname remain unchanged - having
/tmp/foo/bar/baz/blah opened will not prevent mv /tmp/foo /tmp/barf
and the file will remain opened (and working just fine).  AFAICS, you
only update it in smb2_rename(), which is not going to be called by
mv(1) called by admin on server.

BTW, while grepping through the related code, convert_to_nt_pathname()
is Not Nice(tm).  Seriously, strlen(s) == 0 is not an idiomatic way to
check that s is an empty string.  What's more, return value of that
function ends up passed to kfree().  Which is not a good thing to do
to a string constant.  That can be recovered by use of kfree_const() in
get_file_all_info(), but.. ouch.

ksmbd_vfs_rename(): UGH.
	* you allocate a buffer
	* do d_path() into it
	* then use getname_kernel() to allocate another one and copy the contents
into it.  By that point the string might have nothing to do with the actual
location of object, BTW (see above)
	* then you use filename_parentat() (BTW, the need to export both it and
vfs_path_parent_lookup() is an artefact of bad calling conventions - passing
NULL as const struct path * would do the right thing, if not for the fact that
with your calling conventions you have to pass a non-NULL pointer - that to
a local struct path in your vfs_path_parent_lookup()).
	* then you use vfs_path_parent_lookup() to find the new parent.  OK, but...
you proceed to check if it has somehow returned you a symlink.  Huh?  How does
one get a symlink from path_parentat() or anything that would use it?
I would very much appreciate a reproducer for that.
	* you use lock_rename() to lock both parents.  Which relies upon the
caller having checked that they live on the same filesystem.  Neither old nor
new version do that, which means relatively easy deadlocks.
	* look the last components up.  NB: the old one might very well have
nothing to do with the path.dentry.
	* do usual checks re loop prevention (with slightly unusual error
values, but whatever)
	* call ksmbd_lookup_fd_inode() on the old parent.  Then dereference
the return value (if non-NULL)... and never do anything else to it.  How can
that possibly work?  What's there to prevent freeing of that struct ksmbd_file
just as ksmbd_lookup_fd_inode() returns it?  Looks like it's either a leak or
use-after-free, and looking at ksmbd_lookup_fd_inode() it's probably the latter.
	* proceed with vfs_rename(), drop the stuff you'd acquired and go
away.

ksmbd_vfs_unlink():
	* const char *filename, please, unless you really modify it there.
	* what the hell is that ihold/iput pair for?

I'm not sure that the set you'd exported is the right one, but that's
secondary - I'd really like to understand what assumptions are you
making about the ->filename contents, as well as the control flow
from protocol request that demands rename to the actual call of
vfs_rename().  Could you elaborate on that?  I am not familiar with
the protocol, other than bits and pieces I'd observed in fs/cifs
code.
