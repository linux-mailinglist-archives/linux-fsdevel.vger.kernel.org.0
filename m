Return-Path: <linux-fsdevel+bounces-68289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE45EC5880E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B05A54EEE46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF32F25E6;
	Thu, 13 Nov 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="HqYti0DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC982F0C62;
	Thu, 13 Nov 2025 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047269; cv=none; b=UJLKKVLiV/rGh1p4acdW3qQOGq4ZneMtVY1UMEdFTfdojUgTkJnr0StD+yXACZOGqFKXEsADHQLLyn/Uxe5qwScOw2AY4xs8JCRMcm7EVvTRhlB/EW4EnHIXBwup3njQVWtG9RvZ6+MTTDNGMWjZvbV591BIcxRZ9KTRYFdHxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047269; c=relaxed/simple;
	bh=K+cXoWyMnlTMq8bbYqGQRNKQG81e+yalvYB4iNsmOnc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ivFVJXKa/lpQS3p3ff+3/J8xtX8Rj9vbA0y0OfvF6sgGdSj0kLiQLwgXaqrlB3Mf5Qv3XPpDl6+farvkWxolouQNgWuS6cYwx5MKNRJOVqBWQp8S9DSiPfjpgbK/evsFnRjKi2jdEKroXNLxRKW9blxj85KRoEmz240aDaLnEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=HqYti0DL; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id A70DE1D47;
	Thu, 13 Nov 2025 15:17:41 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=HqYti0DL;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 628762151;
	Thu, 13 Nov 2025 15:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1763047263;
	bh=/9X1oIADbCfyIJfAVdtot4DGzNhD/rq0TDB0e6o+OuM=;
	h=From:To:CC:Subject:Date;
	b=HqYti0DLFVaOdRplx8wdkBZSGhoJXiQa9jHAEDFtCUA09f/Te98AIzLF6VfKWjOdO
	 6+BrvCJ/e2RKK+qhkqIvfukrWnLBbaivBOBK0fLOU1WrSbrPfo0ifbx9z6di+nYtPQ
	 go1yGo4cc6Un7zamll+MD5KBQGkjzH1dTu+dbEaQ=
Received: from localhost.localdomain (172.30.20.182) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 13 Nov 2025 18:21:02 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH] fs/ntfs3: update mode in xattr when ACL can be reduced to mode
Date: Thu, 13 Nov 2025 16:20:54 +0100
Message-ID: <20251113152054.7663-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

If a file's ACL can be reduced to standard mode bits, update mode
accordingly, persist the change, and update the cached ACL. This keeps
mode and ACL consistent and avoids redundant xattrs.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/xattr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index e519e21596a7..c93df55e98d0 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -654,12 +654,22 @@ static noinline int ntfs_set_acl_ex(struct mnt_idmap *idmap,
 	err = ntfs_set_ea(inode, name, name_len, value, size, flags, 0, NULL);
 	if (err == -ENODATA && !size)
 		err = 0; /* Removing non existed xattr. */
-	if (!err) {
-		set_cached_acl(inode, type, acl);
+	if (err)
+		goto out;
+
+	if (inode->i_mode != mode) {
+		umode_t old_mode = inode->i_mode;
+		inode->i_mode = mode;
+		err = ntfs_save_wsl_perm(inode, NULL);
+		if (err) {
+			inode->i_mode = old_mode;
+			goto out;
+		}
 		inode->i_mode = mode;
-		inode_set_ctime_current(inode);
-		mark_inode_dirty(inode);
 	}
+	set_cached_acl(inode, type, acl);
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
 
 out:
 	kfree(value);
-- 
2.43.0


