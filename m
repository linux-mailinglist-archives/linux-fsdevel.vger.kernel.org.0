Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E4257F1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHaQ5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 12:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgHaQ5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:57:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EC5C061573;
        Mon, 31 Aug 2020 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kEfHhU2EdJZ5RPXXYFu+fxz9H6I+sVnd5sT285hYjLU=; b=f25rpX+hOe6xkdFm727OhW/ha6
        qgzb4JV3m+Ob73RcInKTbjTaFuxQEGRqJq3kROoHjVG+dloVMBNmsT5pqBP50iiAZ/Ftyk166jJdG
        ZCMF3iMu/d+v4qyCi0iHr3UnRHoSFJRLhJFujRuBYSZqSIMStugGBRrjPDDhxlm9KGlKEZtdreETg
        4mHz7yDo4fO2/SOQyUoO+T/J3S59Zx8Re7OSVZOu9vrtR1n+UBBTAikLGAGKzWutrjTeUr0Ll5xKk
        nX3Oe3OBX/2Vp1KJLF1SwNRMD2IRn2kCRa9tVckd93u5+oFtpZARAXO9dWME8OTDB6nZF/OgyevYg
        rEbZLc9A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCn75-0005lV-JI; Mon, 31 Aug 2020 16:56:59 +0000
Date:   Mon, 31 Aug 2020 17:56:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
Message-ID: <20200831165659.GH14765@casper.infradead.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
 <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
 <87o8mq6aao.fsf@mail.parknet.co.jp>
 <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4010690f-20ad-f7ba-b595-2e07b0fa2d94@kernel.dk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:39:26AM -0600, Jens Axboe wrote:
> We really should ensure that ->io_pages is always set, imho, instead of
> having to work-around it in other spots.

Interestingly, there are only three places in the entire kernel which
_use_ bdi->io_pages.  FAT, Verity and the pagecache readahead code.

Verity:
                        unsigned long num_ra_pages =
                                min_t(unsigned long, num_blocks_to_hash - i,
                                      inode->i_sb->s_bdi->io_pages);

FAT:
        if (ra_pages > sb->s_bdi->io_pages)
                ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);

Pagecache:
        max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
and
        if (req_size > max_pages && bdi->io_pages > max_pages)
                max_pages = min(req_size, bdi->io_pages);

The funny thing is that all three are using it differently.  Verity is
taking io_pages to be the maximum amount to readahead.  FAT is using
it as the unit of readahead (round down to the previous multiple) and
the pagecache uses it to limit reads that exceed the current per-file
readahead limit (but allows per-file readahead to exceed io_pages,
in which case it has no effect).

So how should it be used?  My inclination is to say that the pagecache
is right, by virtue of being the most-used.

