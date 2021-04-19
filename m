Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E764636447B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 15:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbhDSN2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 09:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242101AbhDSN0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:26:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2EEC06134E;
        Mon, 19 Apr 2021 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7/RKG+19pxf8L5NAMnjkraL88KOOFMdlzuOOrjxSYDA=; b=alsWn3P5Lp9G6X9Jyv9ZZfPHEX
        gO9Zfo4rg77Qbv/qHepxOaro966jbcG8DT3lY+OMN7Pf1FFvmZBUMBNrWQiHP2ZOKdqm+2djYmNOT
        t1qUlWhyLD4RISUX7IJTyiVhihv9V5ja2Kb4DhyeP4fRt1dDD0Djjp8nvJWk2KzWn4ehtM9ueSfbP
        LEQkP5WyAdYgNZ9VmkzJuZDd+8KRNgF8HBUTwfNRx6pEk056t7i5wqV8I/LuQbK5CaUJPpPFsWjJZ
        jOIHUbOd4caFg1xPh4F1TgBN/XcbneWoxMqIrZCKAAK3wRZFyan1gsXbTU6wx91LWAVqFht690B/4
        LrHMFzpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYTuN-009y5K-0P; Mon, 19 Apr 2021 13:25:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5273C300223;
        Mon, 19 Apr 2021 15:25:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 447932C23A96D; Mon, 19 Apr 2021 15:25:46 +0200 (CEST)
Date:   Mon, 19 Apr 2021 15:25:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v7 09/28] mm: Create FolioFlags
Message-ID: <YH2E2jNvhEOwCinT@hirez.programming.kicks-ass.net>
References: <20210409185105.188284-1-willy@infradead.org>
 <20210409185105.188284-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409185105.188284-10-willy@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 09, 2021 at 07:50:46PM +0100, Matthew Wilcox (Oracle) wrote:
> These new functions are the folio analogues of the PageFlags functions.
> If CONFIG_DEBUG_VM_PGFLAGS is enabled, we check the folio is not a tail
> page at every invocation.  Note that this will also catch the PagePoisoned
> case as a poisoned page has every bit set, which would include PageTail.
> 
> This saves 1727 bytes of text with the distro-derived config that
> I'm testing due to removing a double call to compound_head() in
> PageSwapCache().

I vote for dropping the Camels if we're going to rework all this.
