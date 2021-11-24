Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2827745B454
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhKXGjT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:39:19 -0500
Received: from verein.lst.de ([213.95.11.211]:35804 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhKXGjS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:39:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C659668AFE; Wed, 24 Nov 2021 07:36:05 +0100 (CET)
Date:   Wed, 24 Nov 2021 07:36:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, dm-devel@redhat.com,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 06/29] dax: move the partition alignment check into
 fs_dax_get_by_bdev
Message-ID: <20211124063605.GA6889@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-7-hch@lst.de> <20211123222555.GE266024@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123222555.GE266024@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 02:25:55PM -0800, Darrick J. Wong wrote:
> > +	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
> > +	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
> 
> Do we have to be careful about 64-bit division here, or do we not
> support DAX on 32-bit?

I can't find anything in the Kconfig limiting DAX to 32-bit.  But
then again the existing code has divisions like this, so the compiler
is probably smart enough to turn them into shifts.

> > +		pr_info("%pg: error: unaligned partition for dax\n", bdev);
> 
> I also wonder if this should be ratelimited...?

This happens once (or maybe three times for XFS with rt and log devices)
at mount time, so I see no need for a ratelimit.
