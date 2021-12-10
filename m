Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F024706DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbhLJRXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 12:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236205AbhLJRXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:23:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9AFC061746;
        Fri, 10 Dec 2021 09:20:09 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 68D2ECE2C1E;
        Fri, 10 Dec 2021 17:20:07 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9417560C4B;
        Fri, 10 Dec 2021 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1639156805;
        bh=pv3ZYrotcb0uW7lV6hIkQGuAyq/RUhIrnAgbae5vAIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MDFk4gU9evOWaGId7xWHaNPUy1NOOEWwfxBj2LFa+8l7e5EnRxBC8UNL12W55Oz4g
         8LeRvgYdlwXrxveGzScE8Mn3xZp6Tg3va1OGbJsSM6bg/xHMYrHGteYEsx62QdPajR
         2f0zu0tuHQzkiDxAhJzwskovryvrWq3wFRZs8OSM=
Date:   Fri, 10 Dec 2021 09:20:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: delete unsafe BUG from page_cache_add_speculative()
Message-Id: <20211210092003.cf84354b406a47253afc868c@linux-foundation.org>
In-Reply-To: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
References: <8b98fc6f-3439-8614-c3f3-945c659a1aba@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 8 Dec 2021 23:19:18 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> It is not easily reproducible, but on 5.16-rc I have several times hit
> the VM_BUG_ON_PAGE(PageTail(page), page) in page_cache_add_speculative():
> usually from filemap_get_read_batch() for an ext4 read, yesterday from
> next_uptodate_page() from filemap_map_pages() for a shmem fault.
> 
> That BUG used to be placed where page_ref_add_unless() had succeeded,
> but now it is placed before folio_ref_add_unless() is attempted: that
> is not safe, since it is only the acquired reference which makes the
> page safe from racing THP collapse or split.
> 
> We could keep the BUG, checking PageTail only when folio_ref_try_add_rcu()
> has succeeded; but I don't think it adds much value - just delete it.
> 
> Fixes: 020853b6f5ea ("mm: Add folio_try_get_rcu()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

I added cc:stable to this.
