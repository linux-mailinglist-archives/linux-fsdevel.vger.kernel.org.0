Return-Path: <linux-fsdevel+bounces-44982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF984A6FD84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB9188AA52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA426FA44;
	Tue, 25 Mar 2025 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qevNB9uN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392A25D8F7;
	Tue, 25 Mar 2025 12:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905350; cv=none; b=h5l9MacviEInDUl1jU2UjQuuVtE24qbsUvtou0aDFz+AW/dqVqxX033q1xN8DgtqkIS45Cb4xnTk9hPgJlvPspMRSAzoVT32U/qBBW4IAUHO6jWYsCJsb/5jVo+jPlRJViS6CJ9n7wg+vmy88q3mAzefaazsichjUylOcsb6ItI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905350; c=relaxed/simple;
	bh=eZJhhLnjsJ5KjWkXGFxCn3MEvfIMBL+8sG27XCid5KE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dmkUsoEpCb1W9mjVlHaQjBy44RZBnNG6CKWsghVSqNsz4VKZYIiKJnNNQmMbq/qL/6voBLX7vsWJa5wKy0eAES7YBAPMuUxOXqhJ4BDmRmaaq7i8K3UrMIx2QzKl+HwuosK62n3jklM/1sHrzzj2jtFNALAGi2TZDOMm/nnzEd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qevNB9uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F4EC4CEE4;
	Tue, 25 Mar 2025 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905349;
	bh=eZJhhLnjsJ5KjWkXGFxCn3MEvfIMBL+8sG27XCid5KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qevNB9uNRXUhGTfVJr+DKl6lS8FQeFJOY4f7ttg3jO2P7YXXcyp32FuamCgRbpfp6
	 Tj8ZRiyJrxpkmlppbuR0aTZlagq4HpBxvwcxFyDkvXMwezEgXXrlUpqBLGrm+vhQVE
	 9kwRr/BG5obSIi/E5vhu4AY8QmWoUzLcx2UvdyDSQLaiwaxvQJ5CeLSKOf3FwJJ5E/
	 hXAzq1VCYp+EoL2e1cTTQa5pm9NoxQr4RcYtb1wSopiaMM/m+ZruEqXbAWZjV+7luh
	 k16fsX64eUOJWO5eXZk1Sat/sU8lm9uDUQzukBAAtX2breq8iLsn6lrcBr2XGHy3Dn
	 z3KzNteqnEguQ==
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
Subject: [RFC PATCH V3 24/43] rv64ilp32_abi: compiler_types: Add "long long" into __native_word()
Date: Tue, 25 Mar 2025 08:16:05 -0400
Message-Id: <20250325121624.523258-25-guoren@kernel.org>
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

The rv64ilp32 abi supports native atomic64 operations. The
atomic64_t is defined by "long long," so add "long long" into
__native_word().

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/compiler_types.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..6cf36a8e9570 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -505,9 +505,16 @@ struct ftrace_likely_data {
 			 default: (x)))
 
 /* Is this type a native word size -- useful for atomic operations */
+#ifdef CONFIG_64BIT
+#define __native_word(t) \
+	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
+	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long) || \
+	 sizeof(t) == sizeof(long long))
+#else
 #define __native_word(t) \
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+#endif
 
 #ifdef __OPTIMIZE__
 # define __compiletime_assert(condition, msg, prefix, suffix)		\
-- 
2.40.1


