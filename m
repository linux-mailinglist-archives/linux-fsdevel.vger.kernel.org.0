Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5614D4C2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 16:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245304AbiCJOwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiCJOgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:36:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6AA65E8;
        Thu, 10 Mar 2022 06:32:12 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CECB221106;
        Thu, 10 Mar 2022 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646922323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7f2i0Vnp4BHkpXiTO8kTdVtjlZHe4P5kjimj9VfeP0=;
        b=gC7G+yALoNzqMclQHszbv0WithoX+oBTYDmx1HrKtAw/VTBjxuM7ArOx51W57vzoq4xh1E
        QdmWmuz/D/VU8+nBQDAg472pak/FjgRaCzBpz5GmbsXNJcyLQWHXJXGIjmvRX63nrxCZV8
        A+XnE3F++P8+9WZg8zhm2BcIp4bKYQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646922323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7f2i0Vnp4BHkpXiTO8kTdVtjlZHe4P5kjimj9VfeP0=;
        b=GC5ScYLuz3282XKAWnz0rNTy3jp7u7fK224Zpo6Cmr+Nvj4r8AHQcWR19Rl+H440hfRYke
        Xfbh5VLxR4juH1Dg==
Received: from vasant-suse.fritz.box (unknown [10.163.24.178])
        by relay2.suse.de (Postfix) with ESMTP id 97D5CA3B81;
        Thu, 10 Mar 2022 14:25:23 +0000 (UTC)
From:   Vasant Karasulli <vkarasulli@suse.de>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ddiss@suse.de
Cc:     Vasant Karasulli <vkarasulli@suse.de>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] The "keep_last_dots" mount option will, in a subsequent commit, control whether or not trailing periods '.' are stripped from path components during file lookup or file creation.
Date:   Thu, 10 Mar 2022 15:24:54 +0100
Message-Id: <20220310142455.23127-2-vkarasulli@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220310142455.23127-1-vkarasulli@suse.de>
References: <20220310142455.23127-1-vkarasulli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vasant Karasulli <vkarasulli@suse.de>
Co-developed-by: David Disseldorp <ddiss@suse.de>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/exfat/exfat_fs.h | 3 ++-
 fs/exfat/super.c    | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 619e5b4bed10..c6800b880920 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -203,7 +203,8 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
-		 discard:1; /* Issue discard requests on deletions */
+		 discard:1, /* Issue discard requests on deletions */
+		 keep_last_dots:1; /* Keep trailing periods in paths */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 8c9fb7dcec16..4c3f80ed17b1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -174,6 +174,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=remount-ro");
 	if (opts->discard)
 		seq_puts(m, ",discard");
+	if (opts->keep_last_dots)
+		seq_puts(m, ",keep_last_dots");
 	if (opts->time_offset)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
@@ -217,6 +219,7 @@ enum {
 	Opt_charset,
 	Opt_errors,
 	Opt_discard,
+	Opt_keep_last_dots,
 	Opt_time_offset,
 
 	/* Deprecated options */
@@ -243,6 +246,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_string("iocharset",		Opt_charset),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag("keep_last_dots",		Opt_keep_last_dots),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
@@ -297,6 +301,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_discard:
 		opts->discard = 1;
 		break;
+	case Opt_keep_last_dots:
+		opts->keep_last_dots = 1;
+		break;
 	case Opt_time_offset:
 		/*
 		 * Make the limit 24 just in case someone invents something
-- 
2.32.0

