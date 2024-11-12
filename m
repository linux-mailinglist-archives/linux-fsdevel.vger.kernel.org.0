Return-Path: <linux-fsdevel+bounces-34549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91419C6289
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918E41F23846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 20:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08E219E5E;
	Tue, 12 Nov 2024 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PwgjgN9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AC21A71D
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443185; cv=none; b=rzVdb2cE+6c4qbyw3el+EGB02Lu5axxZPKY8KGYfO+lpv8w5WoWsYWW8xI9X2lJp3PvpmKEi2WG765iYPR6m6IVz/a1SDVUkYolbD+V7lY3yQEegph24/Be7gVKa65hSA/rmA1ANEy6n6ze7Cj8GY+hj0TuJ+lMFoptCpP61xSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443185; c=relaxed/simple;
	bh=eBbQowgmRYyaltJfP56R/5mfIiOkNSnubfd9QTAwXBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIgzm1D47OO6tXf4+NvSQidxVV7Uk5mUZRfqnr+tG8O9hTOdPq5M7X+L2M2MkXB2F2EeNqum2Qc3rdgSfJahFf5Yu1MVZxc8+ZncYF60/cKKPwghuMgNc5EKRvrasHcUDKNa/0jCrrVsBa/JIV/F4JJ3B4iMKGVxa2b6zIfeKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PwgjgN9O; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=05Pweewsc9NU6cGHmikuv5sL6IdmphdVakYUsTgcS2k=; b=PwgjgN9OlqIzeO+iDlGrMqBB5w
	IL4BJdhMTG8wFNp6QIJySw8vyNvz8xgPh6XPKHCUVFWrZ4GWf350AeUEaAjV65GMA5KG8BM1ZJ0hd
	bL+f5lWpcj6LNVu3Lp87PyICyaqVjVzxKIk7mj9cF+WtuumfZa03Sq9E0+bGBudG2q/8v1DmBW2DX
	dNubX8KxuyR8O+/Rl3JMg86QOkvpQ2Wib536Mi7VFfBjxT1fqGaNMdlNiSnvlGVm26tqP4ZB8cI5X
	BLpbqiaZt3K4BdSxWnAzOG9KLuh/H1azbrW93CY+ZAI9RkV3pbQCHewe9Im29ukKZVHFjElm33Sa4
	8xnAVw2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAxSw-0000000EEtb-2Ipi;
	Tue, 12 Nov 2024 20:26:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] fs/stat.c: switch to CLASS(fd_raw)
Date: Tue, 12 Nov 2024 20:25:50 +0000
Message-ID: <20241112202552.3393751-3-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
References: <20241112202118.GA3387508@ZenIV>
 <20241112202552.3393751-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... and use fd_empty() consistently

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/stat.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 4e8698fa932f..855b995ad09b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -220,15 +220,10 @@ EXPORT_SYMBOL(vfs_getattr);
  */
 int vfs_fstat(int fd, struct kstat *stat)
 {
-	struct fd f;
-	int error;
-
-	f = fdget_raw(fd);
-	if (!fd_file(f))
+	CLASS(fd_raw, f)(fd);
+	if (fd_empty(f))
 		return -EBADF;
-	error = vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
-	fdput(f);
-	return error;
+	return vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
 }
 
 static int statx_lookup_flags(int flags)
@@ -275,7 +270,7 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	CLASS(fd_raw, f)(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 	return vfs_statx_path(&fd_file(f)->f_path, flags, stat, request_mask);
 }
-- 
2.39.5


