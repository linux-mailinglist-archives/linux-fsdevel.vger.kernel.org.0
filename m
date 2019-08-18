Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C529691832
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfHRRAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 13:00:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43004 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfHRQ77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so5501093pgb.9;
        Sun, 18 Aug 2019 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3J/tBreUSwmCA21c4aXcQcRD2d0OTlcA32UpOssIiE8=;
        b=gZwJ5HE2pHL1eTvcl02IMavV2M+r9J5ekcI4osMw8oKeg/9n0tSfpp3ucUd14xTF0k
         Gnzd4zmGvhyTDlODzTE0d8CNyAVr+htyfETwQ0L09gLGLkEpzfZq2sRwNb0a5//dZFqP
         OgTCs6xoNBT94V7xRjnYWdX6ZeHl04Ke2EbbQ0yYK4V1Z1Jb9KGTIKwS95V3ZNDolL2Q
         sNunkDpySOe+TfMD1S36VPZa3gtFES9UBOM+4Oo58mM0mVJdbThPAUfZdA5aeRSaL94n
         mA/xy5PTWuytM80F9CiYIusm3YnU5tR4XHR3X02aGOEHhIdQP97CIpsVnpbFzbpLke7m
         jjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3J/tBreUSwmCA21c4aXcQcRD2d0OTlcA32UpOssIiE8=;
        b=pD4RqzvcB2h7s58tzirTSPGpu22qMXjIsWrnTu90IWdpKzRK88ApFmksby50JWeDvS
         L2EsSP8QkrtUQY1S6cDZ9SGpiE9AqusYyTydUTGIYRFdXaTqf1FPQOfLt9redK/ly5zl
         1/K/HPbsgfj6EK93bp2LM0FT1wJV8HmHRJ93Osf1mMHKV52UwtghV/FnT00j+02FAoH1
         y4yxRzLZ9spKxfhV/IaX/vNHkHLWwXOZeoWf5WENkYyjbQPuS2TY5Fcakm2/Rc+d771m
         X57XY4skr2n26/ow3aFgxAzKYwyAyvWH5bhE0q/9M6U/TGpp2hQLS5AgjJeZhi90KABt
         k0jg==
X-Gm-Message-State: APjAAAWS4uz0k751i/MHiM7+wqBplqeueqRw3YzVfhH3c8Jd+P3kGSdo
        1FuwZPqxXGJM4OdO/hHsOiU=
X-Google-Smtp-Source: APXvYqzaNkM2HJbDHBWrBAPb+F5hpzNQpnHsP945rT4hwd4QMhQLtKT0BtFu+J+65VjwnowJkYIXlA==
X-Received: by 2002:a63:62c6:: with SMTP id w189mr16322750pgb.312.1566147598968;
        Sun, 18 Aug 2019 09:59:58 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:58 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de, dsterba@suse.com
Subject: [PATCH v8 13/20] fs: affs: Initialize filesystem timestamp ranges
Date:   Sun, 18 Aug 2019 09:58:10 -0700
Message-Id: <20190818165817.32634-14-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
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
Acked-by: David Sterba <dsterba@suse.com>
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

