Return-Path: <linux-fsdevel+bounces-55523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF5B0B3F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 08:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD760173A29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3181E1C02;
	Sun, 20 Jul 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WbPJ5jDG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA782192598;
	Sun, 20 Jul 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994385; cv=none; b=TiDwVodWW3p0Fl6iRXzht0zKBhboneZD1F2vWfcxhjntJIKZR2Loh0oCk/DPLSDGayk1mXTHHk5YGigfnKTKzVeM3ExP5yMpiBjhkGJuvWgkZULocSKLgXVn5Z/KmBA0E1cFO+Nyj0ERLX0h5The4olhL2japaYO1RapWrGj3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994385; c=relaxed/simple;
	bh=xSzAA2gv0ibDrNTKlxM9ctRGuuU7YJyBmHWCcxfeOeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idHZ9p3Zi2IxzyFDjPayt2ahbEW97cuMhER+nPCLq3neSGHSBxwqUxiBxhQxzbqdnC2anO3Xa06QTTjIm39+HBQpYw3RQfGER2/vEsZUrwEagf8K8Zolkfh8WIBS3Vr8FSDAAha2jb2t3FEdpEMjiEq6XS6cFuCCL4MSsyRu+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WbPJ5jDG; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0d3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:51:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0d3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994282;
	bh=D2ugkTWHSXT0lgY/l81pjC122eFLTRxMlbXL6ZHS8/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbPJ5jDG6RivnIGPGdH7tAxTfD9XHzmh0bmqjk3F973Xb5FIbCaOvDyDyN0WiLW+c
	 tAy5g/9v8RqOIbjCNSInPta52bvotaWD5hPRM2K4tYGULsfe821h/r4HdujoW8rdGn
	 9EFmbltCfQLyLdRDItbhgPJ53ZPZCGhW9HCQnawRm07kUSSfwL45JVPL9XpFRKMy2D
	 2hEyzbhiOW+lCYQ3FyZ2P2GRpqPNw/1YfkCVJZKyzBpSVwn52GICIvNqCBCCqxkzGf
	 FrZ/9vdEL1jhvq2l9eNoQhYhFkql9Vhx4htZWEqN/Ersst18Dlw9Y8kG++tO6qOW3y
	 MmwLHD5lW3ing==
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
Subject: [PATCH v2 6/7] selftests/bpf: replace "__auto_type" with "auto"
Date: Sat, 19 Jul 2025 23:50:43 -0700
Message-ID: <20250720065045.2859105-7-hpa@zytor.com>
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

Replace instances of "__auto_type" with "auto" in:

	tools/testing/selftests/bpf/prog_tests/socket_helpers.h

This file does not seem to be including <linux/compiler_types.h>
directly or indirectly, so copy the definition but guard it with
!defined(auto).

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 tools/testing/selftests/bpf/prog_tests/socket_helpers.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index e02cabcc814e..0d59503a0c73 100644
--- a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
@@ -17,11 +17,16 @@
 #define VMADDR_CID_LOCAL 1
 #endif
 
+/* include/linux/compiler_types.h */
+#if __STDC_VERSION__ < 202311L && !defined(auto)
+# define auto __auto_type
+#endif
+
 /* include/linux/cleanup.h */
 #define __get_and_null(p, nullvalue)                                           \
 	({                                                                     \
-		__auto_type __ptr = &(p);                                      \
-		__auto_type __val = *__ptr;                                    \
+		auto __ptr = &(p);					       \
+		auto __val = *__ptr;                                           \
 		*__ptr = nullvalue;                                            \
 		__val;                                                         \
 	})
-- 
2.50.1


