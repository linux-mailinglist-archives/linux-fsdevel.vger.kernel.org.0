Return-Path: <linux-fsdevel+bounces-44991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A444A6FE54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7653BDAA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4627CCD4;
	Tue, 25 Mar 2025 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEoFxhRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A02571D1;
	Tue, 25 Mar 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905465; cv=none; b=EF2psVj5s1HE6A8O5B5llUA8J9wuInuPVV4IvT+m0eAaST/Oa2T+0RGYXkk1mn+fqx72nudVCLOB1Yw1itkJrLROyFSOzKuzeyGnXp29D1bfIoTarNkb6gin0udSgpuUbzBr/4rEq5bpBgnWIAkNcKZdXlrxBtfcAfpFdadjaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905465; c=relaxed/simple;
	bh=JPoN7MLEf8eR2nMyp8/thu8bst5//5Hk8VxE062lQ9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CTD6yvbjNSiCvzv6UfFE01CEwtWH/M7HVDPOsH1JzqIpOlK55CcfztyIIITrex76uLXc0etOlWV1TgONRizg1/npWI3flMTZsNtRXNEKOauBYK2fsJKxXVLCBrAl60mTLUOcFVtxakndcnjsEozohUJRc7isa2qzyQkuX7Hovco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dEoFxhRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04FAC4CEE4;
	Tue, 25 Mar 2025 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905464;
	bh=JPoN7MLEf8eR2nMyp8/thu8bst5//5Hk8VxE062lQ9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dEoFxhRXAgIXTk+izxMj8NAc58Z150abzTA52wVaUo6oYVdkPjOE5SSRWPRWeVTRZ
	 U1/G1qYs1uREuzAoBzG0S14o2UVbqgxlA890HlC1yYQsuSNAzyB+Rmkj4zJV2ekZPy
	 fzIcdDjyk24aWTyz20XnUJhgLKC2ybNiG3fcpWxbHC+p5onyj0QMYQr8LexFkeoHXi
	 ika5eYC4afRp1Kftijmmo0sAT2pI8cXHBmJitbAMMAFNHKZ8/nrfoTyLZqlkraub3q
	 7VNeoISO8HTPBn0sSZs3s+QMMmmB4sh2Efhd9ZKgZQ2gPqONiWgdp4ZF195RgbZqwa
	 EQz1rLnxWUczg==
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
Subject: [RFC PATCH V3 32/43] rv64ilp32_abi: mm: Remove _folio_nr_pages
Date: Tue, 25 Mar 2025 08:16:13 -0400
Message-Id: <20250325121624.523258-33-guoren@kernel.org>
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

BITS_PER_LONG defines the layout of the struct page, and
_folio_nr_pages would conflict with page->_mapcount for RV64ILP32
ABI. Here is problem:

BUG: Bad page state in process kworker/u4:0  pfn:61eed
page: refcount:0 mapcount:5 mapping:00000000 index:0x0 pfn:0x61eed
flags: 0x0(zone=0)
raw: 00000000 00000000 ffffffff 00000000 00000000 00000000 00000004 00000000
raw: 00000000 00000000
page dumped because: nonzero mapcount
Modules linked in:
CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.13.0-rc4
Hardware name: riscv-virtio,qemu (DT)
Workqueue: async async_run_entry_fn
Call Trace:
[<bc015096>] dump_backtrace+0x1e/0x26
[<bc002330>] show_stack+0x2a/0x38
[<bc00f38c>] dump_stack_lvl+0x4a/0x68
[<bc00f3c0>] dump_stack+0x16/0x1e
[<bc1cadd8>] bad_page+0x120/0x142
[<bc1cf2c2>] free_unref_page+0x510/0x5f8
[<bc17fb16>] __folio_put+0x6a/0xbc
[<bc1d6090>] free_large_kmalloc+0x6a/0xb8
[<bc1d9144>] kfree+0x23c/0x300
[<bcc02834>] unpack_to_rootfs+0x27c/0x2c0
[<bcc02e96>] do_populate_rootfs+0x24/0x12e
[<bc04c80c>] async_run_entry_fn+0x26/0xcc
[<bc03e116>] process_one_work+0x136/0x224
[<bc03e9e4>] worker_thread+0x234/0x30a
[<bc046334>] kthread+0xca/0xe6
[<bca47bea>] ret_from_fork+0xe/0x18
Disabling lock debugging due to kernel taint

So, remove _folio_nr_pages just like CONFIG_32BIT and use
"_flags_1 & 0xff" instead.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/mm.h       | 4 ++--
 include/linux/mm_types.h | 2 +-
 mm/internal.h            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..454fb8ca724c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2058,7 +2058,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 1;
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	return folio->_folio_nr_pages;
 #else
 	return 1L << (folio->_flags_1 & 0xff);
@@ -2083,7 +2083,7 @@ static inline unsigned long compound_nr(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 1;
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	return folio->_folio_nr_pages;
 #else
 	return 1L << (folio->_flags_1 & 0xff);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b27db7f9496..da3ba1a79ad5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -370,7 +370,7 @@ struct folio {
 			atomic_t _entire_mapcount;
 			atomic_t _nr_pages_mapped;
 			atomic_t _pincount;
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 			unsigned int _folio_nr_pages;
 #endif
 	/* private: the union with struct page is transitional */
diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..c9372a8552ba 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -682,7 +682,7 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 		return;
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	folio->_folio_nr_pages = 1U << order;
 #endif
 }
-- 
2.40.1


