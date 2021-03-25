Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E98348E64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCYKx4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 06:53:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2740 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhCYKxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:53:45 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F5hZF5Ghnz683Jf;
        Thu, 25 Mar 2021 18:44:53 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 25 Mar 2021 11:53:43 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2106.013;
 Thu, 25 Mar 2021 11:53:43 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "mjg59@google.com" <mjg59@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "agruenba@redhat.com" <agruenba@redhat.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Topic: [PATCH v4 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
Thread-Index: AQHXEdMs3dcvjnFQvUyUTwTeWmdH4qqTStlA
Date:   Thu, 25 Mar 2021 10:53:43 +0000
Message-ID: <ad33c998ee834a588e0ca1a31ee2a530@huawei.com>
References: <20210305151923.29039-1-roberto.sassu@huawei.com>
 <20210305151923.29039-9-roberto.sassu@huawei.com>
In-Reply-To: <20210305151923.29039-9-roberto.sassu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.4.143]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> From: Roberto Sassu
> Sent: Friday, March 5, 2021 4:19 PM
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
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 96
> +++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c
> b/security/integrity/evm/evm_main.c
> index eab536fa260f..a07516dcb920 100644
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
> @@ -328,6 +329,79 @@ static enum integrity_status
> evm_verify_current_integrity(struct dentry *dentry)
>  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
>  }
> 
> +/*
> + * evm_xattr_acl_change - check if passed ACL changes the inode mode
> + * @dentry: pointer to the affected dentry
> + * @xattr_name: requested xattr
> + * @xattr_value: requested xattr value
> + * @xattr_value_len: requested xattr value length
> + *
> + * Check if passed ACL changes the inode mode, which is protected by
> EVM.
> + *
> + * Returns 1 if passed ACL causes inode mode change, 0 otherwise.
> + */
> +static int evm_xattr_acl_change(struct dentry *dentry, const char
> *xattr_name,
> +				const void *xattr_value, size_t
> xattr_value_len)
> +{
> +	umode_t mode;
> +	struct posix_acl *acl = NULL, *acl_res;
> +	struct inode *inode = d_backing_inode(dentry);
> +	int rc;
> +
> +	/* UID/GID in ACL have been already converted from user to init ns
> */
> +	acl = posix_acl_from_xattr(&init_user_ns, xattr_value,
> xattr_value_len);
> +	if (!acl)

Based on Mimi's review, I will change this to:

if (IS_ERR_OR_NULL(acl))

> +		return 1;
> +
> +	acl_res = acl;
> +	rc = posix_acl_update_mode(&init_user_ns, inode, &mode,
> &acl_res);

About this part, probably it is not correct.

I'm writing a test for this patch that checks if operations
that don't change the file mode succeed and those that
do fail.

mount-idmapped --map-mount b:3001:0:1 /mnt /mnt-idmapped
pushd /mnt
echo "test" > test-file
chown 3001 test-file
chgrp 3001 test-file
chmod 2644 test-file
<check enabled>
setfacl --set u::rw,g::r,o::r,m:r test-file (expected to succeed, caller has CAP_FSETID, so S_ISGID is not dropped)
setfacl --set u::rw,g::r,o::r,m:rw test-file (expected to fail)
pushd /mnt-idmapped
capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file (expected to succeed, caller is in the owning group of test-file, so S_ISGID is not dropped)

After adding a debug line in posix_acl_update_mode():
printk("%s: %d(%d) %d\n", __func__, in_group_p(i_gid_into_mnt(mnt_userns, inode)), __kgid_val(i_gid_into_mnt(mnt_userns, inode)), capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID));

without passing mnt_userns:
[  748.262582] setfacl --set u::rw,g::r,o::r,m:r test-file
[  748.268021] posix_acl_update_mode: 0(3001) 1
[  748.268035] posix_acl_update_mode: 0(3001) 1
[  748.268570] setfacl --set u::rw,g::r,o::r,m:rw test-file
[  748.274193] posix_acl_update_mode: 0(3001) 1
[  748.279198] capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file
[  748.287894] posix_acl_update_mode: 0(3001) 0

passing mnt_userns:
[   81.159766] setfacl --set u::rw,g::r,o::r,m:r test-file
[   81.165207] posix_acl_update_mode: 0(3001) 1
[   81.165226] posix_acl_update_mode: 0(3001) 1
[   81.165732] setfacl --set u::rw,g::r,o::r,m:rw test-file
[   81.170978] posix_acl_update_mode: 0(3001) 1
[   81.176014] capsh --drop=cap_fsetid -- -c setfacl --set u::rw,g::r,o::r test-file
[   81.184648] posix_acl_update_mode: 1(0) 0
[   81.184663] posix_acl_update_mode: 1(0) 0

The difference is that, by passing mnt_userns, the caller (root) is
in the owning group of the file (3001 -> 0). Without passing mnt_userns,
it is not (3001 -> 3001).

Christian, Andreas, could you confirm that this is correct?

If there are no objections, I will send an additional patch to pass
mnt_userns to EVM.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

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
> + * evm_xattr_change - check if passed xattr value differs from current
> value
> + * @dentry: pointer to the affected dentry
> + * @xattr_name: requested xattr
> + * @xattr_value: requested xattr value
> + * @xattr_value_len: requested xattr value length
> + *
> + * Check if passed xattr value differs from current value.
> + *
> + * Returns 1 if passed xattr value differs from current value, 0 otherwise.
> + */
> +static int evm_xattr_change(struct dentry *dentry, const char
> *xattr_name,
> +			    const void *xattr_value, size_t xattr_value_len)
> +{
> +	char *xattr_data = NULL;
> +	int rc = 0;
> +
> +	if (posix_xattr_acl(xattr_name))
> +		return evm_xattr_acl_change(dentry, xattr_name,
> xattr_value,
> +					    xattr_value_len);
> +
> +	rc = vfs_getxattr_alloc(&init_user_ns, dentry, xattr_name,
> &xattr_data,
> +				0, GFP_NOFS);
> +	if (rc < 0)
> +		return 1;
> +
> +	if (rc == xattr_value_len)
> +		rc = memcmp(xattr_value, xattr_data, rc);
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
> @@ -388,6 +462,10 @@ static int evm_protect_xattr(struct dentry *dentry,
> const char *xattr_name,
>  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
>  		return 0;
> 
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_xattr_change(dentry, xattr_name, xattr_value,
> xattr_value_len))
> +		return 0;
> +
>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
>  				    dentry->d_name.name,
> "appraise_metadata",
> @@ -527,6 +605,19 @@ void evm_inode_post_removexattr(struct dentry
> *dentry, const char *xattr_name)
>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>  }
> 
> +static int evm_attr_change(struct dentry *dentry, struct iattr *attr)
> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	unsigned int ia_valid = attr->ia_valid;
> +
> +	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid))
> &&
> +	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
> +	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /**
>   * evm_inode_setattr - prevent updating an invalid EVM extended
> attribute
>   * @dentry: pointer to the affected dentry
> @@ -557,6 +648,11 @@ int evm_inode_setattr(struct dentry *dentry, struct
> iattr *attr)
>  	    (evm_status == INTEGRITY_FAIL_IMMUTABLE) ||
>  	    (evm_ignore_error_safe(evm_status)))
>  		return 0;
> +
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_attr_change(dentry, attr))
> +		return 0;
> +
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA,
> d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",
>  			    integrity_status_msg[evm_status], -EPERM, 0);
> --
> 2.26.2

