Return-Path: <linux-fsdevel+bounces-31611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E00998E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EA9283DC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A619CC01;
	Thu, 10 Oct 2024 17:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PX1yUrgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96719AA6B
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 17:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728580703; cv=none; b=rcLkfop4zszlpEz6RGXBV+lTyN7ORPC1/2spfnLT1zJkZj7DsodWU5o8hISFrbCd/Hmsuqn0pLDJ5c9EYhoh9YTJXEhC+hIDy2z+HN+JAtedhF1bNPNKQWfHWBVZAZYTQNbz7QSbCBzvx5W+xAXaxrj5BTefU+Xybh7hbNxbMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728580703; c=relaxed/simple;
	bh=k4ocfSM32Uu5iHxIlkRlix8O3K1/N6TxZFColxYO5Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwAimoCj7UJmzsF7AFmcXIaZWIi4gReGSIqZiqy24ceNhnVty4SUciviDFiM+4sbtN2gfTIZnJJ1FDEucpzOxPrgUUO1XheWTV0S7Ym925AhdZ7Oo76Qw68tMkhDTE21TlrZCj6qjxq6EtBdWpxpxoEz/E2Ontl7cJSqXS8cdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=PX1yUrgd; arc=none smtp.client-ip=66.163.189.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728580698; bh=qGOop+O5c1WN7azHKlJ7v0Dq2Z18ZHWlDXNvZjBaYOg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=PX1yUrgduIisfL7QsFJ81+Y9lJPu66g4lzUoeaSlEB8ID6EA9zkn/MdT8rZUo1wJAfNbEDCrIgj8nSAfUvlZQiiyqCVl+XMdJhFZd60A0709g3R8gOI6UjGknpDek+JVL9JKR748qu6bBKCECMDFykh2NHVtQv5aRnQZcCM5nhaU5jNUfFWJ21msfnEzP3ZgssPqFxK8X0Up0WFsQIhSTl2WbsojOfH9UKV7rMHjyU4Mki+kSsYaw1BVLomONXyKxLhPVE1ORcB/dOtC+aHxPzbRJ10RWVWOJZ2j/lq3OYlWK1raX0vb6SBcOyUUZ2pPG281v5lRKCCNaLM45zbbsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1728580698; bh=N2is+iMa4GHpPRMi/DY6qNc7FRFCHh9afFmmmU10xW9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=NpTYMystC3GgpLpgBAtVpCMLD4B4rVFU9Cs8+ugNzBxU6r0wmwcY6S5NHDkfjIfjF7D3qRAK+jCZtTWeLdp8qzChBz8/JfDL5XDINZt8uV5yI/BdqJuVKNBRo32WcDwawlpvUMDyq8qOXkDL1L5j6FSFwgj1d12KDclm80Ngbov8zPJC4nj6E4dxC+qrduCh/3OBbcxlivYkZ7HkbaNfXTONyn2r3lM4Fj2NpzuIunyZIXcoilAaFwwYRupm7lf5vVuAgoeHU8VuWMz5AAsWGJ6BMPx8iSY9wj+yhyKCFPeINiA2SChqdfiMBgtNVEIepfbdkAb+d9XfeXq52qQJFg==
X-YMail-OSG: 4HatynAVM1k3rPgy7U6AgU1_garUFr63TGreVspZCvEBtQTnel3HY9XVMwNzbjH
 nxrgSM9SenXbvcw.QUR4RkuDrjHNkPDbzukqN8ev82nVrggFBH9I0TcVOv8XEo8DFEAaz6Qjirul
 5G1QsNLMfppx7hI.PztHFra0PkBBOn8vNxUJFVxi6VX2GUFY_QQD5dHVRHroBOQ0OBbU3zpd0Kq5
 6JiVc6.EjOUKUT_l5mY475mKYQ0PwqUvgtNqKOXgMY5P1H2XnkmF3eOS8jn8Vb1UXHPzVu5lcXqL
 CWDiADu.7tAtKLD2.XHIGIBug.Fyu2Q4aZsijm.stLLssMHlY7dmd2Go7KMNW.4Z5aJ9hYnWC96z
 Tz9d7fScL6qg2sC1MDBft5QT8ExwycNqhNkUCuaK0ail_6tAFmzPeTa0nYOE8c7nxZQcUk11pRp9
 pYuG16i1dcnHVZ2QNUEmt8lstg1nv.gGLWLks0tkl7kiz2stZFAITBig_YA0UbUaRdYHkYnayCNB
 cjZXV7FvIse4OLeO7UwERRmu6xl2Lp_Va.tyab9OWj82r22hhwMSrcGI0PFBa6yv0JxCP9JbR5jj
 WCnWd8T4UbvV664hysqr1n5L.bTVa0K8PKcJR7RvWOoVDw2EKh2wkAUAu9dfYRa1fHd3qV_04fBF
 j_z_0.l1lAYxw0R1z53SNXEVG7Y30FmC0CCuCA.m2EU1pB6qnb9_49DBKoBIK5WUKj16f0LlNzcT
 Yz3hcJ_dsDT0TCkmv.W5SOWHpsVrGHwoSzaQHnLz4pP6dStMMIOD.DEnehqyBZhlUsFC.YBxjF2_
 zCK6LK71eNR4G8JVbdUGAgdVsnyQlqdS7l0u8ig5c.EX_QFQAlAdXAvY4hxifj0TNyV8VXEhvhJH
 v9s1gkt2YW4OECSu3XWB9xl_av8A7ueR3UhhVinL6GZU6GCBiY4CS44ewzsG5s9VuStlDIJ832RA
 uOR4XxyO.PaFjz5GqImxlOuh.vdk5qp03VaGP1TSC6yJ5i.UOPjJxS_Qre.ANtWAt5lIgp4e_Qo4
 qmS7w884dnGNFmnePcX_5YN6LziA8hOiNscrWJYhUlpu7Bkd5ZTWzZIvRyb.0S78cE5GMH5qfrRO
 w98eeBXaALY0eUysNyHJgjw1g0iR9SKlavTA4fXAcCVMaJ47h5lPEPP9HiF0fOemSxw3.fmqoQYH
 WPAGzKS_YZu_xYCwpyEgrN7GB9i7ntNXSorZKs9kc_a1wdeFj87uods4QVEHU.anvBct_0V6UeuB
 qM_Sv0upQ.Ud1ppWN_e6dIzlqmBDUmxrKf2X9DMh49vNCTF63_pcze0OqBO_peFtcW9wGDIv_Wrv
 xik3DdFh2BGhFj5sGi7BpugZ7mJNcQ0ofAB5lbk0xdEjn003p8AmOgR1GefRRpcFK8wKN.j0NIOy
 KbM.6g6EBeLGgbZ6Yn_NbJugQgPInK0M12q9D_gyp8ZSlwqYAwayST6PRh5jPgq83Qjl4ZiC1Jba
 8tcyXr02USrWTEouWFrcKxbUq2HGQZtENC4v0LEoM1YsgMRSBMVj3CRy3968F1T2lJElT994gFi1
 avCQkTBTgMcEomLgNOXTJYsG2O0eVLjZ4dIQa94TT_p8jeLygb4T6nllxTGY24dRq14FW6GEPXZq
 kdUvY5RYMx8Slyqnl_OY7mnpqRvOAMSxXi0I2e6Tf6dphGGshEXTmIrXjuxllNuDI4FQRgo.Q22R
 y5RrpAMMbD6el03khv3kGVyEOtITAI.8SUeS8SLWkUVRRvVf_BEGEgW8Yx.5VAUKWdI6TI_cDHun
 1R8R5JgdSiI95nLWvXmKULPZMenNDvCkUetkT1AckwloGhbjYDaT7duROnWTDF8LVrQTq2xqYlkF
 myGt4Q4bDy7.jJLFy6gG9J9dW9KxxatT_iL8CiLM3zYnHMiw1AMDIdN7e3wSKuB6sjWVkDvJ0v4D
 uXwdMYalKa_L1mDMjG_Win8uxLNcuC8MxpqxGqip4iXSdxGrsTE6NQK1MHmwOXBz0c0koIHEfu7G
 23sV7UFHloYI5zFm2lwl2tbnQvugBrJwTBemHDVsw6triZXAsOEPkkA4eMSbukUcugb8Cb.m_.so
 X0yD097FY_gAkUT.vL.pg1y3.5C8nOhah6w61VXsiwc0Tj4zHgVQ9HAMmlg.QU_tQL..Py3PsHl7
 ZMP2tN93GLg4bAK2qT5HOhy5nJAgu558hr7aBZHg4fRTv35rG1xPbv5rdPOYc_mOSChT2HhN5ziV
 Op8gkU7xdmFio2jEPoVuF.62c3NQCAhJPOZiY2gag0f33ymK86.Pj3aaQzbjNnszAjV7C3kcSQgI
 2BxY7uMCc8tz8Rh1yM.pcI2kcJIPY8qiH.vHh5Q--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 02fa1b19-b555-450e-b151-307c32e4bb8f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Oct 2024 17:18:18 +0000
Received: by hermes--production-gq1-5d95dc458-xmcnd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f1539127b9d4bcac1c0a489b6658d603;
          Thu, 10 Oct 2024 17:18:12 +0000 (UTC)
Message-ID: <c8e4d6ee-7258-47a8-ac87-f23cd3afd121@schaufler-ca.com>
Date: Thu, 10 Oct 2024 10:18:11 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 6/7] smack: Fix inode numbers in logs
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-6-mic@digikod.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241010152649.849254-6-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 10/10/2024 8:26 AM, Mickaël Salaün wrote:
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/smack/smack_lsm.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 370fd594da12..0be7e442e70f 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -199,8 +199,8 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> -			inode->i_sb->s_id, inode->i_ino, current->comm);
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
> +			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
>  
>  	if (rc <= 0)
>  		return rc;
> @@ -212,9 +212,9 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
>  
>  	smk_bu_mode(mode, acc);
>  
> -	pr_info("Smack %s: (%s %s %s) inode=(%s %ld) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) inode=(%s %llu) %s\n", smk_bu_mess[rc],
>  		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
> -		inode->i_sb->s_id, inode->i_ino, current->comm);
> +		inode->i_sb->s_id, inode_get_ino(inode), current->comm);
>  	return 0;
>  }
>  #else
> @@ -231,8 +231,8 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> -			inode->i_sb->s_id, inode->i_ino, current->comm);
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
> +			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
>  
>  	if (rc <= 0)
>  		return rc;
> @@ -240,9 +240,9 @@ static int smk_bu_file(struct file *file, int mode, int rc)
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
> -		inode->i_sb->s_id, inode->i_ino, file,
> +		inode->i_sb->s_id, inode_get_ino(inode), file,
>  		current->comm);
>  	return 0;
>  }
> @@ -261,8 +261,8 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  
>  	if (isp->smk_flags & SMK_INODE_IMPURE)
> -		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
> -			inode->i_sb->s_id, inode->i_ino, current->comm);
> +		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
> +			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
>  
>  	if (rc <= 0)
>  		return rc;
> @@ -270,9 +270,9 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
>  		rc = 0;
>  
>  	smk_bu_mode(mode, acc);
> -	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
> +	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
>  		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
> -		inode->i_sb->s_id, inode->i_ino, file,
> +		inode->i_sb->s_id, inode_get_ino(inode), file,
>  		current->comm);
>  	return 0;
>  }

