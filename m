Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8F55358D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 07:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiE0Flg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 01:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiE0Fle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 01:41:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94550AF1D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 22:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sJ7J59z0CujPyPzVAWKZfbM4pcB3EWazV5XBof/U/fE=; b=JtYPhDYe2SDIh0bUZqKrL3n6T2
        CZFYdT86g49McBP2n+usIOP3Kl0D1LFwzkzRlSytajR+0tijc7THAaut9T8bus3UCzLY+7aF5TXAi
        MTtwCIR10+BV/AqV+8RWlRiVPg5s6tPon0kgncewBD+4M7SySFCuhIkWUOGaCucNGSm1s+vkF3y92
        5GWMnMLmtec3usB64/8un+P3cZCvJjwbA7hvNn5yO1t9RCtJijxhAEV8fvwQHrZtoB/t96YLbEfiW
        l2aitakw8F2FGxAeABWDyqEYj0hWA/gIj0lUAFooBGdlp/fWyFd1Ux0zylW85Dw8CgMVJvhEzzXLf
        zNwaIe2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuSj5-00GgzL-Nx; Fri, 27 May 2022 05:41:31 +0000
Date:   Thu, 26 May 2022 22:41:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [RFC PATCH 2/9] jfs: Add jfs_iomap_begin()
Message-ID: <YpBkiy4zvIcEXihd@infradead.org>
References: <20220526192910.357055-1-willy@infradead.org>
 <20220526192910.357055-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526192910.357055-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I suspect this might be where your problems lies:

blockdev_direct_IO calls __blockdev_direct_IO with DIO_SKIP_HOLES set.
DIO_SKIP_HOLES causes get_more_blocks to never set the create bit
to get_block except for writes beyond i_size.  If we want to replicate
that behavior with iomap, ->iomap_begin needs to return -ENOTBLK
when it encounters a hole for writing.  To properly supporting writing
to holes we'd need unwritten extents, which jfs does not support.
gfs2 might be a place to look for how to implement this.
