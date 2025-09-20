Return-Path: <linux-fsdevel+bounces-62277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD27B8C1AF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83441564755
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC8127AC43;
	Sat, 20 Sep 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qmfxZkHa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A9D23A58B;
	Sat, 20 Sep 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354485; cv=none; b=dUnOkOeZUbvVGL2cjdSkTl3AWg2X9KIPaSQvoUZ88TuWx3wNGe3byRu97bqPStsvjyLexu6HjH4ef/+d12xLKYYH4TusyId4C7gaYkf2evJ9SXcLuJvaECQdjRr+wkYWDdzP76ryNEnxC16XlaX4Pzk5Oi2HSRYcsrpowGMLqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354485; c=relaxed/simple;
	bh=3zpTAVTwVuvZbFEY+Yj5GDjqcFjqCQEgQUTlxMUxueM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMTLp4xaeTq0DqtPbf/YFqgeNQb3b68sDYKuLKIP9sD7/pTfDmRniwoNtbOeV77tPN0YltPP6KzlQkRy5MdaF/HMYMCmmbbfn00jCrBQ64doFrZ3TnbqvE06iNqKj6j0e/WjHaxLhFOX5mECid+P3qo89jdWyB4eZ9uCmWtqtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qmfxZkHa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1X8MC3Kv2szH/aZW8Vz8ecvuKZEkFejBxtbewl37q7g=; b=qmfxZkHaOy6z213r3hoOLfPjJq
	z5H9zRL8cOu1GzvBs73WpMj+FIYrP7dwqTnnSJ2WNyzAxDOvrv1MaXglsNWmTRhLlFWNTwVj5/o9y
	XjOBTMfpWSYL6tEl+iH5wSQWOC0S4dYhFKVdGR50n09pqsxGd9zpEmzyqWeIowslcjIeyBVJ/zW9P
	Kl/dzZ9WwwYl4BLeUVzB4SjeCf71sDkKYgQca2Hh2mQaJaIoAzJdanSBuHL6fKJCte90eiSRb+56n
	0G3WLx25Foc2DorqmP2+Hpw3LetMjXLyjC7IUR/7nrNv3vsSS0SGTzDYfl5P5mZ2TgLpWKrpE3shU
	2Ti5jkBw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzsK8-0000000ExBm-0p68;
	Sat, 20 Sep 2025 07:48:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	a.hindborg@kernel.org,
	linux-mm@kvack.org,
	linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	kees@kernel.org,
	rostedt@goodmis.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	paul@paul-moore.com,
	casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: [PATCH 02/39] new helper: simple_done_creating()
Date: Sat, 20 Sep 2025 08:47:21 +0100
Message-ID: <20250920074759.3564072-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

should be paired with simple_start_creating() - unlocks parent and
drops dentry reference.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/libfs.c         | 8 ++++++++
 include/linux/fs.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index d029aff41f66..a033f35493d0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2326,3 +2326,11 @@ struct dentry *simple_start_creating(struct dentry *parent, const char *name)
 	return dentry;
 }
 EXPORT_SYMBOL(simple_start_creating);
+
+/* parent must have been held exclusive since simple_start_creating() */
+void simple_done_creating(struct dentry *child)
+{
+	inode_unlock(child->d_parent->d_inode);
+	dput(child);
+}
+EXPORT_SYMBOL(simple_done_creating);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3a33c68249e2..e3000302c3b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3659,6 +3659,7 @@ extern int simple_fill_super(struct super_block *, unsigned long,
 extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 struct dentry *simple_start_creating(struct dentry *, const char *);
+void simple_done_creating(struct dentry *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
-- 
2.47.3


