Return-Path: <linux-fsdevel+bounces-44981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB5A6FDB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC357A57AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644926E152;
	Tue, 25 Mar 2025 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKbe7u9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76B257AC7;
	Tue, 25 Mar 2025 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905339; cv=none; b=tYhfYU0SXsT4a/io4e7LbhrdrYW4pX0QhPx3oY1HfAm7Bz3dQgSWL+3srsivDJhtZLBiruOQ7nH8zBopVGAavIcc+F33486aPOwFuhZSjPWwqcTvbt99MrESNKUt7qTHO9asU45mVFZt+t5K3KTnIRu2B1NWg6qLRyDrSAVBCCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905339; c=relaxed/simple;
	bh=Gba3zEmCGRsT82kSH4PvBGfFD1Y0z5mGbjQJQ/8lKIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJfc3yZIkIkb07ftnX+Cinr/5xAhRtom6BuQIBS6LNMu6VzWtaRlnDbhCdlW8KbxlgSScC1sumBto/3hihifXouJXyBY12sZ9O24T4x6MtEgjSvDkIBRkV3o4QVH7OuYsIbFkYieVjT8UrzmnIEnAdpZTky/Gm1A5n4XBVgghv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKbe7u9X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE58C4CEED;
	Tue, 25 Mar 2025 12:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905335;
	bh=Gba3zEmCGRsT82kSH4PvBGfFD1Y0z5mGbjQJQ/8lKIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKbe7u9Xvh8isSihGt6kXF+4MLeubRmVXpDt87uyRN/SP7UllOiStMyrtlJQjIfsu
	 1Hqtk5naMe0UheGZS80Sfa0zl11d6cST2bQbzQbQP6zp3JTlEhxFZ1+erShyWgpVv5
	 m4OgxrFrdZWkRi8e5adLBRWw11xX6PZl4Esqh79r65lvkXVdx7361AQY5CaHF/wGsB
	 E83s0iVJpTljmHXSCPSP2d0uzzX5JuGLn7J9OB6gQRtgkhW2o+6R7WFKdYQYdMxY96
	 tsyLis/6rOdw68n8FLG2k9n+ahfkJr3B2G35UK8EUKDj+I6/B4BHklYbO/OqqvREWx
	 amTO7iSypzjUw==
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
Subject: [RFC PATCH V3 23/43] rv64ilp32_abi: compat: Correct compat_ulong_t cast
Date: Tue, 25 Mar 2025 08:16:04 -0400
Message-Id: <20250325121624.523258-24-guoren@kernel.org>
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

RV64ILP32 ABI systems have BITS_PER_LONG set to 32, matching
sizeof(compat_ulong_t). Adjust code involving compat_ulong_t
accordingly.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 include/uapi/linux/auto_fs.h |  6 ++++++
 kernel/compat.c              | 15 ++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/auto_fs.h b/include/uapi/linux/auto_fs.h
index 8081df849743..7d925ee810b6 100644
--- a/include/uapi/linux/auto_fs.h
+++ b/include/uapi/linux/auto_fs.h
@@ -80,9 +80,15 @@ enum {
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(AUTOFS_IOCTL, \
 				      AUTOFS_IOC_SETTIMEOUT_CMD, \
 				      compat_ulong_t)
+#if __riscv_xlen == 64
+#define AUTOFS_IOC_SETTIMEOUT   _IOWR(AUTOFS_IOCTL, \
+				      AUTOFS_IOC_SETTIMEOUT_CMD, \
+				      unsigned long long)
+#else
 #define AUTOFS_IOC_SETTIMEOUT   _IOWR(AUTOFS_IOCTL, \
 				      AUTOFS_IOC_SETTIMEOUT_CMD, \
 				      unsigned long)
+#endif
 #define AUTOFS_IOC_EXPIRE       _IOR(AUTOFS_IOCTL, \
 				     AUTOFS_IOC_EXPIRE_CMD, \
 				     struct autofs_packet_expire)
diff --git a/kernel/compat.c b/kernel/compat.c
index fb50f29d9b36..46ffdc5e7cc4 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -203,11 +203,17 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
 		return -EFAULT;
 
 	while (nr_compat_longs > 1) {
-		compat_ulong_t l1, l2;
+		compat_ulong_t l1;
 		unsafe_get_user(l1, umask++, Efault);
+		nr_compat_longs -= 1;
+#if BITS_PER_LONG == 64
+		compat_ulong_t l2;
 		unsafe_get_user(l2, umask++, Efault);
 		*mask++ = ((unsigned long)l2 << BITS_PER_COMPAT_LONG) | l1;
-		nr_compat_longs -= 2;
+		nr_compat_longs -= 1;
+#else
+		*mask++ = l1;
+#endif
 	}
 	if (nr_compat_longs)
 		unsafe_get_user(*mask, umask++, Efault);
@@ -234,8 +240,11 @@ long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 	while (nr_compat_longs > 1) {
 		unsigned long m = *mask++;
 		unsafe_put_user((compat_ulong_t)m, umask++, Efault);
+		nr_compat_longs -= 1;
+#if BITS_PER_LONG == 64
 		unsafe_put_user(m >> BITS_PER_COMPAT_LONG, umask++, Efault);
-		nr_compat_longs -= 2;
+		nr_compat_longs -= 1;
+#endif
 	}
 	if (nr_compat_longs)
 		unsafe_put_user((compat_ulong_t)*mask, umask++, Efault);
-- 
2.40.1


