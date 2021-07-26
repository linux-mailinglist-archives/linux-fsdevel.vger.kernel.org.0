Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C57B3D552B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhGZHev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 03:34:51 -0400
Received: from verein.lst.de ([213.95.11.211]:44244 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231962AbhGZHeu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:34:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DF1C468BEB; Mon, 26 Jul 2021 10:15:12 +0200 (CEST)
Date:   Mon, 26 Jul 2021 10:15:11 +0200
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
Subject: Re: [PATCH 08/27] iomap: add the new iomap_iter model
Message-ID: <20210726081510.GB14853@lst.de>
References: <20210719103520.495450-1-hch@lst.de> <20210719103520.495450-9-hch@lst.de> <20210719165600.GG23236@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719165600.GG23236@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 19, 2021 at 09:56:00AM -0700, Darrick J. Wong wrote:
> Linus previously complained to me about filesystem code (especially
> iomap since it was "newer") (ab)using loff_t variables to store the
> lengths of byte ranges.  It was "loff_t length;" (or so willy
> recollects) that tripped him up.
> 
> ISTR he also said we should use size_t for all lengths because nobody
> should do operations larger than ~2G, but I reject that because iomap
> has users that iterate large ranges of data without generating any IO
> (e.g. fiemap, seek, swapfile activation).
> 
> So... rather than confusing things even more by mixing u64 and ssize_t
> for lengths, can we introduce a new 64-bit length typedef for iomap?
> Last summer, Dave suggested[1] something like:
> 
> 	typedef long long lsize_t;
> 
> That would enable cleanup of all the count/size/length parameters in
> fs/remap_range.c and fs/xfs/xfs_reflink.c to use the new 64-bit length
> type, since those operations have never been limited to 32-bit sizes.

I'd rather avoid playing guinea pig for a somewhat odd new type.  For
now I've switched it to the loff_t as that matches the rest of iomap.
If we switch away either to a new type or s64/u64 we should probably do
it as a big sweep.
