Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA903491AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhCYMOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 08:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhCYMNr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE1F1619BA;
        Thu, 25 Mar 2021 12:13:44 +0000 (UTC)
Date:   Thu, 25 Mar 2021 13:13:41 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Message-ID: <20210325121341.q2ufjhnqe3osjc7c@wittgenstein>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-9-roberto.sassu@huawei.com>
 <ad33c998ee834a588e0ca1a31ee2a530@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad33c998ee834a588e0ca1a31ee2a530@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:53:43AM +0000, Roberto Sassu wrote:
> > From: Roberto Sassu
> > Sent: Friday, March 5, 2021 4:19 PM
> > With the patch to allow xattr/attr operations if a portable signature
> > verification fails, cp and tar can copy all xattrs/attrs so that at the
> > end of the process verification succeeds.
> > 
> > However, it might happen that the xattrs/attrs are already set to the
> > correct value (taken at signing time) and signature verification succeeds
> > before the copy has completed. For example, an archive might contains files
> > owned by root and the archive is extracted by root.
> > 
> > Then, since portable signatures are immutable, all subsequent operations
> > fail (e.g. fchown()), even if the operation is legitimate (does not alter
> > the current value).
> > 
> > This patch avoids this problem by reporting successful operation to user
> > space when that operation does not alter the current value of xattrs/attrs.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  security/integrity/evm/evm_main.c | 96
> > +++++++++++++++++++++++++++++++
> >  1 file changed, 96 insertions(+)
> > 
> > diff --git a/security/integrity/evm/evm_main.c
> > b/security/integrity/evm/evm_main.c
> > index eab536fa260f..a07516dcb920 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/integrity.h>
> >  #include <linux/evm.h>
> >  #include <linux/magic.h>
> > +#include <linux/posix_acl_xattr.h>
> > 
> >  #include <crypto/hash.h>
> >  #include <crypto/hash_info.h>
> > @@ -328,6 +329,79 @@ static enum integrity_status
> > evm_verify_current_integrity(struct dentry *dentry)
> >  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
> >  }
> > 
> > +/*
> > + * evm_xattr_acl_change - check if passed ACL changes the inode mode
> > + * @dentry: pointer to the affected dentry
> > + * @xattr_name: requested xattr
> > + * @xattr_value: requested xattr value
> > + * @xattr_value_len: requested xattr value length
> > + *
> > + * Check if passed ACL changes the inode mode, which is protected by
> > EVM.
> > + *
> > + * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
> > + */
> > +static int evm_xattr_acl_change(struct dentry *dentry, const char
> > *xattr_name,
> > +				const void *xattr_value, size_t
> > xattr_value_len)
> > +{
> > +	umode_t mode;
> > +	struct posix_acl *acl = NULL, *acl_res;
> > +	struct inode *inode = d_backing_inode(dentry);
> > +	int rc;
> > +
> > +	/* UID/GID in ACL have been already converted from user to init ns
> > */
> > +	acl = posix_acl_from_xattr(&init_user_ns, xattr_value,
> > xattr_value_len);
> > +	if (!acl)
> 
> Based on Mimi's review, I will change this to:
> 
> if (IS_ERR_OR_NULL(acl))
> 
> > +		return 1;
> > +
> > +	acl_res = acl;
> > +	rc = posix_acl_update_mode(&init_user_ns, inode, &mode,
> > &acl_res);
> 
> About this part, probably it is not correct.
> 
> I'm writing a test for this patch that checks if operations
> that don't change the file mode succeed and those that
> do fail.
> 
> mount-idmapped --map-mount b:3001:0:1 /mnt /mnt-idmapped
> pushd /mnt
> echo "test" > test-file
> chown 3001 test-file
> chgrp 3001 test-file
> chmod 2644 test-file
> <check enabled>
> setfacl --set u::rw,g::r,o::r,m:r test-file (expected to succeed, caller has CAP_FSETID, so S_ISGID is not dropped)
> setfacl --set u::rw,g::r,o::r,m:rw test-file (expected to fail)
> pushd /mnt-idmapped
> capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file (expected to succeed, caller is in the owning group of test-file, so S_ISGID is not dropped)
> 
> After adding a debug line in posix_acl_update_mode():
> printk("%s: %d(%d) %d\n", __func__, in_group_p(i_gid_into_mnt(mnt_userns, inode)), __kgid_val(i_gid_into_mnt(mnt_userns, inode)), capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID));
> 
> without passing mnt_userns:
> [  748.262582] setfacl --set u::rw,g::r,o::r,m:r test-file
> [  748.268021] posix_acl_update_mode: 0(3001) 1
> [  748.268035] posix_acl_update_mode: 0(3001) 1
> [  748.268570] setfacl --set u::rw,g::r,o::r,m:rw test-file
> [  748.274193] posix_acl_update_mode: 0(3001) 1
> [  748.279198] capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file
> [  748.287894] posix_acl_update_mode: 0(3001) 0
> 
> passing mnt_userns:
> [   81.159766] setfacl --set u::rw,g::r,o::r,m:r test-file
> [   81.165207] posix_acl_update_mode: 0(3001) 1
> [   81.165226] posix_acl_update_mode: 0(3001) 1
> [   81.165732] setfacl --set u::rw,g::r,o::r,m:rw test-file
> [   81.170978] posix_acl_update_mode: 0(3001) 1
> [   81.176014] capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file
> [   81.184648] posix_acl_update_mode: 1(0) 0
> [   81.184663] posix_acl_update_mode: 1(0) 0
> 
> The difference is that, by passing mnt_userns, the caller (root) is
> in the owning group of the file (3001 -> 0). Without passing mnt_userns,
> it is not (3001 -> 3001).
> 
> Christian, Andreas, could you confirm that this is correct?

Hey Robert,

Thanks for the Cc and thanks for testing this with and without idmapped
mounts; very much appreciated.

> 
> If there are no objections, I will send an additional patch to pass
> mnt_userns to EVM.

Yes, since you're starting to verify attrs and posix_acl changes that
deal with uids/gids you need to account for the mnt_userns. I've pulled
and applied your patch locally and looked through it. I think you need
to change:

- evm_inode_setxattr()
- evm_inode_removexattr()

to take a mnt_userns. That should be straightforward. I already changed
security_inode_setxattr() to pass down the mnt_userns so you need to
simply pass that further down:

- security_inode_setxattr(mnt_userns, ...)
  -> evm_inode_setxattr(mnt_userns, ...)

- security_inode_removexattr(mnt_userns, ...)
  -> evm_inode_removexattr(mnt_userns, ...)

The rest looks sane to me.

Fwiw, I'm mainting a large test-suite that I wrote for idmapped mounts
but that aims to cover all vfs operations independent of them. It aims
for:
- test vfs feature x on regular mounts
- test vfs feature on idmapped mounts
- test vfs feature in user namespaces
- test vfs feature on idmapped mount in user namespaces
I'm in the process of upstreaming it for xfstests (cf. [1]). It also
includes tests for xattrs/acls and fscaps. if ima and evm want to add
something to this that'd be great but if you maintain your own testing
that's of course totally ok.
[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/xfstests-dev.git/log/?h=idmapped_mounts

Thanks!
Christian
