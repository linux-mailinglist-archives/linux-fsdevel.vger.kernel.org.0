Return-Path: <linux-fsdevel+bounces-72804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B3703D03D9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C17830336CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F341E5C6;
	Thu,  8 Jan 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpGRj7i6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5E841E5CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863693; cv=none; b=klA12GcINyj97FtZh76HzKAV0I0gvXnmDQFnmWxburdgfyjnq2mfGUtlJ2/MO08ZshKANCj0zNW2c/FhftdG/OIPqtwmajItq9K1fqVSarRYA3xLH11z4nhIZ7phbtRdLIbL9+PPDbhUHDGJCT0ECmhltI/E7hSffF+R3JX+JDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863693; c=relaxed/simple;
	bh=O1kPS5MelCJnE3091PcMFc4fx3i6U389jcgBTmCDIts=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nv+HzUEASBr+qZC68LK/sSUV6858rt082dcHmyw0r1vHyoMT0klNgze5vtJyqx92tVd6bn5y2q3Dxp+qREnqQD2W9NuIO31zoKwkHiTXh2XQqlYYVqWODzFZxW0Khhqt9YIkh1xqFK+9F7/SJbxvVY7Xpn3a7nX6k3mayCeJAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpGRj7i6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso1874499a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 01:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767863685; x=1768468485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9A9CnNPkpLsRMHLIS50U2O5+Dp80nlM7WRY0+NXniA=;
        b=LpGRj7i6o3j1shQ0GljbsEC5sp2QecOg9X0CfhpDjUaKBruoGDeDtJ06Kb4Y0x1WTT
         gVpEVjQ4At+ObkzYOMJncdOB5DVOjeNfeNwyoCFkG6yVOXSWM2Yz0yYD1pwezHR9dNlC
         PbVa+qhTiF5qg5Eo0Ut8/fpBHNnjZzxHJJIr6FC1ySAy5A51cEsJykJB8S4I+SGCkrzC
         fm9TC3VslLEyM5iw713HP0AJMdN1fgSoDRRx5VieHy+M6+OUKXO4hFsLdV4KvMDfP5eL
         q7p0r6fXea3VGsZ3R3PD0S4xsDywva07mv4PPKbqS81uMj5ikGPWVMwzPgBCTgv8hA/r
         GJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863685; x=1768468485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9A9CnNPkpLsRMHLIS50U2O5+Dp80nlM7WRY0+NXniA=;
        b=W/QHQyi0uAfXSoKlGZryekJWIq+EklkRvMilgYQT2AJvRtLfpJJG98ZS0GOikRJpPI
         gKWOooWlL/+CQPJgrGh+8hOcuZCA2ivbtYaZFs43vke/kSfsbFIjbPwVlDDNGB69+hIL
         zIwJHT+ftxcWF1jw2rkWOdp1p1F0+kuW0JbRTwHGmQo0hHfre5rDTIYC/HwU3q7K6gge
         6bN5d6waQng1YpqGksRLPqFuqPj1N6LZGk3fFu1iLUZRyQxJhTee7cbXLsfMS4YM4GlE
         tMWxbTZtE+5HxTIG7ntjrAykJRc2CFiZy+qDsJelrBfikk34DO0+Sat9uUTxcJ9uA8E/
         3TNA==
X-Forwarded-Encrypted: i=1; AJvYcCVzrZPp7qEdJ7u6w0j+BtgGauv9JToA8060atx9sH3+Vqxq2ICeLu7RDtYBzSlxfvQ94bTJGZ8wpc90avD+@vger.kernel.org
X-Gm-Message-State: AOJu0YyIIfJQLy6k3sYQVeMShaCDjSkg357GOUoxYSrvKpa4ff+dFN+n
	14d+niI1z1DHdCmE0npo8BRvGi2YKAe1DdEOx9sPNWYIQeOMteTOGR6Y
X-Gm-Gg: AY/fxX4Ssftq2pZkt9cI/7hWOBPweXEfLlkRyE07Mv9WdOkSFJYYsY14SZKP0avL9+K
	QhgwCwDyMETs1vSdfflomngDi1oXCC1GFOK23Du0Oe6DOkLB9Xd8LpJ9PrCXm2Ca5wNE8H9ZMs9
	LdMWV2wmcS1f4lMBaQYmf8TBj5LABnkQNr+IZF1Vqa4/gvbUdd4AVmv6JdS5QOUTz6WoADeB8FM
	pbWxG4R0mXKUcuM+SEeafnq7lCTCV7bms2cNtKjBNwuNDPv7JSMnObOVEzySPx3d1ahFXTeMwBI
	yFP+q0YTZzsKjNG8szUV5l7Y0hgLXiNIZOVtJ/KpCGSDLEqh2/SIpixzow3rldCyVuKYsJCrqZj
	964pHhsL3gvwQ6IC1nBaL674JhC2lVSOngLOzCME2V87twOQAMzX4ZGWKnqnqtiKvUntt7NJTHW
	6MM753wKFGv0S+R4889fQ31g==
X-Google-Smtp-Source: AGHT+IFN4bvajl/HnvO1CZQ3YQgySLPOlPc+6VtyxPcphHI+k8Jmt+inxmA3yYfVTtpOjwdyDkkOiA==
X-Received: by 2002:a17:90b:3852:b0:343:b610:901c with SMTP id 98e67ed59e1d1-34f68cb9036mr5855290a91.26.1767863685375;
        Thu, 08 Jan 2026 01:14:45 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6af53004sm1950343a91.1.2026.01.08.01.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 01:14:45 -0800 (PST)
Message-ID: <243f57b8-246f-47e7-9fb1-27a771e8e9e8@gmail.com>
Date: Thu, 8 Jan 2026 17:14:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shengyong2021@gmail.com, shengyong1@xiaomi.com,
 LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
Subject: Re: [PATCH v3 RESEND] erofs: don't bother with s_stack_depth
 increasing for now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <20260108030709.3305545-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/26 11:07, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-and-tested-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Acked-by: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-and-tested-by: Sheng Yong <shengyong1@xiaomi.com>

I tested the APEX scenario on an Android phone. APEX images are
filebacked-mounted correctly. And for a stacked APEX testcase,
it reports error as expected.

thanks,
shengyong

> ---
> v2->v3 RESEND:
>   - Exclude bdev-backed EROFS mounts since it will be a real terminal fs
>     as pointed out by Sheng Yong (APEX will rely on this);
> 
>   - Preserve previous "Acked-by:" and "Tested-by:" since it's trivial.
> 
>   fs/erofs/super.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..5136cda5972a 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,21 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>   		 * fs contexts (including its own) due to self-controlled RO
>   		 * accesses/contexts and no side-effect changes that need to
>   		 * context save & restore so it can reuse the current thread
> -		 * context.  However, it still needs to bump `s_stack_depth` to
> -		 * avoid kernel stack overflow from nested filesystems.
> +		 * context.
> +		 * However, we still need to prevent kernel stack overflow due
> +		 * to filesystem nesting: just ensure that s_stack_depth is 0
> +		 * to disallow mounting EROFS on stacked filesystems.
> +		 * Note: s_stack_depth is not incremented here for now, since
> +		 * EROFS is the only fs supporting file-backed mounts for now.
> +		 * It MUST change if another fs plans to support them, which
> +		 * may also require adjusting FILESYSTEM_MAX_STACK_DEPTH.
>   		 */
>   		if (erofs_is_fileio_mode(sbi)) {
> -			sb->s_stack_depth =
> -				file_inode(sbi->dif0.file)->i_sb->s_stack_depth + 1;
> -			if (sb->s_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> -				erofs_err(sb, "maximum fs stacking depth exceeded");
> +			inode = file_inode(sbi->dif0.file);
> +			if ((inode->i_sb->s_op == &erofs_sops &&
> +			     !inode->i_sb->s_bdev) ||
> +			    inode->i_sb->s_stack_depth) {
> +				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>   				return -ENOTBLK;
>   			}
>   		}


