Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D4316816
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBJNef (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 08:34:35 -0500
Received: from verein.lst.de ([213.95.11.211]:51165 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhBJNed (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:34:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id BABDE68B02; Wed, 10 Feb 2021 14:33:47 +0100 (CET)
Date:   Wed, 10 Feb 2021 14:33:47 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        david@fromorbit.com, hch@lst.de, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler
 for dax mapping
Message-ID: <20210210133347.GD30109@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);

No nee for the extern, please avoid the overly long line.

> @@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
>  	if (PageSlab(p))
>  		return -EINVAL;
>  
> +	if (pfn_valid(page_to_pfn(p))) {
> +		if (is_device_fsdax_page(p))
> +			return 0;
> +		else
> +			return -EINVAL;
> +	}
> +

This looks odd.  For one there is no need for an else after a return.
But more importantly page_mapping() as called below pretty much assumes
a valid PFN, so something is fishy in this function.

> +	if (is_zone_device_page(p)) {
> +		if (is_device_fsdax_page(p))
> +			tk->addr = vma->vm_start +
> +					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);

The arithmetics here scream for a common helper, I suspect there might
be other places that could use the same helper.

> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)

Overly long line.  Also the naming scheme with the mf_ seems rather
unusual. Maybe dax_kill_mapping_procs?  Also please add a kerneldoc
comment describing the function given that it exported.
