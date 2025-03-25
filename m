Return-Path: <linux-fsdevel+bounces-45002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E2A6FF64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C9E173FBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F952980A4;
	Tue, 25 Mar 2025 12:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSXvc+q0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC425A2C0;
	Tue, 25 Mar 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905616; cv=none; b=KWRmue95ZmwWF08cLkg27KpsG31njfBe+yci+lYzec7Qonx2HOsDt53Ga72Sz13dzG/TcvygT/QcFAmDa3VNELYUdp2scy+AcMXO8+c6kI2ruszhSK4pjQP9IYBvtjFi926PBLnNMVeV7IUhLPLeDdsPNxP6ZMM1JI9OUyB+AGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905616; c=relaxed/simple;
	bh=9rClAibepR5410hMymY5QyjFNfu9myyrJTkBJ7yJs84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxBua4H0dWDogKpleXnKcVygmGTcbymhQrq32sqktiQaQklcHQ61TGtpRLtm26A721MIhwGdqvKi1WxgLZRdn7RoOBntTlpxkVj2WlF4S22cXDXextvAvTGzsoMwaZwd+Tp/VVulQxzhYQOO45puQ/sH6Xkv4jfObA3/oIP9GkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSXvc+q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD52C4CEED;
	Tue, 25 Mar 2025 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905616;
	bh=9rClAibepR5410hMymY5QyjFNfu9myyrJTkBJ7yJs84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSXvc+q07mYxURgabvhC0EDZ07GzmsdGsbFL99gOWwWn2P5z8FZ/BlJ02MvKw0oi0
	 DebZmNXKJ2CXOdMnsWEWR3OoVOJMtpx5upcoqoGzimuBC7isnkYS1TqP5L1E6cxZU6
	 4XrYv8tJiQ/yVO+KpHHDW9WJtvg1IAC6n5lPmXBEkrmtDpQIZKAsCw9ZnEWbQ7Gm8D
	 EFr+OQdexB1ClgCWhZJhpf6cX91lUXmdACsoE7/AQufDa2ng7DPJR1k3C71ynpd+D/
	 KrFEXsFArC7JDeWksZBrKc+/l/OmyTWBnHSzZmaXAgyqRcEOww2gygQgud3qZdqgXr
	 KuA9Abd2ez09A==
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
Subject: [RFC PATCH V3 42/43] rv64ilp32_abi: memfd: Use vm_flag_t
Date: Tue, 25 Mar 2025 08:16:23 -0400
Message-Id: <20250325121624.523258-43-guoren@kernel.org>
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

RV64ILP32 ABI linux kernel is based on CONFIG_64BIT, and uses
unsigned long long as vm_flags_t. Using unsigned long would
break rv64ilp32 abi.

The definition of vm_flag_t exists, hence its usage is
preferred even if it's not essential.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/memfd.h | 4 ++--
 mm/memfd.c            | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index 246daadbfde8..6f606d9573c3 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -14,7 +14,7 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
  * We also update VMA flags if appropriate by manipulating the VMA flags pointed
  * to by vm_flags_ptr.
  */
-int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr);
+int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
@@ -25,7 +25,7 @@ static inline struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 	return ERR_PTR(-EINVAL);
 }
 static inline int memfd_check_seals_mmap(struct file *file,
-					 unsigned long *vm_flags_ptr)
+					 vm_flags_t *vm_flags_ptr)
 {
 	return 0;
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index 37f7be57c2f5..50dad90ffedc 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -332,10 +332,10 @@ static inline bool is_write_sealed(unsigned int seals)
 	return seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE);
 }
 
-static int check_write_seal(unsigned long *vm_flags_ptr)
+static int check_write_seal(vm_flags_t *vm_flags_ptr)
 {
-	unsigned long vm_flags = *vm_flags_ptr;
-	unsigned long mask = vm_flags & (VM_SHARED | VM_WRITE);
+	vm_flags_t vm_flags = *vm_flags_ptr;
+	vm_flags_t mask = vm_flags & (VM_SHARED | VM_WRITE);
 
 	/* If a private matting then writability is irrelevant. */
 	if (!(mask & VM_SHARED))
@@ -357,7 +357,7 @@ static int check_write_seal(unsigned long *vm_flags_ptr)
 	return 0;
 }
 
-int memfd_check_seals_mmap(struct file *file, unsigned long *vm_flags_ptr)
+int memfd_check_seals_mmap(struct file *file, vm_flags_t *vm_flags_ptr)
 {
 	int err = 0;
 	unsigned int *seals_ptr = memfd_file_seals_ptr(file);
-- 
2.40.1


