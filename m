Return-Path: <linux-fsdevel+bounces-56748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C6B1B388
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB43BE89F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B7270ECF;
	Tue,  5 Aug 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JNCaIIl8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ihefQX9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21817BA9;
	Tue,  5 Aug 2025 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397495; cv=none; b=sa2aMK6tYQVwpgrD0/9sOYxhTWcdTRATaBObMBfiBQzCw1oZx/qkGYUu8lHdiTV5nOkOGK2NMexOmhK/CS9Vhr3kt+gO/GnDYCU3Yr/mPSPCZxwIuyMcVLfzkKI0qsvglYQLqPHc6AviBKRiWTWqdPTVOFmf0Nex9aezkxFuYfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397495; c=relaxed/simple;
	bh=8d8QMvUVqhaWfclFa0wycXMMw4PtuHHIiX4zoK+9ULg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SwqvDu1ocQJOFcDwqzhgK6KpOJmYgeWvIFv3e5tR5Vbav+VlVJzUWy2iumTuL6IFaONbDEqSAWSa6WqrLDpKglWpqRwQjEg/I+mOlTn/7VaSAfPZcBs9qk159sH4ydXBUJz3HLxS/YjO939oxUlpZorTbi3miSbmaFvsG6Lo5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JNCaIIl8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ihefQX9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754397492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCjfpwBcN4N8qmMi1Ar7HuQgM20TOs1AcGFBtHVLexA=;
	b=JNCaIIl8aFl3gkzVhv6d9DrGjyV/nznAukxAA0r78zen6yRP3UO3LsfGN3rafl8RV2RXgp
	Avjxiwjgl5t2xIqFVyqmgUSPsAUVznt214irOQ4m22s7ei3mq1qjxuuttmA6JkYp1qUlj4
	i9WTq8A9Zfrx4XN1L9T5fpn61Oap9QLhnMwy93nc8512u4CBJqbAJ411E3apUdzVcc9efW
	rdozwGR+XipjPCYlXLS92eW3bxBFquqqIp7XL25zNqw+5zDyZ0nBZPW2cGkN9Gm8gj33zQ
	tfsF4gNV67mct7gcEG4Cq3fYE6paijkJCiHb9uwOakVAvhsFjdRa4tOtUemB9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754397492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yCjfpwBcN4N8qmMi1Ar7HuQgM20TOs1AcGFBtHVLexA=;
	b=ihefQX9GohRoxTQlTGxil8zuYy43oISzbixFSQH/MP994gd0HBe9Es7sF9nFuC4is/B6Xh
	eEOVewrBZKu5GsCw==
Date: Tue, 05 Aug 2025 14:38:08 +0200
Subject: [PATCH v3] fs: always return zero on success from replace_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-fix-receive_fd_replace-v3-1-b72ba8b34bac@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAC/7kWgC/4XNwQqDMAyA4VeRntfRVq26095jDNEmzoBUaV1xi
 O++6mkMxo5/SL6szKMj9OySrMxhIE+jjZGeEmb6xj6QE8RmSqhclELyjhbu0CAFrDuoHU5DY5A
 XHUBuUOepAhaPJ4dx84Bv99g9+Xl0r+NPkPv0LxkklxwyDVoIU2SgrwPZ5+xGS8sZkO1sUJ9U9
 pNSkULTqtIUbSVV9U1t2/YGFM3nbgsBAAA=
X-Change-ID: 20250801-fix-receive_fd_replace-7fdd5ce6532d
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754397489; l=2030;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=8d8QMvUVqhaWfclFa0wycXMMw4PtuHHIiX4zoK+9ULg=;
 b=/U+Zxpala7BBX6WPjvitGPYhWuQXsy1CfdLQXUReBrWLKcx8VqNK8MjvbQvwhhvgQHFXrCT43
 vBU/ws35HBFBBID/DSrEHQcqLyQB7fpYMgg5yjhjjvLrCjfzfNdsD2Z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

replace_fd() returns the number of the new file descriptor through the
return value of do_dup2(). However its callers never care about the
specific returned number. In fact the caller in receive_fd_replace() treats
any non-zero return value as an error and therefore never calls
__receive_sock() for most file descriptors, which is a bug.

To fix the bug in receive_fd_replace() and to avoid the same issue
happening in future callers, signal success through a plain zero.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/lkml/20250801220215.GS222315@ZenIV/
Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v3:
- Make commit message slightly more precise
- Avoid double-unlock of file_lock
- Link to v2: https://lore.kernel.org/r/20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de

Changes in v2:
- Move the fix to replace_fd() (Al)
- Link to v1: https://lore.kernel.org/r/20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de
---
Untested, it stuck out while reading the code.
---
 fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 6d2275c3be9c6967d16c75d1b6521f9b58980926..80957d0813db5946ba8a635520e8283c722982b9 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1330,7 +1330,8 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	err = do_dup2(files, file, fd, flags);
+	return err < 0 ? err : 0;
 
 out_unlock:
 	spin_unlock(&files->file_lock);

---
base-commit: d2eedaa3909be9102d648a4a0a50ccf64f96c54f
change-id: 20250801-fix-receive_fd_replace-7fdd5ce6532d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


