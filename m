Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C32188648E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbfHHOkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 10:40:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51546 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHOkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:40:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78EOSgV076510;
        Thu, 8 Aug 2019 14:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=i6ceCYx6lAXpeYFhnWEey2LkjdmU57GUUV9clpAqQxQ=;
 b=VRXLvzIAEcsbhRnf9PMPCzLIodfneXEfq5RYxJSQ0hB9WwOevc5y7tokLu8APqRrOV7L
 +tEkIxWUYgllgy8VF5My05CoEOlQ4HB2W30+/+K/ehI4thnUPg8DtWCUhpvQ4t7Uwlwr
 oW+gQ7o6e/6V/DXEquP9CiocBOVxjxYiMrDYuTbTMsDetTMFNwBMh5fYuYrIlp2EC1ZE
 raA9oqljBfX4tWbzLc7ij5/w3OhEZR44dGxiikap8uwfUw3ScrZUtgI/L4JIHoEQQ4nV
 uz4YhVsu4p39G9X4gZNV3NqAcqKQ9TN9JZo8gYfwOZkIHPPlox4XpamuwyPRkgCrrVgq gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=i6ceCYx6lAXpeYFhnWEey2LkjdmU57GUUV9clpAqQxQ=;
 b=Axe57V7mPCfHLeY3wXBw/jugYqpfaiGD3HhZl2jK9Zd6Ohm2RmxB8yn73dEq5kiKoHZn
 eWH/K0ADmbhxDSWn7OH6bPupTqvdKSbKkNwJ/Hql9JIHvTsLN+sACsoNM7OoxrM3KRZi
 yv5AK9nhQukFnuF/QQqThs3dzc7bVRWG3SNNsa8LCabOZolsAwqE4gWsmShSCcqwLJWL
 1tCqynIh+iPM5rE8OeQOmNDnZEB8FpFCG67iut0Rl/2OAykC93bMdp9RygBD8mh4VLhp
 +gSxaV7gdrichw0l5EHeIAY4qBshFon8n50HnYga9AO8IlbNnSOqpNE1ypVRYhjchq86 QA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2u8has9r1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 14:39:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x78ENRl3092195;
        Thu, 8 Aug 2019 14:39:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2u76698bn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Aug 2019 14:39:48 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x78EdlI8013756;
        Thu, 8 Aug 2019 14:39:47 GMT
Received: from Junxiaos-MacBook-Pro.local (/10.11.16.208)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 07:39:47 -0700
Subject: Re: [PATCH] direct-io: use GFP_NOIO to avoid deadlock
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Mike Snitzer <msnitzer@redhat.com>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        honglei.wang@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <e2ddc05c-a2f8-7f62-c56f-6170adea41dc@oracle.com>
Date:   Thu, 8 Aug 2019 07:39:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1908080540240.15519@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908080146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9342 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908080146
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Mikulas,

This seemed not issue on mainline, mutex in dm_bufio_shrink_count() had 
been removed from mainline.

Thanks,

Junxiao.

On 8/8/19 2:50 AM, Mikulas Patocka wrote:
> A deadlock with this stacktrace was observed.
>
> The obvious problem here is that in the call chain
> xfs_vm_direct_IO->__blockdev_direct_IO->do_blockdev_direct_IO->kmem_cache_alloc
> we do a GFP_KERNEL allocation while we are in a filesystem driver and in a
> block device driver.
>
> This patch changes the direct-io code to use GFP_NOIO.
>
> PID: 474    TASK: ffff8813e11f4600  CPU: 10  COMMAND: "kswapd0"
>     #0 [ffff8813dedfb938] __schedule at ffffffff8173f405
>     #1 [ffff8813dedfb990] schedule at ffffffff8173fa27
>     #2 [ffff8813dedfb9b0] schedule_timeout at ffffffff81742fec
>     #3 [ffff8813dedfba60] io_schedule_timeout at ffffffff8173f186
>     #4 [ffff8813dedfbaa0] bit_wait_io at ffffffff8174034f
>     #5 [ffff8813dedfbac0] __wait_on_bit at ffffffff8173fec8
>     #6 [ffff8813dedfbb10] out_of_line_wait_on_bit at ffffffff8173ff81
>     #7 [ffff8813dedfbb90] __make_buffer_clean at ffffffffa038736f [dm_bufio]
>     #8 [ffff8813dedfbbb0] __try_evict_buffer at ffffffffa0387bb8 [dm_bufio]
>     #9 [ffff8813dedfbbd0] dm_bufio_shrink_scan at ffffffffa0387cc3 [dm_bufio]
>    #10 [ffff8813dedfbc40] shrink_slab at ffffffff811a87ce
>    #11 [ffff8813dedfbd30] shrink_zone at ffffffff811ad778
>    #12 [ffff8813dedfbdc0] kswapd at ffffffff811ae92f
>    #13 [ffff8813dedfbec0] kthread at ffffffff810a8428
>    #14 [ffff8813dedfbf50] ret_from_fork at ffffffff81745242
>
>    PID: 14127  TASK: ffff881455749c00  CPU: 11  COMMAND: "loop1"
>     #0 [ffff88272f5af228] __schedule at ffffffff8173f405
>     #1 [ffff88272f5af280] schedule at ffffffff8173fa27
>     #2 [ffff88272f5af2a0] schedule_preempt_disabled at ffffffff8173fd5e
>     #3 [ffff88272f5af2b0] __mutex_lock_slowpath at ffffffff81741fb5
>     #4 [ffff88272f5af330] mutex_lock at ffffffff81742133
>     #5 [ffff88272f5af350] dm_bufio_shrink_count at ffffffffa03865f9 [dm_bufio]
>     #6 [ffff88272f5af380] shrink_slab at ffffffff811a86bd
>     #7 [ffff88272f5af470] shrink_zone at ffffffff811ad778
>     #8 [ffff88272f5af500] do_try_to_free_pages at ffffffff811adb34
>     #9 [ffff88272f5af590] try_to_free_pages at ffffffff811adef8
>    #10 [ffff88272f5af610] __alloc_pages_nodemask at ffffffff811a09c3
>    #11 [ffff88272f5af710] alloc_pages_current at ffffffff811e8b71
>    #12 [ffff88272f5af760] new_slab at ffffffff811f4523
>    #13 [ffff88272f5af7b0] __slab_alloc at ffffffff8173a1b5
>    #14 [ffff88272f5af880] kmem_cache_alloc at ffffffff811f484b
>    #15 [ffff88272f5af8d0] do_blockdev_direct_IO at ffffffff812535b3
>    #16 [ffff88272f5afb00] __blockdev_direct_IO at ffffffff81255dc3
>    #17 [ffff88272f5afb30] xfs_vm_direct_IO at ffffffffa01fe3fc [xfs]
>    #18 [ffff88272f5afb90] generic_file_read_iter at ffffffff81198994
>    #19 [ffff88272f5afc50] __dta_xfs_file_read_iter_2398 at ffffffffa020c970 [xfs]
>    #20 [ffff88272f5afcc0] lo_rw_aio at ffffffffa0377042 [loop]
>    #21 [ffff88272f5afd70] loop_queue_work at ffffffffa0377c3b [loop]
>    #22 [ffff88272f5afe60] kthread_worker_fn at ffffffff810a8a0c
>    #23 [ffff88272f5afec0] kthread at ffffffff810a8428
>    #24 [ffff88272f5aff50] ret_from_fork at ffffffff81745242
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
>
> ---
>   fs/direct-io.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/fs/direct-io.c
> ===================================================================
> --- linux-2.6.orig/fs/direct-io.c	2019-08-02 08:51:56.000000000 +0200
> +++ linux-2.6/fs/direct-io.c	2019-08-08 11:22:18.000000000 +0200
> @@ -436,7 +436,7 @@ dio_bio_alloc(struct dio *dio, struct di
>   	 * bio_alloc() is guaranteed to return a bio when allowed to sleep and
>   	 * we request a valid number of vectors.
>   	 */
> -	bio = bio_alloc(GFP_KERNEL, nr_vecs);
> +	bio = bio_alloc(GFP_NOIO, nr_vecs);
>   
>   	bio_set_dev(bio, bdev);
>   	bio->bi_iter.bi_sector = first_sector;
> @@ -1197,7 +1197,7 @@ do_blockdev_direct_IO(struct kiocb *iocb
>   	if (iov_iter_rw(iter) == READ && !count)
>   		return 0;
>   
> -	dio = kmem_cache_alloc(dio_cache, GFP_KERNEL);
> +	dio = kmem_cache_alloc(dio_cache, GFP_NOIO);
>   	retval = -ENOMEM;
>   	if (!dio)
>   		goto out;
