Return-Path: <linux-fsdevel+bounces-55482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B84A5B0AB9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10635C0AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 21:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17DA222568;
	Fri, 18 Jul 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="V5Z//aag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADA42AA4;
	Fri, 18 Jul 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874520; cv=none; b=Nrora2z5ktDGIjMVOkFkGWZ5Lf1XWa5uxrJBjS7bJ5m/SVMFfR0IHqcbZteyz2v+8KXpZgXblfECAaoPqxWh0HxiW79ukVaA6x+vj9oEimJ2kQY9abIYPbLqEJjeCxADTA5+GE9amc1cGM3XyQD4Nz1UnI/iujeovS9T9rf3FQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874520; c=relaxed/simple;
	bh=lBKUGA6zNqcsPATDf41Ebh8yrcRzfOT5mMVIGxIAdVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YdahYm7V1DM7bopythFAoqQgqJkZ6Deu/FU5D6JB+bxkZfhErmdXebq93z+yZYiMolhX32soyNFCSgT6qGAIaqBIhtQCkzX+o+as1aF7u/s2NpAhZl+37Oe3mt5ZqP9aML/DV54Oj+wWtk/rFqjBP3hbsRVBuSxzqQVbuWOua4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=V5Z//aag; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from mail.zytor.com ([IPv6:2601:646:8081:9482:197f:c1e5:8ae9:2d06])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 56ILX0sm2795198
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 18 Jul 2025 14:33:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 56ILX0sm2795198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025062101; t=1752874403;
	bh=jOYLooryEKHScahs/oq1OSMQ5trl6tIglcozgM03cmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5Z//aagl38qTHkyKVLjtRYpQg6NLFKlGhO4PTrXNQ+X5WlkCRSfUKB8e2A3YoZ9C
	 6bf3/7kfIkGso1z32JhBGAFS9WqaGkYL84wlFTTFIVb0f3t24PPSHDMczaXVzUZKlD
	 1hBIlHdmZtg1ELHdMO3eX1lzbmqGZZiZG9RMV9MALm5IuUA2GXvk7mZRsQnC4MchvN
	 peq3QRvYPRphYqYX3+Zxyf4UXYjOVs0umThbe4E6PvXQuYappn97AzFeAG+ZZCHh9t
	 0xU5RxTb+3BCZg47mZp5WG6FWvOYUrZgb/aRzR85G4MN49aqicMrwuy0oUkbBtpZcp
	 0mMeiaVOOH6ow==
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
Subject: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
Date: Fri, 18 Jul 2025 14:32:47 -0700
Message-ID: <20250718213252.2384177-5-hpa@zytor.com>
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

Replace uses of "__auto_type" in arch/nios2/include/asm/uaccess.h with
"auto".

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/nios2/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index b8299082adbe..fa9b06a7d7c6 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -172,14 +172,14 @@ do {									\
 
 #define __put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
+	auto __pu_ptr = (ptr);					\
 	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
 	__put_user_common(__pu_val, __pu_ptr);				\
 })
 
 #define put_user(x, ptr)						\
 ({									\
-	__auto_type __pu_ptr = (ptr);					\
+	auto __pu_ptr = (ptr);					\
 	typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);		\
 	access_ok(__pu_ptr, sizeof(*__pu_ptr)) ?			\
 		__put_user_common(__pu_val, __pu_ptr) :			\
-- 
2.50.1


