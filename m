Return-Path: <linux-fsdevel+bounces-44986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74317A6FDE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D286C174314
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE6F278154;
	Tue, 25 Mar 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecDCGr6O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF825FA12;
	Tue, 25 Mar 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905408; cv=none; b=uQsMZo0Bm8ndLdF2ik0NN25hoIqPdVMrr1p9qlVt0BX0cEHeSlIJ4LDJj5tGDdoL4HyPY7gz/Ul87E8dZAgYgcQlSdnrLmNLp5GpUeB0jJEIrQWoctC31BERqXfqU+OMGlD63TmgdUs7zgl4Cqz+2e1KBgN73lmJXt0xxXbX2AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905408; c=relaxed/simple;
	bh=pIv4vnuS3dsIZ+vCl3ehqADgm2CZ2tBy3QR8swaXSZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUASAtCzVyNhBZULnImSGkXqPIxyxj1lDMAMqhhC71sKeAIxtKqgdlCAuW+J5JyhEEM1WMzQcPpFt8KZPer+UkaUp67uT+dfAhFy7fxKHS4iEDyKq4c1h7rx8qKXcmuQow4Bug8JW1HhMmy3XoepWUgIdcRoFDBsyjLpxIu3FOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecDCGr6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2976FC4CEE4;
	Tue, 25 Mar 2025 12:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905408;
	bh=pIv4vnuS3dsIZ+vCl3ehqADgm2CZ2tBy3QR8swaXSZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecDCGr6OLJrXP13nyG/CgfeqC9ouA1qT3tlj+OsrVH1NtYD+Twp5WMbEHjMMkk81f
	 stvP5ulWY1CYT8IOPOz08uY1HZBIlRPl1RvD/lfIzSGNe84mV4QvJl7p4JgmuvzAGK
	 4RQVcdL24R3V34bLEfSycUxh++RgrXULYrYbovXoNTKWlQFJodYvno3cZge1QELjR8
	 9C6TOI1VyQMTYJ6+SrsJ+n3smhuFVy+uvJ4yY+gtiJBw2C4LdtFBWY4B9hpCJDn6Wt
	 XZ5TT6fYnWqqxrxfJ2ivZTzD3naWTrT9gp922T0ATA8xVyN89LV9zmP9RucwuPViGB
	 6t4JQnchHEBxw==
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
Subject: [RFC PATCH V3 28/43] rv64ilp32_abi: iov_iter: Resize kvec to match iov_iter's size
Date: Tue, 25 Mar 2025 08:16:09 -0400
Message-Id: <20250325121624.523258-29-guoren@kernel.org>
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

As drivers/vhost/vringh.c uses BUILD_BUG_ON(sizeof(struct iovec)
!= sizeof(struct kvec)), make them the same.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/linux/uio.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 8ada84e85447..0e1ca023374c 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -17,7 +17,13 @@ typedef unsigned int __bitwise iov_iter_extraction_t;
 
 struct kvec {
 	void *iov_base; /* and that should *never* hold a userland pointer */
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+	u32  __pad1;
+#endif
 	size_t iov_len;
+#if defined(CONFIG_64BIT) && (BITS_PER_LONG == 32)
+	u32  __pad2;
+#endif
 };
 
 enum iter_type {
-- 
2.40.1


