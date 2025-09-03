Return-Path: <linux-fsdevel+bounces-60100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92601B413FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C14C188E1E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37F92D5930;
	Wed,  3 Sep 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uS91RJzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D2E2D839E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875352; cv=none; b=BcYHEgfraoEIzZ7iiooqfHos8hyX/2I9p7l++HIHKIKe3qaAH/TIjpYCya8SrvGLYB8ZKTgr7LLJdadwdN0SRnKATLURfO3ox9Ojhz9cgNjwGB5ITTs/e/sdQ6JrGGphounNfrYWKfWfv7XHNamzoBlNsPe9CSy+Ic9UtSOaoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875352; c=relaxed/simple;
	bh=vrZsRpIj+Q+lRihn/B5CU6jO0r/JOVF5GMXbjzkfv5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tvmfh9ezegICIDYp161QD7XNAXhJJqsRRmri/AoyB0TOmVsQkKKeqiz/iHZjG6yZ/H84Zfy8uS+2pXjOJPvckHLpjQcUBSGp2EspY4V/bPHAEYEm1SKUJUyCxBfp+bEjM5OKZgfGL2QaKU5Jzv5HE7Zn84Rzu5DdGwdIH2HWF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uS91RJzU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2FywFsj0XV2uWtuKs+ZHHjaXQxcvN5pbNgRIxz+MGoc=; b=uS91RJzUvk64AXXuyqZG917FSD
	YRmllak5o2RZxojzN8uPHa/gtb7EKiwKZ58HxDfR4XKMmQKL+4AGd/mrLvnfEmk+FJaeORB3gn4dX
	TW+KemATZ6Hzhi5Q2OKDs0Y9RMGfZK1ZMM9gw24QSt9FIXXuXhPpW/A5afBoA5/Ice6Q6AuNzeh7h
	+IUiCxp7r+y2JPLWFNCqcfr/0TUEh36xaJEBSUjXQxRa5Mm/FIL9/fAnMqDlJPAao1KfcWqyqrW7g
	5rBZbZSUCI6kXzwktJM4VeR3lxH1+2qBv1jdEoBdZVHW4a81wSAQATFLm0O02tFgS4SbPWNJZvBAp
	L89SLRvA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXB-0000000ApGq-1UvX;
	Wed, 03 Sep 2025 04:55:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 55/65] open_detached_copy(): don't bother with mount_lock_hash()
Date: Wed,  3 Sep 2025 05:55:18 +0100
Message-ID: <20250903045537.2579614-57-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we are holding namespace_sem and a reference to root of tree;
iterating through that tree does not need mount_lock.  Neither
does the insertion into the rbtree of new namespace or incrementing
the mount count of that namespace.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a195e25a5d61..69ef608b8c3a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3086,14 +3086,12 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		return ERR_CAST(mnt);
 	}
 
-	lock_mount_hash();
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		mnt_add_to_ns(ns, p);
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
 	mntget(&mnt->mnt);
-	unlock_mount_hash();
 	namespace_unlock();
 
 	mntput(path->mnt);
-- 
2.47.2


