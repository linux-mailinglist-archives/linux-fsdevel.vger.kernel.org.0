Return-Path: <linux-fsdevel+bounces-8092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9782F59A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB891F24DAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCC51D553;
	Tue, 16 Jan 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bHaN2gpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750711D540
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434026; cv=none; b=o5B9nc7YTSsrfjelVl8RO3AyFUoxdmhDowBT9fZZYvbKP2fyJ3b1lXwAde2WXZBzXbsj5GuLWjndmsuWE11AKrhQJYbb+x/Wmzbq4uJ1Hg8egnZ3zYx8sat5iPRgZKCgXfhw1OFWDS9//3YmI7yG4XkY68ai0mFShTfqqIFp9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434026; c=relaxed/simple;
	bh=krbgJirJjW8YpTcAtBT3ukiOUDEFQmC9gAXh8ooGiGk=;
	h=DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Mailer; b=V8fZ50D7kWlyDLN/nSVccHF8bJ8bXcExiaFV/s4sB3xfiRI8Fk+gTfkDpGDNYhYKgLPnVutWqizaEOg/ca3WLTwZM9065SYnKNpIqk0JtCKcV7OkyP0ftke2jES7e6zUBOIEjss2VDaeb+AxXVd/tE3fYTBOi6kWa6bj+qq/1pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bHaN2gpq; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705434022; bh=IRmaV32QBoXSmAQj6OEFJ0FqwkwRwcY1+i7IQefEI/A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bHaN2gpq1EtLsT12Ud8fUa+Wq7cAC6Nzw3Zl5zmHotla48TsOx/hocKWLrpCHVUJMNFaAhQdnZoTkfSpHoW2K5ycQYgzRVM4BTc1k02cTmZYGgCX0n4kYxWf5+Ra8aGvXOr/YkYGdiyvEGO9b8YlTi3ZfGHFOUCYrTDmXdOLADfT06FpZ9WB2PUS061duMOxY3w3vHLeamrjWyDmXrJj+j/gEnTy8/SXfW7kv8SVJtC4C/nsosoEiGB4L9OtdtH9s0J69aRH00dXILwQCxDkOfHvt2B2wc4gtgMV/xZWJmBt+vPOf2WvA2zrhnA4yKRbbqzS8lcxf1aMgHR9TLPfUQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705434022; bh=fLIkHlqRthEnP7UGuJr7n3qUvNID+Hwt/epBDzX4SfY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RmXobPXCfZ43DjA8FyxASiHDFydpf6QKPejUTmG/8r2VoKt+80oFQKsfrCaEjbwLvNm9FoM26x9GM3TCIJKruR1pOr/H5JqDqxWOrlKpO3O+96Oi1eDzomItPzcfOX29/Npws2AW+Ki8/HuUOdvIJYcQqo8kx0c+CqoNG00P5V1BZErg++gIFVhu1CMJ9hbir7nZet8ik1h9+i8bgJ341HsVTG3eTisjFvHaXwYVDtiiTqlM/Xv+2QLlDYHkA2gwa3cDfqR8X/3DEgXfPCt989qHlH6GQCt7WNMaryM2xAGmw+TEK7WVyxcLJEcbwtFV6SMC+87GOszOeBpbMYDvFw==
X-YMail-OSG: rV9McJkVM1l85YA4kC9taTqY4jxPKEPFa25Z696edxyvGuEM7BaED4l4.vTFeZF
 WfWlcVOfbIrzZtoVlJlCzANqcxHQbnc2sll_XQSRAQi5AH5aJBR1Jr0A8pljZC2...7XTgQyILsr
 Ol3.bFle0JbUPirO5vXneYlhDryJjeqjQxicD9UC_3kezEYmfy0zIDTOnaNcYClDwQm0e4phpkCH
 d9deUnJttk_nVFcXjxKTn4Htk7627jpHid4YQsH3DJrWdaFhvxx7wGevKtd7_BCMXoA3HttYDTaW
 oyNwKRrH_rFJ.dP_4HqGl5C84xLFumRhq9LYKXB0lYfYrAykzuNIh2bzMzMjAv6OFqBd6hUxENur
 VyCZ0J84o75hQXCZuf9v9bd.SyB6TqDZfUqoio3YK_a_h6SuSaQS9eUrov11takRUBrug34bjUiB
 8hQX8xzpSgaT7TBHbnPWKFlJPUm6jy0SljDjbeoHGT0LP73DPZCheP7_005PnAVSnzKZmAoTZ_oe
 VrzRb.X21t3Dik4OO7jzisHcKAJPfBCra9SgGENI9BfH.fSBq1ODmBqs9i3S79BaKK45j4d3EnDE
 hN67Fc4Zw49WqyL2C_WFvXShTBQSa46oL2D.3..zdT9ZsMlyfjuFuooRPSAU8b_xx1efHporRH8X
 fuQywUKpPr1Q61a68OnvVGFY.tjuZTMN3RjOp2ePuB0FlZ.ro4qN_hctt.Rcfc91fGzyK8eXimdr
 KvdPF9coRJBZv6PQ7GWAuOrOAt3X1hWaFeI3i6qLm0h80Z8NTMH250pG81wyzhvaqhl4Tr6YmH4o
 JvbNZdNJ9yXgByxTQLCpAe4P68lJeshUM7G3aYS4aL_PjYeTz.DfBqJWn5mnjOthsxl2lS_bXQ4b
 3XeDNhyWvxzcru0DibSWUyxxejZrbJ4871VZpsFmRAy.gloEkfAaXmCRQQhZwIplI4VdF7j91VgQ
 PHzQZdbGinry4BRzrH7IhB47fI.smp3fEpga7qekgfYXSeJccBPx8lkckSfCeb_v9B4KwHO2YoBp
 UYt.oEAXdSmhE.4zze0O0YmnJHRK72evyngdIf9G8HnCDpzE4P.y_70UdMc2W3GDfKEgVUfRNrGa
 ka5gEjY.xgkYp0r8ZETgG43d8pI8HNBeS1wQPp5DETs2qRNcBjmSkHdYbtyBInp06qoWAcf5dzyk
 441Sh8J9x5pnzOzDExZBsgrnQds6mublryh4xtbOFtYT.iAP8IYcWhGAvcDUWFJlwMW1G.RDF0Zf
 WWr_S0VKdDKT9IoK4iFsxE3yLpkAaP0wvVz4DpQk57e3RZpk158.f0OJBwsJDolaxicmwIvWVOFO
 gvEykerv4wUDoqeFqL2RxdNPmZ5jowFixWwH0Am2r3n.5aKmTQQdeD08QTdmhMeutd.9FhKZwLWP
 umSoFkIGBnTnXQ8bp9CovFeZ0agl_UxbOlmmq6iMWnopUW4yUBXRxU2S4D6cOAr.et6eThArRpAU
 fODrC7Iw6.kBxKBjiopE_j6d4skAwIJ4AajWgekj7CL7kUzpgF6Jithskv9CH2KcMPHLJ.Z3Jr3v
 _3WhYg7Ezpda3HWQmY.7lsldeHMlMqfoXjiz7uJtoDIxKPNPwGlYW.ZRENI_ClBDeACxlJHlOSXh
 PeeL6sh04rfM4p.ZXbXse5EZ17JdHw.7aOrVBCN3f0JBLKPPJCgl1O.Gw3Hm27X9GB6icMTDNCAf
 FeTWMMYvZyhnmquRF5f.I8NWihFqWKQvQ_cdPIhxDQBTUZHqALpThIHYWpVxuctJxAd0cGLGTBfl
 U8_QCq1W0oHZcEmQv9xHIuKezr8ZYmtsVzn5dXkoxGN2Tw6FenaGJLCaiip3znyfdAE.eRWHyqoT
 2D.NxOzffik_iAu38TYmwr1j8KcKHSy1hOKJ0TV6o3j5l0iV21GoXnxPLXB8VLtZ94zusL_68mS2
 C383VGFBspJ11ylENxgC5YrBJXvtCJE8Vwd.S3TtqT5MPzDBNOyYQKF0qw0gg5UrUtz5mpSde7ET
 CfJ9Ld0Bt.eCVHknyj8WazqdLyevRcCpC6AXQZ1k7jzmsCr4dIyZCubD5RFbCWMruyZov9gRas72
 XJxIHwz4vM25XIWWRn4ksw3lqLmSdRjBBxMP1oA87cP5X0IKkN27rMomfqBDMZb7p344kTokgnB4
 yswb.WlK2jTYHvSGfhErgHPsyA0PNW18QitSc0dsLJc6k_UakoTxTAGVajibNC4yWGId0noq0NES
 oEyueMGYInXhad3Gx2gHmR5YvVip2oQtqTIAPKNFeZdaWc1EDUPqJV0hsPuAmDBrtEG5gsxVB
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 788ef928-f668-4ad3-acfb-0491b5c5a659
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 19:40:22 +0000
Received: by hermes--production-gq1-78d49cd6df-ml6vl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7d42d16ca15eb5e4a9eb333504efd113;
          Tue, 16 Jan 2024 19:40:20 +0000 (UTC)
Message-ID: <e5ca42cb-6d0e-4e37-a86b-c916c47c7744@schaufler-ca.com>
Date: Tue, 16 Jan 2024 11:40:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 24/25] ima: Make it independent from 'integrity' LSM
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
 <20240115181809.885385-25-roberto.sassu@huaweicloud.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240115181809.885385-25-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/15/2024 10:18 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Make the 'ima' LSM independent from the 'integrity' LSM by introducing IMA
> own integrity metadata (ima_iint_cache structure, with IMA-specific fields
> from the integrity_iint_cache structure), and by managing it directly from
> the 'ima' LSM.
>
> Create ima_iint.c and introduce the same integrity metadata management
> functions found in iint.c (renamed with ima_). However, instead of putting
> metadata in an rbtree, reserve space from IMA in the inode security blob
> for a pointer, and introduce the ima_inode_set_iint()/ima_inode_get_iint()
> primitives to store/retrieve that pointer. This improves search time from
> logarithm to constant.
>
> Consequently, don't include the inode pointer as field in the
> ima_iint_cache structure, since the association with the inode is clear.
> Since the inode field is missing in ima_iint_cache, pass the extra inode
> parameter to ima_get_verity_digest().
>
> Prefer storing the pointer instead of the entire ima_iint_cache structure,
> to avoid too much memory pressure. Use the same mechanism as before, a
> cache named ima_iint_cache (renamed from iint_cache), to quickly allocate
> a new ima_iint_cache structure when requested by the IMA policy.
>
> Create the new ima_iint_cache in ima_iintcache_init(),
> called by init_ima_lsm(), during the initialization of the 'ima' LSM. And,
> register ima_inode_free_security() to free the ima_iint_cache structure, if
> exists.
>
> Replace integrity_iint_cache with ima_iint_cache in various places of the
> IMA code. Also, replace integrity_inode_get() and integrity_iint_find(),
> respectively with ima_inode_get() and ima_iint_find().
>
> Finally, move the remaining IMA-specific flags
> to security/integrity/ima/ima.h, since they are now unnecessary in the
> common integrity layer.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>4

> ---
>  security/integrity/ima/Makefile       |   2 +-
>  security/integrity/ima/ima.h          | 137 +++++++++++++++++++++----
>  security/integrity/ima/ima_api.c      |  23 +++--
>  security/integrity/ima/ima_appraise.c |  27 +++--
>  security/integrity/ima/ima_iint.c     | 142 ++++++++++++++++++++++++++
>  security/integrity/ima/ima_init.c     |   2 +-
>  security/integrity/ima/ima_main.c     |  36 ++++---
>  security/integrity/ima/ima_policy.c   |   2 +-
>  security/integrity/integrity.h        |  53 ----------
>  9 files changed, 308 insertions(+), 116 deletions(-)
>  create mode 100644 security/integrity/ima/ima_iint.c
>
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index 2499f2485c04..b376d38b4ee6 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -4,7 +4,7 @@
>  # Measurement Architecture(IMA).
>  #
>  
> -obj-$(CONFIG_IMA) += ima.o
> +obj-$(CONFIG_IMA) += ima.o ima_iint.o
>  
>  ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
>  	 ima_policy.o ima_template.o ima_template_lib.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a27fc10f84f7..11d7c0332207 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -60,7 +60,7 @@ extern const char boot_aggregate_name[];
>  
>  /* IMA event related data */
>  struct ima_event_data {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	struct file *file;
>  	const unsigned char *filename;
>  	struct evm_ima_xattr_data *xattr_value;
> @@ -119,6 +119,107 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
>  
> +/* IMA iint action cache flags */
> +#define IMA_MEASURE		0x00000001
> +#define IMA_MEASURED		0x00000002
> +#define IMA_APPRAISE		0x00000004
> +#define IMA_APPRAISED		0x00000008
> +/*#define IMA_COLLECT		0x00000010  do not use this flag */
> +#define IMA_COLLECTED		0x00000020
> +#define IMA_AUDIT		0x00000040
> +#define IMA_AUDITED		0x00000080
> +#define IMA_HASH		0x00000100
> +#define IMA_HASHED		0x00000200
> +
> +/* IMA iint policy rule cache flags */
> +#define IMA_NONACTION_FLAGS	0xff000000
> +#define IMA_DIGSIG_REQUIRED	0x01000000
> +#define IMA_PERMIT_DIRECTIO	0x02000000
> +#define IMA_NEW_FILE		0x04000000
> +#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> +#define IMA_MODSIG_ALLOWED	0x20000000
> +#define IMA_CHECK_BLACKLIST	0x40000000
> +#define IMA_VERITY_REQUIRED	0x80000000
> +
> +#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
> +				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> +#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
> +				 IMA_HASHED | IMA_COLLECTED | \
> +				 IMA_APPRAISED_SUBMASK)
> +
> +/* IMA iint subaction appraise cache flags */
> +#define IMA_FILE_APPRAISE	0x00001000
> +#define IMA_FILE_APPRAISED	0x00002000
> +#define IMA_MMAP_APPRAISE	0x00004000
> +#define IMA_MMAP_APPRAISED	0x00008000
> +#define IMA_BPRM_APPRAISE	0x00010000
> +#define IMA_BPRM_APPRAISED	0x00020000
> +#define IMA_READ_APPRAISE	0x00040000
> +#define IMA_READ_APPRAISED	0x00080000
> +#define IMA_CREDS_APPRAISE	0x00100000
> +#define IMA_CREDS_APPRAISED	0x00200000
> +#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
> +				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
> +				 IMA_CREDS_APPRAISE)
> +#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
> +				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
> +				 IMA_CREDS_APPRAISED)
> +
> +/* IMA iint cache atomic_flags */
> +#define IMA_CHANGE_XATTR	0
> +#define IMA_UPDATE_XATTR	1
> +#define IMA_CHANGE_ATTR		2
> +#define IMA_DIGSIG		3
> +#define IMA_MUST_MEASURE	4
> +
> +/* IMA integrity metadata associated with an inode */
> +struct ima_iint_cache {
> +	struct mutex mutex;	/* protects: version, flags, digest */
> +	u64 version;		/* track inode changes */
> +	unsigned long flags;
> +	unsigned long measured_pcrs;
> +	unsigned long atomic_flags;
> +	unsigned long real_ino;
> +	dev_t real_dev;
> +	enum integrity_status ima_file_status:4;
> +	enum integrity_status ima_mmap_status:4;
> +	enum integrity_status ima_bprm_status:4;
> +	enum integrity_status ima_read_status:4;
> +	enum integrity_status ima_creds_status:4;
> +	struct ima_digest_data *ima_hash;
> +};
> +
> +extern struct lsm_blob_sizes ima_blob_sizes;
> +
> +static inline struct ima_iint_cache *
> +ima_inode_get_iint(const struct inode *inode)
> +{
> +	struct ima_iint_cache **iint_sec;
> +
> +	if (unlikely(!inode->i_security))
> +		return NULL;
> +
> +	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
> +	return *iint_sec;
> +}
> +
> +static inline void ima_inode_set_iint(const struct inode *inode,
> +				      struct ima_iint_cache *iint)
> +{
> +	struct ima_iint_cache **iint_sec;
> +
> +	if (unlikely(!inode->i_security))
> +		return;
> +
> +	iint_sec = inode->i_security + ima_blob_sizes.lbs_inode;
> +	*iint_sec = iint;
> +}
> +
> +struct ima_iint_cache *ima_iint_find(struct inode *inode);
> +struct ima_iint_cache *ima_inode_get(struct inode *inode);
> +void ima_inode_free(struct inode *inode);
> +void __init ima_iintcache_init(void);
> +
>  extern const int read_idmap[];
>  
>  #ifdef CONFIG_HAVE_IMA_KEXEC
> @@ -152,8 +253,8 @@ int ima_calc_field_array_hash(struct ima_field_data *field_data,
>  			      struct ima_template_entry *entry);
>  int ima_calc_boot_aggregate(struct ima_digest_data *hash);
>  void ima_add_violation(struct file *file, const unsigned char *filename,
> -		       struct integrity_iint_cache *iint,
> -		       const char *op, const char *cause);
> +		       struct ima_iint_cache *iint, const char *op,
> +		       const char *cause);
>  int ima_init_crypto(void);
>  void ima_putc(struct seq_file *m, void *data, int datalen);
>  void ima_print_digest(struct seq_file *m, u8 *digest, u32 size);
> @@ -267,10 +368,10 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
>  		   struct ima_template_desc **template_desc,
>  		   const char *func_data, unsigned int *allowed_algos);
>  int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
> -int ima_collect_measurement(struct integrity_iint_cache *iint,
> -			    struct file *file, void *buf, loff_t size,
> -			    enum hash_algo algo, struct modsig *modsig);
> -void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
> +int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> +			    void *buf, loff_t size, enum hash_algo algo,
> +			    struct modsig *modsig);
> +void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
>  			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
> @@ -280,7 +381,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>  			       const char *eventname, enum ima_hooks func,
>  			       int pcr, const char *func_data,
>  			       bool buf_hash, u8 *digest, size_t digest_len);
> -void ima_audit_measurement(struct integrity_iint_cache *iint,
> +void ima_audit_measurement(struct ima_iint_cache *iint,
>  			   const unsigned char *filename);
>  int ima_alloc_init_template(struct ima_event_data *event_data,
>  			    struct ima_template_entry **entry,
> @@ -318,17 +419,16 @@ int ima_policy_show(struct seq_file *m, void *v);
>  #define IMA_APPRAISE_KEXEC	0x40
>  
>  #ifdef CONFIG_IMA_APPRAISE
> -int ima_check_blacklist(struct integrity_iint_cache *iint,
> +int ima_check_blacklist(struct ima_iint_cache *iint,
>  			const struct modsig *modsig, int pcr);
> -int ima_appraise_measurement(enum ima_hooks func,
> -			     struct integrity_iint_cache *iint,
> +int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, const struct modsig *modsig);
>  int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
>  		      int mask, enum ima_hooks func);
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
> -enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> +void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
> +enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
>  					   enum ima_hooks func);
>  enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
> @@ -337,14 +437,14 @@ int ima_read_xattr(struct dentry *dentry,
>  void __init init_ima_appraise_lsm(const struct lsm_id *lsmid);
>  
>  #else
> -static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
> +static inline int ima_check_blacklist(struct ima_iint_cache *iint,
>  				      const struct modsig *modsig, int pcr)
>  {
>  	return 0;
>  }
>  
>  static inline int ima_appraise_measurement(enum ima_hooks func,
> -					   struct integrity_iint_cache *iint,
> +					   struct ima_iint_cache *iint,
>  					   struct file *file,
>  					   const unsigned char *filename,
>  					   struct evm_ima_xattr_data *xattr_value,
> @@ -361,14 +461,13 @@ static inline int ima_must_appraise(struct mnt_idmap *idmap,
>  	return 0;
>  }
>  
> -static inline void ima_update_xattr(struct integrity_iint_cache *iint,
> +static inline void ima_update_xattr(struct ima_iint_cache *iint,
>  				    struct file *file)
>  {
>  }
>  
> -static inline enum integrity_status ima_get_cache_status(struct integrity_iint_cache
> -							 *iint,
> -							 enum ima_hooks func)
> +static inline enum integrity_status
> +ima_get_cache_status(struct ima_iint_cache *iint, enum ima_hooks func)
>  {
>  	return INTEGRITY_UNKNOWN;
>  }
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 597ea0c4d72f..b37d043d5748 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -131,8 +131,8 @@ int ima_store_template(struct ima_template_entry *entry,
>   * value is invalidated.
>   */
>  void ima_add_violation(struct file *file, const unsigned char *filename,
> -		       struct integrity_iint_cache *iint,
> -		       const char *op, const char *cause)
> +		       struct ima_iint_cache *iint, const char *op,
> +		       const char *cause)
>  {
>  	struct ima_template_entry *entry;
>  	struct inode *inode = file_inode(file);
> @@ -201,7 +201,8 @@ int ima_get_action(struct mnt_idmap *idmap, struct inode *inode,
>  				allowed_algos);
>  }
>  
> -static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
> +static bool ima_get_verity_digest(struct ima_iint_cache *iint,
> +				  struct inode *inode,
>  				  struct ima_max_digest_data *hash)
>  {
>  	enum hash_algo alg;
> @@ -211,7 +212,7 @@ static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
>  	 * On failure, 'measure' policy rules will result in a file data
>  	 * hash containing 0's.
>  	 */
> -	digest_len = fsverity_get_digest(iint->inode, hash->digest, NULL, &alg);
> +	digest_len = fsverity_get_digest(inode, hash->digest, NULL, &alg);
>  	if (digest_len == 0)
>  		return false;
>  
> @@ -237,9 +238,9 @@ static bool ima_get_verity_digest(struct integrity_iint_cache *iint,
>   *
>   * Return 0 on success, error code otherwise
>   */
> -int ima_collect_measurement(struct integrity_iint_cache *iint,
> -			    struct file *file, void *buf, loff_t size,
> -			    enum hash_algo algo, struct modsig *modsig)
> +int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
> +			    void *buf, loff_t size, enum hash_algo algo,
> +			    struct modsig *modsig)
>  {
>  	const char *audit_cause = "failed";
>  	struct inode *inode = file_inode(file);
> @@ -280,7 +281,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>  	memset(&hash.digest, 0, sizeof(hash.digest));
>  
>  	if (iint->flags & IMA_VERITY_REQUIRED) {
> -		if (!ima_get_verity_digest(iint, &hash)) {
> +		if (!ima_get_verity_digest(iint, inode, &hash)) {
>  			audit_cause = "no-verity-digest";
>  			result = -ENODATA;
>  		}
> @@ -338,8 +339,8 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
>   *
>   * Must be called with iint->mutex held.
>   */
> -void ima_store_measurement(struct integrity_iint_cache *iint,
> -			   struct file *file, const unsigned char *filename,
> +void ima_store_measurement(struct ima_iint_cache *iint, struct file *file,
> +			   const unsigned char *filename,
>  			   struct evm_ima_xattr_data *xattr_value,
>  			   int xattr_len, const struct modsig *modsig, int pcr,
>  			   struct ima_template_desc *template_desc)
> @@ -382,7 +383,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  		ima_free_template_entry(entry);
>  }
>  
> -void ima_audit_measurement(struct integrity_iint_cache *iint,
> +void ima_audit_measurement(struct ima_iint_cache *iint,
>  			   const unsigned char *filename)
>  {
>  	struct audit_buffer *ab;
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 1dd6ee72a20a..3497741caea9 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -84,8 +84,7 @@ int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
>  				NULL, NULL, NULL);
>  }
>  
> -static int ima_fix_xattr(struct dentry *dentry,
> -			 struct integrity_iint_cache *iint)
> +static int ima_fix_xattr(struct dentry *dentry, struct ima_iint_cache *iint)
>  {
>  	int rc, offset;
>  	u8 algo = iint->ima_hash->algo;
> @@ -106,7 +105,7 @@ static int ima_fix_xattr(struct dentry *dentry,
>  }
>  
>  /* Return specific func appraised cached result */
> -enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
> +enum integrity_status ima_get_cache_status(struct ima_iint_cache *iint,
>  					   enum ima_hooks func)
>  {
>  	switch (func) {
> @@ -126,7 +125,7 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  	}
>  }
>  
> -static void ima_set_cache_status(struct integrity_iint_cache *iint,
> +static void ima_set_cache_status(struct ima_iint_cache *iint,
>  				 enum ima_hooks func,
>  				 enum integrity_status status)
>  {
> @@ -152,8 +151,7 @@ static void ima_set_cache_status(struct integrity_iint_cache *iint,
>  	}
>  }
>  
> -static void ima_cache_flags(struct integrity_iint_cache *iint,
> -			     enum ima_hooks func)
> +static void ima_cache_flags(struct ima_iint_cache *iint, enum ima_hooks func)
>  {
>  	switch (func) {
>  	case MMAP_CHECK:
> @@ -276,7 +274,7 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
>   *
>   * Return 0 on success, error code otherwise.
>   */
> -static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
> +static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
>  			struct evm_ima_xattr_data *xattr_value, int xattr_len,
>  			enum integrity_status *status, const char **cause)
>  {
> @@ -443,7 +441,7 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
>   *
>   * Returns -EPERM if the hash is blacklisted.
>   */
> -int ima_check_blacklist(struct integrity_iint_cache *iint,
> +int ima_check_blacklist(struct ima_iint_cache *iint,
>  			const struct modsig *modsig, int pcr)
>  {
>  	enum hash_algo hash_algo;
> @@ -477,8 +475,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
>   *
>   * Return 0 on success, error code otherwise
>   */
> -int ima_appraise_measurement(enum ima_hooks func,
> -			     struct integrity_iint_cache *iint,
> +int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
>  			     struct file *file, const unsigned char *filename,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, const struct modsig *modsig)
> @@ -603,7 +600,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  /*
>   * ima_update_xattr - update 'security.ima' hash value
>   */
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
> +void ima_update_xattr(struct ima_iint_cache *iint, struct file *file)
>  {
>  	struct dentry *dentry = file_dentry(file);
>  	int rc = 0;
> @@ -640,7 +637,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
>  				   struct dentry *dentry, int ia_valid)
>  {
>  	struct inode *inode = d_backing_inode(dentry);
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	int action;
>  
>  	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
> @@ -648,7 +645,7 @@ static void ima_inode_post_setattr(struct mnt_idmap *idmap,
>  		return;
>  
>  	action = ima_must_appraise(idmap, inode, MAY_ACCESS, POST_SETATTR);
> -	iint = integrity_iint_find(inode);
> +	iint = ima_iint_find(inode);
>  	if (iint) {
>  		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
>  		if (!action)
> @@ -674,12 +671,12 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  
>  static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  
>  	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
>  		return;
>  
> -	iint = integrity_iint_find(inode);
> +	iint = ima_iint_find(inode);
>  	if (!iint)
>  		return;
>  	iint->measured_pcrs = 0;
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
> new file mode 100644
> index 000000000000..e7c9c216c1c6
> --- /dev/null
> +++ b/security/integrity/ima/ima_iint.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2008 IBM Corporation
> + *
> + * Authors:
> + * Mimi Zohar <zohar@us.ibm.com>
> + *
> + * File: ima_iint.c
> + *	- implements the IMA hook: ima_inode_free
> + *	- cache integrity information in the inode security blob
> + */
> +#include <linux/slab.h>
> +
> +#include "ima.h"
> +
> +static struct kmem_cache *ima_iint_cache __ro_after_init;
> +
> +/**
> + * ima_iint_find - Return the iint associated with an inode
> + * @inode: Pointer to the inode
> + *
> + * Return the IMA integrity information (iint) associated with an inode, if the
> + * inode was processed by IMA.
> + *
> + * Return: Found iint or NULL.
> + */
> +struct ima_iint_cache *ima_iint_find(struct inode *inode)
> +{
> +	if (!IS_IMA(inode))
> +		return NULL;
> +
> +	return ima_inode_get_iint(inode);
> +}
> +
> +#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
> +
> +/*
> + * It is not clear that IMA should be nested at all, but as long is it measures
> + * files both on overlayfs and on underlying fs, we need to annotate the iint
> + * mutex to avoid lockdep false positives related to IMA + overlayfs.
> + * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> + */
> +static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint,
> +					     struct inode *inode)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
> +
> +	int depth = inode->i_sb->s_stack_depth;
> +
> +	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
> +		depth = 0;
> +
> +	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
> +#endif
> +}
> +
> +static void ima_iint_init_always(struct ima_iint_cache *iint,
> +				 struct inode *inode)
> +{
> +	iint->ima_hash = NULL;
> +	iint->version = 0;
> +	iint->flags = 0UL;
> +	iint->atomic_flags = 0UL;
> +	iint->ima_file_status = INTEGRITY_UNKNOWN;
> +	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
> +	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
> +	iint->ima_read_status = INTEGRITY_UNKNOWN;
> +	iint->ima_creds_status = INTEGRITY_UNKNOWN;
> +	iint->measured_pcrs = 0;
> +	mutex_init(&iint->mutex);
> +	ima_iint_lockdep_annotate(iint, inode);
> +}
> +
> +static void ima_iint_free(struct ima_iint_cache *iint)
> +{
> +	kfree(iint->ima_hash);
> +	mutex_destroy(&iint->mutex);
> +	kmem_cache_free(ima_iint_cache, iint);
> +}
> +
> +/**
> + * ima_inode_get - Find or allocate an iint associated with an inode
> + * @inode: Pointer to the inode
> + *
> + * Find an iint associated with an inode, and allocate a new one if not found.
> + * Caller must lock i_mutex.
> + *
> + * Return: An iint on success, NULL on error.
> + */
> +struct ima_iint_cache *ima_inode_get(struct inode *inode)
> +{
> +	struct ima_iint_cache *iint;
> +
> +	iint = ima_iint_find(inode);
> +	if (iint)
> +		return iint;
> +
> +	iint = kmem_cache_alloc(ima_iint_cache, GFP_NOFS);
> +	if (!iint)
> +		return NULL;
> +
> +	ima_iint_init_always(iint, inode);
> +
> +	inode->i_flags |= S_IMA;
> +	ima_inode_set_iint(inode, iint);
> +
> +	return iint;
> +}
> +
> +/**
> + * ima_inode_free - Called on inode free
> + * @inode: Pointer to the inode
> + *
> + * Free the iint associated with an inode.
> + */
> +void ima_inode_free(struct inode *inode)
> +{
> +	struct ima_iint_cache *iint;
> +
> +	if (!IS_IMA(inode))
> +		return;
> +
> +	iint = ima_iint_find(inode);
> +	ima_inode_set_iint(inode, NULL);
> +
> +	ima_iint_free(iint);
> +}
> +
> +static void ima_iint_init_once(void *foo)
> +{
> +	struct ima_iint_cache *iint = (struct ima_iint_cache *)foo;
> +
> +	memset(iint, 0, sizeof(*iint));
> +}
> +
> +void __init ima_iintcache_init(void)
> +{
> +	ima_iint_cache =
> +	    kmem_cache_create("ima_iint_cache", sizeof(struct ima_iint_cache),
> +			      0, SLAB_PANIC, ima_iint_init_once);
> +}
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 63979aefc95f..393f5c7912d5 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -44,7 +44,7 @@ static int __init ima_add_boot_aggregate(void)
>  	static const char op[] = "add_boot_aggregate";
>  	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry;
> -	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_iint_cache tmp_iint, *iint = &tmp_iint;
>  	struct ima_event_data event_data = { .iint = iint,
>  					     .filename = boot_aggregate_name };
>  	struct ima_max_digest_data hash;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 77d0d4e4b582..45f1a102c599 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -114,7 +114,7 @@ static int mmap_violation_check(enum ima_hooks func, struct file *file,
>   *
>   */
>  static void ima_rdwr_violation_check(struct file *file,
> -				     struct integrity_iint_cache *iint,
> +				     struct ima_iint_cache *iint,
>  				     int must_measure,
>  				     char **pathbuf,
>  				     const char **pathname,
> @@ -127,7 +127,7 @@ static void ima_rdwr_violation_check(struct file *file,
>  	if (mode & FMODE_WRITE) {
>  		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
>  			if (!iint)
> -				iint = integrity_iint_find(inode);
> +				iint = ima_iint_find(inode);
>  			/* IMA_MEASURE is set from reader side */
>  			if (iint && test_bit(IMA_MUST_MEASURE,
>  						&iint->atomic_flags))
> @@ -153,7 +153,7 @@ static void ima_rdwr_violation_check(struct file *file,
>  				  "invalid_pcr", "open_writers");
>  }
>  
> -static void ima_check_last_writer(struct integrity_iint_cache *iint,
> +static void ima_check_last_writer(struct ima_iint_cache *iint,
>  				  struct inode *inode, struct file *file)
>  {
>  	fmode_t mode = file->f_mode;
> @@ -192,12 +192,12 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>  static void ima_file_free(struct file *file)
>  {
>  	struct inode *inode = file_inode(file);
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>  		return;
>  
> -	iint = integrity_iint_find(inode);
> +	iint = ima_iint_find(inode);
>  	if (!iint)
>  		return;
>  
> @@ -209,7 +209,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  			       enum ima_hooks func)
>  {
>  	struct inode *backing_inode, *inode = file_inode(file);
> -	struct integrity_iint_cache *iint = NULL;
> +	struct ima_iint_cache *iint = NULL;
>  	struct ima_template_desc *template_desc = NULL;
>  	char *pathbuf = NULL;
>  	char filename[NAME_MAX];
> @@ -248,7 +248,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	inode_lock(inode);
>  
>  	if (action) {
> -		iint = integrity_inode_get(inode);
> +		iint = ima_inode_get(inode);
>  		if (!iint)
>  			rc = -ENOMEM;
>  	}
> @@ -564,11 +564,11 @@ static int ima_file_check(struct file *file, int mask)
>  static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
>  			    size_t buf_size)
>  {
> -	struct integrity_iint_cache *iint = NULL, tmp_iint;
> +	struct ima_iint_cache *iint = NULL, tmp_iint;
>  	int rc, hash_algo;
>  
>  	if (ima_policy_flag) {
> -		iint = integrity_iint_find(inode);
> +		iint = ima_iint_find(inode);
>  		if (iint)
>  			mutex_lock(&iint->mutex);
>  	}
> @@ -578,7 +578,6 @@ static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
>  			mutex_unlock(&iint->mutex);
>  
>  		memset(&tmp_iint, 0, sizeof(tmp_iint));
> -		tmp_iint.inode = inode;
>  		mutex_init(&tmp_iint.mutex);
>  
>  		rc = ima_collect_measurement(&tmp_iint, file, NULL, 0,
> @@ -688,7 +687,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>  				    struct inode *inode)
>  
>  {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	int must_appraise;
>  
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> @@ -700,7 +699,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>  		return;
>  
>  	/* Nothing to do if we can't allocate memory */
> -	iint = integrity_inode_get(inode);
> +	iint = ima_inode_get(inode);
>  	if (!iint)
>  		return;
>  
> @@ -719,7 +718,7 @@ static void ima_post_create_tmpfile(struct mnt_idmap *idmap,
>   */
>  static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>  {
> -	struct integrity_iint_cache *iint;
> +	struct ima_iint_cache *iint;
>  	struct inode *inode = dentry->d_inode;
>  	int must_appraise;
>  
> @@ -732,7 +731,7 @@ static void ima_post_path_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>  		return;
>  
>  	/* Nothing to do if we can't allocate memory */
> -	iint = integrity_inode_get(inode);
> +	iint = ima_inode_get(inode);
>  	if (!iint)
>  		return;
>  
> @@ -935,7 +934,7 @@ int process_buffer_measurement(struct mnt_idmap *idmap,
>  	int ret = 0;
>  	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry = NULL;
> -	struct integrity_iint_cache iint = {};
> +	struct ima_iint_cache iint = {};
>  	struct ima_event_data event_data = {.iint = &iint,
>  					    .filename = eventname,
>  					    .buf = buf,
> @@ -1168,6 +1167,7 @@ static struct security_hook_list ima_hooks[] __ro_after_init = {
>  #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
>  	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
>  #endif
> +	LSM_HOOK_INIT(inode_free_security, ima_inode_free),
>  };
>  
>  static const struct lsm_id ima_lsmid = {
> @@ -1177,15 +1177,21 @@ static const struct lsm_id ima_lsmid = {
>  
>  static int __init init_ima_lsm(void)
>  {
> +	ima_iintcache_init();
>  	security_add_hooks(ima_hooks, ARRAY_SIZE(ima_hooks), &ima_lsmid);
>  	init_ima_appraise_lsm(&ima_lsmid);
>  	return 0;
>  }
>  
> +struct lsm_blob_sizes ima_blob_sizes __ro_after_init = {
> +	.lbs_inode = sizeof(struct ima_iint_cache *),
> +};
> +
>  DEFINE_LSM(ima) = {
>  	.name = "ima",
>  	.init = init_ima_lsm,
>  	.order = LSM_ORDER_LAST,
> +	.blobs = &ima_blob_sizes,
>  };
>  
>  late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index f69062617754..c0556907c2e6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -49,7 +49,7 @@
>  #define DONT_HASH	0x0200
>  
>  #define INVALID_PCR(a) (((a) < 0) || \
> -	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
> +	(a) >= (sizeof_field(struct ima_iint_cache, measured_pcrs) * 8))
>  
>  int ima_policy_flag;
>  static int temp_ima_appraise;
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 7a97c269a072..671fc50255f9 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -20,59 +20,6 @@
>  #include <linux/audit.h>
>  #include <linux/lsm_hooks.h>
>  
> -/* iint action cache flags */
> -#define IMA_MEASURE		0x00000001
> -#define IMA_MEASURED		0x00000002
> -#define IMA_APPRAISE		0x00000004
> -#define IMA_APPRAISED		0x00000008
> -/*#define IMA_COLLECT		0x00000010  do not use this flag */
> -#define IMA_COLLECTED		0x00000020
> -#define IMA_AUDIT		0x00000040
> -#define IMA_AUDITED		0x00000080
> -#define IMA_HASH		0x00000100
> -#define IMA_HASHED		0x00000200
> -
> -/* iint policy rule cache flags */
> -#define IMA_NONACTION_FLAGS	0xff000000
> -#define IMA_DIGSIG_REQUIRED	0x01000000
> -#define IMA_PERMIT_DIRECTIO	0x02000000
> -#define IMA_NEW_FILE		0x04000000
> -#define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
> -#define IMA_MODSIG_ALLOWED	0x20000000
> -#define IMA_CHECK_BLACKLIST	0x40000000
> -#define IMA_VERITY_REQUIRED	0x80000000
> -
> -#define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
> -				 IMA_HASH | IMA_APPRAISE_SUBMASK)
> -#define IMA_DONE_MASK		(IMA_MEASURED | IMA_APPRAISED | IMA_AUDITED | \
> -				 IMA_HASHED | IMA_COLLECTED | \
> -				 IMA_APPRAISED_SUBMASK)
> -
> -/* iint subaction appraise cache flags */
> -#define IMA_FILE_APPRAISE	0x00001000
> -#define IMA_FILE_APPRAISED	0x00002000
> -#define IMA_MMAP_APPRAISE	0x00004000
> -#define IMA_MMAP_APPRAISED	0x00008000
> -#define IMA_BPRM_APPRAISE	0x00010000
> -#define IMA_BPRM_APPRAISED	0x00020000
> -#define IMA_READ_APPRAISE	0x00040000
> -#define IMA_READ_APPRAISED	0x00080000
> -#define IMA_CREDS_APPRAISE	0x00100000
> -#define IMA_CREDS_APPRAISED	0x00200000
> -#define IMA_APPRAISE_SUBMASK	(IMA_FILE_APPRAISE | IMA_MMAP_APPRAISE | \
> -				 IMA_BPRM_APPRAISE | IMA_READ_APPRAISE | \
> -				 IMA_CREDS_APPRAISE)
> -#define IMA_APPRAISED_SUBMASK	(IMA_FILE_APPRAISED | IMA_MMAP_APPRAISED | \
> -				 IMA_BPRM_APPRAISED | IMA_READ_APPRAISED | \
> -				 IMA_CREDS_APPRAISED)
> -
> -/* iint cache atomic_flags */
> -#define IMA_CHANGE_XATTR	0
> -#define IMA_UPDATE_XATTR	1
> -#define IMA_CHANGE_ATTR		2
> -#define IMA_DIGSIG		3
> -#define IMA_MUST_MEASURE	4
> -
>  enum evm_ima_xattr_type {
>  	IMA_XATTR_DIGEST = 0x01,
>  	EVM_XATTR_HMAC,

