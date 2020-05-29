Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112AB1E7DBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgE2NAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 09:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2NAA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 09:00:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0DEC03E969;
        Fri, 29 May 2020 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l/qkj8tMYwtIaBu15gPjj4VBQ48s7vLokGN1nW8kiMA=; b=kSB6Njf2csdnZ+gPGw+MDMqUsI
        Yti6WRTTtXYzJyvjMP0j5kFjJQoGMM6pPl5lGbudf/uBJcXd2W7FD8ySnZI0sXHOHeWSiQTYeW/qf
        34fh3xdw3V1QBK2EYaEB3zkr+pg+zNb3Q9d9mt6w8k3mM14mlBwya7ytCiAKRDCb/wIoZsz9zcg7N
        7dfjPQJv5G59EeNxJhiW0wsPnlKB0uHl0lueH2M0Ep6ceCNKum4GRqiOeXFqN+5oASydJvKE1fZz2
        3+lHZjG2IUGkc7HfZEeYda6RKUfH3FUedGMzjALNFHooqg4VKtNVPpyk/nr3QQ5+hDV+EHMT4viJT
        XxoHbe3g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeecB-0004rz-Pg; Fri, 29 May 2020 12:59:59 +0000
Date:   Fri, 29 May 2020 05:59:59 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/36] mm: Introduce offset_in_thp
Message-ID: <20200529125959.GB19604@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-7-willy@infradead.org>
 <20200522171517.dltsre7vfdvcrd2m@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522171517.dltsre7vfdvcrd2m@box>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 08:15:17PM +0300, Kirill A. Shutemov wrote:
> On Fri, May 15, 2020 at 06:16:26AM -0700, Matthew Wilcox wrote:
> > +#define offset_in_thp(page, p)	((unsigned long)(p) & (thp_size(page) - 1))
> 
> Looks like thp_mask() would be handy here.

It's not the only place we could use a thp_mask(), but PAGE_MASK is the
inverse of what I think it should be:

include/asm-generic/page.h:#define PAGE_MASK    (~(PAGE_SIZE-1))

ie addr & PAGE_MASK returns the address aligned to page size, not the
offset within the page.  Given this ambiguity, I'm inclined to leave
it as (thp_size(page) - 1), as it's clear which bits we're masking off.
