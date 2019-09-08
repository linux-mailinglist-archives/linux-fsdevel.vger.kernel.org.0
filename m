Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F118AAD123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfIHXTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Sep 2019 19:19:03 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34766 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfIHXTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Sep 2019 19:19:03 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so5746785plr.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Sep 2019 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6uMksyYoQE2pF7FGUiDsdEdyfVo+lbVfSO3ifjA8fXY=;
        b=MMhE+g1E1klM3GkMUOXoVuIrg5F35jG9Fp0fFFgF8T1WvGR8mKBuORKcSbOf6JZ9fi
         5JZVDzs3CXlPPTVKejo301V6FkbOyxCwekmAT8TvcqFY8+i3VG7SkpIKoaBFii2tsaNf
         WEbIxgMIN5+jxpBGfhh+qHECzLIzU52RO36ePGtC/lBR9XsuwJj2ED5cHuDa8FkqY9aB
         AAZ/HK4ruGNY73iWuBQLk7dKBdjpTl1EmhJ8cw3fd6F/yetcOjbdm2VKzD6wtsnxDvzI
         hV3TVDBBE+3KB2r5hV/nLsmCKt0etczoBW2z1KZ1MZOcLErOS0QEbRzSsaVXCRlwNlbu
         2KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6uMksyYoQE2pF7FGUiDsdEdyfVo+lbVfSO3ifjA8fXY=;
        b=gCemEBEZNmcgZxsk50tmY5iMMf01snfAlBGT4UqH552CMNWuk8q/cXKKmRhNdLJpbr
         KBS/7lKFkPMMYnicsmttnWOTMLt7hxZAxBU4+ZirqQNHH+90qL+IzUKLm6R3075k9x++
         mPJym5XncQKnuiLnxt3A+5Pkid9rSonl66NgwfNdUKYnzM451M8MvXzX+XMu+eTTHsxq
         ef6+hBxH/PhJMBbOErRFba8npytIXI3EbqdGYKn61cOCgWor73NRIVjAkbaNQI6lEj3X
         ZFwbRQ6tmePhhVb6HkBdePORJAQpIzh+XZckB0iKM6ysX2uGD/SKM4PMhDXDKeui0NES
         T5yA==
X-Gm-Message-State: APjAAAXJDeh+U5oMZS5rAqI0FNvZKXJ9aszCY5UQ0yRexL/gcDKUfW39
        Y12rNtjejBFh2s7Djd0aKDmH
X-Google-Smtp-Source: APXvYqx8az6HHPPG8qGquQzVzZroFH+w7Yb0fkUIJ0hdikaAfDhkQYunKjRl6y+shJ06O8LY/q9x/w==
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr21041767plb.323.1567984737618;
        Sun, 08 Sep 2019 16:18:57 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id g8sm10832669pgk.1.2019.09.08.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 16:18:57 -0700 (PDT)
Date:   Mon, 9 Sep 2019 09:18:51 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: [PATCH v2 1/6] ext4: introduce direct IO read path using iomap
 infrastructure
Message-ID: <75a6ead09a10e362526a849af482510a0090f82a.1567978633.git.mbobrowski@mbobrowski.org>
References: <cover.1567978633.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1567978633.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new direct IO read path that makes use of the
iomap infrastructure.

The new function ext4_dio_read_iter() is responsible for calling into
the iomap infrastructure via iomap_dio_rw(). If the inode in question
does not pass preliminary checks in ext4_dio_checks(), then we simply
fallback to buffered IO and take that path to fulfil the request. It's
imperative that we drop the IOCB_DIRECT flag from iocb->ki_flags in
order to prevent generic_file_read_iter() from trying to take the
direct IO code path again.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 70b0438dbc94..e52e3928dc25 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -34,6 +34,53 @@
 #include "xattr.h"
 #include "acl.h"
 
+static bool ext4_dio_checks(struct inode *inode)
+{
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+	if (IS_ENCRYPTED(inode))
+		return false;
+#endif
+	if (ext4_should_journal_data(inode))
+		return false;
+	if (ext4_has_inline_data(inode))
+		return false;
+	return true;
+}
+
+static ssize_t ext4_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	ssize_t ret;
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Get exclusion from truncate and other inode operations.
+	 */
+	if (!inode_trylock_shared(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock_shared(inode);
+	}
+
+	if (!ext4_dio_checks(inode)) {
+		inode_unlock_shared(inode);
+		/*
+		 * Fallback to buffered IO if the operation being
+		 * performed on the inode is not supported by direct
+		 * IO. The IOCB_DIRECT flag flags needs to be cleared
+		 * here to ensure that the direct IO code path within
+		 * generic_file_read_iter() is not taken again.
+		 */
+		iocb->ki_flags &= ~IOCB_DIRECT;
+		return generic_file_read_iter(iocb, to);
+	}
+
+	ret = iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	return ret;
+}
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -64,16 +111,19 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(file_inode(iocb->ki_filp)->i_sb))))
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
 
 	if (!iov_iter_count(to))
 		return 0; /* skip atime */
 
-#ifdef CONFIG_FS_DAX
-	if (IS_DAX(file_inode(iocb->ki_filp)))
+	if (IS_DAX(inode))
 		return ext4_dax_read_iter(iocb, to);
-#endif
+
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return ext4_dio_read_iter(iocb, to);
 	return generic_file_read_iter(iocb, to);
 }
 
-- 
2.20.1

