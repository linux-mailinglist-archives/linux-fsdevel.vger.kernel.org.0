Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC34B897
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 14:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfFSMa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 08:30:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38204 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfFSMa2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:30:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so3211673wrs.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2019 05:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQFy3noIgLzCKKvfJTpCDEkL2tduUrGhw500s5XjKOM=;
        b=g0BTj9yauutw14/4gfPtBttftwnfRexlk0M4VoLCcgXE38LwSsU0st19h51tPKGAyd
         81ZTIJsoW8bFaIYdbvIxetrrAKzZ/c9FCAFZe9HOkMdXTlikl6wUV7ZIoF97tIXnenU5
         ztPNAjGHTCW1c+iOpzil4J0GLm2cZJUEsN0XmvcMjCTlMR3Si7k++UQQsc8EA7mwkM5F
         KSHmj8Y+gT6mIEfRaMWuAqlB4MDfCeTX+2zCPnEl4XgoeF7YD04PwolBTGJnWiArA1mv
         uXn+gEGJ2p75sXuhLg2olxDNvX/1wIUmR9AT6kVZiUd1VVns79Kz/VvB93PonLLl0eyl
         owBg==
X-Gm-Message-State: APjAAAWnXJXPTkT5TYUNhqD/LQWwlJNGvQWUK35008XJ2FLjegy1K7Wk
        C4b98bY8jOKlN1uTon6TfI216A==
X-Google-Smtp-Source: APXvYqyM0eIINJF5V89HnKZUprBMY1GZ2O4C7V7moar/rzzhLkG1oS4KKMtGfJ/P9Up2vnllSLiCCw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr87257157wrn.165.1560947425796;
        Wed, 19 Jun 2019 05:30:25 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:24 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] vfs: verify param type in vfs_parse_sb_flag()
Date:   Wed, 19 Jun 2019 14:30:07 +0200
Message-Id: <20190619123019.30032-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

vfs_parse_sb_flag() accepted any kind of param with a matching key, not
just a flag.  This is wrong, only allow flag type and return -EINVAL
otherwise.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 103643c68e3f..e56310fd8c75 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -81,30 +81,29 @@ static const char *const forbidden_sb_flag[] = {
 /*
  * Check for a common mount option that manipulates s_flags.
  */
-static int vfs_parse_sb_flag(struct fs_context *fc, const char *key)
+static int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 {
-	unsigned int token;
+	const char *key = param->key;
+	unsigned int set, clear;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(forbidden_sb_flag); i++)
 		if (strcmp(key, forbidden_sb_flag[i]) == 0)
 			return -EINVAL;
 
-	token = lookup_constant(common_set_sb_flag, key, 0);
-	if (token) {
-		fc->sb_flags |= token;
-		fc->sb_flags_mask |= token;
-		return 0;
-	}
+	set = lookup_constant(common_set_sb_flag, key, 0);
+	clear = lookup_constant(common_clear_sb_flag, key, 0);
+	if (!set && !clear)
+		return -ENOPARAM;
 
-	token = lookup_constant(common_clear_sb_flag, key, 0);
-	if (token) {
-		fc->sb_flags &= ~token;
-		fc->sb_flags_mask |= token;
-		return 0;
-	}
+	if (param->type != fs_value_is_flag)
+		return invalf(fc, "%s: Unexpected value for '%s'",
+			      fc->fs_type->name, param->key);
 
-	return -ENOPARAM;
+	fc->sb_flags |= set;
+	fc->sb_flags &= ~clear;
+	fc->sb_flags_mask |= set | clear;
+	return 0;
 }
 
 /**
@@ -130,7 +129,7 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
 	if (!param->key)
 		return invalf(fc, "Unnamed parameter\n");
 
-	ret = vfs_parse_sb_flag(fc, param->key);
+	ret = vfs_parse_sb_flag(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

