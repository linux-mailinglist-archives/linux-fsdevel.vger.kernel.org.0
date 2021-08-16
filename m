Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6133ECCF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 05:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbhHPDD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 23:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhHPDDy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 23:03:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6AEC061764;
        Sun, 15 Aug 2021 20:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sgTeGggd6fSczx52WtMtKzxx473Mj1eHW70jX24joX8=; b=h8xL57ZMQftS7cRG+UsZycv7aT
        ircyrqajjyn4sB/0lFCcuF6C0VFrsbnwoctiiyrIgZbiio4nFnhDY15xgjIZxwE7pAUAyPNCfEoQk
        EbWtajs63ibGia+h+hTB1+TjzwO68arEatNVoloEC0eOI3xc2hkRYGdXASTPIHiT8NFeBJEc405Th
        4e0DSljoUFCUK9xlACucn50K0CA35cUQ9gdNqO01ShRcuKG80GDzHCKCgXhRTjpuV6vgzQKYyh6Tw
        CHDMdkzP52QHfmYbB8PQWXxjwwcHsWw5W3ghZiggaw3JlUou1Dj+KCiWiFjkEAoatnaCTmIPeI0WK
        b/P6Qsdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFStp-000tom-LL; Mon, 16 Aug 2021 03:03:00 +0000
Date:   Mon, 16 Aug 2021 04:02:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 088/138] mm/filemap: Add filemap_get_folio
Message-ID: <YRnVXaZDNuBnyLA4@casper.infradead.org>
References: <20210715033704.692967-89-willy@infradead.org>
 <20210715033704.692967-1-willy@infradead.org>
 <1815135.1628633133@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1815135.1628633133@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:05:33PM +0100, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> > filemap_get_folio() is a replacement for find_get_page().
> > Turn pagecache_get_page() into a wrapper around __filemap_get_folio().
> > Remove find_lock_head() as this use case is now covered by
> > filemap_get_folio().
> > 
> > Reduces overall kernel size by 209 bytes.  __filemap_get_folio() is
> > 316 bytes shorter than pagecache_get_page() was, but the new
> > pagecache_get_page() is 99 bytes
> 
> longer, one presumes.

In total -- the old pagecache_get_page() turns into
__filemap_get_folio(), but the wrapper is 99 bytes in size.

Added the word "wrapper" to make this clearer.
