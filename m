Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5191355B000
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jun 2022 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiFZHo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jun 2022 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbiFZHoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:44:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACE311A2D;
        Sun, 26 Jun 2022 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZYf9S+9v8SssB2f7SI0aLipRvyLjpdyjZAR4xNwIlyA=; b=ku+r4DqZkB95/Xfmh9ue6cm+09
        CyOJKQrOsW5u38sU/yT0ordtzA+/36HzICae4wQDfFz2S+Hbn5laa+W58cHSq5nsw9ipLZBhM3hNJ
        mXF+/5KDpW3EpisCVvR/XT04v0kdwEIr/NbG8Gznzxnrgcre+KeUy/4U2wO3EW4cPCpzcGr7sZHu4
        G5qwtDrH1THEWNH3Y/cvkvBxQihfsVriRfNB5vflSLMXblFCTZcFF8+Yvxqhcd26i6lzK4QaFpaDi
        Bn+3NT5N/eBtb5v+o6f9b2xcqVfF+oWNL2sc+ddYWmhqUodeV8wXtxU1nuUXbY0dI+3z1TddPdJIk
        AQTuUgeQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5MwN-00ARUE-Bk; Sun, 26 Jun 2022 07:44:19 +0000
Date:   Sun, 26 Jun 2022 00:44:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Avi Kivity <avi@scylladb.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Message-ID: <YrgOUw6YM2c6k59U@infradead.org>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
 <6c06b2d4-2d96-c4a6-7aca-5147a91e7cf2@scylladb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c06b2d4-2d96-c4a6-7aca-5147a91e7cf2@scylladb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 19, 2022 at 02:30:47PM +0300, Avi Kivity wrote:
> > * stx_dio_offset_align: the alignment (in bytes) required for file
> >    offsets and I/O segment lengths for DIO, or 0 if DIO is not supported
> >    on the file.  This will only be nonzero if stx_dio_mem_align is
> >    nonzero, and vice versa.
> 
> 
> If you consider AIO, this is actually three alignments:
> 
> 1. offset alignment for reads (sector size in XFS)
> 
> 2. offset alignment for overwrites (sector size in XFS since ed1128c2d0c87e,
> block size earlier)
> 
> 3. offset alignment for appending writes (block size)
> 
> 
> This is critical for linux-aio since violation of these alignments will
> stall the io_submit system call. Perhaps io_uring handles it better by
> bouncing to a workqueue, but there is a significant performance and latency
> penalty for that.

I think you are mixing things up here.  We actually have two limits that
matter:

 a) the hard limit, which if violated will return an error.
    This has been sector size for all common file systems for years,
    but can be bigger than that with fscrypt in the game (which
    triggered this series)
 b) an optimal write size, which can be done asynchronous and
    without exclusive locking.
    This is what your cases 2) and 3) above refer to.

Exposting this additional optimal performance size might be a good idea
in addition to what is proposed here, even if matters a little less
with io_uring.  But I'm not sure I'd additional split it into append
vs overwrite vs hole filling but just round up to the maximum of those.
