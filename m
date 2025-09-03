Return-Path: <linux-fsdevel+bounces-60055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0ABB413C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94EB1640AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223FF2D6E70;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lD6DLqjc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684E2D4B6D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=Vy9TsSA6l1/6ubweBaI5M+VDZ2+1He8taR1agOItwfJYrIq7WIhrbdutFWpJr6yrm+JVVCJdapAAxdNiQ4tF40dhnnjzmUHgFnwgbJXl4Sr/kRFpSTyFa9k8rC1P63DHHfAxplErJ5mNVxWzYLo5U/Dthv1UgWJgOr3/M3Ddglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=yfJSbHWfy5kIEWgbaNqZUiCVeuubH/AYDBvwPtChjuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohIymfcv8gNL0znwLqCb1tT8WN69ouSAITk4utoGTj7RlHg9UxR4ddYRsCcNfP71NrvTPtkkcOuTXwxnWe5AIy0lRYGeHvRjdYT/rMZUOrMaCTDTR2X5XaK7AQs+IbHIz4a/LkdIkObsilIbGpUA4HM2EmWHaMZrAYnPxo9quwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lD6DLqjc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KEr+v7id3BjFs8cnQzjxngLZ6fe9XJ0LatFW/PEis+Q=; b=lD6DLqjcPNv1fCvDFqgT6wBU1k
	rxkIkIz0lFzGjy14bzP3fr+WlYZwW/gpqbP/ReTVtTsr92xfIXKUn65ZhZej//cliAY4wFfCm0JTD
	CAHSHLzD/N8Yr9/1zjhjB/KBDhbkVh0khcR3fDmIrX90HqSFJNS7AaTZcBTU1s8uLJwAF25xcwaVM
	v1IlEzFb/cuaWvYjwt9P0rlo3MprqBG/egEoZAqAhbqVn2NMFZSZEIjSvbxmKMCocwuW6p18kWFdS
	ebWeEtoeaCMbN05NoUaa98mFQLU9RrNfmcfeOpVU85yxtKKQfpDFcxugXz2T5lHBGCcBd6Zh0Ax2M
	FOPHebfA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7O-1uSa;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 13/65] has_locked_children(): use guards
Date: Wed,  3 Sep 2025 05:54:34 +0100
Message-ID: <20250903045537.2579614-13-viro@zeniv.linux.org.uk>
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

... and document the locking requirements of __has_locked_children()

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 59948cbf9c47..2cb3cb8307ca 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2373,6 +2373,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 	}
 }
 
+/* locks: namespace_shared && pinned(mnt) || mount_locked_reader */
 static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
@@ -2389,12 +2390,8 @@ static bool __has_locked_children(struct mount *mnt, struct dentry *dentry)
 
 bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
-	bool res;
-
-	read_seqlock_excl(&mount_lock);
-	res = __has_locked_children(mnt, dentry);
-	read_sequnlock_excl(&mount_lock);
-	return res;
+	guard(mount_locked_reader)();
+	return __has_locked_children(mnt, dentry);
 }
 
 /*
-- 
2.47.2


