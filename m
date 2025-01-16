Return-Path: <linux-fsdevel+bounces-39366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E60AFA13276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 06:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CCD18886B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 05:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A761953A2;
	Thu, 16 Jan 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cVRjj4yA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873B156C72;
	Thu, 16 Jan 2025 05:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005003; cv=none; b=rCVd7Zdpi7gW3SwUAQGyFEAKWDCLsWCRfc/u2FTuWmA/BZYtil20xi96NgyLP8Rneb2HrKjRyO0fiCwRX8FV0fZZPTFY5i1QKBeAE9KvwGOWmnSupeWZ8cNoceanQYcuh8tIoYdP3vHxSmRKLHC9X7w5cGG9510poY/ji6TIv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005003; c=relaxed/simple;
	bh=SHs2ilSWDO/pKgcDk/TzeH6WoJeSPAPSLHBpIkfNX14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9JYAd5nERlIMGose2G5kjAv4+QoMC7RkyTduGUqrxSVjoQagUeKCgU9uR0P0vDbNhJ/Ye7hiEhbtSLWm3IGd9i0e18ZIdkPlH6+QrlwmLizT3GysdcWxVhuL7meuNsnZS2f6ktSnCnIfyrCXzW2geyMV1gu5luHb0gEwrouZl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cVRjj4yA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e09c+mh4a1QxHTNrOzqotxokwF7Jj+VLy4WQY4XpFUQ=; b=cVRjj4yALbXeWvI+icQh+A3nPF
	O9c+neGqPJ7FsJkCfOypDoAygxblhuk3gcZw7jVU0y0WgtgbnJeDKRWZOPoZfaQmtpbsFvPjifUpX
	ljZSg0MK1ZNj6+5kHepiviLyqW2d7PsxZ41XCnrfFHk0lQcFGr/ea/kEyjvW1RICCS9QKiTYRK+DT
	akvIbyl/yXr/Rb1h/6tTeRZNO89wdrGXADKD8rsVd0MWQsZX0rznkSBdU5BPbJF/ycHWHq/ug2Qwp
	kXlcUoD5I4+JbC/NFwnHiLAokPEu0WKoFvtqx+vd0ss5dw9+pjnkn01jABpHH5fAkIHRBkVlHYRS3
	zFufH4Fg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYILf-000000022HT-0jIx;
	Thu, 16 Jan 2025 05:23:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v2 12/20] exfat_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 16 Jan 2025 05:23:09 +0000
Message-ID: <20250116052317.485356-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116052317.485356-1-viro@zeniv.linux.org.uk>
References: <20250116052103.GF1977892@ZenIV>
 <20250116052317.485356-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... no need to bother with ->d_lock and ->d_parent->d_inode.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e3b4feccba07..61c7164b85b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -34,8 +34,6 @@ static inline void exfat_d_version_set(struct dentry *dentry,
 static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 			      struct dentry *dentry, unsigned int flags)
 {
-	int ret;
-
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
@@ -59,11 +57,7 @@ static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
 
-	spin_lock(&dentry->d_lock);
-	ret = inode_eq_iversion(d_inode(dentry->d_parent),
-			exfat_d_version(dentry));
-	spin_unlock(&dentry->d_lock);
-	return ret;
+	return inode_eq_iversion(dir, exfat_d_version(dentry));
 }
 
 /* returns the length of a struct qstr, ignoring trailing dots if necessary */
-- 
2.39.5


