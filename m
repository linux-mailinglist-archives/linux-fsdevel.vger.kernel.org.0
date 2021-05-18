Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F194387A7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 May 2021 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbhERN6H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 May 2021 09:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244711AbhERN6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 May 2021 09:58:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00136C061573;
        Tue, 18 May 2021 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s36KeDCQTjjdbNaJPGBotFdZABcZ6K5ODWo6m4Tm+Tk=; b=GqjuVupZZdr7ohq92vjExxWC+g
        KjLHczLGtrzn+kflb9uaLoM58CsWOaU3r7Cx0z2WF6g6sEbXwdRMoYmqwifZW78vP/4lDjS+ECaLR
        Dzu25YK8li9B3wL9Se6+DF+yIeajG9fEz9oJyjDPVs4mj7tRQZx4+8iaEJlgHhvFM6LBlh9TQCwMm
        dYMEgmU5O/ZFrjzBw2orErotQStBgt6pdPxwu0TnxEZi5fnBiI//9W6rKbrUe3U+DsakXXYUP0E+1
        l64I2NE9EinIchynh3B85IqlbRungbuGsGaYTe+xMsmTyoWPlHFOBkQ/6itoeELUSGFrNjncNtKJ5
        eEeTIijA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lj0Bu-00E28c-OY; Tue, 18 May 2021 13:56:05 +0000
Date:   Tue, 18 May 2021 14:55:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v10 27/33] mm/writeback: Add folio_wait_stable
Message-ID: <YKPHSulXmAldvrDq@casper.infradead.org>
References: <20210511214735.1836149-1-willy@infradead.org>
 <20210511214735.1836149-28-willy@infradead.org>
 <f87c35b1-4755-de51-1ce7-7f1deccee44c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87c35b1-4755-de51-1ce7-7f1deccee44c@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 18, 2021 at 01:42:04PM +0200, Vlastimil Babka wrote:
> On 5/11/21 11:47 PM, Matthew Wilcox (Oracle) wrote:
> > Move wait_for_stable_page() into the folio compatibility file.
> > folio_wait_stable() avoids a call to compound_head() and is 14 bytes
> > smaller than wait_for_stable_page() was.  The net text size grows by 24
> > bytes as a result of this patch.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Acked-by: Jeff Layton <jlayton@kernel.org>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> This seems to remove last user of thp_head(). Remove it as obsolete?

Good catch!  I'll squash that in.  We're down to just one user of
thp_order in my tree ...
