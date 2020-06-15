Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABA31F9A50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgFOOdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 10:33:17 -0400
Received: from mail.itouring.de ([188.40.134.68]:54726 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730353AbgFOOdP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:33:15 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 10:33:12 EDT
Received: from tux.applied-asynchrony.com (p5ddd79e0.dip0.t-ipconnect.de [93.221.121.224])
        by mail.itouring.de (Postfix) with ESMTPSA id 21FEC41603A0;
        Mon, 15 Jun 2020 16:25:53 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id C7CD3F01600;
        Mon, 15 Jun 2020 16:25:52 +0200 (CEST)
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in
 ->writepages
To:     Yafang Shao <laoar.shao@gmail.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <e4c7868a-9107-573f-c1f4-24c3aa4c9d1f@applied-asynchrony.com>
Date:   Mon, 15 Jun 2020 16:25:52 +0200
MIME-Version: 1.0
In-Reply-To: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020-06-15 13:56, Yafang Shao wrote:
> Recently there is a XFS deadlock on our server with an old kernel.
> This deadlock is caused by allocating memory in xfs_map_blocks() while
> doing writeback on behalf of memroy reclaim. Although this deadlock happens
> on an old kernel, I think it could happen on the upstream as well. This
> issue only happens once and can't be reproduced, so I haven't tried to
> reproduce it on upsteam kernel.
> 
> Bellow is the call trace of this deadlock.
> [480594.790087] INFO: task redis-server:16212 blocked for more than 120 seconds.
> [480594.790087] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [480594.790088] redis-server    D ffffffff8168bd60     0 16212  14347 0x00000004
> [480594.790090]  ffff880da128f070 0000000000000082 ffff880f94a2eeb0 ffff880da128ffd8
> [480594.790092]  ffff880da128ffd8 ffff880da128ffd8 ffff880f94a2eeb0 ffff88103f9d6c40
> [480594.790094]  0000000000000000 7fffffffffffffff ffff88207ffc0ee8 ffffffff8168bd60
> [480594.790096] Call Trace:
> [480594.790101]  [<ffffffff8168dce9>] schedule+0x29/0x70
> [480594.790103]  [<ffffffff8168b749>] schedule_timeout+0x239/0x2c0
> [480594.790111]  [<ffffffff8168d28e>] io_schedule_timeout+0xae/0x130
> [480594.790114]  [<ffffffff8168d328>] io_schedule+0x18/0x20
> [480594.790116]  [<ffffffff8168bd71>] bit_wait_io+0x11/0x50
> [480594.790118]  [<ffffffff8168b895>] __wait_on_bit+0x65/0x90
> [480594.790121]  [<ffffffff811814e1>] wait_on_page_bit+0x81/0xa0
> [480594.790125]  [<ffffffff81196ad2>] shrink_page_list+0x6d2/0xaf0
> [480594.790130]  [<ffffffff811975a3>] shrink_inactive_list+0x223/0x710
> [480594.790135]  [<ffffffff81198225>] shrink_lruvec+0x3b5/0x810
> [480594.790139]  [<ffffffff8119873a>] shrink_zone+0xba/0x1e0
> [480594.790141]  [<ffffffff81198c20>] do_try_to_free_pages+0x100/0x510
> [480594.790143]  [<ffffffff8119928d>] try_to_free_mem_cgroup_pages+0xdd/0x170
> [480594.790145]  [<ffffffff811f32de>] mem_cgroup_reclaim+0x4e/0x120
> [480594.790147]  [<ffffffff811f37cc>] __mem_cgroup_try_charge+0x41c/0x670
> [480594.790153]  [<ffffffff811f5cb6>] __memcg_kmem_newpage_charge+0xf6/0x180
> [480594.790157]  [<ffffffff8118c72d>] __alloc_pages_nodemask+0x22d/0x420
> [480594.790162]  [<ffffffff811d0c7a>] alloc_pages_current+0xaa/0x170
> [480594.790165]  [<ffffffff811db8fc>] new_slab+0x30c/0x320
> [480594.790168]  [<ffffffff811dd17c>] ___slab_alloc+0x3ac/0x4f0
> [480594.790204]  [<ffffffff81685656>] __slab_alloc+0x40/0x5c
> [480594.790206]  [<ffffffff811dfc43>] kmem_cache_alloc+0x193/0x1e0
> [480594.790233]  [<ffffffffa04fab67>] kmem_zone_alloc+0x97/0x130 [xfs]
> [480594.790247]  [<ffffffffa04f90ba>] _xfs_trans_alloc+0x3a/0xa0 [xfs]
> [480594.790261]  [<ffffffffa04f915c>] xfs_trans_alloc+0x3c/0x50 [xfs]
> [480594.790276]  [<ffffffffa04e958b>] xfs_iomap_write_allocate+0x1cb/0x390 [xfs]
> [480594.790299]  [<ffffffffa04d3616>] xfs_map_blocks+0x1a6/0x210 [xfs]
> [480594.790312]  [<ffffffffa04d416b>] xfs_do_writepage+0x17b/0x550 [xfs]
> [480594.790314]  [<ffffffff8118d881>] write_cache_pages+0x251/0x4d0 [xfs]
> [480594.790338]  [<ffffffffa04d3e05>] xfs_vm_writepages+0xc5/0xe0 [xfs]
> [480594.790341]  [<ffffffff8118ebfe>] do_writepages+0x1e/0x40
> [480594.790343]  [<ffffffff811837b5>] __filemap_fdatawrite_range+0x65/0x80
> [480594.790346]  [<ffffffff81183901>] filemap_write_and_wait_range+0x41/0x90
> [480594.790360]  [<ffffffffa04df2c6>] xfs_file_fsync+0x66/0x1e0 [xfs]
> [480594.790363]  [<ffffffff81231cf5>] do_fsync+0x65/0xa0
> [480594.790365]  [<ffffffff81231fe3>] SyS_fdatasync+0x13/0x20
> [480594.790367]  [<ffffffff81698d09>] system_call_fastpath+0x16/0x1b
> 
> Note that xfs_iomap_write_allocate() is replaced by xfs_convert_blocks() in
> commit 4ad765edb02a ("xfs: move xfs_iomap_write_allocate to xfs_aops.c")
> and write_cache_pages() is replaced by iomap_writepages() in
> commit 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap").
> So for upsteam, the call trace should be,
> xfs_vm_writepages
>    -> iomap_writepages
>       -> write_cache_pages
>          -> iomap_do_writepage
>             -> xfs_map_blocks
>                -> xfs_convert_blocks
>                   -> xfs_bmapi_convert_delalloc
>                      -> xfs_trans_alloc //It should alloc page with GFP_NOFS
> 
> I'm not sure whether it is proper to add the GFP_NOFS to all the
> ->writepags, so I only add it for XFS.
> 
> Stefan also reported that he saw this issue two times while under memory
> pressure, So I add his reported-by.
> 
> Reported-by: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> 
> ---
> v2 -> v3:
> - retitle the subject from "iomap: avoid deadlock if memory reclaim is
>    triggered in writepage path"
> - set GFP_NOFS only for XFS ->writepages
> 
> v1 -> v2:
> - retitle the subject from "xfs: avoid deadlock when tigger memory reclam
>    in xfs_map_blocks()"
> - set GFP_NOFS in iomap_do_writepage(), per Dave
> ---
>   fs/xfs/xfs_aops.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> index b356118..1ccfbf2 100644
> --- a/fs/xfs/xfs_aops.c
> +++ b/fs/xfs/xfs_aops.c
> @@ -573,9 +573,21 @@ static inline bool xfs_ioend_needs_workqueue(struct iomap_ioend *ioend)
>   	struct writeback_control *wbc)
>   {
>   	struct xfs_writepage_ctx wpc = { };
> +	unsigned int nofs_flag;
> +	int ret;
>   
>   	xfs_iflags_clear(XFS_I(mapping->host), XFS_ITRUNCATED);
> -	return iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> +
> +	/*
> +	 * We can allocate memory here while doing writeback on behalf of
> +	 * memory reclaim.  To avoid memory allocation deadlocks set the
> +	 * task-wide nofs context for the following operations.
> +	 */
> +	nofs_flag = memalloc_nofs_save();
> +	ret = iomap_writepages(mapping, wbc, &wpc.ctx, &xfs_writeback_ops);
> +	memalloc_nofs_restore(nofs_flag);
> +
> +	return ret;
>   }
>   
>   STATIC int
> 

Not sure if I did something wrong, but while the previous version of this patch
worked fine, this one gave me (with v2 removed obviously):

[  +0.000004] WARNING: CPU: 0 PID: 2811 at fs/iomap/buffered-io.c:1544 iomap_do_writepage+0x6b4/0x780
[  +0.000001] Modules linked in: tcp_bbr2 sch_fq_codel nct6775 hwmon_vid btrfs blake2b_generic xor zstd_compress x86_pkg_temp_thermal drivetemp coretemp crc32_pclmul raid6_pq zstd_decompress aesni_intel i915 crypto_simd cryptd glue_helper intel_gtt bfq i2c_algo_bit iosf_mbi drm_kms_helper i2c_i801 mq_deadline syscopyarea sysfillrect usbhid sysimgblt fb_sys_fops drm drm_panel_orientation_quirks i2c_core atlantic video backlight
[  +0.000013] CPU: 0 PID: 2811 Comm: dmesg Not tainted 5.7.2 #1
[  +0.000000] Hardware name: System manufacturer System Product Name/P8Z68-V LX, BIOS 4105 07/01/2013
[  +0.000002] RIP: 0010:iomap_do_writepage+0x6b4/0x780
[  +0.000001] Code: ff e9 bf fc ff ff 48 8b 44 24 48 48 39 44 24 28 0f 84 f7 fb ff ff 0f 0b e9 f0 fb ff ff 4c 8b 64 24 10 41 89 c7 e9 d8 fb ff ff <0f> 0b eb 88 8b 54 24 24 85 d2 75 5f 49 8b 45 50 48 8b 40 10 48 85
[  +0.000001] RSP: 0018:ffffc90000277ae8 EFLAGS: 00010206
[  +0.000001] RAX: 0000000000444004 RBX: ffffc90000277bc0 RCX: 0000000000000018
[  +0.000000] RDX: 0000000000000000 RSI: ffffc90000277d58 RDI: ffffea001fd25e00
[  +0.000001] RBP: ffff8887f7edfd40 R08: ffffffffffffffff R09: 0000000000000006
[  +0.000001] R10: ffff88881f5dd000 R11: 000000000000020d R12: ffffea001fd25e00
[  +0.000000] R13: ffffc90000277c80 R14: ffff8887fb95e800 R15: ffffea001fd25e00
[  +0.000001] FS:  0000000000000000(0000) GS:ffff8887ff600000(0000) knlGS:0000000000000000
[  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000000] CR2: 00007f836c0915e8 CR3: 0000000002009005 CR4: 00000000000606f0
[  +0.000001] Call Trace:
[  +0.000006]  ? page_mkclean+0x5e/0x90
[  +0.000003]  ? clear_page_dirty_for_io+0x18a/0x1d0
[  +0.000002]  write_cache_pages+0x196/0x400
[  +0.000001]  ? iomap_readpages+0x180/0x180
[  +0.000003]  iomap_writepages+0x1c/0x40
[  +0.000003]  xfs_vm_writepages+0x68/0x90
[  +0.000002]  do_writepages+0x25/0xa0
[  +0.000002]  __filemap_fdatawrite_range+0xa7/0xe0
[  +0.000002]  xfs_release+0x11b/0x160
[  +0.000002]  __fput+0xd7/0x240
[  +0.000003]  task_work_run+0x5c/0x80
[  +0.000001]  do_exit+0x33b/0x9c0
[  +0.000001]  do_group_exit+0x33/0x90
[  +0.000002]  __x64_sys_exit_group+0x14/0x20
[  +0.000001]  do_syscall_64+0x4e/0x310
[  +0.000003]  ? do_user_addr_fault+0x1df/0x460
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  +0.000001] RIP: 0033:0x7f836bf73489
[  +0.000003] Code: Bad RIP value.
[  +0.000000] RSP: 002b:00007fff90ec3b98 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[  +0.000001] RAX: ffffffffffffffda RBX: 00007f836c0626e0 RCX: 00007f836bf73489
[  +0.000001] RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
[  +0.000001] RBP: 00007f836c0626e0 R08: ffffffffffffff80 R09: 00007fff90ec3a60
[  +0.000000] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[  +0.000001] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000
[  +0.000001] ---[ end trace aed8763335accf60 ]---

..and hosed the fs by eating any writeback, zeroing out $things.
0/10 cats, do not want.

-h
