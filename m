Return-Path: <linux-fsdevel+bounces-8091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B682F58B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE881C23B5A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446E1D555;
	Tue, 16 Jan 2024 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="FVOyippu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic302-28.consmr.mail.ne1.yahoo.com (sonic302-28.consmr.mail.ne1.yahoo.com [66.163.186.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF01D52B
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433950; cv=none; b=nesbHZcLe/qdsMFjLzALNMSrhYYLaAKl/BfLFQndFiIEbqj8Y5MYFO2Thx8jO8zh2Kgg7eS1UjY1JNCkARgrEGv9IL/yQDVunrCT5QIZs/JkXn9VxIBSic+iEoOm93MToLP2v6I9xkCEE+hKLBDrUJb30k0qHPiBIWdlApE40cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433950; c=relaxed/simple;
	bh=yOYFzHOuTO6VrRPZgrSLiqLBvjIs0QRPGE1Mbu2QmoU=;
	h=DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Mailer; b=RjokmIu0D7ZFBAIwq6g37C9j1HY/4vS81jSmiDAcvDJQVN41rplK+kGBuQZvS3PZmCimRZStXLwJUAZGdPYF92BKABXOIxE2TjUnDrq6G/ZN2eHP03rdyQO523bknpYPWhZGRR0kgplaFXLBNiKlJfOY3xNw+VDRe2JitLsHiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=FVOyippu; arc=none smtp.client-ip=66.163.186.154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705433946; bh=RiUglubP9qNWL5GzrvRiXCW/GFkHve/7zdA3FMCkSBg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FVOyippupHovAsecVgk9mo/z8SJ6HufkcpEAFWM1T+kup6FCbxXKPCZhb8+/aRSKA+nO9sMvLAtZvxJe9Cqt1vRtTwiaksqMKDq7diepIsv32h90cB3GexsEZec7GRpDeTo0qLdCzQdwVtlUNeIVRXqOmldHV64jkYaigh3yaNNni3PQn+iiZoVWbmjmbVM7qZJPVqQ1XCY9pmPB2+nIZpW1A4w5iJx2ew3J30E2Axxo/DNzDG3GCgikuHOfLJfkzwK3hW+wTDPzsd97CqpATxZXwmjkvD1PcdrJCMgBPIl3V6116sGONwzmXIe6PhW4fP6I63603rNhY9qTEhatpA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705433946; bh=GwkN94/XIb5zBWM8kioZwMqphYVStpq2rIaNU/yrUkD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MoasUze4qOxAbOYFFpe0chksMNJKqL5lNfAsMuMSdi83zyJTr3K2OrRkxf9L3yQnFjnsRiZxeYzeU/pVdFqtxOZt+7QO4ORrDX2sABExMO5MxOAlOBoOY3j1z6kHFEeNk+HjNzPGiTwdUb+cS2CsP/SlJ3zCQssSLIIPSsDEGDzGtyPbwWyEa1pMQmF2uHSnIrB6w1MWY3c80ROx/gRpgZBnbaTlndrqedybYM1ShTm47kLinRtzlkjjvDOPgVNiMCQEQw5N6HEx1BQ5JK7sXxdfMDfUZS2FIlcNzuXvx2xDgf17ei+Au9GXiYlDJZMnelWfD7fVUds0vKdtkA9cmg==
X-YMail-OSG: JqI4QEsVM1l5xt8rq.qZQJGy1.cmebL3bxyY5_SvbESb3wl.zVRXAmzeti2TE8r
 1v0Fw6TsauPx7mbyVDeB.Il03jqK7gteseSX6GqJ4cOf.AOuoIz1U4APcYJvql8zNYP71TdaSAd5
 kW28HnlwDuuXsmM2pL0Jn4Zp0gffzI3AUYsQD4RxNCGLnW7053spvl2REzd7uVQnt09VhXUpWr5P
 5mRRB7khDnAeDxlUL8yGIyqr28dTvZ3hF.rUCGQixbbMlo8t7As7pdCBXU15Jh1_wh2Bj8yfFYgP
 .XdDh7VKCqM_2L8RXd6bR8ueQNPqspa1WoPfOEMM8Ozu9sOXr98sAS4xhsToTiRj.NRfMnsqHQSz
 P6MyPfNyLnc9s5RSpYOHklMLWwdkd6ugpY6ycHm0xBFnJ3Isuxb0.1p18Kh0Jx.cPP0ANpENLpBN
 AdyLDLzt932_Gpujh0GnlqQbUphlzpjbQE4C1Hg0TVt.OmnNg7Lzbg9W9LRp2kik1DGtDeMZLxDm
 JfVnu4igZXdjcw8rJxoydpZ6Ct_yZle_JQciYFF3bIrUCtVLW65hrE8xygTuu6mRNvwKuMH1HCNZ
 pH0IGqEzQRLsADR5OZaGiD9c57Q9NfzyGwprFS0w_7d9DlP1Rz.G0Oi_FDZEmlDmGgaOy8cXxl8b
 ywyHGcwaOB44HDcdq41iCioYsPCHnNgvQw5OptzA2zwKceyvpRZsu812SA5JVbpz03ArtghriWYC
 cI._KDs9zXC4MCORSHhUQ_3oTVf8PjZZVGMlIL1VpW.Y0LH9FsguCx362l6LNIY3AyZUZqZR2Pd.
 b3MwUy.EwkzIeCFbTft6bKrKl3sWlI6vM659HbhSJ8gR5JmU7IW0ETZPGkP6XEJkdUnX1uBJ0H_b
 fQwoGn4xp_vC5_lHupTmtKJcvrQvHUYOgAgwR0t_0Mw.qV9pR3G_Z39yo0M_2rcE6EYvsaMtDmj1
 9bUvuHj8.AAlTdhpYDuXr5bM4Gp9IRXEEJKrXPEkkhYWId0NDNS48D7qbmqgEecklUDoQ7fzH2x1
 mUl.9gVX3dgu.SXs4MALwHoPm2dZk58NF4eBdcDWMCtV866PiC2oL9yBwQprSdmdHIh8GWWe3_kM
 4I.1W.Ezz5byAOLihgffZhIzg882VOwJ9ZH.ICRTDgWmOIxmLHXMQ7YJV_0JD8QZ38YbvC.ZztxQ
 sts_13ziGuEKfHVDbDD0dB12dWBMGmGoF6EYsewydDwYtRlgr5PAeckeXkFeyf1SawrcEEMdgsOu
 GEIygrSLeeoIxL_btDZXS.HCp8WnW6PBuvmr849vWtKSiC3Ic_4CFBz0_mq.zEmEhAFU2GAPJpCX
 ZUhZTtEAc4KXfRVlhY7JHZFC_VPyX6Z2jjOoZWJ6HbkPcaeuZhSQ97YOOCSmeuX46KuanHiSQtvV
 SWgK36PSfRckKsjGf9YPpprPnK54aRiip._nVLdwTUBi0skUJdSKHo..Gz3qTjluZISmYB2JEu91
 3AbxAsx1jf2_ip8r3rIg5NCojTOVKzY3gRdUd_MO319VXzFUDsZCsREbjvuvy4A5rxCIj0Ka2RZm
 KcniRFIs8J3eVK.NrPCgWerRPkqRoGS41brJNWAd66BwS5l97_pZwracupXezKzvaGj63vXf1IDN
 trbnUY75Mc5810ncjiztxMo5x1eBozfuttmpKxGfHFWqDpp6alwRRwqPXUNJ.Rym3.jRQ8I3i46O
 pmktFdhrl_1cuhfILnZx_J0XSgdLoI6QvREQOv_8aY4zEcg70UozTdraJdM3CJWYClTIvkJYTrS6
 LD.0k.SFaDfwuxqlcFer7gCVu7zQXV_J_d2njKkicF4qGZeMeJTCvD0u_tQDYH4BT5p86m2HmNEj
 7OkYR.OgwGu5iCCyQU36gsX4nHGgcxBVlik1MKjpPQ8vqSn.NuD6Sz50nJJZB_4njiJKbTKJ__T1
 ex0WOKbfQzhqUPXOrUxKRZTDMWRI5gmtfmwrV.V.npjDo.d9_fEg3XQr8rlDpOHZQJ1Kh9Bp4bqt
 wVQpSsodfqTX23I.p_dTeWJ9Ny7azr9FVjNGzsIc57PS0tQ5kB1vZBtBHuu2lq7yD3Fjo8sZQpnI
 HLoI1PdS4JRaeYeA1ygDwc8FOxkfTqV317W9urlL3mDZ.k8k7oFtKf1fmtj1ZCDg6EXfyRtD1rn8
 BLSMG5uuiw7TUv._z7wqq03E0vmManzOPLhOv1dzWv..ZmJb_CilgCr8C9P71AW15hm9Lxk0WUfN
 O5L5FreqAgocpW7MWeugMKFYCR69Lz4xS0h2QCCp2taKSiof98ppg5pHXe66U.iUufCvfDZs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 158c8b8e-e7e6-4d95-b7c3-8d60ecdbee93
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 19:39:06 +0000
Received: by hermes--production-gq1-78d49cd6df-tswkb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a6dcb4c61eac71b6ef7500d2bae378b3;
          Tue, 16 Jan 2024 19:39:03 +0000 (UTC)
Message-ID: <0a5b99b9-0839-4f76-abb4-1fc9e5a6cb49@schaufler-ca.com>
Date: Tue, 16 Jan 2024 11:39:01 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 23/25] evm: Make it independent from 'integrity' LSM
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
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-24-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240115181809.885385-24-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/15/2024 10:18 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define a new structure for EVM-specific metadata, called evm_iint_cache,
> and embed it in the inode security blob. Introduce evm_iint_inode() to
> retrieve metadata, and register evm_inode_alloc_security() for the
> inode_alloc_security LSM hook, to initialize the structure (before
> splitting metadata, this task was done by iint_init_always()).
>
> Keep the non-NULL checks after calling evm_iint_inode() except in
> evm_inode_alloc_security(), to take into account inodes for which
> security_inode_alloc() was not called. When using shared metadata,
> obtaining a NULL pointer from integrity_iint_find() meant that the file
> wasn't in the IMA policy. Now, because IMA and EVM use disjoint metadata,
> the EVM status has to be stored for every inode regardless of the IMA
> policy.
>
> Given that from now on EVM relies on its own metadata, remove the iint
> parameter from evm_verifyxattr(). Also, directly retrieve the iint in
> evm_verify_hmac(), called by both evm_verifyxattr() and
> evm_verify_current_integrity(), since now there is no performance penalty
> in retrieving EVM metadata (constant time).
>
> Replicate the management of the IMA_NEW_FILE flag, by introducing
> evm_post_path_mknod() and evm_file_release() to respectively set and clear
> the newly introduced flag EVM_NEW_FILE, at the same time IMA does. Like for
> IMA, select CONFIG_SECURITY_PATH when EVM is enabled, to ensure that files
> are marked as new.
>
> Unlike ima_post_path_mknod(), evm_post_path_mknod() cannot check if a file
> must be appraised. Thus, it marks all affected files. Also, it does not
> clear EVM_NEW_FILE depending on i_version, but that is not a problem
> because IMA_NEW_FILE is always cleared when set in ima_check_last_writer().
>
> Move the EVM-specific flag EVM_IMMUTABLE_DIGSIG to
> security/integrity/evm/evm.h, since that definition is now unnecessary in
> the common integrity layer.
>
> Finally, switch to the LSM reservation mechanism for the EVM xattr, and
> consequently decrement by one the number of xattrs to allocate in
> security_inode_init_security().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/evm.h                   |  8 +--
>  security/integrity/evm/Kconfig        |  1 +
>  security/integrity/evm/evm.h          | 19 +++++++
>  security/integrity/evm/evm_crypto.c   |  4 +-
>  security/integrity/evm/evm_main.c     | 76 ++++++++++++++++++++-------
>  security/integrity/ima/ima_appraise.c |  2 +-
>  security/integrity/integrity.h        |  1 -
>  security/security.c                   |  4 +-
>  8 files changed, 83 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index cb481eccc967..d48d6da32315 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -12,15 +12,12 @@
>  #include <linux/integrity.h>
>  #include <linux/xattr.h>
>  
> -struct integrity_iint_cache;
> -
>  #ifdef CONFIG_EVM
>  extern int evm_set_key(void *key, size_t keylen);
>  extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  					     const char *xattr_name,
>  					     void *xattr_value,
> -					     size_t xattr_value_len,
> -					     struct integrity_iint_cache *iint);
> +					     size_t xattr_value_len);
>  int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  			    const struct qstr *qstr, struct xattr *xattrs,
>  			    int *xattr_count);
> @@ -48,8 +45,7 @@ static inline int evm_set_key(void *key, size_t keylen)
>  static inline enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  						    const char *xattr_name,
>  						    void *xattr_value,
> -						    size_t xattr_value_len,
> -					struct integrity_iint_cache *iint)
> +						    size_t xattr_value_len)
>  {
>  	return INTEGRITY_UNKNOWN;
>  }
> diff --git a/security/integrity/evm/Kconfig b/security/integrity/evm/Kconfig
> index fba9ee359bc9..861b3bacab82 100644
> --- a/security/integrity/evm/Kconfig
> +++ b/security/integrity/evm/Kconfig
> @@ -6,6 +6,7 @@ config EVM
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
> +	select SECURITY_PATH
>  	default n
>  	help
>  	  EVM protects a file's security extended attributes against
> diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> index 53bd7fec93fa..eb1a2c343bd7 100644
> --- a/security/integrity/evm/evm.h
> +++ b/security/integrity/evm/evm.h
> @@ -32,6 +32,25 @@ struct xattr_list {
>  	bool enabled;
>  };
>  
> +#define EVM_NEW_FILE			0x00000001
> +#define EVM_IMMUTABLE_DIGSIG		0x00000002
> +
> +/* EVM integrity metadata associated with an inode */
> +struct evm_iint_cache {
> +	unsigned long flags;
> +	enum integrity_status evm_status:4;
> +};
> +
> +extern struct lsm_blob_sizes evm_blob_sizes;
> +
> +static inline struct evm_iint_cache *evm_iint_inode(const struct inode *inode)
> +{
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	return inode->i_security + evm_blob_sizes.lbs_inode;
> +}
> +
>  extern int evm_initialized;
>  
>  #define EVM_ATTR_FSUUID		0x0001
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index b1ffd4cc0b44..7552d49d0725 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -322,10 +322,10 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
>  static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
>  {
>  	const struct evm_ima_xattr_data *xattr_data = NULL;
> -	struct integrity_iint_cache *iint;
> +	struct evm_iint_cache *iint;
>  	int rc = 0;
>  
> -	iint = integrity_iint_find(inode);
> +	iint = evm_iint_inode(inode);
>  	if (iint && (iint->flags & EVM_IMMUTABLE_DIGSIG))
>  		return 1;
>  
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index f65dbf3e9256..14c8f38e61d6 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -178,14 +178,14 @@ static int is_unsupported_fs(struct dentry *dentry)
>  static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  					     const char *xattr_name,
>  					     char *xattr_value,
> -					     size_t xattr_value_len,
> -					     struct integrity_iint_cache *iint)
> +					     size_t xattr_value_len)
>  {
>  	struct evm_ima_xattr_data *xattr_data = NULL;
>  	struct signature_v2_hdr *hdr;
>  	enum integrity_status evm_status = INTEGRITY_PASS;
>  	struct evm_digest digest;
> -	struct inode *inode;
> +	struct inode *inode = d_backing_inode(dentry);
> +	struct evm_iint_cache *iint = evm_iint_inode(inode);
>  	int rc, xattr_len, evm_immutable = 0;
>  
>  	if (iint && (iint->evm_status == INTEGRITY_PASS ||
> @@ -254,8 +254,6 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  					(const char *)xattr_data, xattr_len,
>  					digest.digest, digest.hdr.length);
>  		if (!rc) {
> -			inode = d_backing_inode(dentry);
> -
>  			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
>  				if (iint)
>  					iint->flags |= EVM_IMMUTABLE_DIGSIG;
> @@ -403,7 +401,6 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>   * @xattr_name: requested xattr
>   * @xattr_value: requested xattr value
>   * @xattr_value_len: requested xattr value length
> - * @iint: inode integrity metadata
>   *
>   * Calculate the HMAC for the given dentry and verify it against the stored
>   * security.evm xattr. For performance, use the xattr value and length
> @@ -416,8 +413,7 @@ int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
>   */
>  enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  				      const char *xattr_name,
> -				      void *xattr_value, size_t xattr_value_len,
> -				      struct integrity_iint_cache *iint)
> +				      void *xattr_value, size_t xattr_value_len)
>  {
>  	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
>  		return INTEGRITY_UNKNOWN;
> @@ -425,13 +421,8 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  	if (is_unsupported_fs(dentry))
>  		return INTEGRITY_UNKNOWN;
>  
> -	if (!iint) {
> -		iint = integrity_iint_find(d_backing_inode(dentry));
> -		if (!iint)
> -			return INTEGRITY_UNKNOWN;
> -	}
>  	return evm_verify_hmac(dentry, xattr_name, xattr_value,
> -				 xattr_value_len, iint);
> +				 xattr_value_len);
>  }
>  EXPORT_SYMBOL_GPL(evm_verifyxattr);
>  
> @@ -448,7 +439,7 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
>  
>  	if (!evm_key_loaded() || !S_ISREG(inode->i_mode) || evm_fixmode)
>  		return INTEGRITY_PASS;
> -	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
> +	return evm_verify_hmac(dentry, NULL, NULL, 0);
>  }
>  
>  /*
> @@ -526,14 +517,14 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
>  
>  	evm_status = evm_verify_current_integrity(dentry);
>  	if (evm_status == INTEGRITY_NOXATTRS) {
> -		struct integrity_iint_cache *iint;
> +		struct evm_iint_cache *iint;
>  
>  		/* Exception if the HMAC is not going to be calculated. */
>  		if (evm_hmac_disabled())
>  			return 0;
>  
> -		iint = integrity_iint_find(d_backing_inode(dentry));
> -		if (iint && (iint->flags & IMA_NEW_FILE))
> +		iint = evm_iint_inode(d_backing_inode(dentry));
> +		if (iint && (iint->flags & EVM_NEW_FILE))
>  			return 0;
>  
>  		/* exception for pseudo filesystems */
> @@ -735,9 +726,9 @@ static int evm_inode_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>  
>  static void evm_reset_status(struct inode *inode)
>  {
> -	struct integrity_iint_cache *iint;
> +	struct evm_iint_cache *iint;
>  
> -	iint = integrity_iint_find(inode);
> +	iint = evm_iint_inode(inode);
>  	if (iint)
>  		iint->evm_status = INTEGRITY_UNKNOWN;
>  }
> @@ -1019,6 +1010,42 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
>  }
>  EXPORT_SYMBOL_GPL(evm_inode_init_security);
>  
> +static int evm_inode_alloc_security(struct inode *inode)
> +{
> +	struct evm_iint_cache *iint = evm_iint_inode(inode);
> +
> +	/* Called by security_inode_alloc(), it cannot be NULL. */
> +	iint->flags = 0UL;
> +	iint->evm_status = INTEGRITY_UNKNOWN;
> +
> +	return 0;
> +}
> +
> +static void evm_file_release(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct evm_iint_cache *iint = evm_iint_inode(inode);
> +	fmode_t mode = file->f_mode;
> +
> +	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
> +		return;
> +
> +	if (iint && atomic_read(&inode->i_writecount) == 1)
> +		iint->flags &= ~EVM_NEW_FILE;
> +}
> +
> +static void evm_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	struct evm_iint_cache *iint = evm_iint_inode(inode);
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return;
> +
> +	if (iint)
> +		iint->flags |= EVM_NEW_FILE;
> +}
> +
>  #ifdef CONFIG_EVM_LOAD_X509
>  void __init evm_load_x509(void)
>  {
> @@ -1071,6 +1098,9 @@ static struct security_hook_list evm_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_removexattr, evm_inode_removexattr),
>  	LSM_HOOK_INIT(inode_post_removexattr, evm_inode_post_removexattr),
>  	LSM_HOOK_INIT(inode_init_security, evm_inode_init_security),
> +	LSM_HOOK_INIT(inode_alloc_security, evm_inode_alloc_security),
> +	LSM_HOOK_INIT(file_release, evm_file_release),
> +	LSM_HOOK_INIT(path_post_mknod, evm_post_path_mknod),
>  };
>  
>  static const struct lsm_id evm_lsmid = {
> @@ -1084,10 +1114,16 @@ static int __init init_evm_lsm(void)
>  	return 0;
>  }
>  
> +struct lsm_blob_sizes evm_blob_sizes __ro_after_init = {
> +	.lbs_inode = sizeof(struct evm_iint_cache),
> +	.lbs_xattr_count = 1,
> +};
> +
>  DEFINE_LSM(evm) = {
>  	.name = "evm",
>  	.init = init_evm_lsm,
>  	.order = LSM_ORDER_LAST,
> +	.blobs = &evm_blob_sizes,
>  };
>  
>  late_initcall(init_evm);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 076451109637..1dd6ee72a20a 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -520,7 +520,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	}
>  
>  	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value,
> -				 rc < 0 ? 0 : rc, iint);
> +				 rc < 0 ? 0 : rc);
>  	switch (status) {
>  	case INTEGRITY_PASS:
>  	case INTEGRITY_PASS_IMMUTABLE:
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 59eaddd84434..7a97c269a072 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -37,7 +37,6 @@
>  #define IMA_DIGSIG_REQUIRED	0x01000000
>  #define IMA_PERMIT_DIRECTIO	0x02000000
>  #define IMA_NEW_FILE		0x04000000
> -#define EVM_IMMUTABLE_DIGSIG	0x08000000
>  #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
>  #define IMA_MODSIG_ALLOWED	0x20000000
>  #define IMA_CHECK_BLACKLIST	0x40000000
> diff --git a/security/security.c b/security/security.c
> index a44740640a9a..f811cc376a7a 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1716,8 +1716,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  		return 0;
>  
>  	if (initxattrs) {
> -		/* Allocate +1 for EVM and +1 as terminator. */
> -		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 2,
> +		/* Allocate +1 as terminator. */
> +		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
>  				     sizeof(*new_xattrs), GFP_NOFS);
>  		if (!new_xattrs)
>  			return -ENOMEM;

