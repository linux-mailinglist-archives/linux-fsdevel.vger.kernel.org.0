Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685AE1C75E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgEFQLT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 6 May 2020 12:11:19 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730208AbgEFQLO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 12:11:14 -0400
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 08BA7A6B66337BCE45B5;
        Wed,  6 May 2020 17:11:12 +0100 (IST)
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.487.0; Wed, 6 May 2020 17:11:11 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 6 May 2020 18:11:10 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Wed, 6 May 2020 18:11:10 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "david.safford@gmail.com" <david.safford@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jmorris@namei.org" <jmorris@namei.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Topic: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure
Thread-Index: AQHWHfmwvisCdHYC6kmVk7fgFWuzYaibRKAQ
Date:   Wed, 6 May 2020 16:11:10 +0000
Message-ID: <96ef56e0bcb64b83a0180b09b87a67e6@huawei.com>
References: <20200429073935.11913-1-roberto.sassu@huawei.com>
In-Reply-To: <20200429073935.11913-1-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.71.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Roberto Sassu
> Sent: Wednesday, April 29, 2020 9:40 AM
> To: zohar@linux.ibm.com; david.safford@gmail.com;
> viro@zeniv.linux.org.uk; jmorris@namei.org
> Cc: linux-fsdevel@vger.kernel.org; linux-integrity@vger.kernel.org; linux-
> security-module@vger.kernel.org; linux-kernel@vger.kernel.org; Silviu
> Vlasceanu <Silviu.Vlasceanu@huawei.com>; Roberto Sassu
> <roberto.sassu@huawei.com>
> Subject: [RFC][PATCH 1/3] evm: Move hooks outside LSM infrastructure

Any thought on this? The implementation can be discussed later.

I just wanted a feedback on the approach, if this is the right direction
to solve the problem.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli


> EVM is a module for the protection of the integrity of file metadata. It
> protects security-relevant extended attributes, and some file attributes
> such as the UID and the GID. It protects their integrity with an HMAC or
> with a signature.
> 
> What makes EVM different from other LSMs is that it makes a security
> decision depending on multiple pieces of information, which cannot be
> managed atomically by the system.
> 
> Example: cp -a file.orig file.dest
> 
> If security.selinux, security.ima and security.evm must be preserved, cp
> will invoke setxattr() for each xattr, and EVM performs a verification
> during each operation. The problem is that copying security.evm from
> file.orig to file.dest will likely break the following EVM verifications if
> some metadata still have to be copied. EVM has no visibility on the
> metadata of the source file, so it cannot determine when the copy can be
> considered complete.
> 
> On the other hand, EVM has to check metadata during every operation to
> ensure that there is no transition from corrupted metadata, e.g. after an
> offline attack, to valid ones after the operation. An HMAC update would
> prevent the corruption to be detected, as the HMAC on the new values
> would
> be correct. Thus, to avoid this issue, EVM has to return an error to the
> system call so that its execution will be interrupted.
> 
> A solution that would satisfy both requirements, not breaking user space
> applications and detecting corrupted metadata is to let metadata operations
> be completed successfully and to pass the result of the EVM verification
> from the pre hooks to the post hooks. In this way, the HMAC update can be
> avoided if the verification wasn't successful.
> 
> This approach will bring another important benefit: it is no longer
> required that every file has a valid HMAC or signature. Instead of always
> enforcing metadata integrity, even when it is not relevant for IMA, EVM
> will let IMA decide for files selected with the appraisal policy,
> depending on the result of the requested verification.
> 
> The main problem is that the result of the verification currently cannot be
> passed from the pre hooks to the post hooks, due to how the LSM API is
> defined. A possible solution would be to use integrity_iint_cache for this
> purpose, but it will increase the memory pressure, as new structures will
> be allocated also for metadata operations, not only for measurement,
> appraisal and audit. Another solution would be to extend the LSM API, but
> it seems not worthwhile as EVM would be the only module getting a benefit
> from this change.
> 
> Given that pre and post hooks are called from the same system call, a more
> efficient solution seems to move the hooks outside the LSM infrastructure,
> so that the return value of the pre hooks can be passed to the post hooks.
> A predefined error (-EAGAIN) will be used to signal to the system call to
> continue the execution. Otherwise, if the pre hooks return -EPERM, the
> system calls will behave as before and will immediately return before
> metadata are changed.
> 
> Overview of the changes:
> 
> evm_inode_init_security()	LSM (no change)
> evm_inode_setxattr()		LSM -> vfs_setxattr()
> evm_inode_post_setxattr()	LSM -> vfs_setxattr()
> evm_inode_removexattr()		LSM -> vfs_removexattr()
> evm_inode_post_removexattr()	vfs_removexattr() (no change)
> evm_inode_setattr()		LSM -> vfs_setattr()
> evm_inode_post_setattr()	vfs_setattr() (no change)
> evm_verifyxattr()		outside LSM (no change)
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/attr.c           |  5 ++++-
>  fs/xattr.c          | 17 +++++++++++++++--
>  security/security.c | 18 +++---------------
>  3 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index b4bbdbd4c8ca..8f26d7d2e3b4 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -224,7 +224,7 @@ int notify_change(struct dentry * dentry, struct iattr
> * attr, struct inode **de
>  {
>  	struct inode *inode = dentry->d_inode;
>  	umode_t mode = inode->i_mode;
> -	int error;
> +	int error, evm_error;
>  	struct timespec64 now;
>  	unsigned int ia_valid = attr->ia_valid;
> 
> @@ -328,6 +328,9 @@ int notify_change(struct dentry * dentry, struct iattr
> * attr, struct inode **de
>  	error = security_inode_setattr(dentry, attr);
>  	if (error)
>  		return error;
> +	evm_error = evm_inode_setattr(dentry, attr);
> +	if (evm_error)
> +		return evm_error;
>  	error = try_break_deleg(inode, delegated_inode);
>  	if (error)
>  		return error;
> diff --git a/fs/xattr.c b/fs/xattr.c
> index e13265e65871..3b323b75b741 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -183,6 +183,7 @@ int __vfs_setxattr_noperm(struct dentry *dentry,
> const char *name,
>  			fsnotify_xattr(dentry);
>  			security_inode_post_setxattr(dentry, name, value,
>  						     size, flags);
> +			evm_inode_post_setxattr(dentry, name, value,
> size);
>  		}
>  	} else {
>  		if (unlikely(is_bad_inode(inode)))
> @@ -210,7 +211,7 @@ vfs_setxattr(struct dentry *dentry, const char
> *name, const void *value,
>  		size_t size, int flags)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	int error;
> +	int error, evm_error;
> 
>  	error = xattr_permission(inode, name, MAY_WRITE);
>  	if (error)
> @@ -221,6 +222,12 @@ vfs_setxattr(struct dentry *dentry, const char
> *name, const void *value,
>  	if (error)
>  		goto out;
> 
> +	evm_error = evm_inode_setxattr(dentry, name, value, size);
> +	if (evm_error) {
> +		error = evm_error;
> +		goto out;
> +	}
> +
>  	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
> 
>  out:
> @@ -382,7 +389,7 @@ int
>  vfs_removexattr(struct dentry *dentry, const char *name)
>  {
>  	struct inode *inode = dentry->d_inode;
> -	int error;
> +	int error, evm_error;
> 
>  	error = xattr_permission(inode, name, MAY_WRITE);
>  	if (error)
> @@ -393,6 +400,12 @@ vfs_removexattr(struct dentry *dentry, const char
> *name)
>  	if (error)
>  		goto out;
> 
> +	evm_error = evm_inode_removexattr(dentry, name);
> +	if (evm_error) {
> +		error = evm_error;
> +		goto out;
> +	}
> +
>  	error = __vfs_removexattr(dentry, name);
> 
>  	if (!error) {
> diff --git a/security/security.c b/security/security.c
> index 7fed24b9d57e..e1368ab34cee 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1255,14 +1255,9 @@ int security_inode_permission(struct inode
> *inode, int mask)
> 
>  int security_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  {
> -	int ret;
> -
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
> -	ret = call_int_hook(inode_setattr, 0, dentry, attr);
> -	if (ret)
> -		return ret;
> -	return evm_inode_setattr(dentry, attr);
> +	return call_int_hook(inode_setattr, 0, dentry, attr);
>  }
>  EXPORT_SYMBOL_GPL(security_inode_setattr);
> 
> @@ -1291,10 +1286,7 @@ int security_inode_setxattr(struct dentry *dentry,
> const char *name,
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
> -	ret = ima_inode_setxattr(dentry, name, value, size);
> -	if (ret)
> -		return ret;
> -	return evm_inode_setxattr(dentry, name, value, size);
> +	return ima_inode_setxattr(dentry, name, value, size);
>  }
> 
>  void security_inode_post_setxattr(struct dentry *dentry, const char
> *name,
> @@ -1303,7 +1295,6 @@ void security_inode_post_setxattr(struct dentry
> *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size,
> flags);
> -	evm_inode_post_setxattr(dentry, name, value, size);
>  }
> 
>  int security_inode_getxattr(struct dentry *dentry, const char *name)
> @@ -1335,10 +1326,7 @@ int security_inode_removexattr(struct dentry
> *dentry, const char *name)
>  		ret = cap_inode_removexattr(dentry, name);
>  	if (ret)
>  		return ret;
> -	ret = ima_inode_removexattr(dentry, name);
> -	if (ret)
> -		return ret;
> -	return evm_inode_removexattr(dentry, name);
> +	return ima_inode_removexattr(dentry, name);
>  }
> 
>  int security_inode_need_killpriv(struct dentry *dentry)
> --
> 2.17.1

