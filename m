Return-Path: <linux-fsdevel+bounces-32273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2624B9A2F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E091F248C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298D3DAC00;
	Thu, 17 Oct 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iSDw60lg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2021D3182;
	Thu, 17 Oct 2024 21:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199702; cv=none; b=YxXPWNCG0JxkrDQUy8sCF9pgKSHoSKaGZWAeGIVcCaFTU+beoNmXWAETC7J8rMxlDok2yjizk5+NXY3FocxsqAYgv4y7r9U3RxjGMoEqJrztSw8WgMeuKAVckAShrTuHz95yw1y1izDNsZzn5ZoQF6ges38pyGSzeMsWgXV/JH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199702; c=relaxed/simple;
	bh=D53nHasbAy5mgMYWiQL0gWKqem/rpPA58GRuUy/JWp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJBkEKNyFrZN2u7JnOTpJitDCja83dSgXWWxZUJ+AuHKXDDfRMp/xi8l6jOrfzTme6+oBXK1mMiHhEksvBG3/qcBH0QHn0V608pKmNmoO+tKP72X+TKcRSGxAfOHkhCpbdHCfl7nVd6KYVjVYYDRcpUBVI6KAaJCnsfR+QEJpj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iSDw60lg; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hhDlIiM2rMTHaWInpW6Q+AoMhFTJClxESMUDFdoVjOU=; b=iSDw60lge7F7jzxnfBIsI91WxB
	qUzuh1/WBRtByHLpt4cxcSlLviYC4/jFyhvBZPy6uEmS+VF+oW6ak2o4bVutpmBW4bQMfsQIo8mAG
	+juqzsuDe8HB4B2hREQeCPz+RS0WKS67EQ8L0EtlER/ESOs2wgSLKhsE9K74dwfkl6hOp8+ObcTD6
	6LAhbhdeWd6gHFQxhL5oWdJNLB8m5P54vbdwXwmuGnmDFJwvdhGoLjjHGEd/h0K1wItgADP9RWYET
	joaTf9z6dhkOUy/M/LYT2u93fRdprG0iDxu4FwtKK5rszT7/Tg/gkOt6luCYqdTQqHzGvncfCSJJ/
	NajR5XjA==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Xpe-00Bnlc-NG; Thu, 17 Oct 2024 23:14:54 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:13 -0300
Subject: [PATCH v7 3/9] unicode: Export latest available UTF-8 version
 number
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-3-a9c056f8391f@igalia.com>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

Export latest available UTF-8 version number so filesystems can easily
load the newest one.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/unicode/utf8-selftest.c | 3 ---
 include/linux/unicode.h    | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 600e15efe9edfdf6d04cecd162e84f1f5a59c5e1..5ddaf27b21a6543770917d5a837e86e12eee0b81 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -17,9 +17,6 @@
 static unsigned int failed_tests;
 static unsigned int total_tests;
 
-/* Tests will be based on this version. */
-#define UTF8_LATEST	UNICODE_AGE(12, 1, 0)
-
 #define _test(cond, func, line, fmt, ...) do {				\
 		total_tests++;						\
 		if (!cond) {						\
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 4d39e6e11a950c76f78d775fd6f351296f3d7d53..0c0ab04e84ee80227f9390ad0498f21a7ab7d34b 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -16,6 +16,8 @@ struct utf8data_table;
 	 ((unsigned int)(MIN) << UNICODE_MIN_SHIFT) |	\
 	 ((unsigned int)(REV)))
 
+#define UTF8_LATEST        UNICODE_AGE(12, 1, 0)
+
 static inline u8 unicode_major(unsigned int age)
 {
 	return (age >> UNICODE_MAJ_SHIFT) & 0xff;

-- 
2.47.0


