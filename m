Return-Path: <linux-fsdevel+bounces-9982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC28846DD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7490228A35E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5945FF19;
	Fri,  2 Feb 2024 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k01v73Q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6367765C
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869386; cv=none; b=R70XrDdnCeLqA8kXD9wQX7d8fDxxi4Uoh2uc8j4GCxD2QpEBMPH7w3ClfM+TVq/GUXVcV2OOz9QtaCTU4iVgyEwHGQIXSbY4Ae3zF0eFg2yJqvbQdJWNhwPVtqXI+dd9SleBfuDwzIQf89WSQQLHqqjiYiLWpa3Wm0l4gZwjbNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869386; c=relaxed/simple;
	bh=IoKcX6nUmEq3b7auc8jGq4hpY+HwoZld02Aivgz+zUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dt1rofd4y1bqzWPVMRYk9ugEX5URmR33E1A2rsKNpK1Ud5n5cbOU4Zz6eqzYp5h3tqok8nCiG6xaWogQ0Y7dO/sBR+qMidWDyqEb2CDpkRnUVx/9EXSiWw/N5ScvWQnrMgl6p5/PTVqj1lEdR6tUIQ9J0f/acODIqI2zD0K6NeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k01v73Q6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fb020de65so16551755e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706869383; x=1707474183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M19hun2XSU/ho4mIaziYMiXnDtKvvevq/zzHhKZGoUo=;
        b=k01v73Q63nbMl4HMhRhVxcRDbbAA9EFBv9AOfRrQMXCUA+QuB4tvslOd7P9GbohVG1
         igen5m22E3qEkeek6nwTgD9SYQUOadVcJRuYRQyOEo4dwxIOYK4MEnPNOTwDzmjkt0T2
         YYOTKc6XP9J5CaXWiT/Kqz/beG7WTQMlf59XrvBsU6HdV0zpucxYInLKBsJcbaCmO40V
         oYNgX6rPUbelmqY2oPVg5HCnfTXhstumity4Y2plFFOaNfHzc8GL85c4ypkfTlXS48iJ
         AvwfepHRUoVBYg7QKTdt4Ge6qX9sfcBN0jBVp3z08Wq83lE8gxTkPIiK7X87yveJoZbC
         xsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869383; x=1707474183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M19hun2XSU/ho4mIaziYMiXnDtKvvevq/zzHhKZGoUo=;
        b=awgkMdUCO4VynrtqXbSfH3zgJh5715vZg0APxbOw2xD3VAY2GZ+W9/MaX+vRVMdVtO
         rUVs6R40/FcYyP0boockIVOFfLvukCwOGw1sFncQwY0I0ajEhALhsuEQV4+R+ezP3o7h
         fbSbkIrYMuPb7RBz+1YEsrYG3vN9lNf8JGgLm7pODGvj3kkFZemV+zYUS3tZ6W9cg3jR
         tkkGZDPajUFBYZU+mMley7G30tuuvHPl7slJCRz13C2aZmwfJbW53rvXslCd6T6PSROS
         rnU/jgpoWckPUZQZWym6ki02OFM520g8xXx8BbfBe48MFHH6jKhkjQUkpeRHOL877Pg2
         jckw==
X-Gm-Message-State: AOJu0YybHWc43GQCufGEKU0/ymQ9A5nUcI6tyJG1c7KoaHZWtghyVHyk
	+UztfkbsKSYp8hyIfbAeIklov+TdPKqSRwDvRg56YFfsDfEK+OEAxBMtlpkS
X-Google-Smtp-Source: AGHT+IHhvjGOyowVx6tXDZGlNqbSVEHrOkveyl8Pf+nIW4/TXvASOWSKENZxNu1kPXQx8CTsyXyfHQ==
X-Received: by 2002:a05:600c:a39e:b0:40f:b680:3e84 with SMTP id hn30-20020a05600ca39e00b0040fb6803e84mr5127248wmb.2.1706869382585;
        Fri, 02 Feb 2024 02:23:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUh5wKQttGa5cNxHQm1ODNxcTcgryR0pv2iKqRTxH0t+/LA3KizezM3GR4mRXV1KUsERNGxEUMgaOSYrCiVOf8JKb92uQvEpDTzV1/oFxC1OiN3G1fSTTHcT3KpRocT1Bm2twAEb+CfQy5CbmetW5ARtU5maanHYjR9mSACJ2//7tJqkkVpEJZ6/OfdtUzEzVWWxDFj1h6k2AXwHUhzAr8OMJxGWgaeXV+ElCcotaZyJ6W4
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id p18-20020adfcc92000000b0033b18e6d81fsm1600181wrj.114.2024.02.02.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:23:02 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] remap_range: merge do_clone_file_range() into vfs_clone_file_range()
Date: Fri,  2 Feb 2024 12:22:58 +0200
Message-Id: <20240202102258.1582671-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit dfad37051ade ("remap_range: move permission hooks out of
do_clone_file_range()") moved the permission hooks from
do_clone_file_range() out to its caller vfs_clone_file_range(),
but left all the fast sanity checks in do_clone_file_range().

This makes the expensive security hooks be called in situations
that they would not have been called before (e.g. fs does not support
clone).

The only reason for the do_clone_file_range() helper was that overlayfs
did not use to be able to call vfs_clone_file_range() from copy up
context with sb_writers lock held.  However, since commit c63e56a4a652
("ovl: do not open/llseek lower file with upper sb_writers held"),
overlayfs just uses an open coded version of vfs_clone_file_range().

Merge_clone_file_range() into vfs_clone_file_range(), restoring the
original order of checks as it was before the regressing commit and adapt
the overlayfs code to call vfs_clone_file_range() before the permission
hooks that were added by commit ca7ab482401c ("ovl: add permission hooks
outside of do_splice_direct()").

Note that in the merge of do_clone_file_range(), the file_start_write()
context was reduced to cover ->remap_file_range() without holding it
over the permission hooks, which was the reason for doing the regressing
commit in the first place.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401312229.eddeb9a6-oliver.sang@intel.com
Fixes: dfad37051ade ("remap_range: move permission hooks out of do_clone_file_range()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

It was I who introduced do_clone_file_range() in commit 031a072a0b8a
("vfs: call vfs_clone_file_range() under freeze protection") 8 years
ago.  It was actually called vfs_clone_file_range() and later renamed
to do_clone_file_range(), but it was always a bit of a hack.

With recent changes to overlayfs, we can finally get rid of it and on
the way, hopefully, solve the v6.8-rc1 performance regression reported
by kernel test robot.

Thanks,
Amir.


 fs/overlayfs/copy_up.c | 14 ++++++--------
 fs/remap_range.c       | 31 +++++++++----------------------
 include/linux/fs.h     |  3 ---
 3 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b8e25ca51016..8586e2f5d243 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -265,20 +265,18 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struct dentry *dentry,
 	if (IS_ERR(old_file))
 		return PTR_ERR(old_file);
 
+	/* Try to use clone_file_range to clone up within the same fs */
+	cloned = vfs_clone_file_range(old_file, 0, new_file, 0, len, 0);
+	if (cloned == len)
+		goto out_fput;
+
+	/* Couldn't clone, so now we try to copy the data */
 	error = rw_verify_area(READ, old_file, &old_pos, len);
 	if (!error)
 		error = rw_verify_area(WRITE, new_file, &new_pos, len);
 	if (error)
 		goto out_fput;
 
-	/* Try to use clone_file_range to clone up within the same fs */
-	ovl_start_write(dentry);
-	cloned = do_clone_file_range(old_file, 0, new_file, 0, len, 0);
-	ovl_end_write(dentry);
-	if (cloned == len)
-		goto out_fput;
-	/* Couldn't clone, so now we try to copy the data */
-
 	/* Check if lower fs supports seek operation */
 	if (old_file->f_mode & FMODE_LSEEK)
 		skip_hole = true;
diff --git a/fs/remap_range.c b/fs/remap_range.c
index f8c1120b8311..de07f978ce3e 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -373,9 +373,9 @@ int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(generic_remap_file_range_prep);
 
-loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
-			   struct file *file_out, loff_t pos_out,
-			   loff_t len, unsigned int remap_flags)
+loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
+			    struct file *file_out, loff_t pos_out,
+			    loff_t len, unsigned int remap_flags)
 {
 	loff_t ret;
 
@@ -391,23 +391,6 @@ loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
 	if (!file_in->f_op->remap_file_range)
 		return -EOPNOTSUPP;
 
-	ret = file_in->f_op->remap_file_range(file_in, pos_in,
-			file_out, pos_out, len, remap_flags);
-	if (ret < 0)
-		return ret;
-
-	fsnotify_access(file_in);
-	fsnotify_modify(file_out);
-	return ret;
-}
-EXPORT_SYMBOL(do_clone_file_range);
-
-loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
-			    struct file *file_out, loff_t pos_out,
-			    loff_t len, unsigned int remap_flags)
-{
-	loff_t ret;
-
 	ret = remap_verify_area(file_in, pos_in, len, false);
 	if (ret)
 		return ret;
@@ -417,10 +400,14 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 		return ret;
 
 	file_start_write(file_out);
-	ret = do_clone_file_range(file_in, pos_in, file_out, pos_out, len,
-				  remap_flags);
+	ret = file_in->f_op->remap_file_range(file_in, pos_in,
+			file_out, pos_out, len, remap_flags);
 	file_end_write(file_out);
+	if (ret < 0)
+		return ret;
 
+	fsnotify_access(file_in);
+	fsnotify_modify(file_out);
 	return ret;
 }
 EXPORT_SYMBOL(vfs_clone_file_range);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..023f37c60709 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2101,9 +2101,6 @@ int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				  struct file *file_out, loff_t pos_out,
 				  loff_t *count, unsigned int remap_flags);
-extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  loff_t len, unsigned int remap_flags);
 extern loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
-- 
2.34.1

