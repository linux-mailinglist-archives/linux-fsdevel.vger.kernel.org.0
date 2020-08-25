Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B668A250E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 03:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHYBGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 21:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHYBGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:06:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A50C061574;
        Mon, 24 Aug 2020 18:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xzdunZmDdu/tuWxDqIrXIq5mvQShEvSrh2WBDyB9JHs=; b=Gw+T08pM8yf5l2lRbR+PV/GPw3
        a6J9xQN1X7CiVASDZBWQD8ZppaZXqkQmDbsY581gBBycjBYuteqT7aX3oPt0ssNMy+zftlITNbp+P
        ITlxwxxr9UGu+F9v2lAfvo5b2ObAkB3iIZ22h+r8F0dwJMaHQWi6kxy9YTjhtbUxsaLVjVgklnglb
        NELmocqxLdHU+OcFcUVu4XvPPRjS0TB3CcOWM0qqvDwxP4nQ5RsHj5EQAxVxyD+Ows1Y9RwbcphjD
        ZijhXNt5TQr9INGaJI6KBsKOO5ZSsAzSWygUjx7nkf06fpYBpEAViN0kTIPfg3jlRVePv7iGpfItQ
        31Y9Ay2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kANPZ-00088W-KT; Tue, 25 Aug 2020 01:06:05 +0000
Date:   Tue, 25 Aug 2020 02:06:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200825010605.GJ17456@casper.infradead.org>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-9-willy@infradead.org>
 <20200825001223.GH12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825001223.GH12131@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:12:23AM +1000, Dave Chinner wrote:
> > -static int
> > -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> > -		unsigned copied, struct page *page)
> > +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> > +		size_t copied, struct page *page)
> >  {
> 
> Please leave the function declarations formatted the same way as
> they currently are. They are done that way intentionally so it is
> easy to grep for function definitions. Not to mention is't much
> easier to read than when the function name is commingled into the
> multiline paramener list like...

I understand that's true for XFS, but it's not true throughout the
rest of the kernel.  This file isn't even consistent:

buffered-io.c:static inline struct iomap_page *to_iomap_page(struct page *page)
buffered-io.c:static inline bool iomap_block_needs_zeroing(struct inode
buffered-io.c:static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
buffered-io.c:static void iomap_writepage_end_bio(struct bio *bio)
buffered-io.c:static int __init iomap_init(void)

(i just grepped for ^static so there're other functions not covered by this)

The other fs/iomap/ files are equally inconsistent.

