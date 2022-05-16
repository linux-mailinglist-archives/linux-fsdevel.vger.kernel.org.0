Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3419F5285AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiEPNnt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiEPNnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:43:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA6935879;
        Mon, 16 May 2022 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bdKEgcBu660QK59Q7ijUEpupyYvQqpjvn1VWbciI8qw=; b=O/SokAB18zhm+omASVU0WcYHV4
        pBaIDuyPT8BdWj0IvU5nAl7VHstuV4EgY3Na29XZ6YIeAtQoFfctGmHpInbBc9MO3G8vJQAFGkONP
        5z92l/5uDZ3B3e2zRs5Yagnhi8Sbk5DXTZ9OfERsyNy9w37eBeB9GDoz06oT0HRLJKrgEhBu7QW1m
        naIVgpg0nPy/xS2SAVFzYZwkh9E7x/JcTd41TLtxaNEPsTvD36+CezTZNZOPGgbyqcovB9W4jCYJ3
        6cFzR3Q0u6I7u6JJg7NdCA9nK11udjZO5NKGD7tQ0Gou3ySkStzUmesg8Oz2mypgTU0WYSWNjJeOi
        j2yXTD/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqb0h-0081X1-86; Mon, 16 May 2022 13:43:43 +0000
Date:   Mon, 16 May 2022 06:43:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: don't invalidate folios after writeback errors
Message-ID: <YoJVD7wmX6r6mFTe@infradead.org>
References: <YoHG5cMwvx8PSddI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoHG5cMwvx8PSddI@magnolia>
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

The changes looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

I did a little digging and the invalidatepage call first appeared
in

commit 90ce6b6a90f62578a141359ffe9261e65f2c5265
Author: Steve Lord <lord@sgi.com>
Date:   Mon Sep 2 12:36:59 2002 +0000

    move page_buf_io.c to xfs_aops.c

The old page_buf_io.c file seems to not have made it through to
git, so this seems rather prehistoric.
