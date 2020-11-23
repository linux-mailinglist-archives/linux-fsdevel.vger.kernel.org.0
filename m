Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6762C0117
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 09:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgKWIFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 03:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKWIFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:05:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584CC0613CF;
        Mon, 23 Nov 2020 00:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6vGNH6/LtgD9H2B7jY2SC28nVQh3dS5TfEwthu4Yqq0=; b=ZAqo9NfKjGkL2SJi0Et2eFTHHn
        SyVCEbdUmUIfwpdvBuuWvFBs+XXOd7k1xLJehh+E7u1OeHRW7tdsHvERCOFJ18rpuaDwZrh2Bpf4p
        GHifpGgC0MOM2Cj739hSkfHtJxZ7U412O1Tzn65r8/mLOHMADt9YJdfREPFf2EtryGT+OIY+r4Nz1
        WBeADPY66kCsCM8yUaREC77lOZ09vI2AT1QsaaFr1N1hHvNXhVevUpoQ2ZnJ531G4XlESqBTwNfAN
        9Se0TiLHstfosyW2NcAEDqbCjU1U+jZvKjRy4hDToRxwrdt597/uGrDfWAgjbGxLFhVXqyo8FblrG
        HduUcWMw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh6qQ-000852-Hy; Mon, 23 Nov 2020 08:05:06 +0000
Date:   Mon, 23 Nov 2020 08:05:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
Message-ID: <20201123080506.GA30578@infradead.org>
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 21, 2020 at 02:13:30PM +0000, David Howells wrote:
> Switch to using a table of operations.  In a future patch the individual
> methods will be split up by type.  For the moment, however, the ops tables
> just jump directly to the old functions - which are now static.  Inline
> wrappers are provided to jump through the hooks.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Please run performance tests.  I think the indirect calls could totally
wreck things like high performance direct I/O, especially using io_uring
on x86.
