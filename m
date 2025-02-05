Return-Path: <linux-fsdevel+bounces-40989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC0A29BF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 22:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6AA3A78E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067521505D;
	Wed,  5 Feb 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I91MEbMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375A215061
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791618; cv=none; b=DK0bM+7HV3Ml715mBst+4KSRG12e7Fd06uC1SInMolgMWSOfV9WJRZ2NXNCRjLsJYyKSd+lzHmHTay7+O/whsEr+6zuQ5EZGHpaukY0c0uWpK6K0+GreUk0Ii8k3nPY1PP6D6RZUeJ0zbzzwEQSNpgo+V5QeJsuUGgUZtglrXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791618; c=relaxed/simple;
	bh=KrYVNYnNXO3e1ogblYs4fmOomKS82ZE+NgD+7BH3QIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U23h1xGSvQ3a5Vd/H0QIme2CDSNT25v/aPy10KSpBSHqHtC3VD3rG8NIMavuKiIlinNHJWBecSfz5YQ7ZZ0dh2LU5cH1ob72QTh/vtfuf65DQiTLaebB5mfK42Ejdjek3A1VnSEmxvmvbld7NLcEZVIhDYOo2hkQl3PUVqOYNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I91MEbMW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738791616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fHF88XgGidd1DCQa6ISHgfR4eudTTqNM5XPaGCskyoc=;
	b=I91MEbMWLnk/+Xr5xjtd940ReKkMHKZV5b8rnxo2TMh62AUpyrMy0oPRBRMiFl/+Uk1WKw
	8Kc8rV4h2nnnI4BHMPnRXprY1xyfmIkr4y9oNYe0AAwKzAPINilQr8mCaZB9kLQoNgPxvJ
	nQ7euaiTJmXWpEdkmWrryEW41QMKaLs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-tE2WBKusN9WrDBqlsxeILg-1; Wed, 05 Feb 2025 16:40:13 -0500
X-MC-Unique: tE2WBKusN9WrDBqlsxeILg-1
X-Mimecast-MFC-AGG-ID: tE2WBKusN9WrDBqlsxeILg
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-844d02766f9so22522739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 13:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791613; x=1739396413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHF88XgGidd1DCQa6ISHgfR4eudTTqNM5XPaGCskyoc=;
        b=QE8xC7dvw2UstgXyrGAo4ZbFuJR7flZObcJr7VzJncQkIn6Bc1kuFnSAKhMGwNzFSm
         0FtCjilndTaE1um3DPkHr8JZEuNrTp2/qpxtm+CU75SlwBP9vFi2hODiG+15XuczuzKH
         FJ7DUlG2urQEb/jjsTAIHkmV2zY9kYyD2m3EuOkBvK/Arg0sbN2om7EvGD/M+/h31jbw
         9T72wKBUrNc/ApbPqx4BGZqQhZ0+rMjqjJSklJcNqraPB+T1khBOjnB2ec9KVgLTRfde
         RCdA79AHpTdJLg6419KKKNli0AK48ZgLjTZsAK4vapDOxul9aIr2rQYFdwznx2DdFhix
         2lPg==
X-Gm-Message-State: AOJu0Yzr8yu4/ekgUk2I29elroCeA5VmBkgTkAXE+KrGAKlceHY+tbmU
	sqjRXCX/VdCYvQpc8N4hLZx3o+VyIYp+NiYMbHF8ElWvIHFl+eCvpFuzZkRqwBt+9WEcOR3U+KN
	WreF6R2EQQEGer/hac+0fGlsPvoVZ5Cn6N0R01WUKGeK19fA5XdO79Nek6LFTLIavgvNIeRY/KN
	o2tALlT9J864EaEur2ujC2bxjOvQYkWZnrhuoqdsdgFsMFtmg0
X-Gm-Gg: ASbGncvAQq1p4HhVjjQusvWjeemObHaGs/kow3D8Va5VqLV6Zt6RGBHbM9zVBNgPy8I
	xqvLETDCjZA8tIdfkvlvvTIqBYcZX/Oncve45zOx8I1pg4QI7DDxzrXu/UmfmVPfYjS5313i+g3
	qcpqVr8MbnaiTQakS+BL7TRqMpxh16rh24td/65UmnAnNkFRO0AdbgNN3jnmX3hn9ogJ7q+rMlL
	DBpywiAQsf8sa74blKMeBZivqobsfxbC8+/4kCtWvFWcAxQVyDgn67QZmSfXgjHnCs2mlAblXM6
	HTN1mvULhO1IrcDm2yHojkKHrHec8ruvMwH0r1mAdVRd9m8Xzs+kMg==
X-Received: by 2002:a05:6602:7213:b0:835:4b2a:e52b with SMTP id ca18e2360f4ac-854ea4f4627mr408222439f.10.1738791612816;
        Wed, 05 Feb 2025 13:40:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEs1ZwJR/q/FPx7PeTWWfsg1TqGg1ogBjLL1VNewgJfenIDd5EITWpWdGsjQaOGpYg3MTZdUg==
X-Received: by 2002:a05:6602:7213:b0:835:4b2a:e52b with SMTP id ca18e2360f4ac-854ea4f4627mr408220539f.10.1738791612422;
        Wed, 05 Feb 2025 13:40:12 -0800 (PST)
Received: from fedora-rawhide.sandeen.net (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-854a1717863sm368050839f.36.2025.02.05.13.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:40:11 -0800 (PST)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	neilb@suse.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	tony.luck@intel.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH 4/4] vfs: remove some unused old mount api code
Date: Wed,  5 Feb 2025 15:34:32 -0600
Message-ID: <20250205213931.74614-5-sandeen@redhat.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250205213931.74614-1-sandeen@redhat.com>
References: <20250205213931.74614-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove reconfigure_single, mount_single, and compare_single now
that no users remain.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/super.c                 | 55 --------------------------------------
 include/linux/fs.h         |  3 ---
 include/linux/fs_context.h |  2 --
 3 files changed, 60 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 5a7db4a556e3..723176dee229 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1737,61 +1737,6 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_nodev);
 
-int reconfigure_single(struct super_block *s,
-		       int flags, void *data)
-{
-	struct fs_context *fc;
-	int ret;
-
-	/* The caller really need to be passing fc down into mount_single(),
-	 * then a chunk of this can be removed.  [Bollocks -- AV]
-	 * Better yet, reconfiguration shouldn't happen, but rather the second
-	 * mount should be rejected if the parameters are not compatible.
-	 */
-	fc = fs_context_for_reconfigure(s->s_root, flags, MS_RMT_MASK);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	ret = parse_monolithic_mount_data(fc, data);
-	if (ret < 0)
-		goto out;
-
-	ret = reconfigure_super(fc);
-out:
-	put_fs_context(fc);
-	return ret;
-}
-
-static int compare_single(struct super_block *s, void *p)
-{
-	return 1;
-}
-
-struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int))
-{
-	struct super_block *s;
-	int error;
-
-	s = sget(fs_type, compare_single, set_anon_super, flags, NULL);
-	if (IS_ERR(s))
-		return ERR_CAST(s);
-	if (!s->s_root) {
-		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
-		if (!error)
-			s->s_flags |= SB_ACTIVE;
-	} else {
-		error = reconfigure_single(s, flags, data);
-	}
-	if (unlikely(error)) {
-		deactivate_locked_super(s);
-		return ERR_PTR(error);
-	}
-	return dget(s->s_root);
-}
-EXPORT_SYMBOL(mount_single);
-
 /**
  * vfs_get_tree - Get the mountable root
  * @fc: The superblock configuration context.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f..ff5e8ab9f951 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2641,9 +2641,6 @@ static inline bool is_mgtime(const struct inode *inode)
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
-extern struct dentry *mount_single(struct file_system_type *fs_type,
-	int flags, void *data,
-	int (*fill_super)(struct super_block *, void *, int));
 extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int flags, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 4b4bfef6f053..a19e4bd32e4d 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -144,8 +144,6 @@ extern void put_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param_source(struct fs_context *fc,
 				     struct fs_parameter *param);
 extern void fc_drop_locked(struct fs_context *fc);
-int reconfigure_single(struct super_block *s,
-		       int flags, void *data);
 
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
-- 
2.48.0


