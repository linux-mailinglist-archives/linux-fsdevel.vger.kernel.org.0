Return-Path: <linux-fsdevel+bounces-55485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF72B0ABA5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146DE1C825FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0D4224B04;
	Fri, 18 Jul 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Zk9YCLSE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2FD207A32;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=dxsG/Prk82FrkWR5qZYNQdz+4NVGQEpalFcp3ryDlKpPw8tYPByu+JX65XxXptxzRzV5I/3al9jlPYrOO2H3UPf44YtPU3/9JOTVU6jUaguykUmbtcEUdC4fG1cN+DQ5YBRmP/QJm6ADzUVzXUHCMKTsWSh2h7lyujititaRZ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=9dtVCcaoM7scDr6iHjz+kfoV+3QGDIWOIuOPomYWM8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5gZNX5Hp+to1koPFe68vlQ581nZnm/Zps/Pa2eADIQk4zG56fEbr8ER/OKEh6iUBuvutAZkk0Ts/B2xVxG97r5E2TdBI68qjZE3bqrruy4xnmh7DBX6LpU17etbK8qD8D/WaoesUeTWVpyF12OZI/1jnxy2J+41blkPzq01gmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Zk9YCLSE; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0sk2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0sk2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874395;
	bh=Z4WmS4NAnxtVl2zGz5v9dKawPFHSnciPALGaXZnv+mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zk9YCLSE+KfX8gmZ6wswqlqJW5JOx+SissEJ5Ra2wJTy1z7ecBDKHBGRc64XXQhNE
	 YZVhdTFGXR/Dh1aYxkOOAJUbRtB0NhBTa5/4TeGRJt3f4bZAIv+vF+od9n7EFsWHPE
	 5mcyAnxN1JS+C7sEx7Kb1S7AvDFnoN5+K4Mec9vf5RXaUDj0vWkuV+yLe/lwL9obPj
	 XRNn1oKKwl+4Sq0358zKr91s43RP7AdpGWVM5D8r6mlYTJ/Bw0kHkLiojNOjKikOdz
	 rMOKgmauDhfRoWu0WTCVxGtC3lY8ioEkKUyWrnmWMgNrwmvCe4+kbH3kmHJWdY8JlL
	 Uv8GXdJ/L0ZNQ==
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
Subject: [PATCH 2/7] include/linux: change "__auto_type" to "auto"
Date: Fri, 18 Jul 2025 14:32:45 -0700
Message-ID: <20250718213252.2384177-3-hpa@zytor.com>
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

Replace instances of "__auto_type" with "auto" in include/linux.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 include/linux/cleanup.h  | 4 ++--
 include/linux/compiler.h | 2 +-
 include/linux/minmax.h   | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..08973560e81d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -201,8 +201,8 @@
 
 #define __get_and_null(p, nullvalue)   \
 	({                                  \
-		__auto_type __ptr = &(p);   \
-		__auto_type __val = *__ptr; \
+		auto __ptr = &(p);   \
+		auto __val = *__ptr; \
 		*__ptr = nullvalue;         \
 		__val;                      \
 	})
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6f04a1d8c720..f50183b71bb6 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,7 +186,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);					\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index eaaf5c008e4d..7c6fba53ea5b 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -89,7 +89,7 @@
 	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
-	__auto_type ux = (x); __auto_type uy = (y);	\
+	auto ux = (x); auto uy = (y);	\
 	BUILD_BUG_ON_MSG(!__types_ok(ux, uy),		\
 		#op"("#x", "#y") signedness error");	\
 	__cmp(op, ux, uy); })
@@ -129,7 +129,7 @@
 	__careful_cmp(max, (x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull)
 
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({			\
-	__auto_type ux = (x); __auto_type uy = (y);__auto_type uz = (z);\
+	auto ux = (x); auto uy = (y); auto uz = (z);			\
 	BUILD_BUG_ON_MSG(!__types_ok3(ux, uy, uz),			\
 		#op"3("#x", "#y", "#z") signedness error");		\
 	__cmp(op, ux, __cmp(op, uy, uz)); })
@@ -203,7 +203,7 @@
  * This macro checks @val/@lo/@hi to make sure they have compatible
  * signedness.
  */
-#define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
+#define clamp(val, lo, hi) __careful_clamp(auto, val, lo, hi)
 
 /**
  * clamp_t - return a value clamped to a given range using a given type
-- 
2.50.1


