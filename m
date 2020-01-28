Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCEB114C379
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 00:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA1XTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 18:19:13 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgA1XTN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:19:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so7443578pfw.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2020 15:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLcRmbaGlZdT/dpZlJUmvZno5pRafmsAvk974Kpo0hg=;
        b=Uu/tFiLKrEU22a+bF0hgmuvOq+9GWhHCv5ryzlUy7nT/+50ZfTiBYll3DjnDe6Hjhz
         PXJRMBtu2kF85QlGg3RaoZUj8p+HwPcfeWZgvBAFVA4vn7xP8gPLRXI0DyI0gyWSpvlh
         OV1te5rVfq6HioNmKqJ8UV0slW89c71OvFm4BlmL3CbxRrTIsGM7f7oVZuvQCnWZrNrq
         TFxQodMMDMSEJvaon6kziPU3AF+GsT3gPAT4gPCn5GLjnI4LhicIsNGe6uLZzb9KyWhJ
         igTJaazXFUew+eY2D8sDkWcQ43NonxGEcTqP9en213GTH4AUyg2OON9gG2zaCc1BdOKR
         Lt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLcRmbaGlZdT/dpZlJUmvZno5pRafmsAvk974Kpo0hg=;
        b=Fptjvt+dTVYayt7cEyZGmj/ipbfgQ1RAgNKTuLE9Gc1xOeCSTn8lk/N9k81NGeIm8H
         p10uTrCeB00xz6HR2zYK2e8BGFZp6JRZXZji9EJQKMKWs/m9Xfqwq8frwL4SYs9x7LuR
         mIbQGHyDFyOUwKWZvlJIsaVoX/xf4RscviTyEuD7XOIarYohw7n+jq4BYrxCD1GsjgiA
         IWuEcprKkhst4/m2e3sKa9tzaMtRnKu+oC1dY8cAUOWkrG/380gLezPLaeT7s6ZDzNYD
         7hfoJZM/ybvzN/8WJO2sA+afzeUfg1z31TPCSUctN2aqjo+JA214DvWiq6v9TbE245vB
         PR5Q==
X-Gm-Message-State: APjAAAViPOn0W1eT00l9Hfuk6IHNGfkkHfPue4BDmVJ/+bBf3Xxp+stA
        +9zMayZ9i82dWKViB8+6ATbNgsc/e/U=
X-Google-Smtp-Source: APXvYqyjxSYa9RA7QGQXFGSSazCnhFc+y5dw0aRvRcPjNpp6z895Xr1OzUph51XuP6Argyi+Z5UwmQ==
X-Received: by 2002:a65:538b:: with SMTP id x11mr26652080pgq.395.1580253552318;
        Tue, 28 Jan 2020 15:19:12 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:200::43a7])
        by smtp.gmail.com with ESMTPSA id p24sm156353pgk.19.2020.01.28.15.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:19:11 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com
Subject: [RFC PATCH xfsprogs] xfs_io: add support for linkat() AT_LINK_REPLACE
Date:   Tue, 28 Jan 2020 15:18:58 -0800
Message-Id: <ff4b873f356ed8ff63ee582bc57c4babea947159.1580253398.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 io/link.c         | 24 ++++++++++++++++++++----
 man/man8/xfs_io.8 |  9 ++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/io/link.c b/io/link.c
index f4f4b139..3fc3e24d 100644
--- a/io/link.c
+++ b/io/link.c
@@ -12,6 +12,9 @@
 #ifndef AT_EMPTY_PATH
 #define AT_EMPTY_PATH	0x1000
 #endif
+#ifndef AT_LINK_REPLACE
+#define AT_LINK_REPLACE	0x10000
+#endif
 
 static cmdinfo_t flink_cmd;
 
@@ -22,6 +25,7 @@ flink_help(void)
 "\n"
 "link the open file descriptor to the supplied filename\n"
 "\n"
+" -f -- overwrite the target filename if it exists (AT_LINK_REPLACE)\n"
 "\n"));
 }
 
@@ -30,10 +34,22 @@ flink_f(
 	int		argc,
 	char		**argv)
 {
-	if (argc != 2)
+	int		flags = AT_EMPTY_PATH;
+	int		c;
+
+	while ((c = getopt(argc, argv, "f")) != EOF) {
+		switch (c) {
+		case 'f':
+			flags |= AT_LINK_REPLACE;
+			break;
+		default:
+			return command_usage(&flink_cmd);
+		}
+	}
+	if (optind != argc - 1)
 		return command_usage(&flink_cmd);
 
-	if (linkat(file->fd, "", AT_FDCWD, argv[1], AT_EMPTY_PATH) < 0) {
+	if (linkat(file->fd, "", AT_FDCWD, argv[optind], flags) < 0) {
 		perror("flink");
 		return 0;
 	}
@@ -46,9 +62,9 @@ flink_init(void)
 	flink_cmd.name = "flink";
 	flink_cmd.cfunc = flink_f;
 	flink_cmd.argmin = 1;
-	flink_cmd.argmax = 1;
+	flink_cmd.argmax = -1;
 	flink_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK | CMD_FLAG_ONESHOT;
-	flink_cmd.args = _("filename");
+	flink_cmd.args = _("[-f] filename");
 	flink_cmd.oneline =
 		_("link the open file descriptor to the supplied filename");
 	flink_cmd.help = flink_help;
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index c69b295d..f79b3a59 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -807,8 +807,15 @@ for the full list) is available via the
 .B help
 command.
 .TP
-.BI "flink " path
+.BI "flink [ \-f ]" " path"
 Link the currently open file descriptor into the filesystem namespace.
+.RS 1.0i
+.PD 0
+.TP 0.4i
+.B \-f
+overwrite the target path if it exists (AT_LINK_REPLACE).
+.PD
+.RE
 .TP
 .BR stat " [ " \-v "|" \-r " ]"
 Selected statistics from
-- 
2.25.0

