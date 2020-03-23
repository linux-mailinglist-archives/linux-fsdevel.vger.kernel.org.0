Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8441118FA65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 17:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCWQvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 12:51:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCWQvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qnJsiFUlsfG8nkEwHXI5fzoOQxcwHFVgXJE/nh17pk0=; b=AQJe4ivEzUOJlvzK5K7/6UDM6h
        6tAkMU38DjI9eXGNTxmbPBBRViHAijPG5Z/PY02NV011PZ6vqM1nac7qQqCoT/YDZFqgIWJlvVv1z
        XNjAuda6PPtSRKmXQFV/LyD2+uPwppZdAuTiGHjUmOXVnGRASz0GkVuFIBe5Bj0k+90wwgqz7CUmA
        wr7gXc2ErLDPNpwXgHs0I0Xa88zUjEFYE1UfU7Y3Shz29mZ2rDSzl1uw2vkDGMnBR33ZSGlyYLIk/
        m5GdGT8Xid80WcUJ0uf6JA8IuOdS/8T16rOgBYCVM0fV4hJoCbC7xH9AHahfZmLCDTmWMUfLaCgpG
        FQ2w9C4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGQIs-0001GS-1m; Mon, 23 Mar 2020 16:51:54 +0000
Date:   Mon, 23 Mar 2020 09:51:54 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Message-ID: <20200323165154.GB30433@infradead.org>
References: <20200323131244.29435-1-willy@infradead.org>
 <20200323132052.GA7683@infradead.org>
 <20200323134032.GH4971@bombadil.infradead.org>
 <20200323135500.GA14335@infradead.org>
 <20200323151054.GI4971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323151054.GI4971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:10:54AM -0700, Matthew Wilcox wrote:
> > That looks silly to me.  This just means we'll keep iterating over
> > small bios for readahead..  Either we just ignore the different gfp
> > mask, or we need to go all the way and handle errors, although that
> > doesn't really look nice.
> 
> I'm not sure it's silly,

Oh well, I'm not going to be in the way of fixing a bug I added.  So
feel free to go ahead with this and mention it matches mpage_readpages.

> although I'd love to see bio_alloc() support
> nr_iovecs == 0 meaning "allocate me any size biovec and tell me what
> size I got in ->bi_max_vecs".  By allocating a small biovec this time,
> we do one allocation rather than two, and maybe by the time we come to
> allocate the next readahead bio, kswapd will have succeeded in freeing
> up more memory for us.

Sounds easy enough - especially as callers don't need to look at
bi_max_vecs anyway, that is the job of bio_add_page and friends.  That
being said an upper bound still sounds useful - no need to allocate
a a gigantic bio if we know we only need a few pages.
