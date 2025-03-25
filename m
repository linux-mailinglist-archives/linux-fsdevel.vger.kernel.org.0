Return-Path: <linux-fsdevel+bounces-44992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C94A6FE52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA51166DE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F027E1C7;
	Tue, 25 Mar 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJ61zsFN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F72571D1;
	Tue, 25 Mar 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905480; cv=none; b=dwjwB+P9TxzatwpxIBvFq4OCDzWmebzS7P3Yj0b55SsW4aPs0agXPmmNH/G/iVTaUcdlvR+K8Myz7Kxv2sRNgOt1gQ7ypNvCcYO3xzxZO38YkFCSP1Jv2yuWonK/wtjla0K3f502sjAtB+RRGnEZmwBrvbWu8XHjfg+qghoypso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905480; c=relaxed/simple;
	bh=+rpm/N8/UHXP5n3hRK8c2vpAMzIx7Ul4qNvFlNw8mss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HagG87bgnClocGxdlKM7dnFgKl7Qpnr1tQhnoUvR3jGCvirCyt742Glw2jC04Ne8sHJr45OmGN5tjDcaYndfDcJ3cAut/RYHgM0LTG8V9DSjN93A5bbACva01tIgw1a9b6Q5bWClFcbKxIEVD71EfbT1S2LGLg+0B5fLWZ+LlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJ61zsFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D02C4CEED;
	Tue, 25 Mar 2025 12:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905479;
	bh=+rpm/N8/UHXP5n3hRK8c2vpAMzIx7Ul4qNvFlNw8mss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJ61zsFNPv0tVZchhiONptI9S+phpKdkaxrIZlJXfqP8ZFhX5npdPIZKutJs7jnqd
	 cCfXzR1Lhw26JF6STGdUIKZRIQjVQ3FNgrDHdOvq/LtsFHWE3zxFE/GTBVb31ANpi6
	 beEwlo8W1sTeTn0cFAZJSTH8Xx2n6hy1MZKcm5ZKAENN6VnIKjbEvFrXx/UwseWpbr
	 aofW9gTlCfs1lWzyuR3LRO5UKXtkNqYmP8M+/YlMc+6Le8QBFSTCqH374JFrd1SAX6
	 1sinYuNojS4RMnq31N3OYBaEEMx5tdvpoFDLmiGmnn4c78h2enMsQS6DDCJxF83lgY
	 sgAsBfhlY0xYg==
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
Subject: [RFC PATCH V3 33/43] rv64ilp32_abi: mm/auxvec: Adapt mm->saved_auxv[] to Elf64
Date: Tue, 25 Mar 2025 08:16:14 -0400
Message-Id: <20250325121624.523258-34-guoren@kernel.org>
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

Unable to handle kernel paging request at virtual address 60723de0
Oops [#1]
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.13.0-rc4-00031-g01dc3ca797b3-dirty #161
Hardware name: riscv-virtio,qemu (DT)
epc : percpu_counter_add_batch+0x38/0xc4
 ra : filemap_map_pages+0x3ec/0x54c
epc : ffffffffbc4ea02e ra : ffffffffbc1722e4 sp : ffffffffc1c4fc60
 gp : ffffffffbd6d3918 tp : ffffffffc1c50000 t0 : 0000000000000000
 t1 : 000000003fffefff t2 : 0000000000000000 s0 : ffffffffc1c4fca0
 s1 : 0000000000000022 a0 : ffffffffc25c8250 a1 : 0000000000000003
 a2 : 0000000000000020 a3 : 000000003fffefff a4 : 000000000b1c2000
 a5 : 0000000060723de0 a6 : ffffffffbffff000 a7 : 000000003fffffff
 s2 : ffffffffc25c8250 s3 : ffffffffc246e240 s4 : ffffffffc2138240
 s5 : ffffffffbd70c4d0 s6 : 0000000000000003 s7 : 0000000000000000
 s8 : ffffffff9a02d780 s9 : 0000000000000100 s10: ffffffffc1c4fda8
 s11: 0000000000000003 t3 : 0000000000000000 t4 : 00000000000004f7
 t5 : 0000000000000000 t6 : 0000000000000001
status: 0000000200000100 badaddr: 0000000060723de0 cause: 000000000000000d
[<bc4ea02e>] percpu_counter_add_batch+0x38/0xc4
[<bc1722e4>] filemap_map_pages+0x3ec/0x54c
[<bc1adc86>] handle_mm_fault+0xb6c/0xe9c
[<bc01bb3e>] handle_page_fault+0xd0/0x418
[<bca3e264>] do_page_fault+0x20/0x3a
[<bca4882c>] _new_vmalloc_restore_context_a0+0xb0/0xbc
Code: 8a93 4baa 511c 171b 0027 873b 00ea 4318 2481 9fb9 (aa03) 0007

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/mm_types.h | 4 ++++
 kernel/sys.c             | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index da3ba1a79ad5..0d436b0217fd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -962,7 +962,11 @@ struct mm_struct {
 		unsigned long start_brk, brk, start_stack;
 		unsigned long arg_start, arg_end, env_start, env_end;
 
+#ifdef CONFIG_64BIT
+		unsigned long long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
+#else
 		unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
+#endif
 
 		struct percpu_counter rss_stat[NR_MM_COUNTERS];
 
diff --git a/kernel/sys.c b/kernel/sys.c
index cb366ff8703a..81c0d94ff50d 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2008,7 +2008,11 @@ static int validate_prctl_map_addr(struct prctl_mm_map *prctl_map)
 static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
 {
 	struct prctl_mm_map prctl_map = { .exe_fd = (u32)-1, };
+#ifdef CONFIG_64BIT
+	unsigned long long user_auxv[AT_VECTOR_SIZE];
+#else
 	unsigned long user_auxv[AT_VECTOR_SIZE];
+#endif
 	struct mm_struct *mm = current->mm;
 	int error;
 
@@ -2122,7 +2126,11 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	 * up to the caller to provide sane values here, otherwise userspace
 	 * tools which use this vector might be unhappy.
 	 */
+#ifdef CONFIG_64BIT
+	unsigned long long user_auxv[AT_VECTOR_SIZE] = {};
+#else
 	unsigned long user_auxv[AT_VECTOR_SIZE] = {};
+#endif
 
 	if (len > sizeof(user_auxv))
 		return -EINVAL;
-- 
2.40.1


