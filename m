Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2B4F5FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 15:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiDFNSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiDFNRV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:17:21 -0400
Received: from synology.com (mail.synology.com [211.23.38.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FCD611C70
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 02:56:01 -0700 (PDT)
From:   Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1649238955; bh=dSjDx94g5hTveDywcip83RDdrkAhrhLJOttNxAdQ0dA=;
        h=From:To:Cc:Subject:Date;
        b=NxzgsFHjvYbKM2tciudCp8CKN3SfIQTICZMnGrEwa0V3Udbps3mHhcp/KSDqQqhvB
         3UfsQLEDDq3fT9EiLX3efO8OYXP6qVwQzn27XL+Zp8hgEXKSPD3RQ5HnV/uRbEtJUH
         4m/YtI7c1S16ubwVzxBAR6YGrj57je24s5kpMMok=
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, shepjeng@gmail.com,
        kernel@cccheng.net, Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] exfat: introduce mount option 'sys_tz'
Date:   Wed,  6 Apr 2022 17:55:52 +0800
Message-Id: <20220406095552.111869-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXFAT_TZ_VALID bit in {create,modify,access}_tz is corresponding to
OffsetValid field in exfat specification [1]. When this bit isn't
set, timestamps should be treated as having the same UTC offset as
the current local time.

Currently, there is an option 'time_offset' for users to specify the
UTC offset for this issue. This patch introduces a new mount option
'sys_tz' to use system timezone as time offset.

Link: [1] https://docs.microsoft.com/en-us/windows/win32/fileio/exfat-specification#74102-offsetvalid-field

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 fs/exfat/exfat_fs.h |  1 +
 fs/exfat/misc.c     | 10 ++++++++--
 fs/exfat/super.c    |  9 ++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index c6800b880920..82e507413291 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -203,6 +203,7 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
+		 sys_tz:1, /* Use local timezone */
 		 discard:1, /* Issue discard requests on deletions */
 		 keep_last_dots:1; /* Keep trailing periods in paths */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index d5bd8e6d9741..9380e0188b55 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -74,6 +74,13 @@ static void exfat_adjust_tz(struct timespec64 *ts, u8 tz_off)
 		ts->tv_sec += TIMEZONE_SEC(0x80 - tz_off);
 }
 
+static inline int exfat_tz_offset(struct exfat_sb_info *sbi)
+{
+	if (sbi->options.sys_tz)
+		return -sys_tz.tz_minuteswest;
+	return sbi->options.time_offset;
+}
+
 /* Convert a EXFAT time/date pair to a UNIX date (seconds since 1 1 70). */
 void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 tz, __le16 time, __le16 date, u8 time_cs)
@@ -96,8 +103,7 @@ void exfat_get_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		/* Adjust timezone to UTC0. */
 		exfat_adjust_tz(ts, tz & ~EXFAT_TZ_VALID);
 	else
-		/* Convert from local time to UTC using time_offset. */
-		ts->tv_sec -= sbi->options.time_offset * SECS_PER_MIN;
+		ts->tv_sec -= exfat_tz_offset(sbi) * SECS_PER_MIN;
 }
 
 /* Convert linear UNIX date to a EXFAT time/date pair. */
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8ca21e7917d1..3e0f67b2103e 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -170,7 +170,9 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",discard");
 	if (opts->keep_last_dots)
 		seq_puts(m, ",keep_last_dots");
-	if (opts->time_offset)
+	if (opts->sys_tz)
+		seq_puts(m, ",sys_tz");
+	else if (opts->time_offset)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
 }
@@ -214,6 +216,7 @@ enum {
 	Opt_errors,
 	Opt_discard,
 	Opt_keep_last_dots,
+	Opt_sys_tz,
 	Opt_time_offset,
 
 	/* Deprecated options */
@@ -241,6 +244,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
+	fsparam_flag("sys_tz",			Opt_sys_tz),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
@@ -298,6 +302,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_keep_last_dots:
 		opts->keep_last_dots = 1;
 		break;
+	case Opt_sys_tz:
+		opts->sys_tz = 1;
+		break;
 	case Opt_time_offset:
 		/*
 		 * Make the limit 24 just in case someone invents something
-- 
2.34.1

