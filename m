Return-Path: <linux-fsdevel+bounces-69284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53641C76810
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E37BA4E3009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D33019CD;
	Thu, 20 Nov 2025 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2ozhJsE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3743C27B349
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677948; cv=none; b=CdTrac6ie7h00AAnTaPMWkw3AHwXfQZ+gVdr0cU2JZ8SrQXkbwq2k7Ir6hSkuMN/GQkIf+pvqrzl7SN/PAaYTYoM0duuDIwbEZgjdrLM8nlxbaiNGlZqWwgf82d/piPovtehEc/A6v4rdtMfSyMkkANMf4ECFAyng5NshmIO/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677948; c=relaxed/simple;
	bh=5+aeo/vL4yo8kKFNZnyLH9lE/WslqrvqJJJj8RgLH+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSTmlFGkz9a6B+nzyK9LY990bGRyAzBGL/oTLLDRV9VvNTflHr34TumLuiPtVrV/yBmC1d+PvkP+6I5waxB/fJlvJgvPoMsk931kHHmmqN8wEJU8/wA9V0B9CXPRSK6ejooAj9PRvAS+KnP9ZSJpIspaRaFHeymgiIKRp9xyXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2ozhJsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2C9C116B1;
	Thu, 20 Nov 2025 22:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677947;
	bh=5+aeo/vL4yo8kKFNZnyLH9lE/WslqrvqJJJj8RgLH+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2ozhJsEcgJf3b/R2wA6tazc8OUT8PfRzJ45xpHslSoPVGCD7MnPFy+kgrSJOZwDr
	 TWV28qJU+lQi1GpiSAsblhcGl3R/VpquZaX9i02Kv+O+L7OD4VugaHnkftCl5XP2E2
	 cT304wNJ7rM2W6g8GSs+U70qzE6kYPpP+5qyuAlAZ5ytGLPwhDF2IuIMaNa8FMK9sV
	 AQ9HDwv31AV14DZEVzZs1Iidn9lrt5jbF8JYKkkRKto6jbM3k8sZoCy6pdUhSHnh6+
	 KuH6w+nnSN1AdxhZf1hafJ4eJ8ZUstlKYmgoXNS1E9MsEXfI6WIhqi+Wo79mFZ2L+j
	 pQvqSBgUIBiTg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:02 +0100
Subject: [PATCH RFC v2 05/48] namespace: convert open_tree() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-5-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5+aeo/vL4yo8kKFNZnyLH9lE/WslqrvqJJJj8RgLH+Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3szL2uu1XmPebP+e52/Gn/AaaFrNr/AefM14f98J
 xqZLzDt7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIzgJGhhWthm+ef27Kan/F
 kvL8UNysjtlvuSMuvXBdy2tvELp20mmGf/bK63KqbZOe5+248ehop9Kti90nd5TfnNT470+28On
 CPywA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..fbc4e4309bc8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3103,19 +3103,12 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
-	int fd;
-	struct file *file __free(fput) = NULL;
-
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+		return fd_publish(fdf);
+	}
 }
 
 /*

-- 
2.47.3


