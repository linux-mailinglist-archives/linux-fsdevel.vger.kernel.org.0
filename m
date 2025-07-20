Return-Path: <linux-fsdevel+bounces-55519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D99B0B3E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 08:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A22B3BE377
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767391D9663;
	Sun, 20 Jul 2025 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bfT8wB4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E09273FD;
	Sun, 20 Jul 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752994384; cv=none; b=eqr6/v0dk8NQCwiWRb2ekx0OuUTJ/cjr0e6NZ1sePg/EsM10EDVsdJd8YNVfwdm7AcqCGPJgrUCzm91wOAAsk/rNB73Noge8iQ693YW1EgEjENU92WmW/parUunciOAnlW4AjkVoh12khbMmQJHGwAVUfuQWTTpbTm+lwyeGAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752994384; c=relaxed/simple;
	bh=LsNKexgn6BXks9XAt1SRbHnNEwPRhDi/Uja4dX8cv2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDFRrub2P+Svp6YaQWM5W0AmOUoRlRRlIzo9O6civT8N4JpfimONeA/+bkBLLsClMQE8bnqF5QXESZefeEuEVg+Y5k0e1rPt78ZfS8LeUwBItvpJ4ucYB6DFSRzC/ID8r9k/n8ZleNv+amd2uDPwhXmKJXc8Wffd8vbpWg7PJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bfT8wB4N; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9484:f04a:f27d:fd66:5c61])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56K6oq0b3555973
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 19 Jul 2025 23:51:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56K6oq0b3555973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752994275;
	bh=WjknFaojsifwlKw0WpmL9PxEqgNG67NL4pP5k1y5h+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfT8wB4NnCNiFno5TmtLgXp0LHSfcSGYno/ulj/mwTg2eV/U0U5mXDDLkhxIzDOWu
	 Yn//5eN6IgvkaZZDalhvPMYwur4x5RPsQ7ukQRJcrbbrK5lkTRFRTsAEs0YAqnTsPG
	 KVJoTRtRhgCnSRb34YM7GgdSHICF6a09oJQVKyQLhuvVtLgvE2/1xBl/RDnYXBAkev
	 Qo0cU9LsowrnxbikFqwbodWZTVIg3zcTvssyJbemvXwN/BWEB4DW/lxarrXqkESIdP
	 s/enNrRqYcsNdynt5gF54xwhvSV3wuw+Zb75z4P8GR2cdk44p6eOJhauAxKrWxCXLp
	 wi9VYu2Mnq6Fg==
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
Subject: [PATCH v2 4/7] arch/nios2: replace "__auto_type" and adjacent equivalent with "auto"
Date: Sat, 19 Jul 2025 23:50:41 -0700
Message-ID: <20250720065045.2859105-5-hpa@zytor.com>
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

Replace uses of "__auto_type" in arch/nios2/include/asm/uaccess.h with
"auto", and equivalently convert an adjacent cast to the analogous
form.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/nios2/include/asm/uaccess.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index b8299082adbe..6ccc9a232c23 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -172,15 +172,15 @@ do {									\
 
 #define __put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
-	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	auto __pu_ptr = (ptr);						\
+	auto __pu_val = (typeof(*__pu_ptr))(x);				\
 	__put_user_common(__pu_val, __pu_ptr);				\
 })
 
 #define put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
-	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
+	auto __pu_ptr = (ptr);						\
+	auto __pu_val = (typeof(*__pu_ptr))(x);				\
 	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
 		__put_user_common(__pu_val, __pu_ptr) :			\
 		-EFAULT;						\
-- 
2.50.1


