Return-Path: <linux-fsdevel+bounces-67813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C69C4BE28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 08:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D971898DB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 07:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126E5350A07;
	Tue, 11 Nov 2025 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="af7kWl7S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A49346FA6;
	Tue, 11 Nov 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762844132; cv=none; b=BR3+mMQ7YDkbGa5dxaqQJBgb/L4B0/syeb4rTXV+umwTYWbaSe8neYUsSqZqiQDTdnPcNRRwilHOn/dcCiEnulDWIe4iT05YeKUC/OG6nVK2HHkYa97FTFRNahn4SQgA0vTJwNzHItrJLu56YLboQwzBVhS/++wt7ESD1fEiGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762844132; c=relaxed/simple;
	bh=0rJZ4ovRi5zcpx7S+ter6YR4mMdmc+sGFQAeyIE+h1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFQsoox6W5jL0S0BSefChtSVZb9AWVqe0WBt/nmEpQbhchZaPb73i7ubjxvJGxkJjWz4bzAnOAPHux1u2r4hVaalBOxCP9kPvSXAjzDrjMaVFqTCJ0hshk9hBlNjJ7OtJTLgMubN04+VnoL9maGutRBna3geRPBL/TJ+MBpub4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=af7kWl7S; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3maaNWdAFQG6lKGkg4q4mAf3fnGzZVX1VVI0dDX3CYE=; b=af7kWl7SJFjT7QdFsmwd1bB+oa
	7VF4d+2ZD5Otiraw7rQJvFktfdYbXy9putsaQRRkXkOvJ2RRHpQeOkz/XScblzy4AWTDnYkqxk7jI
	xvXI50CDcJ3cX8iE/4vQHVzOqyIJoFi+dUf84KaD7SvsNct9FO7YtW9WAFxGc7FQ396MDz96SPgRz
	aMN6g8qg7qqSneL1FzADG34DExFPBmzbA6yQLt0avegFgzzf5TaGU9ndWTrScPkLhVV+zRqofYjyA
	6KZLqZMKt2p757dZqbtqzRX96ZIr1csj7b+Z3fPzh75G6phFt8ewveWWPDJd8CZfUOOwzM4Ebj77C
	7W2Byy1g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIiHh-0000000Bww2-47vE;
	Tue, 11 Nov 2025 06:55:22 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org,
	brauner@kernel.org,
	jack@suse.cz,
	raven@themaw.net,
	miklos@szeredi.hu,
	neil@brown.name,
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
	john.johansen@canonical.com,
	selinux@vger.kernel.org,
	borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: [PATCH v3 04/50] new helper: simple_done_creating()
Date: Tue, 11 Nov 2025 06:54:33 +0000
Message-ID: <20251111065520.2847791-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk>
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
index 28bd4e8d3892..f5037c556f61 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3662,6 +3662,7 @@ extern int simple_fill_super(struct super_block *, unsigned long,
 extern int simple_pin_fs(struct file_system_type *, struct vfsmount **mount, int *count);
 extern void simple_release_fs(struct vfsmount **mount, int *count);
 struct dentry *simple_start_creating(struct dentry *, const char *);
+void simple_done_creating(struct dentry *);
 
 extern ssize_t simple_read_from_buffer(void __user *to, size_t count,
 			loff_t *ppos, const void *from, size_t available);
-- 
2.47.3


