Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86CF54834B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 11:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiFMJ3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 05:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiFMJ3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:29:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859051838E;
        Mon, 13 Jun 2022 02:29:12 -0700 (PDT)
X-UUID: 7fd7a7cd56aa48028009b12fd4eef166-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:ef9de552-49db-41b8-bb82-e466149488f3,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:fda38737-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 7fd7a7cd56aa48028009b12fd4eef166-20220613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 603676385; Mon, 13 Jun 2022 17:29:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 13 Jun 2022 17:29:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jun 2022 17:29:06 +0800
Message-ID: <490be4e0b984e146c93586507442de3dad8694bb.camel@mediatek.com>
Subject: Re: [PATCH] [fuse] alloc_page nofs avoid deadlock
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenguanyou <chenguanyou9338@gmail.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yong-xuan Wang =?UTF-8?Q?=28=E7=8E=8B=E8=A9=A0=E8=90=B1=29?= 
        <Yong-xuan.Wang@mediatek.com>
Date:   Mon, 13 Jun 2022 17:29:06 +0800
In-Reply-To: <CAJfpegsw3NpH6oTU9nxJLPUYMJVmfWhAa6yB8vnDZctP9vHc0g@mail.gmail.com>
References: <20210603125242.31699-1-chenguanyou@xiaomi.com>
         <CAJfpegsEkRnU26Vvo4BTQUmx89Hahp6=RTuyEcPm=rqz8icwUQ@mail.gmail.com>
         <1fabb91167a86990f4723e9036a0e006293518f4.camel@mediatek.com>
         <CAJfpegsOSWZpKHqDNE_B489dGCzLr-RVAhimVOsFkxJwMYmj9A@mail.gmail.com>
         <07c5f2f1e10671bc462f88717f84aae9ee1e4d2b.camel@mediatek.com>
         <CAJfpegvAJS=An+hyAshkNcTS8A2TM28V2UP4SYycXUw3awOR+g@mail.gmail.com>
         <YVMz8E1Lg/GZQcjw@miu.piliscsaba.redhat.com>
         <SI2PR03MB5545E0B76E54013678B9FEEC8BA99@SI2PR03MB5545.apcprd03.prod.outlook.com>
         <07ad7d51d15c7ffc708b55066ded653a4b2c5c98.camel@mediatek.com>
         <CAJfpegsw3NpH6oTU9nxJLPUYMJVmfWhAa6yB8vnDZctP9vHc0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-06-13 at 16:45 +0800, Miklos Szeredi wrote:
> On Fri, 10 Jun 2022 at 09:48, Ed Tsai <ed.tsai@mediatek.com> wrote:
> 
> > Recently, we get this deadlock issue again.
> > fuse_flush_time_update()
> > use sync_inode_metadata() and it only write the metadata, so the
> > writeback worker could still be blocked becaused of file data.
> > 
> > I try to use write_inode_now() instead of sync_inode_metadata() and
> > the
> > writeback thread will not be blocked anymore. I don't think this is
> > a
> > good solution, but this confirm that there is still a potential
> > deadlock because of file data. WDYT.
> 
> I'm not sure how that happens.  Normally writeback doesn't
> block.  Can
> you provide the stack traces of all related tasks in the deadlock?
> 
> Thanks,
> Miklos

The writeback worker
ppid=22915 pid=22915 S cpu=6 prio=120 wait=3614s kworker/u16:21
vmlinux  request_wait_answer + 64
vmlinux  __fuse_request_send + 328
vmlinux  fuse_request_send + 60
vmlinux  fuse_simple_request + 376
vmlinux  fuse_flush_times + 276
vmlinux  fuse_write_inode + 104 (inode=0xFFFFFFD516CC4780, ff=0)
vmlinux  write_inode + 384
vmlinux  __writeback_single_inode + 960
vmlinux  writeback_sb_inodes + 892
vmlinux  __writeback_inodes_wb + 156
vmlinux  wb_writeback + 512
vmlinux  wb_check_background_flush + 600
vmlinux  wb_do_writeback + 644
vmlinux  wb_workfn + 756
vmlinux  process_one_work + 628
vmlinux  worker_thread + 708
vmlinux  kthread + 376
vmlinux  ret_from_fork + 16

Thread-11
ppid=3961 pid=26057 D cpu=4 prio=120 wait=3614s Thread-11
vmlinux  __inode_wait_for_writeback + 108
vmlinux  inode_wait_for_writeback + 156
vmlinux  evict + 160
vmlinux  iput_final + 292
vmlinux  iput + 600
vmlinux  dentry_unlink_inode + 212
vmlinux  __dentry_kill + 228
vmlinux  shrink_dentry_list + 408
vmlinux  prune_dcache_sb + 80
vmlinux  super_cache_scan + 272
vmlinux  do_shrink_slab + 944
vmlinux  shrink_slab + 1104
vmlinux  shrink_node + 712
vmlinux  shrink_zones + 188
vmlinux  do_try_to_free_pages + 348
vmlinux  try_to_free_pages + 848
vmlinux  __perform_reclaim + 64
vmlinux  __alloc_pages_direct_reclaim + 64
vmlinux  __alloc_pages_slowpath + 1296
vmlinux  __alloc_pages_nodemask + 2004
vmlinux  __alloc_pages + 16
vmlinux  __alloc_pages_node + 16
vmlinux  alloc_pages_node + 16
vmlinux  __read_swap_cache_async + 172
vmlinux  read_swap_cache_async + 12
vmlinux  swapin_readahead + 328
vmlinux  do_swap_page + 844
vmlinux  handle_pte_fault + 268
vmlinux  __handle_speculative_fault + 548
vmlinux  handle_speculative_fault + 44
vmlinux  do_page_fault + 500
vmlinux  do_translation_fault + 64
vmlinux  do_mem_abort + 72
vmlinux  el0_sync + 1032

ppid=3961 is com.google.android.providers.media.module, and it is the
android fuse daemon.

So, the daemon and wb worker were wait for each other.

Best,
Ed Tsai

