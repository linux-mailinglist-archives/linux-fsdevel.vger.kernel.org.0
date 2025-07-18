Return-Path: <linux-fsdevel+bounces-55484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7823B0ABA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC3D1C8256A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDA5224B06;
	Fri, 18 Jul 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IW9rzXlw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25C420E70B;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=F1COb3XW6XjCd9RNMtFygV2TYfNbxMhNI0o4P+1wEhnmrlG2/TWEShtX64Y2w5r00v7GUcZG3+csjoREjT7pkY0r2oAm3yX35+BCeXPGQP5ZujLp7lpRLdbzBtnVE5fgXVFPHBTgK8WfYQcaFxDh1xemQYKT33Whyx7/1cvHqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=wMzR91h+TTsVUPy1C9Ptk1wSfGkXWgH6/ZpbQTxAPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyyh4xdqcqFlKo5KLth0pWWCkxqg4LBddXNgFq5Vp2B1fxCfQNQgd0zQnqxedOw1JqEEhJS+qjt7LI9ttagOXKnnaD9HCfHH4sKTycigX1Rwfr2qMLxHe+U5Tw8wxmEVIKl8v1XyjlUSmw9LXI4Nj9YJZZS/IQI+JXXxySp/fiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IW9rzXlw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0sn2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:23 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0sn2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874406;
	bh=qL1eHen7HIDVH6yqsXjkpDMtAGllh3zedpoW2tNYpvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IW9rzXlwv/uOkas2T3V1khmJxnERsM2el1H1phxIc7qBkga4MRMTJqZm/DomFnl35
	 13DgyxteCdDLxQXAMTjZT4QCKOAa2XlTB4RRqROrWiW8v+aUAPtPup3VvZX79UZ0w4
	 M/Dp8YZJJo3weiB7ePx+x6MdyGAJbnCehkeS7eAUcBdDl/7qWeHNyKvwq3+ywo09lV
	 mh4Yp6iGpkGN+EVv1osRLkRAXVmGvmJ47UjqsYwnHpb7etq5FpyBctcUjTEvClOX1r
	 JSTu9U0f1LXRMf0PUUcicVM0fKa34mwPaZF94RKc1s4ReHsuyk9Bm5gpbcgdPuY4rE
	 N9SyHnaYWmTrg==
From: "H. Peter Anvin" <hpa@zytor.com>
To: 
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Laight <David.Laight@ACULAB.COM>,
        David Lechner <dlechner@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Gatlin Newhouse <gatlin.newhouse@gmail.com>,
        Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Kees Cook <kees@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Herbert <Marc.Herbert@linux.intel.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>,
        Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        NeilBrown <neil@brown.name>, Peter Zijlstra <peterz@infradead.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Uros Bizjak <ubizjak@gmail.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Yafang Shao <laoar.shao@gmail.com>, Ye Bin <yebin10@huawei.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-sparse@vger.kernel.org,
        virtualization@lists.linux.dev, x86@kernel.org
Subject: [PATCH 5/7] arch/x86: replace "__auto_type" with "auto"
Date: Fri, 18 Jul 2025 14:32:48 -0700
Message-ID: <20250718213252.2384177-6-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718213252.2384177-1-hpa@zytor.com>
References: <20250718213252.2384177-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace instances of "__auto_type" with "auto" in:

	arch/x86/include/asm/bug.h
	arch/x86/include/asm/string_64.h
	arch/x86/include/asm/uaccess_64.h

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/bug.h        | 2 +-
 arch/x86/include/asm/string_64.h  | 6 +++---
 arch/x86/include/asm/uaccess_64.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f0e9acf72547..4cce2ce8657b 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -94,7 +94,7 @@ do {								\
  */
 #define __WARN_FLAGS(flags)					\
 do {								\
-	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
+	auto __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
 	_BUG_FLAGS(ASM_UD2, __flags, ANNOTATE_REACHABLE(1b));	\
 	instrumentation_end();					\
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 79e9695dc13e..4635616863f5 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -31,7 +31,7 @@ KCFI_REFERENCE(__memset);
 #define __HAVE_ARCH_MEMSET16
 static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosw"
 		: "+D" (s), "+c" (n)
@@ -44,7 +44,7 @@ static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
 #define __HAVE_ARCH_MEMSET32
 static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosl"
 		: "+D" (s), "+c" (n)
@@ -57,7 +57,7 @@ static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
 #define __HAVE_ARCH_MEMSET64
 static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
 {
-	const __auto_type s0 = s;
+	const auto s0 = s;
 	asm volatile (
 		"rep stosq"
 		: "+D" (s), "+c" (n)
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..b0e4533ce625 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -72,7 +72,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
 	return ret;
 }
 #define masked_user_access_begin(x) ({				\
-	__auto_type __masked_ptr = (x);				\
+	auto __masked_ptr = (x);				\
 	__masked_ptr = mask_user_address(__masked_ptr);		\
 	__uaccess_begin(); __masked_ptr; })
 
-- 
2.50.1


