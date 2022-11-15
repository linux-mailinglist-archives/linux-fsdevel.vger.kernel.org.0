Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB635629362
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiKOIkK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiKOIkJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:40:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A135582;
        Tue, 15 Nov 2022 00:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yuh2AMTeq6XlUMUUyRATLkJw+4BsFLkicyPlBlFhPJo=; b=XfisNEoRqIh8yEGYpWzXgh23Sr
        buVO6GTrfuC2K2/TOOpv1KkekxkXWTAiVCQfaoiNOvJsxio1npxmNGfsa/4hZcReATm/hc7EK9qt0
        QF0y9bxfOoZNBfj05MuG3pmntR+avrCMATKBpT0Kf5mvz9FwLU3+JGlLmVv/3Qo/O/EFFaOnh2gW5
        hPsUrkohpPBoOetYrCoyBNzy4i76AmergsP7AarvqCIpZtdVsP4fx7eYyNLGIuu4DypVDMsMIEpU2
        IFRd2IqxgT9jEGRT3R3iPM9fC5uIwW0jKei/nNF4mqJz1Iz9OSPQgqt+Snst/KkUKmtZu5kNK43kw
        YquOyt1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourUF-008zH0-Ix; Tue, 15 Nov 2022 08:40:07 +0000
Date:   Tue, 15 Nov 2022 00:40:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/9] mm: export mapping_seek_hole_data()
Message-ID: <Y3NQZ7UQVEFWZFPn@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-2-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:35PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> XFS needs this for finding cached dirty data regions when cleaning
> up short writes, so it needs to be exported as XFS can be built as a
> module.

NAK.  Even if you use these helpers to make your life a little easier,
the main delalloc punch logic belongs into iomap and not XFS, and does
not need the exports.
