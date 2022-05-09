Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC42551FF1F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236732AbiEIOLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 10:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiEIOLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 10:11:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9953E219F53
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HTdq0BPscXmTsFbbuYV43XVdwvRwRVUcGXTkIEGWAKE=; b=QccbNV/tWK90NKwSbXx1wxAr/w
        9jVI8NunLdpZUdF6eZFjFHmCNniO0TYPDnY2MSyLlPhu6zrE2FqtT1K25x6vxo/n2eHNnbvQoHOz3
        ROYj74tsVahz9RFcsiW1rKjeccD3oEGF+tfDiXAI/+3Y3lzJ8LTDb8pJiIHtgKmky67I/u+honS8/
        shmIOwT28n5RgY7gPw6j8RpCzqoAmDwUQycGZVI2XRl6cTkIplmtLi5MD1YeIalh2sWz/SgnBwMha
        KGpNN/KCHbdvpnLuW4jA6Eu0XOcC9mioLudQyIoGrKdpqmA2rPZY/M+OE2eENiJrf6E54JBiyj5tX
        iTw7gORQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1no42i-003VpW-UF; Mon, 09 May 2022 14:07:20 +0000
Date:   Mon, 9 May 2022 15:07:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/37] ext4: Convert ext4 to read_folio
Message-ID: <YnkgGJdQpT6UZtI3@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
 <20220508203131.667959-19-willy@infradead.org>
 <YnkXjPZMSC+yYGOe@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnkXjPZMSC+yYGOe@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 09:30:52AM -0400, Theodore Ts'o wrote:
> On Sun, May 08, 2022 at 09:31:12PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is a "weak" conversion which converts straight back to using pages.
> > A full conversion should be performed at some point, hopefully by
> > someone familiar with the filesystem.
> 
> What worries me about the "weak" conversion is that ext4_read_folio()
> (formerly ext4_read_page()) is going to completely the wrong thing if
> the folio contains more than a single page.  This seems to
> be... scary.  How are callers of aops->read_folio() supposed to know
> whether the right thing or the wrong thing will happen if a random
> folio is passed to aops->read_folio()?

I'm probably answering these emails out of order, but the page
cache is absolutely not supposed to be creating large folios for
filesystems that haven't indicated their support for such by calling
mapping_set_large_folios().  We could assert that in every filesystem,
but it's on the same scale as asserting that page (or folio) != NULL
and page->mapping != NULL.  Filesystems should trust the VFS to obey
its rules.  Obviously this is a new rule, so people aren't as familiar
with it as "you can rely on the page to not be truncated while we're
calling readpage" or "the page is locked on entry to these aops".
