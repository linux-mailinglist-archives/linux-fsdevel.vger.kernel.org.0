Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC900316831
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhBJNlr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 08:41:47 -0500
Received: from verein.lst.de ([213.95.11.211]:51214 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBJNlp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:41:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 97BF768B02; Wed, 10 Feb 2021 14:41:00 +0100 (CET)
Date:   Wed, 10 Feb 2021 14:41:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v3 06/11] mm, pmem: Implement ->memory_failure() in
 pmem driver
Message-ID: <20210210134100.GE30109@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-7-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208105530.3072869-7-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		unsigned long pfn, int flags)
> +{
> +	struct pmem_device *pdev;
> +	struct gendisk *disk;
> +	loff_t disk_offset;
> +	int rc = 0;
> +	unsigned long size = page_size(pfn_to_page(pfn));
> +
> +	pdev = container_of(pgmap, struct pmem_device, pgmap);
> +	disk = pdev->disk;

Would be nice to initialize this at the time of declaration:

	struct pmem_device *pdev =
		container_of(pgmap, struct pmem_device, pgmap);
	struct gendisk *disk = pdev->disk
	unsigned long size = page_size(pfn_to_page(pfn));

> +	if (!disk)
> +		return -ENXIO;
> +
> +	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
> +	if (disk->fops->corrupted_range) {
> +		rc = disk->fops->corrupted_range(disk, NULL, disk_offset,
> +						 size, &flags);
> +		if (rc == -ENODEV)
> +			rc = -ENXIO;
> +	} else
> +		rc = -EOPNOTSUPP;

Why do we need the disk and fops check here? A pgmap registered by pmem.c
should always have a disk with pmem_fops.  And more importantly this
has no business going through the block layer.

Instead the file system should deposit a callback when starting to use
the dax_device using fs_dax_get_by_bdev / dax_get_by_host and a private
data (the superblock), and we avoid all the lookup problems.

> +int mf_generic_kill_procs(unsigned long long pfn, int flags)

This function seems to be only used inside of memory-failure.c, so it
could be marked static.  Also I'd name it dax_generic_memory_failure
or something like that to match the naming of the ->memory_failure
pgmap operation.

Also maybe just splitting this out into a helper would be a nice prep
patch.
