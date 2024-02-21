Return-Path: <linux-fsdevel+bounces-12390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886685EC0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 23:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574C2B23FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3C3BB37;
	Wed, 21 Feb 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X1BGpO1C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FA93EA8E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555980; cv=none; b=qJLdXh327dTCMawwm0ap1eljVZy+K7XgOYZHpiZ2jw9OBqBzFTudZOfvpsGc1QcQpsZILP7CZtUdsgXe4dVsOAG/4X+CPHOBnxaho5+fYatuKK+04QEsZAiaxAqxe5hQi4jhyjN8SZVW9trPiwsScmBcb8s4p8rCTBY9YNx1jHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555980; c=relaxed/simple;
	bh=Rd6+5o8B1z7Uu8KRFhwIduy1ibyPyt60019HIsBYj9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKqDIwGJWhIw61VVW5kkcCNcq3QbF3NyDXGABQ7lX7N8N7dNZ+HL9e+QwACQIaeE1ov85PiWQRnTN3F2DaBzdLpku/YbWYVhbht3yrjLHru09f1JAJfSjQ320SElRY14wSMq9PoPGqww2t8Jet0U5G4LvMpxX8qjAU3qDoh95CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X1BGpO1C; arc=none smtp.client-ip=66.163.189.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708555976; bh=vQXRx63GUTpgFNFyiPicte7GlwliGyAPhXQerDd2nlQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=X1BGpO1C6ljjrxKfpIsSjK++ylZJ9PD2r3LuNSl/Di3kcL0cVYer0bUJyG2NbBRuuqINQvUq89knNeP/h2xV8QcmmAc2HDVRdIJKkP289Txm9Yy5JpEP5cUIBd56fbiCvKqAldb/gsKaoA7mrgu8YVq7b9KBKKjsWVd+ja5xeeLSq+/PUG+CZ0SD+opRBBwB1FfLuu31R2azALl7gDJyORNRANbljsFqNwG++OB9qGVeokbnKHDZrmBDRugGoe0Qsmme5f4yQpcYm0AS1Wiq5YVcwnKFXEqP0eH3J3uLZR9hE5kyuO1qZF8NwRiX7GFYGjsFjt5LVjRvFjDQhS+WzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1708555976; bh=iHjgd5k4Rr54g7F1RLDZXNmXNow+s+ZFi2yvQYIrbEC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=UkEmKRDyxG5D7yt8lEjITv9Ch5qpf/qXyPbrDABrFzUjfh4Y5fJiIm1R/Vh8GTL5shmXz3ms5uRJsYXLflHSV6KJsVE0DFFPxH6KsBPFnzu7bMLhrnqGNse5k5Ev7wzVpubGlQWvKX7eNZtJExYuEj4SEeqSRl0vgTU51gqQc1KVNtxeXzXT8sszvPvOYuFUvv1xLclytMhPIa8jkmBHPCHbpyqXRvpSN6ELt22WgmJAuWB1t+6HkF/sjWhX7kDbN6fYwWtAWVnBeCY6rq95u/iILbbsQqV3aztlxPFTOn4oubEZu+kt1JxXi1aKVdadFrXKaW0ReZuA3w+E3blksQ==
X-YMail-OSG: jttrBygVM1k0RetLrvq9CDs_aPXkmrNVZCk6fpmYdEkS23DD29Ye5y8NGleyXS5
 CplQ6u0EuREOrSQ9ia9_klav5E6PoiatBqbSKiGwVrK3Dft.lt0os2zL7gbk0RS3Gqn6SorT23Jc
 vL6joNfLCtgW5HQqpPKTlyciDJTXwr.GsHYKnKKVGi9MQcdnISANhkWbjIWQQN2ah2RS4kxfYGaO
 FdG_q7yss4TJlM_kNDe5oqAzSS0coX7Su8pqbC0ZgmTLaiV4dbjtUFOyfe_y4aOssvoNALQhccOI
 6KzvGCT15mrl1PEJx3rxY1DpWqveRPjJl1tuypTK_NaCnQAApnsihAZgzDhJJ9vpWoc_IWoLL8r.
 qcBgfqYfsLxjTN41NsjKpHNUeMW2hcoG0vUEz17RUGUC0y17gdGAlMgOQoRPI4gC4c2NT1FZtmSw
 lP4Mdd9KWbWFeMchfclmfz1VpBZWYEVfHTnnjjullL6qbpv7XOSGwVbHhPUo2DAtj_bW7T1g2KUq
 k0b2zszUrf0RpCrlO8XYnlghtCHk4WyMGnOdcZuBiA6idlstu1sZm666P3_6cSlNaCHh.d6WUQZE
 msMzeNMMqho8wJzbrRW697SHVXMIP4ymIgsLEQRChLgR5MbCwh0ytadjgozR.AbZXePnnpmTAJ14
 AL84yrtPAe3CW7tM57PpKKbApHAel.5bf3vWR7PH7PjWlQef2g4P6xnB23LgXuxadWdA1Xr1daXZ
 2ZbiI.FJd.m_c09fstmA_L0TMf1aQPKxGe4lOZaKmbMkRSKlTp6HLb6KQa3hC2djZknZwIIs8w5c
 .xkWOtdymmNSPcm4lt5imVrR9v47Xd2Pe_64UpmacBtyciJlWBRkw2pFNfyNcBOtZwneU_h3v1Nr
 H_EU7YMmy2cQlyO50HlwdeHErUsXolX_BQkI9Obnjln5MA_Dh9.D8lRXwGEVbX8LQdE_qNf55tLc
 VGWZJUBLElDQMnca2EpvPioVNw4uakDt0ZlXTTMk21hleGS3XT5Tz6N9j0NfH3172GxcqC.FzBy3
 nf2AAWayLYdUwviTHYt87fSqEK6jcv0ziFUzymstnv4Lsg6SF4RgausR4AGP1pD1C.whlxnYYieE
 MvlkBD6H2h280Y0_46ndqXIw.asNBt95ljA1HwMf9TudWS8511rsXLYNpLmPNkMNufld1oW6SwLV
 ZkLMifcs5XzspOLl1y49mmcuJDFEvYr4le3zb6Dg5Vm0y_DhSvC_G3zoxNSYx3XhE9J.zB787ux7
 p2Jldyp4ZkEX7e0TTRBYgob3FNsuIXIVKhcM4NLbgQzKfdJeZ8PTBFy5I5UU06dhOL6.1tBm_Qmp
 HSUWCRPrwDXx_0O1yBw2xvz4HF_tIWqnaM6dV.L7yXOEvhSvEOyE7.PhgEfMcN3UY42Sgh1oa8mj
 S2ayONKtxVBUmUMg06iXZkeftnRtIryi6njOifXLQOqB3eL6sIHsVnHpsBHaPU4YNI32Fs6GK3gu
 BSt2NJQL7IMwLXkMr1TsqpWD.nO2GWw8Da8hIjJbfHK76d0_kugXEoMT633.MdZ0sJqZ2.YkhEZi
 cgZsoxSs3v7BJXZYQDxqKsQ4Dq2dIBMDMfHjUuvIdLL6LO8tzKv0OkQj2e9RyeGZrkravNWVHKYT
 6BG2rCdXNaOM8JrCn1BSk2ruPE6siGlZlKDT.QRm4bvKdWZoJyCGxLfrAeisJRAxOrjr07ji02_E
 bLatttiBe719gKfg1l46Hxz19FFT79Z0EOj3VeHK2kx0NLcxhAqKl9y_Wu6b0bcHTdBy7JFAx1h3
 FzYDTVz4.uhU3J1EJYcxK9fUvObYdlg2zzmXI_xze43Sya2Y2iMyZ6e1jQwAjJeuMzW7ea_PGgaG
 sFgvn9l5sAHuPEf2wlYNGT2nHbto.C3xtuVOoTBtS6KObT8qtA.8yZWcySnCPPFpz3G3Yx2pNgD7
 g42m.qZX_Z.5blzlpHQ66.g0KMQ.6VmHiWo1gCufroWMqHiMoDeDXuMitE9.hMMd5QkUQVjtdAiM
 gCUPzUTQXQIhJyBuCenQWzKbLMIS38Ve9PRbqL.4fjuhe_QKoEfG.V3k7CZQbgoT4zDhegXUbCRw
 JcjottclNCZ1gtjxkRosLyUsD0vxW0Jd5zYM4PPPyGVeFvXoPA0kJkoJ6RrDR1Zm6JQkacq0kiQs
 LkhZ9rL9h7DQHjQfv0L.9p7fQ5bbr4TmumgKfF_vQLjMdQv8a7NYaRYrRJfr4HHGESNVzuqgcAjB
 fjDNnFMlNsJIRj7YoYydKE3h2tLwg75fCGIn4RfR4_888krYmZxG2EdTCNvk6ohGiwg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 19f325b7-7748-46c2-9c57-e750cb002b56
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Feb 2024 22:52:56 +0000
Received: by hermes--production-gq1-5c57879fdf-9nrfh (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 060ea49497017965d95d3a76dc76dbf6;
          Wed, 21 Feb 2024 22:52:54 +0000 (UTC)
Message-ID: <b14d41b6-547b-4a1d-b2b5-0bae11454482@schaufler-ca.com>
Date: Wed, 21 Feb 2024 14:52:50 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/25] smack: add hooks for fscaps operations
Content-Language: en-US
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, audit@vger.kernel.org,
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-13-3039364623bd@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-13-3039364623bd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/21/2024 1:24 PM, Seth Forshee (DigitalOcean) wrote:
> Add hooks for set/get/remove fscaps operations which perform the same
> checks as the xattr hooks would have done for XATTR_NAME_CAPS.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  security/smack/smack_lsm.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 0fdbf04cc258..1eaa89dede6b 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1530,6 +1530,74 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
>  	return rc;
>  }
>  
> +/**
> + * smack_inode_set_fscaps - Smack check for setting file capabilities
> + * @mnt_userns: the userns attached to the source mnt for this request
> + * @detry: the object
> + * @caps: the file capabilities
> + * @flags: unused
> + *
> + * Returns 0 if the access is permitted, or an error code otherwise.
> + */
> +static int smack_inode_set_fscaps(struct mnt_idmap *idmap,
> +				  struct dentry *dentry,
> +				  const struct vfs_caps *caps, int flags)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +	return rc;
> +}
> +
> +/**
> + * smack_inode_get_fscaps - Smack check for getting file capabilities
> + * @dentry: the object
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_get_fscaps(struct mnt_idmap *idmap,
> +				  struct dentry *dentry)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
> +	return rc;
> +}
> +
> +/**
> + * smack_inode_remove_acl - Smack check for removing file capabilities

s/smack_inode_remove_acl/smack_inode_remove_fscaps/

> + * @idmap: idmap of the mnt this request came from
> + * @dentry: the object
> + *
> + * Returns 0 if access is permitted, an error code otherwise
> + */
> +static int smack_inode_remove_fscaps(struct mnt_idmap *idmap,
> +				     struct dentry *dentry)
> +{
> +	struct smk_audit_info ad;
> +	int rc;
> +
> +	rc = cap_inode_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> +	if (rc != 0)
> +		return rc;
> +
> +	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
> +	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
> +
> +	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
> +	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
> +	return rc;
> +}
> +
>  /**
>   * smack_inode_getsecurity - get smack xattrs
>   * @idmap: idmap of the mount
> @@ -5045,6 +5113,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(inode_set_acl, smack_inode_set_acl),
>  	LSM_HOOK_INIT(inode_get_acl, smack_inode_get_acl),
>  	LSM_HOOK_INIT(inode_remove_acl, smack_inode_remove_acl),
> +	LSM_HOOK_INIT(inode_set_fscaps, smack_inode_set_fscaps),
> +	LSM_HOOK_INIT(inode_get_fscaps, smack_inode_get_fscaps),
> +	LSM_HOOK_INIT(inode_remove_fscaps, smack_inode_remove_fscaps),
>  	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
>  	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
>  	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),
>

