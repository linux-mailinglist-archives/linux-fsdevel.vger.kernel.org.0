Return-Path: <linux-fsdevel+bounces-44983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63D7A6FD95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE568841895
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5D26FDA8;
	Tue, 25 Mar 2025 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2sof5de"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C141C25D8F7;
	Tue, 25 Mar 2025 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905364; cv=none; b=O5iLTxfcEvGc7WLje7XHMSkWVcQAxRDCzzO24ZIb+ZWIJ4sPo+gGiW1WS+W6G7FQE5C7ZeRJ1abLlvSXq4LMpzhjIgRRqiTWO3THaFc2365anEGogGWFVkkKUIFiF6XNSA44HO7MeZR4mdkXrLeMqZlNV3DOuLZ+8O2mcLtc1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905364; c=relaxed/simple;
	bh=pRtaUMiFeAu+95a3CJwIpLTg/ZslxDoQ016dR5ldst0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2HKm6OcOHwOglAcARoacMwd/Xp5LJfL+ZTDpOoLRCVCBxnLJj4tPqopfcRmXTFl17tSLUzkSfKEgijapwSYbVv3IiW5n4m4rMoF8kNKt6Df/5011bUNODgNmduibrKArfiQsRfUSQSV3m3lO3PwRPg+pjjTPGGmytT7vvsZ3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2sof5de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6B6C4CEE9;
	Tue, 25 Mar 2025 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905363;
	bh=pRtaUMiFeAu+95a3CJwIpLTg/ZslxDoQ016dR5ldst0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2sof5deaUnKxXsdbuejLa7cMfsQ/jfo9NR4yzxltIbGt9I7LGg3viUZpXT1k8RFw
	 9WTRwz7YQbBmvTKk30sv6fC7V/LIHte4FG9qKAIedqe9Y/ickF0YMfyR54zTwhm5BQ
	 obpUACKtQgLFBumRgfvC3WYEeXtPc/EwoiH4j3URzIqNlAo4TJWEvolJgwku1sqkJx
	 7rKaKFTW+8U8evbqHZ+v5cGHZoXKojJ2sQX8sVgxL7kldYux1laci0G+UGSLEZ94Hd
	 tb6MX1/sRkfPX52VC52FXAgkrmJ6qByYnTyzQlY4MscJzEO+hWOnTRGT/1TDXE8C38
	 5yNfgh3K5oAwg==
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
Subject: [RFC PATCH V3 25/43] rv64ilp32_abi: exec: Adapt 64lp64 env and argv
Date: Tue, 25 Mar 2025 08:16:06 -0400
Message-Id: <20250325121624.523258-26-guoren@kernel.org>
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

The rv64ilp32 abi reuses the env and argv memory layout of the
lp64 abi, so leave the space to fit the lp64 struct layout.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 fs/exec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..548d18b7ae92 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -424,6 +424,10 @@ static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
 	}
 #endif
 
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+	nr = nr * 2;
+#endif
+
 	if (get_user(native, argv.ptr.native + nr))
 		return ERR_PTR(-EFAULT);
 
-- 
2.40.1


