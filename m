Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE5258214
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgHaTsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 15:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgHaTsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 15:48:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A3EC061573;
        Mon, 31 Aug 2020 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lCbGSkGKUU8F1R9YT3KZ6FWEFaUZVzQp7ByD3Mg/eQQ=; b=bb8HY1CGR7xPK7g0ER8gDDtzKm
        sKjn7irzf13v6WwDkgC7bZ9M13Lr7/uV57MqN7evtV3T8kIwluG+Nh6586EmE6u4Zl1oe/1g5YwkZ
        G3BklKMwixfU1DZEB9kuG4WF9UfnokgdHuG1g7RN6dfTOYxdueQ0AA9nwxKZjF3iDZYb/nT1KpRPB
        eV+DiNM7n6yCr3TzsGzNN9anwQQ2eucwFJM9A2cPRmBGR8v+W2lC49CLKjhYEAFsB5PMjRxyCxFaJ
        i331AdMA94NOUHyFPg0J75g7EIPdNVzx1yoh/pS6FCNFPRsP4ctt3cCS+9czLdMsuBg+Guh1DK0I5
        jS6KwdyA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCpnB-0000ZU-5D; Mon, 31 Aug 2020 19:48:37 +0000
Date:   Mon, 31 Aug 2020 20:48:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Message-ID: <20200831194837.GJ14765@casper.infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
 <20200824151700.16097-5-willy@infradead.org>
 <20200827084431.GA15909@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827084431.GA15909@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:44:31AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 24, 2020 at 04:16:53PM +0100, Matthew Wilcox (Oracle) wrote:
> > Iterate once for each THP instead of once for each base page.
> 
> FYI, I've always been wondering if bio_for_each_segment_all is the
> right interface for the I/O completions, because we generally don't
> need the fake bvecs for each page.  Only the first page can have an
> offset, and only the last page can be end earlier than the end of
> the page size.
> 
> It would seem way more efficient to just have a helper that extracts
> the offset and end, and just use that in a loop that does the way
> cheaper iteration over the physical addresses only.  This might (or
> might) not be a good time to switch to that model for iomap.

Something like this?

static void iomap_read_end_io(struct bio *bio)
{
        int i, error = blk_status_to_errno(bio->bi_status);

        for (i = 0; i < bio->bi_vcnt; i++) {
                struct bio_vec *bvec = &bio->bi_io_vec[i];
                size_t offset = bvec->bv_offset;
                size_t length = bvec->bv_len;
                struct page *page = bvec->bv_page;

                while (length > 0) { 
                        size_t count = thp_size(page) - offset;
                        
                        if (count > length)
                                count = length;
                        iomap_read_page_end_io(page, offset, count, error);
                        page += (offset + count) / PAGE_SIZE;
                        length -= count;
                        offset = 0;
                }
        }

        bio_put(bio);
}

Maybe I'm missing something important here, but it's significantly
simpler code -- iomap_read_end_io() goes down from 816 bytes to 560 bytes
(256 bytes less!) iomap_read_page_end_io is inlined into it both before
and after.

There is some weirdness going on with regards to bv_offset that I don't
quite understand.  In the original bvec_advance:

                bv->bv_page = bvec->bv_page + (bvec->bv_offset >> PAGE_SHIFT);
                bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;

which I cargo-culted into bvec_thp_advance as:

                bv->bv_page = thp_head(bvec->bv_page +
                                (bvec->bv_offset >> PAGE_SHIFT));
                page_size = thp_size(bv->bv_page);
                bv->bv_offset = bvec->bv_offset -
                                (bv->bv_page - bvec->bv_page) * PAGE_SIZE;

Is it possible to have a bvec with an offset that is larger than the
size of bv_page?  That doesn't seem like a useful thing to do, but
if that needs to be supported, then the code up top doesn't do that.
We maybe gain a little bit by counting length down to 0 instead of
counting it up to bv_len.  I dunno; reading the code over now, it
doesn't seem like that much of a difference.

Maybe you meant something different?
