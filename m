Return-Path: <linux-fsdevel+bounces-52899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E5AE81DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75DA3B841F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 11:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58FE25CC49;
	Wed, 25 Jun 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WH7akxYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17717A2F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750851719; cv=none; b=O3oAIi/KsoFzXkn0K2OMbPwdu/UoTtWtdaJyI6zxKvWFGRXSM+U7paGCTBDjI2wRYiB0feG2d1wAgIGxB6lFILnlWjcUFYNrcTYbSv6N1Ty+mmzwUjiRkBd5F/2Es6X1sENn+3qjo2ubtufKQ4jb1YAy0cvCjv7g3JUAevQBWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750851719; c=relaxed/simple;
	bh=AiZ+4BJeQwwgeYzerv9oMdkL4douk5VFTfA7c2gLQc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=dLAR3LA9gc/mlnKxxhiTFq7m/PPnWIC/Mfkgl9M2ezGOgmmqxT8HiMW96hRjeVQjhabO0Pkq5Y6Arv+xuh1U08saDrFCIJ99gohbz2qXobymZS496DeHMOG3iEV40IWmdYccNB5aPQR//dJEqmykUJkWltQOpjrGf1XVo15Bcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WH7akxYQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250625114153euoutp0278ceafa971d55b88216b3d6bc10c3661~MRltSwPxv1703017030euoutp02s
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 11:41:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250625114153euoutp0278ceafa971d55b88216b3d6bc10c3661~MRltSwPxv1703017030euoutp02s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750851713;
	bh=iOWMgX0Z9ViulP6ngLZfwJEBoO6kYOpEBwMizntxyEw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=WH7akxYQZjP6zMg8ZQk02YcXdJU3b2j+0hWYDhE57FMvQ7JYK+kuWN+qpv5fCTDrE
	 szo8Q6x4MnWd14zIyr+xBjKCJlofeplBFnMHn69YmqakSezaDSbrayelbP9IwIHMD2
	 StYyAu598zM11pEhF25btt4GboLPgPlP55A89ma8=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250625114152eucas1p250b0d9a60a030e0eca6adf4d50794ebd~MRls7i1Te2073720737eucas1p2q;
	Wed, 25 Jun 2025 11:41:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250625114151eusmtip1ad5d6bda7cf749a2e77ad330f8396be4~MRlrtK14k3239232392eusmtip1C;
	Wed, 25 Jun 2025 11:41:51 +0000 (GMT)
Message-ID: <404dfe9a-1f4f-4776-863a-d8bbe08335e2@samsung.com>
Date: Wed, 25 Jun 2025 13:41:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coredump: reduce stack usage in vfs_coredump()
To: Arnd Bergmann <arnd@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, Alexander
	Mikhalitsyn <alexander@mihalicyn.com>, Jann Horn <jannh@google.com>, Luca
	Boccassi <luca.boccassi@gmail.com>, Jeff Layton <jlayton@kernel.org>, Roman
	Kisel <romank@linux.microsoft.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250620112105.3396149-1-arnd@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250625114152eucas1p250b0d9a60a030e0eca6adf4d50794ebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250625114152eucas1p250b0d9a60a030e0eca6adf4d50794ebd
X-EPHeader: CA
X-CMS-RootMailID: 20250625114152eucas1p250b0d9a60a030e0eca6adf4d50794ebd
References: <20250620112105.3396149-1-arnd@kernel.org>
	<CGME20250625114152eucas1p250b0d9a60a030e0eca6adf4d50794ebd@eucas1p2.samsung.com>

Hi,

On 20.06.2025 13:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added socket coredump code runs into some corner cases
> with KASAN that end up needing a lot of stack space:
>
> fs/coredump.c:1206:1: error: the frame size of 1680 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
>
> Mark the socket helper function as noinline_for_stack so its stack
> usage does not leak out to the other code paths. This also seems to
> help with register pressure, and the resulting combined stack usage of
> vfs_coredump() and coredump_socket() is actually lower than the inlined
> version.
>
> Moving the core_state variable into coredump_wait() helps reduce the
> stack usage further and simplifies the code, though it is not sufficient
> to avoid the warning by itself.
>
> Fixes: 6a7a50e5f1ac ("coredump: use a single helper for the socket")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This change appears in today's linux-next (next-20250625) as commit 
fb82645d3f72 ("coredump: reduce stack usage in vfs_coredump()"). In my 
tests I found that it causes a kernel oops on some of my ARM 32bit 
Exynos based boards. This is really strange, because I don't see any 
obvious problem in this patch. Reverting $subject on top of linux-next 
hides/fixes the oops. I suspect some kind of use-after-free issue, but I 
cannot point anything related. Here is the kernel log from one of the 
affected boards (I've intentionally kept the register and stack dumps):

8<--- cut here ---
Unable to handle kernel paging request at virtual address c10ba370 when 
write
[c10ba370] *pgd=4101941e(bad)
Internal error: Oops: 80d [#1] SMP ARM
Modules linked in: cmac bnep mwifiex_sdio mwifiex btmrvl_sdio btmrvl 
sha256 libsha256_generic bluetooth cfg80211 exynos_gsc v4l2_mem2mem 
s5p_mfc videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 
videobuf2_common ecdh_generic ecc videodev mc s5p_cec
CPU: 1 UID: 0 PID: 1367 Comm: cgm-release-age Not tainted 
6.16.0-rc3-next-20250625 #10627 PREEMPT
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at vfs_coredump+0x294/0x17bc
LR is at _raw_spin_unlock_irq+0x20/0x50
pc : [<c03c4534>]    lr : [<c0cf096c>]    psr: a0000013
sp : f1249dd0  ip : 00000000  fp : f1249e68
r10: c1ae41e4  r9 : 00000000  r8 : c13aaa74
r7 : 00000000  r6 : 63726f46  r5 : c2a3c000  r4 : c3852080
r3 : c10ba370  r2 : c3852080  r1 : ffffffff  r0 : 00006325
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4324c06a  DAC: 00000051
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: slab task_struct start c3852080 pointer offset 
0 size 4160
Register r3 information: non-slab/vmalloc memory
Register r4 information: slab task_struct start c3852080 pointer offset 
0 size 4160
Register r5 information: slab kmalloc-128 start c2a3c000 pointer offset 
0 size 128
Register r6 information: non-paged memory
Register r7 information: NULL pointer
Register r8 information: non-slab/vmalloc memory
Register r9 information: NULL pointer
Register r10 information: non-slab/vmalloc memory
Register r11 information: 2-page vmalloc region starting at 0xf1248000 
allocated at kernel_clone+0x58/0x3f4
Register r12 information: NULL pointer
Process cgm-release-age (pid: 1367, stack limit = 0x4909c75e)
Stack: (0xf1249dd0 to 0xf124a000)
9dc0:                                     c3852830 00000000 c3852080 
c01ae7fc
9de0: c13095a8 c45c8600 c2a3c000 00000000 00000000 c014ab28 c102c84c 
c104be90
9e00: c13095a8 c1496b58 ffffffff 00000081 00000000 6fda5e52 c127e2ec 
00000000
9e20: c2a3c280 00000004 00000080 00000000 c3852800 00000001 00000001 
00000000
9e40: c2855d90 00000000 c3852830 c0ce2874 c13133c8 c3852080 c13133e0 
c1472911
9e60: c1cc6480 ef0484e0 f1249f60 00000000 00000000 800000cd 00000001 
00000000
9e80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9ea0: 00000000 00000000 00000006 c01450a8 f1249f4c 00000001 c12849dc 
6fda5e52
9ec0: c0cf096c c3852080 00000005 00000006 400004d8 0001e000 c1309154 
c2855d80
9ee0: f1249f60 c014ab28 00000000 c02eeb48 00000000 c3852830 00000000 
ce4d1c00
9f00: f1249f4c c13095a8 c127e2ec c2855d90 00000000 6fda5e52 c12849dc 
c3852080
9f20: f1249fb0 00000000 f1249f4c 5ac3c35a b6d21668 c3852730 b6d2166c 
c011a430
9f40: 00000000 00000002 f1249f74 c0cf096c bee9b9d4 c0148328 f1249f7c 
00000000
9f60: 00000006 00000000 fffffffa 00000557 00000000 00000000 00000000 
00000000
9f80: 00000000 6fda5e52 00000000 00000000 b6f43968 bee9b9d4 000000af 
c0100290
9fa0: c3852080 000000af 00000000 c0100088 00000000 bee9b9d4 00000000 
00000008
9fc0: 00000000 b6f43968 bee9b9d4 000000af bee9bf70 b6ebdc94 00440f90 
00000000
9fe0: 00000020 bee9b9d0 ffffffff b6d2166c 00000010 00000002 00000000 
00000000
Call trace:
  vfs_coredump from get_signal+0x990/0xd9c
  get_signal from do_work_pending+0x118/0x588
  do_work_pending from slow_work_pending+0xc/0x24
Exception stack(0xf1249fb0 to 0xf1249ff8)
9fa0:                                     00000000 bee9b9d4 00000000 
00000008
9fc0: 00000000 b6f43968 bee9b9d4 000000af bee9bf70 b6ebdc94 00440f90 
00000000
9fe0: 00000020 bee9b9d0 ffffffff b6d2166c 00000010 00000002
Code: e1a03006 e5966004 e5930000 f57ff05b (e5837000)
---[ end trace 0000000000000000 ]---
note: cgm-release-age[1367] exited with irqs disabled


> ---
>   fs/coredump.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index e2611fb1f254..c46e3996ff91 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -518,27 +518,28 @@ static int zap_threads(struct task_struct *tsk,
>   	return nr;
>   }
>   
> -static int coredump_wait(int exit_code, struct core_state *core_state)
> +static int coredump_wait(int exit_code)
>   {
>   	struct task_struct *tsk = current;
> +	struct core_state core_state;
>   	int core_waiters = -EBUSY;
>   
> -	init_completion(&core_state->startup);
> -	core_state->dumper.task = tsk;
> -	core_state->dumper.next = NULL;
> +	init_completion(&core_state.startup);
> +	core_state.dumper.task = tsk;
> +	core_state.dumper.next = NULL;
>   
> -	core_waiters = zap_threads(tsk, core_state, exit_code);
> +	core_waiters = zap_threads(tsk, &core_state, exit_code);
>   	if (core_waiters > 0) {
>   		struct core_thread *ptr;
>   
> -		wait_for_completion_state(&core_state->startup,
> +		wait_for_completion_state(&core_state.startup,
>   					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
>   		/*
>   		 * Wait for all the threads to become inactive, so that
>   		 * all the thread context (extended register state, like
>   		 * fpu etc) gets copied to the memory.
>   		 */
> -		ptr = core_state->dumper.next;
> +		ptr = core_state.dumper.next;
>   		while (ptr != NULL) {
>   			wait_task_inactive(ptr->task, TASK_ANY);
>   			ptr = ptr->next;
> @@ -858,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
>   	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
>   }
>   
> -static bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
> +static noinline_for_stack bool coredump_socket(struct core_name *cn, struct coredump_params *cprm)
>   {
>   	if (!coredump_sock_connect(cn, cprm))
>   		return false;
> @@ -1095,7 +1096,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>   {
>   	struct cred *cred __free(put_cred) = NULL;
>   	size_t *argv __free(kfree) = NULL;
> -	struct core_state core_state;
>   	struct core_name cn;
>   	struct mm_struct *mm = current->mm;
>   	struct linux_binfmt *binfmt = mm->binfmt;
> @@ -1131,7 +1131,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>   	if (coredump_force_suid_safe(&cprm))
>   		cred->fsuid = GLOBAL_ROOT_UID;
>   
> -	if (coredump_wait(siginfo->si_signo, &core_state) < 0)
> +	if (coredump_wait(siginfo->si_signo) < 0)
>   		return;
>   
>   	old_cred = override_creds(cred);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


