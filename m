Return-Path: <linux-fsdevel+bounces-44984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E8A6FDF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A577AAA42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1444270EDC;
	Tue, 25 Mar 2025 12:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntclLWyc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015DB258CD6;
	Tue, 25 Mar 2025 12:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905381; cv=none; b=fxvwXUA8D1jD3DFNE+iQK6Z/q0Wn9A/RE3IgEItHM3UU+AhxJacV3gFfbZTu8I13c5AzdwezHrdTonWpFr3XQLRZ7R3cj+X68qIfmFtWPNFnPHpyo9B7s+y6VY9N/wJQdNiiAoVJMmUQ/pRjki/iz71FYZrMgBzSxmMKTvOMGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905381; c=relaxed/simple;
	bh=kGPsHFFMg2CAbXtRnGFCoMZoeXyVXOmvw2ykjsD95WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vd7wR9xRSzglgqhy+urllQIHZyvC20E4PjPJlpqV+Dz8lCr7MXvAPpgJJG5wO7l+EA1h66acIQWpgmSIUIQVRFm+G50zGHnBQ3kDnt3ZVbvD504BHp0SbRx960Wo0wq6rJLpjIPlbjzuy8QZvcKGL2joHYBthnkosd5wxSbz47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntclLWyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4CEC4CEE4;
	Tue, 25 Mar 2025 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905380;
	bh=kGPsHFFMg2CAbXtRnGFCoMZoeXyVXOmvw2ykjsD95WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntclLWycxIrsN91q9/Iq7DZLV3nwTWOf4Qo5f6R8yJlXo1s0ypvyO9gc8nw1n9iJa
	 FXE4HvXg9jbtr74bzaGhsm46h50G8b9MlQPjOkwWiuLMEejz6lYx8r2CpJVGHd+i84
	 Y9n4c1aA4xtTudNn6+y4oe79jba9Mxkk0kZFXd/7xCyMom+qmIyy4T/0ysXPzI7bay
	 5sdbYuoQbrTw4El0JuMiLQwd1ke34f9kjkg3HXYA3l/Iwam2xe4E80RyKMurhKZ1jo
	 s5Lzild3//u1NkkMe5ZEFU8hjrRZDyJHVc5UpBWJ9x1eZ2XWDKu2b3FH9QfncuRVF3
	 1ztYGTU3Jqe1Q==
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
Subject: [RFC PATCH V3 26/43] rv64ilp32_abi: file_ref: Use 32-bit width for refcnt
Date: Tue, 25 Mar 2025 08:16:07 -0400
Message-Id: <20250325121624.523258-27-guoren@kernel.org>
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

The sizeof(atomic_t) is 4 in rv64ilp32 abi linux kernel, which
could provide a higher density of cache and a smaller memory
footprint.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/file_ref.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 9b3a8d9b17ab..ce9b47359e14 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -27,7 +27,7 @@
  * 0xFFFFFFFFFFFFFFFFUL
  */
 
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define FILE_REF_ONEREF		0x0000000000000000UL
 #define FILE_REF_MAXREF		0x7FFFFFFFFFFFFFFFUL
 #define FILE_REF_SATURATED	0xA000000000000000UL
@@ -44,7 +44,7 @@
 #endif
 
 typedef struct {
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	atomic64_t refcnt;
 #else
 	atomic_t refcnt;
-- 
2.40.1


