Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8115879E31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 03:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfG3Bu0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 21:50:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43564 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbfG3BuZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 21:50:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so28949573pfg.10;
        Mon, 29 Jul 2019 18:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o10DUO5dEIQstB6p+42EOsG96pidROgmozIpVkiPhZk=;
        b=AtD608eCTmGCbG2RQYuTeyjUti0VNtTfCfQ+vCcFRD8QDQZmw7/F8T6mE670/qTYNj
         31zi69dyn7ge70xQeKw5o2EYGqK9oaYEXotVW/WEbgtBnHEZXH8kIPbiBpr89RyMNPq9
         SdPoQsFtGTW2KfC03miJEC+JIE1MQLdiIwoIGflkA2v/8dcje9cA0WjIXE+VSRts3NRv
         jMHzFkskc3vie/+KbhBuP8CqduvHG/iugP3Xvs7lS4ktvWS4xB4seh19oxG5yr/n7DKD
         lToykY13dw15f6j9iL43VkEwNrUx1pVtcONfcnOJ5TKV2BE2L73KmeI2WZmauqY4eF7B
         +csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o10DUO5dEIQstB6p+42EOsG96pidROgmozIpVkiPhZk=;
        b=ZJZ/m0fFI+PvvAeLWo3j3pXhaG1UYc/nmVSEI84JA7o2Riu6Yy4iWwSIsGvp5gxV0G
         I05unEULeJyZUNZzzwS6G2mkyAyynY99lWPKUCpW3rLHwN528McUHftA2OQJigskZ5vN
         Bk8LMpl5CPxicwaLy8tM5tYe6tWtqxcTfUUFOYW5pvKHGAgRRg1tAMfJA33aD4ZdZ0L+
         Fwf5vt66LYa+3Mhvmr4k6QuNsZZ4PofTABUL3+vEoNjFP0QjameKqH7yNtZ6debKGViD
         aHAh+/sH6xSfiE7zqj5oUN8DiEf5KORbSu+pynjVkIk7AJWW62R5F1b77YNOR5igmxFS
         IQJQ==
X-Gm-Message-State: APjAAAXditTDlpyXkrtLQXLrH7F15QAZrYF5fFXtxP8IbMCBexBRmId5
        o6KjKCKjHMBHnOlW6YeFA0o=
X-Google-Smtp-Source: APXvYqwNoGUy/BYWsCRcIxS2wctsm4ggNIqk3MCZ3a8pDhKO9QuJPxZuEulwOvT7X2WWllFjpJxxVg==
X-Received: by 2002:aa7:96a4:: with SMTP id g4mr40955745pfk.193.1564451424669;
        Mon, 29 Jul 2019 18:50:24 -0700 (PDT)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r6sm138807156pjb.22.2019.07.29.18.50.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 18:50:24 -0700 (PDT)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org
Subject: [PATCH 05/20] utimes: Clamp the timestamps before update
Date:   Mon, 29 Jul 2019 18:49:09 -0700
Message-Id: <20190730014924.2193-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

POSIX is ambiguous on the behavior of timestamps for
futimens, utimensat and utimes. Whether to return an
error or silently clamp a timestamp beyond the range
supported by the underlying filesystems is not clear.

POSIX.1 section for futimens, utimensat and utimes says:
(http://pubs.opengroup.org/onlinepubs/9699919799/functions/futimens.html)

The file's relevant timestamp shall be set to the greatest
value supported by the file system that is not greater
than the specified time.

If the tv_nsec field of a timespec structure has the special
value UTIME_NOW, the file's relevant timestamp shall be set
to the greatest value supported by the file system that is
not greater than the current time.

[EINVAL]
    A new file timestamp would be a value whose tv_sec
    component is not a value supported by the file system.

The patch chooses to clamp the timestamps according to the
filesystem timestamp ranges and does not return an error.
This is in line with the behavior of utime syscall also
since the POSIX page(http://pubs.opengroup.org/onlinepubs/009695399/functions/utime.html)
for utime does not mention returning an error or clamping like above.

Same for utimes http://pubs.opengroup.org/onlinepubs/009695399/functions/utimes.html

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/utimes.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index 350c9c16ace1..4c1a2ce90bbc 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -21,6 +21,7 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 	int error;
 	struct iattr newattrs;
 	struct inode *inode = path->dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
 	struct inode *delegated_inode = NULL;
 
 	error = mnt_want_write(path->mnt);
@@ -36,16 +37,24 @@ static int utimes_common(const struct path *path, struct timespec64 *times)
 		if (times[0].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_ATIME;
 		else if (times[0].tv_nsec != UTIME_NOW) {
-			newattrs.ia_atime.tv_sec = times[0].tv_sec;
-			newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
+			newattrs.ia_atime.tv_sec =
+				clamp(times[0].tv_sec, sb->s_time_min, sb->s_time_max);
+			if (times[0].tv_sec == sb->s_time_max || times[0].tv_sec == sb->s_time_min)
+				newattrs.ia_atime.tv_nsec = 0;
+			else
+				newattrs.ia_atime.tv_nsec = times[0].tv_nsec;
 			newattrs.ia_valid |= ATTR_ATIME_SET;
 		}
 
 		if (times[1].tv_nsec == UTIME_OMIT)
 			newattrs.ia_valid &= ~ATTR_MTIME;
 		else if (times[1].tv_nsec != UTIME_NOW) {
-			newattrs.ia_mtime.tv_sec = times[1].tv_sec;
-			newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
+			newattrs.ia_mtime.tv_sec =
+				clamp(times[1].tv_sec, sb->s_time_min, sb->s_time_max);
+			if (times[1].tv_sec >= sb->s_time_max || times[1].tv_sec == sb->s_time_min)
+				newattrs.ia_mtime.tv_nsec = 0;
+			else
+				newattrs.ia_mtime.tv_nsec = times[1].tv_nsec;
 			newattrs.ia_valid |= ATTR_MTIME_SET;
 		}
 		/*
-- 
2.17.1

