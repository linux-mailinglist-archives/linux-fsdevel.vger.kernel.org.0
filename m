Return-Path: <linux-fsdevel+bounces-15372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E388D3FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 02:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC752C22C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 01:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE01CFA9;
	Wed, 27 Mar 2024 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPafyMyB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5254618C36;
	Wed, 27 Mar 2024 01:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711504386; cv=none; b=NLKDF+9GNXaiuqyrSBX8G6sbZ22tqgtG6LouMaPteln524BlQKsDQHw9oE05HkkFYa0+f0E8gLhsZRIS3NnnN1ymhUDEmlWgP26clsooN4Dq1BdVna3L3izI67DJvpXfEnhyljgtC3aNkuUhz0zxg3aAG4+NKZBMq3t8who68ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711504386; c=relaxed/simple;
	bh=fWF/GOrEFq92DLREoy1D7sjTCgpcyZGH/3/RhOMHjn8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmpMixhAuLH6p+ybuvfyTghD8K9uCLJvFSP3TgnqgRCh1UWjVGMU0ArWBeilh1hLNAJVj+e6qKInwIbTf1nn6aod1HKmQoP0JH6arssBx5/2ifuQ69kLNeFNo0moeChd0Vo9hopAa9j4kfaCNNbRemnOel7nAY6P5pHVFMdf50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPafyMyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22025C433B2;
	Wed, 27 Mar 2024 01:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711504386;
	bh=fWF/GOrEFq92DLREoy1D7sjTCgpcyZGH/3/RhOMHjn8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XPafyMyB6m79tKnMzD6Tr8yT8RAJvzYNSW51eZ6BGHpIoIp/F4gR/hiKPh5Cx3C/U
	 evMxGpF3Yp0Xrm6LdQVAjDkeSpkw3BvI7UC2yhINlTChI/kaFcPNEbQul0AXRDgtyU
	 7+2DeeGmeYjy+YO/STH1hyn8GFN8h30vCUw9otpCoAHz81GHxB+kn4snTw/H+SaUsp
	 VicBRSKxAv2L5CmkG9ERX66Q0+tSeFVUlHF3EUnk9NxJ2MJWP/rC14crAQr3yvkGPm
	 RE0Knw/Ezm5t11do7RIvruVR3SM3gRAkNgvGfL56PSSNqVWcewfX+Arvtz/xxakTTF
	 XaViuG3AR2hmQ==
Date: Tue, 26 Mar 2024 18:53:05 -0700
Subject: [PATCH 01/15] vfs: export remap and write check helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171150380682.3216674.8890477329517035702.stgit@frogsfrogsfrogs>
In-Reply-To: <171150380628.3216674.10385855831925961243.stgit@frogsfrogsfrogs>
References: <171150380628.3216674.10385855831925961243.stgit@frogsfrogsfrogs>
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


