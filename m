Return-Path: <linux-fsdevel+bounces-24852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152D945AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07EADB24818
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB791DAC68;
	Fri,  2 Aug 2024 09:21:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDE1D2F73;
	Fri,  2 Aug 2024 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590465; cv=none; b=A8m6iBOVOKB+NcEpBUvP64NPemAlSBXTKIL7WCb5n6ba280p7bova/oe4XwWTeaNNEaIZCweeNH0zSov5qBGxJrOaBT2Hm8mCekIm3xJo6pRQtan4oJ2RUQZag/aUdJ7CwiA1ho3iHUpdnqGMdjljLqXo4Z0frXJCgMBNXZ9Shg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590465; c=relaxed/simple;
	bh=+qIHkhJv16Hh8lMeuvWUMc6pm97g3HIFWRHqqhzgbrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WyzD/kVZYnUsC50ER1OrMEeN3WQJ0vNdjohyjk/MXCPnCYBoWq/EaobkSuRTRfxA7x+BFSkO1eNyikwG+hLbJx27buwVuGONELSfBZZFDUNbEOt7Zkpu0Yko2zgWqfcSxgb9InURusHVIWtfS6jcPjnS/g+1xRJU9pZU/orZ6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laoqinren.net; spf=none smtp.mailfrom=laoqinren.net; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laoqinren.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=laoqinren.net
X-QQ-mid: bizesmtpsz11t1722590369tysorc
X-QQ-Originating-IP: pPNwhlYaIQO+30V/hlDGbUY7D9eliME6KMTXrd/P93M=
Received: from localhost.localdomain.info ( [103.37.140.45])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 02 Aug 2024 17:19:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16223661223895339579
From: Wang Long <w@laoqinren.net>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	cl@linux.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Wang Long <w@laoqinren.net>
Subject: [PATCH] percpu-rwsem: remove the unused parameter 'read'
Date: Fri,  2 Aug 2024 17:19:01 +0800
Message-Id: <20240802091901.2546797-1-w@laoqinren.net>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:laoqinren.net:qybglogicsvrsz:qybglogicsvrsz4a-1

In the function percpu_rwsem_release, the parameter `read`
is unused, so remove it.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 fs/super.c                   | 2 +-
 include/linux/fs.h           | 2 +-
 include/linux/percpu-rwsem.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 38d72a3cf6fc..216c0d2b7927 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1905,7 +1905,7 @@ static void lockdep_sb_freeze_release(struct super_block *sb)
 	int level;
 
 	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
-		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
+		percpu_rwsem_release(sb->s_writers.rw_sem + level, _THIS_IP_);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..d63809e7ea54 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1683,7 +1683,7 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
 #define __sb_writers_acquired(sb, lev)	\
 	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
 #define __sb_writers_release(sb, lev)	\
-	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
+	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
 
 /**
  * __sb_write_started - check if sb freeze level is held
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 36b942b67b7d..c012df33a9f0 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -145,7 +145,7 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 #define percpu_rwsem_assert_held(sem)	lockdep_assert_held(sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
-					bool read, unsigned long ip)
+					unsigned long ip)
 {
 	lock_release(&sem->dep_map, ip);
 }
-- 
2.33.0


