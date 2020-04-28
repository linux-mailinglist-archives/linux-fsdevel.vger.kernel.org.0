Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F6C1BB5D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 07:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgD1FVi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 01:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725917AbgD1FVh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:21:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F83C03C1A9;
        Mon, 27 Apr 2020 22:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=btOt+GJLXunt0yTMMtppqrdFkNuz4JVhPhDALsvkRkA=; b=kz5m517ctvWWh0t+4t+NNx9Rkl
        oSOdlk3JhkkXMDaa1VXuyAuOlgzyjrq+DfEknFCzMsNsNY5Y11InfWh1vPzPfatUmjLvaIt+vuyJ7
        UjVnIOCXBM+KbNMLyHebA828UmsFNiFJ4M+556kOcvZpoViWvsHil2m5CkXcO5J5Qpa+N4z5ORNKF
        SJtdsfnm2D+NUex27zd3t0dsPhZMOzLWY4+NYcDsQTzWVp9eAQxz4w6HYzBAgdHV2epdrEUQgn20a
        jtZtq0M/x7iQLMizoT6OXUEY/2Vt6UyCtDMCx1tEOo/VMDd7gBUh36aJT/v98gAZEmK75nZJQvdue
        Ivt3QYjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTIgb-0007Fy-Dl; Tue, 28 Apr 2020 05:21:37 +0000
Date:   Mon, 27 Apr 2020 22:21:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v10 03/12] block: Inline encryption support for blk-mq
Message-ID: <20200428052137.GA18572@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-4-satyat@google.com>
 <20200422093502.GB12290@infradead.org>
 <20200428025400.GB52406@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428025400.GB52406@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:54:00AM +0000, Satya Tangirala wrote:
> It's modified by additions in the next patch in the series and I
> thought I should introduce the function with the final type from the
> get go - is that alright?

It is probably ok, let me review the next patch in more detail.

> > >  	__blk_queue_split(q, &bio, &nr_segs);
> > > @@ -2011,6 +2015,15 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
> > >  
> > >  	blk_mq_bio_to_request(rq, bio, nr_segs);
> > >  
> > > +	ret = blk_crypto_init_request(rq);
> > > +	if (ret != BLK_STS_OK) {
> > > +		bio->bi_status = ret;
> > > +		bio_endio(bio);
> > > +		blk_mq_free_request(rq);
> > > +		return BLK_QC_T_NONE;
> > > +	}
> > 
> > Didn't Eric have a comment last round that we shoul dtry this before
> > attaching the bio to simplify error handling?
> > 
> In the previous round, I believe Eric commented that I should call
> blk_crypto_init_request after bio_to_request so that we can do away
> with some of the arguments to blk_crypto_init_request and also a
> boilerplate function used only while calling blk_crypto_init_request.
> I realize you wrote "And we can fail just the request on an error, so
> yes this doesn't seem too bad." in response to this particular
> comment of Eric's, and it seems I might not actually have understood
> what that meant - did you have something in mind different from what I'm
> doing here?

No, this looks ok, sorry for the noise.
