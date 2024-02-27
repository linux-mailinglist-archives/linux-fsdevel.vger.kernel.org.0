Return-Path: <linux-fsdevel+bounces-12915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B598686D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 03:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A6E1F21AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4A1D54A;
	Tue, 27 Feb 2024 02:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGbPVaKB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960DD107A9;
	Tue, 27 Feb 2024 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000468; cv=none; b=EYz/X4cGSDkmY5mvRUM1SYZ9MYCl0xpgT7j9H1N3AV0aoFO+1Q/Q5WhannAGAjaBF/nIM3yIkwD5boxH6b91+HyTF5qe+xAo+m547bjVmqmdtJe2ivqWtaCE/U7PdIw4xETLL42pDSxWob8PHXsAPba+gNSUJ0MjhMQ3OCYaOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000468; c=relaxed/simple;
	bh=Y6hXzQX8NCAmy+7lnxYgLm0zTK3JfgZyk8RhlT8AXms=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnBF3UoMDrdQtFIeduXyXrxislfKsUfHCn85Fbv8qUPffQpEgA5Db0pFbpgj+k2EXBegmmWZyapGhyReA6LhLZY3h/sbRxPdcvAzewRgqlV+grcJ0bsiSNDFmqIS/AjretZWNmrLLXYmpj+9Rzcp16hfR68FSZV7OJ+YuJVteD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGbPVaKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A23C43390;
	Tue, 27 Feb 2024 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709000468;
	bh=Y6hXzQX8NCAmy+7lnxYgLm0zTK3JfgZyk8RhlT8AXms=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UGbPVaKBkU670AYQaxp79O1lT8uOLrEFUzC+j/Dj+8W58Im2ylEweYMfup7cT4iuY
	 ye0sg7/H5mVGeUKJwm76WWJpcRDZmYUo9Yfp1fxXyPDlrTe6/Xp0NliqlJXZXYfN7D
	 mSftbge/eZyuDVOYEVyohkG9aqMedeh8aFosNwhyN3AorYzRzdKZe7tb+aUvXtHcwv
	 ghcZwsoAx8526unPfSJZvBd+D1Aw4DxGHvjHoKnqGcJ75Qk3rs1BAjqnm/b2xvVp4a
	 kh88YZ/QPviG0SWAQwV71cHCYr7I1k/BvSolp6+KMmrYrXcJ1Ajz6Tw7vN2o4pJiQ/
	 2BxFQ82YdP2PA==
Date: Mon, 26 Feb 2024 18:21:07 -0800
Subject: [PATCH 01/14] vfs: export remap and write check helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de
Message-ID: <170900011656.938268.17556267059591974055.stgit@frogsfrogsfrogs>
In-Reply-To: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs>
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
index 1fbc72c5f112c..f0ada316dc97b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2096,6 +2096,7 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,


