Return-Path: <linux-fsdevel+bounces-29102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C89755E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095FF1F27B5D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 14:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0791ABEDB;
	Wed, 11 Sep 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RNPzzW+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F71AB537;
	Wed, 11 Sep 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065941; cv=none; b=Jclc7nx0LxAYJgDzpsk7dKOxTJWRrsLxm45a7nwZVzvdebCJm8KEWbQuePWHzC7VRZS9m0BTseIgTItL7+RB3VnFbXWlsb85jx9kG35r6ENt850Jc1CwVSQ1wcmFvO+r6M0LYdrz8M9iowwXeYt9+BhIMYFjfy5/MttSTV7kUKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065941; c=relaxed/simple;
	bh=TNZ/1JgO74m1hYqUho91tGqfE80KNCqAjRAv1/zC2VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNT2oECHHn6hw4El4U2fidzBh43f3bCwyKct0kZn3gfNwWg2ezjhk1FydusXPC6PJTHsuuoun4xhmlebXqeX4Hfci3WrvFBDpc0QbCcEGhF4L/rwzdoY1MjWFaAmDVfR5QlC43TgoWBQm0C81xBPODz0WU4+fGaDMMYWoJKzBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RNPzzW+J; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Q0CxLvnub6YNgaQNFMUQs5iJpolg9jiEm0ayfVoTv18=; b=RNPzzW+J6Gy+V7B4nSX+XG52Pv
	mrTDmizb56Ty4IzYaIyjxAFQgOgdRKJYM34xOv64sr9PVV8kbabW76/oWNPdm+0Utqhh8sC/OQg0W
	3lpoSGCXhe49JKsQv9lsQ2jUmNmuNjG69npKt6k5TV3g8MgJRHJQ4/JypQs9EOwcifkjLK0WGwQD7
	unLC+UxtoDo0VewnbYj9oeiZuVk0XYwqxOpBp/PAcGGjmWRLy4kv0p7EwJztZazVs8KS10o7mNeoY
	TvngTO0It3S6tzFVn0hNSiHadP8T0DQxncgAiTK4LF8Qf7QA1rBFVhbKsOh25JVczfyokdbHftNMA
	Xp8oLGxQ==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1soOb2-00CTwi-L9; Wed, 11 Sep 2024 16:45:29 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH v4 04/10] unicode: Export latest available UTF-8 version number
Date: Wed, 11 Sep 2024 11:44:56 -0300
Message-ID: <20240911144502.115260-5-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911144502.115260-1-andrealmeid@igalia.com>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
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
Acked-by: Gabriel Krisman Bertazi <krisman@suse.de>
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
index 12face04c763..5e6b212a2aed 100644
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


