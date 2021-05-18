Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3D387A13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbhERNhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbhERNhj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 09:37:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B434C061756;
        Tue, 18 May 2021 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H//by0SeCqYqsx1Zt0OwZMGgLE8Rb7GwOiwBk+sMcPU=; b=rcQd2jIGLy0lT7aYMqYer0JaB4
        lQ3D1sem6bs+9gVom1VdpOIkD38TqglN3KZPOf+c8h/J+drqthK8VNRZxCQvoMqSO+LDN83QN+nfa
        58cV38hz6xmzFUtnVnh2sZl/A9X0wt1KP+ZAhgLm7z8A3R+V7fTw8EgvT2zpKQuZCdakPpRHxFtHa
        PSNle7Zash+tZyQAqOG3Z0HAAsp2QyVGJ0bjqXEpKTAB3Fo7qRQSnbZi0Kk5YF6KevefqOR3DULIR
        K6yaaPV7x/MFqNj03ZuLyTpSXM4a/xvSIrjJfqp5NGU42q0e/T2w8sZoimZpsnjGQ/8v+yfAIL5t5
        G9JErTlA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lizsw-00E1Hd-IJ; Tue, 18 May 2021 13:35:54 +0000
Date:   Tue, 18 May 2021 14:35:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 22/33] mm/filemap: Add __folio_lock_or_retry
Message-ID: <YKPCsoYexbwCOaTF@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-23-willy@infradead.org>
 <76184de4-4ab9-0f04-ab37-8637f4b22566@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76184de4-4ab9-0f04-ab37-8637f4b22566@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 12:38:46PM +0200, Vlastimil Babka wrote:
> > -int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
> > +int __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
> >  			 unsigned int flags)
> >  {
> > -	struct folio *folio = page_folio(page);
> > -
> >  	if (fault_flag_allow_retry_first(flags)) {
> >  		/*
> >  		 * CAUTION! In this case, mmap_lock is not released
> 
> A bit later in this branch, 'page' is accessed, but it no longer exists. And
> thus as expected, it doesn't compile. Assuming it's fixed later, but
> bisectability etc...

Oops.  Thanks for catching that; I've reordered this patch and the
folio_wait_locked() patch, which makes the entire problem go away.

