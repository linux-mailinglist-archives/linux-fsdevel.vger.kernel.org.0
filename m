Return-Path: <linux-fsdevel+bounces-61132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A5B556BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA2F561381
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812C33438D;
	Fri, 12 Sep 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CVCpFauk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09513009F0
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703565; cv=none; b=fADRqjfN0lzrKEhTMOH3FBgYijGD7vOiOU8aD6Mq0b+wKHDjQh8levf4PnwtorodY5pAvQiok9r6MPjy27SiFOt70A2S9Lk1z3G6vh1u+W0eHPAjDvahgxHI0RwJkcYNorY5F13PFzaf+Z27J+JqXaFhV6OtVym2k1xHklKe/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703565; c=relaxed/simple;
	bh=5mqcrfcXXLEZdj9kGHKQldzmzfxHHFlFkmkH26cZ7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqnzVDI3VuvHX8CTGRQtdJ23F9UztO2fIYRjiR6PPflGcTDcAad9SgN9e5xy1JPGWnz2dNMuXy82rb9ZSO/xpvoj//HOy7FqNhMQfYIcd/GrA1KMP2gGQ6Hqsl7Uilju/T8wY5rQZC95/4jVE37haqSCaOQsWTORQlwBngI0ClE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CVCpFauk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vJD0lDMGdbrj6ccoTSO2uVzkpxvo58Z5lv7XKiIH9/o=; b=CVCpFaukbmNW2HmTars53ezcKT
	bD1FejriockNtJU2Wzl7qcnEKFUmVKt3LqijizWrxWYzCGm8uJdzI/9F9ygzrzfKRZaoT59ILYKQA
	rhe+IYyKmVZfK3+9d54LHFM5a/xWYlRZs6ZLZPU8sfr5974S1QRiFtvJ2JVJ2Tb7dTPeM14fC4pcy
	4eb4yc32vsi6vPO9ODXNQZ4as9OBNVEPcOoJydKp6IKowaeHdlA4qrYnYnJ3L9afFB1jFRxTZpZRx
	UoTKq/eD9RdhGmFoSC/gUka9IgDp9cOCNwodgf/5oj+Eau3VNcN0Pzeqjoc4h7XWK/l9AdEFVhAIh
	BOr9ii+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zN-00000001g8S-3wlw;
	Fri, 12 Sep 2025 18:59:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 8/9] simplify gfs2_atomic_open()
Date: Fri, 12 Sep 2025 19:59:15 +0100
Message-ID: <20250912185916.400113-8-viro@zeniv.linux.org.uk>
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

the difference from 9p et.al. is that on gfs2 the lookup side might
end up opening the file.  That's what the FMODE_OPENED check there
is about - and it might actually be seen with finish_open() having
failed, if it fails late enough.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/inode.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8760e7e20c9d..8a7ed80d9f2d 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1368,27 +1368,19 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
 {
-	struct dentry *d;
 	bool excl = !!(flags & O_EXCL);
 
-	if (!d_in_lookup(dentry))
-		goto skip_lookup;
-
-	d = __gfs2_lookup(dir, dentry, file);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
-	if (d != NULL)
-		dentry = d;
-	if (d_really_is_positive(dentry)) {
-		if (!(file->f_mode & FMODE_OPENED))
+	if (d_in_lookup(dentry)) {
+		struct dentry *d = __gfs2_lookup(dir, dentry, file);
+		if (file->f_mode & FMODE_OPENED) {
+			if (IS_ERR(d))
+				return PTR_ERR(d);
+			dput(d);
+			return excl && (flags & O_CREAT) ? -EEXIST : 0;
+		}
+		if (d || d_really_is_positive(dentry))
 			return finish_no_open(file, d);
-		dput(d);
-		return excl && (flags & O_CREAT) ? -EEXIST : 0;
 	}
-
-	BUG_ON(d != NULL);
-
-skip_lookup:
 	if (!(flags & O_CREAT))
 		return -ENOENT;
 
-- 
2.47.2


