Return-Path: <linux-fsdevel+bounces-51680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93928ADA09A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 04:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453201718EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Jun 2025 02:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69E288AD;
	Sun, 15 Jun 2025 02:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="R1zSz7Ut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EEE136E
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jun 2025 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749953012; cv=none; b=Bxz64WLxj8A/zKDoaJX6swq3LAaC0xR7OuoaecPYXqxV+YjmKAV6+oTXfMroCwsl7E+ARfUrLXKGhvy99VbTodZr/RrlSipnKII0wLoubHs370LP/00lX8RDw6VtZma/kNbI3DiPKtyoJQtj211SHB5KbhVNe4pXXs78hhBlTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749953012; c=relaxed/simple;
	bh=GcEgY3H4ZvSrgk1sCaacl944cBB3XUvLLMbBugyviz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz3Oovxy+o8UEeT85fQeG4D2LlP4MvODBkx7ud9YN/owlwhzt9shgeWcX9qhiTRRUUnQ7FTKTmomCngEfE3Ghw/1i32lw5ZaSIXVQikIPiJcMGNz5RtMRe4ZSLMRugLA4dOvg79uncZwDyHH3yTJmUJ3eLR8vaYxvQW1kqk5600=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=R1zSz7Ut; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VjdbcAKu8nxaQtxEO+5xxutXvxIABoYCEbk7m2dcuLs=; b=R1zSz7UtXjND6qZG1kGY0w2dBD
	mBVRUkUxquWwlP/hTZiS3nKLCeedwHaANSaB4UkiiSLswf1rr/uDy9NW8FHRiuE1l7ySMfhfAjp6W
	GzQolrxVTS83faksi5JVYndky46csE9qUeDJgbK4mW7Y5rFTurcCM74btoDNZIooKdH9OcF6Y5qd5
	mksNn3wJaGsX+Y8QtAttXntWyjIDANpjwZA8uXqDhfy2jxYZwXKslnsKAmh7q1Dj9ElKYO6qtaceS
	C6SL/Z3h7LXNAl5+atoV5Fge02HUWfzP4Hbb/HKMX97D5BV5l44q3rFxdvmICBLZcZ1OzNsOAbF94
	QpwHdebA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQciV-0000000DX7E-30f5;
	Sun, 15 Jun 2025 02:03:28 +0000
Date: Sun, 15 Jun 2025 03:03:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] binder_ioctl_write_read(): simplify control flow a bit
Message-ID: <20250615020327.GF1880847@ZenIV>
References: <20250615003011.GD1880847@ZenIV>
 <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615003216.GB3011112@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

[don't really care which tree that goes through; right now it's
in viro/vfs.git #work.misc, but if somebody prefers to grab it
through a different tree, just say so]
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/android/binder.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c463ca4a8fff..b00187ba273f 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5384,10 +5384,9 @@ static int binder_ioctl_write_read(struct file *filp, unsigned long arg,
 	void __user *ubuf = (void __user *)arg;
 	struct binder_write_read bwr;
 
-	if (copy_from_user(&bwr, ubuf, sizeof(bwr))) {
-		ret = -EFAULT;
-		goto out;
-	}
+	if (copy_from_user(&bwr, ubuf, sizeof(bwr)))
+		return -EFAULT;
+
 	binder_debug(BINDER_DEBUG_READ_WRITE,
 		     "%d:%d write %lld at %016llx, read %lld at %016llx\n",
 		     proc->pid, thread->pid,
@@ -5402,8 +5401,6 @@ static int binder_ioctl_write_read(struct file *filp, unsigned long arg,
 		trace_binder_write_done(ret);
 		if (ret < 0) {
 			bwr.read_consumed = 0;
-			if (copy_to_user(ubuf, &bwr, sizeof(bwr)))
-				ret = -EFAULT;
 			goto out;
 		}
 	}
@@ -5417,22 +5414,17 @@ static int binder_ioctl_write_read(struct file *filp, unsigned long arg,
 		if (!binder_worklist_empty_ilocked(&proc->todo))
 			binder_wakeup_proc_ilocked(proc);
 		binder_inner_proc_unlock(proc);
-		if (ret < 0) {
-			if (copy_to_user(ubuf, &bwr, sizeof(bwr)))
-				ret = -EFAULT;
+		if (ret < 0)
 			goto out;
-		}
 	}
 	binder_debug(BINDER_DEBUG_READ_WRITE,
 		     "%d:%d wrote %lld of %lld, read return %lld of %lld\n",
 		     proc->pid, thread->pid,
 		     (u64)bwr.write_consumed, (u64)bwr.write_size,
 		     (u64)bwr.read_consumed, (u64)bwr.read_size);
-	if (copy_to_user(ubuf, &bwr, sizeof(bwr))) {
-		ret = -EFAULT;
-		goto out;
-	}
 out:
+	if (copy_to_user(ubuf, &bwr, sizeof(bwr)))
+		ret = -EFAULT;
 	return ret;
 }
 
-- 
2.39.5


