Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A343B733799
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 19:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbjFPRp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 13:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344108AbjFPRpv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:45:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979E2D76;
        Fri, 16 Jun 2023 10:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wf7h14C/ndjCaTHxfnwQbBH5ggMqQ/dM131PuzIFEgI=; b=RFWpXvWB+okzpPAwuSC2IX/DMU
        HaeW90j0Fyeo1BhZAd5QC5a2Bcm5rQIj4UcmC5RioX/c7fYYNKlgI+xQuesmFgGUW/C1ojjULMV9+
        DvgPs2FoT5PPA/skslZ2W7CPIOy1+nmSKtr4ozO+TWX5C+x0wfA/XZSQl26h0sgFsU1S2ISnNzI2V
        WGbugW5Q6mXc6OrpkpwzHTR59f+EV0cLEH3/z9FO931ZoipqPJGWdRUadbQNLWf3qa82F966O8tHV
        VTnijrlu5GiRpYAaoHjcVVqPe7IbTIOenthL2hRCZeKzwr9/wggWl1dV+2lZokdV4Rxo386/rOjDJ
        9V7Ydq1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qADW3-009Ddp-SC; Fri, 16 Jun 2023 17:45:43 +0000
Date:   Fri, 16 Jun 2023 18:45:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 6/8] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZIyfx+ISChR8S+fC@casper.infradead.org>
References: <20230612203910.724378-1-willy@infradead.org>
 <20230612203910.724378-7-willy@infradead.org>
 <ZIeg4Uak9meY1tZ7@dread.disaster.area>
 <ZIe7i4kklXphsfu0@casper.infradead.org>
 <ZIfGpWYNA1yd5K/l@dread.disaster.area>
 <ZIfNrnUsJbcWGSD8@casper.infradead.org>
 <ZIggux3yxAudUSB1@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIggux3yxAudUSB1@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 13, 2023 at 05:54:35PM +1000, Dave Chinner wrote:
> If I hadn't looked at the code closely and saw a trace with this
> sort of behaviour (i.e. I understood large folios were in use,
> but not exactly how they worked), I'd be very surprised to see a
> weird repeated pattern of varying folio sizes. I'd probably think
> it was a bug in the implementation....
> 
> > I'd prefer the low-risk approach for now; we can change it later!
> 
> That's fine by me - just document the limitations and expected
> behaviour in the code rather than expect people to have to discover
> this behaviour for themselves.

How about this?

+++ b/include/linux/pagemap.h
@@ -548,6 +548,17 @@ typedef unsigned int __bitwise fgf_t;

 #define FGP_WRITEBEGIN         (FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)

+/**
+ * fgf_set_order - Encode a length in the fgf_t flags.
+ * @size: The suggested size of the folio to create.
+ *
+ * The caller of __filemap_get_folio() can use this to suggest a preferred
+ * size for the folio that is created.  If there is already a folio at
+ * the index, it will be returned, no matter what its size.  If a folio
+ * is freshly created, it may be of a different size than requested
+ * due to alignment constraints, memory pressure, or the presence of
+ * other folios at nearby indices.
+ */
 static inline fgf_t fgf_set_order(size_t size)
 {
        unsigned int shift = ilog2(size);

