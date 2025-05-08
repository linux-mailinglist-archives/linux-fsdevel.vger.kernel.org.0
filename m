Return-Path: <linux-fsdevel+bounces-48466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3EAAF6BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB78F1BA6407
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A917262FF2;
	Thu,  8 May 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MZXuYfd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9862144A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746696552; cv=none; b=s8ViJB40dOQNWlSH+xTG+hy/VxhT9kLb3EkmIBM0v1Bnm4YaEbXxL+9QL29zKXERHvIkhvJogJMAADle2g2mxylRcaaSuLkwXVGFsT1kTMxQA0Qb9VMakFHWHM1FaADyia+TtukrHNUt6CjqCfXqEZVpTmPb4hdPWmeVzuxCbqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746696552; c=relaxed/simple;
	bh=6F7GV4ssBJ6tpLXnJ9XCktIpxuVg/M87FLs8u08ZizQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxAj/rWUl4gFsv532jxArTlAWerIpUo2OlCwfUg3sCdNgy0hWtX3aQKH6zOjeH2vTxtl6gkeJ2FT2Utp8o+iYgnhzM4AnJB6AGnq6Mc+Wws8Nq/luLMDUuhd/IOhdGrc2VQHiG/0JxrAHEsc9BEO1miWKuMy0xZZ74EpUJwi8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MZXuYfd6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac34257295dso124247166b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746696549; x=1747301349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=opfiCfUXENQMpzh2yphnVtVlQqtDZdSXf+/9PLMPkjg=;
        b=MZXuYfd6AZGhtatl/poiIw6s6uJn1qmh58MgfltDu9D6+a3xHndqZmUqcRYxP4tH01
         HIuZZv0U420/guMRvh8f6vzhM26k5he4l4Gu98wEep8q54oS4Dr8PoCtLYezN8mBj8NS
         zw8VKAe3sw+l+uNfYDk5A45SbGTLHRoZhBdo3ZdODBQMAf5l0Kkgwi4ix2TKwgAS2MqE
         yCdwhNmZxazd9AO/OjHDnrcEHTGMoM1d2etLP1NLKvtnIdQEyOBcnGV+zJxgjstcvAmZ
         wdyluWQZSutGdn9nz/M7r9uqVx9xrODAvExvDahJWr+etP1V+MICZpc7ALzZUgmOD2gA
         wvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746696549; x=1747301349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opfiCfUXENQMpzh2yphnVtVlQqtDZdSXf+/9PLMPkjg=;
        b=NED6EYpUodROP0uzE8r9APGiLXpNw7vQiHZthl0ANY73wx1jbjsOkppkYqLTgFP6bE
         n03jHM0HBuiJdndfnqcx0OgwP+v84YkmW+AJSFtu396YmSK//YmOppSP33CUClH0lefH
         7ACwVOgr5VZXO8RsDChi6xykS1Rxu6Ck3pQNqqzUbS6z7xZ+KZnL/1JD4xveGA2pcok/
         LcNuzbhQDAAFfsh7o2PR7byEr+RlWK57K4ctA/CKXFmQCDSsQsXOd4zkeWzmPaSr6jeu
         f9dC+HSsfEtv1yjExAvbzw79ZnhdHlp1f2mZhhp6SXUXLNFO+lp7ypxSt2wN5KS/vEDU
         eQVA==
X-Forwarded-Encrypted: i=1; AJvYcCU6KJi04kAGRXgtIflyVi9t3srRmC/WF+RF6KPHWytAKVVf4QtONdppsx37FwQgpEl15dvN4FJ/V3Y0sbrO@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ0s+R0/+nQhs1MRsMf/rySKmi+jJXcBp5V4PqvuYZ4kM15XjJ
	ZM2kzufMqXl8PWBcc1vlhEBeBDyctMtmvqjBYwyTJ4yhsU3zQfzIx9Z9zy0e9OOHrO1rdWZE+wJ
	y
X-Gm-Gg: ASbGncv2vgECMiVph4HTTXRxtuXh2SSScDC5ap1PtcCjk5kMm8Pdkp9uEw5KfuHn8Is
	ou4VP41QYxEg6ZemPJSAIg27sU8sfUUlizv0r4ScMsco6hJ2AqR/aurzNirs7K/P5f0Qe6aJYBS
	E3vPeaBb6s92lnXQWe0BiV0VAptnscllh96Qtv9ItiGj/RxETmBdqBlRbUDVFvDrlXz1P9oDEnw
	SimLiGIGZ/bZ/uLMbVqytaNycMjJ6eJ2+P6O4u5G1SubEkS1a7o1Dq7qL9CVRW3qSJ/uqLuXXRm
	YHpLW6xZnUJIm587Z7CcxrhvYsBP9UjC5tW9v6CIO6hO2qRuHZk6ZGGDm5MftZXt7IMd5IJ+JOV
	SYOU=
X-Google-Smtp-Source: AGHT+IGdYaYNv3ROChfHXSgpO45jNEPsYzW9OFewKO5xVmDUgDHoPI7eWDbjD+1ly/pW6XkUenfq0A==
X-Received: by 2002:a17:907:c242:b0:ace:3a24:97d with SMTP id a640c23a62f3a-ad1fe677a1amr245411066b.4.1746696548748;
        Thu, 08 May 2025 02:29:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4d56976sm1737872a91.27.2025.05.08.02.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 02:29:08 -0700 (PDT)
Message-ID: <9a49247a-91dd-4c13-914a-36a5bfc718ba@suse.com>
Date: Thu, 8 May 2025 18:59:04 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>
References: <20250505030345.GD2023217@ZenIV> <20250506193405.GS2023217@ZenIV>
 <20250506195826.GU2023217@ZenIV>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250506195826.GU2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/7 05:28, Al Viro 写道:
> [Aaarghh...]
> it's simpler to do btrfs_reconfigure_for_mount() right after vfs_get_tree() -
> no need to mess with ->s_umount.
>      
> [fix for braino(s) folded in - kudos to Klara Modin <klarasmodin@gmail.com>]
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Qu Wenruo <wqu@suse.com>
Test-by: Qu Wenruo <wqu@suse.com>

Although the commit message can be enhanced a little, I can handle it at 
merge time, no need to re-send.

Thanks,
Qu

> ---
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7121d8c7a318..592ed044340c 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -1984,17 +1984,13 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>    * btrfs or not, setting the whole super block RO.  To make per-subvolume mounting
>    * work with different options work we need to keep backward compatibility.
>    */
> -static int btrfs_reconfigure_for_mount(struct fs_context *fc, struct vfsmount *mnt)
> +static int btrfs_reconfigure_for_mount(struct fs_context *fc)
>   {
>   	int ret = 0;
>   
> -	if (fc->sb_flags & SB_RDONLY)
> -		return ret;
> -
> -	down_write(&mnt->mnt_sb->s_umount);
> -	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> +	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
>   		ret = btrfs_reconfigure(fc);
> -	up_write(&mnt->mnt_sb->s_umount);
> +
>   	return ret;
>   }
>   
> @@ -2047,17 +2043,18 @@ static int btrfs_get_tree_subvol(struct fs_context *fc)
>   	security_free_mnt_opts(&fc->security);
>   	fc->security = NULL;
>   
> -	mnt = fc_mount(dup_fc);
> -	if (IS_ERR(mnt)) {
> -		put_fs_context(dup_fc);
> -		return PTR_ERR(mnt);
> +	ret = vfs_get_tree(dup_fc);
> +	if (!ret) {
> +		ret = btrfs_reconfigure_for_mount(dup_fc);
> +		up_write(&dup_fc->root->d_sb->s_umount);
>   	}
> -	ret = btrfs_reconfigure_for_mount(dup_fc, mnt);
> +	if (!ret)
> +		mnt = vfs_create_mount(dup_fc);
> +	else
> +		mnt = ERR_PTR(ret);
>   	put_fs_context(dup_fc);
> -	if (ret) {
> -		mntput(mnt);
> -		return ret;
> -	}
> +	if (IS_ERR(mnt))
> +		return PTR_ERR(mnt);
>   
>   	/*
>   	 * This free's ->subvol_name, because if it isn't set we have to
> 


