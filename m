Return-Path: <linux-fsdevel+bounces-61129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF98B556B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A51D6249A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF475338F30;
	Fri, 12 Sep 2025 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ReosUFEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75417324B38
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703561; cv=none; b=FDJa2bdvpXQMVC4Excfh18Xlcbs2xHBDntbaGKkKgucWUwVlJk+2Fn5aUllQ+1IdynzS74O0JcFktCy2RnOpRxT4gBok9ORyQF/1gtJ9kvZEw4aven4MpDQZyzQGOfNZmx709yft4XnviqVJPhyHfXUNNaTgT6W/kDfs0l96QnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703561; c=relaxed/simple;
	bh=NIza92DitBgWatPdAp+xGOVqszMt8H8015n3XceK3D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0fHG9auWzUxhuCDtHRJSmbJJu2rU3D1CQbXzUJ0BVkOG2R9dVs0pw77QUHNAZz87N73s6Q0yKCb6O/Ta4Qb/eT5tcwuwRK8Sw/nI+bxN9k3JLHyCL9De0fKJs+MF4J8Fn5pV5Wxuauk7GJIz+8KLe58+GYw6/+EeJMBUH8nmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ReosUFEd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=rGQIXR1yWXc5HYyV8zgVZvOi4GCFdPRzjZKvygNevcY=; b=ReosUFEdVcy524taPcybB7wUQy
	zjvrKoKyzUHbBbOO6BnP8B9pnrfNsrGev/HdjRz9ttfua/HABGgPb/Ou6VLQobzobCE18BTJUBWSV
	biOjC86p9KP/0cg4CBdU4MgGjIUUpa4AkfCF6N9K7VPzExWTgsXdfFrLkgoZd5bF8v5QIFiQ8+zP6
	WMiBYYGttzzDNWGsKE1PRDciS0gczzLLNVWsGsbrw8fni4X/UF0I/Ebu/glv08/I2u8EOBt6dS/XD
	2/wN+GGpG0zqYGeiYSMNh2eHZdzCz2NJOyC8EiXAvww0+caPpzoZS1RzxXaOAKvkwuS3IsddCrXTb
	PvXtpszA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zN-00000001g5v-06ft;
	Fri, 12 Sep 2025 18:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 4/9] simplify cifs_atomic_open()
Date: Fri, 12 Sep 2025 19:59:11 +0100
Message-ID: <20250912185916.400113-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
References: <20250912185530.GZ39973@ZenIV>
 <20250912185916.400113-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

now that finish_no_open() does the right thing if it's given ERR_PTR() as
dentry...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/dir.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 5223edf6d11a..47710aa13822 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -484,8 +484,6 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	 * in network traffic in the other paths.
 	 */
 	if (!(oflags & O_CREAT)) {
-		struct dentry *res;
-
 		/*
 		 * Check for hashed negative dentry. We have already revalidated
 		 * the dentry and it is fine. No need to perform another lookup.
@@ -493,11 +491,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 		if (!d_in_lookup(direntry))
 			return -ENOENT;
 
-		res = cifs_lookup(inode, direntry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		return finish_no_open(file, res);
+		return finish_no_open(file, cifs_lookup(inode, direntry, 0));
 	}
 
 	xid = get_xid();
-- 
2.47.2


