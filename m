Return-Path: <linux-fsdevel+bounces-28777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CEE96E29E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 200F8B262FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B71F190045;
	Thu,  5 Sep 2024 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hbeKl1QT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCACB17B51A;
	Thu,  5 Sep 2024 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563016; cv=none; b=JkaiMTHnbv+xlUZLkGURAx7e532lv1Q0653Gis02Tm/jNavCHpGwhwZ0+ZyUuK3oRCJyS7+/2KxX2TRxzJUbhM5pzCqsy+zlm/u4+6X5ndG1w6sV/bYrkXbmyUbP00bR2jg2y10lb9KS4RY6X803BhlQsGKmC2qPc29TJupu9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563016; c=relaxed/simple;
	bh=0ayzV8+fDZpvGn5mEUT1XYCyH/1u2eCNInzpL2N8O4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcBuP5d5qwQ5PnDVwUS5AXyIGGue/RkAbIHEj3TvzCOu9H+M3JUa+dTT7pfgpB9Zu/nuHtHhe4v67POJOTunhXfVlJ3EgPhO76/YP86CNEW18rRRyNOoXK4RMmi3MDz+584bKLuGwy1nfuAuIFvdmPcSJHy44+LeMRDJ6MFFVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hbeKl1QT; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7BUAvvMuRU2tfo2IDkqAEnh0rC165iKKlWi/Zf6qiA4=; b=hbeKl1QTRIQB74KvSycQ2F2ZFI
	6EfPYPIhY/kDzNhC98wdLPBaxCUHGO7YQWeSRu206BRnRY4OziReMSFa9WRpaSTikBw7d2jXLjfwr
	nTprejKDeitM+tSIEZhx2fICW04IwmW+fU43Zj738ANKXAnWQOgAZGu/wevvHpNtkqgvIVwpWgBLZ
	ZdqWoBif0OlbIyaMHRLkuCGA/93cKu/Is6K/FZyIKHbUW5sbcDVaAzQttKFFePbOWeMf/SGsQubuk
	g3gaYQ56XbCJ6j0nXmDVsOxjwOAJDtg+1amttVaH0F5VvFc65s2ObC6W5W2m8zfdlLd7ncHFNieAE
	HSjJ+DLQ==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlN-00A6Ho-RC; Thu, 05 Sep 2024 21:03:25 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 4/9] unicode: Export latest available UTF-8 version number
Date: Thu,  5 Sep 2024 16:02:47 -0300
Message-ID: <20240905190252.461639-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export latest available UTF-8 version number so filesystems can easily
load the newest one.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---

If this is the accepted way of doing that, I will also add something to
checkpatch to warn that modifications at fs/unicode/utf8data.c likely
need to change this define.

Other ways to implement this:

1) Having a new arg for utf8_load()

struct unicode_map *utf8_load(unsigned int version, bool latest)
{
	um->tables = symbol_request(utf8_data_table);

	if (latest) {
		int i = um->tables->utf8agetab_size - 1;
		version = um->tables->utf8agetab[i]
	}
}

2) Expose utf8agetab[]

Having utf8agetab[] at include/linux/unicode.h will make easier to
programmatically  find out the latest version without the need to do a
symbol_request/symbol_put of the whole utf8 table.
---
 fs/unicode/utf8-selftest.c | 3 ---
 include/linux/unicode.h    | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 600e15efe9ed..5ddaf27b21a6 100644
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
index f73a78655588..db043ea914fd 100644
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
2.46.0


