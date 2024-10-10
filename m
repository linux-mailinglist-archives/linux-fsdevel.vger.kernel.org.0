Return-Path: <linux-fsdevel+bounces-31628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E37F9992DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38DBCB27CEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8D1E8859;
	Thu, 10 Oct 2024 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JscOpjLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83851E882B;
	Thu, 10 Oct 2024 19:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589276; cv=none; b=nNdYDBz45W8OKy3NR4u5S7N3LRMzlurhzVaGu8gYwY9LbpwAstJHipSWFWEXWhzVkeeMT1rXc+J0rUmKkMdvV13KSnVQhw8HM5YFTbW97rZdv4Xtkm4RnMP6zFIUhCLXvRl+2i0q/orqeio/pCrY6PE3orBfbYgaCP9kVhjhvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589276; c=relaxed/simple;
	bh=D53nHasbAy5mgMYWiQL0gWKqem/rpPA58GRuUy/JWp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8Ox/7yAkW6wbjOAWqXcPx6UiGWAQ/m3em51McZ16qBYd//Z7lfutnydcXP99Agc1LJQ34+ImB9zrq3xlga87kfuvMMnU8xHyKVRm4bDg7WhyZlwIyI6Ncih3yUWXb+rpAZaJs6Ne7pwnlKm1zfGE8ZRxcLBlaC4doJoBFLeB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JscOpjLC; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hhDlIiM2rMTHaWInpW6Q+AoMhFTJClxESMUDFdoVjOU=; b=JscOpjLCcDAbWr+y72BNgPbFuT
	YFffuCfFxjs6RPw7PX+MxgkAyxRSQEaucgc/5WtOLfUHuenuf4pgFNElvM3fOxGP1DFhqC35aoHCx
	Ov0V/eXe5I0g9YO7VY2It9HBYn85ZVn2LrOzoxgFLj19k5/yFH9Jl41GoX5ZJfrHRqEBtxv4pcMic
	67rBjBCnMcnzYBK4rO48DMznqloTqrgwAV9KR1x0daA67b3mZiInkxDgCQ2ByNCNCoG+/J+KYQnpT
	og0jUep8IQm8/pzZ3bZ5nFan0FK46EBCtJo01dhQUaPwhfWdqEBHXzClxUvjp4yZYMR/dOAp3HLql
	toZs0oOw==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz27-007SHz-Q3; Thu, 10 Oct 2024 21:41:12 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:38 -0300
Subject: [PATCH v6 03/10] unicode: Export latest available UTF-8 version
 number
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-3-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
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


