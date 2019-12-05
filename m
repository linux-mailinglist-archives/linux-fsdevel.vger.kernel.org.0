Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93ACA113C01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 07:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfLEG5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 01:57:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEG5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:57:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB56uYqm047328;
        Thu, 5 Dec 2019 06:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=Wj8BxiJjaAEB20Dm4CnLfmaU1VtGhhsZOJx/RAp+TK0=;
 b=jgL16FH8HEHivIgoUiROJkL+aKtxLr1N6PPJN6jzt8Jfvz81iKnkPdbbV61IWznqL/Ip
 Kl6b7swMVxP0E9XNTNzHEP9dBUvJj4uxv9hw0SaTpLhc04ArWiYrWjQ0FbFYLtEJ/w+g
 mrR+nLe33bVABTEMXU2hkDhKccQX8wvb7iMCVWn9uWVVaWFJ4GL2/fib6y0rYPnlu+65
 PWwYJ5DV+3iqRONtiEovLts9yiZMDG8xvx9ZYm579lZVnLBs2bE4n/CA1MUVFukge8o5
 o6U3OaV/2sOs6AZAVLS4xmLz1O5Gjs11fDeYEGBaYshZbwwQlSk6ZexOIN3N1xSFuZEc EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wkgcqk2w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 06:57:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB56mmiZ152302;
        Thu, 5 Dec 2019 06:57:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2wptnwxkex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Dec 2019 06:57:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB56vUFZ004690;
        Thu, 5 Dec 2019 06:57:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Dec 2019 22:57:30 -0800
Date:   Wed, 4 Dec 2019 22:57:29 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: stop using ioend after it's been freed in
 iomap_finish_ioend()
Message-ID: <20191205065729.GA13260@magnolia>
References: <20191205065132.21604-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205065132.21604-1-zlang@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050054
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 02:51:32PM +0800, Zorro Lang wrote:
> This patch fixes the following KASAN report. The @ioend has been
> freed by dio_put(), but the iomap_finish_ioend() still trys to access
> its data.
> 
> [20563.631624] BUG: KASAN: use-after-free in iomap_finish_ioend+0x58c/0x5c0
> [20563.638319] Read of size 8 at addr fffffc0c54a36928 by task kworker/123:2/22184
> 
> [20563.647107] CPU: 123 PID: 22184 Comm: kworker/123:2 Not tainted 5.4.0+ #1
> [20563.653887] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [20563.664499] Workqueue: xfs-conv/sda5 xfs_end_io [xfs]
> [20563.669547] Call trace:
> [20563.671993]  dump_backtrace+0x0/0x370
> [20563.675648]  show_stack+0x1c/0x28
> [20563.678958]  dump_stack+0x138/0x1b0
> [20563.682455]  print_address_description.isra.9+0x60/0x378
> [20563.687759]  __kasan_report+0x1a4/0x2a8
> [20563.691587]  kasan_report+0xc/0x18
> [20563.694985]  __asan_report_load8_noabort+0x18/0x20
> [20563.699769]  iomap_finish_ioend+0x58c/0x5c0
> [20563.703944]  iomap_finish_ioends+0x110/0x270
> [20563.708396]  xfs_end_ioend+0x168/0x598 [xfs]
> [20563.712823]  xfs_end_io+0x1e0/0x2d0 [xfs]
> [20563.716834]  process_one_work+0x7f0/0x1ac8
> [20563.720922]  worker_thread+0x334/0xae0
> [20563.724664]  kthread+0x2c4/0x348
> [20563.727889]  ret_from_fork+0x10/0x18
> 
> [20563.732941] Allocated by task 83403:
> [20563.736512]  save_stack+0x24/0xb0
> [20563.739820]  __kasan_kmalloc.isra.9+0xc4/0xe0
> [20563.744169]  kasan_slab_alloc+0x14/0x20
> [20563.747998]  slab_post_alloc_hook+0x50/0xa8
> [20563.752173]  kmem_cache_alloc+0x154/0x330
> [20563.756185]  mempool_alloc_slab+0x20/0x28
> [20563.760186]  mempool_alloc+0xf4/0x2a8
> [20563.763845]  bio_alloc_bioset+0x2d0/0x448
> [20563.767849]  iomap_writepage_map+0x4b8/0x1740
> [20563.772198]  iomap_do_writepage+0x200/0x8d0
> [20563.776380]  write_cache_pages+0x8a4/0xed8
> [20563.780469]  iomap_writepages+0x4c/0xb0
> [20563.784463]  xfs_vm_writepages+0xf8/0x148 [xfs]
> [20563.788989]  do_writepages+0xc8/0x218
> [20563.792658]  __writeback_single_inode+0x168/0x18f8
> [20563.797441]  writeback_sb_inodes+0x370/0xd30
> [20563.801703]  wb_writeback+0x2d4/0x1270
> [20563.805446]  wb_workfn+0x344/0x1178
> [20563.808928]  process_one_work+0x7f0/0x1ac8
> [20563.813016]  worker_thread+0x334/0xae0
> [20563.816757]  kthread+0x2c4/0x348
> [20563.819979]  ret_from_fork+0x10/0x18
> 
> [20563.825028] Freed by task 22184:
> [20563.828251]  save_stack+0x24/0xb0
> [20563.831559]  __kasan_slab_free+0x10c/0x180
> [20563.835648]  kasan_slab_free+0x10/0x18
> [20563.839389]  slab_free_freelist_hook+0xb4/0x1c0
> [20563.843912]  kmem_cache_free+0x8c/0x3e8
> [20563.847745]  mempool_free_slab+0x20/0x28
> [20563.851660]  mempool_free+0xd4/0x2f8
> [20563.855231]  bio_free+0x33c/0x518
> [20563.858537]  bio_put+0xb8/0x100
> [20563.861672]  iomap_finish_ioend+0x168/0x5c0
> [20563.865847]  iomap_finish_ioends+0x110/0x270
> [20563.870328]  xfs_end_ioend+0x168/0x598 [xfs]
> [20563.874751]  xfs_end_io+0x1e0/0x2d0 [xfs]
> [20563.878755]  process_one_work+0x7f0/0x1ac8
> [20563.882844]  worker_thread+0x334/0xae0
> [20563.886584]  kthread+0x2c4/0x348
> [20563.889804]  ret_from_fork+0x10/0x18
> 
> [20563.894855] The buggy address belongs to the object at fffffc0c54a36900
>                 which belongs to the cache bio-1 of size 248
> [20563.906844] The buggy address is located 40 bytes inside of
>                 248-byte region [fffffc0c54a36900, fffffc0c54a369f8)
> [20563.918485] The buggy address belongs to the page:
> [20563.923269] page:ffffffff82f528c0 refcount:1 mapcount:0 mapping:fffffc8e4ba31900 index:0xfffffc0c54a33300
> [20563.932832] raw: 17ffff8000000200 ffffffffa3060100 0000000700000007 fffffc8e4ba31900
> [20563.940567] raw: fffffc0c54a33300 0000000080aa0042 00000001ffffffff 0000000000000000
> [20563.948300] page dumped because: kasan: bad access detected
> 
> [20563.955345] Memory state around the buggy address:
> [20563.960129]  fffffc0c54a36800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
> [20563.967342]  fffffc0c54a36880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [20563.974554] >fffffc0c54a36900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> [20563.981766]                                   ^
> [20563.986288]  fffffc0c54a36980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
> [20563.993501]  fffffc0c54a36a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [20564.000713] ==================================================================
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205703
> Signed-off-by: Zorro Lang <zlang@redhat.com>

Pretty clearly a scrwup on my part.

Fixes: 9cd0ed63ca514 ("iomap: enhance writeback error message")
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
> 
> Hi,
> 
> I can't reproduce this bug by running generic/461 on this patch. But then
> generic/461 started to hit below issue:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205465#c3
> 
> Which I reported one month ago. At least it's not a regression from this patch.
> 
> Thanks,
> Zorro
> 
>  fs/iomap/buffered-io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index d33c7bc5ee92..dc25a2183ba9 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1128,6 +1128,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  	struct bio *bio = &ioend->io_inline_bio;
>  	struct bio *last = ioend->io_bio, *next;
>  	u64 start = bio->bi_iter.bi_sector;
> +	loff_t offset = ioend->io_offset;
>  	bool quiet = bio_flagged(bio, BIO_QUIET);
>  
>  	for (bio = &ioend->io_inline_bio; bio; bio = next) {
> @@ -1148,12 +1149,12 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
>  			iomap_finish_page_writeback(inode, bv->bv_page, error);
>  		bio_put(bio);
>  	}
> +	/* The ioend has been freed by bio_put() */
>  
>  	if (unlikely(error && !quiet)) {
>  		printk_ratelimited(KERN_ERR
>  "%s: writeback error on inode %lu, offset %lld, sector %llu",
> -			inode->i_sb->s_id, inode->i_ino, ioend->io_offset,
> -			start);
> +			inode->i_sb->s_id, inode->i_ino, offset, start);
>  	}
>  }
>  
> -- 
> 2.20.1
> 
