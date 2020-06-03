Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3321EC9B4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFCGsz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 02:48:55 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55872 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFCGsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:48:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200603064852euoutp029e47512c42a6cfce866b5388f1a6fdea~U9eUWQ10V1614116141euoutp020
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2020 06:48:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200603064852euoutp029e47512c42a6cfce866b5388f1a6fdea~U9eUWQ10V1614116141euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591166932;
        bh=FP+oHu1ZKPLgzkpn+WtVvYWahse9lDSc5c8CXSXoDuw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S9m8oly8sddS6EL39ylPOAAFBMBUeOfjtsBwFUT5jFOX9bda35LST2qRRsYbydW61
         pB6aQQY0akz9+DlEZTF6yTtcytgre3kFerWzsxLcMYta/kfoERGYXeX9tkjhRFsWE2
         goZ6uCQpThD71RZ1jDXUMqGXjeCqjVXnvrFmcfoQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200603064852eucas1p1bd0bcfd345341dce68a296375fb0a791~U9eUHWNvv2442224422eucas1p1u;
        Wed,  3 Jun 2020 06:48:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B0.F8.60679.4D747DE5; Wed,  3
        Jun 2020 07:48:52 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b~U9eTepbYJ0363103631eucas1p2T;
        Wed,  3 Jun 2020 06:48:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200603064851eusmtrp2e11aa2f6a4bf3a04b87301913d7ca40f~U9eTd6Xir1776517765eusmtrp2U;
        Wed,  3 Jun 2020 06:48:51 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-b8-5ed747d48e40
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.F1.08375.3D747DE5; Wed,  3
        Jun 2020 07:48:51 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200603064851eusmtip24519b279e7936764c77c01632cbc1b25~U9eTCtPhA0725207252eusmtip2j;
        Wed,  3 Jun 2020 06:48:51 +0000 (GMT)
Subject: Re: [PATCHv5 3/5] ext4: mballoc: Introduce pcpu seqcnt for freeing
 PA to improve ENOSPC handling
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <aa4f7629-02ff-e49b-e9c0-5ef4a1deee90@samsung.com>
Date:   Wed, 3 Jun 2020 08:48:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7pX3K/HGZz5zmFx8aC/xfPlixkt
        Zs67w2axZ+9JFovLu+awWbx6fIvdorXnJ7sDu8eERQcYPZrOHGX2WL/lKovH501yASxRXDYp
        qTmZZalF+nYJXBk/vz5lLDinXfF78RzmBsbNKl2MnBwSAiYSF6/dY+9i5OIQEljBKHHocDsz
        hPOFUWLxyXNsEM5nRommvzMZYVpWd+9nhUgsZ5S4vOEsVMt7Rokvd04yg1QJC2RLrNi6kwnE
        FhFwk1iz9wwTSBGzwHpGiSd314ONYhMwlOh628UGYvMK2En8P/kQrJlFQEVi+cPDLCC2qECs
        RM/9V8wQNYISJ2c+AYtzCsRITPzSCdbLLCAv0bx1NjOELS5x68l8JohT17FLPOiIg7BdJB7t
        m80OYQtLvDq+BcqWkfi/cz7YcRICzYwSD8+tZYdweoB+a5oB9bS1xJ1zv4C2cQBt0JRYv0sf
        Iuwo8W3pNrCwhACfxI23ghA38ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJZ7OQ
        fDMLyTezEPYuYGRZxSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJEZh6Tv87/mUH464/SYcY
        BTgYlXh4DQyvxQmxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/x
        opexQgLpiSWp2ampBalFMFkmDk6pBkbOzHNlatlqUyo3tzBeMd9rzL2R32XPso88FlV7ZnU8
        YZ8gbdIb0bx4zs3C0yfXL2ubmNU1O/qRzGW3T74TnlQt/eWQua0z9kxK2xeb5rPPUn7LKJY7
        cKc7y+gxvuhyvr/CXdciTfTk3Fm2sbMPnhAX558c0GXblvwwdEnAgVVJE5u3aUiZKSmxFGck
        GmoxFxUnAgBNLVKtOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7qX3a/HGcx7qW5x8aC/xfPlixkt
        Zs67w2axZ+9JFovLu+awWbx6fIvdorXnJ7sDu8eERQcYPZrOHGX2WL/lKovH501yASxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk/vz5lLDin
        XfF78RzmBsbNKl2MnBwSAiYSq7v3s3YxcnEICSxllFgy6zwzREJG4uS0BlYIW1jiz7UuNoii
        t4wSE1afZwdJCAtkS8zaegesSETATWLN3jNMIEXMAhsZJQ7MuMgM0dHFKHFv8lFGkCo2AUOJ
        rrcgozg5eAXsJP6ffAi2jkVARWL5w8MsILaoQKxE9+If7BA1ghInZz4Bi3MKxEhM/NIJ1sss
        YCYxbzNEL7OAvETz1tlQtrjErSfzmSYwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhX
        nJhbXJqXrpecn7uJERht24793LyD8dLG4EOMAhyMSjy8BobX4oRYE8uKK3MPMUpwMCuJ8Dqd
        PR0nxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnARJBXEm9oamhuYWlobmxubGahJM7bIXAw
        RkggPbEkNTs1tSC1CKaPiYNTqoGxPGEmS866/GufAqpuXDl32sE0IKRJZVKt4KGFR/7PCppo
        VSotzMRVEzK5N4uZNaqe95yWxv5ZL0Tznq3ludPEccnXofHJY07bz6XS3wpnzVNb2N64SjSJ
        bfHM+Dn/9k2/0G3EuT/zdJXpu7CjD4PuFrs1lj8tvs17i3t35beJWZv/n6uPXvFMiaU4I9FQ
        i7moOBEA4qcxKMwCAAA=
X-CMS-MailID: 20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b
References: <cover.1589955723.git.riteshh@linux.ibm.com>
        <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
        <CGME20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b@eucas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ritesh,

On 20.05.2020 08:40, Ritesh Harjani wrote:
> There could be a race in function ext4_mb_discard_group_preallocations()
> where the 1st thread may iterate through group's bb_prealloc_list and
> remove all the PAs and add to function's local list head.
> Now if the 2nd thread comes in to discard the group preallocations,
> it will see that the group->bb_prealloc_list is empty and will return 0.
>
> Consider for a case where we have less number of groups
> (for e.g. just group 0),
> this may even return an -ENOSPC error from ext4_mb_new_blocks()
> (where we call for ext4_mb_discard_group_preallocations()).
> But that is wrong, since 2nd thread should have waited for 1st thread
> to release all the PAs and should have retried for allocation.
> Since 1st thread was anyway going to discard the PAs.
>
> The algorithm using this percpu seq counter goes below:
> 1. We sample the percpu discard_pa_seq counter before trying for block
>     allocation in ext4_mb_new_blocks().
> 2. We increment this percpu discard_pa_seq counter when we either allocate
>     or free these blocks i.e. while marking those blocks as used/free in
>     mb_mark_used()/mb_free_blocks().
> 3. We also increment this percpu seq counter when we successfully identify
>     that the bb_prealloc_list is not empty and hence proceed for discarding
>     of those PAs inside ext4_mb_discard_group_preallocations().
>
> Now to make sure that the regular fast path of block allocation is not
> affected, as a small optimization we only sample the percpu seq counter
> on that cpu. Only when the block allocation fails and when freed blocks
> found were 0, that is when we sample percpu seq counter for all cpus using
> below function ext4_get_discard_pa_seq_sum(). This happens after making
> sure that all the PAs on grp->bb_prealloc_list got freed or if it's empty.
>
> It can be well argued that why don't just check for grp->bb_free to
> see if there are any free blocks to be allocated. So here are the two
> concerns which were discussed:-
>
> 1. If for some reason the blocks available in the group are not
>     appropriate for allocation logic (say for e.g.
>     EXT4_MB_HINT_GOAL_ONLY, although this is not yet implemented), then
>     the retry logic may result into infinte looping since grp->bb_free is
>     non-zero.
>
> 2. Also before preallocation was clubbed with block allocation with the
>     same ext4_lock_group() held, there were lot of races where grp->bb_free
>     could not be reliably relied upon.
> Due to above, this patch considers discard_pa_seq logic to determine if
> we should retry for block allocation. Say if there are are n threads
> trying for block allocation and none of those could allocate or discard
> any of the blocks, then all of those n threads will fail the block
> allocation and return -ENOSPC error. (Since the seq counter for all of
> those will match as no block allocation/discard was done during that
> duration).
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

This patch landed in yesterday's linux-next and causes following 
WARNING/BUG on various Samsung Exynos-based boards:

  BUG: using smp_processor_id() in preemptible [00000000] code: logsave/552
  caller is ext4_mb_new_blocks+0x404/0x1300
  CPU: 3 PID: 552 Comm: logsave Tainted: G        W 5.7.0-next-20200602 #4
  Hardware name: Samsung Exynos (Flattened Device Tree)
  [<c011184c>] (unwind_backtrace) from [<c010d250>] (show_stack+0x10/0x14)
  [<c010d250>] (show_stack) from [<c05185fc>] (dump_stack+0xbc/0xe8)
  [<c05185fc>] (dump_stack) from [<c0ab689c>] 
(check_preemption_disabled+0xec/0xf0)
  [<c0ab689c>] (check_preemption_disabled) from [<c03a7b38>] 
(ext4_mb_new_blocks+0x404/0x1300)
  [<c03a7b38>] (ext4_mb_new_blocks) from [<c03780f4>] 
(ext4_ext_map_blocks+0xc7c/0x10f4)
  [<c03780f4>] (ext4_ext_map_blocks) from [<c03902b4>] 
(ext4_map_blocks+0x118/0x5a0)
  [<c03902b4>] (ext4_map_blocks) from [<c0394524>] 
(mpage_map_and_submit_extent+0x134/0x9c0)
  [<c0394524>] (mpage_map_and_submit_extent) from [<c03958c8>] 
(ext4_writepages+0xb18/0xcb0)
  [<c03958c8>] (ext4_writepages) from [<c02588ec>] (do_writepages+0x20/0x94)
  [<c02588ec>] (do_writepages) from [<c024c688>] 
(__filemap_fdatawrite_range+0xac/0xcc)
  [<c024c688>] (__filemap_fdatawrite_range) from [<c024c700>] 
(filemap_flush+0x28/0x30)
  [<c024c700>] (filemap_flush) from [<c037eedc>] 
(ext4_release_file+0x70/0xac)
  [<c037eedc>] (ext4_release_file) from [<c02c3310>] (__fput+0xc4/0x234)
  [<c02c3310>] (__fput) from [<c014eb74>] (task_work_run+0x88/0xcc)
  [<c014eb74>] (task_work_run) from [<c010ca40>] 
(do_work_pending+0x52c/0x5cc)
  [<c010ca40>] (do_work_pending) from [<c0100094>] 
(slow_work_pending+0xc/0x20)
  Exception stack(0xec9c1fb0 to 0xec9c1ff8)
  1fa0:                                     00000000 0044969c 0000006c 
00000000
  1fc0: 00000001 0045a014 00000241 00000006 00000000 be91abb4 be91abb0 
0000000c
  1fe0: 00459fd4 be91ab90 00448ed4 b6e43444 60000050 00000003

Please let me know how I can help debugging this issue. The above log is 
from linux-next 20200602 compiled from exynos_defconfig running on ARM 
32bit Samsung Exynos4412-based Odroid U3 board, however I don't think 
this is Exynos specific issue. Probably I've observed it, because 
exynos_defconfig has most of the debugging options enabled.

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

