Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB660258780
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 07:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAFeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 01:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAFea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:34:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C7C061290;
        Mon, 31 Aug 2020 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZSo4Kk3lGyfakbzAOPf8+T3dlZFXdTrrp8cG3ND3CNc=; b=N0law7ZrT/Xc3xr2dooUsCVfPc
        nZkvh3GnonhgfEn5o5VQ6gOZA65oAMMu5Iz9sI+Z3RWX/372JQxqtjkiXBBGTmgCuugQECYCkv1+u
        Q7LmtbnpzGMZxpYhvM3KfSmgZwj10w1zrk/m5Njt/q2fKA5CtBErJfDWv5hINfAyY0Jjp2i5p4IIl
        TGdGrjgtvxwY7t2CGWm+NZWgQVECHmx/gmN1L6VeSNUVJO7IK+bw8FkuDLmi9OG6NkjvXI+zGvW6s
        ibS07B5cYF8p7v5Dx+gbtRN7Pg7NqvkVqahCgo3F6tehsPKsz9MlrCZmh7kFZ96T8vA4Rt8M1vWk4
        5439Eg7w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCyw6-0007KE-DH; Tue, 01 Sep 2020 05:34:26 +0000
Date:   Tue, 1 Sep 2020 06:34:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Message-ID: <20200901053426.GB24560@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
 <20200824151700.16097-5-willy@infradead.org>
 <20200827084431.GA15909@infradead.org>
 <20200831194837.GJ14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831194837.GJ14765@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 08:48:37PM +0100, Matthew Wilcox wrote:
> static void iomap_read_end_io(struct bio *bio)
> {
>         int i, error = blk_status_to_errno(bio->bi_status);
> 
>         for (i = 0; i < bio->bi_vcnt; i++) {
>                 struct bio_vec *bvec = &bio->bi_io_vec[i];

This should probably use bio_for_each_bvec_all instead of directly
poking into the bio.  I'd also be tempted to move the loop body into
a separate helper, but that's just a slight stylistic preference.

>                 size_t offset = bvec->bv_offset;
>                 size_t length = bvec->bv_len;
>                 struct page *page = bvec->bv_page;
> 
>                 while (length > 0) { 
>                         size_t count = thp_size(page) - offset;
>                         
>                         if (count > length)
>                                 count = length;
>                         iomap_read_page_end_io(page, offset, count, error);
>                         page += (offset + count) / PAGE_SIZE;

Shouldn't the page_size here be thp_size?

> Maybe I'm missing something important here, but it's significantly
> simpler code -- iomap_read_end_io() goes down from 816 bytes to 560 bytes
> (256 bytes less!) iomap_read_page_end_io is inlined into it both before
> and after.

Yes, that's exactly why I think avoiding bio_for_each_segment_all is
a good idea in general.

> There is some weirdness going on with regards to bv_offset that I don't
> quite understand.  In the original bvec_advance:
> 
>                 bv->bv_page = bvec->bv_page + (bvec->bv_offset >> PAGE_SHIFT);
>                 bv->bv_offset = bvec->bv_offset & ~PAGE_MASK;
> 
> which I cargo-culted into bvec_thp_advance as:
> 
>                 bv->bv_page = thp_head(bvec->bv_page +
>                                 (bvec->bv_offset >> PAGE_SHIFT));
>                 page_size = thp_size(bv->bv_page);
>                 bv->bv_offset = bvec->bv_offset -
>                                 (bv->bv_page - bvec->bv_page) * PAGE_SIZE;
> 
> Is it possible to have a bvec with an offset that is larger than the
> size of bv_page?  That doesn't seem like a useful thing to do, but
> if that needs to be supported, then the code up top doesn't do that.
> We maybe gain a little bit by counting length down to 0 instead of
> counting it up to bv_len.  I dunno; reading the code over now, it
> doesn't seem like that much of a difference.

Drivers can absolutely see a bv_offset that is larger due to bio
splitting.  However the submitting file system should never see one
unless it creates one, which would be stupid.

And yes, eventually bv_page and bv_offset should be replaced with a

	phys_addr_t		bv_phys;

and life would become simpler in many places (and the bvec would
shrink for most common setups as well).

For now I'd end up with something like:

static void iomap_read_end_bvec(struct page *page, size_t offset,
		size_t length, int error)
{
	while (length > 0) {
		size_t page_size = thp_size(page);
		size_t count = min(page_size - offset, length);

		iomap_read_page_end_io(page, offset, count, error);

		page += (offset + count) / page_size;
		length -= count;
		offset = 0;
	}
}

static void iomap_read_end_io(struct bio *bio)
{
	int i, error = blk_status_to_errno(bio->bi_status);
	struct bio_vec *bvec;

	bio_for_each_bvec_all(bvec, bio, i)
		iomap_read_end_bvec(bvec->bv_page, bvec->bv_offset,
				    bvec->bv_len, error;
        bio_put(bio);
}

and maybe even merge iomap_read_page_end_io into iomap_read_end_bvec.
