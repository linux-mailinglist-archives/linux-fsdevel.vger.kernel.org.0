Return-Path: <linux-fsdevel+bounces-55520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA2B0B3E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 08:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C19189C461
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD001DE4CA;
	Sun, 20 Jul 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IyaoOebw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C581917ED;
	Sun, 20 Jul 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994385; cv=none; b=BVg2InmxzawkC/kdxPE642ANGK1Q9ZDUq8yybvfmODbXziTnsXSh7YilDJIRDoyBC8UV8ZVoHjPu7XpxxBK+gFF4tnorUewrBSB/mkoUQbEyzwgUOrK9Xfkown2iGc5IEIS827U5HgPJosiQiHjnbEGpd8FGTSv9ZTT3nVfmeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994385; c=relaxed/simple;
	bh=QJYX1MFqg9BEnLun28Yp5CaUuKwFY/3raKGCnx2LRNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uB5FZeze9saFzNd+LJsl+HFQN3Ef++0/xDEUpB2I0j2raVEQbogvYOZ9k3mEDDvSA/2tet6tGdEN7f+Q0dyCZOxPQKpX2WzcVsK2VVprHhtef0ArkNHrMTpNZliYoYz5mooOtPENvNeh07m1biVBu7P/+ux0g2K1/O85PeyHI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=IyaoOebw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0Z3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:51:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0Z3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994267;
	bh=ELa2jqTmRsp27qDcEQ9Wkl+L9BhxZJU1zyGapTBoOEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyaoOebwCvNMxsbv8ant0kY7MOMwXoHKo25+4RBG5+U3uhKvfmj5aVg2EaAOi2yxd
	 alZKTjrWigRHG3wWOvHyRHl158c/jnUUc2kx+rfHgVF7ytc+keMlp1f6UJaPZWLhBS
	 xYNPr1xvNLrPoZ7nihezY/kliWsi1cStyLblbAPF+seEOt4BrdHQUmAwW4NDYzWYSx
	 ybSlFTvxXT8TbUWZg2OlgUDSXzSl3Yi/aJ7/q5zUQB78Dqns8DXZfDV6gON/faQHjH
	 cUDK6QX//Mp+t1HPJui7r42qiQC2FJtW0me/gkCx100dbyZg5bJV7Be97Om3sakIm0
	 a1SG8Lt8KPPpw==
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
        Borislav Petkov <bp@alien8.de>,
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
Subject: [PATCH v2 2/7] include/linux: change "__auto_type" to "auto"
Date: Sat, 19 Jul 2025 23:50:39 -0700
Message-ID: <20250720065045.2859105-3-hpa@zytor.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250720065045.2859105-1-hpa@zytor.com>
References: <20250720065045.2859105-1-hpa@zytor.com>
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
 include/linux/cleanup.h  | 6 +++---
 include/linux/compiler.h | 2 +-
 include/linux/minmax.h   | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7093e1d08af0..c7f3031ae400 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -199,10 +199,10 @@
 
 #define __free(_name)	__cleanup(__free_##_name)
 
-#define __get_and_null(p, nullvalue)   \
+#define __get_and_null(p, nullvalue)	    \
 	({                                  \
-		__auto_type __ptr = &(p);   \
-		__auto_type __val = *__ptr; \
+		auto __ptr = &(p);	    \
+		auto __val = *__ptr;	    \
 		*__ptr = nullvalue;         \
 		__val;                      \
 	})
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6f04a1d8c720..7fef5cd41dfc 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -186,7 +186,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define data_race(expr)							\
 ({									\
 	__kcsan_disable_current();					\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);						\
 	__kcsan_enable_current();					\
 	__v;								\
 })
diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index eaaf5c008e4d..a0158db54a04 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -89,7 +89,7 @@
 	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
 
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
-	__auto_type ux = (x); __auto_type uy = (y);	\
+	auto ux = (x); auto uy = (y);			\
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


