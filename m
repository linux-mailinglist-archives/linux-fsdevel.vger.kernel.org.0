Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F19456AD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 08:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhKSHVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 02:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbhKSHU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:20:59 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCFDC06173E
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id b12so16413835wrh.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Nov 2021 23:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFGb18pBC9MBpjQaAVm5hqQdk6D4Ir2REv4FVUlaigw=;
        b=CJ7bKrQNzHwFOLCxyr6Eqedny+jYVFlV7e59I/83ia+MFeAx3GbonEE7TENZXok+c/
         pRqYPYl0QEWuMVAL6oHmF7Khqlz+U/U5yZjI8LTXfZKg8gzRy/SV5MyFzmxDsgZxde4+
         y3ey9UdRXqUVio6sOOFof1ehJTF1jXEiir+eh7xdg0Nj/2LooSVhRgQpI5HLTRtrGLuk
         4yagv2rGL850wvQ83ZOdNWV9kN2E+lgw6Pfu+9XM8hNHt2LncZLbiBU3ic6FcE/egzxK
         2NvGgCCBnvNQdFXQwXTBpVr/Rj62jvJLltzbm6LfFZORSA8LREIBaZmGdYkg/aQeWv92
         qTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFGb18pBC9MBpjQaAVm5hqQdk6D4Ir2REv4FVUlaigw=;
        b=flXEaJ6l8Oj0YAI8xz4+0fSjl24jarR6/p7GpgFKQhdXGEji4LSp193qjFJwqELfSO
         15Qq171thlCnk03M5l//Zd062egaCPTnwErbUFUZvqB/S97lWFFRvvSpvvSY2wGTEGyV
         IVAge8sYMluM2wnDKtApWtRfYBIItb8zisnAd4y6OKsOljKFTMapDKw9OV4ta/WS232d
         kjqwQxIXNSmi3dalH4Iy8NNI5lvCknn/QldKPX9nvhqIg9O8MXY2YFKgPBRCsTsDcMOT
         hKyBzSvnIfneuJpdApuYIS3S7AmY0Qw2sQ3lyIDAwSdarQNM7QGLdqw75vrinidQj2a6
         LPHQ==
X-Gm-Message-State: AOAM532FWEq6P1RieIacLjdPzFPZApjmsqVPWEGONLmX6CB8v7Z58Ge1
        4zstBtLk6dHZ334MaV/M7KI=
X-Google-Smtp-Source: ABdhPJzCDdWDi9I29AcfAP5Stctg0fjCL0rpB2As/qrT2SB5t60xKU+CxmhDuR7XNQPsudJFBDjLzA==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr4606923wrv.99.1637306276651;
        Thu, 18 Nov 2021 23:17:56 -0800 (PST)
Received: from localhost.localdomain ([82.114.45.86])
        by smtp.gmail.com with ESMTPSA id l22sm1905913wmp.34.2021.11.18.23.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 23:17:56 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 9/9] fanotify: wire up FAN_RENAME event
Date:   Fri, 19 Nov 2021 09:17:38 +0200
Message-Id: <20211119071738.1348957-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119071738.1348957-1-amir73il@gmail.com>
References: <20211119071738.1348957-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FAN_RENAME is the successor of FAN_MOVED_FROM and FAN_MOVED_TO
and can be used to get the old and new parent+name information in
a single event.

FAN_MOVED_FROM and FAN_MOVED_TO are still supported for backward
compatibility, but it makes little sense to use them together with
FAN_RENAME in the same group.

FAN_RENAME uses special info type records to report the old and
new parent+name, so reporting only old and new parent id is less
useful and was not implemented.
Therefore, FAN_REANAME requires a group with flag FAN_REPORT_NAME.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 8 ++++++++
 include/linux/fanotify.h           | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 4f06b17e209d..072fb0f0c941 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -947,7 +947,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 20);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
 
 	mask = fanotify_group_event_mask(group, iter_info, mask, data,
 					 data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 5ec60db3cfbb..02b5b63c6582 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1587,6 +1587,14 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
 		goto fput_and_out;
 
+	/*
+	 * FAN_RENAME uses special info type records to report the old and
+	 * new parent+name.  Reporting only old and new parent id is less
+	 * useful and was not implemented.
+	 */
+	if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
+		goto fput_and_out;
+
 	if (flags & FAN_MARK_FLUSH) {
 		ret = 0;
 		if (mark_type == FAN_MARK_MOUNT)
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 376e050e6f38..3afdf339d53c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -82,7 +82,8 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
  * Directory entry modification events - reported only to directory
  * where entry is modified and not to a watching parent.
  */
-#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE)
+#define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
+				 FAN_RENAME)
 
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
-- 
2.33.1

