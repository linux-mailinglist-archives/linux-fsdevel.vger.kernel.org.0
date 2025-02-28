Return-Path: <linux-fsdevel+bounces-42844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3129A499AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF772172F4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0B26B94B;
	Fri, 28 Feb 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dix9v1YN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9B26B2B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746662; cv=none; b=Q+sGOoHtgbCBvkD0o7fFWVJHvYocWQrC2xmddIQrGEitMLkWFct5dvBgDHH0HnIgX14UJ7Kh+0Brx0Zc8U2ZYA+xP0bgncraUyhlXf7BYtmJyp6l6ec92hM43AcJBW6HYNxX9XAHVkeXtf8eze8/35KsJtGZVK43ex/jKSyt2y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746662; c=relaxed/simple;
	bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fegAusJeoojyBa1yg5FSooQCXNWoiGtvc6rCJZOHhF4Kki4GEzkzOVcO99xO3nALyl0ioPJP2KK13LpNCMa4V/PjTrQschcQmSjGiP1XuVudD1r6yiKGuUqZxd1c5iSMQ9TqLwV9zRjhossZfzVlgvK5R5ubNAHRDdUAU8GlH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dix9v1YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A2BC4CEE9;
	Fri, 28 Feb 2025 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746662;
	bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dix9v1YN2gtfpd7d1YpedMBksV+zLJatDnvA1rPhXkTRRAkBTtQlPkz38a7WSyrfr
	 USbJDPFEOJ8EtTwqfCXEg1LVUR9kVXDrGxaG/Kh9kaNhxXZdxGTxXIMf058/nN/Ye2
	 CEDjkyNaefifcWhLp6gn/kG27mL4mrd861XfVgmNSLqYaBOjd73HlbJTSBnoq2GE/o
	 fGo/oN3fdZiG4azCi8CF+ekGi9YGBItpBcJMLlvX9eXkv6wwhWki/MCBqfpYvVe6oy
	 gZAiYfihtg1x1La5clrsrhCrVZRQ5GKyC8nZsWWMaCgm3En4xsj8JlZtijBYmQbQTw
	 jfo3zpaH+bu3w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:01 +0100
Subject: [PATCH RFC 01/10] pidfs: switch to copy_struct_to_user()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-1-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=808; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZjULMH8o08Q3tgpr2GVXRlFaT9JjnSTHHYx1rcX56Cg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL8og+VhWIPRwtXnH95fnavC8NqouVHF5X1KTJYuw
 /Lyn8vFO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSUMnI0HVCarbY41e3F2kJ
 TghoW6Bf5HPHtd33jglX4ILmJZxJBxn+R1h2e9zZ/upvhvHEz3zHajQ643a83/C9+dm/bl7L+QE
 83AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We have a helper that deals with all the required logic.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 049352f973de..aa8c8bda8c8f 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -276,10 +276,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	 * userspace knows about will be copied. If userspace provides a new
 	 * struct, only the bits that the kernel knows about will be copied.
 	 */
-	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
-		return -EFAULT;
-
-	return 0;
+	return copy_struct_to_user(uinfo, usize, &kinfo, sizeof(kinfo), NULL);
 }
 
 static bool pidfs_ioctl_valid(unsigned int cmd)

-- 
2.47.2


