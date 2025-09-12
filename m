Return-Path: <linux-fsdevel+bounces-61127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D8B556B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CD3178CCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D683375B4;
	Fri, 12 Sep 2025 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="I3ojSNgh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF2334363
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703560; cv=none; b=jVjSPLcFjGXgIWO8jY/3Nc14pFlKHb9IvCbD6/So6bRGfO6cvxyNOrPFCfUO1CNkiB8Tt7s/QiZuNIe0nUK1B98TasZzm9oP2KX3FxZO23CZT4B/dgeJkcJx8pXvk9Ufl787EKf1brEhF/5XYwwzF2mcf4XWgCm3J5El/XkBXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703560; c=relaxed/simple;
	bh=rDUDS+SnYVLz9N16kjXKp71xjy3paCkHVW6Xndu0vbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltdhbk1YFG8ZgEIIxPNfV6Jq8OyjoT0wFXfExLqlmVBOyMvvDP8wKbwmo8zphiG7WKM72E+Flk5+WInybcLe1BJIH78oCcD8daCUilsreTWaLGGQIJysYldWpnT35fjwXcxzMYtdI21JWI9RZ0RiTNfWXKPBFlWaGYZXE/xw+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=I3ojSNgh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Knp9XdScAgEy0N7rowcbWv1Usg6r9Ym+huHfkR+ISmc=; b=I3ojSNghPSgN7XbaEfYGjxcatn
	xw0PRhmTsGXQulfk2/vI4ChS0kpB0eKKMaj2XQXGGQkguz2tNG8YJ7JLQPdIopxbh7KPV4BlRcYrZ
	u2fVQwOEuDXGsw0SwWaTO5Qyv0qpXdbR85kWUATXieuJTYyFmSmLwZuoAGNwiztsUpgb9f23kemUj
	GxCg0SzEXqhlwazRrG2sNA2CxDDApS9bKptS+PlsVI8aI4r0JBkwQZ8b3Mdibo74V0JQYsXgs+o3+
	9iiaSrPL7W033oblZQVoz7BsQqFxZfOjYV9jEvdFAHFIPgitOhovPIb27Qr3WQXdUwryPGghtPTyI
	PETW5EKA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zN-00000001g69-1N2m;
	Fri, 12 Sep 2025 18:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 6/9] simplify nfs_atomic_open_v23()
Date: Fri, 12 Sep 2025 19:59:13 +0100
Message-ID: <20250912185916.400113-6-viro@zeniv.linux.org.uk>
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

1) finish_no_open() takes ERR_PTR() as dentry now.
2) caller of ->atomic_open() will call d_lookup_done() itself, no
need to do it here.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/dir.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..c8dd1d0b8d85 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2260,7 +2260,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 			struct file *file, unsigned int open_flags,
 			umode_t mode)
 {
-
+	struct dentry *res = NULL;
 	/* Same as look+open from lookup_open(), but with different O_TRUNC
 	 * handling.
 	 */
@@ -2275,21 +2275,15 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 		if (error)
 			return error;
 		return finish_open(file, dentry, NULL);
-	} else if (d_in_lookup(dentry)) {
+	}
+	if (d_in_lookup(dentry)) {
 		/* The only flags nfs_lookup considers are
 		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
 		 * we want those to be zero so the lookup isn't skipped.
 		 */
-		struct dentry *res = nfs_lookup(dir, dentry, 0);
-
-		d_lookup_done(dentry);
-		if (unlikely(res)) {
-			if (IS_ERR(res))
-				return PTR_ERR(res);
-			return finish_no_open(file, res);
-		}
+		res = nfs_lookup(dir, dentry, 0);
 	}
-	return finish_no_open(file, NULL);
+	return finish_no_open(file, res);
 
 }
 EXPORT_SYMBOL_GPL(nfs_atomic_open_v23);
-- 
2.47.2


