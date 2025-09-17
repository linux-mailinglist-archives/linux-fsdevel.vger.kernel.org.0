Return-Path: <linux-fsdevel+bounces-62050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D387B824C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 01:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F3572083D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 23:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E63128B8;
	Wed, 17 Sep 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u9X8vV3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F94312830;
	Wed, 17 Sep 2025 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758151694; cv=none; b=dIvEcFy0dC/xtGGctN8RBKrZEWGEtr+JKOzKr8YYZJwuVldqMWpSy/9pr+8SBFZma1aDCQVL7P1FqIMAvhfPSFgf8MRBMBp71yvl8gpxBBdK4RNi7Z2et5T9hZod2fJbtc1oFslRvnRIlrIH2Skxqg9T83GqwPEbDRADb/OA5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758151694; c=relaxed/simple;
	bh=/XKll5c+qsqnTvwojllXwSeICv4xLDaE9SJBOYtVd1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/SI/OfCb5kqb/VMkBfZmnzLxSUyXtao3z9eJZTwfFEcQcp+Hp0/vfggxfaTyb23QxyoBTFNHfaXbkYPTcOcy5D4WrKh8qQ+7UMlWrJs/pQmINetvc7B+m8GCiQZdaGop0wcDdFBP+wcCq+hQ/AaCTjHwrgpJzJFtLAyC1cju+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u9X8vV3s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B7EZDTd3Xyq75vW4Am5AueSjn4s60K0ngq6gL7hkvHI=; b=u9X8vV3svWkLbkRQ5kIW8+RBlb
	sBIVOGxk8ub4RsdOBSQ5z9vbW2aAg5txHboPUhVKD0Y7O7ipjCfNM0e16dNFJRgOeNYsoEDFsX2jU
	/TNvF+bKj7J8ZHEcdrEVRB1B5zvHXAA6HlGuTfrj7c7PhrB7KyFEqW9U3rFXDCrA+z7lghiv0SBDl
	9KkiGC0Xkv44JqTBmky9cwlmjiiJKbkf72E5oJ+1ayoHOwdLAAseKUsU/Bhjw16O9P2eJii9msCvL
	4jtqCBFwXCnBRgLR76azkjYd2I+54QDAZK5YPLTa1TNKRoVOMB4lx5O4sEl4ZP5IYo5KiyjKedseZ
	wJHNeGMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz1Yn-0000000Aj6X-39iO;
	Wed, 17 Sep 2025 23:27:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: v9fs@lists.linux.dev,
	miklos@szeredi.hu,
	agruenba@redhat.com,
	linux-nfs@vger.kernel.org,
	hansg@kernel.org,
	linux-cifs@vger.kernel.org
Subject: [PATCH 8/9] simplify gfs2_atomic_open()
Date: Thu, 18 Sep 2025 00:27:35 +0100
Message-ID: <20250917232736.2556586-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
References: <20250917232416.GG39973@ZenIV>
 <20250917232736.2556586-1-viro@zeniv.linux.org.uk>
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

Reviewed-by: NeilBrown <neil@brown.name>
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
2.47.3


