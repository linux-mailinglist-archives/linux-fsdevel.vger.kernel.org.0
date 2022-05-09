Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22851F2BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 04:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiEIDAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiEIC56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 22:57:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3C981645
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 19:54:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n18so12606754plg.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 May 2022 19:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZTTQaK1MCP0Shiup/o7qs7DSoxAGZcC20JNp/8zusXE=;
        b=lvu0tqEAYL4lMpXHlUzMzuGrVzNiSN1F7GkTpaXG15DPrHT1CKlKmPTSyxU7h/NV/j
         kUWsTNFP/67CPMC2uOZi3lJkE0lLp5sDkHR5Vg4ZoLQibwozZlVvVrWAmrcTfYRpX//B
         IUvdewS9yYA2LSGRsdHGz3Vy9in8L82rvGFwD3Zc8rtXp9G3nFfXed3dmePb2uW74wWS
         gjRGNoAkLLOEaS+JIVqDdXS8Khp2rr6+h+bGKqkjlK7OSgl+ubpQebutmaP5tiQRi8Kq
         5jTLundScFrLcZoaaz36HUq3ybV0gU6aQtsrRhtprHTBJRtzsvzNZ5USFQbLHaHia+ap
         v4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZTTQaK1MCP0Shiup/o7qs7DSoxAGZcC20JNp/8zusXE=;
        b=DX+PMDZZTmjbsMtPdgZ8YwCMAvWxU78F2hp0pSqJvzztvxiRuvefsNe8gYTjLhoOcL
         OE9gyxkyuIk+WVE4hM6CIdPUo1Vzm7au5iBeVABM/dBvJ94O6zIu3u7dS8HqePpM2Nlv
         cLpWWukQp/q3wuycsUHXfWxBd38H9D1IlyQWWi78FllzGN4tBdeSuEGPTpCWbLJOq9At
         ZcUIzwLZEen9yRj1zjopZ89NcTSWfJ6uuQglkQ1lnamd3RbLabXcoBehlTutXxjhbulq
         HjQ57wa1eOGt54eBarvhWUbAjmCxo+sGYAfFqvwk8F6aufvR6TDePpyMMCHEev3oGrM5
         RRGg==
X-Gm-Message-State: AOAM5337rUytrQD/EoDkgXYzO2NK0qxrItq38edx8IlFfG+bKSwPk+pV
        sG2Al8ENgKMLXSNxcozqijC3ww==
X-Google-Smtp-Source: ABdhPJy7zWNcQupxAcYMUNYtQ/R40mo+W7VEUJcoJcHH9ByfyOdtqYbfEKoLlg6WSLCwLEQ+8OB54A==
X-Received: by 2002:a17:902:d2c9:b0:15e:b28d:8ad2 with SMTP id n9-20020a170902d2c900b0015eb28d8ad2mr14262241plc.94.1652064845269;
        Sun, 08 May 2022 19:54:05 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902e29200b0015e8d4eb258sm5783241plc.162.2022.05.08.19.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 19:54:04 -0700 (PDT)
Date:   Mon, 9 May 2022 10:54:00 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        mike.kravetz@oracle.com, akpm@linux-foundation.org, sj@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/3] Introduce new huge_ptep_get_access_flags()
 interface
Message-ID: <YniCSGvBeUq3yxCg@FVFYT0MHHV2J.usts.net>
References: <cover.1651998586.git.baolin.wang@linux.alibaba.com>
 <Ynf5Aje8FXlPdOSl@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ynf5Aje8FXlPdOSl@casper.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 08, 2022 at 06:08:18PM +0100, Matthew Wilcox wrote:
> On Sun, May 08, 2022 at 04:58:51PM +0800, Baolin Wang wrote:
> > As Mike pointed out [1], the huge_ptep_get() will only return one specific
> > pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
> > will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
> > size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
> > size hugetlb page for those functions that want to check the dirty or
> > young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
> > get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
> > will also get inaccurate access statistics.
> > 
> > To fix this issue, one approach is that we can define an ARM64 specific huge_ptep_get()
> > implementation, which will take into account any subpages' dirty or young bits.
> > However we should add a new parameter for ARM64 specific huge_ptep_get() to check
> > how many continuous PTEs or PMDs in this CONT-PTE/PMD size hugetlb, that means we
> > should convert all the places using huge_ptep_get(), meanwhile most places using
> > huge_ptep_get() did not care about the dirty or young flags at all.
> > 
> > So instead of changing the prototype of huge_ptep_get(), this patch set introduces
> > a new huge_ptep_get_access_flags() interface and define an ARM64 specific implementation,
> > that will take into account any subpages' dirty or young bits for CONT-PTE/PMD size
> > hugetlb page. And we can only change to use huge_ptep_get_access_flags() for those
> > functions that care about the dirty or young flags of a hugetlb page.
> 
> I question whether this is the right approach.  I understand that
> different hardware implementations have different requirements here,
> but at least one that I'm aware of (AMD Zen 2/3) requires that all
> PTEs that are part of a contig PTE must have identical A/D bits.  Now,
> you could say that's irrelevant because it's x86 and we don't currently
> support contPTE on x86, but I wouldn't be surprised to see that other
> hardware has the same requirement.
> 
> So what if we make that a Linux requirement?  Setting a contPTE dirty or
> accessed becomes a bit more expensive (although still one/two cachelines,
> so not really much more expensive than a single write).  Then there's no
> need to change the "get" side of things because they're always identical.
> 
> It does mean that we can't take advantage of hardware setting A/D bits,
> unless hardware can be persuaded to behave this way.  I don't have any
> ARM specs in front of me to check.
>

I have looked at the comments in get_clear_flush() (in arch/arm64/mm/hugetlbpage.c).
That says:

	/*
	 * If HW_AFDBM is enabled, then the HW could turn on
	 * the dirty or accessed bit for any page in the set,
	 * so check them all.
	 */

Unfortunately, the AD bits are not identical in all subpages.

Thanks.
