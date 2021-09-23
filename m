Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2580F415FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbhIWNZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 09:25:50 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17279 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241320AbhIWNZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:25:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1632402523; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=DRn4vGd96dGD8cKVzzWUjNJKFPgjfCYBK0l1Frw9AqTe7+7FinjJ8MrKMKiydWBaeUP3MpTuKud+dPmMcHEzShsMq7FpAfoaCP7Udy2l2iyVCsWKAe3s4vPu4LCYrDMXkWrPfyVyL4eZBRICJUhXFHoGbSsEpguwMzTvmNaHVuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1632402523; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=THw0YvMlxjX1i71lpc4CHFA+3w1dXqVfXs694rHAFw0=; 
        b=MIAWSmelOd6p6i+AbbwfXjUZH1yPjBxaL/6JELlFuwbzO6KAylw3IljmmdRK7oIrRglfaEv5KUU41xDDHf9+oRBjq/IUbk3LSNdJY1WF6pSucd8apH1Cwniy3l62wAxjcwee2Oir1jRfsgoCe+cP5d6C9M3c/XnhpSXSmWLt8+I=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1632402523;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=THw0YvMlxjX1i71lpc4CHFA+3w1dXqVfXs694rHAFw0=;
        b=XWkTWpTIMjshz23RcCmTbnXDGGJxrJC4OAeiH5+AHTLm2qjREUfJsWJ3AGcWkBQn
        FRJyHnNlgBqolSkPsFGEoIh/7icBqaemuIu4uRm+Bub0i5FCFqlfnJfwa/0eYE0frot
        Q8E9qR0ldZNehaayd1aQSNTWqqn+HRu9BEeWvFuA=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1632402522263998.249844109196; Thu, 23 Sep 2021 21:08:42 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20210923130814.140814-10-cgxu519@mykernel.net>
Subject: [RFC PATCH v5 09/10] fs: introduce new helper sync_fs_and_blockdev()
Date:   Thu, 23 Sep 2021 21:08:13 +0800
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210923130814.140814-1-cgxu519@mykernel.net>
References: <20210923130814.140814-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs needs to call upper layer's ->sync_fs
and __sync_blockdev() to sync metadata during syncfs(2).

Currently, __sync_blockdev() does not export to module
so introduce new helper sync_fs_and_blockdev() to wrap
those operations.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/sync.c          | 14 ++++++++++----
 include/linux/fs.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 1373a610dc78..36c755e6568a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -21,6 +21,15 @@
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
 =09=09=09SYNC_FILE_RANGE_WAIT_AFTER)
=20
+
+int sync_fs_and_blockdev(struct super_block *sb, int wait)
+{
+=09if (sb->s_op->sync_fs)
+=09=09sb->s_op->sync_fs(sb, wait);
+=09return __sync_blockdev(sb->s_bdev, wait);
+}
+EXPORT_SYMBOL(sync_fs_and_blockdev);
+
 /*
  * Do the filesystem syncing work. For simple filesystems
  * writeback_inodes_sb(sb) just dirties buffers with inodes so we have to
@@ -34,10 +43,7 @@ static int __sync_filesystem(struct super_block *sb, int=
 wait)
 =09=09sync_inodes_sb(sb);
 =09else
 =09=09writeback_inodes_sb(sb, WB_REASON_SYNC);
-
-=09if (sb->s_op->sync_fs)
-=09=09sb->s_op->sync_fs(sb, wait);
-=09return __sync_blockdev(sb->s_bdev, wait);
+=09return sync_fs_and_blockdev(sb, wait);
 }
=20
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..e5ebf126281c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2777,6 +2777,7 @@ static inline bool sb_is_blkdev_sb(struct super_block=
 *sb)
=20
 void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
+extern int sync_fs_and_blockdev(struct super_block *sb, int wait);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
=20
--=20
2.27.0


