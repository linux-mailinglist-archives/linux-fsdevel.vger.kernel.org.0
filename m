Return-Path: <linux-fsdevel+bounces-66985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C5C32F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E435518C25A4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC62EFD9B;
	Tue,  4 Nov 2025 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NF4B26cu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738762EB5CD
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762288968; cv=none; b=BHQ+X2E6rHOrOuncpKNUNc0J+U11slr2ZuBFTb3q7u54shQt5DxaQV54pLi6EQlS1AopmfGEof8Z61TkMkz4pTI1IvSZMtytJldoEGqv1gPqS+rWty2xKzX5rv7DbZ2al6FNMLeC+8RimsqVp63jfno7fO6Dt+qcsJN9X8Q7fJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762288968; c=relaxed/simple;
	bh=JGsJhmJeF5q8J7Ype2nL15gIcp7qqgcNpRYXX2zKA1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAkL4gS9h9KgjJAht1o71E4jQ9RZ9KI/pGo8I6FaKtaSCKWJFyEz5+KRz1iyHIrtfv6kCiPLCz6nl9iXF774Jap+cBiuSfFWNvvQAGdATGuEnV45UuDlKYp1gqokf/uj+i/tUCDoQ+vUOog+ImzGXezM7458/HZnwaqeNVLCtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NF4B26cu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c7e438a8so897740f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Nov 2025 12:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762288964; x=1762893764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3/I2a0uZTAnglwIVDCoK1EV+nWMPjHOXPCZYdwAgCYY=;
        b=NF4B26cuPHjv3gz17Rsd4oUx/nd3H2cVMGfdAtWNrXbFRIn90kvaIWFt3FX9h1quZJ
         kLLp5i6VaIXIirF0hn9FPubdMMfmwIMNzylZN3OiRuxw32b2UMKihBm8DYldouUrhFym
         2tqjhuNCieP75phG/5Dlp3EO/UP3JX5c/ckIbEo/zfl/KaTbCzNlVwJ8zwHt+CIsG2xM
         BbHYPVW3s4uJC6BrZ1ZN58sX2ZOp21+aJX+ytIjJG5vkbyhnIn9xz/tD7NXW599Y3jpK
         v8PhPVLh8vmgGdnZqIE6CobxZEn+jhXyhzFecnCon9lim+OttiR3GX6GdmzS77ICPWGM
         RCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762288964; x=1762893764;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/I2a0uZTAnglwIVDCoK1EV+nWMPjHOXPCZYdwAgCYY=;
        b=HVIx9tBmP1c9HYpdV5SgB2Vq7UyXm7xfvxRLF7zV4cK1Jq0gbNRi5g3C3ai4TjVaXU
         RDtIdUdKD5sMjknLB0P8RQ+Onf/bvsUbdDogBUzFXENee5CKQth7B6bDMOaC0Zgszr+8
         i7vf3TgMpV0obFzASTvf6G5dYOhbzqe/6CPKjuySqfAEQuJzuFdYwcoc5mYnCmseqo6g
         bWTlvNITgrSklAnbfRVNVFSoMWusga97ptchrXwQl9aySd9PgNdHSj00QJR4u8Ume6e2
         7pQH1IKOjVw5fpFLtq/zrSHFdgL2oOx02DSexEmOqqBmUc4pEoCLH4vUU/fmxD9m3it/
         zRqA==
X-Forwarded-Encrypted: i=1; AJvYcCWW68a0fKqI+4jMGgh4/BNzqsLESQRA5uuFgc5/s4E2qB6wgsj0cAEE7QSgeLBt/MeaIgSA1HqF/GrfVDos@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1RT3CWMkJBGhmALRtcO2Y3cxkV5CNu3XoFANYdQEm4H/lAdy
	f7Jaqg6jPGi3s6JLYOKaftAy8WT9aCsVcxhazuRGpe4zrJ57T4i0C1hSOugItXwIyNI=
X-Gm-Gg: ASbGncsluzXfTGDyhJOIzVCKczSwVgFNYH99+ldhyVHPfoMKIHqGBSSCA/GbJBMkGoo
	Z+6VYzPWiBFXFxrgGNbfXfPtUN5Q55UpbIwVDKA3dSYR9nihgI5PXt84uJnrgAg/WuT2EivfJ5G
	iWkURPR1hWAFfuS4iX5G3qNuvkvy3TvyAFqsMPT/wm+tCjTilDypqGI6kIZBMxO8fhBI2120xTu
	R7FUdn9lbAVhJuOhls/rNXr1zGQRNNg6bpds7n6dCTDpOVDcGFPbsvVKggQHvkaRbN2NaBcj8Tb
	vrV0tJgMsxU5G/coiarZv5JNwT8th5D38rNZdJTYumFtAJ1LfSxkDDMGAEMOiT9EyBWCkfyk6U4
	IhcUerNkHPCO7bu/KssVudklLeQjYDuArG6Ayei2UQstauzcqHmadj8B5dHL3exnNir69N4DHWz
	sU2JQpg9h4XKhgc2ac3Gb5V/J78QzN
X-Google-Smtp-Source: AGHT+IG8Z203PhFCyhJhz48A8l8UhXjLU1AaikFIf0iJkmfVY5x+Gi/GZMr6bL+04r89yb9RlNQzVA==
X-Received: by 2002:a05:6000:26d3:b0:429:c851:69bc with SMTP id ffacd0b85a97d-429e32dd761mr472461f8f.8.1762288963767;
        Tue, 04 Nov 2025 12:42:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3246e7bsm3976191b3a.8.2025.11.04.12.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 12:42:43 -0800 (PST)
Message-ID: <247c8075-60d3-4090-a76d-8d59d9e859ca@suse.com>
Date: Wed, 5 Nov 2025 07:12:38 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/8] btrfs: use super write guard in
 btrfs_reclaim_bgs_work()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-2-5108ac78a171@kernel.org>
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
In-Reply-To: <20251104-work-guards-v1-2-5108ac78a171@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 22:42, Christian Brauner 写道:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>   fs/btrfs/block-group.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 5322ef2ae015..8284b9435758 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1850,7 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   	if (!btrfs_should_reclaim(fs_info))
>   		return;
>   
> -	sb_start_write(fs_info->sb);
> +	guard(super_write)(fs_info->sb);
>   
>   	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
>   		sb_end_write(fs_info->sb);

This one is still left using the old scheme, and there is another one in 
the mutex_trylock() branch.

I'm wondering how safe is the new scope based auto freeing.

Like when the freeing function is called? Will it break the existing 
freeing/locking sequence in other locations?

For this call site, sb_end_write() is always called last so it's fine.

Thanks,
Qu

> @@ -2030,7 +2030,6 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
>   	list_splice_tail(&retry_list, &fs_info->reclaim_bgs);
>   	spin_unlock(&fs_info->unused_bgs_lock);
>   	btrfs_exclop_finish(fs_info);
> -	sb_end_write(fs_info->sb);
>   }
>   
>   void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)
> 


