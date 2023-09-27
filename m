Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288357B0EBF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0WDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 18:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjI0WDe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:03:34 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26721102
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 15:03:32 -0700 (PDT)
Date:   Wed, 27 Sep 2023 18:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695852210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MhiClaLDYKhigvirakBlbf0dDxnkM6jHInnEhxD/nM4=;
        b=ZZ2UH24d0LNxPqymHB1ytC2ZGy8d/FJGtv0QbYnlExpB6qJY9tTOf+WXhm/qltDlLRhczU
        1a5FyXUGdAcBZDdPVr3TV/H3L3vDI/GCX23L82Yxw9lRzznc48bDv9SRh9OzrfVm0w0kgi
        jR9DiWs7eQ7edx0e/AJrDo/SJhRKoIw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, djwong@kernel.org
Subject: Re: [PATCH 2/2] bcachefs: remove writeback bio size limit
Message-ID: <20230927220326.jcu4d4khpfjsn6qd@moria.home.lan>
References: <20230927112338.262207-1-bfoster@redhat.com>
 <20230927112338.262207-3-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927112338.262207-3-bfoster@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 07:23:38AM -0400, Brian Foster wrote:
> The bcachefs folio writeback code includes a bio full check as well
> as a fixed size check when it determines whether to submit the
> current write op or continue to add to the current bio. The current
> code submits prematurely when the current folio fits exactly in the
> remaining space allowed in the current bio, which typically results
> in an extent merge that would have otherwise been unnecessary. This
> can be observed with a buffered write sized exactly to the current
> maximum value (1MB) and with key_merging_disabled=1. The latter
> prevents the merge from the second write such that a subsequent
> check of the extent list shows a 1020k extent followed by a
> contiguous 4k extent.
> 
> It's not totally clear why the fixed write size check exists.
> bio_full() already checks that the bio can accommodate the current
> dirty range being processed, so the only other concern is write
> latency. Even then, a 1MB cap seems rather small. For reference,
> iomap includes a folio batch size (of 4k) to mitigate latency
> associated with writeback completion folio processing, but that
> restricts writeback bios to somewhere in the range of 16MB-256MB
> depending on folio size (i.e. considering 4k to 64k pages). Unless
> there is some known reason for it, remove the size limit and rely on
> bio_full() to cap the size of the bio.

We definitely need some sort of a cap; otherwise, there's nothing
preventing us from building up gigabyte+ bios (multipage bvecs, large
folios), and we don't want that.

This probably needs to be a sysctl - better would be a hint provided by
the filesystem based on the performance characteristics of the
device(s), but the writeback code doesn't know which device we're
writing to so that'll be tricky to plumb.

iomap has IOEND_BATCH_SIZE, which is another hard coded limit; perhaps
iomap could use the new sysctl as well.

> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  fs/bcachefs/fs-io-buffered.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
> index 58ccc7b91ac7..d438b93a3a30 100644
> --- a/fs/bcachefs/fs-io-buffered.c
> +++ b/fs/bcachefs/fs-io-buffered.c
> @@ -607,8 +607,6 @@ static int __bch2_writepage(struct folio *folio,
>  		if (w->io &&
>  		    (w->io->op.res.nr_replicas != nr_replicas_this_write ||
>  		     bio_full(&w->io->op.wbio.bio, sectors << 9) ||
> -		     w->io->op.wbio.bio.bi_iter.bi_size + (sectors << 9) >=
> -		     (BIO_MAX_VECS * PAGE_SIZE) ||
>  		     bio_end_sector(&w->io->op.wbio.bio) != sector))
>  			bch2_writepage_do_io(w);
>  
> -- 
> 2.41.0
> 
