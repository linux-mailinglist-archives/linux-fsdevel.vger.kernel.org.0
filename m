Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8879F4045DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350954AbhIIG5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 02:57:11 -0400
Received: from mail.synology.com ([211.23.38.101]:48612 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234638AbhIIG5L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 02:57:11 -0400
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1631170560; bh=Pm4yAAvvAwrpBm41bwSetur+e99+EGnlix4hDdg9uN8=;
        h=From:To:Cc:Subject:Date;
        b=bEQ40i13ZSwseWOCXbSlBD+lV58YYpl8hIExH5r+7lc1XmfvUjqLTIAz98Y/uUz5o
         oa0JIYRMklxvdpoxq65X9cnjv5IEeVcQvlfsqKx55XLjklglbGFRi1eURFSpSoRv02
         PeSSrLmknet3Yw0DhiPSIs7CAs0P4rOj5tQe7tcI=
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shepjeng@gmail.com, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] exfat: use local UTC offset when EXFAT_TZ_VALID isn't set
Date:   Thu,  9 Sep 2021 14:55:43 +0800
Message-Id: <20210909065543.164329-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXFAT_TZ_VALID is corresponding to OffsetValid field in exfat
specification [1]. If this bit isn't set, timestamps should be treated
as having the same UTC offset as the current local time.

This patch uses the existing mount option 'time_offset' as fat does. If
time_offset isn't set, local UTC offset in sys_tz will be used as the
default value.

Link: [1] https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#74102-offsetvalid-field
Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/exfat/exfat_fs.h | 1 +
 fs/exfat/misc.c     | 8 +++++++-
 fs/exfat/super.c    | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..b57fdd94ad01 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -204,6 +204,7 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
+		 tz_set:1, /* Filesystem timestamps' offset set */
 		 discard:1; /* Issue discard requests on deletions */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index d34e6193258d..349e3fe64ea2 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -73,6 +73,12 @@ static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
 		ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
 }
 
+static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
+{
+	return (sbi->options.tz_set ? -sbi->options.time_offset :
+			sys_tz.tz_minuteswest) * SECS_PER_MIN;
+}
+
 /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_cs)
@@ -96,7 +102,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
 	else
 		/* Convert from local time to UTC using time_offset. */
-		ts->tv_sec -= sbi->options.time_offset * SECS_PER_MIN;
+		ts->tv_sec += exfat_tz_offset(sbi);
 }
 
 /* Convert linear UNIX date to a EXFAT time/date pair. */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..caeea375e4fa 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -173,7 +173,7 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=remount-ro");
 	if (opts->discard)
 		seq_puts(m, ",discard");
-	if (opts->time_offset)
+	if (opts->tz_set)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
 }
@@ -303,6 +303,7 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		 */
 		if (result.int_32 < -24 * 60 || result.int_32 > 24 * 60)
 			return -EINVAL;
+		opts->tz_set = 1;
 		opts->time_offset = result.int_32;
 		break;
 	case Opt_utf8:
-- 
2.25.1

