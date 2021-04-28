Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8C36DBC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 17:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239842AbhD1PgT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 11:36:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2944 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhD1PgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:16 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVjHL5d7mz6wkLW;
        Wed, 28 Apr 2021 23:29:50 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 17:35:28 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 28 Apr 2021 17:35:28 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: RE: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Topic: [PATCH v4 04/11] ima: Move ima_reset_appraise_flags() call to
 post hooks
Thread-Index: AQHXEdMA2oN9D131skWV9JJ8Z5VEUarKXeAg
Date:   Wed, 28 Apr 2021 15:35:28 +0000
Message-ID: <8e62ae3f8cf94c798fc1b7ffd69cbdc4@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-5-roberto.sassu@huawei.com>
In-Reply-To: <20210305151923.29039-5-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Roberto Sassu
> Sent: Friday, March 5, 2021 4:19 PM
> ima_inode_setxattr() and ima_inode_removexattr() hooks are called before
> an
> operation is performed. Thus, ima_reset_appraise_flags() should not be
> called there, as flags might be unnecessarily reset if the operation is
> denied.
> 
> This patch introduces the post hooks ima_inode_post_setxattr() and
> ima_inode_post_removexattr(), and adds the call to
> ima_reset_appraise_flags() in the new functions.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/xattr.c                            |  2 ++
>  include/linux/ima.h                   | 18 ++++++++++++++++++
>  security/integrity/ima/ima_appraise.c | 25 ++++++++++++++++++++++---
>  security/security.c                   |  1 +
>  4 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index b3444e06cded..81847f132d26 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -16,6 +16,7 @@
>  #include <linux/namei.h>
>  #include <linux/security.h>
>  #include <linux/evm.h>
> +#include <linux/ima.h>
>  #include <linux/syscalls.h>
>  #include <linux/export.h>
>  #include <linux/fsnotify.h>
> @@ -502,6 +503,7 @@ __vfs_removexattr_locked(struct user_namespace
> *mnt_userns,
> 
>  	if (!error) {
>  		fsnotify_xattr(dentry);
> +		ima_inode_post_removexattr(dentry, name);
>  		evm_inode_post_removexattr(dentry, name);
>  	}
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 61d5723ec303..5e059da43857 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -171,7 +171,13 @@ extern void ima_inode_post_setattr(struct
> user_namespace *mnt_userns,
>  				   struct dentry *dentry);
>  extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len);
> +extern void ima_inode_post_setxattr(struct dentry *dentry,
> +				    const char *xattr_name,
> +				    const void *xattr_value,
> +				    size_t xattr_value_len);
>  extern int ima_inode_removexattr(struct dentry *dentry, const char
> *xattr_name);
> +extern void ima_inode_post_removexattr(struct dentry *dentry,
> +				       const char *xattr_name);
>  #else
>  static inline bool is_ima_appraise_enabled(void)
>  {
> @@ -192,11 +198,23 @@ static inline int ima_inode_setxattr(struct dentry
> *dentry,
>  	return 0;
>  }
> 
> +static inline void ima_inode_post_setxattr(struct dentry *dentry,
> +					   const char *xattr_name,
> +					   const void *xattr_value,
> +					   size_t xattr_value_len)
> +{
> +}
> +
>  static inline int ima_inode_removexattr(struct dentry *dentry,
>  					const char *xattr_name)
>  {
>  	return 0;
>  }
> +
> +static inline void ima_inode_post_removexattr(struct dentry *dentry,
> +					      const char *xattr_name)
> +{
> +}
>  #endif /* CONFIG_IMA_APPRAISE */
> 
>  #if defined(CONFIG_IMA_APPRAISE) &&
> defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/integrity/ima/ima_appraise.c
> b/security/integrity/ima/ima_appraise.c
> index 565e33ff19d0..1f029e4c8d7f 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -577,21 +577,40 @@ int ima_inode_setxattr(struct dentry *dentry, const
> char *xattr_name,
>  	if (result == 1) {
>  		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
>  			return -EINVAL;
> -		ima_reset_appraise_flags(d_backing_inode(dentry),
> -			xvalue->type == EVM_IMA_XATTR_DIGSIG);
>  		result = 0;
>  	}
>  	return result;
>  }
> 
> +void ima_inode_post_setxattr(struct dentry *dentry, const char
> *xattr_name,
> +			     const void *xattr_value, size_t xattr_value_len)
> +{
> +	const struct evm_ima_xattr_data *xvalue = xattr_value;
> +	int result;
> +
> +	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
> +				   xattr_value_len);
> +	if (result == 1)
> +		ima_reset_appraise_flags(d_backing_inode(dentry),

I found an issue in this patch.

Moving ima_reset_appraise_flags() to the post hook causes this
function to be executed also when __vfs_setxattr_noperm() is
called.

The problem is that at the end of a write IMA calls
ima_collect_measurement() to recalculate the file digest and
update security.ima. ima_collect_measurement() sets
IMA_COLLECTED.

However, after that __vfs_setxattr_noperm() causes
IMA_COLLECTED to be reset, and to unnecessarily recalculate
the file digest. This wouldn't happen if ima_reset_appraise_flags()
is in the pre hook.

I solved by replacing:
	iint->flags &= ~IMA_DONE_MASK;
with:
	iint->flags &= ~(IMA_DONE_MASK & ~IMA_COLLECTED);

just when the IMA_CHANGE_XATTR bit is set. It should
not be a problem since setting an xattr does not influence
the file content.

Mimi, what do you think?

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> +			xvalue->type == EVM_IMA_XATTR_DIGSIG);
> +}
> +
>  int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name)
>  {
>  	int result;
> 
>  	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
>  	if (result == 1) {
> -		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
>  		result = 0;
>  	}
>  	return result;
>  }
> +
> +void ima_inode_post_removexattr(struct dentry *dentry, const char
> *xattr_name)
> +{
> +	int result;
> +
> +	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
> +	if (result == 1)
> +		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> +}
> diff --git a/security/security.c b/security/security.c
> index 5ac96b16f8fa..efb1f874dc41 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1319,6 +1319,7 @@ void security_inode_post_setxattr(struct dentry
> *dentry, const char *name,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return;
>  	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
> +	ima_inode_post_setxattr(dentry, name, value, size);
>  	evm_inode_post_setxattr(dentry, name, value, size);
>  }
> 
> --
> 2.26.2

