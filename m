Return-Path: <linux-fsdevel+bounces-67184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C5C375CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6953B9F9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685028851F;
	Wed,  5 Nov 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fYVCN4Of"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F59280339
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367835; cv=none; b=K+QFZ3bp/nCjP+j3pUpDWa6e1YY5xSIR1wn24nuKO8Vj+y7BXCDqp5MZJU5980gjOb6BnU5b/5e74VgF50PxxS+HAEFJp+bwu0pBbo2FEhZJG/WN3uJmafd+QNwwoqbOEFh4ceN2S2PUzuIKpoSkL8jcC5g5y/TQYh9GswW8Xvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367835; c=relaxed/simple;
	bh=w1KYQIP//0eBMv4//DhZ5KFx9PNW1UPFH7nnebTruwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPsfhaGaSSegNLXR3td+lslgdKbqy7HJ9k/1cV8cmiYMJEQbF/q+kvfHPxRSo4brGwEz5RcAmzvMDEtgNl7AHwcspYKKgwZFRVKqKaqbP7pytBJY0e0hWNcH81BIk1kWu6HMWpVjcB/nBbokNG7WRFRR1FFS4dsbXJW5Sd/Wj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fYVCN4Of; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429b7ba208eso109563f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762367832; x=1762972632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wVms5zHRqmmTEZveui8rFB3VRHHPz5yVXKILCesT61s=;
        b=fYVCN4OfbHIr8B6q0Fi2RkHSRnuiG8B6MV/syAoNmWfmZuE8ZlusEVg3Pxq17sxR2v
         7AkJFhY7iCk+P/zK0QeVYfM3eWMSeeYDlikkK639vYgdmNG49juLIQskyq3AZY6yMYjx
         yTev4+Oj088dMF8IXyH2XTXsnz8C/6Eh3kSn9HIovoxccDTgbLnSmWSHcQZ+WNckNFiK
         lCaMSfbb7ZZoq+2+O9PX8PodM/MiZP0K/rYwn/z2RdZo++j2yZBUqEJfQZpV/HGQLTQH
         zhanoIv2dkwGV4Pe0knKElXwBIAVqJqXT6PhTpFHxfSlSI/40HlRhhEC+nRYsoGS3n/h
         UT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367832; x=1762972632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVms5zHRqmmTEZveui8rFB3VRHHPz5yVXKILCesT61s=;
        b=VJA8M4oI/ok6Y/t++nLUbZek8WgcjqOYxcajVu3AyO2q8WzZ3n8lEgBkPtpJwRclNj
         nKiBvSjpVmWQia7KAggQmchJRWsogum5Y7QE+yV2gm+ZP5pV3+10L/lSz4WNgCWpusGO
         jCayEWphiMGqf+XPN2epL6pu3Zc1ZSCDEttKR3rCv/iU0vHuuB4QLqiTvN90AKj/g5eD
         Fiz1kU7JKdXHhjpOiAmwxiZ9eEz/pk6VTrHZtAT56GXw6nlgJC62VXRcNeZ4LGZB2mxJ
         3ZGwO851R8adZ3GFS0+N2pkqDQ45rtQIFtmPy9yGL8rV4I1WgllDJSdlLkGchenOFu7R
         pElg==
X-Gm-Message-State: AOJu0Yx9zwGumge0sOo0RZty9sA0adVrdeaJwraA3JQIiR+LMemR2rad
	LJSMxb9rq026zFaKEGMO18TZ1qf/kS3RV91h6njccMnBuH3I1pkr+tiRjzs2yQ5eGgV1whqLhFe
	1MC3OoL/5RLR2S1HEGw0+fzhl/4vxbS3p9NgWOCFN8g==
X-Gm-Gg: ASbGncuzb3OAFaDxdL0T60SxG9Gwo0c+8nYF54qozXfPB5TwNoeivjHc6ptV3m/CIKx
	edRvPDj+sdle1iYWVpLk4rND+HkgK1A2U/XegCD8u3H539ikFgvk+/ZK4C7DSHYz38amW47SYrV
	yuH3LNItF8rNByddc+3w3GuosyHUCL50kvzUPqROJUK1wne1Of4lCvyElaMr0kilVHl5Aml0XET
	8Rx3O7QZ714Xn//Gpa86Smn2w5IEYvBDIMvlaam+Os/P+QAuI8C9awXcXe5aC2gyt8CKTTjuGxB
	zaIYjrJ5w2BZUWt92lUx1e9BC131ROrML5J78OKtdtNEGrgbPyCX5pEgeQQ5jEtk8sUT
X-Google-Smtp-Source: AGHT+IG5bZpCpAJS0uB9KNssTM0G9hDscPSWpbhRk73gTjzcEZVb+SiJRjSt3rx+GFSKRtyh83PP5p7jyKcIDWTsbQs=
X-Received: by 2002:a05:6000:4593:b0:429:de20:3d84 with SMTP id
 ffacd0b85a97d-429e35d299emr2327042f8f.6.1762367832176; Wed, 05 Nov 2025
 10:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org> <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
In-Reply-To: <20251104-work-guards-v1-7-5108ac78a171@kernel.org>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 5 Nov 2025 19:37:01 +0100
X-Gm-Features: AWmQ_bmfaeOypajqSuDAqK1J5uivhcjJ2drotaSadJ4EnDW1YFSkgONoikGnaIQ
Message-ID: <CAPjX3Feor+wY-_rniWOaGQf_7RPaUQLDZmmjABDkAav8AExaxA@mail.gmail.com>
Subject: Re: [PATCH RFC 7/8] open: use super write guard in do_ftruncate()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 13:16, Christian Brauner <brauner@kernel.org> wrote:
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/open.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index 3d64372ecc67..1d73a17192da 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -191,12 +191,9 @@ int do_ftruncate(struct file *file, loff_t length, int small)
>         if (error)
>                 return error;
>
> -       sb_start_write(inode->i_sb);
> -       error = do_truncate(file_mnt_idmap(file), dentry, length,
> -                           ATTR_MTIME | ATTR_CTIME, file);
> -       sb_end_write(inode->i_sb);
> -
> -       return error;
> +       scoped_guard(super_write, inode->i_sb)
> +               return do_truncate(file_mnt_idmap(file), dentry, length,
> +                                  ATTR_MTIME | ATTR_CTIME, file);

Again, why scoped_guard? It does not make sense, or do I miss something?

--nX

>  }
>
>  int do_sys_ftruncate(unsigned int fd, loff_t length, int small)
>
> --
> 2.47.3
>
>

