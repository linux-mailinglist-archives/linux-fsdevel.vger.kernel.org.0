Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87724356BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhDGMFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 08:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhDGMFp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:05:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C14361139;
        Wed,  7 Apr 2021 12:05:32 +0000 (UTC)
Date:   Wed, 7 Apr 2021 14:05:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     zohar@linux.ibm.com, mjg59@google.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v5 09/12] evm: Allow setxattr() and setattr() for
 unmodified metadata
Message-ID: <20210407120530.dgcsuyywbaz4fllm@wittgenstein>
References: <20210407105252.30721-1-roberto.sassu@huawei.com>
 <20210407105252.30721-10-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210407105252.30721-10-roberto.sassu@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 12:52:49PM +0200, Roberto Sassu wrote:
> With the patch to allow xattr/attr operations if a portable signature
> verification fails, cp and tar can copy all xattrs/attrs so that at the
> end of the process verification succeeds.
> 
> However, it might happen that the xattrs/attrs are already set to the
> correct value (taken at signing time) and signature verification succeeds
> before the copy has completed. For example, an archive might contains files
> owned by root and the archive is extracted by root.
> 
> Then, since portable signatures are immutable, all subsequent operations
> fail (e.g. fchown()), even if the operation is legitimate (does not alter
> the current value).
> 
> This patch avoids this problem by reporting successful operation to user
> space when that operation does not alter the current value of xattrs/attrs.
> 
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 107 ++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 74f9f3a2ae53..2a8fcba67d47 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -18,6 +18,7 @@
>  #include <linux/integrity.h>
>  #include <linux/evm.h>
>  #include <linux/magic.h>
> +#include <linux/posix_acl_xattr.h>
>  
>  #include <crypto/hash.h>
>  #include <crypto/hash_info.h>
> @@ -328,6 +329,89 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
>  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
>  }
>  
> +/*
> + * evm_xattr_acl_change - check if passed ACL changes the inode mode
> + * @mnt_userns: user namespace of the idmapped mount
> + * @dentry: pointer to the affected dentry
> + * @xattr_name: requested xattr
> + * @xattr_value: requested xattr value
> + * @xattr_value_len: requested xattr value length
> + *
> + * Check if passed ACL changes the inode mode, which is protected by EVM.
> + *
> + * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
> + */
> +static int evm_xattr_acl_change(struct user_namespace *mnt_userns,
> +				struct dentry *dentry, const char *xattr_name,
> +				const void *xattr_value, size_t xattr_value_len)
> +{
> +	umode_t mode;
> +	struct posix_acl *acl = NULL, *acl_res;
> +	struct inode *inode = d_backing_inode(dentry);
> +	int rc;
> +
> +	/* user_ns is not relevant here, ACL_USER/ACL_GROUP don't have impact
> +	 * on the inode mode (see posix_acl_equiv_mode()).
> +	 */
> +	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
> +	if (IS_ERR_OR_NULL(acl))
> +		return 1;
> +
> +	acl_res = acl;
> +	/* Passing mnt_userns is necessary to correctly determine the GID in
> +	 * an idmapped mount, as the GID is used to clear the setgid bit in
> +	 * the inode mode.
> +	 */
> +	rc = posix_acl_update_mode(mnt_userns, inode, &mode, &acl_res);
> +
> +	posix_acl_release(acl);
> +
> +	if (rc)
> +		return 1;
> +
> +	if (inode->i_mode != mode)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * evm_xattr_change - check if passed xattr value differs from current value
> + * @mnt_userns: user namespace of the idmapped mount
> + * @dentry: pointer to the affected dentry
> + * @xattr_name: requested xattr
> + * @xattr_value: requested xattr value
> + * @xattr_value_len: requested xattr value length
> + *
> + * Check if passed xattr value differs from current value.
> + *
> + * Returns 1 if passed xattr value differs from current value, 0 otherwise.
> + */
> +static int evm_xattr_change(struct user_namespace *mnt_userns,
> +			    struct dentry *dentry, const char *xattr_name,
> +			    const void *xattr_value, size_t xattr_value_len)
> +{
> +	char *xattr_data = NULL;
> +	int rc = 0;
> +
> +	if (posix_xattr_acl(xattr_name))
> +		return evm_xattr_acl_change(mnt_userns, dentry, xattr_name,
> +					    xattr_value, xattr_value_len);
> +
> +	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
> +				0, GFP_NOFS);
> +	if (rc < 0)
> +		return 1;
> +
> +	if (rc == xattr_value_len)
> +		rc = memcmp(xattr_value, xattr_data, rc);

Afaik memcmp() can return values greater than 1 and less than 0 so it
might make sense to explicitly do sm like:
rc = memcmp() ? 1 : 0;
or
!!memcmp()
or alter the comment for evm_xattr_change().

other than that

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

> +	else
> +		rc = 1;
> +
> +	kfree(xattr_data);
> +	return rc;
> +}
> +
>  /*
>   * evm_protect_xattr - protect the EVM extended attribute
>   *
> @@ -389,6 +473,11 @@ static int evm_protect_xattr(struct user_namespace *mnt_userns,
>  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
>  		return 0;
>  
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_xattr_change(mnt_userns, dentry, xattr_name, xattr_value,
> +			      xattr_value_len))
> +		return 0;
> +
>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",
> @@ -532,6 +621,19 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>  }
>  
> +static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	unsigned int ia_valid = attr->ia_valid;
> +
> +	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
> +	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
> +	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /**
>   * evm_inode_setattr - prevent updating an invalid EVM extended attribute
>   * @dentry: pointer to the affected dentry
> @@ -562,6 +664,11 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  	    (evm_status == INTEGRITY_FAIL_IMMUTABLE) ||
>  	    (evm_ignore_error_safe(evm_status)))
>  		return 0;
> +
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_attr_change(dentry, attr))
> +		return 0;
> +
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",
>  			    integrity_status_msg[evm_status], -EPERM, 0);
> -- 
> 2.26.2
> 
