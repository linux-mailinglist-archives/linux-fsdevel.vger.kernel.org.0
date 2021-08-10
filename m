Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CD03E5425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHJHOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 03:14:07 -0400
Received: from verein.lst.de ([213.95.11.211]:34890 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhHJHOG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:14:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 02B8268AFE; Tue, 10 Aug 2021 09:13:42 +0200 (CEST)
Date:   Tue, 10 Aug 2021 09:13:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 19/30] iomap: switch iomap_bmap to use iomap_iter
Message-ID: <20210810071341.GB16590@lst.de>
References: <20210809061244.1196573-1-hch@lst.de> <20210809061244.1196573-20-hch@lst.de> <20210810063951.GH3601443@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810063951.GH3601443@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 09, 2021 at 11:39:51PM -0700, Darrick J. Wong wrote:
> Can't this at least be rephrased as:
> 
> 	const uint bno_shift = (mapping->host->i_blkbits - SECTOR_SHIFT);
> 
> 	while ((ret = iomap_iter(&iter, ops)) > 0) {
> 		if (iter.iomap.type == IOMAP_MAPPED)
> 			bno = iomap_sector(iomap, iter.pos) << bno_shift;
> 		/* leave iter.processed unset to stop iteration */
> 	}
> 
> to make the loop exit more explicit?

Sure.
