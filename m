Return-Path: <linux-fsdevel+bounces-45070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FB1A71598
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8564188BCD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954641DDA0F;
	Wed, 26 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GbbtMXX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B41C84BB;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=HdbCCuqmCIN74UBGh2HPm9WK/I5C+zh6o0vgzFjAXhTB+NF9nmP77O2n7gtJv66cZHr/QZlq0i+wghSkShn5fsFFOo6mm5rO+HmU0yV8/ytgOQZwykSusCBlYcC4FZI59VJPunK0+kI34kBxGgfy1BNQ6WP106Y+hstUR7zpduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=KbPXXfRMPMbRC7rd9iUF2nVKYlz6F7zzKUNd4WnEUvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncZvzgnQ+lT782lsf3+22zsxPpahC0seHVFSb/TLjTVZ4ym4Lnlm6OM6uWvMm7Y19zZo1JyaurqfdGpGMw+2QhVh6/IvJofANKyVj7nZpxps6Jyqxi5xXbZmTUULmNZh4fMStC1JHDm3y8tcTOq8K9e+DaRLnLHVJFeayj6UUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GbbtMXX1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y+mzxJMNAix6hEe0DMlkLUt+uC5JhVrR/pZpXYCHRMQ=; b=GbbtMXX1LGV/vYNBrFxO31ruQ0
	Fj4L4U+vbfbUqhqNJvYtrfZ4GoazeLoUu5LrWE7OmsSNj/oU2YQtwTsji286abAbmEwSwsvJmp9or
	Qm0pHSHnD/rrM3Oyo/MTmwEQFgxygLiLWk7rqz75IhunfwUIVH0L2yAl886cLGIQmginu9TriXV54
	22Vc4OO+D5syZRjUnaKENEpdjDg+OPmREuPvFejz6H1DAg6/PNRWdYnSXBWxyfJa1YIMEZ8VUMmpV
	25xuT8jqEWNjfwO/eB2ulr8/jXI+e/nDV2T2S95K/5NJXP5EqTjDXBcbGscHaJYOsWaPZMeOLmeLm
	hZrZjTyA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LLq-2wo8;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 2/6] fs: add iterate_supers_excl() and iterate_supers_reverse_excl()
Date: Wed, 26 Mar 2025 04:22:16 -0700
Message-ID: <20250326112220.1988619-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

There are use cases where we wish to traverse the superblock list
but also capture errors, and in which case we want to avoid having
our callers issue a lock themselves since we can do the locking for
the callers. Provide a iterate_supers_excl() which calls a function
with the write lock held. If an error occurs we capture it and
propagate it.

Likewise there are use cases where we wish to traverse the superblock
list but in reverse order. The new iterate_supers_reverse_excl() helpers
does this but also also captures any errors encountered.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/super.c         | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 +
 2 files changed, 93 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 117bd1bfe09f..9995546cf159 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -945,6 +945,97 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 	spin_unlock(&sb_lock);
 }
 
+/**
+ *	iterate_supers_excl - exclusively call func for all active superblocks
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument. Returns 0 unless an error
+ *	occurred on calling the function on any superblock.
+ */
+int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
+/**
+ *	iterate_supers_reverse_excl - exclusively calls func in reverse order
+ *	@f: function to call
+ *	@arg: argument to pass to it
+ *
+ *	Scans the superblock list and calls given function, passing it
+ *	locked superblock and given argument, in reverse order, and holding
+ *	the s_umount write lock. Returns if an error occurred.
+ */
+int iterate_supers_reverse_excl(int (*f)(struct super_block *, void *),
+					 void *arg)
+{
+	struct super_block *sb, *p = NULL;
+	int error = 0;
+
+	spin_lock(&sb_lock);
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
+		if (hlist_unhashed(&sb->s_instances))
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+
+		down_write(&sb->s_umount);
+		if (sb->s_root && (sb->s_flags & SB_BORN)) {
+			error = f(sb, arg);
+			if (error) {
+				up_write(&sb->s_umount);
+				spin_lock(&sb_lock);
+				__put_super(sb);
+				break;
+			}
+		}
+		up_write(&sb->s_umount);
+
+		spin_lock(&sb_lock);
+		if (p)
+			__put_super(p);
+		p = sb;
+	}
+	if (p)
+		__put_super(p);
+	spin_unlock(&sb_lock);
+
+	return error;
+}
+
 /**
  *	iterate_supers_type - call function for superblocks of given type
  *	@type: fs type
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1d9a9c557e1a..da17fd74961c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3538,6 +3538,8 @@ extern struct file_system_type *get_fs_type(const char *name);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+extern int iterate_supers_excl(int (*f)(struct super_block *, void *), void *arg);
+extern int iterate_supers_reverse_excl(int (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.47.2


