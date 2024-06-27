Return-Path: <linux-fsdevel+bounces-22643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B3D91AC4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451921C22BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C219F19938A;
	Thu, 27 Jun 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLI1+IL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE2196D9E;
	Thu, 27 Jun 2024 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504725; cv=none; b=KHzKOG2JJ6JgRfBglE/BVXW5COK5Q17i/R9+zxbA+GwIPakQUSz51IS6NRjz3aWu/xKpk/FuueHZkMhgA7m2P7l/4kqfabosTrDX1UEjz7qylfD7y/W5PZI6LjFarSaZwhRNEl0izo0MKKOy2CDsp35R13T9ixM4UVD05pVlM6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504725; c=relaxed/simple;
	bh=6t1hPXDwq6nhiw9cHdmXBhSJAnLSGk6/1kXJ+BFAyf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UB4BbgMgFnS61JvE0Zj2Se7nXsJy3seq/ekmyvhjOmH+HQjTHyZWjtE4bhzawcmPBPGtIlW925PPTptePGFxTRQ57JWmvD4M6sNNaCWFTCCBSOlCmBo/zalT5oaTlruGoiH0iUSBouFkoM07h8KLCp4uJG4LtYddMK1MCrinudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLI1+IL9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d26a4ee65so1755901a12.2;
        Thu, 27 Jun 2024 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719504722; x=1720109522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQhvv3Potox166bw4fqLYlWp68a4ZD1pI5VWDFn1bbo=;
        b=aLI1+IL9YjoXmeYrTvGMebe+cKp43RflzJYcoVpnk7Z++oBL17S8AHwSqtJHNOd2o2
         nQV+UhXST1LLaNFi8KxdPltwZOoTdNeIMcXx297rufkefVpvOJzDjapQSoUqpzkbF/g7
         8qV8DhXyvvArYfEk53RJAcbi9Qsl2kg8FnMXculnZtwS6eaSkiAN6wqKr92QsGFqq+VB
         twKfPcZ78JhuQFkCU+l9ASLAxyeSTG5JpBmdssKwurW98UdBrZ9xiAXNem7SDF2HDLzK
         SGcDO27oPW0LsgewAa4Ww/K4TmX7ibLhKkgSbQ2sxHBowIgObTbpXYyLVT8aUhUxwpMV
         KnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719504722; x=1720109522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQhvv3Potox166bw4fqLYlWp68a4ZD1pI5VWDFn1bbo=;
        b=lInXRwvXxYYJ8VOPsBbncaoCqVTUBbLf4XjeZwoYh4JMpxAHbpe/CkMSFh+qEb9Cy7
         hz5Rw94R7RX17VjyjuLZ23ljpyVLdgGrNCLeBVeKdjl2tXEztuDNRaNyP6UBndVFbF3h
         JiBXGYVa9sYQCZYxGn7jhvSY7qnzhoSnd1OMr0hOsIHqK2IhmteloMORMbRiLTBB0TRd
         JTa4Vp+W9sRZ6U6SEUojZUtUwZv+BgFv8jqvZPSobhl9uJD3jjt9ufB/SuSEy4P57XKm
         xCVW7+33Fm0TpxE9drT08xxEUDNalBBIibFAIC31nkSwEc0s3L/K0RxrHc2tGgnXmDbE
         8lBw==
X-Forwarded-Encrypted: i=1; AJvYcCXfi1kMNwdEq7w/TnAv6Ox5nKw8XR+vGAMsV/E9CvkdoOz9Olzno/w4rHohg43HxZuLq2K5839AlfjmvMkPhy218PZ55380D/zg9uvPN1Kdbr/xFEOm37F6X7ICYu+QrjcM5yyeJdE21GmsCA==
X-Gm-Message-State: AOJu0YwVMmZeM7JIx2tzH96X83fkQ3C0nfq1IG9qVeFxhPLnCy3OgMwk
	b9s5cAfCPbVS+YpJJE1UHv+urBt5/AUJpG9ZNh8Sm2aXNuQJWjcs
X-Google-Smtp-Source: AGHT+IEM5NV77NJF9VUVPKs+69oU2yk4tmCMJHjCJU9I3YD8DvkkLHBBbNqQMXfzviyQaF9UD63drw==
X-Received: by 2002:a05:6402:35c7:b0:585:f46d:f573 with SMTP id 4fb4d7f45d1cf-585f46df576mr12714a12.0.1719504721630;
        Thu, 27 Jun 2024 09:12:01 -0700 (PDT)
Received: from f.. (cst-prg-81-171.cust.vodafone.cz. [46.135.81.171])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d17b0334sm1053123a12.46.2024.06.27.09.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:12:00 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: rename parent_ino to d_parent_ino and make it use RCU
Date: Thu, 27 Jun 2024 18:11:52 +0200
Message-ID: <20240627161152.802567-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The routine is used by procfs through dir_emit_dots.

The combined RCU and lock fallback implementation is too big for an
inline. Given that the routine takes a dentry argument fs/dcache.c seems
like the place to put it in.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

this shows up with stress-ng --getdent (as one of many things)

build-tested with first adding d_parent_ino, then building allmodconfig
and fixing failures as they pop up. by the end of it grep shows no
remaining occurences, so i don't believe there will be any build regressions.

scheme borrowed from dget_parent

I cared enough to whip out the patch, but I'm not going to particularly
strongly defend it. arguably the getdent bench is not that great and I'm
not confident anything real runs into this as a problem.

 fs/dcache.c            | 30 ++++++++++++++++++++++++++++++
 fs/f2fs/file.c         |  2 +-
 fs/hfsplus/ioctl.c     |  4 ++--
 include/linux/dcache.h |  2 ++
 include/linux/fs.h     | 16 +---------------
 5 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a0a944fd3a1c..38d42f333b35 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3100,6 +3100,36 @@ void d_tmpfile(struct file *file, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+/*
+ * Obtain inode number of the parent dentry.
+ */
+ino_t d_parent_ino(struct dentry *dentry)
+{
+	struct dentry *parent;
+	struct inode *iparent;
+	unsigned seq;
+	ino_t ret;
+
+	rcu_read_lock();
+	seq = raw_seqcount_begin(&dentry->d_seq);
+	parent = READ_ONCE(dentry->d_parent);
+	iparent = d_inode_rcu(parent);
+	if (likely(iparent)) {
+		ret = iparent->i_ino;
+		if (!read_seqcount_retry(&dentry->d_seq, seq)) {
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
+
+	spin_lock(&dentry->d_lock);
+	ret = dentry->d_parent->d_inode->i_ino;
+	spin_unlock(&dentry->d_lock);
+	return ret;
+}
+EXPORT_SYMBOL(d_parent_ino);
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a390b82dd26e..66ab9a859655 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -185,7 +185,7 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	if (!dentry)
 		return 0;
 
-	*pino = parent_ino(dentry);
+	*pino = d_parent_ino(dentry);
 	dput(dentry);
 	return 1;
 }
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index 5661a2e24d03..40d04dba13ac 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -40,7 +40,7 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 
 	/* Directory containing the bootable system */
 	vh->finder_info[0] = bvh->finder_info[0] =
-		cpu_to_be32(parent_ino(dentry));
+		cpu_to_be32(d_parent_ino(dentry));
 
 	/*
 	 * Bootloader. Just using the inode here breaks in the case of
@@ -51,7 +51,7 @@ static int hfsplus_ioctl_bless(struct file *file, int __user *user_flags)
 
 	/* Per spec, the OS X system folder - same as finder_info[0] here */
 	vh->finder_info[5] = bvh->finder_info[5] =
-		cpu_to_be32(parent_ino(dentry));
+		cpu_to_be32(d_parent_ino(dentry));
 
 	mutex_unlock(&sbi->vh_mutex);
 	return 0;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 58916b3f53ad..bff956f7b2b9 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -283,6 +283,8 @@ static inline unsigned d_count(const struct dentry *dentry)
 	return dentry->d_lockref.count;
 }
 
+ino_t d_parent_ino(struct dentry *dentry);
+
 /*
  * helper function for dentry_operations.d_dname() members
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 32cbcb3443e5..04ee7d7c9621 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3463,20 +3463,6 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	return 0;
 }
 
-static inline ino_t parent_ino(struct dentry *dentry)
-{
-	ino_t res;
-
-	/*
-	 * Don't strictly need d_lock here? If the parent ino could change
-	 * then surely we'd have a deeper race in the caller?
-	 */
-	spin_lock(&dentry->d_lock);
-	res = dentry->d_parent->d_inode->i_ino;
-	spin_unlock(&dentry->d_lock);
-	return res;
-}
-
 /* Transaction based IO helpers */
 
 /*
@@ -3601,7 +3587,7 @@ static inline bool dir_emit_dot(struct file *file, struct dir_context *ctx)
 static inline bool dir_emit_dotdot(struct file *file, struct dir_context *ctx)
 {
 	return ctx->actor(ctx, "..", 2, ctx->pos,
-			  parent_ino(file->f_path.dentry), DT_DIR);
+			  d_parent_ino(file->f_path.dentry), DT_DIR);
 }
 static inline bool dir_emit_dots(struct file *file, struct dir_context *ctx)
 {
-- 
2.43.0


