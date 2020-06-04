Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2F1EDFFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 10:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFDIp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 04:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgFDIp0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:45:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2739DC05BD1E;
        Thu,  4 Jun 2020 01:45:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so2976714pfc.5;
        Thu, 04 Jun 2020 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5J9A6lfEIObP5lEW2ah6UPa6UJFkXGi0PKa9x9e+BPk=;
        b=VcksE1Z9PYhl6Z7MtI2mY9kDfsZ8adYUd52OWI63HJfKMvWh8xvy/UkUm1T+tW1eQu
         oj2EwWyq8s8pgIN3vOhpJye/qRO3IU+BqQwTWNDftwthVBREEv9M4gdEbRTzk/RcaYR+
         w79RUuQqk5JGppA5P19LrXRsxhswTbYy9P85Z6iR1FSmHCbmDnBdhxd3CSpUjpVto811
         VoBmKWIwfJALUVGVvgetHir5cyD0HmtMH5F2rGAZhVxgD7NcIYU45iVmyheTh5EGCk8+
         /GIiU6B3/u+ihm8WMdt4UkSf5igsIEY3uLIJsZAxUpfKNo6qUFBAL2hZ2m8t2ReWXTJ+
         CY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5J9A6lfEIObP5lEW2ah6UPa6UJFkXGi0PKa9x9e+BPk=;
        b=iKNlKKF9UUqUhXE65pkqL/2nimS2DMB9cQ7WvuoxeN8Q9EWJPjkBkINL1QG7hFdQ3P
         WMqridNr4EB1Vwy8jaBkk0H5LPjCM2ZsA6FusLajX9YKPEREYOR9C1tHFY6NYYluodHy
         Zo0R3kl4wQ/5Go4OEI37NTiHAlbLFFimPLgwv5u0LslBAoZCkfSMexFUDmLTTrJ+wpsS
         94fEIUDzYsBZVZk7nP09T+c0xHtS2lIPoZEI+SsJQNhevNrx0WEJmelLN7vgF3mTs0ia
         fFAU60Gq/lIoiftDEPTiw0sD3rp+28QWyvLFthBuDBf/1CtKrzWCzb7q5fkd/BARSMrH
         PsOA==
X-Gm-Message-State: AOAM530gZPwBS3jr9Z4SWLS7nrlCJq1eto3Fjy7LPEjceUcwYImhPTnO
        5EhM0uFKQQfIKvH5QqxKWlE=
X-Google-Smtp-Source: ABdhPJyshvh/H5llCM5E71362fTjGMDuMog1e2ot/OxXy5IGo2arHQvIWsLPHIvwSCbcb7oi3bPvIg==
X-Received: by 2002:a63:5307:: with SMTP id h7mr3485041pgb.28.1591260325649;
        Thu, 04 Jun 2020 01:45:25 -0700 (PDT)
Received: from dc803.flets-west.jp ([2404:7a87:83e0:f800:39b2:3392:bee8:f3be])
        by smtp.gmail.com with ESMTPSA id y6sm4770565pjw.15.2020.06.04.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:45:24 -0700 (PDT)
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
To:     kohada.t2@gmail.com
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] exfat: optimize exfat_zeroed_cluster()
Date:   Thu,  4 Jun 2020 17:44:43 +0900
Message-Id: <20200604084445.19205-2-kohada.t2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200604084445.19205-1-kohada.t2@gmail.com>
References: <20200604084445.19205-1-kohada.t2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace part of exfat_zeroed_cluster() with exfat_update_bhs().
And remove exfat_sync_bhs().

Signed-off-by: Tetsuhiro Kohada <kohada.t2@gmail.com>
---
 fs/exfat/fatent.c | 54 ++++++++++-------------------------------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 267e5e09eb13..5d11bc2f1b68 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -230,21 +230,6 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	return 0;
 }
 
-static inline int exfat_sync_bhs(struct buffer_head **bhs, int nr_bhs)
-{
-	int i, err = 0;
-
-	for (i = 0; i < nr_bhs; i++)
-		write_dirty_buffer(bhs[i], 0);
-
-	for (i = 0; i < nr_bhs; i++) {
-		wait_on_buffer(bhs[i]);
-		if (!err && !buffer_uptodate(bhs[i]))
-			err = -EIO;
-	}
-	return err;
-}
-
 int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 {
 	struct super_block *sb = dir->i_sb;
@@ -266,41 +251,24 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned int clu)
 	}
 
 	/* Zeroing the unused blocks on this cluster */
-	n = 0;
 	while (blknr < last_blknr) {
-		bhs[n] = sb_getblk(sb, blknr);
-		if (!bhs[n]) {
-			err = -ENOMEM;
-			goto release_bhs;
-		}
-		memset(bhs[n]->b_data, 0, sb->s_blocksize);
-		exfat_update_bh(sb, bhs[n], 0);
-
-		n++;
-		blknr++;
-
-		if (n == nr_bhs) {
-			if (IS_DIRSYNC(dir)) {
-				err = exfat_sync_bhs(bhs, n);
-				if (err)
-					goto release_bhs;
+		for (n = 0; n < nr_bhs && blknr < last_blknr; n++, blknr++) {
+			bhs[n] = sb_getblk(sb, blknr);
+			if (!bhs[n]) {
+				err = -ENOMEM;
+				goto release_bhs;
 			}
-
-			for (i = 0; i < n; i++)
-				brelse(bhs[i]);
-			n = 0;
+			memset(bhs[n]->b_data, 0, sb->s_blocksize);
 		}
-	}
 
-	if (IS_DIRSYNC(dir)) {
-		err = exfat_sync_bhs(bhs, n);
+		set_bit(EXFAT_SB_DIRTY, &sbi->s_state);
+		err = exfat_update_bhs(bhs, n, IS_DIRSYNC(dir));
 		if (err)
 			goto release_bhs;
-	}
-
-	for (i = 0; i < n; i++)
-		brelse(bhs[i]);
 
+		for (i = 0; i < n; i++)
+			brelse(bhs[i]);
+	}
 	return 0;
 
 release_bhs:
-- 
2.25.1

