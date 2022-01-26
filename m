Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D8D49D002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 17:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243294AbiAZQuS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 11:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiAZQuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:50:18 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0EC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 08:50:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k17so165820plk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KGeC0mFmNIWURdxkRl+DY9Ft9hjbJoEii4WArXZSn9U=;
        b=egWgY66GHp+XW4YBH4mdcRUR4Shw+ODfGCAzb4JxokHUPLh0O8+liWx1PSTBFL9/4E
         Aiz2LW+LjfrJVyytxD9TnBan2qrx/NF1C9jKmQHBy/RLhIQdMy7Sjq62HBYT8P/u7Dkl
         I4DEGXaP8E6fRBgcuEAs4btVv1D5id6iGAjXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KGeC0mFmNIWURdxkRl+DY9Ft9hjbJoEii4WArXZSn9U=;
        b=oVmH6dh82t6x6P3WXlyTIHmgWQfRq5bnHKQbhmNoAzv+NFa7pvlf7ubSxWpVdOVZmf
         tRtf3F4tPhXDtI3Xp7R7wWI91d28hvF1v5IEo6FQOnp50QB9Zlqr3XjoMppardpYJW10
         4bziDT3lLxTHUi0TBMr0gV9d5W0W+ROQqmnEKpbW/pF01+NGu9Ino6Z4tueoo3gBxxee
         2AqU954lB9AOJVvKcyKWJPc5Vapp+e6vg+DMwOkMus5jdksXmP7pjX0cqap7fs2TBZZe
         7ZVXu5nqvid1p3ZJCugCK8DaqoCmFKUTTE0tz+L3zWBXCeFzmZKiiGIc98YqG8bMk/mM
         5uqQ==
X-Gm-Message-State: AOAM531SBGMCujXlM6rZH+KNmHtckuoxAWvoH35L0DUPReQYpQNZxqry
        KdCiQWwlzzm3o1uZZfmIUwgGuQ==
X-Google-Smtp-Source: ABdhPJymuP7NHkv3+J8l4UVfbeho5XE03myjuslPfdXJo8qM4ZkjsvRYrDFOza7BpRzsSGzgz5oE/Q==
X-Received: by 2002:a17:902:7786:b0:14a:bb95:6a36 with SMTP id o6-20020a170902778600b0014abb956a36mr23889299pll.136.1643215816857;
        Wed, 26 Jan 2022 08:50:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k13sm2972963pfc.176.2022.01.26.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:50:16 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:50:15 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202201260845.FCBC0B5A06@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfF18Dy85mCntXrx@fractal.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groﬂ wrote:
> From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> Date: Wed, 26 Jan 2022 16:35:07 +0100
> Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Commit 5f501d555653 ("binfmt_elf: reintroduce using
> MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> 
> Specifically consider an ELF binary with the following PT_LOAD segments:
> 
> Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> 
> Note how the last segment is actually the first segment and vice versa.
> 
> Since total_mapping_size() only computes the difference between the
> first and the last segment in the order that they appear, it will return
> a size of 0 in this case, thus causing load_elf_binary() to fail, which
> did not happen before that change.
> 
> Strictly speaking total_mapping_size() made that assumption already
> before that patch, but the issue did not appear because the old
> load_addr_set guards never allowed this call to total_mapping_size().
> 
> Instead of fixing this by reverting to the old load_addr_set logic, we
> fix this by comparing the correct first and last segments in
> total_mapping_size().

Ah, nice. Yeah, this is good.

> Signed-off-by: Magnus Groﬂ <magnus.gross@rwth-aachen.de>

Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  fs/binfmt_elf.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index f8c7f26f1fbb..0caaad9eddd1 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
>  {
>  	int i, first_idx = -1, last_idx = -1;
> +	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
>  
>  	for (i = 0; i < nr; i++) {
>  		if (cmds[i].p_type == PT_LOAD) {
> -			last_idx = i;
> -			if (first_idx == -1)
> +			/*
> +			 * The PT_LOAD segments are not necessarily ordered
> +			 * by vaddr. Make sure that we get the segment with
> +			 * minimum vaddr (maximum vaddr respectively)
> +			 */
> +			if (cmds[i].p_vaddr <= min_vaddr) {
>  				first_idx = i;
> +				min_vaddr = cmds[i].p_vaddr;
> +			}
> +			if (cmds[i].p_vaddr >= max_vaddr) {
> +				last_idx = i;
> +				max_vaddr = cmds[i].p_vaddr;
> +			}
>  		}
>  	}
>  	if (first_idx == -1)
>  		return 0;
>  
> -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> +	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
>  }
>  
>  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> -- 
> 2.34.1

-- 
Kees Cook
