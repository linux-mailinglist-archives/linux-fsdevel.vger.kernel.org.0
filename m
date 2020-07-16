Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2DE221EB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgGPInD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgGPInA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:43:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D7BC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:43:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so6190457wrs.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t8HX3T30YFpWehvlFQBIGM0mnagKMhXY8ru6f3KVWCQ=;
        b=KwFaMThXXg/rbRioI8k4lKUxhorsCqwBFU7GiLVg3N4xUslggWxjRCvKjPNdx2i99a
         wHF+6J0fldOoBXs6pyJsH9mM7O+JpyesTLjbgTarE7Qt6Oa7rVNoMB/LNOIiSzXhYmNk
         +HmogQJjYJC9yIjr4sqiIawkorsaTbCuySnLOKf3oLwOkCPJRrj+UXwQQTQWDpXrJvcU
         WKa+BOZXuo2f3AH8Ph0xrhWP1Nk87SsOLmUwUrnX1zRhFVok96v2JJjixel5/H7mtUJH
         gu1pf6kkBhzGxqPrTlCUd7gttvgOI/yfZmRy9h1QW2iKNqg+kJopW1J7VwKgHZJ1w284
         ZAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t8HX3T30YFpWehvlFQBIGM0mnagKMhXY8ru6f3KVWCQ=;
        b=ODQUb1UCdD/9Z1sYRLwC0Ch/JdA/sowyb1rTpb41PI0Ed+VP3pIYCAcR90hxeOz6p/
         bYxK6IUzmEejkq9wfloA3UMgaTKk+xUchOmZwsEON+SLUxA3dmWN0hnsVI30vUM4T+p9
         MeyBG3vInJ+88dkP6J5ShbJxiUpMyRii3uhlqr4uNMHXHZyiaF/5LUqYLEDfdH4LsVS3
         F+v4tM4cTZ9pJZZV4w+qbjUxlvl0monjvXzjq6L+MeGraru6iR7kyyA3YbgiDll1WK7w
         2LU+7r/aoKTiE0VCypfocfDxp0lb5h3y4TiSvQZt12pPNyQGaT6XfpwT/g1E387buOdw
         wdKA==
X-Gm-Message-State: AOAM531qGznJerKnskR5Ezs41nqQYvWrJzm3xlXm5QYKrz8lLbDnm6af
        B5h3NQQoxND2rAlrYJI4lpE=
X-Google-Smtp-Source: ABdhPJzbrvGeGH0q7/t7ITQRejZ0yH/iP69AHGl0WCKt64D8bHCER85w11oL5sBzFXk6FrpHVGn89g==
X-Received: by 2002:a5d:4bc4:: with SMTP id l4mr3783848wrt.97.1594888978673;
        Thu, 16 Jul 2020 01:42:58 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:57 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 16/22] fsnotify: remove check that source dentry is positive
Date:   Thu, 16 Jul 2020 11:42:24 +0300
Message-Id: <20200716084230.30611-17-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the unneeded check for positive source dentry in
fsnotify_move().

fsnotify_move() hook is mostly called from vfs_rename() under
lock_rename() and vfs_rename() starts with may_delete() test that
verifies positive source dentry.  The only other caller of
fsnotify_move() - debugfs_rename() also verifies positive source.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 044cae3a0628..fe4f2bc5b4c2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -149,8 +149,7 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 	if (target)
 		fsnotify_link_count(target);
 
-	if (source)
-		fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
+	fsnotify(source, mask, source, FSNOTIFY_EVENT_INODE, NULL, 0);
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
-- 
2.17.1

