Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1268359C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 19:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjAaStO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjAaStF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:49:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE3AD0E;
        Tue, 31 Jan 2023 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bp1srOOlc5HEApehtt7EJwx+t0Jni/2mYYi7TJa5tYw=; b=dUHpHXITsZ77ywOGjiYY+l+jlD
        N69XtD/wQfHxdcor7ruO5SUbDimd4gSGGrH+c1WEhAO6tkCcTa7eLQczzJ2pVAx6V8adxZHACqfTv
        cnVnyIuOxsA+Y7EDoUdeSDOlrtRmeQUbiTvHn0Cr3qdBrA5Jaw5tTiYJpbyuVAlzR+N8Un67LOAW6
        DG/+XP0ZP26f6j7YK1ixztNOlmd246bduFJupLKvnaGFQaUHL4wQicfyNYeB33sRlfXd6TGaF5RGp
        0et6ldylkFWWu9cCXXrEnNa4ixQhfl9YsZosTEmNpc+NvKI/Il0bsxQsfdSof5z75lbZpl/zIKH5j
        qNGwU1hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMvgM-00BZTO-6N; Tue, 31 Jan 2023 18:48:38 +0000
Date:   Tue, 31 Jan 2023 18:48:38 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv2 1/3] iomap: Move creation of iomap_page early in
 __iomap_write_begin
Message-ID: <Y9lihmePkCHWHrlI@casper.infradead.org>
References: <cover.1675093524.git.ritesh.list@gmail.com>
 <d879704250b5f890a755873aefe3171cbd193ae9.1675093524.git.ritesh.list@gmail.com>
 <Y9f4MFzpFEi73E6P@infradead.org>
 <20230130202150.pfohy5yg6dtu64ce@rh-tp>
 <Y9gv0YV9V6gR9l3F@casper.infradead.org>
 <20230131183725.m7yoh7st5pplilvq@rh-tp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131183725.m7yoh7st5pplilvq@rh-tp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 12:07:25AM +0530, Ritesh Harjani (IBM) wrote:
> On 23/01/30 09:00PM, Matthew Wilcox wrote:
> > On Tue, Jan 31, 2023 at 01:51:50AM +0530, Ritesh Harjani (IBM) wrote:
> > > > > Thus the iop structure will only gets allocated at the time of writeback
> > > > > in iomap_writepage_map(). This I think, was a not problem till now since
> > > > > we anyway only track uptodate status in iop (no support of tracking
> > > > > dirty bitmap status which later patches will add), and we also end up
> > > > > setting all the bits in iomap_page_create(), if the page is uptodate.
> > > >
> > > > delayed iop allocation is a feature and not a bug.  We might have to
> > > > refine the criteria for sub-page dirty tracking, but in general having
> > > > the iop allocates is a memory and performance overhead and should be
> > > > avoided as much as possible.  In fact I still have some unfinished
> > > > work to allocate it even more lazily.
> > >
> > > So, what I meant here was that the commit[1] chaged the behavior/functionality
> > > without indenting to. I agree it's not a bug.
> >
> > It didn't change the behaviour or functionality.  It broke your patches,
> > but it certainly doesn't deserve its own commit reverting it -- because
> > it's not wrong.
> >
> > > But when I added dirty bitmap tracking support, I couldn't understand for
> > > sometime on why were we allocating iop only at the time of writeback.
> > > And it was due to a small line change which somehow slipped into this commit [1].
> > > Hence I made this as a seperate patch so that it doesn't slip through again w/o
> > > getting noticed/review.
> >
> > It didn't "slip through".  It was intended.
> >
> > > Thanks for the info on the lazy allocation work. Yes, though it is not a bug, but
> > > with subpage dirty tracking in iop->state[], if we end up allocating iop only
> > > at the time of writeback, than that might cause some performance degradation
> > > compared to, if we allocat iop at ->write_begin() and mark the required dirty
> > > bit ranges in ->write_end(). Like how we do in this patch series.
> > > (Ofcourse it is true only for bs < ps use case).
> > >
> > > [1]: https://lore.kernel.org/all/20220623175157.1715274-5-shr@fb.com/
> >
> > You absolutely can allocate it in iomap_write_begin, but you can avoid
> > allocating it until writeback time if (pos, len) entirely overlap the
> > folio.  ie:
> >
> > 	if (pos > folio_pos(folio) ||
> > 	    pos + len < folio_pos(folio) + folio_size(folio))
> > 		iop = iomap_page_create(iter->inode, folio, iter->flags, false);
> 
> Thanks for the suggestion. However do you think it will be better if this is
> introduced along with lazy allocation changes which Christoph was mentioning
> about?
> Why I am thinking that is because, with above approach we delay the allocation
> of iop until writeback, for entire folio overlap case. But then later
> in __iomap_write_begin(), we require iop if folio is not uptodate.
> Hence we again will have to do some checks to see if the iop is not allocated
> then allocate it (which is for entire folio overlap case).
> That somehow looked like an overkill for a very little gain in the context of
> this patch series. Kindly let me know your thoughts on this.

Look at *why* __iomap_write_begin() allocates an iop.  It's to read in the
blocks which are going to be partially-overwritten by the write.  If the
write overlaps the entire folio, there are no parts which need to be read
in, and we can simply return.  Maybe we should make that more obvious:

	if (folio_test_uptodate(folio))
		return 0;
	if (pos <= folio_pos(folio) &&
	    pos + len >= folio_pos(folio) + folio_size(folio))
		return 0;
	folio_clear_error(folio);

(I think pos must always be >= folio_pos(), so that <= could be ==, but
it doesn't hurt anything to use <=)
