Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301AB73FAE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 13:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjF0LQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 07:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjF0LQj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 07:16:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD1626B9;
        Tue, 27 Jun 2023 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q55zNrWcWX1seCjDV15l5s1oxcHr7EHzoCwODPWQFB8=; b=GrNr0wF+UWMj9j/CemXePQbh2f
        UhyC+Z4kB+Q53ASus8GloxIp1c3MAarYTkW2nRn1swIualKPTLxdDCNqALlZBU3llcHyZQrf2vfIz
        7yePy40bFfiPCAEngGlQqdCZq0UcizDiWEh15qjp/Rt8YjrnzQpR89Ob8z/udsYAVb1YBDG2izgu3
        KxhBTGtRSTRLdJlVoKNWU03M6MdgzokM2XoHTIITgQk2Lz0L8PM7rwydCgkKBkn/nOF95YZKBGvtr
        QlSzZiRwHKadmIku2zVxtEj+AMiO3hHut6DtYkic76BoD2BulNflsSdrlTghATY6aNuvEQrUglZkY
        OYojYUww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qE6gU-002egV-Sn; Tue, 27 Jun 2023 11:16:34 +0000
Date:   Tue, 27 Jun 2023 12:16:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 03/12] writeback: Factor should_writeback_folio() out of
 write_cache_pages()
Message-ID: <ZJrFEto4BbLB+ubt@casper.infradead.org>
References: <20230626173521.459345-1-willy@infradead.org>
 <20230626173521.459345-4-willy@infradead.org>
 <ZJphl4Ws4QzitTny@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJphl4Ws4QzitTny@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 09:12:07PM -0700, Christoph Hellwig wrote:
> > +	if (folio_test_writeback(folio)) {
> > +		if (wbc->sync_mode != WB_SYNC_NONE)
> > +			folio_wait_writeback(folio);
> > +		else
> > +			return false;
> > +	}
> 
> Please reorder this to avoid the else and return earlier while you're
> at it:
> 
> 	if (folio_test_writeback(folio)) {
> 		if (wbc->sync_mode == WB_SYNC_NONE)
> 			return false;
> 		folio_wait_writeback(folio);
> 	}

Sure, that makes sense.

> (that's what actually got me started on my little cleanup spree while
> checking some details of the writeback waiting..)

This might be a good point to share that I'm considering (eventually)
not taking the folio lock here.

My plan looks something like this (not fully baked):

truncation (and similar) paths currently lock the folio,  They would both
lock the folio _and_ claim that they were doing writeback on the folio.

Filesystems would receive the folio from the writeback iterator with
the writeback flag already set.


This allows, eg, folio mapping/unmapping to take place completely
independent of writeback.  That seems like a good thing; I can't see
why the two should be connected.

> > +	BUG_ON(folio_test_writeback(folio));
> > +	if (!folio_clear_dirty_for_io(folio))
> > +		return false;
> > +
> > +	return true;
> 
> ..
> 
> 	return folio_clear_dirty_for_io(folio);
> 
> ?

I did consider that, but there's a nice symmetry to the code the way it's
currently written, and that took precedence in my mind over "fewer lines
of code".  There's nothing intrinsic about folio_clear_dirty_for_io()
being the last condition to be checked (is there?  We have to
redirty_for_io if we decide to not start writeback), so it seemed to
make sense to leave space to add more conditions.
