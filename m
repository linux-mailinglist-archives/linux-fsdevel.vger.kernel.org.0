Return-Path: <linux-fsdevel+bounces-45000-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBBDA6FF31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 14:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A03C175811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E5C290BAA;
	Tue, 25 Mar 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihVlwKbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617525745C;
	Tue, 25 Mar 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905603; cv=none; b=i6TphsgKWTOCs4hkVTuMbuDuScl7kHolxQtdVmIdmrBzZWwvZJLabWc6xFYf73EtTXz2wBi2Opr1FtwfkKNuZfyyHRRfODRBjSnL7djM0XsWaSJ6Is4lkQEZs3b7B+dkBLfaz3rsKcRs63C0t8VY2veobCcQ8uRaDutcNL//4fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905603; c=relaxed/simple;
	bh=gGEDexkonBv9xkqlklXH6H0siev5It/WclAJgWuLAaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJz+SqQonA4Emf+lRFy347EqEP/b9jer/HUpWI1fKDSN0pLBOq8MqIQb5VfDcZvsQu+jDyqTzlbhwqs6VdZv08yt984u0y0qRM/aucA4w/ov+1St/a8jG5T2xjdmBg4etTkZTKpIDd86t8mh8SVQuwhq71WiwYDDoVND31FAB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihVlwKbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58230C4CEE4;
	Tue, 25 Mar 2025 12:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905600;
	bh=gGEDexkonBv9xkqlklXH6H0siev5It/WclAJgWuLAaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihVlwKblKsuWFNcMtDJ1k3ctKSbBwY49h9IjoH9KGH6RI/zq8BylDBqvJ9wyno/qp
	 IUv3RwZeYhK0sWieeIu1X7UarNylQxXDlKivCnDKhn4bx62KBOApARfUIXTkLXXsFn
	 3rI4E6bpvA/elj8kLNZnsdeON0EYb/TTcZHXFJrgLVFjWNZTsDHQaIIhPnPY6YDHgo
	 7rJORY6u+zOpHejnqnKv38Ge2nOcCABkagysYa3pxGYsHk/Lvc8HyUvKwE4GThzBZl
	 GffrGstDg5zLMeOPdXBQ0RXicXDZjiJ6nMyN1iFUR0hjCFd9gaaZECI2ylLLzOHNni
	 HKltn+V1I4Cmg==
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
Subject: [RFC PATCH V3 41/43] rv64ilp32_abi: tty: Adapt ptr_to_compat
Date: Tue, 25 Mar 2025 08:16:22 -0400
Message-Id: <20250325121624.523258-42-guoren@kernel.org>
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

The RV64ILP32 ABI is based on 64-bit ISA, but BITS_PER_LONG is 32.
So, the size of unsigned long is the same as compat_ulong_t and
no need "(unsigned long)v.iomem_base >> 32 ? 0xfffffff : ..."
detection.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 449dbd216460..75e256e879d0 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2873,8 +2873,12 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 	err = tty->ops->get_serial(tty, &v);
 	if (!err) {
 		memcpy(&v32, &v, offsetof(struct serial_struct32, iomem_base));
+#if BITS_PER_LONG == 64
 		v32.iomem_base = (unsigned long)v.iomem_base >> 32 ?
 			0xfffffff : ptr_to_compat(v.iomem_base);
+#else
+		v32.iomem_base = ptr_to_compat(v.iomem_base);
+#endif
 		v32.iomem_reg_shift = v.iomem_reg_shift;
 		v32.port_high = v.port_high;
 		if (copy_to_user(ss, &v32, sizeof(v32)))
-- 
2.40.1


