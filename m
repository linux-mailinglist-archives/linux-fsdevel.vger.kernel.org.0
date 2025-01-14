Return-Path: <linux-fsdevel+bounces-39136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1368A107FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36891888DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF675236ED8;
	Tue, 14 Jan 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jHTCj2eR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A4232454;
	Tue, 14 Jan 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861766; cv=none; b=uKVunnLKXcy/jjGUforiZG+5ih/hf7Ea/mbbRsFJu4a57w93auP11V48g6U1rQCpaE/M+M/JQU97sFNxIhushFI4PP/nU0yXkNaDSq9zolQQcc5UFy2StscuLr1Wmu+h46dw2BncRXwv7s++9UPe2PKqM3H58Cw85h2D7hb3cJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861766; c=relaxed/simple;
	bh=avibWBzzYlVJuJNsyxPVWE3qJgJLyOxk08sKoQLXxdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gTbwjZO2lU31zpJzEPCCJxytrFwKw9iWSQemw5qO/OahcV2Wo/kd78sdJBKTxoT8o/F77b5f6Xbo57C1FSRFP5WGzmuBHa1AGY2FNWRyjwfD8F5gKt7TnEV7N++iruttxnMcXnVT0sBLeqeN79MxYGk7cZJuuzTFdz5UXfrFAO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jHTCj2eR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EDUskV031385;
	Tue, 14 Jan 2025 13:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5J44fg
	WG2g28SUw2UDmVWWHkV8cQ+6akBsC3mlxe5BE=; b=jHTCj2eR3VfCjH2/Y4Jqce
	3EGxuifb0Y+4Jx1NMBU84xAAxJaSp8f0KaPIrVM7+VH/Y768msBs6BlUEUEOCkoo
	4m205p+IyA/J90cUJxw/VLxnjZSNcfGbAlzur60WUXwBTGXrb/zTrxFYREeGvhLR
	1R64vYBkM111ky+j6cokwrcalU+etBLO0BOLqc+J2LoXQog4txpiuZGu9KtX4uHL
	8KtTMm/LOxo4BDRbIhapDsKoqdc5cDnCwaAcjDR/UfANotbXePgCxijgah0xlbT9
	PyM6rCLw6rjohY76Mo5p1nDP3IbHGk98XRCVUoGSk5GbgEN9JMnm21eq5y4cbisg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2stv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:35:35 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EDZYOa021414;
	Tue, 14 Jan 2025 13:35:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445cnb2sts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:35:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50E9xFf1017014;
	Tue, 14 Jan 2025 13:35:33 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk38p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:35:33 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EDZXfu64815492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 13:35:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D52358059;
	Tue, 14 Jan 2025 13:35:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25A2858043;
	Tue, 14 Jan 2025 13:35:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.110.183])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 13:35:31 +0000 (GMT)
Message-ID: <5bd0ab00a006c5dbbe62f9c5e43a722db05f8e49.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/7] ima: Remove inode lock
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, jack@suse.cz, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date: Tue, 14 Jan 2025 08:35:30 -0500
In-Reply-To: <20241128100621.461743-3-roberto.sassu@huaweicloud.com>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
	 <20241128100621.461743-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VCNFpYBBhbVcRt1IWZYrDzvQZ0DODHlT
X-Proofpoint-GUID: MHHAf5tYYYN6dYz9Uoh06FgBjH3xb3DM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140111

On Thu, 2024-11-28 at 11:06 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Move out the mutex in the ima_iint_cache structure to a new structure
> called ima_iint_cache_lock, so that a lock can be taken regardless of
> whether or not inode integrity metadata are stored in the inode.
>=20
> Introduce ima_inode_security() to retrieve the ima_iint_cache_lock
> structure, if inode i_security is not NULL, and consequently remove
> ima_inode_get_iint() and ima_inode_set_iint(), since the ima_iint_cache
> structure can be read and modified from the new structure.
>=20
> Move the mutex initialization and annotation in the new function
> ima_inode_alloc_security() and introduce ima_iint_lock() and
> ima_iint_unlock() to respectively lock and unlock the mutex.
>=20
> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, an=
d
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 31 +++=
+-------
> =C2=A0security/integrity/ima/ima_api.c=C2=A0 |=C2=A0 4 +-
> =C2=A0security/integrity/ima/ima_iint.c | 92 ++++++++++++++++++++++++++--=
---
> =C2=A0security/integrity/ima/ima_main.c | 39 ++++++-------
> =C2=A04 files changed, 109 insertions(+), 57 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 3f1a82b7cd71..b4eeab48f08a 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -182,7 +182,6 @@ struct ima_kexec_hdr {
> =C2=A0
> =C2=A0/* IMA integrity metadata associated with an inode */
> =C2=A0struct ima_iint_cache {
> -	struct mutex mutex;	/* protects: version, flags, digest */
> =C2=A0	struct integrity_inode_attributes real_inode;
> =C2=A0	unsigned long flags;
> =C2=A0	unsigned long measured_pcrs;
> @@ -195,35 +194,27 @@ struct ima_iint_cache {
> =C2=A0	struct ima_digest_data *ima_hash;
> =C2=A0};
> =C2=A0
> +struct ima_iint_cache_lock {
> +	struct mutex mutex;	/* protects: iint version, flags, digest */
> +	struct ima_iint_cache *iint;
> +};
> +
> =C2=A0extern struct lsm_blob_sizes ima_blob_sizes;
> =C2=A0
> -static inline struct ima_iint_cache *
> -ima_inode_get_iint(const struct inode *inode)
> +static inline struct ima_iint_cache_lock *ima_inode_security(void *i_sec=
urity)
> =C2=A0{

Is there a reason for naming the function ima_inode_security() and passing
i_security, when the other LSMs name it <lsm>_inode() and pass the inode?

static inline struct inode_smack *smack_inode(const struct inode *inode)
static inline struct inode_security_struct *selinux_inode(const struct inod=
e *inode)
static inline struct landlock_inode_security *landlock_inode(const struct i=
node
*const inode)

Mimi


> -	struct ima_iint_cache **iint_sec;
> -
> -	if (unlikely(!inode->i_security))
> +	if (unlikely(!i_security))
> =C2=A0		return NULL;
> =C2=A0
> -	iint_sec =3D inode->i_security + ima_blob_sizes.lbs_inode;
> -	return *iint_sec;
> -}
> -
> -static inline void ima_inode_set_iint(const struct inode *inode,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ima_iint_cache *iint)
> -{
> -	struct ima_iint_cache **iint_sec;
> -
> -	if (unlikely(!inode->i_security))
> -		return;
> -
> -	iint_sec =3D inode->i_security + ima_blob_sizes.lbs_inode;
> -	*iint_sec =3D iint;
> +	return i_security + ima_blob_sizes.lbs_inode;
> =C2=A0}
> =C2=A0
> =C2=A0struct ima_iint_cache *ima_iint_find(struct inode *inode);
> =C2=A0struct ima_iint_cache *ima_inode_get(struct inode *inode);
> +int ima_inode_alloc_security(struct inode *inode);
> =C2=A0void ima_inode_free_rcu(void *inode_security);
> +void ima_iint_lock(struct inode *inode);
> +void ima_iint_unlock(struct inode *inode);
> =C2=A0void __init ima_iintcache_init(void);
> =C2=A0
> =C2=A0extern const int read_idmap[];
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 984e861f6e33..37c2a228f0e1 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -234,7 +234,7 @@ static bool ima_get_verity_digest(struct ima_iint_cac=
he *iint,
> =C2=A0 * Calculate the file hash, if it doesn't already exist,
> =C2=A0 * storing the measurement and i_version in the iint.
> =C2=A0 *
> - * Must be called with iint->mutex held.
> + * Must be called with iint mutex held.
> =C2=A0 *
> =C2=A0 * Return 0 on success, error code otherwise
> =C2=A0 */
> @@ -343,7 +343,7 @@ int ima_collect_measurement(struct ima_iint_cache *ii=
nt, struct
> file *file,
> =C2=A0 *	- the inode was previously flushed as well as the iint info,
> =C2=A0 *	=C2=A0 containing the hashing info.
> =C2=A0 *
> - * Must be called with iint->mutex held.
> + * Must be called with iint mutex held.
> =C2=A0 */
> =C2=A0void ima_store_measurement(struct ima_iint_cache *iint, struct file=
 *file,
> =C2=A0			=C2=A0=C2=A0 const unsigned char *filename,
> diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/i=
ma_iint.c
> index 9d9fc7a911ad..dcc32483d29f 100644
> --- a/security/integrity/ima/ima_iint.c
> +++ b/security/integrity/ima/ima_iint.c
> @@ -26,7 +26,13 @@ static struct kmem_cache *ima_iint_cache __ro_after_in=
it;
> =C2=A0 */
> =C2=A0struct ima_iint_cache *ima_iint_find(struct inode *inode)
> =C2=A0{
> -	return ima_inode_get_iint(inode);
> +	struct ima_iint_cache_lock *iint_lock;
> +
> +	iint_lock =3D ima_inode_security(inode->i_security);
> +	if (!iint_lock)
> +		return NULL;
> +
> +	return iint_lock->iint;
> =C2=A0}
> =C2=A0
> =C2=A0#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH + 1)
> @@ -37,18 +43,18 @@ struct ima_iint_cache *ima_iint_find(struct inode *in=
ode)
> =C2=A0 * mutex to avoid lockdep false positives related to IMA + overlayf=
s.
> =C2=A0 * See ovl_lockdep_annotate_inode_mutex_key() for more details.
> =C2=A0 */
> -static inline void ima_iint_lockdep_annotate(struct ima_iint_cache *iint=
,
> -					=C2=A0=C2=A0=C2=A0=C2=A0 struct inode *inode)
> +static inline void ima_iint_lock_lockdep_annotate(struct mutex *mutex,
> +						=C2=A0 struct inode *inode)
> =C2=A0{
> =C2=A0#ifdef CONFIG_LOCKDEP
> -	static struct lock_class_key ima_iint_mutex_key[IMA_MAX_NESTING];
> +	static struct lock_class_key ima_iint_lock_mutex_key[IMA_MAX_NESTING];
> =C2=A0
> =C2=A0	int depth =3D inode->i_sb->s_stack_depth;
> =C2=A0
> =C2=A0	if (WARN_ON_ONCE(depth < 0 || depth >=3D IMA_MAX_NESTING))
> =C2=A0		depth =3D 0;
> =C2=A0
> -	lockdep_set_class(&iint->mutex, &ima_iint_mutex_key[depth]);
> +	lockdep_set_class(mutex, &ima_iint_lock_mutex_key[depth]);
> =C2=A0#endif
> =C2=A0}
> =C2=A0
> @@ -65,14 +71,11 @@ static void ima_iint_init_always(struct ima_iint_cach=
e *iint,
> =C2=A0	iint->ima_read_status =3D INTEGRITY_UNKNOWN;
> =C2=A0	iint->ima_creds_status =3D INTEGRITY_UNKNOWN;
> =C2=A0	iint->measured_pcrs =3D 0;
> -	mutex_init(&iint->mutex);
> -	ima_iint_lockdep_annotate(iint, inode);
> =C2=A0}
> =C2=A0
> =C2=A0static void ima_iint_free(struct ima_iint_cache *iint)
> =C2=A0{
> =C2=A0	kfree(iint->ima_hash);
> -	mutex_destroy(&iint->mutex);
> =C2=A0	kmem_cache_free(ima_iint_cache, iint);
> =C2=A0}
> =C2=A0
> @@ -87,9 +90,14 @@ static void ima_iint_free(struct ima_iint_cache *iint)
> =C2=A0 */
> =C2=A0struct ima_iint_cache *ima_inode_get(struct inode *inode)
> =C2=A0{
> +	struct ima_iint_cache_lock *iint_lock;
> =C2=A0	struct ima_iint_cache *iint;
> =C2=A0
> -	iint =3D ima_iint_find(inode);
> +	iint_lock =3D ima_inode_security(inode->i_security);
> +	if (!iint_lock)
> +		return NULL;
> +
> +	iint =3D iint_lock->iint;
> =C2=A0	if (iint)
> =C2=A0		return iint;
> =C2=A0
> @@ -99,11 +107,31 @@ struct ima_iint_cache *ima_inode_get(struct inode *i=
node)
> =C2=A0
> =C2=A0	ima_iint_init_always(iint, inode);
> =C2=A0
> -	ima_inode_set_iint(inode, iint);
> +	iint_lock->iint =3D iint;
> =C2=A0
> =C2=A0	return iint;
> =C2=A0}
> =C2=A0
> +/**
> + * ima_inode_alloc_security - Called to init an inode
> + * @inode: Pointer to the inode
> + *
> + * Initialize and annotate the mutex in the ima_iint_cache_lock structur=
e.
> + *
> + * Return: Zero.
> + */
> +int ima_inode_alloc_security(struct inode *inode)
> +{
> +	struct ima_iint_cache_lock *iint_lock;
> +
> +	iint_lock =3D ima_inode_security(inode->i_security);
> +
> +	mutex_init(&iint_lock->mutex);
> +	ima_iint_lock_lockdep_annotate(&iint_lock->mutex, inode);
> +
> +	return 0;
> +}
> +
> =C2=A0/**
> =C2=A0 * ima_inode_free_rcu - Called to free an inode via a RCU callback
> =C2=A0 * @inode_security: The inode->i_security pointer
> @@ -112,10 +140,48 @@ struct ima_iint_cache *ima_inode_get(struct inode *=
inode)
> =C2=A0 */
> =C2=A0void ima_inode_free_rcu(void *inode_security)
> =C2=A0{
> -	struct ima_iint_cache **iint_p =3D inode_security +
> ima_blob_sizes.lbs_inode;
> +	struct ima_iint_cache_lock *iint_lock;
> +
> +	iint_lock =3D ima_inode_security(inode_security);
> +
> +	mutex_destroy(&iint_lock->mutex);
> +
> +	if (iint_lock->iint)
> +		ima_iint_free(iint_lock->iint);
> +}
> +
> +/**
> + * ima_iint_lock - Lock integrity metadata
> + * @inode: Pointer to the inode
> + *
> + * Lock integrity metadata.
> + */
> +void ima_iint_lock(struct inode *inode)
> +{
> +	struct ima_iint_cache_lock *iint_lock;
> +
> +	iint_lock =3D ima_inode_security(inode->i_security);
> +
> +	/* Only inodes with i_security are processed by IMA. */
> +	if (iint_lock)
> +		mutex_lock(&iint_lock->mutex);
> +}
> +
> +/**
> + * ima_iint_unlock - Unlock integrity metadata
> + * @inode: Pointer to the inode
> + *
> + * Unlock integrity metadata.
> + */
> +void ima_iint_unlock(struct inode *inode)
> +{
> +	struct ima_iint_cache_lock *iint_lock;
> +
> +	iint_lock =3D ima_inode_security(inode->i_security);
> =C2=A0
> -	if (*iint_p)
> -		ima_iint_free(*iint_p);
> +	/* Only inodes with i_security are processed by IMA. */
> +	if (iint_lock)
> +		mutex_unlock(&iint_lock->mutex);
> =C2=A0}
> =C2=A0
> =C2=A0static void ima_iint_init_once(void *foo)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cea0afbbc28d..05cfb04cd02b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -163,7 +163,7 @@ static void ima_check_last_writer(struct ima_iint_cac=
he *iint,
> =C2=A0	if (!(mode & FMODE_WRITE))
> =C2=A0		return;
> =C2=A0
> -	mutex_lock(&iint->mutex);
> +	ima_iint_lock(inode);
> =C2=A0	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
> =C2=A0		struct kstat stat;
> =C2=A0
> @@ -181,7 +181,7 @@ static void ima_check_last_writer(struct ima_iint_cac=
he *iint,
> =C2=A0				ima_update_xattr(iint, file);
> =C2=A0		}
> =C2=A0	}
> -	mutex_unlock(&iint->mutex);
> +	ima_iint_unlock(inode);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -247,7 +247,7 @@ static int process_measurement(struct file *file, con=
st struct
> cred *cred,
> =C2=A0	if (action & IMA_FILE_APPRAISE)
> =C2=A0		func =3D FILE_CHECK;
> =C2=A0
> -	inode_lock(inode);
> +	ima_iint_lock(inode);
> =C2=A0
> =C2=A0	if (action) {
> =C2=A0		iint =3D ima_inode_get(inode);
> @@ -259,15 +259,11 @@ static int process_measurement(struct file *file, c=
onst
> struct cred *cred,
> =C2=A0		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
> =C2=A0					 &pathbuf, &pathname, filename);
> =C2=A0
> -	inode_unlock(inode);
> -
> =C2=A0	if (rc)
> =C2=A0		goto out;
> =C2=A0	if (!action)
> =C2=A0		goto out;
> =C2=A0
> -	mutex_lock(&iint->mutex);
> -
> =C2=A0	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
> =C2=A0		/* reset appraisal flags if ima_inode_post_setattr was called */
> =C2=A0		iint->flags &=3D ~(IMA_APPRAISE | IMA_APPRAISED |
> @@ -412,10 +408,10 @@ static int process_measurement(struct file *file, c=
onst
> struct cred *cred,
> =C2=A0	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags=
) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 !(iint->flags & IMA_NEW_FILE))
> =C2=A0		rc =3D -EACCES;
> -	mutex_unlock(&iint->mutex);
> =C2=A0	kfree(xattr_value);
> =C2=A0	ima_free_modsig(modsig);
> =C2=A0out:
> +	ima_iint_unlock(inode);
> =C2=A0	if (pathbuf)
> =C2=A0		__putname(pathbuf);
> =C2=A0	if (must_appraise) {
> @@ -580,18 +576,13 @@ static int __ima_inode_hash(struct inode *inode, st=
ruct file
> *file, char *buf,
> =C2=A0	struct ima_iint_cache *iint =3D NULL, tmp_iint;
> =C2=A0	int rc, hash_algo;
> =C2=A0
> -	if (ima_policy_flag) {
> +	ima_iint_lock(inode);
> +
> +	if (ima_policy_flag)
> =C2=A0		iint =3D ima_iint_find(inode);
> -		if (iint)
> -			mutex_lock(&iint->mutex);
> -	}
> =C2=A0
> =C2=A0	if ((!iint || !(iint->flags & IMA_COLLECTED)) && file) {
> -		if (iint)
> -			mutex_unlock(&iint->mutex);
> -
> =C2=A0		memset(&tmp_iint, 0, sizeof(tmp_iint));
> -		mutex_init(&tmp_iint.mutex);
> =C2=A0
> =C2=A0		rc =3D ima_collect_measurement(&tmp_iint, file, NULL, 0,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 ima_hash_algo, NULL);
> @@ -600,22 +591,24 @@ static int __ima_inode_hash(struct inode *inode, st=
ruct file
> *file, char *buf,
> =C2=A0			if (rc !=3D -ENOMEM)
> =C2=A0				kfree(tmp_iint.ima_hash);
> =C2=A0
> +			ima_iint_unlock(inode);
> =C2=A0			return -EOPNOTSUPP;
> =C2=A0		}
> =C2=A0
> =C2=A0		iint =3D &tmp_iint;
> -		mutex_lock(&iint->mutex);
> =C2=A0	}
> =C2=A0
> -	if (!iint)
> +	if (!iint) {
> +		ima_iint_unlock(inode);
> =C2=A0		return -EOPNOTSUPP;
> +	}
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * ima_file_hash can be called when ima_collect_measurement has st=
ill
> =C2=A0	 * not been called, we might not always have a hash.
> =C2=A0	 */
> =C2=A0	if (!iint->ima_hash || !(iint->flags & IMA_COLLECTED)) {
> -		mutex_unlock(&iint->mutex);
> +		ima_iint_unlock(inode);
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
> =C2=A0
> @@ -626,11 +619,12 @@ static int __ima_inode_hash(struct inode *inode, st=
ruct file
> *file, char *buf,
> =C2=A0		memcpy(buf, iint->ima_hash->digest, copied_size);
> =C2=A0	}
> =C2=A0	hash_algo =3D iint->ima_hash->algo;
> -	mutex_unlock(&iint->mutex);
> =C2=A0
> =C2=A0	if (iint =3D=3D &tmp_iint)
> =C2=A0		kfree(iint->ima_hash);
> =C2=A0
> +	ima_iint_unlock(inode);
> +
> =C2=A0	return hash_algo;
> =C2=A0}
> =C2=A0
> @@ -1118,7 +1112,7 @@ EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> =C2=A0 * @kmod_name: kernel module name
> =C2=A0 *
> =C2=A0 * Avoid a verification loop where verifying the signature of the m=
odprobe
> - * binary requires executing modprobe itself. Since the modprobe iint->m=
utex
> + * binary requires executing modprobe itself. Since the modprobe iint mu=
tex
> =C2=A0 * is already held when the signature verification is performed, a =
deadlock
> =C2=A0 * occurs as soon as modprobe is executed within the critical regio=
n, since
> =C2=A0 * the same lock cannot be taken again.
> @@ -1193,6 +1187,7 @@ static struct security_hook_list ima_hooks[] __ro_a=
fter_init
> =3D {
> =C2=A0#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> =C2=A0	LSM_HOOK_INIT(kernel_module_request, ima_kernel_module_request),
> =C2=A0#endif
> +	LSM_HOOK_INIT(inode_alloc_security, ima_inode_alloc_security),
> =C2=A0	LSM_HOOK_INIT(inode_free_security_rcu, ima_inode_free_rcu),
> =C2=A0};
> =C2=A0
> @@ -1210,7 +1205,7 @@ static int __init init_ima_lsm(void)
> =C2=A0}
> =C2=A0
> =C2=A0struct lsm_blob_sizes ima_blob_sizes __ro_after_init =3D {
> -	.lbs_inode =3D sizeof(struct ima_iint_cache *),
> +	.lbs_inode =3D sizeof(struct ima_iint_cache_lock),
> =C2=A0};
> =C2=A0
> =C2=A0DEFINE_LSM(ima) =3D {


