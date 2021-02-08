Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C1313716
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhBHPTr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 10:19:47 -0500
Received: from verein.lst.de ([213.95.11.211]:41732 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhBHPPD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:15:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id D07EF68AFE; Mon,  8 Feb 2021 16:14:19 +0100 (CET)
Date:   Mon, 8 Feb 2021 16:14:19 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
Subject: Re: [PATCH 3/7] fsdax: Copy data before write
Message-ID: <20210208151419.GC12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>  	switch (iomap.type) {
>  	case IOMAP_MAPPED:
> +cow:
>  		if (iomap.flags & IOMAP_F_NEW) {
>  			count_vm_event(PGMAJFAULT);
>  			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>  			major = VM_FAULT_MAJOR;
>  		}
>  		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
> -						NULL, &pfn);
> +						&kaddr, &pfn);

Any chance you could look into factoring out this code into a helper
to avoid the goto magic, which is a little too convoluted?

>  	switch (iomap.type) {
>  	case IOMAP_MAPPED:
> +cow:
>  		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
> -						NULL, &pfn);
> +						&kaddr, &pfn);
>  		if (error < 0)
>  			goto finish_iomap;
>  
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						DAX_PMD, write && !sync);
>  
> +		if (srcmap.type != IOMAP_HOLE) {

Same here.
