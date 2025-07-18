Return-Path: <linux-fsdevel+bounces-55481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2022CB0AB9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85C75C0AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7492222AC;
	Fri, 18 Jul 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cFg+031R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3F1F8725;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=jfTSpWRZ8q7Znyp33DvJbmUwbCPp4mIwzRDQHqjX0+4KMrh5nWYarCb6hctDjoJrIMd9GjCqokjQnASTrZ6KTAb8QdZHXpBqH6R+iSAgqzEVmq6vwOdhT803a1x4nneBklbIMsHhMVnBykjuSFrOJUscFdNrstJLS0Kx784TeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=OPia4yWRRB0ETvHg3iEu6ZARkqU6LQuX0N7+VdhAdZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTf13X+jZR40QuqQSKWIPOw/ruuXOGpstSEQCemD8p/OyZptPebF+J+YlGHK3J6JVf/ny66bz7GpfITIMrSV61J1tgFQp3/Y0evr/UoQO8XdtgXD+h7D0BY+mC0bcqR1TE4YDS2RWXhGIcGuWB6F56ReAAQcT70wW53KBV0HJC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cFg+031R; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0sp2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0sp2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874414;
	bh=PBGN4oO/waKGE3jC/Ll9lbwkGvnnLUY8sUOeeNBmyj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFg+031RqaaaPlckPQZdrk7tHRtUQ91gMNZp0PCiAL+WS4vDpv5381NXCbOx9+vvi
	 vA2jRIb+O5/TVvIfLSuwnuFCz0DXgInWqk0DTtrJi8gPLUe1MVqpOm2n5j0W3DxwAJ
	 tZAeEeTeTQWXhL+b+HKBe5o7KVHhnv/VYE/5PTiVKLImFHUL30VJ3SiEiEkDceRwIQ
	 j22Dtvl6wpGlQSC4QquExka0Lf8ys+jSvS1EgRDoVCuzSPtlcM+fBkck//a3x1N7r9
	 y1P3/wLVyPO9mfdNhI6s4gnvNmYd8pAlAeKvUir8mEV0gjLzQYUn3RG9wWSMQC6YUp
	 rWuLmL/fzY+bA==
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
Subject: [PATCH 7/7] tools/virtio: replace "__auto_type" with "auto"
Date: Fri, 18 Jul 2025 14:32:50 -0700
Message-ID: <20250718213252.2384177-8-hpa@zytor.com>
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

Replace one instance of "__auto_type" with "auto" in:

	tools/virtio/linux/compiler.h

This file *does* include <linux/compiler_types.h> directly, so there
is no need to duplicate the definition.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 tools/virtio/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 204ef0e9f542..b6e94c2ebe49 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -31,7 +31,7 @@
  */
 #define data_race(expr)							\
 ({									\
-	__auto_type __v = (expr);					\
+	auto __v = (expr);					\
 	__v;								\
 })
 
-- 
2.50.1


