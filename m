Return-Path: <linux-fsdevel+bounces-60430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1AEB46A90
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAEB565B6F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Sep 2025 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562C22D0618;
	Sat,  6 Sep 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jblRYD9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74802882A8
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Sep 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757149903; cv=none; b=jKuW4Me4o877TSrB4zKaLFSM68+Jyjm+ewrZRk7Ajc69Gg65Wkhr4TnlWNFwQxsE/IQTTy+a/PWOBC08EBFBSJESnaadZDQChxHlbtKrBKuwlVkXeSVXCoPMrO5NdfHDMC7CHiSpe0SbsP7QpOoeBqIV9rQANzoPg+QbXCUPO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757149903; c=relaxed/simple;
	bh=5l+mai61GvCXo+4U63DMK1b1ugJqM9BrEqGvq1FiyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs74IS0rYpb2jRJJPOWo0oVVhpoXib4VP05xPYmxLavhcwD+74/LYizgfhTccTsfoZwbOSPTHsmcKdwl7u4Usnq/ZtWhh5vliBi6Hm1c8/Skc8d0njm/J4DRq6CKvvL3OG2tCz3BHwDOnigJ2o+gEtsSlNushJXInSQAWUbNMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jblRYD9y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ybK2+ugDO7Ag9LQWDIuIladHWm2X2XOUDP2feGHBR+o=; b=jblRYD9ysAmPJke/VbWiqb+krI
	woH5zzj04hHrLG/EGDCDMooR2M3VCKzHc+MzwgUDfIzU0/NFZ4D2ubLxwMNOb6TnxtCpDn9XdQdgQ
	YmNzcgQQhN35Cdl+pzO5aO/ZN9+nKdygw99XYAszlD8t73Q66E8bY08bh7UMq2AspSligH/Nu5yvM
	Qb/cyyUVR98+aAQfM+5F6XZP/PGQgnaS2Fys6i94hsOP6KYayRFzt9ko4tb2dQWHrLHX3TZm1qfPw
	3zSwhminlGvJJxzD75nB++a0b/2+8GInmC4CfPkpegMYfZ+UsSgsL/uIdaGaiPiaXYd4dL0yB1ytk
	5sw4xQ/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuoxP-00000000Oss-1o8O;
	Sat, 06 Sep 2025 09:11:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org,
	amir73il@gmail.com,
	chuck.lever@oracle.com,
	linkinjeon@kernel.org,
	john@apparmor.net
Subject: [PATCH 10/21] ksmbd_vfs_path_lookup_locked(): root_share_path can be const struct path *
Date: Sat,  6 Sep 2025 10:11:26 +0100
Message-ID: <20250906091137.95554-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250906091137.95554-1-viro@zeniv.linux.org.uk>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 04539037108c..9f45c6ced854 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -72,7 +72,7 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_config *share_conf,
 {
 	struct qstr last;
 	struct filename *filename __free(putname) = NULL;
-	struct path *root_share_path = &share_conf->vfs_path;
+	const struct path *root_share_path = &share_conf->vfs_path;
 	int err, type;
 	struct dentry *d;
 
-- 
2.47.2


