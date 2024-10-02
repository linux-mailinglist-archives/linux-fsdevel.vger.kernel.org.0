Return-Path: <linux-fsdevel+bounces-30632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03298CAE5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB531F23504
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764E7FD;
	Wed,  2 Oct 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="mqYWq7x1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E83E2F44
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833225; cv=none; b=FR13TrA6kklPy+8PuDp1148nIujVVRmaEcTWjJKo5HbdqwK9EnGm9RVcGIj9uSVEeXOyrkYRszgabnyPoUQdkX/TokAK7NW/+4JXIKecdgyyJElQZXbwRWflck6ge4aGemTX1RDGmvy2rJoLakAx4JAFwQVZD/rOtN494cXM8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833225; c=relaxed/simple;
	bh=QzJZcYuJqvu4t2qF3uS7a40qvoBvPZsRghW4Ip08npo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=he+nLz4lNzVOF1n9Ln/gmuSHEYGsTRpBeE9WyGGMokUpGoFcNU6TiIe9+YOUQllpGP9Xq3nWC9ypwnNFrkWfXbrJZEN7MOvLKz607+yBUgu+QRD/GR3LAz8znVVp+n4c0UST0A0EP4vfwYTtefljTTY3jXAxUD6O7p9IYFsXhqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=mqYWq7x1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso268854a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727833223; x=1728438023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1rJUH/mWxXjOpXgbWGlZQXMWgJmvd7aMaDMpndP2yo=;
        b=mqYWq7x1xbf1Ifrw7l1y2hhb9uvYjvNPSTW1iORI8rCU2XEsl+XY/vOeenwwhuh/gY
         ajpJIWehMuzEXqo8GoU0SwcE6EjcUK+/obMFHEa5HIBTDnN44tZMziodmtPWVDDg44oS
         liGh0o9dM1n4SBN5ZanO4+Atj/FQLwPgu+9nPP0tO/wB658yECd2nYb1eK4tpCJrIIyu
         Umi/Ogw0B1sjExbsJdPofoexikFkJ9xIhVPNFzXe7zyJe1GTGvRq532XyL3D4IFnQX76
         ixifH88l8GT6DzppfqRVwkDy1lgnwuPn76+vleoRSMchGFMuoaqFJkSKob3fscTt9W3d
         sTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727833223; x=1728438023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1rJUH/mWxXjOpXgbWGlZQXMWgJmvd7aMaDMpndP2yo=;
        b=Wq3fO2yygE8zDmSkuW3kLvWgtd+6E/0JdXYUT9JFD9D2DQK7rTVJMewSqWIxzNRv07
         +aHUTkdH/4at80ls3hOS2Z2i8S4TcvGvN5wJKDkWzcb7RwI+RVIuVLLQuHmgcq4fjOuv
         bdRimTKXlxaml5nhCLzGSV0Nqh1ERsOk7PtjSw1s8qzXKhVZDqnDrutOM5b8d8ZgAw8G
         KzRUPkgX6FBqVVkMea10a8F4uca2b58/VKF8klIxXQshX56mJBd94djxx9+3zyBhRt/f
         oHeoOSJcc8d7rbVnPBId07CMIlsMpr60USjxTl2bOpJ5aZT1hqRUfKJFIy4TjBrmbk/5
         8q9Q==
X-Gm-Message-State: AOJu0YwtQIm1K1lvLCCHYBRvVYR4dSuFoA//C0wUgHyz+R50IuZ+5eb5
	f+0AiQ5krZ6vIJOwfAG1pEVLNWkyyVUVF7X2pvyYi1xWEHemQkLJ1fsmhlXx7HhPr32iuqeAeWU
	j
X-Google-Smtp-Source: AGHT+IER4Kb2iLiz3Cn70aHvpLUJtA0lkyIz83+tDTqx83rbjBv6L7OqRmyXU9lvlCTDvJmi8BZfWg==
X-Received: by 2002:a17:90a:dc0d:b0:2d8:85fc:464c with SMTP id 98e67ed59e1d1-2e15a253ae9mr8067492a91.11.1727833223299;
        Tue, 01 Oct 2024 18:40:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa54fe3sm317590a91.54.2024.10.01.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 18:40:22 -0700 (PDT)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.96)
	(envelope-from <dave@fromorbit.com>)
	id 1svoLj-00Ck8r-0v;
	Wed, 02 Oct 2024 11:40:19 +1000
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1svoLj-0000000FxGf-2yhr;
	Wed, 02 Oct 2024 11:40:19 +1000
From: Dave Chinner <david@fromorbit.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev,
	torvalds@linux-foundation.org
Subject: [PATCH 7/7] bcachefs: implement sb->iter_vfs_inodes
Date: Wed,  2 Oct 2024 11:33:24 +1000
Message-ID: <20241002014017.3801899-8-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002014017.3801899-1-david@fromorbit.com>
References: <20241002014017.3801899-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Untested, probably doesn't work, just a quick hack to indicate
how this could be done with the new bcachefs inode cache.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/bcachefs/fs.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 4a1bb07a2574..7708ec2b68c1 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1814,6 +1814,46 @@ void bch2_evict_subvolume_inodes(struct bch_fs *c, snapshot_id_list *s)
 	darray_exit(&grabbed);
 }
 
+static int
+bch2_iter_vfs_inodes(
+        struct super_block      *sb,
+        ino_iter_fn             iter_fn,
+        void                    *private_data,
+        int                     flags)
+{
+	struct bch_inode_info *inode, *old_inode = NULL;
+	int ret = 0;
+
+	mutex_lock(&c->vfs_inodes_lock);
+	list_for_each_entry(inode, &c->vfs_inodes_list, ei_vfs_inode_list) {
+		if (!super_iter_iget(&inode->v, flags))
+			continue;
+
+		if (!(flags & INO_ITER_UNSAFE))
+			mutex_unlock(&c->vfs_inodes_lock);
+
+		ret = iter_fn(VFS_I(ip), private_data);
+		cond_resched();
+
+		if (!(flags & INO_ITER_UNSAFE)) {
+			if (old_inode)
+				iput(&old_inode->v);
+			old_inode = inode;
+			mutex_lock(&c->vfs_inodes_lock);
+		}
+
+		if (ret == INO_ITER_ABORT) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+	}
+	if (old_inode)
+		iput(&old_inode->v);
+	return ret;
+}
+
 static int bch2_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct super_block *sb = dentry->d_sb;
@@ -1995,6 +2035,7 @@ static const struct super_operations bch_super_operations = {
 	.put_super	= bch2_put_super,
 	.freeze_fs	= bch2_freeze,
 	.unfreeze_fs	= bch2_unfreeze,
+	.iter_vfs_inodes = bch2_iter_vfs_inodes
 };
 
 static int bch2_set_super(struct super_block *s, void *data)
-- 
2.45.2


