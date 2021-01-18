Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA72FACED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 22:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394415AbhARVnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 16:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388645AbhARVnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 16:43:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C7C061573;
        Mon, 18 Jan 2021 13:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jyoij0RsS5818dRxwbFzHUwXraId823WtMIOT0DRHDU=; b=VzVcYihCG2lQP/J+Q1f+x03Lb9
        t98+gi+/CgDqKJW57GasOmXfZ3X/Ontf1Jy+h/Vufi5B7DBL/HO/K7pli0GoxlhgV4CWuP8HVAA+p
        UEsGaHbKjGVwlYGofoUPnuvNO73ROV5shc4ls71ZVzf2Dh11tGvjQ+id/8rPf6jHuBSAKONc3bR6i
        Rzn2GPfmu17eKyqf8RZUDJBIXZv6b54wvSN8Mhm05NsnaCjlAF5rUJ7Z+lpbUgR5IQ18hs+ZoxhDn
        zbAHC8NJ+gHgwD7F5WV/s27g3iR6VIXzaHQaQtXv2xZT50RWD4R4/xzGZzwMaf6TpjBHnMTqwhVci
        YdKB8mjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1cHJ-00DRHV-4I; Mon, 18 Jan 2021 21:41:39 +0000
Date:   Mon, 18 Jan 2021 21:41:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        avi@scylladb.com
Subject: Re: [PATCH 10/11] iomap: add a IOMAP_DIO_UNALIGNED flag
Message-ID: <20210118214137.GG2260413@casper.infradead.org>
References: <20210118193516.2915706-1-hch@lst.de>
 <20210118193516.2915706-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118193516.2915706-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 18, 2021 at 08:35:15PM +0100, Christoph Hellwig wrote:
> Add a flag to signal an I/O that is not file system block aligned.
> +	if (dio_flags & IOMAP_DIO_UNALIGNED) {

There are a number of things that DIO has to be aligned to -- memory
addresses, for example.  Can we be a little more verbose about what is
unaligned here?  eg

	if (dio_flags & IOMAP_DIO_FS_UNALIGNED)

(or FSBLK_UNALIGNED, or ... something).

