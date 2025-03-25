Return-Path: <linux-fsdevel+bounces-44994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D098A6FEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C14119A018D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692A5280CD0;
	Tue, 25 Mar 2025 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbm8Xu/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831A262811;
	Tue, 25 Mar 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905510; cv=none; b=MiChJk0XGEOXbNyHKx6HnnRsIiSg0ltdTVAi0vWwxIvSu/4YrpWJOLDGd6P1OKrwdr4khTZRlvhhf5Td0P2+D+otTQrfzZK9NeGTvysZ20oTOrMJK2Ql6JEvgKW1/4ldouW2YrGzwu65eXFQU5Ptc/cwCEuXFZPXCuYlInBOJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905510; c=relaxed/simple;
	bh=uqoJTO8TQ6On8+9R1MYgJxGk7xYpfwdXChiuqug5XKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/CdgXTGN/LQteLk88R6CO/9NNzr4GFN2m571anakaMHYn0zJPudLTOhrluGCAHlWivgPDKXK5Rb+hs4CIE1tUHNnanKV+GK3lFXl84Thi7oX+YbsIkHx5BweXZkNGZldZ5uvtZu89q+tWT41/HW53byTfRAt56NoTIZDbtxgGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbm8Xu/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981CC4CEE4;
	Tue, 25 Mar 2025 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905510;
	bh=uqoJTO8TQ6On8+9R1MYgJxGk7xYpfwdXChiuqug5XKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tbm8Xu/xL9LwAkup8nr/CZGwgZ/HtBocjjMNivSDeL5hMNIibkzNWBIjcdug8EvfD
	 QidFgTYi+HMsMkeR8+VRTweKTrWgmou5CzsndMXzlO4oZEivwlhPhDjj4fjOc56Qc9
	 LEKFd8XS0hLN2de0NvYOj9MFS3ZC1n3uwR87P/ChdO+Qxq566Apd5rBSyR6mxaQqhR
	 uYwPY7KfQYrAJZbgGx2D1hYimJ9ECj2lRGYUD9xqOKdph3HacGa/jE9YJiGcpZdWWY
	 sfTkSdpa1Iac6eeiW6fFY3790kvmIaOHme0uYaLwkVlbwify8gYY2fjL3qNT/qkevh
	 HrFm01xwFxqLQ==
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
Subject: [RFC PATCH V3 35/43] rv64ilp32_abi: net: Use BITS_PER_LONG in struct dst_entry
Date: Tue, 25 Mar 2025 08:16:16 -0400
Message-Id: <20250325121624.523258-36-guoren@kernel.org>
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

The rv64ilp32 ABI depends on CONFIG_64BIT for its ILP32 data type,
which is smaller. To align with ILP32 requirements, CONFIG_64BIT
was changed to BITS_PER_LONG in struct dts_entry.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/net/dst.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 78c78cdce0e9..af1c74c4836e 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -65,7 +65,7 @@ struct dst_entry {
 	 * __rcuref wants to be on a different cache line from
 	 * input/output/ops or performance tanks badly
 	 */
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	rcuref_t		__rcuref;	/* 64-bit offset 64 */
 #endif
 	int			__use;
@@ -74,7 +74,7 @@ struct dst_entry {
 	short			error;
 	short			__pad;
 	__u32			tclassid;
-#ifndef CONFIG_64BIT
+#if BITS_PER_LONG == 32
 	struct lwtunnel_state   *lwtstate;
 	rcuref_t		__rcuref;	/* 32-bit offset 64 */
 #endif
@@ -89,7 +89,7 @@ struct dst_entry {
 	 */
 	struct list_head	rt_uncached;
 	struct uncached_list	*rt_uncached_list;
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 	struct lwtunnel_state   *lwtstate;
 #endif
 };
-- 
2.40.1


