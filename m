Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBDD1DCEFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 16:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbgEUOH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 10:07:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44588 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729784AbgEUOH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 10:07:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id w19so2856607ply.11;
        Thu, 21 May 2020 07:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JoNp2Y7zz0yJJeDFRUhzITUSQI74mvmrMIPrAd1z6ao=;
        b=iXRMyycckLPFlAxzxaQ0vY442HBL7Y+U/PZd3hnAnFGWM6DXyawdSqL5rITEv9KlTv
         naThp8QPSHtKKrR7L8oWdYdhiumrt4pfLpbbIAI2nItUY6tFQmAxxUmYIxfXdHM+Ky9U
         brsJTlQITGNPpc0gKvhY1h5zJx9qF97L0DYshJ6VtYibAHo+3vGTtd+sjSeizKY80erE
         uL1ythqRrlJRvsSxYVakSvmTUc9R4PO+wv9BarjqpmqA88axBnB31Yo/+FkGXkg0bK/i
         WtJUb78E1NawfCaTy0NQG/USoD4J9tsZdAVI0iSx3HnuYr41jWaMFZMUGEjBhyhFeB8B
         UQFQ==
X-Gm-Message-State: AOAM531SRgW7+Bdmln86ESFhhM7hdfpkGd8g3VMH6ANs3FXwdwvaZBGS
        BmBQ0vadMHxFti5H2kOWQ6NT5jWg
X-Google-Smtp-Source: ABdhPJzDGF9DJTORsBVEnMP8Hw6YVRUo6pmf6G69G8j1zrKhS8KG1Y3mnbVONHFbMgBusKU35FP/sQ==
X-Received: by 2002:a17:902:c403:: with SMTP id k3mr9919096plk.12.1590070077224;
        Thu, 21 May 2020 07:07:57 -0700 (PDT)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id w14sm4287763pgi.12.2020.05.21.07.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:07:56 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2] exfat: add the dummy mount options to be backward compatible with staging/exfat
Date:   Thu, 21 May 2020 23:05:02 +0900
Message-Id: <20200521140502.2409-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Ubuntu and Fedora release new version used kernel version equal to or
higher than v5.4, They started to support kernel exfat filesystem.

Linus Torvalds reported mount error with new version of exfat on Fedora.

	exfat: Unknown parameter 'namecase'

This is because there is a difference in mount option between old
staging/exfat and new exfat.
And utf8, debug, and codepage options as well as namecase have been
removed from new exfat.

This patch add the dummy mount options as deprecated option to be backward
compatible with old one.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
v2:
 - fix checkpatch.pl warning(Missing Signed-off-by).

 fs/exfat/super.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 0565d5539d57..26b0db5b20de 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -203,6 +203,12 @@ enum {
 	Opt_errors,
 	Opt_discard,
 	Opt_time_offset,
+
+	/* Deprecated options */
+	Opt_utf8,
+	Opt_debug,
+	Opt_namecase,
+	Opt_codepage,
 };
 
 static const struct constant_table exfat_param_enums[] = {
@@ -223,6 +229,10 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
+	fsparam_flag("utf8",			Opt_utf8),
+	fsparam_flag("debug",			Opt_debug),
+	fsparam_u32("namecase",			Opt_namecase),
+	fsparam_u32("codepage",			Opt_codepage),
 	{}
 };
 
@@ -278,6 +288,18 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		opts->time_offset = result.int_32;
 		break;
+	case Opt_utf8:
+		pr_warn("exFAT-fs: 'utf8' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_debug:
+		pr_warn("exFAT-fs: 'debug' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_namecase:
+		pr_warn("exFAT-fs: 'namecase' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_codepage:
+		pr_warn("exFAT-fs: 'codepage' mount option is deprecated and has no effect\n");
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

