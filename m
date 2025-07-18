Return-Path: <linux-fsdevel+bounces-55483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBBAB0ABA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B00AA68BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4233922422E;
	Fri, 18 Jul 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Kx/7ty58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC39720C000;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=QXJd3EuXWXdLr8RKfLfTkfxeZCGJDI+bgNWOf5nzEqXAP1iNxslBevHbd/HBqzvRjLR75B/Q6Mo6sIhoIlcF0uraGCkU9MX1v2vUkVReW5YabPnjKupxDiChqPjw7wux2pYy3smb1IG3xYEDBqCkRsjsV6V21H5kF/5oKzB+Yvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=+dM1bld6YqFuWFqTeVy2M0W6B7tgTC8OPQdbIxYR2qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKD8yqmcxqS7hhj5NAzeG60l+pV8TDclhzLctSfelycwy5o+GO4+Tn9UEPvdUg2j6NMZlPqOXYhy6FU2k3GwgVs0bxKQPmwq3PPVvSS1lgQu7rFk/n+FOTvGynodi7gTuwwY7PibuHuQ+qh8T0WzgXzMYfltBg5f/s3+15FAYbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Kx/7ty58; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0sj2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0sj2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874392;
	bh=vsGxPzzTTwhbkBTwSIw4sMhUPUpWMkx20cB75uEuQgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kx/7ty58HGwlQQ9wukr5GLlArF7WbH8FuLxY3YsNTqgBvNvDn0WLESCp9yJlEkRvK
	 D4v3jsyACGn/Zs+sckVl4E860FaFow+wHRJOWxoCMXIYb5M2IMBAuSPrJjBVrsUBhD
	 /z/2WYf/0/n2ZRIQN1GkLQfeh2VxSfqhR08ebExZYrzLD/q2cp0wIUqMd8i/5oolkG
	 m9q4A3UgO3CxGt0qZyknk+aBLuIVgK4P11GErU8wEHk64cwd2VWdUQYXO2EbfL8jqY
	 h9urWUThtVvbUsShKEJP0wwRg/YQQwYh6tfsnwTvBJ48CiN2PxQ0jt/Wp6SDYN/z5X
	 4iujXkUVnsq5A==
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
Subject: [PATCH 1/7] compiler_types.h: add "auto" as a macro for "__auto_type"
Date: Fri, 18 Jul 2025 14:32:44 -0700
Message-ID: <20250718213252.2384177-2-hpa@zytor.com>
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

"auto" was defined as a keyword back in the K&R days, but as a storage
type specifier.  No one ever used it, since it was and is the default
storage type for local variables.

C++11 recycled the keyword to allow a type to be declared based on the
type of an initializer.  This was finally adopted into standard C in
C23.

gcc and clang provide the "__auto_type" alias keyword as an extension
for pre-C23, however, there is no reason to pollute the bulk of the
source base with this temporary keyword; instead define "auto" as a
macro unless the compiler is running in C23+ mode.

This macro is added in <linux/compiler_types.h> because that header is
included in some of the tools headers, wheres <linux/compiler.h> is
not as it has a bunch of very kernel-specific things in it.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 include/linux/compiler_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2b77d12e07b2..c8b1ee37934e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -13,6 +13,19 @@
 
 #ifndef __ASSEMBLY__
 
+/*
+ * C23 introduces "auto" as a standard way to define type-inferred
+ * variables, but "auto" has been a (useless) keyword even since K&R C,
+ * so it has always been "namespace reserved."
+ *
+ * Until at some future time we require C23 support, we need the gcc
+ * extension __auto_type, but there is no reason to put that elsewhere
+ * in the source code.
+ */
+#if __STDC_VERSION__ < 202311L
+# define auto __auto_type
+#endif
+
 /*
  * Skipped when running bindgen due to a libclang issue;
  * see https://github.com/rust-lang/rust-bindgen/issues/2244.
-- 
2.50.1


