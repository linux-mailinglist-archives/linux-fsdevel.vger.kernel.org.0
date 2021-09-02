Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A143FE9F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhIBH2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:28:21 -0400
Received: from verein.lst.de ([213.95.11.211]:50243 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233363AbhIBH2U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:28:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D973368B05; Thu,  2 Sep 2021 09:27:19 +0200 (CEST)
Date:   Thu, 2 Sep 2021 09:27:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     djwong@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
        dan.j.williams@intel.com, david@fromorbit.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rgoldwyn@suse.de, viro@zeniv.linux.org.uk,
        willy@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH v8 3/7] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210902072719.GB13867@lst.de>
References: <20210829122517.1648171-1-ruansy.fnst@fujitsu.com> <20210829122517.1648171-4-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829122517.1648171-4-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 29, 2021 at 08:25:13PM +0800, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.

Nit: s/We r/R/ above.

> + * MAP_SYNC on a dax mapping guarantees dirty metadata is
> + * flushed on write-faults (non-cow), but not read-faults.
> + */
> +static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
> +		struct vm_area_struct *vma)
> +{
> +	return (iter->flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC)
> +		&& (iter->iomap.flags & IOMAP_F_DIRTY);
> +}
> +
> +static bool dax_fault_is_cow(const struct iomap_iter *iter)
> +{
> +	return (iter->flags & IOMAP_WRITE)
> +		&& (iter->iomap.flags & IOMAP_F_SHARED);
> +}

The && goes last on the first line, not at the beginning of the second.
