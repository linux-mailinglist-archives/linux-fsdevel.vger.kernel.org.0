Return-Path: <linux-fsdevel+bounces-55480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A6B0AB97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70C7AA6802
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13E5221FB1;
	Fri, 18 Jul 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kUtLsUmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CF1FE45D;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=CdlJf/6xn+ryj2zP40y+bucpJOtWsY2FPVmX7ZFEklSbuMBxjDTJsLPKIIpg0GHSJl23ialWnEv/axP3Aow5biloL5HEFN5b0qjZ94NwyxBPpOLdbcXH5/XPIOBWfcms/MEMcTYyUz5AlS9znEPJv24hPtgBiFRFj1lcxafbCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=qTM7AwfdMSpV4NjWdyBTj056XS0XUIw4MsAivRgxjA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ9+1A70DQ5U8JJ2t2Qx4fycQ8bJydXM2QgrIQntvq7xJYYugzacPeXcN1d0v1Dv0DkOqrnaffz0xXzdmigoYgr434KiJoy6i8RIZoAYfyHvR6eyz07g9cAB1n7ODgHVc/WhayCvZYCP9UzRHLwprPfTPMwFF4G/lowKFh6AsP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kUtLsUmn; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0so2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0so2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874410;
	bh=jdACkDnI1i4f1cAIvfWumKYM1ftH6IqzvEllMEW8ooQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUtLsUmnGPo16uDqJL2qnrWMXseSawh9pJpv2YNt13h/uBXId+AZ31/sNWTpQXkp2
	 SjEAlw3kdXesYtDUSnlCvfAQNJLFsTtaIo6MXGBTKn3LylDCR6PPhMBLUd5mcsQyfX
	 57ujEYGvSBblQt4abQ3lWHNmuhdAwG0gyzOAMOeE/ztt60vidgLq9F+AOBLr4XsBmW
	 r8LStmai4OmIZA0okWI//xBbtAIjITaM3K3apWhtvxdZpYXAIHuowGsM8KQJDSmR1v
	 j/alPUDZy6ED9LuWWNAZgancdZ4nVifLbixnsyiSXDaE1mUcmhczWyQeYdRKFPGu6S
	 KQCwtaZV5Xgtg==
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
Subject: [PATCH 6/7] selftests/bpf: replace "__auto_type" with "auto"
Date: Fri, 18 Jul 2025 14:32:49 -0700
Message-ID: <20250718213252.2384177-7-hpa@zytor.com>
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

	tools/testing/selftests/bpf/prog_tests/socket_helpers.h

This file does not seem to be including <linux/compiler_types.h>
directly or indirectly, so copy the definition but guard it with
!defined(auto).

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 tools/testing/selftests/bpf/prog_tests/socket_helpers.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/socket_helpers.h b/tools/testing/selftests/bpf/prog_tests/socket_helpers.h
index e02cabcc814e..958b65aa29ea 100644
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
+		auto __ptr = &(p);                                      \
+		auto __val = *__ptr;                                    \
 		*__ptr = nullvalue;                                            \
 		__val;                                                         \
 	})
-- 
2.50.1


