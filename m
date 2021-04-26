Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295B436BC21
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhDZXjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 19:39:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:59761 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237677AbhDZXjH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 19:39:07 -0400
IronPort-SDR: hi2N/OYRUK1SBv3ZwQs2BLJPjHixmabKB7m3mnbHv5CZ/iBvGBdm5Vmcp2oSGjp2g9YL3hd5tk
 q89L9+9KkYoA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="260374755"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="260374755"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:38:23 -0700
IronPort-SDR: A50+Fd5pn/qjEoSorYMDPYKihZpodieBazBUiERfxoqvGxei7QgZ5XYQMXGBr7+xxjtAB4Hi42
 7J1D/c4nsVXg==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="618771565"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 16:38:23 -0700
Date:   Mon, 26 Apr 2021 16:38:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210426233823.GT1904484@iweiny-DESK2.sc.intel.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422134501.1596266-2-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:44:59PM +0800, Shiyang Ruan wrote:
> The dax page fault code is too long and a bit difficult to read. And it
> is hard to understand when we trying to add new features. Some of the
> PTE/PMD codes have similar logic. So, factor them as helper functions to
> simplify the code.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/dax.c | 153 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 84 insertions(+), 69 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fdc6775..f843fb8fbbf1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c

[snip]

> @@ -1355,19 +1379,8 @@ static vm_fault_t dax_iomap_pte_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						 0, write && !sync);
>  
> -		/*
> -		 * If we are doing synchronous page fault and inode needs fsync,
> -		 * we can insert PTE into page tables only after that happens.
> -		 * Skip insertion for now and return the pfn so that caller can
> -		 * insert it after fsync is done.
> -		 */
>  		if (sync) {
> -			if (WARN_ON_ONCE(!pfnp)) {
> -				error = -EIO;
> -				goto error_finish_iomap;
> -			}
> -			*pfnp = pfn;
> -			ret = VM_FAULT_NEEDDSYNC | major;
> +			ret = dax_fault_synchronous_pfnp(pfnp, pfn);

I commented on the previous version...  So I'll ask here too.

Why is it ok to drop 'major' here?

Ira

