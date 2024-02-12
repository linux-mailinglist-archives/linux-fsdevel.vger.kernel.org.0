Return-Path: <linux-fsdevel+bounces-11173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B9851BF8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0528AB21FDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77423F9FD;
	Mon, 12 Feb 2024 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nsrl8yIb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114913E49E;
	Mon, 12 Feb 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760128; cv=none; b=gxpCgRPH6himCzoyasBsu73DWcCxshq6XLhE7Og95nsgOWR0sIlU42oe8qbm6rIuZNrSu3yFI8k4TsIPp7dXaq6aOyUyGZx+WEC27emeYQ6AHLsJChde1ERz3i6V1EzuHPAmDSqr9pleAVT3cjMaIUjRcoX6T85TzBv50j9Wc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760128; c=relaxed/simple;
	bh=fg208aqq/dk9zqQHNCp4uzls8PkYl7qxboWUqwuQpQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaBWwwXZtH0nECm6GSe7E/LH1CXD2fZY/mBxx0G3MUOPOMk4QTmX8+8LhnWEaa1ri6A0OPLAnr71SBftO4nhrBNtGQBeNE8Ne603uE4ylIPfU9kMdbVYMqfhJGLJu19lxVFMvMJ3Cb8SSBiH10JRERgCmuA/b9RWr0bflGntU8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nsrl8yIb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CHgrrb019260;
	Mon, 12 Feb 2024 17:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fJVNv/6nZjWeb7KILVPEur4+gl0mUhLZHgPunP6732g=;
 b=nsrl8yIblo/4b4jgIGYcob76ZTrOiuPBgqKmENaL3i9++PU5lXKpSGtaxj6ocdbKwq3f
 pD4Y7ripUyoZ0n/RIc7Syth+DdsPTHecTY72ZuWjovSZ2jKlNRn/UkYiinvryGwsPbT8
 HU/pF2sK/zbDVz0uWAw/z5Z+BDdvRnNFyQ1MfhRqMZGdasgdhv8fkKy17GYBAdeHBEJF
 H/+dt7+Gbix8RU4J//AhNcnufTBlUlN/F/58yYoyk25A3W3ji6NJtbp91NxGiNJEx3/t
 lh692v+RrvllD4ARBqiZRFuT3tagOt314C1qP8NDfX+b7Av0kn80cMrG5jVAqC/w7Y/X pA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qyng4vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:48:09 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CHhJ25020005;
	Mon, 12 Feb 2024 17:48:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7qyng4td-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:48:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CGSUOs024878;
	Mon, 12 Feb 2024 17:37:29 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp200h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 17:37:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CHbQED43123078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 17:37:28 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B22FC58061;
	Mon, 12 Feb 2024 17:37:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C1C95805E;
	Mon, 12 Feb 2024 17:37:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 17:37:20 +0000 (GMT)
Message-ID: <fd6ddc3d-e5d3-4b9c-b00b-ac2b1f22d653@linux.ibm.com>
Date: Mon, 12 Feb 2024 12:37:20 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-20-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EjolkXjCCnV6IXr0rLl_iQi_aPKLzovk
X-Proofpoint-ORIG-GUID: FcZAfoeYEX1DkXNqmP6J6TNlDhQJioeb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_14,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120135



On 1/15/24 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for removing the 'integrity' LSM, move
> integrity_kernel_module_request() to IMA, and rename it to
> ima_kernel_module_request().
> 
> Compile it conditionally if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled,
> and call it from security.c (removed afterwards with the move of IMA to the
> LSM infrastructure).
> 
> Adding this hook cannot be avoided, since IMA has no control on the flags
> passed to crypto_alloc_sig() in public_key_verify_signature(), and thus
> cannot pass CRYPTO_NOLOAD, which solved the problem for EVM hashing with
> commit e2861fa71641 ("evm: Don't deadlock if a crypto algorithm is
> unavailable").
> 
> EVM alone does not need to implement this hook, first because there is no
> mutex to deadlock, and second because even if it had it, there should be a
> recursive call. However, since verification from EVM can be initiated only
> by setting inode metadata, deadlock would occur if modprobe would do the
> same while loading a kernel module (which is unlikely).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   include/linux/ima.h                    | 10 +++++++++
>   include/linux/integrity.h              | 13 ------------
>   security/integrity/digsig_asymmetric.c | 23 --------------------
>   security/integrity/ima/ima_main.c      | 29 ++++++++++++++++++++++++++
>   security/security.c                    |  2 +-
>   5 files changed, 40 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 31ef6c3c3207..0f9af283cbc8 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -256,4 +256,14 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
>   	return false;
>   }
>   #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +#if defined(CONFIG_IMA) && defined(CONFIG_INTEGRITY_ASYMMETRIC_KEYS)
> +extern int ima_kernel_module_request(char *kmod_name);
> +#else
> +static inline int ima_kernel_module_request(char *kmod_name)
> +{
> +	return 0;
> +}
> +
> +#endif
>   #endif /* _LINUX_IMA_H */
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2ea0f2f65ab6..ef0f63ef5ebc 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -42,17 +42,4 @@ static inline void integrity_load_keys(void)
>   }
>   #endif /* CONFIG_INTEGRITY */
>   
> -#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> -
> -extern int integrity_kernel_module_request(char *kmod_name);
> -
> -#else
> -
> -static inline int integrity_kernel_module_request(char *kmod_name)
> -{
> -	return 0;
> -}
> -
> -#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> -
>   #endif /* _LINUX_INTEGRITY_H */
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index 895f4b9ce8c6..de603cf42ac7 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -132,26 +132,3 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>   	pr_debug("%s() = %d\n", __func__, ret);
>   	return ret;
>   }
> -
> -/**
> - * integrity_kernel_module_request - prevent crypto-pkcs1pad(rsa,*) requests
> - * @kmod_name: kernel module name
> - *
> - * We have situation, when public_key_verify_signature() in case of RSA
> - * algorithm use alg_name to store internal information in order to
> - * construct an algorithm on the fly, but crypto_larval_lookup() will try
> - * to use alg_name in order to load kernel module with same name.
> - * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
> - * we are safe to fail such module request from crypto_larval_lookup().
> - *
> - * In this way we prevent modprobe execution during digsig verification
> - * and avoid possible deadlock if modprobe and/or it's dependencies
> - * also signed with digsig.
> - */
> -int integrity_kernel_module_request(char *kmod_name)
> -{
> -	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 02021ee467d3..908fa026ec58 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1091,6 +1091,35 @@ int ima_measure_critical_data(const char *event_label,
>   }
>   EXPORT_SYMBOL_GPL(ima_measure_critical_data);
>   
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +
> +/**
> + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
> + * @kmod_name: kernel module name
> + *
> + * We have situation, when public_key_verify_signature() in case of RSA > + * algorithm use alg_name to store internal information in order to
> + * construct an algorithm on the fly, but crypto_larval_lookup() will try
> + * to use alg_name in order to load kernel module with same name.
> + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
> + * we are safe to fail such module request from crypto_larval_lookup().
> + *
> + * In this way we prevent modprobe execution during digsig verification
> + * and avoid possible deadlock if modprobe and/or it's dependencies
> + * also signed with digsig.

This text needs to some reformulation at some point..

> + *
> + * Return: Zero if it is safe to load the kernel module, -EINVAL otherwise.
> + */
> +int ima_kernel_module_request(char *kmod_name)
> +{
> +	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) == 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> +
>   static int __init init_ima(void)
>   {
>   	int error;
> diff --git a/security/security.c b/security/security.c
> index d2a1226e6e69..6c6571a141a1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3255,7 +3255,7 @@ int security_kernel_module_request(char *kmod_name)
>   	ret = call_int_hook(kernel_module_request, 0, kmod_name);
>   	if (ret)
>   		return ret;
> -	return integrity_kernel_module_request(kmod_name);
> +	return ima_kernel_module_request(kmod_name);
>   }
>   
>   /**

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

