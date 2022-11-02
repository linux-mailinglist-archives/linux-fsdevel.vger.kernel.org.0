Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFE615E0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiKBIlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 04:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiKBIl2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:41:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9227CDB;
        Wed,  2 Nov 2022 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t+UH3XitHYQrbQpMnhqGCbAEIZ0fIBrRF5YJYhjc25w=; b=OZJKhiPwoG1p2ULHjGaP0oa9fP
        nDbaSGw4ERkqcx2Why/RmYeTSotLRUF1dk3f5pq4CpQef58wFCfCzG12QFroBJB07zXhPHkxm1cHj
        LNGfMq/hhCwhTfGDbDd8cSnqK9tiWm4ual9+gpbG5ObqtfSKW18Odt9d/DCmpLEzMjR+EeYfJwJ5W
        ubqQKYct9JivtZQHIoMpSKfv8+0f+HTIZ5bSEBvAwuHURb6lCPOU8Z1efuqsc7EvzO/zJadqQaJL5
        EDAewY67ftIBdy2RTOVN5ZPr/FkY7/bJ39huV7hv3dkfYZY1h6FTU+oehFDXh8kuZulo/UIDMFiEA
        qjuXpI+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq9JN-0095De-TN; Wed, 02 Nov 2022 08:41:25 +0000
Date:   Wed, 2 Nov 2022 01:41:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/7] xfs: use iomap_valid method to detect stale cached
 iomaps
Message-ID: <Y2ItNSakpecwC9Va@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-7-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	*((int *)&iomap->private) = sequence;

> +static bool
> +xfs_buffered_write_iomap_valid(
> +	struct inode		*inode,
> +	const struct iomap	*iomap)
> +{
> +	int			seq = *((int *)&iomap->private);

I really hate this stuffing of the sequence into the private pointer.
The iomap structure isn't so size constrained that we have to do that,
so we can just add a sequence number field directly to it.  I don't
think that is a layering violation, as the concept of a sequence
numebr is pretty generic and we'll probably need it for all file systems
eventually.

> +
> +	if (seq != READ_ONCE(XFS_I(inode)->i_df.if_seq))
> +		return false;

Which makes me wonder if we could do away with the callback entirely
by adding an option sequence number pointer to the iomap_iter.  If set
the core code compares it against iomap->seq and we get rid of the
per-folio indirect call, and boilerplate code that would need to be
implemented in every file system.
