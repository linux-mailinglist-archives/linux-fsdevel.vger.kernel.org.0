Return-Path: <linux-fsdevel+bounces-32716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62C39AE0AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 11:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C521F246C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 09:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CE1CBA07;
	Thu, 24 Oct 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cenCSqyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D31CACEE;
	Thu, 24 Oct 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761996; cv=none; b=GpV//6DP5MhphVA81Meq5HGum94JVeOf9dBb9aL+CvUYgpR6CvC24PYjVwF8BKE3RLw8UOs8f64JNzJLChlvi83DdQnoIa3Y3exUpD0vquOS+ZpXAanMgdCm2uQ6jubi5cYTeEA87TkAZxre1aoLDg4P+2YaKHRP4jLUtxASa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761996; c=relaxed/simple;
	bh=gI5r6WxghRNbaB4222Ow6J8HwbUxosES6vp+uQE8wT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN05RX94isV25BYWYqeDpaIVWMMM96DVKqoRcnR8oEqEaW4lNWZi/LlWgEdivSGQqU8CB8cRulp+yEmzyapgHf/Cbpic3EBGO37qJtrjR0SoUpCmdrXxG1ZRT78gna5QqOFTPOwMDe5kYYwpSS+ZYxKz3wRVOmRkSvqL6vpofKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cenCSqyO; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e7e1320cabso283057eaf.0;
        Thu, 24 Oct 2024 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729761989; x=1730366789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uByvF+p9sfUcjbc3juszjPemeC33hYqCK/m9ejh7ku8=;
        b=cenCSqyO3S6BVIjZ5cPyVfngnhDvL/d9Z8ECythjpXdb1d0Ge3f5hYswUgv/rYyzsM
         YKJhFJ3cRY/P7lMKdjVRNR9r0zyNGCAQjweUY1FlkNMJ9yCcFd3pJVL+25WLiVoV2XjZ
         FKWxRtG1ZFG0IoRAbLtNCLPYoR9v5jB5NJs+HydfUoG+2JmOpVP5PBphvEBNzUpDmXyy
         sdDJcK+sEhEO3UkkpUjFHWdALeo12nhQ+ZLUkJ44ZrEl29+dq/yQisbgabaXGP7ljMq1
         dnPaCQ8DpFsGt6AH9ZwheJ9nkt0/Wil/Z43IaROOmAu30pD4t0D13pzi4QgYtkWKR20P
         9ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761989; x=1730366789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uByvF+p9sfUcjbc3juszjPemeC33hYqCK/m9ejh7ku8=;
        b=dpgNgX3ACEfzv8pO4ZCqmReMzhpJh5GQLUWJo0rSFD8jH+lUPD+GTTN3V1ZEKTzT+W
         EHVTGUOHMyw0ult1Y1uWEcDaVsbasuBjOv4WyuP2/+5ujUfAqYsjdRwFTQwE9IrymS5X
         kJoTDOwvHys4kUA9s/O6bxTjx1ni2YX5nJpsBBbju+FGyYEQO7MPkXhttSZ2QgsA+/mi
         8Kjp77Y67JZ3IX76E/EEHfpwm2w1kovH/iDbfJNf+ivg/ubeF0BI28b/pxl/vd92tvrF
         +rne85eUndTBnuZ/zl/LDpMFcRlOwwGoejwOMtsPcaTUO9zGkzZriMYJBQG5JJXbBD87
         ULuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5fv1oTne9LP8icDTx7gMdrWOWtSOk7JeSsOzrhIUqWPUMrM41Mt3p2pVBDqmLEAQSCvsbs7ce3a+GTsY=@vger.kernel.org, AJvYcCVt17rtgCVHMXhkL0D2fUalkLAnZwNRfuZTCdU1JMVZKKsK8bBQBXC+zXeOBXpb830B24NL7cyT4TQoe0TR@vger.kernel.org, AJvYcCXe6zKdrvyXV2RP65TX7qYAFwCf/RmblhBylF3K8O6kkEDwMP86XJ+shwIpf3QtAgg3/9Yz+n5002bBEd83@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz+0OJhiGsmoO0excgqb474azKkS191+7zaF8pbsQ3Sx2lG0N2
	amc9lTOswAWDeW2T49ktUvNYsvWZ8+LVGJRguzsAhGsAd8vqCHuX
X-Google-Smtp-Source: AGHT+IEfzOe49P4Bt14+CWfuNgq3/ZfrLUbVLpMvO1IY7qyylHG+wsjwmkiTLExkIbZBLS1JIQGgiw==
X-Received: by 2002:a05:6870:392b:b0:27b:b2e0:6a5 with SMTP id 586e51a60fabf-28ccb774520mr6181526fac.3.1729761989369;
        Thu, 24 Oct 2024 02:26:29 -0700 (PDT)
Received: from carrot.. (i118-19-49-33.s41.a014.ap.plala.or.jp. [118.19.49.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d774fsm7608906b3a.106.2024.10.24.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:26:28 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] nilfs2: Remove nilfs_writepage
Date: Thu, 24 Oct 2024 18:25:43 +0900
Message-ID: <20241024092602.13395-10-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
References: <20241024092602.13395-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Since nilfs2 has a ->writepages operation already, ->writepage is only
called by the migration code.  If we add a ->migrate_folio operation,
it won't even be used for that and so it can be deleted.

[ konishi.ryusuke: fixed panic by using buffer_migrate_folio_norefs ]
Link: https://lkml.kernel.org/r/20241002150036.1339475-2-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index be6acf6e2bfc..c24f06268010 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -170,37 +170,6 @@ static int nilfs_writepages(struct address_space *mapping,
 	return err;
 }
 
-static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	int err;
-
-	if (sb_rdonly(inode->i_sb)) {
-		/*
-		 * It means that filesystem was remounted in read-only
-		 * mode because of error or metadata corruption. But we
-		 * have dirty pages that try to be flushed in background.
-		 * So, here we simply discard this dirty page.
-		 */
-		nilfs_clear_folio_dirty(folio);
-		folio_unlock(folio);
-		return -EROFS;
-	}
-
-	folio_redirty_for_writepage(wbc, folio);
-	folio_unlock(folio);
-
-	if (wbc->sync_mode == WB_SYNC_ALL) {
-		err = nilfs_construct_segment(inode->i_sb);
-		if (unlikely(err))
-			return err;
-	} else if (wbc->for_reclaim)
-		nilfs_flush_segment(inode->i_sb, inode->i_ino);
-
-	return 0;
-}
-
 static bool nilfs_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
@@ -295,7 +264,6 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 }
 
 const struct address_space_operations nilfs_aops = {
-	.writepage		= nilfs_writepage,
 	.read_folio		= nilfs_read_folio,
 	.writepages		= nilfs_writepages,
 	.dirty_folio		= nilfs_dirty_folio,
@@ -304,6 +272,7 @@ const struct address_space_operations nilfs_aops = {
 	.write_end		= nilfs_write_end,
 	.invalidate_folio	= block_invalidate_folio,
 	.direct_IO		= nilfs_direct_IO,
+	.migrate_folio		= buffer_migrate_folio_norefs,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 };
 
-- 
2.43.0


