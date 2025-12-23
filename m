Return-Path: <linux-fsdevel+bounces-71958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C61CD8568
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 08:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0981C302ABB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 07:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F43090EB;
	Tue, 23 Dec 2025 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJhjkprA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gy9yqeF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25821CFF6;
	Tue, 23 Dec 2025 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766473244; cv=none; b=XAvfx3GJbqYtUFjbiuwW8qkdtfPpQ/+InHogh5bXE4UUxJyivGV4owncgkN116jdBDFdkkRzn/EDsDIKFpW4309SIfgAPTp5Qw8wKpO3AeqnchOodkvanb9mPgTc/JJ5/MNJT2SZmZ2wRwQhsFip+Y+Hoi8ezErRV+1m2XazDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766473244; c=relaxed/simple;
	bh=VESpH4Q/wPFQac3Fxxr69JbHKPbE1SR9444P0CJhx7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FeA+kfdeE6zneR115bFbtQz/ylNSyQ1Zaktz2jSjsPJGH4McW+riA1k0mM6qa9DpAw+BoNEP/4T69utQLSoJM06plYsstv4N8I90QmDB5PncXURHe73cAc8DgUUOW5Rc/XwEBRSxPDx1xclEoLh6qfORXY47uqm5piDBIEwX0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJhjkprA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gy9yqeF5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766473241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BywG6AQMcVJFeA7uaa2WuuatB8WHezGICiNxDvjW2L0=;
	b=pJhjkprA1WeLQIhNnH+7t3f+tLbC97rX7BCDy+j/GX5QFRjjJti7L42hTxHs9RQSIbZ5+W
	LwqQPrwwr5HqBRukAEYM7irIMYnjs/8oCOLny6TGmYZIfILnhCnU4Plt7XyFRUcjD22PNX
	1vQgXNN6OnN7C221EGvJevfiFUH5r9xwFv70pEXA1trS/ZdMGjF7xXiUfyjqzdsw4T4BDE
	YAJKFPu7eYGgxzJll3/FFzRTDNQqN0nj4NcMCCqZTlP/Y9Uv2muYKHuI28Y/7C8qRCPJTa
	vh0UiII+kGChBAPWN+Us0tOgCGV2jTavix1qIF9f7E841seWhwYBZbdAxEDvAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766473241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BywG6AQMcVJFeA7uaa2WuuatB8WHezGICiNxDvjW2L0=;
	b=gy9yqeF59oEe9cv2ki/fXAlr5bhgyYD9qTQEXGi5c62Do+JzFkBQK8miSIkLv4x+k0QJhM
	cAo01Xu1Ds5gzwCg==
Date: Tue, 23 Dec 2025 08:00:39 +0100
Subject: [PATCH v2] select: store end_time as timespec64 in restart block
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251223-restart-block-expiration-v2-1-8e33e5df7359@linutronix.de>
X-B4-Tracking: v=1; b=H4sIABY+SmkC/3WNQQ6CMBBFr0JmbU1baARX3MOwwHaQiaQl00owh
 LtbiVuX7yfv/Q0iMmGEa7EB40KRgs+gTwXYsfcPFOQyg5baKCUvgjGmnpO4T8E+Ba4zcZ+yJIx
 ulKlM5epaQdZnxoHWI33rMo8UU+D38bSo7/qLKvk/uighhXFlY21TuqEa2on8K3HwtJ4dQrfv+
 wd6KXKKxAAAAA==
X-Change-ID: 20251107-restart-block-expiration-52915454d881
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766473241; l=2651;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=VESpH4Q/wPFQac3Fxxr69JbHKPbE1SR9444P0CJhx7o=;
 b=am66H2/vYvhA7nJ6g+ZCU0nQ2i47s25EgHgqBgXcQ0uWi6uYOw9tZLxg1eKGikdhML/YMCdfx
 NvgTsLiikoqCF7NugbRkLcvSwmR0acCAb1hZV27IU9smAKIwXA5zeWc
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Storing the end time seconds as 'unsigned long' can lead to truncation
on 32-bit architectures if assigned from the 64-bit timespec64::tv_sec.
As the select() core uses timespec64 consistently, also use that in the
restart block.

This also allows the simplification of the accessors.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changes in v2:
- Drop already applied patches, and trim recipients accordingly
- Pick up review tags
- Link to v1: https://lore.kernel.org/r/20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de
---
 fs/select.c                   | 12 ++++--------
 include/linux/restart_block.h |  4 ++--
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 65019b8ba3f7..78a1508c84d3 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1038,14 +1038,11 @@ static long do_restart_poll(struct restart_block *restart_block)
 {
 	struct pollfd __user *ufds = restart_block->poll.ufds;
 	int nfds = restart_block->poll.nfds;
-	struct timespec64 *to = NULL, end_time;
+	struct timespec64 *to = NULL;
 	int ret;
 
-	if (restart_block->poll.has_timeout) {
-		end_time.tv_sec = restart_block->poll.tv_sec;
-		end_time.tv_nsec = restart_block->poll.tv_nsec;
-		to = &end_time;
-	}
+	if (restart_block->poll.has_timeout)
+		to = &restart_block->poll.end_time;
 
 	ret = do_sys_poll(ufds, nfds, to);
 
@@ -1077,8 +1074,7 @@ SYSCALL_DEFINE3(poll, struct pollfd __user *, ufds, unsigned int, nfds,
 		restart_block->poll.nfds = nfds;
 
 		if (timeout_msecs >= 0) {
-			restart_block->poll.tv_sec = end_time.tv_sec;
-			restart_block->poll.tv_nsec = end_time.tv_nsec;
+			restart_block->poll.end_time = end_time;
 			restart_block->poll.has_timeout = 1;
 		} else
 			restart_block->poll.has_timeout = 0;
diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
index 67d2bf579942..9b262109726d 100644
--- a/include/linux/restart_block.h
+++ b/include/linux/restart_block.h
@@ -6,6 +6,7 @@
 #define __LINUX_RESTART_BLOCK_H
 
 #include <linux/compiler.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 
 struct __kernel_timespec;
@@ -50,8 +51,7 @@ struct restart_block {
 			struct pollfd __user *ufds;
 			int nfds;
 			int has_timeout;
-			unsigned long tv_sec;
-			unsigned long tv_nsec;
+			struct timespec64 end_time;
 		} poll;
 	};
 };

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251107-restart-block-expiration-52915454d881

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


