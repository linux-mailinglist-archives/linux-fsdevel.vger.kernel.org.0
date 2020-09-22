Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA9A274687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVQXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:23:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726577AbgIVQXz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600791833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lcIO481qDJ9vuNJ4CyHr3flfzsNXYKz7f6xPpe0hVIQ=;
        b=NEk/xvX0wmMreVZRcPXXxUjEBD7m3UgIOYKfE+5SftBQFlw+MRipzqv4Q2+X5GDrgKQQDo
        zyc6CDsZ39Dme1F/tr1v+nm/3k4C6CppYBA62QFs1Udw73fRpG3ohBEWjxd9Lgi/UvbBJq
        VvDw/WinBgRzaqAPkEWzlXUCbOeFyfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-MlgWAuc3Numqqo876HbTpg-1; Tue, 22 Sep 2020 12:23:49 -0400
X-MC-Unique: MlgWAuc3Numqqo876HbTpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59B7D1005E5E;
        Tue, 22 Sep 2020 16:23:47 +0000 (UTC)
Received: from ovpn-66-35.rdu2.redhat.com (unknown [10.10.67.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5B307882A;
        Tue, 22 Sep 2020 16:23:45 +0000 (UTC)
Message-ID: <163f852ba12fd9de5dec7c4a2d6b6c7cdb379ebc.camel@redhat.com>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
From:   Qian Cai <cai@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net,
        Dave Chinner <dchinner@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Date:   Tue, 22 Sep 2020 12:23:45 -0400
In-Reply-To: <20200910234707.5504-6-willy@infradead.org>
References: <20200910234707.5504-1-willy@infradead.org>
         <20200910234707.5504-6-willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-09-11 at 00:47 +0100, Matthew Wilcox (Oracle) wrote:
> Size the uptodate array dynamically to support larger pages in the
> page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> but with a 2MB maximum page size, we'd have to allocate more than 4kB
> per page.  Add a few debugging assertions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Some syscall fuzzing will trigger this on powerpc:

.config: https://gitlab.com/cailca/linux-mm/-/blob/master/powerpc.config

[ 8805.895344][T445431] WARNING: CPU: 61 PID: 445431 at fs/iomap/buffered-io.c:78 iomap_page_release+0x250/0x270
[ 8805.895376][T445431] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod bnx2x tg3 ahci libahci mdio libphy firmware_class libata dm_mirror dm_region_hash dm_log dm_mod
[ 8805.895521][T445431] CPU: 61 PID: 445431 Comm: trinity-c61 Not tainted 5.9.0-rc6-next-20200922 #3
[ 8805.895551][T445431] NIP:  c0000000004734a0 LR: c00000000047335c CTR: 0000000000000000
[ 8805.895571][T445431] REGS: c000001fe5427620 TRAP: 0700   Not tainted  (5.9.0-rc6-next-20200922)
[ 8805.895609][T445431] MSR:  9000000000029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 44002244  XER: 20040000
[ 8805.895671][T445431] CFAR: c000000000473394 IRQMASK: 0 
[ 8805.895671][T445431] GPR00: c00000000029b698 c000001fe54278b0 c000000005687e00 0000000000000000 
[ 8805.895671][T445431] GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[ 8805.895671][T445431] GPR08: c00c000002c4b5c7 007fff8000000015 0000000000000001 c000000005f5e028 
[ 8805.895671][T445431] GPR12: 0000000000002000 c000001ffffc0580 0000000010037be0 00000000109ec8e0 
[ 8805.895671][T445431] GPR16: 00000000109eccb0 c000001fe54279c0 c000001fe5427a40 0000000000000000 
[ 8805.895671][T445431] GPR20: c000000000a4aa80 0000000000000008 0000000000000000 000000000000000f 
[ 8805.895671][T445431] GPR24: ffffffffffffffff c000001fe54279b8 c000001fe5427940 0000000000000001 
[ 8805.895671][T445431] GPR28: 0000000000000001 c0000014dd4f9128 0000000000000000 c00c000006273a80 
[ 8805.895989][T445431] NIP [c0000000004734a0] iomap_page_release+0x250/0x270
[ 8805.896016][T445431] LR [c00000000047335c] iomap_page_release+0x10c/0x270
[ 8805.896041][T445431] Call Trace:
[ 8805.896065][T445431] [c000001fe54278b0] [c000001fe5427940] 0xc000001fe5427940 (unreliable)
[ 8805.896101][T445431] [c000001fe54278f0] [c00000000029b698] truncate_cleanup_page+0x188/0x2e0
[ 8805.896144][T445431] [c000001fe5427920] [c00000000029c61c] truncate_inode_pages_range+0x23c/0x9f0
[ 8805.896187][T445431] [c000001fe5427b40] [c00000000029ceec] truncate_pagecache+0x5c/0x90
[ 8805.896229][T445431] [c000001fe5427b80] [c000000000569858] xfs_setattr_size+0xb8/0x5d0
[ 8805.896270][T445431] [c000001fe5427c10] [c00000000056a26c] xfs_vn_setattr+0x8c/0x130
[ 8805.896321][T445431] [c000001fe5427c60] [c0000000003dbe60] notify_change+0x390/0x5b0
[ 8805.896372][T445431] [c000001fe5427cd0] [c0000000003a5294] do_truncate+0x94/0x130
[ 8805.896412][T445431] [c000001fe5427d60] [c0000000003a57a8] do_sys_ftruncate+0xe8/0x160
[ 8805.896455][T445431] [c000001fe5427dc0] [c00000000002a458] system_call_exception+0xf8/0x1d0
[ 8805.896496][T445431] [c000001fe5427e20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 8805.896544][T445431] Instruction dump:
[ 8805.896569][T445431] 3c82fb3a 388490c8 4be65be1 60000000 0fe00000 60000000 60000000 60000000 
[ 8805.896623][T445431] 0fe00000 4bfffea8 60000000 60000000 <0fe00000> 4bfffef4 60000000 60000000 
[ 8805.896678][T445431] CPU: 61 PID: 445431 Comm: trinity-c61 Not tainted 5.9.0-rc6-next-20200922 #3
[ 8805.896716][T445431] Call Trace:
[ 8805.896750][T445431] [c000001fe5427410] [c0000000006440e8] dump_stack+0xec/0x144 (unreliable)
[ 8805.896796][T445431] [c000001fe5427450] [c0000000000b0a24] __warn+0xc4/0x144
[ 8805.896837][T445431] [c000001fe54274e0] [c000000000642cf8] report_bug+0x108/0x1f0
[ 8805.896878][T445431] [c000001fe5427580] [c000000000021714] program_check_exception+0x104/0x2e0
[ 8805.896922][T445431] [c000001fe54275b0] [c000000000009664] program_check_common_virt+0x2c4/0x310
[ 8805.896965][T445431] --- interrupt: 700 at iomap_page_release+0x250/0x270
[ 8805.896965][T445431]     LR = iomap_page_release+0x10c/0x270
[ 8805.897018][T445431] [c000001fe54278b0] [c000001fe5427940] 0xc000001fe5427940 (unreliable)
[ 8805.897053][T445431] [c000001fe54278f0] [c00000000029b698] truncate_cleanup_page+0x188/0x2e0
[ 8805.897104][T445431] [c000001fe5427920] [c00000000029c61c] truncate_inode_pages_range+0x23c/0x9f0
[ 8805.897146][T445431] [c000001fe5427b40] [c00000000029ceec] truncate_pagecache+0x5c/0x90
[ 8805.897186][T445431] [c000001fe5427b80] [c000000000569858] xfs_setattr_size+0xb8/0x5d0
[ 8805.897226][T445431] [c000001fe5427c10] [c00000000056a26c] xfs_vn_setattr+0x8c/0x130
[ 8805.897266][T445431] [c000001fe5427c60] [c0000000003dbe60] notify_change+0x390/0x5b0
[ 8805.897307][T445431] [c000001fe5427cd0] [c0000000003a5294] do_truncate+0x94/0x130
[ 8805.897329][T445431] [c000001fe5427d60] [c0000000003a57a8] do_sys_ftruncate+0xe8/0x160
[ 8805.897369][T445431] [c000001fe5427dc0] [c00000000002a458] system_call_exception+0xf8/0x1d0
[ 8805.897410][T445431] [c000001fe5427e20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 8805.897448][T445431] irq event stamp: 360936
[ 8805.897475][T445431] hardirqs last  enabled at (360935): [<c0000000002bd5b8>] dec_zone_page_state+0x78/0xb0
[ 8805.897515][T445431] hardirqs last disabled at (360936): [<c00000000000965c>] program_check_common_virt+0x2bc/0x310
[ 8805.897556][T445431] softirqs last  enabled at (342438): [<c0000000008d3d38>] __do_softirq+0x378/0x6e4
[ 8805.897597][T445431] softirqs last disabled at (342433): [<c0000000000bc838>] irq_exit+0x118/0x140

> ---
>  fs/iomap/buffered-io.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7fc0e02d27b0..9670c096b83e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -22,18 +22,25 @@
>  #include "../internal.h"
>  
>  /*
> - * Structure allocated for each page when block size < PAGE_SIZE to track
> - * sub-page uptodate status and I/O completions.
> + * Structure allocated for each page or THP when block size < page size
> + * to track sub-page uptodate status and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> -	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	unsigned long		uptodate[];
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
>  {
> +	/*
> +	 * per-block data is stored in the head page.  Callers should
> +	 * not be dealing with tail pages (and if they are, they can
> +	 * call thp_head() first.
> +	 */
> +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> +
>  	if (page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;
> @@ -45,11 +52,13 @@ static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> +	unsigned int nr_blocks = i_blocks_per_page(inode, page);
>  
> -	if (iop || i_blocks_per_page(inode, page) <= 1)
> +	if (iop || nr_blocks <= 1)
>  		return iop;
>  
> -	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> +	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> +			GFP_NOFS | __GFP_NOFAIL);
>  	spin_lock_init(&iop->uptodate_lock);
>  	attach_page_private(page, iop);
>  	return iop;
> @@ -59,11 +68,14 @@ static void
>  iomap_page_release(struct page *page)
>  {
>  	struct iomap_page *iop = detach_page_private(page);
> +	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
>  
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_count));
>  	WARN_ON_ONCE(atomic_read(&iop->write_count));
> +	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> +			PageUptodate(page));
>  	kfree(iop);
>  }
>  

