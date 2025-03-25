Return-Path: <linux-fsdevel+bounces-44990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113AEA6FE3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50982188F8C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF927CB05;
	Tue, 25 Mar 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWpvaUIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860325DD1A;
	Tue, 25 Mar 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905450; cv=none; b=e2FVTDJJLdbcPhTPz6p3fz8q+Moqbv2pAC5chieJSExnXqShApflZyYuKShUMjYZvb5piqrJbp2Wf1nUCOEZzjYMTTNurbOvjnwyZKmoGMD2/kQCtX34MdY8tx3X7RwixRhkWc0AkT53/JfVEXbKESAIIzlLmyO/vugbzld5JYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905450; c=relaxed/simple;
	bh=YlFb6KkzVSGSuegSI2MJMuDKnOb+jmQgRm/aIyv4ASM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o6cvTxyHqJDtHSpgpjFNjfiIFW/AmxaRmlS82d96BDgutnbUiINb+8zlBCMGdtqT1wqrfN/fRURAgkZ6tyFIu/AjEJzrQXZsSGWPyVfLN4WfMq9aImmi6AppSmhvqkOHSfGP9Fj2hQKugHK9CCy7OM8+oaMb8FPXgx6nMqIjD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWpvaUIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EE3C4CEE9;
	Tue, 25 Mar 2025 12:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905449;
	bh=YlFb6KkzVSGSuegSI2MJMuDKnOb+jmQgRm/aIyv4ASM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWpvaUIxJ2xmK0FQF0ljHhlr/YashdPyYsTn7al4PxnIvUdy5/V+e9JCSqYjPiQ5E
	 qVMLggXWg+4qFNOeniAE53fLZ1Prkl0/M6GeEuOJ+uT+3t3q7fV6UUS2UIgffUSeso
	 wRSxhB5nlUaDz5ji9smEUpkoHf9ykZfP/NySchrJUTDEg5MhkdVVvAnNX4EACaRX4T
	 pdKSFNThVJ1sR53X8HbMYhyVDRiX7Q6sFsJkcrdiRsi7pFRqIxw20GaRxB8ae45rL7
	 7llPuKtxuxdA0NoRclxRUGq3TI+0zr3JNpZA7Af2b2pgVGyaoWF87wcU8ebw0LTt3d
	 JLIfeJGTL7Z9g==
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
Subject: [RFC PATCH V3 31/43] rv64ilp32_abi: maple_tree: Use BITS_PER_LONG instead of CONFIG_64BIT
Date: Tue, 25 Mar 2025 08:16:12 -0400
Message-Id: <20250325121624.523258-32-guoren@kernel.org>
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

The Maple tree algorithm uses ulong type for each element. The
number of slots is based on BITS_PER_LONG for RV64ILP32 ABI, so
use BITS_PER_LONG instead of CONFIG_64BIT.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/maple_tree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index cbbcd18d4186..ff6265b6468b 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -24,7 +24,7 @@
  *
  * Nodes in the tree point to their parent unless bit 0 is set.
  */
-#if defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
+#if (BITS_PER_LONG == 64) || defined(BUILD_VDSO32_64)
 /* 64bit sizes */
 #define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
 #define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
-- 
2.40.1


