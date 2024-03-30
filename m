Return-Path: <linux-fsdevel+bounces-15746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670D892882
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D251F220FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E045D197;
	Sat, 30 Mar 2024 00:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2GSdj3b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35B15CB;
	Sat, 30 Mar 2024 00:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760232; cv=none; b=JUAdRnGW3U7MiI9ci0oinBwLbWeDp0DGnDqs36YDYHjJqewNNZuMRMDRuhOIOkQMEU7iQG8wznYNVDpYcQy9P0zjtDVsPBSrr8/JdFp+RpaYJNj1jGbuvWCmWEf0f65sGpka1UOWXniGB+ULrsxt+gAmXn/T7Mk//CVJ+b5hYSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760232; c=relaxed/simple;
	bh=fWF/GOrEFq92DLREoy1D7sjTCgpcyZGH/3/RhOMHjn8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbNDdHUlZdiQsoSF1K+rO3IIjuJkHS2+E9ZSyst7fyf8W78fsRXyCTJICF+gdezGnRSHe/ydEyi3eCT2pI2LD6VGauGQdyTVN7tSXzCtXlP21u8jPaTqAiQaoYs+Vc0n0R9AzRTT8L7ZI0Mi1u3uG+lFd13NoPRd/m+McKd8yZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2GSdj3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6609C433C7;
	Sat, 30 Mar 2024 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760231;
	bh=fWF/GOrEFq92DLREoy1D7sjTCgpcyZGH/3/RhOMHjn8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=G2GSdj3bsEms9Sw7ZsnoX7cRNRsRarnFHRHYjsG4cPu8qB19yyB4ZO0N7PMxAp7CV
	 tDTbWFaED+FWgfc+brMTOAmylnahw6hrEh7MTbdV0CqXLwYTyaPdyUN0CriE69FFlO
	 XgxBOQEcSqHR9R1F8SNDazjpMn3Tkj2EVwPyM9E241Y/ep6YLOicJi4gnYI37E2sgv
	 ArO/A2UROBA17ynlgbNSxQaE5hkFgkvzsbdKJkF+QLuxdtOifYhGkS6gYugZMfoXDC
	 xPsY0Ol2k8eUUjlVO7qy7U9TmqxAbKYqq4yz1iK3eJA44hYSM3GhkJbl2CravD51ne
	 3kFBjRnVXH6Bg==
Date: Fri, 29 Mar 2024 17:57:11 -0700
Subject: [PATCH 01/14] vfs: export remap and write check helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-xfs@vger.kernel.org
Message-ID: <171176018692.2014991.9057903191389511791.stgit@frogsfrogsfrogs>
In-Reply-To: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
References: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Export these functions so that the next patch can use them to check the
file ranges being passed to the XFS_IOC_EXCHANGE_RANGE operation.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c    |    1 +
 fs/remap_range.c   |    4 ++--
 include/linux/fs.h |    1 +
 3 files changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c3..85c096f2c0d06 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1667,6 +1667,7 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(generic_write_check_limits);
 
 /* Like generic_write_checks(), but takes size of write instead of iter. */
 int generic_write_checks_count(struct kiocb *iocb, loff_t *count)
diff --git a/fs/remap_range.c b/fs/remap_range.c
index de07f978ce3eb..28246dfc84851 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -99,8 +99,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 	return 0;
 }
 
-static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
-			     bool write)
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write)
 {
 	int mask = write ? MAY_WRITE : MAY_READ;
 	loff_t tmp;
@@ -118,6 +117,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 
 	return fsnotify_file_area_perm(file, mask, &pos, len);
 }
+EXPORT_SYMBOL_GPL(remap_verify_area);
 
 /*
  * Ensure that we don't remap a partial EOF block in the middle of something
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0f..9cbec9750d86b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2117,6 +2117,7 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,


