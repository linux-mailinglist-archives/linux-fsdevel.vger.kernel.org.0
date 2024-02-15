Return-Path: <linux-fsdevel+bounces-11730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36EB85693A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB90283DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46268139568;
	Thu, 15 Feb 2024 16:10:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63612BF03;
	Thu, 15 Feb 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013402; cv=none; b=eLwqsw6/Pv9qTDEaNz9naSBRbff4mNWBxc+xyLr7Z0tprpHvP0JTqQJy928CpEpQE+OfQa09nsNn63FLQemAuQgSM4W6N9kt5XDugKmQqK0LNRA5HQCX0jwYhFHw1I+4MtWyX54nzAdxndeI3Xew8qp3qJeCsC4ASDAR33/Fllw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013402; c=relaxed/simple;
	bh=pyvdhz1r+1+9rk40dW1W5zr/3iw6uq3t0sJFZ+8ErU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FpAyjXkEW16bjb4kTO6FXEoOQRqaHpYWf7YwaxcPBWBX0We3UsXEeVkOlmrRRHDN6oEt5g+XlSpvY/ejEKDGPflYoFhf55uMXdfF4giCkRctPE6BL1fzIN1XoxiJLByAhU0Nn2GU1hQsqX14TOHZxEdDPvvNh1dNiHrHerqkxMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TbKKD1yqNz9xw3n;
	Thu, 15 Feb 2024 23:50:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D156E140A92;
	Fri, 16 Feb 2024 00:09:40 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD37xg0N85lztGQAg--.15724S2;
	Thu, 15 Feb 2024 17:09:40 +0100 (CET)
Message-ID: <09d6fa08e2d62720759f57237043a2dd9b5208ca.camel@huaweicloud.com>
Subject: Re: [PATCH v10 19/25] integrity: Move
 integrity_kernel_module_request() to IMA
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
 kolga@netapp.com,  Dai.Ngo@oracle.com, tom@talpey.com, paul@paul-moore.com,
 jmorris@namei.org,  serge@hallyn.com, zohar@linux.ibm.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, dhowells@redhat.com,
 jarkko@kernel.org,  stephen.smalley.work@gmail.com, omosnace@redhat.com,
 casey@schaufler-ca.com,  shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu
	 <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 15 Feb 2024 17:09:20 +0100
In-Reply-To: <20240215103113.2369171-20-roberto.sassu@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
	 <20240215103113.2369171-20-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD37xg0N85lztGQAg--.15724S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WrWDCr1DAw4fZry5Jr1rXrb_yoWxCw47pa
	yDKFZ8AryxAr9rCaykJF13uFWFg3yfGrW7WwsxGr1fGFsI9r4qvr47XF13XryfurWrJr1F
	grs2qr1akw1Dt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
	aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5ZjCwABsG

On Thu, 2024-02-15 at 11:31 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> In preparation for removing the 'integrity' LSM, move
> integrity_kernel_module_request() to IMA, and rename it to
> ima_kernel_module_request(). Rewrite the function documentation, to expla=
in
> better what the problem is.
>=20
> Compile it conditionally if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled,
> and call it from security.c (removed afterwards with the move of IMA to t=
he
> LSM infrastructure).
>=20
> Adding this hook cannot be avoided, since IMA has no control on the flags
> passed to crypto_alloc_sig() in public_key_verify_signature(), and thus
> cannot pass CRYPTO_NOLOAD, which solved the problem for EVM hashing with
> commit e2861fa71641 ("evm: Don't deadlock if a crypto algorithm is
> unavailable").
>=20
> EVM alone does not need to implement this hook, first because there is no
> mutex to deadlock, and second because even if it had it, there should be =
a
> recursive call. However, since verification from EVM can be initiated onl=
y
> by setting inode metadata, deadlock would occur if modprobe would do the
> same while loading a kernel module (which is unlikely).
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>

I hope the change of the ima_kernel_module_request() documentation is
fine for everyone.

If not, let me know.

Thanks

Roberto

> ---
>  include/linux/ima.h                    | 10 ++++++++
>  include/linux/integrity.h              | 13 ----------
>  security/integrity/digsig_asymmetric.c | 23 ------------------
>  security/integrity/ima/ima_main.c      | 33 ++++++++++++++++++++++++++
>  security/security.c                    |  2 +-
>  5 files changed, 44 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 31ef6c3c3207..0f9af283cbc8 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -256,4 +256,14 @@ static inline bool ima_appraise_signature(enum kerne=
l_read_file_id func)
>  	return false;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
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
>  #endif /* _LINUX_IMA_H */
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2ea0f2f65ab6..ef0f63ef5ebc 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -42,17 +42,4 @@ static inline void integrity_load_keys(void)
>  }
>  #endif /* CONFIG_INTEGRITY */
> =20
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
>  #endif /* _LINUX_INTEGRITY_H */
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/=
digsig_asymmetric.c
> index 895f4b9ce8c6..de603cf42ac7 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -132,26 +132,3 @@ int asymmetric_verify(struct key *keyring, const cha=
r *sig,
>  	pr_debug("%s() =3D %d\n", __func__, ret);
>  	return ret;
>  }
> -
> -/**
> - * integrity_kernel_module_request - prevent crypto-pkcs1pad(rsa,*) requ=
ests
> - * @kmod_name: kernel module name
> - *
> - * We have situation, when public_key_verify_signature() in case of RSA
> - * algorithm use alg_name to store internal information in order to
> - * construct an algorithm on the fly, but crypto_larval_lookup() will tr=
y
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
> -	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) =3D=3D 0)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 02021ee467d3..3891b83efdb3 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1091,6 +1091,39 @@ int ima_measure_critical_data(const char *event_la=
bel,
>  }
>  EXPORT_SYMBOL_GPL(ima_measure_critical_data);
> =20
> +#ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
> +
> +/**
> + * ima_kernel_module_request - Prevent crypto-pkcs1pad(rsa,*) requests
> + * @kmod_name: kernel module name
> + *
> + * Avoid a verification loop where verifying the signature of the modpro=
be
> + * binary requires executing modprobe itself. Since the modprobe iint->m=
utex
> + * is already held when the signature verification is performed, a deadl=
ock
> + * occurs as soon as modprobe is executed within the critical region, si=
nce
> + * the same lock cannot be taken again.
> + *
> + * This happens when public_key_verify_signature(), in case of RSA algor=
ithm,
> + * use alg_name to store internal information in order to construct an
> + * algorithm on the fly, but crypto_larval_lookup() will try to use alg_=
name
> + * in order to load a kernel module with same name.
> + *
> + * Since we don't have any real "crypto-pkcs1pad(rsa,*)" kernel modules,
> + * we are safe to fail such module request from crypto_larval_lookup(), =
and
> + * avoid the verification loop.
> + *
> + * Return: Zero if it is safe to load the kernel module, -EINVAL otherwi=
se.
> + */
> +int ima_kernel_module_request(char *kmod_name)
> +{
> +	if (strncmp(kmod_name, "crypto-pkcs1pad(rsa,", 20) =3D=3D 0)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/security.c b/security/security.c
> index f8d9ebeb4c31..48dc3db4c834 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3250,7 +3250,7 @@ int security_kernel_module_request(char *kmod_name)
>  	ret =3D call_int_hook(kernel_module_request, 0, kmod_name);
>  	if (ret)
>  		return ret;
> -	return integrity_kernel_module_request(kmod_name);
> +	return ima_kernel_module_request(kmod_name);
>  }
> =20
>  /**


