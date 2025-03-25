Return-Path: <linux-fsdevel+bounces-44980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249BA6FD6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10BF175F05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9289026B2D6;
	Tue, 25 Mar 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiNwDozb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F625BADE;
	Tue, 25 Mar 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905322; cv=none; b=lh329s+fIten52W4NJN9PJNYL/Wf6h3RXkzpB6ty/3E19uMF585Lv4fU0hAPTbMSDskbPQG2FP9ndlS1G3hp/gved6Cqg5KasL8KaUB5lOpC/5RPk9LsfU1bYTdzgFkbEwqSmzXa9pedXHsD6TyZ0Voa2Fxss7KFcNJYLLfs5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905322; c=relaxed/simple;
	bh=EOiooLZvwzRM6FHGKB7Ghuvoq/JlTjUJTDs6W9lVozk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQbTfQfFeVMK/HJW1P4xKe4Py6pWFYw4Pd2RXyIZOS0NRJVgDprQKKPux2BJ6xxHOBOoQ1V17helpws+A27p2xJYGW8aH+8P8sLZeuKNhpe0zTY/B+zd4+loveTNijPg9gxNzjYaqA2wGPZmyPyXPZZAGv2fsGq2GjbjxaY0Z9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiNwDozb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED79C4CEE9;
	Tue, 25 Mar 2025 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905322;
	bh=EOiooLZvwzRM6FHGKB7Ghuvoq/JlTjUJTDs6W9lVozk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiNwDozbmDOug84APDztOZ2kil/O/36KZmxFYgseIvSYpf80jP5BkPovMatjpEwF7
	 9Mq3kmZ4ePc7RYLpMw9NEaSm0LGSMxns79AzH45x1KmUkZqWo4Skq6zfdG3Tlcxage
	 +k81YCl4yto0KufO7fU24VbbmT5HpsiwnQ/LJNEbWscleUqJq17+j1b39fWz8LWMSg
	 Uuit3b1JS+cJhBplzgf1jYyOjOrjET/O1rJQILxC4gg7nPXrpSCtouxe46dwFeFif2
	 9u1eZQAL0xJs37uoPehOJHR0ac4C+89etNoi3+6KrTYRMMOEqLazYSIyboQBbBmP0S
	 sxGJTKjz/HGow==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 22/43] rv64ilp32_abi: bpf: Change KERN_ARENA_SZ to 256MiB
Date: Tue, 25 Mar 2025 08:16:03 -0400
Message-Id: <20250325121624.523258-23-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

The RV64ILP32 ABI limits the vmalloc range to 512MB, hence the
arena kernel range is set to 256MiB instead of 4GiB.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 kernel/bpf/arena.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 870aeb51d70a..4eb99f83d4a1 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -40,7 +40,14 @@
 
 /* number of bytes addressable by LDX/STX insn with 16-bit 'off' field */
 #define GUARD_SZ (1ull << sizeof_field(struct bpf_insn, off) * 8)
-#define KERN_VM_SZ (SZ_4G + GUARD_SZ)
+
+#if BITS_PER_LONG == 64
+#define KERN_ARENA_SZ SZ_4G
+#else
+#define KERN_ARENA_SZ SZ_256M
+#endif
+
+#define KERN_VM_SZ (KERN_ARENA_SZ + GUARD_SZ)
 
 struct bpf_arena {
 	struct bpf_map map;
@@ -115,7 +122,7 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
 		return ERR_PTR(-EINVAL);
 
 	vm_range = (u64)attr->max_entries * PAGE_SIZE;
-	if (vm_range > SZ_4G)
+	if (vm_range > KERN_ARENA_SZ)
 		return ERR_PTR(-E2BIG);
 
 	if ((attr->map_extra >> 32) != ((attr->map_extra + vm_range - 1) >> 32))
@@ -321,7 +328,7 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 
 	if (pgoff)
 		return -EINVAL;
-	if (len > SZ_4G)
+	if (len > KERN_ARENA_SZ)
 		return -E2BIG;
 
 	/* if user_vm_start was specified at arena creation time */
@@ -337,12 +344,14 @@ static unsigned long arena_get_unmapped_area(struct file *filp, unsigned long ad
 	ret = mm_get_unmapped_area(current->mm, filp, addr, len * 2, 0, flags);
 	if (IS_ERR_VALUE(ret))
 		return ret;
+#if BITS_PER_LONG == 64
 	if ((ret >> 32) == ((ret + len - 1) >> 32))
 		return ret;
+#endif
 	if (WARN_ON_ONCE(arena->user_vm_start))
 		/* checks at map creation time should prevent this */
 		return -EFAULT;
-	return round_up(ret, SZ_4G);
+	return round_up(ret, KERN_ARENA_SZ);
 }
 
 static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
@@ -366,7 +375,7 @@ static int arena_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
 		return -EBUSY;
 
 	/* Earlier checks should prevent this */
-	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > SZ_4G || vma->vm_pgoff))
+	if (WARN_ON_ONCE(vma->vm_end - vma->vm_start > KERN_ARENA_SZ || vma->vm_pgoff))
 		return -EFAULT;
 
 	if (remember_vma(arena, vma))
-- 
2.40.1


