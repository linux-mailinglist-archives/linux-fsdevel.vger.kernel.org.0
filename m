Return-Path: <linux-fsdevel+bounces-8090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D786D82F4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3031C23A79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE21D526;
	Tue, 16 Jan 2024 19:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gfJ1J0me"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF071CFBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431822; cv=none; b=fXd/felDjaTO7wZ0KmKYwdA1uKToUDLg7BoQngMpgsKiMabvQ0agJLy+VvzSl9IN6JUyBL8I3VQ2YyYY+pM1r885CeLzjIyPK92xpM9J4moRbm7dNF/oW3gTC42NGxUlSvO8nO4J62G6zBjJ9WJ5LQv5AQTizgAdxSNLoe5se1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431822; c=relaxed/simple;
	bh=LP3JFUleL5tgrEt+FYX6R+NjZb6uZ96M1GAySEcCltA=;
	h=DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Mailer; b=TVYPgS13Y/wFP7s+S7076uJDinCpgrv3PDuYW9ugJocLJw9Xk1knjEIEMSTKRqMkm8PVYRrSinLknZcVXuvu5F9LqMNQP6Q1P/M7xogr27P/0WSctzLPOOJ812DuFbuaObXAqoClfS22orqIL4ZVup+RD6hDdGU9L1GJhfho1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gfJ1J0me; arc=none smtp.client-ip=66.163.190.153
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705431820; bh=bmM3zqWDq47hwxFfMaTYAE8RyedabxO1GzYz/ZL707w=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gfJ1J0me/hyQMHATFli5OPXC0ZOqpRJ8pZW/DKYbGDiRyK5HuXWepb+AOkAHmFwapbreYp1DrB2x/hNkmwXN+xPFOLwwgkUYe8/1IqQC11EX6jR4rZV5AGvkZIxWXVXBjfRq2oIMygue21zzQTuNjF5Jso51GowPxTiTqcZicNJfKso2mEkxLvJy6QUt44SoMwzLqVjyEVI+NVyL0MKteqO8zO5A2X8JsHt4TYSYZHCm6o5o4Tl0QJLXhhD0/8H2+Dnz62k82lQzy9h8R3XCzZO8UBhaqjOu9Z7dJhadCh2zGgYgtFkBoWFX/IeGRa2IEO0BrT9ev+uvBC2GMHZDPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705431820; bh=yVpQHVA656PKzID8E+1S2n14b2EDzsNVO4IaOWQQoyk=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UbJfFRhGnqgR8kqeokxWE2c3aJ0Bw+0p9zZaihqxTrPZ/tRPIlhIlNFFfJy80rmcDlNzF9kGjnwTVaPTf4Eohx4iba1C6+N5aQjY2z1jFIyKrg08/ECzIefDEJfQ43ckAH35jQ+8mGPYf+s4qvl6vRuiyA3p/7P2C/o8/oehsaC30mVucE/47/Efo+oEyB6cbT2tlCHUdp4GdTcBv21PGltW3KRyBDSa2DRImge3Y8yEcHpcese5mzdCLlvI6hqXCmOJRTquBHVJkWcSVQGrEuujeAqzkQ7mnJKZd7uV1+gFcnWR8lOJAJFpErZcvVctTsJQeHm66zFc34L5nNsYzQ==
X-YMail-OSG: HzhZVqMVM1k0wdhgORxZEIa0BEoxW7ThWD3oZB3wtO4Lu5jtoGTZjWih_bmlbfY
 hgH745BXuLQIMRDRUty4hPvnD7LWJRPMNumDXmwXdiVLWqqPr4Up4xp1WX8p7PEmTISUk5Co37FO
 2snZxspE.QbmEaCFQxP8cKz9.G2AXzmYV4GvA4dEsTBTF0oyZJkhHJFPHZJPWIrdCPRNSSsfbEOt
 ze2P1dCCbkDwJg.Fgm.qhrwkwuh3GbD5DYnyVuknQB23XvqbDrQLpA9dneErIrnXlKlG5_3XSgB6
 kuOVyxVzluO3Ia4enOIu3V0PK4U_Aam7jV4oFeWaEFLn6xLEe90SV4EHyQbq1eVc42MbXd0oOK33
 OdPyJY07rEjVVF2G5E8AccGZYjyzWbo42Cy10DYwdx6TvQuQ4APFoDJtPx1AYSuB_nAaaaodEzcn
 W0TT9lrbuoZ7OcNuiDDVeZ98rsy0Eze9gi54nC8Hycy2QsBs1OOBcO2TYPGKuUq7wMwT8eHEi0..
 9P7DZJuZ5AjLPIt4MK9Dj0Xz_sORmKHm1Bo2i5Rmrxwav26BAHLUFDb.atk4fZagD8havmS9ks92
 IiuantOofFSSVLfLtdZ5op5wbTpN1cdldLwAE6tyVneK.Yvvfdq1vNvYeLG7C77iMy0Xnl6RApGj
 pEsBHoSkGtSb12WdCFP6xv84SwEyNnIJgrpKyppICQ_iL.pof.gJcQ5ZuxVGm7dfbmRkOBX5Xw2g
 dnK6fwr6QdRdsjh1J8uv6gOXXVRoMIrXxEc6A3N_hhpb3qQV2NsLKRyopS3C_YK5TNkJG8b1gBcN
 58h_sQj.8FRuqeF2tK1VgVgEloVfpe5bqAW.NknZDhJOkLEESpuEG2QI4KJvNz4R8gIXooExI.o5
 pUKeAMR6Ox_VuAe6iZNHIAuDxxXYwB0ipY22Rdr35JxX61A6TY6rBjTFPnZdyAViW_WthJPML8Aq
 gTtG6dLe1gXrw2GSaupJbWsa4e6Dy.tEabnyUimkHx8ZUQFurG4jpo_QTgNZZ.OPviill5ynTjVI
 fZl9zeSPUHgO2aI6EcJKHd.I9b16.xxrfM5bjwaKZdi46Brk62AT2GPjjrvUiZSXQZLn2fpSD4xQ
 mIx9aCp0JMxPUx3qVnZ9sfyIrxzApTN.QZ714LxeHyhV66ddIqBwxVQzlSgeh7DTGbztwcsn.3T5
 bmlpmRhOEQ0aDE4Z_nZVGJHIDF6sA2qryWFS1qsHOa2ICl452N4Pz0.0xv0hm4Lw1fyl0n8QkUY3
 p_fS5wDQFc2nlJ2lRAM5weKsFILIQpXo_SBxd2dyzZRplHAsczFmeaPHIECLPbWl1YQNz.FoXamN
 H4cyWjvZCWRvGISiht6Q2xMpj2Y8CbcT9ghIN_nQzQXVQwAt9uegefwiufaspjh.5BsvdOUmq.7j
 x79QCptFtlC7T17vMorxbckW476FvRk0.LiBMCdqHVfU.KE4nB8V.KYcauFswTWPiuhUmn9h4WcX
 Hx9T3u6eSiA7HfaxZbQgMJJi4pJiTQYI4P6v.y5ESO3kZG_POJiTbVZTGHZ1wsPeOO0j9cK6lvuF
 9rcLfdJGBtE8VO0JSQSmcWbivCtXZI0eES2n.r2QNqgDB2ZiAOCoYURhxNwP08MWYTDPAoafr0cM
 FNjoS9tHZi.ANpu0_kPagQM9EJbRKvPSzHVFba9.Jf.yfyUjNC0I1Ae_Si1GhbyLPiy2o_q_ko2E
 8zXtRzaRTMjH6bK89OCDXAxWrR0WEQ_fAORU7_IJ1mkk3OpJNgDifmrsWOP_5oQNVQPTPAMSA8uE
 b_vzK8D0W7B4B.arIy3uhe5Xca0YNjMZog56xHEBgOXLwqtP_YeaCGgkEB_5tNSTLbeK_Wr2nGtB
 jDAQJOJocLrb8Johhy.JQ2QICZJ9jAKdi8nabKWSgLDD5EhHgoab6_NYLSFhscXu_p3Ao5jcl0U2
 g7UpVgRW2nVH0REA525_ugBQYZYA9z_dGMu94JyttuWWDFK23_GwPI2DnjjvfxKz5Fe7tWu3u0Zb
 QTgkOgQPGThaHKyaKxdowYDYFwCns7pY6hrmhiO9JbUfoJRuTyEbNZ8rTC0Wf8QR_zSxL2BYf0fr
 hZFWt1Kd1ur9cEVDINsJSCEV9esyC8dFneS9mFG5HuUCfhqWA_3GVAGWYec9CS_l1nDU7ZT71AwR
 mPtwX6dP0sFCrabksP0j2Q1UfuNqCfHrT29RPbTa95h.eP5KkKdofD9S_mzIL_XS_9i6Inxi_vYT
 HBSHxF9co27xEaLDD9DzzGWcFj1FVX7IIm0pbbd6gcsSVLiH_7KjWdlbPMgiJWbRfVbLYxw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d0a23db9-8c45-41d9-843b-159616e635b6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 19:03:40 +0000
Received: by hermes--production-gq1-78d49cd6df-t49qq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b9e58974c20c0628bd9811e4fdefae14;
          Tue, 16 Jan 2024 19:03:37 +0000 (UTC)
Message-ID: <5259a6a3-5f9a-4c41-851b-ffd6bd245be3@schaufler-ca.com>
Date: Tue, 16 Jan 2024 11:03:34 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 21/25] ima: Move IMA-Appraisal to LSM infrastructure
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
 neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
 eparis@parisplace.org, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-22-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240115181809.885385-22-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/15/2024 10:18 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> A few additional IMA hooks are needed to reset the cached appraisal
> status, causing the file's integrity to be re-evaluated on next access.
> Register these IMA-appraisal only functions separately from the rest of IMA
> functions, as appraisal is a separate feature not necessarily enabled in
> the kernel configuration.
>
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
>
> Also move the inline function ima_inode_remove_acl() from the public ima.h
> header to ima_appraise.c.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  fs/attr.c                             |  2 -
>  include/linux/ima.h                   | 55 ---------------------------
>  security/integrity/ima/ima.h          |  5 +++
>  security/integrity/ima/ima_appraise.c | 38 +++++++++++++-----
>  security/integrity/ima/ima_main.c     |  1 +
>  security/security.c                   | 13 -------
>  6 files changed, 35 insertions(+), 79 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 221d2bb0a906..38841f3ebbcb 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -17,7 +17,6 @@
>  #include <linux/filelock.h>
>  #include <linux/security.h>
>  #include <linux/evm.h>
> -#include <linux/ima.h>
>  
>  #include "internal.h"
>  
> @@ -503,7 +502,6 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (!error) {
>  		fsnotify_change(dentry, ia_valid);
>  		security_inode_post_setattr(idmap, dentry, ia_valid);
> -		ima_inode_post_setattr(idmap, dentry, ia_valid);
>  		evm_inode_post_setattr(idmap, dentry, ia_valid);
>  	}
>  
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 23ae24b60ecf..0bae61a15b60 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -92,66 +92,11 @@ static inline void ima_add_kexec_buffer(struct kimage *image)
>  
>  #ifdef CONFIG_IMA_APPRAISE
>  extern bool is_ima_appraise_enabled(void);
> -extern void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -				   struct dentry *dentry, int ia_valid);
> -extern int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			      const char *xattr_name, const void *xattr_value,
> -			      size_t xattr_value_len, int flags);
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
> -extern int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -				 const char *xattr_name);
>  #else
>  static inline bool is_ima_appraise_enabled(void)
>  {
>  	return 0;
>  }
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
>  #endif /* CONFIG_IMA_APPRAISE */
>  
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c0412100023e..a27fc10f84f7 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -334,6 +334,7 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
>  int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value, int xattr_len);
> +void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
>  
>  #else
>  static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> @@ -385,6 +386,10 @@ static inline int ima_read_xattr(struct dentry *dentry,
>  	return 0;
>  }
>  
> +static inline void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
> +{
> +}
> +
>  #endif /* CONFIG_IMA_APPRAISE */
>  
>  #ifdef CONFIG_IMA_APPRAISE_MODSIG
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 36abc84ba299..076451109637 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -636,8 +636,8 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>   * This function is called from notify_change(), which expects the caller
>   * to lock the inode's i_mutex.
>   */
> -void ima_inode_post_setattr(struct mnt_idmap *idmap,
> -			    struct dentry *dentry, int ia_valid)
> +static void ima_inode_post_setattr(struct mnt_idmap *idmap,
> +				   struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
>  	struct integrity_iint_cache *iint;
> @@ -750,9 +750,9 @@ static int validate_hash_algo(struct dentry *dentry,
>  	return -EACCES;
>  }
>  
> -int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -		       const char *xattr_name, const void *xattr_value,
> -		       size_t xattr_value_len, int flags)
> +static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const char *xattr_name, const void *xattr_value,
> +			      size_t xattr_value_len, int flags)
>  {
>  	const struct evm_ima_xattr_data *xvalue = xattr_value;
>  	int digsig = 0;
> @@ -781,8 +781,8 @@ int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return result;
>  }
>  
> -int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> -		      const char *acl_name, struct posix_acl *kacl)
> +static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +			     const char *acl_name, struct posix_acl *kacl)
>  {
>  	if (evm_revalidate_status(acl_name))
>  		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> @@ -790,8 +790,8 @@ int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  	return 0;
>  }
>  
> -int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> -			  const char *xattr_name)
> +static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
> +				 const char *xattr_name)
>  {
>  	int result;
>  
> @@ -803,3 +803,23 @@ int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	}
>  	return result;
>  }
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
> +void __init init_ima_appraise_lsm(const struct lsm_id *lsmid)
> +{
> +	security_add_hooks(ima_appraise_hooks, ARRAY_SIZE(ima_appraise_hooks),
> +			   lsmid);
> +}
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 483ccd24e214..77d0d4e4b582 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1178,6 +1178,7 @@ static const struct lsm_id ima_lsmid = {
>  static int __init init_ima_lsm(void)
>  {
>  	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
> +	init_ima_appraise_lsm(&ima_lsmid);
>  	return 0;
>  }
>  
> diff --git a/security/security.c b/security/security.c
> index aa17b47d44c1..c07ad3c5f767 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -20,7 +20,6 @@
>  #include <linux/kernel_read_file.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/integrity.h>
> -#include <linux/ima.h>
>  #include <linux/evm.h>
>  #include <linux/fsnotify.h>
>  #include <linux/mman.h>
> @@ -2308,9 +2307,6 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
>  
>  	if (ret == 1)
>  		ret = cap_inode_setxattr(dentry, name, value, size, flags);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_setxattr(idmap, dentry, name, value, size, flags);
>  	if (ret)
>  		return ret;
>  	return evm_inode_setxattr(idmap, dentry, name, value, size, flags);
> @@ -2338,9 +2334,6 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
>  		return 0;
>  	ret = call_int_hook(inode_set_acl, 0, idmap, dentry, acl_name,
>  			    kacl);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_set_acl(idmap, dentry, acl_name, kacl);
>  	if (ret)
>  		return ret;
>  	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
> @@ -2401,9 +2394,6 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>  		return 0;
>  	ret = call_int_hook(inode_remove_acl, 0, idmap, dentry, acl_name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_remove_acl(idmap, dentry, acl_name);
>  	if (ret)
>  		return ret;
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
> @@ -2503,9 +2493,6 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
>  	ret = call_int_hook(inode_removexattr, 1, idmap, dentry, name);
>  	if (ret == 1)
>  		ret = cap_inode_removexattr(idmap, dentry, name);
> -	if (ret)
> -		return ret;
> -	ret = ima_inode_removexattr(idmap, dentry, name);
>  	if (ret)
>  		return ret;
>  	return evm_inode_removexattr(idmap, dentry, name);

