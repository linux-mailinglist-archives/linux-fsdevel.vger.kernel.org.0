Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385D63EC401
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhHNRHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhHNRHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 13:07:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F1AC061764;
        Sat, 14 Aug 2021 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N9Yv2av3cpyv3lJbvKZNeQlU7TaQP8VpMldoCKFJq8k=; b=hQ+oYO7a1shonLjP7Cn0NzXSqZ
        vv+8E0DmbARYhOfI5154UkFS3yh+j7O90EJYchLMpF7V1uNiEfBFr22KCiT3iCuXynwPGcrR6LTZh
        ZyPdEFwZjxwNfr4wMXOXpPCcDx/HjQCwrL+eALaLWdzcADJuqFvQx6tt9CVlDv+LTf1VXCLgmkp09
        XlmaS4LDT2pM2sprqtS1+XoDNCLaM78OeJhGgEQ15SHBGGM8Vqe26RqQPvothSiQfuNSEQoHrvz5B
        snbAg51ztzmkLuV37jQGJoNXgPX5Rl8VY267ldcQdkNt6N3Rc6eWkob9lwD+EbDgMdxDmsYW6jlnR
        sdZQnpvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEx6l-00GrzN-7C; Sat, 14 Aug 2021 17:06:15 +0000
Date:   Sat, 14 Aug 2021 18:06:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 052/138] mm: Add folio_raw_mapping()
Message-ID: <YRf3/8xtVzTZiKNu@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-53-willy@infradead.org>
 <ceeeaac4-c8c5-3b03-66da-6deec35c501b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceeeaac4-c8c5-3b03-66da-6deec35c501b@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 03:59:06PM +0200, Vlastimil Babka wrote:
> On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> > Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
> > It's only a couple of instructions (load and mask), so it's definitely
> > going to be cheaper to inline it than call it.  Leave page_rmapping
> > out of line.
> 
> Maybe mention the page_anon_vma() in changelog too?

Convert __page_rmapping to folio_raw_mapping and move it to mm/internal.h.
It's only a couple of instructions (load and mask), so it's definitely
going to be cheaper to inline it than call it.  Leave page_rmapping
out of line.  Change page_anon_vma() to not call folio_raw_mapping() --
it's more efficient to do the subtraction than the mask.
