Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF30F2ADCD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 18:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgKJRZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 12:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJRZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:25:41 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25842C0613CF;
        Tue, 10 Nov 2020 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=28HWKUwdnjtdHRGTZi8i0JiE0Srn9hHeE5n1l/oapiU=; b=MT2M8edc9/atGMnFZkwAidHNnQ
        k0to/p1MLVrblLmCx+4ZVA+3OCdrLywoKOJvdHv2AFLAfWbVFSiOY0/eT37WYTRikan6+rXDvIgT7
        iGKnMkVKeu82WNMGApgDqs8sXJi3aEb5/3JqokV7lqDANrlQ/PEyAXGLteZRSFBC/doIA//U2R/gP
        EjKM+47pkaujjI/QQvdbAcErm58In0DvtSSp9r1iPuzhuT7rC0z0Lc/+MVjPPbEq90mAyhgRRoKMg
        lusucSoQUCOQ5mvQCPjjQycum5xDUVqcN+6iyvGnZJbsNmetmJ504pJzVyL2i50zNB4/QU6I98kkw
        wNIkZkog==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcXOk-0006OC-Oj; Tue, 10 Nov 2020 17:25:38 +0000
Date:   Tue, 10 Nov 2020 17:25:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v10 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201110172538.GB22758@infradead.org>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72734501cc1d9e08117c215ed60f7b38e3665f14.1605007036.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  		struct iomap_dio *dio, struct iomap *iomap)
> @@ -278,6 +306,13 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>  		bio->bi_private = dio;
>  		bio->bi_end_io = iomap_dio_bio_end_io;
>  
> +		/*
> +		 * Set the operation flags early so that bio_iov_iter_get_pages
> +		 * can set up the page vector appropriately for a ZONE_APPEND
> +		 * operation.
> +		 */
> +		bio->bi_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);

We could just calculate the flags once before the loop if we touch
this anyway.

But otherwise this looks ok to me.
