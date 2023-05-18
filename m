Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CF3707A2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 08:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjERGQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERGQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 02:16:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBEE52;
        Wed, 17 May 2023 23:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QALLuOQcWW4dlcG4HIZmL/vxfPES0OG44dfdvKT13CM=; b=0W2sTALnYleACOaKgsL96SBt8u
        J3x0L0zI7QDyeRElmqJZvUaMsdwgvNGMUCuOW+RRfKbKSiWV3K+nz/L2WN7OMHqxjIry6t/CDIOF3
        bejYz2VpCh9MplD6tOrUSgI5RLZCljBnDl6+/5m+JEYECahO1TM6J6Q+MLrHtA97cD/HRIzHVYyUS
        lJQaEezuKBSaMR4AziCvrTuxYLxXY/P4jWY4kWTeq1dFUE/xTZDma7RABoOJCUKd0wG7vDHdQS1wk
        Qp25gCEYfHPmiR1dKK4JhBdfRDGJ3nUOWXXv+onzob8RuKYPv27d+CXn3+vo9xSuRIQctqU9JLOKq
        m+TgYaYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzWwF-00C2v0-0l;
        Thu, 18 May 2023 06:16:35 +0000
Date:   Wed, 17 May 2023 23:16:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 2/5] iomap: Refactor iop_set_range_uptodate() function
Message-ID: <ZGXCw7OHfKQ9TNiW@infradead.org>
References: <cover.1683485700.git.ritesh.list@gmail.com>
 <203a9e25873f6c94c9de89823439aa1f6a7dc714.1683485700.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a9e25873f6c94c9de89823439aa1f6a7dc714.1683485700.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (iop) {
> +		spin_lock_irqsave(&iop->uptodate_lock, flags);
> +		bitmap_set(iop->uptodate, first_blk, nr_blks);
> +		if (bitmap_full(iop->uptodate,
> +				i_blocks_per_folio(inode, folio)))
> +			folio_mark_uptodate(folio);
> +		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
> +	} else {
> +		folio_mark_uptodate(folio);
> +	}

If we did a:

	if (!iop) {
		folio_mark_uptodate(folio);
		return;
	}

we can remove a leel of identation and keep thing a bit simpler.
But I can live with either style.

