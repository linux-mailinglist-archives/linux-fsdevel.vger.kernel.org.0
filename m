Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7000349DAAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 07:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiA0Gbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 01:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiA0Gbo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:31:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7B6C061714
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 22:31:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h12so1933580pjq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lbnwPKU+OhK3Q8fw1IuxNsJFONUjafO81x0YepRwpVU=;
        b=kO9cnRNWfjIxqhEdVxCFXalKyVLcLDpNmXISPWJKVrRl/8JOO7AgK6mLU7YlhwTgor
         pCioL/3CJ1Fmt8XwtuZPo7bxRC4d9cy0rws8xX3sp89q1pvSg2xrocgc9sgxD91sCWuT
         PaL/uBnscqfMv92i5lPUBveJNHc6A9V30lsuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lbnwPKU+OhK3Q8fw1IuxNsJFONUjafO81x0YepRwpVU=;
        b=REiXj8QXT8OtgAIJB4MajhmFDY9H3Qggskw8Zp7K5Yh5cHuOZZjSp277TJQTRnfPNX
         Y7FJ5FjPJnannHhkOSD5K/Qa7u921p2yZQTnr3s3Kw5B9dhA+B0EgVg7SwUI1p0xkDC0
         zZv9pJ8xSEAq6Gicyv0woXGnqt0NEyQoDhc9GuOX/WlqOQ60RD/M9d5DTppI/SsUL8hZ
         5pOYy+Ydo2dncZoFZfaj0eMV016LW7uDO35JMHeHgwyb0w13OUFu3iBRppVIpb3t2jYX
         9EFbPhvFPnJKnvgc2nZonkED8Z5npMKhEkNW4AJaz931HrG4EV0SoNLlFl19Ke/IEb7m
         39tA==
X-Gm-Message-State: AOAM530KK2Auzg7RJfV6VN5I0dVC2Mc2MfCWJtFhzgO9dPsbjuoT7hVg
        M4EmtOCZWJA9nv8UwB4Ms38QVcLL+dHCdQ==
X-Google-Smtp-Source: ABdhPJxvX+FZ7Zy2fT+BIbiP7+n2FkjaQpST0iFKTFY5IKtAfg1u2lmwN3kwf3oFPjUo3NWaIp2P4w==
X-Received: by 2002:a17:902:ab5b:: with SMTP id ij27mr2171967plb.148.1643265103569;
        Wed, 26 Jan 2022 22:31:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l13sm18528130pgs.16.2022.01.26.22.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 22:31:43 -0800 (PST)
Date:   Wed, 26 Jan 2022 22:31:42 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202201262230.E16DF58B@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202201260845.FCBC0B5A06@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groﬂ wrote:
> > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=UTF-8
> > Content-Transfer-Encoding: 8bit
> > 
> > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > 
> > Specifically consider an ELF binary with the following PT_LOAD segments:
> > 
> > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > 
> > Note how the last segment is actually the first segment and vice versa.
> > 
> > Since total_mapping_size() only computes the difference between the
> > first and the last segment in the order that they appear, it will return
> > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > did not happen before that change.
> > 
> > Strictly speaking total_mapping_size() made that assumption already
> > before that patch, but the issue did not appear because the old
> > load_addr_set guards never allowed this call to total_mapping_size().
> > 
> > Instead of fixing this by reverting to the old load_addr_set logic, we
> > fix this by comparing the correct first and last segments in
> > total_mapping_size().
> 
> Ah, nice. Yeah, this is good.
> 
> > Signed-off-by: Magnus Groﬂ <magnus.gross@rwth-aachen.de>
> 
> Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> Cc: stable@vger.kernel.org
> Acked-by: Kees Cook <keescook@chromium.org>

Andrew, can you pick this up too?

-Kees

> 
> -Kees
> 
> > ---
> >  fs/binfmt_elf.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index f8c7f26f1fbb..0caaad9eddd1 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> >  static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> >  {
> >  	int i, first_idx = -1, last_idx = -1;
> > +	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
> >  
> >  	for (i = 0; i < nr; i++) {
> >  		if (cmds[i].p_type == PT_LOAD) {
> > -			last_idx = i;
> > -			if (first_idx == -1)
> > +			/*
> > +			 * The PT_LOAD segments are not necessarily ordered
> > +			 * by vaddr. Make sure that we get the segment with
> > +			 * minimum vaddr (maximum vaddr respectively)
> > +			 */
> > +			if (cmds[i].p_vaddr <= min_vaddr) {
> >  				first_idx = i;
> > +				min_vaddr = cmds[i].p_vaddr;
> > +			}
> > +			if (cmds[i].p_vaddr >= max_vaddr) {
> > +				last_idx = i;
> > +				max_vaddr = cmds[i].p_vaddr;
> > +			}
> >  		}
> >  	}
> >  	if (first_idx == -1)
> >  		return 0;
> >  
> > -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> > -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> > +	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
> >  }
> >  
> >  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> > -- 
> > 2.34.1
> 
> -- 
> Kees Cook

-- 
Kees Cook
