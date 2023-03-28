Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7C6CB2CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjC1AZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1AZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 20:25:12 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A5B1FC1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bw7fVv06z8aVoJfo/5LiVvYUAlMoLPGwWGnociTlCSQ=; b=B2by3VO1iiGL9FVZd2NGNyi7kI
        1AczvhRXTUop1HLRbIykiQ1ahb99nPL/H91lyOuu4p3WZGlBis6jr0yQGd69bg7tkF3W6eM/umq9I
        hFCOnjspRdLrR2vZC5CHFqGKL5yxIUYXwOinJdqryIjobWNbgrtZGRC3TmWKQDPLmTqJIgw4OuMz9
        tm1twcfvwXzQI/RSI0MvI56tXRNidK6UgJ4u4eJw17TYev1q6nimgrLtu4qcOlOkmXQgyy/Hyd395
        oXkDb7+WyLtXb9+16JH7k2CAhKxWDPlmjqyoMrbA379i6TT0YtbVFDnZLj+ajh3Sc2W4KB1eowAPN
        havO24Tg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pgx9B-002YpW-2g;
        Tue, 28 Mar 2023 00:25:10 +0000
Date:   Tue, 28 Mar 2023 01:25:09 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        brauner@kernel.org
Subject: Re: [PATCH 3/3] iov_iter: import single vector iovecs as ITER_UBUF
Message-ID: <20230328002509.GK3390869@ZenIV>
References: <20230327232713.313974-1-axboe@kernel.dk>
 <20230327232713.313974-4-axboe@kernel.dk>
 <20230328000811.GJ3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328000811.GJ3390869@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:08:11AM +0100, Al Viro wrote:
> On Mon, Mar 27, 2023 at 05:27:13PM -0600, Jens Axboe wrote:
> > Add a special case to __import_iovec(), which imports a single segment
> > iovec as an ITER_UBUF rather than an ITER_IOVEC. ITER_UBUF is cheaper
> > to iterate than ITER_IOVEC, and for a single segment iovec, there's no
> > point in using a segmented iterator.
> 
> Won't that enforce the "single-segment readv() is always identical to
> read()"?  We'd been through that before - some of infinibarf drvivers
> have two different command sets, one reached via read(), another - via
> readv().  It's a userland ABI.  Misdesigned one, but that's infinibarf
> for you.
> 
> Does anyone really need this particular microoptimization?

static ssize_t qib_write_iter(struct kiocb *iocb, struct iov_iter *from)
{
        struct qib_filedata *fp = iocb->ki_filp->private_data;
	struct qib_ctxtdata *rcd = ctxt_fp(iocb->ki_filp);
	struct qib_user_sdma_queue *pq = fp->pq;

	if (!iter_is_iovec(from) || !from->nr_segs || !pq)
		return -EINVAL;

	return qib_user_sdma_writev(rcd, pq, from->iov, from->nr_segs);
}

Hit this with single-segment writev() and you've got yourself -EINVAL.
Sure, that could be adjusted for (check for user_backed_iter(), then
if it's ubuf form an iovec and pass that to qib_user_sdma_writev()),
but that's a clear regression.

Found by simple grepping for iter_is_iovec()...
