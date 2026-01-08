Return-Path: <linux-fsdevel+bounces-72705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1ED00AF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 03:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E81B302AAD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8229B78F;
	Thu,  8 Jan 2026 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsZpsr5X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E90B299949
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 02:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839205; cv=none; b=rcWI+PlMeh3Ecfo8sr0StEVD3y0VMdhk+eLA0atPGRcnWXg8bergCqrHFXlLuY4DxlkU2uv+yI2MVeLGNj2aa37aIKLx/RnZHJIvmPYGXb35oJRSAumxRsOzBsYv+0HKhy9WnjGdiK5IDhFNXaAhjcy9VobIan1KdLDdJWMP61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839205; c=relaxed/simple;
	bh=JUqVjRUk9Ght0IhfZYovVkug4AGW3LuZwIJbtBD5sQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMvM2TlluBAhTPFE08FprBpDCdHXYS+lbKomxMxJdedpKSMRqj105HvoLQSkxPQ280W0Cvmf32t65sjfGvdAEfNX9ad6fiTm4dXdGwOXmlI3YKJXmK4X9CJELqW5zg+UUSjNOEVlI0OrcXACKHjNei9VhwZLMVKr4WaR4qzLZhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsZpsr5X; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c026e074373so1498514a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 18:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839202; x=1768444002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SlkG/EJNtxTQbmqNLHdB90183ZHhg2gpdFgNQmGYHqw=;
        b=VsZpsr5XIUG+DZtF1JXGDxMBhsFbJTYA5osbFHNKrBtEDkGd5EtXddaiQRwIkD7s9K
         hytVSx+SjopXJAUd1tgpWe+c19Lrpp7M1u/7nXtnkmr4HWLk6Iyy5z5h1f+my1mWfTah
         uezp7zi6drRJH1msrAfZ67JV2oXNTq0FLwqryVK4lsb0FUEQv9wv4GQrxlYqHEjfa4U5
         vG3XUqdF68i92z6Q+WVTGeATLFSN9gnjfuJBVhLABU5yktVIGOY/0IIAhPa9zN87cNJd
         +rO+py3Nn6sTUngDynbS6myEdbU6K7fx6MSSBjNvV1TAJlOdE/s9c/3h1kXvojbx605o
         ucqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839202; x=1768444002;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SlkG/EJNtxTQbmqNLHdB90183ZHhg2gpdFgNQmGYHqw=;
        b=BSpsID5eOE1sQJjwcvL1tbZgTOACrd7dT13BLmkfuOEdzIE53g2OLJYDyr7F+fanaT
         qkVtrVMhXcgOCPyLim7EpGL5k5CrhVg45sQDBrkj/UF2V7XuKg5eSIqogrpLeQtkwpI2
         PWKKLycQDrg0TuM8JSVxPSaHQjQlBUjnIs9quXZ+6MWR36MNZCJ3KPGSCJAKTx+ENEDe
         GoMSm6OWdRie+FH/9jbTI6jAAIOD+cROIJ5UFpAEBzYQ2QqBW/xXM6hSlX4HiyHhqb7P
         TbFVBdIcVaf1Vwwd4vPs+lMOtXrd0PpRK3+6a46nLt4OUM1KmnUsoQcErXCO8Wq/6z35
         Vatw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqEuX1Fo4VYDSL373n6ZndmlWKuJq1myhZbpKDSFNDD2BdCWznmaVzt/t8yc3cTL4nRBkfiCz+WQY5lN0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Yy3obVBmWk1MqJXvOF0xQvlgfU/5Pvhl/6GjKzSJQE4S5jxa
	u7v+MZ0NcQwp8zjDnG+zqcaJ4a+NVFgA/AxOXrDBJ0j/k9ZlHMQdRpg6
X-Gm-Gg: AY/fxX4jD6wBnxp82Uy2hutIHf8LwsHmQT830OTeEIPXwqifDb7uEIF1o5Qu7zxaNo+
	I5ZAiKomI4/BmGU86wWWlaBDVir9shgk6GWXxrTVMMzD6CMv8Ge3r5Ayv5pfKHvy/ufVRW4rRCZ
	C45URhJ4/Fx00uPFOkVpVbTP/ttjJqAQHT2Ml2wVU2Btjx66KlkJmMsuwK9bxttcFC4UgLfWSvp
	UzspSYrhHs4AgqzJy/uloajuFLgz8L+498iqDcXo7Yhzo5IOsrq2UBm1DhqueCnlluAnnbPSHS8
	DGjndu+CRS1h//pr531QPkR8PXVAX2dbX0Pfh/vqu73VmwogqiBBggpc33fHu4y8i156bIMejN+
	+PR04ms+P7bwmCsIKNbKOWVrFWhXt1IyoxEbjo5M1Th4pf79HADPM9W915u8c6DigSMn83ZdVzM
	KUrJP+VZzUEGQAA/FlEf/XhA==
X-Google-Smtp-Source: AGHT+IEGa+ws2SHQIi5xy8NLYinApzL2ZD35WLB81CyXBtazqNT3JFCWjfqFBKIDmDkCcdskllaiiA==
X-Received: by 2002:a17:903:2292:b0:2a1:2ed4:ca1e with SMTP id d9443c01a7336-2a3ee4b72e8mr39060825ad.34.1767839201831;
        Wed, 07 Jan 2026 18:26:41 -0800 (PST)
Received: from [10.189.144.225] ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a303sm61626365ad.5.2026.01.07.18.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 18:26:41 -0800 (PST)
Message-ID: <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
Date: Thu, 8 Jan 2026 10:26:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Amir Goldstein <amir73il@gmail.com>, Alexander Larsson <alexl@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Miklos Szeredi
 <mszeredi@redhat.com>, Zhiguo Niu <niuzhiguo84@gmail.com>,
 shengyong2021@gmail.com, shengyong1@xiaomi.com
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US, fr-CH
From: Sheng Yong <shengyong2021@gmail.com>
In-Reply-To: <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/7/26 01:05, Gao Xiang wrote:
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
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> v2:
>   - Update commit message (suggested by Amir in 1-on-1 talk);
>   - Add proper `Reported-by:`.
> 
>   fs/erofs/super.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 937a215f626c..0cf41ed7ced8 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -644,14 +644,20 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
> +			if (inode->i_sb->s_op == &erofs_sops ||

Hi, Xiang

In Android APEX scenario, apex images formatted as EROFS are packed in
system.img which is also EROFS format. As a result, it will always fail
to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
is true.
Any thoughts to handle such scenario?

thanks,
shengyong

> +			    inode->i_sb->s_stack_depth) {
> +				erofs_err(sb, "file-backed mounts cannot be applied to stacked fses");
>   				return -ENOTBLK;
>   			}
>   		}


