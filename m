Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4824A03A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 23:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350536AbiA1WaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 17:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351283AbiA1WaO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:30:14 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA80C06173B
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 14:30:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v3so6498956pgc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jan 2022 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UQU/zzOIGiyUM8/XLeItcnOhkfwjpiwMD0bTk1M1h+c=;
        b=jT2/6eWTnRxYOlLDgGUVm6GoKxvh3ihMwsjZsge72KQr5rO94AiWzyRB9S/F8+nezH
         6GNP+mG2ncB+2c9SeTf952+m26365xklIWFgbK0QJs4L9rcSCV3zREErS/hnjU+ESu6o
         zs9dPkuxEA4/h44VByiEciXRGX+0o6P4CHv1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UQU/zzOIGiyUM8/XLeItcnOhkfwjpiwMD0bTk1M1h+c=;
        b=Z0SgDx2Jw/zbCMBVLep9Cw2gAzE2NlSlb583iz27t857Bs2J7Rcap5NrB+Kjx0Y5Kk
         S1TFgnQn5epuLUsTC5ifhNKriGIWcvR0eRFwOx+/yFTtCn77rHyxjDDRqPM2ppWoK8VI
         om/twmVY4J8qNjgrTZcJYp8Yb2RlMO9VLlkdGeB+qeDIsNXPjetscR+P3aWmq/zFcprN
         3ozt3ss3YLDSryoLn+5BmxrqINO/fmmFZMRImVv6EjDdvfGPgRR3eLZGgGhK9ho5mXK0
         hTHxIRccN4NhNqTcNGAuJX0IEtfrjWnh4zvi1Ohx69KnWP5qIDPMHTGGYpnF42l/ifqQ
         vrUQ==
X-Gm-Message-State: AOAM5326vdQR5KvT8U2YaVWH0WLPE/CsYRZ9gPRDA9Ppe/XubREbqN4E
        Tm1JDCODYwQId9XDmnfvKG+Sgw==
X-Google-Smtp-Source: ABdhPJyUHOWf/aLPEpgdmUJXWIEYc1ZsCgRh+fo8EE0lsoiW4r9GmsIXssoGzqEE853Xkwa5k4vN8g==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr8147584pgl.374.1643409013479;
        Fri, 28 Jan 2022 14:30:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm3251898pju.7.2022.01.28.14.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 14:30:13 -0800 (PST)
Date:   Fri, 28 Jan 2022 14:30:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202201281347.F36AEA5B61@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfOooXQ2ScpZLhmD@fractal.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 09:26:09AM +0100, Magnus Groﬂ wrote:
> On Wed, Jan 26, 2022 at 10:31:42PM -0800 Kees Cook wrote:
> > On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groﬂ wrote:
> > > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > > MIME-Version: 1.0
> > > > Content-Type: text/plain; charset=UTF-8
> > > > Content-Transfer-Encoding: 8bit
> > > > 
> > > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > > > 
> > > > Specifically consider an ELF binary with the following PT_LOAD segments:
> > > > 
> > > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > > > 
> > > > Note how the last segment is actually the first segment and vice versa.
> > > > 
> > > > Since total_mapping_size() only computes the difference between the
> > > > first and the last segment in the order that they appear, it will return
> > > > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > > > did not happen before that change.
> > > > 
> > > > Strictly speaking total_mapping_size() made that assumption already
> > > > before that patch, but the issue did not appear because the old
> > > > load_addr_set guards never allowed this call to total_mapping_size().
> > > > 
> > > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > > fix this by comparing the correct first and last segments in
> > > > total_mapping_size().
> > > 
> > > Ah, nice. Yeah, this is good.
> > > 
> > > > Signed-off-by: Magnus Groﬂ <magnus.gross@rwth-aachen.de>
> > > 
> > > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > > Cc: stable@vger.kernel.org
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > Andrew, can you pick this up too?
> > 
> > -Kees
> > 
> 
> May I also propose to include this patch in whatever mailing-list
> corresponds to the 5.16.x bugfix series?
> It turns out that almost all native Linux games published by the Virtual
> Programming company have this kind of weird PT_LOAD ordering including
> the famous Bioshock Infinite, so right now those games are all
> completely broken since Linux 5.16.
> 
> P.S.: Someone should probably ask Virtual Programming, what kind of
> tooling they use to create such convoluted ELF binaries.

Oh, actually, this was independently fixed:
https://lore.kernel.org/all/YVmd7D0M6G/DcP4O@localhost.localdomain/

Alexey, you never answered by question about why we can't use a proper
type and leave the ELF_PAGESTART() macros alone:
https://lore.kernel.org/all/202110071038.B589687@keescook/

I still don't like the use of "int" in ELF_PAGESTART(), but I agree
it shouldn't cause a problem. I just really don't like mixing a signed
type with address calculations, from a robustness perspective.

Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
to include:

Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

> 
> > > 
> > > -Kees
> > > 
> > > > ---
> > > >  fs/binfmt_elf.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > > > index f8c7f26f1fbb..0caaad9eddd1 100644
> > > > --- a/fs/binfmt_elf.c
> > > > +++ b/fs/binfmt_elf.c
> > > > @@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
> > > >  static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
> > > >  {
> > > >  	int i, first_idx = -1, last_idx = -1;
> > > > +	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
> > > >  
> > > >  	for (i = 0; i < nr; i++) {
> > > >  		if (cmds[i].p_type == PT_LOAD) {
> > > > -			last_idx = i;
> > > > -			if (first_idx == -1)
> > > > +			/*
> > > > +			 * The PT_LOAD segments are not necessarily ordered
> > > > +			 * by vaddr. Make sure that we get the segment with
> > > > +			 * minimum vaddr (maximum vaddr respectively)
> > > > +			 */
> > > > +			if (cmds[i].p_vaddr <= min_vaddr) {
> > > >  				first_idx = i;
> > > > +				min_vaddr = cmds[i].p_vaddr;
> > > > +			}
> > > > +			if (cmds[i].p_vaddr >= max_vaddr) {
> > > > +				last_idx = i;
> > > > +				max_vaddr = cmds[i].p_vaddr;
> > > > +			}
> > > >  		}
> > > >  	}
> > > >  	if (first_idx == -1)
> > > >  		return 0;
> > > >  
> > > > -	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
> > > > -				ELF_PAGESTART(cmds[first_idx].p_vaddr);
> > > > +	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
> > > >  }
> > > >  
> > > >  static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
> > > > -- 
> > > > 2.34.1
> > > 
> > > -- 
> > > Kees Cook
> > 
> > -- 
> > Kees Cook

-- 
Kees Cook
