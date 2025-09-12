Return-Path: <linux-fsdevel+bounces-61133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8EEB556BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9343B267F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0883333471C;
	Fri, 12 Sep 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vdfigY8s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A7032ED4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703566; cv=none; b=G2AcxwwbTrQKhQj0iN0kaZLLx/SZpyjNwQg4QZsn5piyaqpkKqKuwenvRfwODzQWAvbDwBDcyHIBXy7TJhODC9BXt7JU/SxGXIvpGPyCyon0Usi1/Y4yd15wqh/qPk4jIbTZf8ohgNoqsqbDfE4BYBH79UVMlHh1KpqTuABmN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703566; c=relaxed/simple;
	bh=zdea1RouDYMzXmAJq3YI4CWAC7bHDwaab/t63Joc15c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HeFymtlryM5V21cL8doioyBp5bxWlkmWDEReG3HSXntTiyyQ4wMXLq2LVpU8EfmpxWuvz7fOH44NlBmqDH9HDvQTXY5mW1S5VTuXiCwBbTuGj46wrXqpnqrqOF55JKeN9MijQ7SqB9b1cgMX9aJhakpOz6ibdPQ2gmZrYx/GjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vdfigY8s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/yz1vCsyVgcnoQSOe6jDk9BmzYFpfKBDQSQZK4ctptk=; b=vdfigY8sDzNO/yaPNk09ibiJWv
	qkzD9Lm/biKyuUVI5BFkMPfEnInCR7agcXU0lEnVdcAa+okzJJRrLy7KkW84LYBZeP4thetZ3AkLa
	WU7/6PXqiJslBKMJLJgym3071QMv/OsYs0NgpStmpcPVytAqnNOCl3qoXNmOyZL8eMf/ESPvdRA4/
	DMvxPEYrYO7rjMGnbjnj7B85+imR1In66WlHXbAZcHBrFZgZePP8ha/yEJQl1AJhhM6CQvt6OSDfO
	QU+UiNKNvmianTj68Pji2V5QjKH+4VIlCLXN4wUhsxsbuAiUMyKAf6oip6l8j26y+4sCaBlbHs81Z
	CNvK5qXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ux8zN-00000001g63-0jvU;
	Fri, 12 Sep 2025 18:59:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: neil@brown.name
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu
Subject: [PATCH 5/9] simplify vboxsf_dir_atomic_open()
Date: Fri, 12 Sep 2025 19:59:12 +0100
Message-ID: <20250912185916.400113-5-viro@zeniv.linux.org.uk>
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

similar to 9p et.al.
---
 fs/vboxsf/dir.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 770e29ec3557..42bedc4ec7af 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -315,46 +315,39 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 {
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
 	struct vboxsf_handle *sf_handle;
-	struct dentry *res = NULL;
 	u64 handle;
 	int err;
 
 	if (d_in_lookup(dentry)) {
-		res = vboxsf_dir_lookup(parent, dentry, 0);
-		if (IS_ERR(res))
-			return PTR_ERR(res);
-
-		if (res)
-			dentry = res;
+		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
+		if (res || d_really_is_positive(dentry))
+			return finish_no_open(file, res);
 	}
 
 	/* Only creates */
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
-		return finish_no_open(file, res);
+	if (!(flags & O_CREAT))
+		return finish_no_open(file, NULL);
 
 	err = vboxsf_dir_create(parent, dentry, mode, false, flags & O_EXCL, &handle);
 	if (err)
-		goto out;
+		return err;
 
 	sf_handle = vboxsf_create_sf_handle(d_inode(dentry), handle, SHFL_CF_ACCESS_READWRITE);
 	if (IS_ERR(sf_handle)) {
 		vboxsf_close(sbi->root, handle);
-		err = PTR_ERR(sf_handle);
-		goto out;
+		return PTR_ERR(sf_handle);
 	}
 
 	err = finish_open(file, dentry, generic_file_open);
 	if (err) {
 		/* This also closes the handle passed to vboxsf_create_sf_handle() */
 		vboxsf_release_sf_handle(d_inode(dentry), sf_handle);
-		goto out;
+		return err;
 	}
 
 	file->private_data = sf_handle;
 	file->f_mode |= FMODE_CREATED;
-out:
-	dput(res);
-	return err;
+	return 0;
 }
 
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
-- 
2.47.2


