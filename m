Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2718F84B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 16:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCWPKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 11:10:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCWPKz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IB3P5+UfxQRnNJV3ZF77i5LAuSfIu3wVRUAEfbs+W3A=; b=k7jBRmY4RBVpLAi7OONy34+ahO
        Z3ukezy3jpfoleQ2MowcBNthbF0ZBa4Icm5BqDjJcCj7u2GqN3Qn/i7kn01CAV2r5TIgYJRQXwEd4
        rIfiiuAfsnU6rk5lECpRet8JvFz5OA3KH1xh6X/sD1YyaL5mXeb1OTgPvS6cTaQZeL6jLjCpmHgCj
        idCsI7SAcCeo5t30D4gUQ0QgkVQd5+sIHinlYCq/WaP/fdtRL9YL0pDRPdu00gj9xq5lWw+XATvpj
        9FJd6vMTXHi0tfyxey/i1YWg/JEgkPHM50M7rIvr7/V00sXOzvYnRfiYPiaHgT5fWDRXBB2RMGrZp
        Vo3T+rHw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGOj8-0007Re-QJ; Mon, 23 Mar 2020 15:10:55 +0000
Date:   Mon, 23 Mar 2020 08:10:54 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: Do not use GFP_NORETRY to allocate BIOs
Message-ID: <20200323151054.GI4971@bombadil.infradead.org>
References: <20200323131244.29435-1-willy@infradead.org>
 <20200323132052.GA7683@infradead.org>
 <20200323134032.GH4971@bombadil.infradead.org>
 <20200323135500.GA14335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323135500.GA14335@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 23, 2020 at 06:55:00AM -0700, Christoph Hellwig wrote:
> On Mon, Mar 23, 2020 at 06:40:32AM -0700, Matthew Wilcox wrote:
> > Oh, I see that now.  It uses readahead_gfp_mask(), and I was grepping for
> > GFP_NORETRY so I didn't spot it.  It falls back to block_read_full_page()
> > which we can't do.  That will allocate smaller BIOs, so there's an argument
> > that we should do the same.  How about this:
> 
> That looks silly to me.  This just means we'll keep iterating over
> small bios for readahead..  Either we just ignore the different gfp
> mask, or we need to go all the way and handle errors, although that
> doesn't really look nice.

I'm not sure it's silly, although I'd love to see bio_alloc() support
nr_iovecs == 0 meaning "allocate me any size biovec and tell me what
size I got in ->bi_max_vecs".  By allocating a small biovec this time,
we do one allocation rather than two, and maybe by the time we come to
allocate the next readahead bio, kswapd will have succeeded in freeing
up more memory for us.
