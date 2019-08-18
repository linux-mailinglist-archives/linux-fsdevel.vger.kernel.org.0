Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA89180F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 19:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfHRQ7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38494 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfHRQ7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so5505905pga.5;
        Sun, 18 Aug 2019 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rUBVEJFml8xN/3NysGyzbXTdVn2u+LQ/JuruhLlfDg=;
        b=pitzbBHZsC1uM0DL/w98n1NkYkBv923i14v+6uF3OjXUnuFklYRxPvDOOnm7pXQdRd
         oO+y1taV/sMp/pDxW2kA7wRLIwmAk2aBWajXPvIftBYk4mJZplMsv16UaFaHsuJIZNrT
         /0szjiFztu/xE2imziHMT0jT8VYx5yr1hAzNJtH7evNH/VPg2ZPS6rZJG7is2cnHZy+Q
         9ye5q9vFZXdm5wfbF9B2NN+USdQERWmpQSHh+BNeUpjthdov6iZTRSAKRJ4kPHXiIbcn
         LldQw5HHIAPwgGlcZruQ9ylZWCxDm/7mnYoc83+uu2dvfnE7DWs62B0OGJdZlquGVkIA
         vuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rUBVEJFml8xN/3NysGyzbXTdVn2u+LQ/JuruhLlfDg=;
        b=s9BUfoW3s19RwidWjqSLqFdFzfO/V3VcCHQnzMstfzBvnLchz+q9WUgIcTluMjjRSS
         t6jRkAVTtXppIPDEVASJlyI8R0o/2DFDby+ZlxdreibTumNnhu88yx+3dsq16qD5Q+F1
         6OZ7NJ5GxmhRxRvY3vvAfc3W00RCuC2t32HRWhugV08yaS7htrTh8UOJDPixX54Lxb3v
         lpc48sKXiGkyCoUsskYN2Anu0MU6CqZPsiTFBxCtUASoT6ZveZ/TGDqwYtbO6gBBvG9E
         mVUDVxEVLr2w845G4mDiPP3+AsEpFfh+gKsUF0y9emuNRNXdcagwf51SFURpZa0wG6V/
         vlVg==
X-Gm-Message-State: APjAAAVq+/cHHxTaxAdEt5k4HSpecSBx3LJOUndpIriVV91xzJ8tk/wh
        vSOqRFIuIWtFzPPPOAWocJU=
X-Google-Smtp-Source: APXvYqwSEVrmo7MbgR7WT42005XrBMQC2eEXpXo+oxpUZuKIOAKm0W6XYP6C9mEpzMFD+JZMb4n+FA==
X-Received: by 2002:a63:4042:: with SMTP id n63mr5870840pga.75.1566147579569;
        Sun, 18 Aug 2019 09:59:39 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:39 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 04/20] mount: Add mount warning for impending timestamp expiry
Date:   Sun, 18 Aug 2019 09:58:01 -0700
Message-Id: <20190818165817.32634-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The warning reuses the uptime max of 30 years used by
settimeofday().

Note that the warning is only emitted for writable filesystem mounts
through the mount syscall. Automounts do not have the same warning.

Print out the warning in human readable format using the struct tm.
After discussion with Arnd Bergmann, we chose to print only the year number.
The raw s_time_max is also displayed, and the user can easily decode
it e.g. "date -u -d @$((0x7fffffff))". We did not want to consolidate
struct rtc_tm and struct tm just to print the date using a format specifier
as part of this series.
Given that the rtc_tm is not compiled on all architectures, this is not a
trivial patch. This can be added in the future.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/namespace.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index bfcb4e341257..7fcf289593c5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2468,6 +2468,26 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	unlock_mount_hash();
 }
 
+static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
+{
+	struct super_block *sb = mnt->mnt_sb;
+
+	if (!__mnt_is_readonly(mnt) &&
+	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
+		char *buf = (char *)__get_free_page(GFP_KERNEL);
+		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
+		struct tm tm;
+
+		time64_to_tm(sb->s_time_max, 0, &tm);
+
+		pr_warn("Mounted %s file system at %s supports timestamps until %04ld (0x%llx)\n",
+			sb->s_type->name, mntpath,
+			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
+
+		free_page((unsigned long)buf);
+	}
+}
+
 /*
  * Handle reconfiguration of the mountpoint only without alteration of the
  * superblock it refers to.  This is triggered by specifying MS_REMOUNT|MS_BIND
@@ -2493,6 +2513,9 @@ static int do_reconfigure_mnt(struct path *path, unsigned int mnt_flags)
 	if (ret == 0)
 		set_mount_attributes(mnt, mnt_flags);
 	up_write(&sb->s_umount);
+
+	mnt_warn_timestamp_expiry(path, &mnt->mnt);
+
 	return ret;
 }
 
@@ -2533,6 +2556,9 @@ static int do_remount(struct path *path, int ms_flags, int sb_flags,
 		}
 		up_write(&sb->s_umount);
 	}
+
+	mnt_warn_timestamp_expiry(path, &mnt->mnt);
+
 	put_fs_context(fc);
 	return err;
 }
@@ -2741,8 +2767,13 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 		return PTR_ERR(mnt);
 
 	error = do_add_mount(real_mount(mnt), mountpoint, mnt_flags);
-	if (error < 0)
+	if (error < 0) {
 		mntput(mnt);
+		return error;
+	}
+
+	mnt_warn_timestamp_expiry(mountpoint, mnt);
+
 	return error;
 }
 
-- 
2.17.1

