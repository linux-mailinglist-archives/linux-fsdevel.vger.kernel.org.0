Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E24679E50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfG3Bv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:51:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46903 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbfG3Bue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id k189so10122804pgk.13;
        Mon, 29 Jul 2019 18:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3/DjHVGVi/F7aqXCng/e3omBwsQcSJR2eYgFJqv7Mc=;
        b=MHJi7qDWRMASA2QX3F2ibh+beP9hQfu4y/3XWxnFZrpKupkIBJ7aQg41m49kU4QqxZ
         e2h5S1+q23g0nf2Z3vFkkxBFads7S8im6K2WahdPuX7rx7O+rUwONCjTxE2hBDr3jP3I
         t/rN8zsaFDZY1fdh2Ji4f/uUNvUEuEO2GdqrTIRZ69z074luty63vB7VOPbi/IN+Dr02
         DkIugKH5IuWRHXxC5yjTrSRjbbYhcJnRhB8MNPd+lHVO9xRmL8MLOZWQkQWo/fzvCkJV
         S3WCaDQ11GZb4mHYqfO5hLNfgpFn0Au5PhN8BsBl0gQQC5JxqUPOg61Px4p54kb5y+Cf
         BqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3/DjHVGVi/F7aqXCng/e3omBwsQcSJR2eYgFJqv7Mc=;
        b=YglheY5XE7NE2A7DhqEATlJiUc/2U1Rtz/bjhstivGaCNRPpDafA3AhaePaEpXG2cm
         vc6wwPY0ugmNEsZhG2HYkfb/n8xjYuDV06AgN8T2+7kTthK9V1IvQVR+Ragm/iN/UjYx
         gQyJVjxQ/Jarse5eyd8VVCc13mfyznb4w1AG7STo0RPeT/yCN6kbpMeDNtIjouBF9yb8
         CAUD5p1qDXVQrH3KenInMPHoLuIvRYAXur1UXIXLR43ZkFo9S1vJJYzh3cnAeMV5X3iu
         mBYvllcBiBpUxjZVhhnkYcAc1LlLxIBhqnC3auHuexlRPKzpu1IdUBhIPBMLwj7z7FEI
         28QA==
X-Gm-Message-State: APjAAAUMP0/Yk72myp+p7n8Aefrlib6CPYjb4RbPMB2u6Yr5VlYu5tO5
        +49YhSDZnkdAndi5mqxTfMavPGpK6Gc=
X-Google-Smtp-Source: APXvYqw57XCWaQyUqG42LYuM47RZdiFqd+cXrmNyi0MvSlqoJu3ygzgQo+qtS2WAhgSGWrF2osL52Q==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr39695235pjr.60.1564451434099;
        Mon, 29 Jul 2019 18:50:34 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:33 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, dsterba@suse.com
Subject: [PATCH 13/20] fs: affs: Initialize filesystem timestamp ranges
Date:   Mon, 29 Jul 2019 18:49:17 -0700
Message-Id: <20190730014924.2193-14-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

Also fix timestamp calculation to avoid overflow
while converting from days to seconds.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: dsterba@suse.com
---
 fs/affs/amigaffs.c | 2 +-
 fs/affs/amigaffs.h | 3 +++
 fs/affs/inode.c    | 4 ++--
 fs/affs/super.c    | 4 ++++
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index 14a6c1b90c9f..f708c45d5f66 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -375,7 +375,7 @@ affs_secs_to_datestamp(time64_t secs, struct affs_date *ds)
 	u32	 minute;
 	s32	 rem;
 
-	secs -= sys_tz.tz_minuteswest * 60 + ((8 * 365 + 2) * 24 * 60 * 60);
+	secs -= sys_tz.tz_minuteswest * 60 + AFFS_EPOCH_DELTA;
 	if (secs < 0)
 		secs = 0;
 	days    = div_s64_rem(secs, 86400, &rem);
diff --git a/fs/affs/amigaffs.h b/fs/affs/amigaffs.h
index f9bef9056659..81fb396d4dfa 100644
--- a/fs/affs/amigaffs.h
+++ b/fs/affs/amigaffs.h
@@ -32,6 +32,9 @@
 
 #define AFFS_ROOT_BMAPS		25
 
+/* Seconds since Amiga epoch of 1978/01/01 to UNIX */
+#define AFFS_EPOCH_DELTA ((8 * 365 + 2) * 86400LL)
+
 struct affs_date {
 	__be32 days;
 	__be32 mins;
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 73598bff8506..a346cf7659f1 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -150,10 +150,10 @@ struct inode *affs_iget(struct super_block *sb, unsigned long ino)
 	}
 
 	inode->i_mtime.tv_sec = inode->i_atime.tv_sec = inode->i_ctime.tv_sec
-		       = (be32_to_cpu(tail->change.days) * (24 * 60 * 60) +
+		       = (be32_to_cpu(tail->change.days) * 86400LL +
 		         be32_to_cpu(tail->change.mins) * 60 +
 			 be32_to_cpu(tail->change.ticks) / 50 +
-			 ((8 * 365 + 2) * 24 * 60 * 60)) +
+			 AFFS_EPOCH_DELTA) +
 			 sys_tz.tz_minuteswest * 60;
 	inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = inode->i_atime.tv_nsec = 0;
 	affs_brelse(bh);
diff --git a/fs/affs/super.c b/fs/affs/super.c
index e7d036efbaa1..cc463ae47c12 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -355,6 +355,10 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op                = &affs_sops;
 	sb->s_flags |= SB_NODIRATIME;
 
+	sb->s_time_gran = NSEC_PER_SEC;
+	sb->s_time_min = sys_tz.tz_minuteswest * 60 + AFFS_EPOCH_DELTA;
+	sb->s_time_max = 86400LL * U32_MAX + 86400 + sb->s_time_min;
+
 	sbi = kzalloc(sizeof(struct affs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		return -ENOMEM;
-- 
2.17.1

