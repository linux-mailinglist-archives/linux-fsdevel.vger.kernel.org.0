Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B874B6422
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiBOHSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:18:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBOHSH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:18:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21637CCC40
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lh/4vU9mdF8EI5uwzlU0rCLsZXjqtBxSaTihRBxn1pU=; b=VkRqdL5cio50YFn/NoU25FxW8L
        W3N2Cwlzj3DvlCOFlJi1NaqjCHxvYE63rQAUapjBO4RBsQpSl1vecKtJ9sam3gnnLPM865g2GuCaP
        9kqU/1OUItCjFhTIcF0SvekDI6zmRdnZTLkiwOtu2Wd/jvAgqoQBzECW4BMJVRrpPSaSbRROGvhp+
        wgWj6nb1hYJ59CqHze5eA24Yuqv+80RvMUEccEs2gH7HPj5wsC4IP0kCtd5mUZvJyYnkI7W8jlLze
        3VI6acaYCBvC+p7wGTraRbMBWk1zCuvlKZzSv3k/KqRl/lc4VasyFisxnrNHAwipRN0hn45jBhtqB
        iT9+3xSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs61-0016b5-Mj; Tue, 15 Feb 2022 07:17:57 +0000
Date:   Mon, 14 Feb 2022 23:17:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 02/10] mm/truncate: Inline invalidate_complete_page()
 into its one caller
Message-ID: <YgtTpQD4TODoHVT2@infradead.org>
References: <20220214200017.3150590-1-willy@infradead.org>
 <20220214200017.3150590-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214200017.3150590-3-willy@infradead.org>
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

On Mon, Feb 14, 2022 at 08:00:09PM +0000, Matthew Wilcox (Oracle) wrote:
> invalidate_inode_page() is the only caller of invalidate_complete_page()
> and inlining it reveals that the first check is unnecessary (because we
> hold the page locked, and we just retrieved the mapping from the page).
> Actually, it does make a difference, in that tail pages no longer fail
> at this check, so it's now possible to remove a tail page from a mapping.

There is a comment that referneces invalidate_complete_page in
kernel/futex/core.c which needs updating.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
