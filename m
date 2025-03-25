Return-Path: <linux-fsdevel+bounces-44985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FAA6FDCB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F87D18877B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A6277010;
	Tue, 25 Mar 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0wh/8Tx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94725E835;
	Tue, 25 Mar 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905395; cv=none; b=uHsa8SXbLiSJaYASZqj+on3/tMeNZs7DV04sZTJSiZDpQWvMlz+U8duXa25d3e8YNY9pdIxroBATlbravz/+0171yhoDYSwq54EvO07u5zYev5bc7q/2py1fQqThbgNvr/VcO/eAgypVb6OGE6leErYlgiNIlQuEuiQyyrx7jjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905395; c=relaxed/simple;
	bh=ZdAkreXNjU924DvNhCbpfQtujvhWVn4yr+yoUPb7XPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnjyBy2nhX9ByN5KAlQ0D3xvV0kCIQ3eu0eQExDwsUCK4Uve7OYEWov6sXj2Til+YLvgoI4xAFJ6VDIoha9TruWSx+fxyIFx6ert7ffcQ7U9TYogKe92hq1c1FaeMT4djWJMuKWnN+vF9KkOu2MutCAwso3HKRezuOW3c8o9BtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0wh/8Tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADAAC4CEED;
	Tue, 25 Mar 2025 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905394;
	bh=ZdAkreXNjU924DvNhCbpfQtujvhWVn4yr+yoUPb7XPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0wh/8TxUniEX/ZB9PGz8ZaGiNSQaTZGsJyssDgFsfp+2sbfBlRKcQH+lkBCu3zaB
	 +q5JKkf/6/6G9uTXxsQGTjo+cVtnmWczJLZwsleSvMn8bvWHhxQEszuBw4x52yi9Bk
	 RNfQry6flnLoDYkb77T9WYq6b9r6RmFWBsHS2ig0gx5/AlMuJzcHEncwWe7YEL1iNP
	 87fpjQaGqgvuIa+FZFiDtwpz20AgIa6I0L4yQIwx2Bw4QTCN9Co6vjT0+kAHFSHwyB
	 wE+o43JlKf9U+bBptVGvCfBIgJ0CtZ70Z/obq8KrvHdjwDYUww471PY6i6UOaWxc62
	 UYzxYGeDDf+ug==
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
Subject: [RFC PATCH V3 27/43] rv64ilp32_abi: input: Adapt BITS_PER_LONG to dword
Date: Tue, 25 Mar 2025 08:16:08 -0400
Message-Id: <20250325121624.523258-28-guoren@kernel.org>
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

The RV64ILP32 ABI linux kernel is based on CONFIG_64BIT, but
BITS_PER_LONG is 32. So, adapt bits to dword with BITS_PER_LONG.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/input/input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c9e3ac64bcd0..7af5e8c66f25 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1006,7 +1006,11 @@ static int input_bits_to_string(char *buf, int buf_size,
 	int len = 0;
 
 	if (in_compat_syscall()) {
+#if BITS_PER_LONG == 64
 		u32 dword = bits >> 32;
+#else
+		u32 dword = bits;
+#endif
 		if (dword || !skip_empty)
 			len += snprintf(buf, buf_size, "%x ", dword);
 
-- 
2.40.1


