Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7101D4A2CA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jan 2022 08:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiA2Hx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Jan 2022 02:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241538AbiA2Hx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:53:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20280C061714;
        Fri, 28 Jan 2022 23:53:26 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id s5so24059296ejx.2;
        Fri, 28 Jan 2022 23:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V3C0z5IroBeiguIOSKAcKVGNuToGvGjPgBbl6Yl9zMg=;
        b=RHdxMon+ZeVk8FQ16CpIIzWiFwQK5GU7XDGx7jyddHtRJSrMZhULKzMZqaOz5MZdR+
         SZ0gzxdxgVysXWiwSQANZ2rk7mHqS7Z+X8LEQYtvK+0nzbgrmKgL2V3vn/2A5jHBnzct
         DlXBzp2DTpRxofYGuPPnL0G2KxXHvf1uGll23z94RoddPMw9BKbqzKeN9JrgF3lGN4kW
         rZDoZ35AwW5L4JCqPeBOulMuax9j1WWOrXT5t74hwjZJwCdQnNB4V5XkJPA4qdAGYIE5
         XAYHsUYHqlNAC6toswV/q3YIMc3RUDFxPppOM7P9XvZSazFx60oIYlZarvk3Q/wOdit8
         FD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V3C0z5IroBeiguIOSKAcKVGNuToGvGjPgBbl6Yl9zMg=;
        b=0JtCJe8rBXI37Uw2qtB5iQ3GbDtvEyTe/ARLoCWznFZHDzeiVP6fnFcQQA+flA/mFc
         +qxyemA5IcbicyFUnkJVbwcO/WpOu205FXSrYhVEybs3wZlyxAmnSSZOvTu0kVJD2D7m
         WlH25wrejbWmFGxVxv3ZbHgKbG0SPq5M74PEGMOA//Brok2HZIu4eNpN12VqXJm5y6WE
         H1XkU75IDC2oAX3DWRZj3UNpFwkzA099nNF6Mp/uqO2IK6mSy3gvrFwksCq4F2n2X5eV
         S4RrxTVrRYarjwQg/zq3Su1Oz6p0pOGcur3hILILEiZqr/CL71b0MyrBCIzKREy4I7vg
         2hbw==
X-Gm-Message-State: AOAM53323nK/C8uPcBQpbUkFiFSvJfDzWWQgC0e2m1dVKEU9xEC2RA1b
        BWJudtwseIz6xJkqzwT/Ig==
X-Google-Smtp-Source: ABdhPJwf+Gs1yWgNFnDVGNxI23Nmulb7bzJe/lxP0QWRmQrOA9fyGgLwu3ss5qdxBrjTbQdumIX8hg==
X-Received: by 2002:a17:906:1f57:: with SMTP id d23mr9528448ejk.693.1643442804455;
        Fri, 28 Jan 2022 23:53:24 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.3])
        by smtp.gmail.com with ESMTPSA id j15sm10757736ejx.199.2022.01.28.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 23:53:23 -0800 (PST)
Date:   Sat, 29 Jan 2022 10:53:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <YfTychdtyCdslrEY@localhost.localdomain>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202201281347.F36AEA5B61@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 02:30:12PM -0800, Kees Cook wrote:
> On Fri, Jan 28, 2022 at 09:26:09AM +0100, Magnus Groß wrote:
> > On Wed, Jan 26, 2022 at 10:31:42PM -0800 Kees Cook wrote:
> > > On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > > > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groß wrote:
> > > > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > > > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > > > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > > > MIME-Version: 1.0
> > > > > Content-Type: text/plain; charset=UTF-8
> > > > > Content-Transfer-Encoding: 8bit
> > > > > 
> > > > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > > > > 
> > > > > Specifically consider an ELF binary with the following PT_LOAD segments:
> > > > > 
> > > > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > > > > 
> > > > > Note how the last segment is actually the first segment and vice versa.
> > > > > 
> > > > > Since total_mapping_size() only computes the difference between the
> > > > > first and the last segment in the order that they appear, it will return
> > > > > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > > > > did not happen before that change.
> > > > > 
> > > > > Strictly speaking total_mapping_size() made that assumption already
> > > > > before that patch, but the issue did not appear because the old
> > > > > load_addr_set guards never allowed this call to total_mapping_size().
> > > > > 
> > > > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > > > fix this by comparing the correct first and last segments in
> > > > > total_mapping_size().
> > > > 
> > > > Ah, nice. Yeah, this is good.
> > > > 
> > > > > Signed-off-by: Magnus Groß <magnus.gross@rwth-aachen.de>
> > > > 
> > > > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > > > Cc: stable@vger.kernel.org
> > > > Acked-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Andrew, can you pick this up too?
> > > 
> > > -Kees
> > > 
> > 
> > May I also propose to include this patch in whatever mailing-list
> > corresponds to the 5.16.x bugfix series?
> > It turns out that almost all native Linux games published by the Virtual
> > Programming company have this kind of weird PT_LOAD ordering including
> > the famous Bioshock Infinite, so right now those games are all
> > completely broken since Linux 5.16.
> > 
> > P.S.: Someone should probably ask Virtual Programming, what kind of
> > tooling they use to create such convoluted ELF binaries.
> 
> Oh, actually, this was independently fixed:
> https://lore.kernel.org/all/YVmd7D0M6G/DcP4O@localhost.localdomain/

Oh wow, I accidently fixed real bug.

> Alexey, you never answered by question about why we can't use a proper
> type and leave the ELF_PAGESTART() macros alone:
> https://lore.kernel.org/all/202110071038.B589687@keescook/
> 
> I still don't like the use of "int" in ELF_PAGESTART(), but I agree
> it shouldn't cause a problem. I just really don't like mixing a signed
> type with address calculations, from a robustness perspective.

It is very robust. There are 2 ways to mask pointers

	unsigned long & ~(unsigned long)-1

	or

	unsigned long & ~(int)-1

Both work. Second variant works for uint32_t too.

As I wrote in that thread, this macro

	#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))

is slightly incorrect because type of the expression can be (unsigned long)
but it logically should be typeof(v). Now fixing by switching to ALIGN
doesn't do anything because ALIGN has the same problem.
And fixing ALIGN requires to go through thousands of usages, which is
way too much for one localised ELF fix.

	PT_ALEXEY
