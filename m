Return-Path: <linux-fsdevel+bounces-38221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5458F9FDDF0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 09:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA0C3A16CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Dec 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360686321;
	Sun, 29 Dec 2024 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wskurl7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF627713
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Dec 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735459948; cv=none; b=VF827Fftsr1YcIAsasydiZpVNe0ZTDR76qARe2otVY70ahrvGDRnOeM/VEKwpsODNTrLXCMw6n6w9al1IyTyfQGmf1xiExVcYduyfWaINX85u7SSmPyXNgxvVCxpCL77/G5/P6nhm5sTKet6BOFn2zNtVgJ0ZNlIspKAnWRIOzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735459948; c=relaxed/simple;
	bh=MrnxKx6r5qwN3yPtpKl045P17TLg4O5b5uArc2lV+hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuFtWAZjHjIFYhkcKBkz/moIWsw/9/JNe9+a7kjn/WnbbBHy3nBw75/i8d87Gc0MzAkpAWAhhvOGNCgPblguTbvMNCuZ400mzmJygmx3em68Mn2IbIMkBdlqUgOdbSpe0OqCsK/Rgc9row1Jhz5EBjg89L4MRZGmsSKuf4jVx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wskurl7w; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vSf3Pf8FTfxYoucTfNkf6F2oHNFeP06oq8V0YuzXvU0=; b=wskurl7wio5htjKMBAs8TXy3md
	I+S9MYVg5VKVyyJECnzw2Sa8febG4RWJDxznc1O2QBhVI9UBtZU7+RYlIzGJLMP7C85pwckdF5M82
	IjgvGT7OZ0V4zLYotf3WH2xokfCLXjlvIqko/pfjtu5TAh7pKT9Nc/ZVnFVYZDdrM3khbie0NpHUA
	EQRcSaTxiHnRAIST3OU7YBM4SWVFNM4Lsd+dqDIlURnHx60wFYJvv/xfDHmomSH8jaS1EG3++S9vf
	AQENB1vl+zMIZgV1p+94V8y89oMeGmRb0iORYqdD7fPM8RGM58O6C/ruAOJ6Roej24CPyvKONcTBk
	Cp+LE3yg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tRoPP-0000000DOhn-207S;
	Sun, 29 Dec 2024 08:12:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH 01/20] debugfs: fix missing mutex_destroy() in short_fops case
Date: Sun, 29 Dec 2024 08:12:04 +0000
Message-ID: <20241229081223.3193228-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229080948.GY1977892@ZenIV>
References: <20241229080948.GY1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

we need that in ->real_fops == NULL, ->short_fops != NULL case

Fixes: 8dc6d81c6b2a "debugfs: add small file operations for most files"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/debugfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 38a9c7eb97e6..c99a0599c811 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -229,7 +229,7 @@ static void debugfs_release_dentry(struct dentry *dentry)
 		return;
 
 	/* check it wasn't a dir (no fsdata) or automount (no real_fops) */
-	if (fsd && fsd->real_fops) {
+	if (fsd && (fsd->real_fops || fsd->short_fops)) {
 		WARN_ON(!list_empty(&fsd->cancellations));
 		mutex_destroy(&fsd->cancellations_mtx);
 	}
-- 
2.39.5


