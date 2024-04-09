Return-Path: <linux-fsdevel+bounces-16392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94C89D11A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EC72860B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0796FE06;
	Tue,  9 Apr 2024 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5+kbjLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACA96A8AD;
	Tue,  9 Apr 2024 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633687; cv=none; b=SGqH14B6z71u0inI8ZWL0FJWYFjsBDqhfi4cBK/5EjPivFqTNvfPz1ykanNlanEr9oEQgQF2Ia7nKUxvtgzjC8AKekqEsEj4Mup7VSMh6OF+BN9E9leaZOsjOvnNAelSn5qq5jWLJopw0U4yUCD1ocXCVMVLq/bo1c67B82YjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633687; c=relaxed/simple;
	bh=xbcoifa+4Xv/ZiQQ+S6FWREb3ShQ5oUXGuyIDZJs1K0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NveYMz6r2J54AWHIyapWAQ2Rou6kdK1fYGPLi+6tVORm+Ivk26dsiECJxu9LnwJ50Dt1W2BTUFuEqnK/eSGyidpqPJz4uCIzUlT1KvqWE6+/O8BRA6YD8D3Ih7MVU1+gxGn7qsD8NOKsHh5UzA+9YCWgsWoHEvYdFqp0OTdZCFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5+kbjLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5C6C433C7;
	Tue,  9 Apr 2024 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633686;
	bh=xbcoifa+4Xv/ZiQQ+S6FWREb3ShQ5oUXGuyIDZJs1K0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Y5+kbjLXu7yEkMRWZuHe3CGDBSVF/Tq5uD5aV1sTmR/0hPZ9EHvJQ7js+qlaS5m5O
	 fj3+8CcZwdJz/6Jd/zaSbeseRghF+CjuY2BgOwXCZ8V278gnUN1eQk+4XI4GeLtAus
	 hM5T/qErPpTKfU/+lkJ8Ry3x0ZIlLaYoYSN7yc+9IydKnORHgRcCB+2YhHo97OmjYm
	 jhHG5e+GCJMxZVWfxqanmjKOStOhafn2Yo6Oy+54VHfQcG3N57AxCJKMYDQK2uruBm
	 XkiqCCQBDrKpWHc6nHvclSzJufW0x+o93qHsIqCZIxIX3qBP0ZVkVkKEoJT9IZmgu4
	 ha8ASINUlzQzg==
Date: Mon, 08 Apr 2024 20:34:46 -0700
Subject: [PATCH 01/14] vfs: export remap and write check helpers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, hch@lst.de,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <171263348478.2978056.8704924456828804175.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
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
index 8dfd53b52744a..0835faeebe7b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2119,6 +2119,7 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+int remap_verify_area(struct file *file, loff_t pos, loff_t len, bool write);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,


