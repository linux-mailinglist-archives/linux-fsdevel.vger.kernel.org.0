Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA24BB3D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 09:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiBRIC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 03:02:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiBRIC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:02:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725321FECA;
        Fri, 18 Feb 2022 00:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 123F2B81C21;
        Fri, 18 Feb 2022 08:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BCAC340EB;
        Fri, 18 Feb 2022 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645171356;
        bh=NUlcL9+98RkSnEHuB4RbeA0kdHu/Vm1M0qRPByORiXM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FK/wUgOeKLrPHPKc45gRhzQFctFkPUl7hmSuzFrqMDyRC7Q9U95qPIizQGG/+jYF8
         ac3D++/CBBD0erAILfvbOXBUcX/xci9M03GFE6/PIE4iZXs6zzv73mwCaVw+dAEwJO
         w61mUwRBQZlu1olneQEGKNaC/H7MQACTafBBkrMcicG4eO0vA5o+qKs19TPn6wd7r5
         yNwUSXuO+0cjOitOMdqc0Tgh4hNRXXtTbFyuXPoQyY41deI/rmX469zGgfi731k1cF
         ImMXu//UmuDrO3q6LlEkNsU5OnajBaJOC+SQ7J20S9efRuNkzxuDJ9XrpVbUeUbVI2
         jHJhvFn7TqIEA==
Received: by mail-wm1-f49.google.com with SMTP id n8so4662927wms.3;
        Fri, 18 Feb 2022 00:02:36 -0800 (PST)
X-Gm-Message-State: AOAM531vTHyZHgm13Obef2ONQt2jTLl5y2yLz+jStw11n3xqmqGhManZ
        ME/WcX18qIeANm4DEyhTHbSdNQeAFLWmvEx+vmQ=
X-Google-Smtp-Source: ABdhPJwx1r4+NgODyxjeVLAvCm8mGNWsCilCANKqgUh3sMl4RDeoYrxSb75BOy9FgVWe2dUZ9UM30oIRUrf3FcTXflI=
X-Received: by 2002:a7b:c001:0:b0:37d:409d:624d with SMTP id
 c1-20020a7bc001000000b0037d409d624dmr5945124wmb.64.1645171354835; Fri, 18 Feb
 2022 00:02:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:168c:0:0:0:0 with HTTP; Fri, 18 Feb 2022 00:02:34
 -0800 (PST)
In-Reply-To: <Yg7dMwEebkITEMI+@zeniv-ca.linux.org.uk>
References: <20220216230319.6436-1-linkinjeon@kernel.org> <Yg7dMwEebkITEMI+@zeniv-ca.linux.org.uk>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 18 Feb 2022 17:02:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9CEDqfwNsVU=DkfBhmL2zmiRaTfALeDRt8KHqMVnQ=1w@mail.gmail.com>
Message-ID: <CAKYAXd9CEDqfwNsVU=DkfBhmL2zmiRaTfALeDRt8KHqMVnQ=1w@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: fix racy issue from using ->d_parent and ->d_name
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,
2022-02-18 8:41 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Feb 17, 2022 at 08:03:19AM +0900, Namjae Jeon wrote:
>> Al pointed out that ksmbd has racy issue from using ->d_parent and
>> ->d_name
>> in ksmbd_vfs_unlink and smb2_vfs_rename(). and he suggested changing from
>> the way it start with dget_parent(), which can cause retry loop and
>> unexpected errors, to find the parent of child, lock it and then look for
>> a child in locked directory.
>>
>> This patch introduce a new helper(vfs_path_parent_lookup()) to avoid
>> out of share access and export vfs functions like the following ones to
>> use
>> vfs_path_parent_lookup() and filename_parentat().
>>  - __lookup_hash().
>>  - getname_kernel() and putname().
>>  - filename_parentat()
>
> First of all, your vfs_path_parent_lookup() calling conventions are wrong.
> You have 3 callers:
> 	err = vfs_path_parent_lookup(share->vfs_path.dentry,
> 				     share->vfs_path.mnt, filename_struct,
> 				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
> 				     &path, &last, &type);
> 	err = vfs_path_parent_lookup(share_conf->vfs_path.dentry,
> 				     share_conf->vfs_path.mnt, to,
> 				     lookup_flags | LOOKUP_BENEATH,
> 				     &new_path, &new_last, &new_type);
> 	err = vfs_path_parent_lookup(share->vfs_path.dentry,
> 				     share->vfs_path.mnt, filename_struct,
> 				     LOOKUP_NO_SYMLINKS | LOOKUP_BENEATH,
> 				     &path, &last, &type);
> Note that in all of them the first two arguments come from ->dentry and
> ->mnt of the same struct path instance.  Now, look at the function itself:
>
> int vfs_path_parent_lookup(struct dentry *dentry, struct vfsmount *mnt,
> 			   struct filename *filename, unsigned int flags,
> 			   struct path *parent, struct qstr *last, int *type)
> {
> 	struct path root = {.mnt = mnt, .dentry = dentry};
>
> 	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
> 				    type, &root);
> }
>
> What about the __filename_parentat() last argument?  It's declared as
> struct path *root and passed to set_nameidata().  No other uses.  And
> set_nameidata() gets it via const struct path *root argument.  IOW,
> it's not going to modify the contents of that struct path.  Since
> you __filename_parentat() doesn't do anything else with its root
> argument, there's no reason not to make _that_ const struct path *,
> is there?
Yep, No reason.

>
> Now, if you do that, you can safely turn vfs_path_parent_lookup()
> take const struct path * instead of dentry/vfsmount pair of arguments
> and drop the local struct path instance in the vfs_path_parent_lookup()
> itself.
Yes. I will change it.

>
> The fact that vfs_path_lookup() passes vfsmount and dentry separately
> doesn't mean you need to do the same - look at the existing callers
> of vfs_path_lookup() (outside of ksmbd itself) and you'll see the
> difference.  Incidentally, this
> fs/ksmbd/vfs.c:22:#include "../internal.h"      /* for vfs_path_lookup */
> had been a really bad idea.  And no, nfsd doing the same is not a good
> thing either...
>
> General rule: if it's exported, it's *NOT* internal.
Okay. Then as another patch, I will move vfs_path_lookup prototype in
internal.h to linux/namei.h.

>
>
> Next:
>
>> index 077b8761d099..b094cd1d4951 100644
>> --- a/fs/ksmbd/oplock.c
>> +++ b/fs/ksmbd/oplock.c
>> @@ -1713,11 +1713,14 @@ int smb2_check_durable_oplock(struct ksmbd_file
>> *fp,
>>  			ret = -EBADF;
>>  			goto out;
>>  		}
>> +		down_read(&fp->filename_lock);
>>  		if (name && strcmp(fp->filename, name)) {
>> +			up_read(&fp->filename_lock);
>>  			pr_err("invalid name reconnect %s\n", name);
>>  			ret = -EINVAL;
>>  			goto out;
>>  		}
>> +		up_read(&fp->filename_lock);
>
> What assumptions do you make about those strings?  Note that opened file
> is *NOT* guaranteed to have its pathname remain unchanged - having
> /tmp/foo/bar/baz/blah opened will not prevent mv /tmp/foo /tmp/barf
> and the file will remain opened (and working just fine).  AFAICS, you
> only update it in smb2_rename(), which is not going to be called by
> mv(1) called by admin on server.
Whenever a FILE_ALL_INFORMATION request is received from a client,
ksmbd need to call d_path(then, removing the share path in pathname is
required) to obtain pathname for windows. To avoid the issue you
mentioned, we can remove the all uses of ->filename and calling
d_path() whenever pathname is need.

>
> BTW, while grepping through the related code, convert_to_nt_pathname()
> is Not Nice(tm).  Seriously, strlen(s) == 0 is not an idiomatic way to
> check that s is an empty string.  What's more, return value of that
> function ends up passed to kfree().  Which is not a good thing to do
> to a string constant.  That can be recovered by use of kfree_const() in
> get_file_all_info(), but.. ouch.
Okay.

>
> ksmbd_vfs_rename(): UGH.
> 	* you allocate a buffer
> 	* do d_path() into it
> 	* then use getname_kernel() to allocate another one and copy the contents
> into it.  By that point the string might have nothing to do with the actual
> location of object, BTW (see above)
Can we use dget_parent() and take_dentry_name_snapshot() for source
file instead of d_path(), getname_kernel() and filename_parentat()?
Because ksmbd receive fileid(ksmbd_file) for source file from client.
[See control flow the below]

> 	* then you use filename_parentat() (BTW, the need to export both it and
> vfs_path_parent_lookup() is an artefact of bad calling conventions -
> passing
> NULL as const struct path * would do the right thing, if not for the fact
> that
> with your calling conventions you have to pass a non-NULL pointer - that to
> a local struct path in your vfs_path_parent_lookup()).
Okay.

> 	* then you use vfs_path_parent_lookup() to find the new parent.  OK,
> but...
> you proceed to check if it has somehow returned you a symlink.  Huh?  How
> does
> one get a symlink from path_parentat() or anything that would use it?
As security issues, We made it not to allow symlinks.

> I would very much appreciate a reproducer for that.
> 	* you use lock_rename() to lock both parents.  Which relies upon the
> caller having checked that they live on the same filesystem.  Neither old
> nor
> new version do that, which means relatively easy deadlocks.
Okay. will add the check for this.

> 	* look the last components up.  NB: the old one might very well have
> nothing to do with the path.dentry.
Okay.

> 	* do usual checks re loop prevention (with slightly unusual error
> values, but whatever)
I understood that you pointed out to add retry_estale() check and retry.

> 	* call ksmbd_lookup_fd_inode() on the old parent.  Then dereference
> the return value (if non-NULL)... and never do anything else to it.  How
> can
> that possibly work?  What's there to prevent freeing of that struct
> ksmbd_file
> just as ksmbd_lookup_fd_inode() returns it?  Looks like it's either a leak
> or
> use-after-free, and looking at ksmbd_lookup_fd_inode() it's probably the
> latter.
Right. Need to increase reference count of ksmbd_file. I will fix it.

> 	* proceed with vfs_rename(), drop the stuff you'd acquired and go
> away.
Okay.

>
> ksmbd_vfs_unlink():
> 	* const char *filename, please, unless you really modify it there.
Okay.
> 	* what the hell is that ihold/iput pair for?
I refered codes in do_unlinkat() for this. If this pair is not needed,
I'll delete it,
but could you please tell me why it's needed in unlinkat() ?

>
> I'm not sure that the set you'd exported is the right one, but that's
> secondary - I'd really like to understand what assumptions are you
> making about the ->filename contents, as well as the control flow
> from protocol request that demands rename to the actual call of
> vfs_rename().  Could you elaborate on that?  I am not familiar with
> the protocol, other than bits and pieces I'd observed in fs/cifs
> code.
As I said above, the uses of ->filename can be replaced with d_path().
control flow for rename is the following.

 a. Receiving smb2 create(open) request from client.
     - Getting struct file after calling vfs_path_lookup() and
dentry_open() using pathname from client.
     - create ksmbd_file and add struct file to fp->filp and generate
fileid for struct ksmbd_file.
     - send smb2 create response included fileid of ksmbd_file to client.
 b. Receiving smb2_set_info file(FILE_RENAME_INFORMATION) request from client.
     - lookup ksmbd_file using fileid of request. This will source
file for rename.
     - get absolute pathname for destination fille in smb2 set info
file for rename.
     - find both parents of source and destination and lock and do rename...
 c. Receiving smb2 close.

Thanks for your review!
>
