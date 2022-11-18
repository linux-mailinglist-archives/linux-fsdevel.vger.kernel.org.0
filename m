Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3227162EB5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 02:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiKRByV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 20:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRByT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:54:19 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C662047;
        Thu, 17 Nov 2022 17:54:16 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id F16F312CF; Thu, 17 Nov 2022 19:54:14 -0600 (CST)
Date:   Thu, 17 Nov 2022 19:54:14 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] lsm,fs: fix vfs_getxattr_alloc() return type and
 caller error paths
Message-ID: <20221118015414.GA19423@mail.hallyn.com>
References: <20221110043614.802364-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110043614.802364-1-paul@paul-moore.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:36:14PM -0500, Paul Moore wrote:
> The vfs_getxattr_alloc() function currently returns a ssize_t value
> despite the fact that it only uses int values internally for return
> values.  Fix this by converting vfs_getxattr_alloc() to return an
> int type and adjust the callers as necessary.  As part of these
> caller modifications, some of the callers are fixed to properly free
> the xattr value buffer on both success and failure to ensure that
> memory is not leaked in the failure case.
> 
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

Do I understand right that the change to process_measurement()
will avoid an unnecessary call to krealloc() if the xattr has
not changed size between the two calls to ima_read_xattr()?
If something more than that is going on there, it might be
worth pointing out in the commit message.

> ---
>  fs/xattr.c                                |  5 +++--
>  include/linux/xattr.h                     |  6 +++---
>  security/apparmor/domain.c                |  3 +--
>  security/commoncap.c                      | 22 ++++++++++------------
>  security/integrity/evm/evm_crypto.c       |  5 +++--
>  security/integrity/evm/evm_main.c         |  7 +++++--
>  security/integrity/ima/ima.h              |  5 +++--
>  security/integrity/ima/ima_appraise.c     |  6 +++---
>  security/integrity/ima/ima_main.c         |  6 ++++--
>  security/integrity/ima/ima_template_lib.c | 11 +++++------
>  10 files changed, 40 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 61107b6bbed29..f38fd969b5fcd 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -354,11 +354,12 @@ xattr_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
>   * vfs_getxattr_alloc - allocate memory, if necessary, before calling getxattr
>   *
>   * Allocate memory, if not already allocated, or re-allocate correct size,
> - * before retrieving the extended attribute.
> + * before retrieving the extended attribute.  The xattr value buffer should
> + * always be freed by the caller, even on error.
>   *
>   * Returns the result of alloc, if failed, or the getxattr operation.
>   */
> -ssize_t
> +int
>  vfs_getxattr_alloc(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		   const char *name, char **xattr_value, size_t xattr_size,
>  		   gfp_t flags)
> diff --git a/include/linux/xattr.h b/include/linux/xattr.h
> index 4c379d23ec6e7..2218a9645b89d 100644
> --- a/include/linux/xattr.h
> +++ b/include/linux/xattr.h
> @@ -68,9 +68,9 @@ int __vfs_removexattr_locked(struct user_namespace *, struct dentry *,
>  int vfs_removexattr(struct user_namespace *, struct dentry *, const char *);
>  
>  ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
> -ssize_t vfs_getxattr_alloc(struct user_namespace *mnt_userns,
> -			   struct dentry *dentry, const char *name,
> -			   char **xattr_value, size_t size, gfp_t flags);
> +int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
> +		       struct dentry *dentry, const char *name,
> +		       char **xattr_value, size_t size, gfp_t flags);
>  
>  int xattr_supported_namespace(struct inode *inode, const char *prefix);
>  
> diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
> index 91689d34d2811..04a818d516047 100644
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@ -311,10 +311,9 @@ static int aa_xattrs_match(const struct linux_binprm *bprm,
>  			   struct aa_profile *profile, unsigned int state)
>  {
>  	int i;
> -	ssize_t size;
>  	struct dentry *d;
>  	char *value = NULL;
> -	int value_size = 0, ret = profile->xattr_count;
> +	int size, value_size = 0, ret = profile->xattr_count;
>  
>  	if (!bprm || !profile->xattr_count)
>  		return 0;
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 5fc8986c3c77c..d4fc890955134 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -350,14 +350,14 @@ static __u32 sansflags(__u32 m)
>  	return m & ~VFS_CAP_FLAGS_EFFECTIVE;
>  }
>  
> -static bool is_v2header(size_t size, const struct vfs_cap_data *cap)
> +static bool is_v2header(int size, const struct vfs_cap_data *cap)
>  {
>  	if (size != XATTR_CAPS_SZ_2)
>  		return false;
>  	return sansflags(le32_to_cpu(cap->magic_etc)) == VFS_CAP_REVISION_2;
>  }
>  
> -static bool is_v3header(size_t size, const struct vfs_cap_data *cap)
> +static bool is_v3header(int size, const struct vfs_cap_data *cap)
>  {
>  	if (size != XATTR_CAPS_SZ_3)
>  		return false;
> @@ -379,7 +379,7 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>  			  struct inode *inode, const char *name, void **buffer,
>  			  bool alloc)
>  {
> -	int size, ret;
> +	int size;
>  	kuid_t kroot;
>  	u32 nsmagic, magic;
>  	uid_t root, mappedroot;
> @@ -395,20 +395,18 @@ int cap_inode_getsecurity(struct user_namespace *mnt_userns,
>  	dentry = d_find_any_alias(inode);
>  	if (!dentry)
>  		return -EINVAL;
> -
> -	size = sizeof(struct vfs_ns_cap_data);
> -	ret = (int)vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS,
> -				      &tmpbuf, size, GFP_NOFS);
> +	size = vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS, &tmpbuf,
> +				  sizeof(struct vfs_ns_cap_data), GFP_NOFS);
>  	dput(dentry);
> -
> -	if (ret < 0 || !tmpbuf)
> -		return ret;
> +	/* gcc11 complains if we don't check for !tmpbuf */
> +	if (size < 0 || !tmpbuf)
> +		goto out_free;
>  
>  	fs_ns = inode->i_sb->s_user_ns;
>  	cap = (struct vfs_cap_data *) tmpbuf;
> -	if (is_v2header((size_t) ret, cap)) {
> +	if (is_v2header(size, cap)) {
>  		root = 0;
> -	} else if (is_v3header((size_t) ret, cap)) {
> +	} else if (is_v3header(size, cap)) {
>  		nscap = (struct vfs_ns_cap_data *) tmpbuf;
>  		root = le32_to_cpu(nscap->rootid);
>  	} else {
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 708de9656bbd2..fa5ff13fa8c97 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -335,14 +335,15 @@ static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
>  				(char **)&xattr_data, 0, GFP_NOFS);
>  	if (rc <= 0) {
>  		if (rc == -ENODATA)
> -			return 0;
> -		return rc;
> +			rc = 0;
> +		goto out;
>  	}
>  	if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG)
>  		rc = 1;
>  	else
>  		rc = 0;
>  
> +out:
>  	kfree(xattr_data);
>  	return rc;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 23d484e05e6f2..bce72e80fd123 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -519,14 +519,17 @@ static int evm_xattr_change(struct user_namespace *mnt_userns,
>  
>  	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name, &xattr_data,
>  				0, GFP_NOFS);
> -	if (rc < 0)
> -		return 1;
> +	if (rc < 0) {
> +		rc = 1;
> +		goto out;
> +	}
>  
>  	if (rc == xattr_value_len)
>  		rc = !!memcmp(xattr_value, xattr_data, rc);
>  	else
>  		rc = 1;
>  
> +out:
>  	kfree(xattr_data);
>  	return rc;
>  }
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index be965a8715e4e..03b440921e615 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -326,7 +326,7 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
>  int ima_read_xattr(struct dentry *dentry,
> -		   struct evm_ima_xattr_data **xattr_value);
> +		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
>  
>  #else
>  static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> @@ -372,7 +372,8 @@ ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len)
>  }
>  
>  static inline int ima_read_xattr(struct dentry *dentry,
> -				 struct evm_ima_xattr_data **xattr_value)
> +				 struct evm_ima_xattr_data **xattr_value,
> +				 int xattr_len)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 3e0fbbd995342..88ffb15ca0e2e 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -221,12 +221,12 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  }
>  
>  int ima_read_xattr(struct dentry *dentry,
> -		   struct evm_ima_xattr_data **xattr_value)
> +		   struct evm_ima_xattr_data **xattr_value, int xattr_len)
>  {
> -	ssize_t ret;
> +	int ret;
>  
>  	ret = vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_IMA,
> -				 (char **)xattr_value, 0, GFP_NOFS);
> +				 (char **)xattr_value, xattr_len, GFP_NOFS);
>  	if (ret == -EOPNOTSUPP)
>  		ret = 0;
>  	return ret;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 040b03ddc1c77..0226899947d6a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -293,7 +293,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	/* HASH sets the digital signature and update flags, nothing else */
>  	if ((action & IMA_HASH) &&
>  	    !(test_bit(IMA_DIGSIG, &iint->atomic_flags))) {
> -		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
> +		xattr_len = ima_read_xattr(file_dentry(file),
> +					   &xattr_value, xattr_len);
>  		if ((xattr_value && xattr_len > 2) &&
>  		    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
>  			set_bit(IMA_DIGSIG, &iint->atomic_flags);
> @@ -316,7 +317,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	if ((action & IMA_APPRAISE_SUBMASK) ||
>  	    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
>  		/* read 'security.ima' */
> -		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
> +		xattr_len = ima_read_xattr(file_dentry(file),
> +					   &xattr_value, xattr_len);
>  
>  		/*
>  		 * Read the appended modsig if allowed by the policy, and allow
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 7bf9b15072202..4564faae7d673 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -601,16 +601,15 @@ int ima_eventevmsig_init(struct ima_event_data *event_data,
>  	rc = vfs_getxattr_alloc(&init_user_ns, file_dentry(event_data->file),
>  				XATTR_NAME_EVM, (char **)&xattr_data, 0,
>  				GFP_NOFS);
> -	if (rc <= 0)
> -		return 0;
> -
> -	if (xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
> -		kfree(xattr_data);
> -		return 0;
> +	if (rc <= 0 || xattr_data->type != EVM_XATTR_PORTABLE_DIGSIG) {
> +		rc = 0;
> +		goto out;
>  	}
>  
>  	rc = ima_write_template_field_data((char *)xattr_data, rc, DATA_FMT_HEX,
>  					   field_data);
> +
> +out:
>  	kfree(xattr_data);
>  	return rc;
>  }
> -- 
> 2.38.1
