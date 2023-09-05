Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B2793070
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 22:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbjIEUzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIEUzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:55:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6209F;
        Tue,  5 Sep 2023 13:55:31 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385KfmXR029165;
        Tue, 5 Sep 2023 20:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=R+Ffl09yHsjZ9PlTeBL69nT9f0z0ciPKxBWX5DNc8/4=;
 b=Lz3iINHuLb9PNbEYaLeA27A3USKv+aP+eD+3Sw1OAM4SjrvRw2dTQ9SQ5B1IfXs6rtsW
 KnP8c0NOolcVJhPBK1KNljl2xPg3+locmj1JIXk1XH+JZPChY/KtIlp/BMnQ3O5VcYeC
 xQZQr47LcboC/uccrWMQ89VE14i2On33mOdJzJtAzxayhOaURsuidrypUQ1Vh7cAEyvm
 KCiLqruR4EvdXnZNpRPalIpM8omUrdrhUgO0JM+N526SgKGVsquIBjbQMV3ommfKVfB1
 lJEH7zAdBw2gTqEfzi8xDU/r/j7UPYRCZMjRbWdn0YwBPHxHAOWfujQVmgOXK5evGFZt ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxbkd8b27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 20:55:00 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 385Kgjlo000876;
        Tue, 5 Sep 2023 20:54:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxbkd8b1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 20:54:59 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 385JpKm5001667;
        Tue, 5 Sep 2023 20:54:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsp84f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 20:54:58 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385KswJK37618128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 20:54:58 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2411258061;
        Tue,  5 Sep 2023 20:54:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B465803F;
        Tue,  5 Sep 2023 20:54:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Sep 2023 20:54:56 +0000 (GMT)
Message-ID: <4194efc4-6b85-5e73-1028-ffef942bdb4a@linux.ibm.com>
Date:   Tue, 5 Sep 2023 16:54:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 22/25] ima: Move IMA-Appraisal to LSM infrastructure
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
 <20230904134049.1802006-3-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230904134049.1802006-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1UVJOnMh8Kbx7B-aEUCFqVPDCY8aCnTu
X-Proofpoint-GUID: U_vpxZkvX5EIqQO_yUK22t6Qvoq9FCKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050180
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/4/23 09:40, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Do the registration of IMA-Appraisal functions separately from the rest of
> IMA functions, as appraisal is a separate feature not necessarily enabled
> in the kernel configuration.
>
> Reuse the same approach as for other IMA functions, remove hardcoded calls
> from the LSM infrastructure or the other places, declare the functions as
> static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm() to chain the
> initialization.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   fs/attr.c                             |  2 -
>   include/linux/ima.h                   | 55 ---------------------------
>   security/integrity/ima/ima.h          |  5 +++
>   security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>   security/integrity/ima/ima_main.c     |  1 +
>   security/security.c                   | 13 -------
>   6 files changed, 35 insertions(+), 79 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 3c309eb456c6..63fb60195409 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -17,7 +17,6 @@
>   #include <linux/filelock.h>
>   #include <linux/security.h>
>   #include <linux/evm.h>
> -#include <linux/ima.h>
>   
>   #include "internal.h"
>   
> @@ -487,7 +486,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>   	if (!error) {
>   		fsnotify_change(dentry, ia_valid);
>   		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry, ia_valid);
>   		evm_inode_post_setattr(idmap, dentry, ia_valid);
>   	}
>   
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 58591b5cbdb4..586e2e18e494 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -98,66 +98,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>   
>   #ifdef CONFIG_IMA_APPRAISE
>   extern bool is_ima_appraise_enabled(void);
> -extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry, int ia_valid);
> -int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len, int flags);
> -extern int ima_inode_set_acl(struct mnt_idmap *idmap,
> -			     struct dentry *dentry, const char *acl_name,
> -			     struct posix_acl *kacl);
> -static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
> -}
> -
> -int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			  const char *xattr_name);
>   #else
>   static inline bool is_ima_appraise_enabled(void)
>   {
>   	return 0;
>   }
> -
> -static inline void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -					  struct dentry *dentry, int ia_valid)
> -{
> -	return;
> -}
> -
> -static inline int ima_inode_setxattr(struct mnt_idmap *idmap,
> -				     struct dentry *dentry,
> -				     const char *xattr_name,
> -				     const void *xattr_value,
> -				     size_t xattr_value_len,
> -				     int flags)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_inode_set_acl(struct mnt_idmap *idmap,
> -				    struct dentry *dentry, const char *acl_name,
> -				    struct posix_acl *kacl)
> -{
> -
> -	return 0;
> -}
> -
> -static inline int ima_inode_removexattr(struct mnt_idmap *idmap,
> -					struct dentry *dentry,
> -					const char *xattr_name)
> -{
> -	return 0;
> -}
> -
> -static inline int ima_inode_remove_acl(struct mnt_idmap *idmap,
> -				       struct dentry *dentry,
> -				       const char *acl_name)
> -{
> -	return 0;
> -}
>   #endif /* CONFIG_IMA_APPRAISE */
>   
>   #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c0412100023e..d19aa9c068da 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>   				 int xattr_len);
>   int ima_read_xattr(struct dentry *dentry,
>   		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
> +void __init init_ima_appraise_lsm(void);
>   
>   #else
>   static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> @@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
>   	return 0;
>   }
>   
> +static inline void __init init_ima_appraise_lsm(void)
> +{
> +}
> +
>   #endif /* CONFIG_IMA_APPRAISE */
>   
>   #ifdef CONFIG_IMA_APPRAISE_MODSIG
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index c35e3537eb87..8fe6ea70f02b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -634,8 +634,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>    * This function is called from notify_change(), which expects the caller
>    * to lock the inode's i_mutex.
>    */
> -void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -			    struct dentry *dentry, int ia_valid)
> +static void ima_inode_post_setattr(struct mnt_idmap *idmap,
> +				   struct dentry *dentry, int ia_valid)
>   {
>   	struct inode *inode = d_backing_inode(dentry);
>   	struct integrity_iint_cache *iint;
> @@ -748,9 +748,9 @@ static int validate_hash_algo(struct dentry *dentry,
>   	return -EACCES;
>   }
>   
> -int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len, int flags)
> +static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const char *xattr_name, const void *xattr_value,
> +			      size_t xattr_value_len, int flags)
>   {
>   	const struct evm_ima_xattr_data *xvalue = xattr_value;
>   	int digsig = 0;
> @@ -779,8 +779,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	return result;
>   }
>   
> -int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> -		      const char *acl_name, struct posix_acl *kacl)
> +static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +			     const char *acl_name, struct posix_acl *kacl)
>   {
>   	if (evm_revalidate_status(acl_name))
>   		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> @@ -788,8 +788,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>   	return 0;
>   }
>   
> -int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			  const char *xattr_name)
> +static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 const char *xattr_name)
>   {
>   	int result;
>   
> @@ -801,3 +801,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>   	}
>   	return result;
>   }
> +
> +static int ima_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +				const char *acl_name)
> +{
> +	return ima_inode_set_acl(idmap, dentry, acl_name, NULL);
> +}
> +
> +static struct security_hook_list ima_appraise_hooks[] __ro_after_init = {
> +	LSM_HOOK_INIT(inode_post_setattr, ima_inode_post_setattr),
> +	LSM_HOOK_INIT(inode_setxattr, ima_inode_setxattr),
> +	LSM_HOOK_INIT(inode_set_acl, ima_inode_set_acl),
> +	LSM_HOOK_INIT(inode_removexattr, ima_inode_removexattr),
> +	LSM_HOOK_INIT(inode_remove_acl, ima_inode_remove_acl),
> +};
> +
> +void __init init_ima_appraise_lsm(void)
> +{
> +	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
> +			   "integrity");
> +}
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 0e4f882fcdce..c31e11a5bc31 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1141,6 +1141,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
>   void __init init_ima_lsm(void)
>   {
>   	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), "integrity");
> +	init_ima_appraise_lsm();
>   }
>   
>   late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/security.c b/security/security.c
> index 0b196d3f01b8..eb686f9471ea 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -20,7 +20,6 @@
>   #include <linux/kernel_read_file.h>
>   #include <linux/lsm_hooks.h>
>   #include <linux/integrity.h>
> -#include <linux/ima.h>
>   #include <linux/evm.h>
>   #include <linux/fsnotify.h>
>   #include <linux/mman.h>
> @@ -2217,9 +2216,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>   
>   	if (ret == 1)
>   		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
>   	if (ret)
>   		return ret;
>   	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> @@ -2247,9 +2243,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>   		return 0;
>   	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
>   			    kacl);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
>   	if (ret)
>   		return ret;
>   	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
> @@ -2310,9 +2303,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>   	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>   		return 0;
>   	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
>   	if (ret)
>   		return ret;
>   	return evm_inode_remove_acl(idmap, dentry, acl_name);
> @@ -2412,9 +2402,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>   	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>   	if (ret == 1)
>   		ret = cap_inode_removexattr(idmap, dentry, name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_removexattr(idmap, dentry, name);
>   	if (ret)
>   		return ret;
>   	return evm_inode_removexattr(idmap, dentry, name);


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

