Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45D936BBCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhDZWst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 18:48:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:7682 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDZWss (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:48:48 -0400
IronPort-SDR: /SvtknyNJ0WwgJtvjU9yAzNhgns13nJMVYrl9vKGFFZj3ngk6Urtd1ENYIvkX2N1tuGLbSLS3C
 7D/l3ut8VOpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196475940"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196475940"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:48:04 -0700
IronPort-SDR: 0OoBkbV+1Ox6DgCJsz3p8pRg6Qh4Z7QgEJFLV0iN/+erqAfcNG7xRSGc7htjfewXeCRxv2MdCY
 48Pnrx+6JMhw==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429568748"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:48:03 -0700
Date:   Mon, 26 Apr 2021 15:48:03 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH v2 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210426224803.GR1904484@iweiny-DESK2.sc.intel.com>
References: <20210407133823.828176-1-ruansy.fnst@fujitsu.com>
 <20210407133823.828176-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407133823.828176-2-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 09:38:21PM +0800, Shiyang Ruan wrote:
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

Is there a reason VM_FAULT_MAJOR should be left out here?

Ira

