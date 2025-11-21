Return-Path: <linux-fsdevel+bounces-69403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BD761C7B2EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E0DE4EEABB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CB8350A32;
	Fri, 21 Nov 2025 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlUqwgPB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DD34846A
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748062; cv=none; b=rdU6vS4DkBNiLcHmnBUs8wcg74hSrsE+OAJm0YdjIEpXHyRgTbIiETtrC3gIb3bA6Bm+gi1HHVg7q/BMwJgiKLIeKAx33LuYB7PQpEZPcrchR9M9/wEGHHDU2RsIsUMjf0q2UlRLOfj1gC8d3oPAQaGyUtYQrkRz5BQETFHAzSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748062; c=relaxed/simple;
	bh=KR9/S0QdXz7V2KSpqcnWHNkJhZgc6bEukDF+0Jsr0qA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sjNK3V//Zs7AHotLYuk6+8UhOikuqkcznxgU3GLf2Sgi9hjH5t0axkcSJy7Fk8xVJIjLhct6jQkd7Ej8UDjCl0WMZ1zPnw2fMrT34d7t3am0q8S2Ww6l25RA1NLheeAjVtCFl0eOj2H5mLI3dnf45PA7+cb5ifOAftrJI7uzuz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlUqwgPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CB3C16AAE;
	Fri, 21 Nov 2025 18:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748062;
	bh=KR9/S0QdXz7V2KSpqcnWHNkJhZgc6bEukDF+0Jsr0qA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SlUqwgPB2iQTLENHr0ImXobl0Wc1GcSy7zGsRUGWyvUGg8a/V3ZB06Muz+Tg38kY5
	 TsQAdLqmO7L4iEY4ZBTijLrFq0xCfO4mnDAc/48lxm8TVqD5VF+H8KoceFm6gTxrgw
	 i/IlQM2u1sK3DxoPD0dB8LqktTCENR5P3eADWz5Yl35khNE12q/OdtgwW0b7AjoDad
	 Rv70lc1DuYqjtfH2X8kVb6+VvOHV25yiPla87IRMXOuVuB8pmQz0IHiT6cOWxWaC4N
	 ni0+Xatn5eZydQfsLOsrF+5JOvzMIVCFStpN3xFq2l+xoTjZKhguLBANnWwsLXSQXM
	 fbIbY55htznDg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:00:44 +0100
Subject: [PATCH RFC v3 05/47] namespace: convert open_tree() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-5-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KR9/S0QdXz7V2KSpqcnWHNkJhZgc6bEukDF+0Jsr0qA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrDhvtmPinJm7t6RZSEY97Dj7tolH3G5G1v3vrP8em
 C/uNt5d2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRqZ0M/8s/unDKRl7daJzo
 VWj/o0Iu72LG1VPuO2sEsuW3yL74t5CRod95qYt9U91lpk0iLX5Mn568rv4SdprZpe9lv1tQjlY
 kAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..cff0fdc27fda 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3103,19 +3103,14 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
-	int fd;
-	struct file *file __free(fput) = NULL;
-
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	int ret;
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
 
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return fd_publish(fdf);
 }
 
 /*

-- 
2.47.3


