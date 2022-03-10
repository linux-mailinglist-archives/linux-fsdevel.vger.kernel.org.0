Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07E74D456C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 12:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiCJLOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 06:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236453AbiCJLOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:14:43 -0500
X-Greylist: delayed 128 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 03:13:39 PST
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D2F65E5;
        Thu, 10 Mar 2022 03:13:39 -0800 (PST)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id FGV00041;
        Thu, 10 Mar 2022 19:10:41 +0800
Received: from localhost.localdomain (172.16.35.8) by GCY-MBS-28.TCL.com
 (10.136.3.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Mar
 2022 19:10:42 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <miklos@szeredi.hu>
CC:     <Ed.Tsai@mediatek.com>, <guoweichao@oppo.com>,
        <huangjianan@oppo.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <zhangshiming@oppo.com>
Subject: Re: [fuse-devel] [PATCH] fuse: avoid deadlock when write fuse inode
Date:   Thu, 10 Mar 2022 19:10:26 +0800
Message-ID: <20220310111026.684924-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJfpegsbORd5hDhnth5qY1aP-6AZDMe9f9+CyWVhvpEmHPnuwQ@mail.gmail.com>
References: <CAJfpegsbORd5hDhnth5qY1aP-6AZDMe9f9+CyWVhvpEmHPnuwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.35.8]
X-ClientProxiedBy: GCY-EXS-05.TCL.com (10.74.128.155) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   20223101910411d16907f6fcc7c4fc6f62671d6c235dc
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Miklos

The similar issue occurs in our Android device(4G RAM + 3G zram + 8 arm cores + kernel-4.14) too.
Under the monkey test, kswapd and fuse daemon thread deadlocked when free pages is extreme low
(less than 1/2 of the min watermark), the backtrace of the 2 threads is as follows. kswapd
try to evict inode to free some memory(blocked at inode_wait_for_writeback), and fuse daemon thread
handle the fuse inode write request, which is throttled when do direct reclaim in page allocation
slow path(blocked at throttle_direct_reclaim). As the __GFP_FS is set, the thread is throttled until
kswapd free enough pages until watermark ok(check allow_direct_reclaim), which cause the deadlock.
Although the kernel version is 4.14, the same issue exists in the upstream kernel too.

kswapd0         D 26485194.538158 157 1287917 23577482 0x1a20840 0x0 157 438599862461462
<ffffff8beec866b4> __switch_to+0x134/0x150
<ffffff8befb838cc> __schedule+0xd5c/0x1100
<ffffff8befb83ce0> schedule+0x70/0x90
<ffffff8befb849b4> bit_wait+0x14/0x54
<ffffff8befb84350> __wait_on_bit+0x74/0xe0
<ffffff8beeeae0b4> inode_wait_for_writeback+0xa0/0xe4
<ffffff8beee9b95c> evict+0xa4/0x284
<ffffff8beee99b58> iput+0x25c/0x2ac
<ffffff8beee9602c> dentry_unlink_inode+0xd8/0xe4
<ffffff8beee93274> __dentry_kill+0xe8/0x22c
<ffffff8beee9374c> shrink_dentry_list+0x19c/0x3b0
<ffffff8beee9340c> prune_dcache_sb+0x54/0x80
<ffffff8beee79c50> super_cache_scan+0x114/0x164
<ffffff8beee16504> shrink_slab+0x454/0x528
<ffffff8beee1b81c> shrink_node+0x144/0x318
<ffffff8beee1a100> kswapd+0x830/0x9e0
<ffffff8beecde9f0> kthread+0x17c/0x18c
<ffffff8beec856a4> ret_from_fork+0x10/0x18
<ffffffffffffffff> 0xffffffffffffffff

Thread-19       D 7542.719029 2888 24823 5064 0x1404840 0x1000008 24235 438599754021693
<ffffff8beec866b4> __switch_to+0x134/0x150
<ffffff8befb838cc> __schedule+0xd5c/0x1100
<ffffff8befb83ce0> schedule+0x70/0x90
<ffffff8beee18258> try_to_free_pages+0x264/0x4b0
<ffffff8beee06978> __alloc_pages_nodemask+0x7a4/0x10d0
<ffffff8beefac784> fuse_copy_fill+0x15c/0x210
<ffffff8beefabbcc> fuse_dev_do_read+0x434/0xc24
<ffffff8beefab56c> fuse_dev_splice_read+0x84/0x1d8
<ffffff8beeeb5788> SyS_splice+0x67c/0x8bc
<ffffff8beec83fc0> el0_svc_naked+0x34/0x38
<ffffffffffffffff> 0xffffffffffffffff

code snippet:
static bool throttle_direct_reclaim(...)
{
...
	/*
	 * If the caller cannot enter the filesystem, it's possible that it
	 * is due to the caller holding an FS lock or performing a journal
	 * transaction in the case of a filesystem like ext[3|4]. In this case,
	 * it is not safe to block on pfmemalloc_wait as kswapd could be
	 * blocked waiting on the same lock. Instead, throttle for up to a
	 * second before continuing.
	 */
	if (!(gfp_mask & __GFP_FS)) {
		wait_event_interruptible_timeout(pgdat->pfmemalloc_wait,
			allow_direct_reclaim(pgdat), HZ);

		goto check_pending;
	}

	/* Throttle until kswapd wakes the process */
	wait_event_killable(zone->zone_pgdat->pfmemalloc_wait,
		allow_direct_reclaim(pgdat));
...
}

Thanks,
yanwu

On Wed, 24 Mar 2021 16:28:35 +0100 Miklos Szeredi via <miklos@szeredi.hu> wrote:
> On what kernel are you seeing this?

> I don't see how it can happen on upstream kernels, since there's a
>"write_inode_now(inode, 1)" call in fuse_release() and nothing can
> dirty the inode after the file has been released.

> Thanks,
> Miklos

>On Tue, Feb 2, 2021 at 5:41 AM Huang Jianan via fuse-devel
><fuse-devel@lists.sourceforge.net> wrote:
>>
>> We found the following deadlock situations in low memory scenarios:
>> Thread A                         Thread B
>> - __writeback_single_inode
>>  - fuse_write_inode
>>   - fuse_simple_request
>>    - __fuse_request_send
>>     - request_wait_answer
>>                                  - fuse_dev_splice_read
>>                                   - fuse_copy_fill
>>                                    - __alloc_pages_direct_reclaim
>>                                     - do_shrink_slab
>>                                      - super_cache_scan
>>                                       - shrink_dentry_list
>>                                        - dentry_unlink_inode
>>                                         - iput_final
>>                                          - inode_wait_for_writeback


