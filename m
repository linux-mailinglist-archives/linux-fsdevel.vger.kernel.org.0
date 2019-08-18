Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCF091803
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfHRQ7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 12:59:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43721 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRQ7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id v12so5713554pfn.10;
        Sun, 18 Aug 2019 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X4S1jP6JxbrAY5LAlhL0l2T5ZB0TobcoF1e+jYIC6JQ=;
        b=L8MGPefZg6eIgQo4yOxgeyqLU8H+1bvdtduSoRT5Ec2z+4+IkPoB9EHXeBRYFIz9fR
         XWv0lyov3QoGlAZ6lVt8haaPGWu56dtc1qPy3rhA8hwEfr4HlTwSMXPGp1/eG3UrBUd5
         ls4STrMCAoaRoAOm3kdYO8zwZAjpelo6sx/uyGaSjkpMJaYMI6G13Vg7lQqgxbFB38jX
         8+O0jwzSqLRCP8GVg968HRV7QCps92kz3HwdDvIdNtj/kXW+I71kRsFflDSFAaOpmEWY
         sedUHq0l2PYiWKKG0hw/uy+V+IivljpG5l1WsEuouKcxrAhyhyYETbZ2TiMIe3QiHrk6
         cICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X4S1jP6JxbrAY5LAlhL0l2T5ZB0TobcoF1e+jYIC6JQ=;
        b=g5n9BnCUn577+peEhJJ4rLTMOywysyONrg2WSSyExgV5YkfkQGZWDzDw5l+aor0OKq
         4f2RB9m9gP1AtXPmunXaY0KT0iZNVP8PjydrJdjNeUi4djtRsV/nbhKrCOg5dLHLLvnP
         IM8g4BhUaB8hG4hUl0lEj4Yis/jYHJIQJ0ajh9ChnRIIxCOtbg3JpzlO0HkypcMgEKs5
         iDhXnAP69xUarLdF2B+Mu8BJEg25qnVT22MEHt4mBEIB2U0TBHzviTgZAagLo8kPLdrD
         OPFLkPSEZz8Wuw3xQXcsgiOinIZ1zzCUkRy0JAdWEaANx/6LAmF0LfZHR1IUta6F0ADL
         bndg==
X-Gm-Message-State: APjAAAUwaX3ZKuiFJ+vD3So6uMVtofhd5dBlhyMFI/2kBvmk9mHXdrzN
        wPoRlWkiEzHz6PvdV60nMpuEenzE
X-Google-Smtp-Source: APXvYqxENSxuYopBbdzr3b3DEoqjxPe1GP+G2AQGOYdXsR8ZldanKgFojrfRhtv58BmKEbttL2c/GQ==
X-Received: by 2002:a63:3dcd:: with SMTP id k196mr16606794pga.45.1566147574845;
        Sun, 18 Aug 2019 09:59:34 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id b136sm15732831pfb.73.2019.08.18.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 09:59:34 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        arnd@arndb.de
Subject: [PATCH v8 02/20] vfs: Add timestamp_truncate() api
Date:   Sun, 18 Aug 2019 09:57:59 -0700
Message-Id: <20190818165817.32634-3-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

timespec_trunc() function is used to truncate a
filesystem timestamp to the right granularity.
But, the function does not clamp tv_sec part of the
timestamps according to the filesystem timestamp limits.

The replacement api: timestamp_truncate() also alters the
signature of the function to accommodate filesystem
timestamp clamping according to flesystem limits.

Note that the tv_nsec part is set to 0 if tv_sec is not within
the range supported for the filesystem.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c         | 33 ++++++++++++++++++++++++++++++++-
 include/linux/fs.h |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index ef33fdf0105f..fef457a42882 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2169,6 +2169,37 @@ struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran)
 }
 EXPORT_SYMBOL(timespec64_trunc);
 
+/**
+ * timestamp_truncate - Truncate timespec to a granularity
+ * @t: Timespec
+ * @inode: inode being updated
+ *
+ * Truncate a timespec to the granularity supported by the fs
+ * containing the inode. Always rounds down. gran must
+ * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
+ */
+struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
+{
+	struct super_block *sb = inode->i_sb;
+	unsigned int gran = sb->s_time_gran;
+
+	t.tv_sec = clamp(t.tv_sec, sb->s_time_min, sb->s_time_max);
+	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
+		t.tv_nsec = 0;
+
+	/* Avoid division in the common cases 1 ns and 1 s. */
+	if (gran == 1)
+		; /* nothing */
+	else if (gran == NSEC_PER_SEC)
+		t.tv_nsec = 0;
+	else if (gran > 1 && gran < NSEC_PER_SEC)
+		t.tv_nsec -= t.tv_nsec % gran;
+	else
+		WARN(1, "invalid file time granularity: %u", gran);
+	return t;
+}
+EXPORT_SYMBOL(timestamp_truncate);
+
 /**
  * current_time - Return FS time
  * @inode: inode.
@@ -2190,7 +2221,7 @@ struct timespec64 current_time(struct inode *inode)
 		return now;
 	}
 
-	return timespec64_trunc(now, inode->i_sb->s_time_gran);
+	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 93c440d22547..1170d8260aa2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -737,6 +737,8 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
+struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
+
 static inline unsigned int i_blocksize(const struct inode *node)
 {
 	return (1 << node->i_blkbits);
-- 
2.17.1

