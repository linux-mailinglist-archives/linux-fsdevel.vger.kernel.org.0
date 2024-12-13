Return-Path: <linux-fsdevel+bounces-37279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B279F0999
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE14282B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417321B982C;
	Fri, 13 Dec 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mxTayN3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED54199947
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086163; cv=none; b=LU+iUN+aB8YSPouOk57ky5T67ASaYLiz9L4BxuJi/1Eb5pqKj0VovaPsGVi5d+09sFE+dPsYAupSoUTsIXvbr9sqRqUcHPFKC2ymrVJ2KWlYOLJXsB2gy+sscY7J/rWQTPTyGM+c5eD+rmQdwudM+/7wUOJMArknfwyBkiCOU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086163; c=relaxed/simple;
	bh=uQk3YiNhVftPdOBtGtcASBXBwlbiU9NElxYJFE/USb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=V6nAiz0sjQVcHvAsNkEnD3TCtQuy8uOwClSD7rRBI1D6SBwG2SClzRNhC5270KSY9afDzG4F1VC3RoBSlNWKKy2RRkv3Gml0CjubNh98/Fcm20oQd0dxuENd6UR1CGRkErHpP+cAhLFs0aXdWuuJdOaVhqDKlnh1Iq4aTKee2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mxTayN3i; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241213103551euoutp01d029820d4c3bc17d5ebd3e88610adf35~QtirlLYKg1544615446euoutp01L
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 10:35:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241213103551euoutp01d029820d4c3bc17d5ebd3e88610adf35~QtirlLYKg1544615446euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734086151;
	bh=F3SNy8Zh+7aBpHD+922mycwN1XOIOHNBjqabKdr3dmk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mxTayN3iFlnczVdvlBOEhph+HiZDvXrrpohVeQJpAcNcTtBkwyeO5FH0PZBv6HQX/
	 1LSuCTUPCBeLKAKTry/smTv+HxrSJKGwmhwhB3dGKt3EcGNLXrVhkwgyVeRgogh+9t
	 3/H5i7rx6HaMliMOC4KOdbDUMrXaEIsouL8hY3xM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241213103551eucas1p21c756187c5859bd07e908ebd0d40432b~QtirfqAMC3195031950eucas1p2I;
	Fri, 13 Dec 2024 10:35:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.33.20397.70E0C576; Fri, 13
	Dec 2024 10:35:51 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e~QtirDAMp10560505605eucas1p1W;
	Fri, 13 Dec 2024 10:35:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241213103551eusmtrp24fe9ec5ba1aec7f5603f3f62a2a2f161~QtirCaK-41076910769eusmtrp2J;
	Fri, 13 Dec 2024 10:35:51 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-2a-675c0e0710f2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id AC.6D.19920.70E0C576; Fri, 13
	Dec 2024 10:35:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241213103550eusmtip148085130d9dea76c534abbed313f7439~Qtip9vjN90495804958eusmtip1k;
	Fri, 13 Dec 2024 10:35:50 +0000 (GMT)
Message-ID: <e3b555c5-4aff-4f0d-b45b-9c46240a02da@samsung.com>
Date: Fri, 13 Dec 2024 11:35:48 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 2/2] pidfs: use maple tree
To: Christian Brauner <brauner@kernel.org>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241209-work-pidfs-maple_tree-v2-2-003dbf3bd96b@kernel.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduznOV12vph0g/5FmhavD39itNje8IDd
	Ys/ekywWG1Y2MFn8/jGHzYHVY/MKLY9NqzrZPDYvqff4+PQWi8fnTXIBrFFcNimpOZllqUX6
	dglcGa8O9LEUrA2s2L95BVMD43bHLkZODgkBE4nZlz8wdjFycQgJrGCU+Dl9IytIQkjgC6PE
	975YiMRnRolfb2+xdTFygHV8f8cFUbMcqGGlMkTNR0aJe8cbmUASvAJ2Ep/P7WcBsVkEVCVW
	H5sPFReUODnzCVhcVEBe4v6tGewgtrCAqcSVKyfBFosI1Et8vd7CBmIzCzhK3Gp7zwxhi0vc
	egIxh03AUKLrbRfYPZwCXhL33iZAlMhLNG+dzQzx2AkOicaTqhC2i8TLU5/YIGxhiVfHt7BD
	2DIS/3eCjOQCstsZJRb8vg/lTGCUaHh+ixGiylrizrlfYMuYBTQl1u/Shwg7Sjy6280MCRM+
	iRtvBSFu4JOYtG06VJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlKgzELy5Cwk38xC2LuAkWUV
	o3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYJI5/e/41x2MK1591DvEyMTBeIhRgoNZSYT3
	hn1kuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAOTXiuf
	xQvhp9s/b1mbmRmobuTJ8evRjqtndpu5Tg25fOvSTKVfMdmqgqXbn3Fdm7m7N6i9ZZeh4f9C
	jRkXq9ZrpQpJ9WcvDH5WL6n52y7kdtbivgs501cs7nj9lVdj7cRzUa6tGxZ8DOWasYjr07K0
	6Rc38N4uWahpb3lHwmPDThnbU4fmpa89UPzGtIolLXa/iUuC44/N52683c0/hftzlWlY3d2H
	hXVNd+7YPk63OR9Z3Hrh6nc3/15uacfVP7eXBc9vOyQ3+/+N20oNrdbWclOWKbsc3tX5nmdR
	1rz883mm7nMK/yzZMWdGVvP04PdZq56nXVr0dYfR/FffPidryDtfu7Z79gHedvvYXTyucUos
	xRmJhlrMRcWJAHFoiymhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7rsfDHpBld+cVq8PvyJ0WJ7wwN2
	iz17T7JYbFjZwGTx+8ccNgdWj80rtDw2repk89i8pN7j49NbLB6fN8kFsEbp2RTll5akKmTk
	F5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZbw60MdSsDawYv/mFUwN
	jNsduxg5OCQETCS+v+PqYuTiEBJYyihxqeE2cxcjJ1BcRuLktAZWCFtY4s+1LjaIoveMEtPu
	zGEDSfAK2El8PrefBcRmEVCVWH1sPhNEXFDi5MwnYHFRAXmJ+7dmsIPYwgKmEleunGQFGSQi
	0MgosWLPdLBBzAKOErfa3jNDbOhklDj5uIsRIiEucesJxFQ2AUOJrrcgZ3BwcAp4Sdx7mwBR
	YibRtRWmXF6ieets5gmMQrOQ3DELyaRZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85
	P3cTIzC6th37uXkH47xXH/UOMTJxMB5ilOBgVhLhvWEfmS7Em5JYWZValB9fVJqTWnyI0RQY
	GBOZpUST84HxnVcSb2hmYGpoYmZpYGppZqwkzut2+XyakEB6YklqdmpqQWoRTB8TB6dUA1NR
	br7m90MFt7k9s6fOP3/kZc+rt/KtmlmvChdesgrz125onrUurF3Z5ny8y+NHj1fbll/fdPnO
	W2cml898cSmlTPe+tGUGJd5/8eihXzyr1BcRzQXu/4Ur8xynOjU+VAzY+2jt8v5u6ZqbKbZS
	5xIFTaeo/q73FROYpnd66rcFUxKlr7Wm9bt/7z2aX1vJv5Kj8u9ZyQkVj2dN5ONxXX31cnL9
	yZMi0R3Pbn12bZ4zTUxdffNfwdpkfVnZGedCahnEiziYojluS7EayK1knTznnpaSZI7t0U8c
	zsIRP5YzL33UzX976eybHNMEnOtzay4eW+WyqWytsZxh4eWjkf/Ei03eTHDSaJ00/9AkDSWW
	4oxEQy3mouJEAF31U+c3AwAA
X-CMS-MailID: 20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e
References: <20241209-work-pidfs-maple_tree-v2-0-003dbf3bd96b@kernel.org>
	<20241209-work-pidfs-maple_tree-v2-2-003dbf3bd96b@kernel.org>
	<CGME20241213103551eucas1p1f97e0ca298e6a9edfc75b287b4c2079e@eucas1p1.samsung.com>

On 09.12.2024 14:46, Christian Brauner wrote:
> So far we've been using an idr to track pidfs inodes. For some time now
> each struct pid has a unique 64bit value that is used as the inode
> number on 64 bit. That unique inode couldn't be used for looking up a
> specific struct pid though.
>
> Now that we support file handles we need this ability while avoiding to
> leak actual pid identifiers into userspace which can be problematic in
> containers.
>
> So far I had used an idr-based mechanism where the idr is used to
> generate a 32 bit number and each time it wraps we increment an upper
> bit value and generate a unique 64 bit value. The lower 32 bits are used
> to lookup the pid.
>
> I've been looking at the maple tree because it now has
> mas_alloc_cyclic(). Since it uses unsigned long it would simplify the
> 64bit implementation and its dense node mode supposedly also helps to
> mitigate fragmentation.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

This patch landed in today's linux-next as commit a2c8e88a30f7 ("pidfs: 
use maple tree"). In my tests I found that it triggers the following 
lockdep warning, what probably means that something has not been 
properly initialized:

================================
WARNING: inconsistent lock state
6.13.0-rc1-00015-ga2c8e88a30f7 #15489 Not tainted
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
c25d4d10 (&sighand->siglock){?.+.}-{3:3}, at: __lock_task_sighand+0x80/0x1bc
{HARDIRQ-ON-W} state was registered at:
   lockdep_hardirqs_on_prepare+0x1a4/0x2c0
   trace_hardirqs_on+0x94/0xa0
   _raw_spin_unlock_irq+0x20/0x50
   mtree_erase+0x88/0xbc
   free_pid+0xc/0xd4
   release_task+0x630/0x7a8
   do_exit+0x6b8/0xa64
   call_usermodehelper_exec_async+0x120/0x144
   ret_from_fork+0x14/0x28
irq event stamp: 1017892
hardirqs last  enabled at (1017891): [<c0c8e510>] 
default_idle_call+0x18/0x13c
hardirqs last disabled at (1017892): [<c0100b94>] __irq_svc+0x54/0xd0
softirqs last  enabled at (1017868): [<c013b410>] 
handle_softirqs+0x328/0x520
softirqs last disabled at (1017835): [<c013b7b4>] __irq_exit_rcu+0x144/0x1f0

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&sighand->siglock);
   <Interrupt>
     lock(&sighand->siglock);

  *** DEADLOCK ***

2 locks held by swapper/0/0:
  #0: c137b4d0 (rcu_read_lock){....}-{1:3}, at: 
kill_pid_info_type+0x2c/0x168
  #1: c137b4d0 (rcu_read_lock){....}-{1:3}, at: 
__lock_task_sighand+0x0/0x1bc

stack backtrace:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 
6.13.0-rc1-00015-ga2c8e88a30f7 #15489
Hardware name: Samsung Exynos (Flattened Device Tree)
Call trace:
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from print_usage_bug.part.0+0x24c/0x270
  print_usage_bug.part.0 from mark_lock.part.0+0xc20/0x129c
  mark_lock.part.0 from __lock_acquire+0xae8/0x2a00
  __lock_acquire from lock_acquire+0x134/0x384
  lock_acquire from _raw_spin_lock_irqsave+0x4c/0x68
  _raw_spin_lock_irqsave from __lock_task_sighand+0x80/0x1bc
  __lock_task_sighand from group_send_sig_info+0x120/0x1b4
  group_send_sig_info from kill_pid_info_type+0x8c/0x168
  kill_pid_info_type from it_real_fn+0x5c/0x120
  it_real_fn from __hrtimer_run_queues+0xcc/0x538
  __hrtimer_run_queues from hrtimer_interrupt+0x128/0x2c4
  hrtimer_interrupt from exynos4_mct_tick_isr+0x44/0x7c
  exynos4_mct_tick_isr from handle_percpu_devid_irq+0x84/0x158
  handle_percpu_devid_irq from generic_handle_domain_irq+0x24/0x34
  generic_handle_domain_irq from gic_handle_irq+0x88/0xa8
  gic_handle_irq from generic_handle_arch_irq+0x34/0x44
  generic_handle_arch_irq from __irq_svc+0x8c/0xd0
Exception stack(0xc1301f20 to 0xc1301f68)
...
  __irq_svc from default_idle_call+0x1c/0x13c
  default_idle_call from do_idle+0x23c/0x2ac
  do_idle from cpu_startup_entry+0x28/0x2c
  cpu_startup_entry from kernel_init+0x0/0x12c

--->8---

> ---
>   fs/pidfs.c   | 52 +++++++++++++++++++++++++++++++---------------------
>   kernel/pid.c | 34 +++++++++++++++++-----------------
>   2 files changed, 48 insertions(+), 38 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 7a1d606b09d7b315e780c81fc7341f4ec82f2639..4a622f906fc210d5e81ba2ac856cfe0ca930f219 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -19,14 +19,15 @@
>   #include <linux/ipc_namespace.h>
>   #include <linux/time_namespace.h>
>   #include <linux/utsname.h>
> +#include <linux/maple_tree.h>
>   #include <net/net_namespace.h>
>   
>   #include "internal.h"
>   #include "mount.h"
>   
> -static DEFINE_IDR(pidfs_ino_idr);
> -
> -static u32 pidfs_ino_upper_32_bits = 0;
> +static struct maple_tree pidfs_ino_mtree = MTREE_INIT(pidfs_ino_mtree,
> +						      MT_FLAGS_ALLOC_RANGE |
> +						      MT_FLAGS_LOCK_IRQ);
>   
>   #if BITS_PER_LONG == 32
>   /*
> @@ -34,8 +35,6 @@ static u32 pidfs_ino_upper_32_bits = 0;
>    * the higher 32 bits are the generation number. The starting
>    * value for the inode number and the generation number is one.
>    */
> -static u32 pidfs_ino_lower_32_bits = 1;
> -
>   static inline unsigned long pidfs_ino(u64 ino)
>   {
>   	return lower_32_bits(ino);
> @@ -49,8 +48,6 @@ static inline u32 pidfs_gen(u64 ino)
>   
>   #else
>   
> -static u32 pidfs_ino_lower_32_bits = 0;
> -
>   /* On 64 bit simply return ino. */
>   static inline unsigned long pidfs_ino(u64 ino)
>   {
> @@ -71,30 +68,43 @@ static inline u32 pidfs_gen(u64 ino)
>    */
>   int pidfs_add_pid(struct pid *pid)
>   {
> -	u32 upper;
> -	int lower;
> +	static unsigned long lower_next = 0;
> +	static u32 pidfs_ino_upper_32_bits = 0;
> +	unsigned long lower;
> +	int ret;
> +	MA_STATE(mas, &pidfs_ino_mtree, 0, 0);
>   
>           /*
>   	 * Inode numbering for pidfs start at 2. This avoids collisions
>   	 * with the root inode which is 1 for pseudo filesystems.
>            */
> -	lower = idr_alloc_cyclic(&pidfs_ino_idr, pid, 2, 0, GFP_ATOMIC);
> -	if (lower >= 0 && lower < pidfs_ino_lower_32_bits)
> -		pidfs_ino_upper_32_bits++;
> -	upper = pidfs_ino_upper_32_bits;
> -	pidfs_ino_lower_32_bits = lower;
> -	if (lower < 0)
> -		return lower;
> -
> -	pid->ino = ((u64)upper << 32) | lower;
> +	mtree_lock(&pidfs_ino_mtree);
> +	ret = mas_alloc_cyclic(&mas, &lower, pid, 2, ULONG_MAX, &lower_next,
> +			       GFP_KERNEL);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +#if BITS_PER_LONG == 32
> +	if (ret == 1) {
> +		u32 higher;
> +
> +		if (check_add_overflow(pidfs_ino_upper_32_bits, 1, &higher))
> +			goto out_unlock;
> +		pidfs_ino_upper_32_bits = higher;
> +	}
> +#endif
> +	pid->ino = ((u64)pidfs_ino_upper_32_bits << 32) | lower;
>   	pid->stashed = NULL;
> -	return 0;
> +
> +out_unlock:
> +	mtree_unlock(&pidfs_ino_mtree);
> +	return ret;
>   }
>   
>   /* The idr number to remove is the lower 32 bits of the inode. */
>   void pidfs_remove_pid(struct pid *pid)
>   {
> -	idr_remove(&pidfs_ino_idr, lower_32_bits(pid->ino));
> +	mtree_erase(&pidfs_ino_mtree, pidfs_ino(pid->ino));
>   }
>   
>   #ifdef CONFIG_PROC_FS
> @@ -522,7 +532,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
>   
>   	guard(rcu)();
>   
> -	pid = idr_find(&pidfs_ino_idr, lower_32_bits(pid_ino));
> +	pid = mtree_load(&pidfs_ino_mtree, pid_ino);
>   	if (!pid)
>   		return NULL;
>   
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 6131543e7c090c164a2bac014f8eeee61926b13d..28100bbac4c130e192abf65d88cca9d330971c5c 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -131,6 +131,8 @@ void free_pid(struct pid *pid)
>   	int i;
>   	unsigned long flags;
>   
> +	pidfs_remove_pid(pid);
> +
>   	spin_lock_irqsave(&pidmap_lock, flags);
>   	for (i = 0; i <= pid->level; i++) {
>   		struct upid *upid = pid->numbers + i;
> @@ -152,7 +154,6 @@ void free_pid(struct pid *pid)
>   		}
>   
>   		idr_remove(&ns->idr, upid->nr);
> -		pidfs_remove_pid(pid);
>   	}
>   	spin_unlock_irqrestore(&pidmap_lock, flags);
>   
> @@ -249,16 +250,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   		tmp = tmp->parent;
>   	}
>   
> -	/*
> -	 * ENOMEM is not the most obvious choice especially for the case
> -	 * where the child subreaper has already exited and the pid
> -	 * namespace denies the creation of any new processes. But ENOMEM
> -	 * is what we have exposed to userspace for a long time and it is
> -	 * documented behavior for pid namespaces. So we can't easily
> -	 * change it even if there were an error code better suited.
> -	 */
> -	retval = -ENOMEM;
> -
>   	get_pid_ns(ns);
>   	refcount_set(&pid->count, 1);
>   	spin_lock_init(&pid->lock);
> @@ -269,12 +260,23 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   	INIT_HLIST_HEAD(&pid->inodes);
>   
>   	upid = pid->numbers + ns->level;
> -	idr_preload(GFP_KERNEL);
> -	spin_lock_irq(&pidmap_lock);
> -	if (!(ns->pid_allocated & PIDNS_ADDING))
> -		goto out_unlock;
> +
>   	retval = pidfs_add_pid(pid);
>   	if (retval)
> +		goto out_free;
> +
> +	/*
> +	 * ENOMEM is not the most obvious choice especially for the case
> +	 * where the child subreaper has already exited and the pid
> +	 * namespace denies the creation of any new processes. But ENOMEM
> +	 * is what we have exposed to userspace for a long time and it is
> +	 * documented behavior for pid namespaces. So we can't easily
> +	 * change it even if there were an error code better suited.
> +	 */
> +	retval = -ENOMEM;
> +
> +	spin_lock_irq(&pidmap_lock);
> +	if (!(ns->pid_allocated & PIDNS_ADDING))
>   		goto out_unlock;
>   	for ( ; upid >= pid->numbers; --upid) {
>   		/* Make the PID visible to find_pid_ns. */
> @@ -282,13 +284,11 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>   		upid->ns->pid_allocated++;
>   	}
>   	spin_unlock_irq(&pidmap_lock);
> -	idr_preload_end();
>   
>   	return pid;
>   
>   out_unlock:
>   	spin_unlock_irq(&pidmap_lock);
> -	idr_preload_end();
>   	put_pid_ns(ns);
>   
>   out_free:
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


