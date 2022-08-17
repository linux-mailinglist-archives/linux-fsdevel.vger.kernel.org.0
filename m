Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35505972FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiHQPbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiHQPbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 11:31:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174128E442
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xjF2dRJwFCHabLautL7vUkzPczlUuGRC5hw2s/8u9fs=; b=BZCn+BEmdt4YalsavwMnIXmtb3
        qcZPuN9KoeN6UkrNTfX6WGeRSRC6Dz0tEK2Bp2SJLxlswObHU1UXpxes38fGhBg2ll5nXfY8CwOyH
        z7A2kE803VX9GhqakDG6ZPAWjwcVH+1DnFL3/fNEV6QPk6g9QxaglrweEW6K47MnzRdDG0ypPUkTT
        iplFVabjM0b2VsdpNE0t+73NvRyPAphX4wYO4Q6nvxskM3T+ibpa5Bjv/GwKUFarNMIbQxtHb076J
        ZeB+RVf/PjpbB+m/9A3Fpnrfvb0G7UY+RtTI8HiaLiXUqpkpnU0Oa5EJzUeWX8m/jqat5ckVUeMpp
        Ntb9Z6Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOL0U-008MPO-A2; Wed, 17 Aug 2022 15:30:58 +0000
Date:   Wed, 17 Aug 2022 16:30:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Guixin Liu <kanie@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [RFC PATCH] mm/filemap.c: fix the timing of asignment of prev_pos
Message-ID: <Yv0Jsjp3qCnKn13V@casper.infradead.org>
References: <1660744317-8183-1-git-send-email-kanie@linux.alibaba.com>
 <20220817081657.5e8332cec593621fccfacf93@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817081657.5e8332cec593621fccfacf93@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:16:57AM -0700, Andrew Morton wrote:
> On Wed, 17 Aug 2022 21:51:57 +0800 Guixin Liu <kanie@linux.alibaba.com> wrote:
> 
> > The prev_pos should be assigned before the iocb->ki_pos is incremented,
> > so that the prev_pos is the exact location of the last visit.
> > 
> > Fixes: 06c0444290cec ("mm/filemap.c: generic_file_buffered_read() now
> > uses find_get_pages_contig")
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> > 
> > ---
> > Hi guys,
> >     When I`m running repetitive 4k read io which has same offset,
> > I find that access to folio_mark_accessed is inevitable in the
> > read process, the reason is that the prev_pos is assigned after the
> > iocb->ki_pos is incremented, so that the prev_pos is always not equal
> > to the position currently visited.
> >     Is this a bug that needs fixing?
> 
> It looks wrong to me and it does appear that 06c0444290cecf0 did this
> unintentionally.

That commit was the start of a problem, but I think I restored the
original behaviour in 5ccc944dce3d.  You were part of that discussion
back in June:
https://lore.kernel.org/linux-mm/20220602082129.2805890-1-yukuai3@huawei.com/

