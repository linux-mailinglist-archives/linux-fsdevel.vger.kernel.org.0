Return-Path: <linux-fsdevel+bounces-67011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841DC3351D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 00:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1490318C46FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B72D372D;
	Tue,  4 Nov 2025 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvFrfYpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E872604;
	Tue,  4 Nov 2025 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297554; cv=none; b=cm0hFWMnuJgZSysxbDoT4cYt7NMyG5NuTWuqKnXJ4WQK5xI+QbQjq83N7oDl686ASJsHK2uUjWgAurZU42xO7EIMXA8uEQqeCPF1XQ9lRjoIpJUDnaF4TcvXwSKyjd5GGtjaTLnn2GupJfdah7CN5H2Wtw90T8CT/nicpxJLhg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297554; c=relaxed/simple;
	bh=WCtPTfqQtVxV9hfqYB2PSFajh5C8vxNraqseQ7UsQT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qs3bl+nMGKajf1ihjfb1c8U04VYfZgCAoNE5XLuyZnVKOkoHjYwOZvO/KFyWEUdSIyHaOpgtX8W6wMy3Y8h9NUL06zH6GNlp+CG5aM9lrlAJZs9MFP5WlEYbeqNpAv7Mc2U1W2mVixd2I3WQXa8jZJFvPCPO1Cko/1NgLKMTPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvFrfYpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82776C116D0;
	Tue,  4 Nov 2025 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762297554;
	bh=WCtPTfqQtVxV9hfqYB2PSFajh5C8vxNraqseQ7UsQT8=;
	h=From:Date:Subject:To:Cc:From;
	b=BvFrfYpKupJEmVnXZbkqAK4A4TwNe6EgVFqvWg7p+c+vnkMbi1H7+1HD9uz3JMxgd
	 1lS7/PcHA+LXoZuDCcJqkS8uoP1QOJrYjSt+CEJHUUBxI2eBTobtdFysyclroiVaAJ
	 4TZyoBpdVxeisLjyFkhPVnXp8FUmu5u415JLguayLOtao4qP+wDX5DixAIrObW9/xR
	 vKLpdlZhLQzkgfF1IC9wIzBpqVLpZESLX9C7SgQgSlw4q70eEWQxJTuSf2cfFExaJe
	 LTXd4OBi/uHg1yBl6cDrjrKMt0lZ8lHA+q+95FymfERSfQHasz/rP3sAHXCZKFCurr
	 R+KW8ja0KDbyg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Nov 2025 00:05:01 +0100
Subject: [PATCH] pidfs: reduce wait_pidfd lock scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-work-pidfs-wait_pidfd-lock-v1-1-02638783be07@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJyGCmkC/yXM0QqDMAyF4VeRXC+jVYSxVxljpG2qwdFKM3Qgv
 vvqvDsfB/4NlIuwwr3ZoPAiKjlV2EsDfqQ0MEqohta0vbWmxzWXCWcJUXEl+byOGfCd/YRknQn
 dzUfbBaiBuXCU7z/+eFY7UkZXKPnxSC5Rr+e/7z9kNtZ8iAAAAA==
X-Change-ID: 20251105-work-pidfs-wait_pidfd-lock-a1b0d38cf13d
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WCtPTfqQtVxV9hfqYB2PSFajh5C8vxNraqseQ7UsQT8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRytV18kWbS+F/8n7clwz3W6K832YTTI3XeuefwRTjuK
 U0/bfa5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIylxkZ3kq/LFdLWt/Ee+r6
 hO97f9xIXLgk0u+LSsrNzwqXag5yOTIy3HQSmJUazlNn8TXa+Odb/81e87e+/sbDuNArJnHJnDk
 F3AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no need to hold the lock after we realized that pid->attr is
set. We're holding a reference to struct pid so it won't go away and
pidfs_exit() is called once per struct pid.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0ef5b47d796a..d2e74c069b4f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -613,17 +613,19 @@ void pidfs_exit(struct task_struct *tsk)
 
 	might_sleep();
 
-	guard(spinlock_irq)(&pid->wait_pidfd.lock);
-	attr = pid->attr;
-	if (!attr) {
-		/*
-		 * No one ever held a pidfd for this struct pid.
-		 * Mark it as dead so no one can add a pidfs
-		 * entry anymore. We're about to be reaped and
-		 * so no exit information would be available.
-		 */
-		pid->attr = PIDFS_PID_DEAD;
-		return;
+	/* Synchronize with pidfs_register_pid(). */
+	scoped_guard(spinlock_irq, &pid->wait_pidfd.lock) {
+		attr = pid->attr;
+		if (!attr) {
+			/*
+			 * No one ever held a pidfd for this struct pid.
+			 * Mark it as dead so no one can add a pidfs
+			 * entry anymore. We're about to be reaped and
+			 * so no exit information would be available.
+			 */
+			pid->attr = PIDFS_PID_DEAD;
+			return;
+		}
 	}
 
 	/*

---
base-commit: a20432b6571ddc02e86c549f582d61ac5a89ca40
change-id: 20251105-work-pidfs-wait_pidfd-lock-a1b0d38cf13d


