Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D836603242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiJRSWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiJRSWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CE18263C;
        Tue, 18 Oct 2022 11:22:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m15so21728211edb.13;
        Tue, 18 Oct 2022 11:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FuCoIWD2t78PwWblywGhp3stRwE/o0mS9jcK6KpYrk=;
        b=hlksfLCc+twqaCOXME55MLK9avaFTa5AlpKRBTbqc7lKpvGajPI/NgaYTHiWov7jOd
         dseb1Wgxsx4myWjGAD2ylHdg4xfzcf0S6me0pZ5WU6jYPHetofZEUpjgVwsdjRCsuHvx
         ioWllCXh/ejODlxSCBl0a/a8++6jQYjx46ozj6ctW1u0LZY8/Q5H7/TCoNzZHym4oYBf
         uA1JEFuuN3NjFAggAd/10MVONTc0TLwAIv+8pxhgq+eVfgMoe7oe0zg6USOGGf6OkCJV
         k71zPBqr3vcg7pvOJeV8s2R3rPSLeaQrBrA313m9CVxGvVdZ7K5Abes4+deNBZdGX8pu
         phZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FuCoIWD2t78PwWblywGhp3stRwE/o0mS9jcK6KpYrk=;
        b=KAi6rD/6LqTx3ZJ9KZ05epaCYiJ6YLvDtAsCX2cKCWkEjmedpx6m9/WN0X6ftsoiCE
         cBYp+ySx54FVf+q9jjsUWfSl9ZCqHJba5p9hlP7yXHkb+M7RdCBQp3IEX6QX8xO12F3H
         wWcCuRC++Iq2zSichs0XWev+JytrPu0yvUSgky4JwE8La+eKAG3NuLYJstVPoyNlXl8v
         wExV7kLA4Hi0uZUaA5JxvSXS699GcVTInEhGmQW6Lx3up9KXIaTi6SP07ohZQtl3iloo
         v1nmL1C9Bx/PBQZ0DsfhXCLQ37bN7oNHA45OJ9hb/iuT5WfGROANe4TTdKr6zacGO7x8
         dUcw==
X-Gm-Message-State: ACrzQf02kBXdAogw/wG1I5dKZdYTJ+Wz1lP1Pl6hnM3Hsdm9MpeUme5Z
        eoHkkpy0kDw6QjzIs/B/C41Op+erQQw=
X-Google-Smtp-Source: AMsMyM5vAxWl3RzsN/dUY7VNMa50dPcKJe+ah01iBbwABq/l/tjAKRbYSMGVqo8bBFvbIYDzlt+0eg==
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id b16-20020aa7dc10000000b00440b446c0ccmr3818157edu.34.1666117351009;
        Tue, 18 Oct 2022 11:22:31 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:30 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v10 02/11] landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
Date:   Tue, 18 Oct 2022 20:22:07 +0200
Message-Id: <20221018182216.301684-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename check_access_path_dual() to is_access_to_paths_allowed().

Make it return true iff the access is allowed.

Calculate the EXDEV/EACCES error code in the one place where it's needed.

Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 89 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 64ed7665455f..277868e3c6ce 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -430,7 +430,7 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
 }
 
 /**
- * check_access_path_dual - Check accesses for requests with a common path
+ * is_access_to_paths_allowed - Check accesses for requests with a common path
  *
  * @domain: Domain to check against.
  * @path: File hierarchy to walk through.
@@ -465,14 +465,10 @@ is_eacces(const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_ACCESS_FS],
  * allow the request.
  *
  * Returns:
- * - 0 if the access request is granted;
- * - -EACCES if it is denied because of access right other than
- *   LANDLOCK_ACCESS_FS_REFER;
- * - -EXDEV if the renaming or linking would be a privileged escalation
- *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
- *   not allowed by the source or the destination.
+ * - true if the access request is granted;
+ * - false otherwise.
  */
-static int check_access_path_dual(
+static bool is_access_to_paths_allowed(
 	const struct landlock_ruleset *const domain,
 	const struct path *const path,
 	const access_mask_t access_request_parent1,
@@ -492,17 +488,17 @@ static int check_access_path_dual(
 	(*layer_masks_child2)[LANDLOCK_NUM_ACCESS_FS] = NULL;
 
 	if (!access_request_parent1 && !access_request_parent2)
-		return 0;
+		return true;
 	if (WARN_ON_ONCE(!domain || !path))
-		return 0;
+		return true;
 	if (is_nouser_or_private(path->dentry))
-		return 0;
+		return true;
 	if (WARN_ON_ONCE(domain->num_layers < 1 || !layer_masks_parent1))
-		return -EACCES;
+		return false;
 
 	if (unlikely(layer_masks_parent2)) {
 		if (WARN_ON_ONCE(!dentry_child1))
-			return -EACCES;
+			return false;
 		/*
 		 * For a double request, first check for potential privilege
 		 * escalation by looking at domain handled accesses (which are
@@ -513,7 +509,7 @@ static int check_access_path_dual(
 		is_dom_check = true;
 	} else {
 		if (WARN_ON_ONCE(dentry_child1 || dentry_child2))
-			return -EACCES;
+			return false;
 		/* For a simple request, only check for requested accesses. */
 		access_masked_parent1 = access_request_parent1;
 		access_masked_parent2 = access_request_parent2;
@@ -622,24 +618,7 @@ static int check_access_path_dual(
 	}
 	path_put(&walker_path);
 
-	if (allowed_parent1 && allowed_parent2)
-		return 0;
-
-	/*
-	 * This prioritizes EACCES over EXDEV for all actions, including
-	 * renames with RENAME_EXCHANGE.
-	 */
-	if (likely(is_eacces(layer_masks_parent1, access_request_parent1) ||
-		   is_eacces(layer_masks_parent2, access_request_parent2)))
-		return -EACCES;
-
-	/*
-	 * Gracefully forbids reparenting if the destination directory
-	 * hierarchy is not a superset of restrictions of the source directory
-	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
-	 * source or the destination.
-	 */
-	return -EXDEV;
+	return allowed_parent1 && allowed_parent2;
 }
 
 static inline int check_access_path(const struct landlock_ruleset *const domain,
@@ -649,8 +628,10 @@ static inline int check_access_path(const struct landlock_ruleset *const domain,
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 
 	access_request = init_layer_masks(domain, access_request, &layer_masks);
-	return check_access_path_dual(domain, path, access_request,
-				      &layer_masks, NULL, 0, NULL, NULL);
+	if (is_access_to_paths_allowed(domain, path, access_request,
+				       &layer_masks, NULL, 0, NULL, NULL))
+		return 0;
+	return -EACCES;
 }
 
 static inline int current_check_access_path(const struct path *const path,
@@ -711,8 +692,9 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
  * file.  While walking from @dir to @mnt_root, we record all the domain's
  * allowed accesses in @layer_masks_dom.
  *
- * This is similar to check_access_path_dual() but much simpler because it only
- * handles walking on the same mount point and only checks one set of accesses.
+ * This is similar to is_access_to_paths_allowed() but much simpler because it
+ * only handles walking on the same mount point and only checks one set of
+ * accesses.
  *
  * Returns:
  * - true if all the domain access rights are allowed for @dir;
@@ -857,10 +839,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		access_request_parent1 = init_layer_masks(
 			dom, access_request_parent1 | access_request_parent2,
 			&layer_masks_parent1);
-		return check_access_path_dual(dom, new_dir,
-					      access_request_parent1,
-					      &layer_masks_parent1, NULL, 0,
-					      NULL, NULL);
+		if (is_access_to_paths_allowed(
+			    dom, new_dir, access_request_parent1,
+			    &layer_masks_parent1, NULL, 0, NULL, NULL))
+			return 0;
+		return -EACCES;
 	}
 
 	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
@@ -886,11 +869,27 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	 * parent access rights.  This will be useful to compare with the
 	 * destination parent access rights.
 	 */
-	return check_access_path_dual(dom, &mnt_dir, access_request_parent1,
-				      &layer_masks_parent1, old_dentry,
-				      access_request_parent2,
-				      &layer_masks_parent2,
-				      exchange ? new_dentry : NULL);
+	if (is_access_to_paths_allowed(
+		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
+		    old_dentry, access_request_parent2, &layer_masks_parent2,
+		    exchange ? new_dentry : NULL))
+		return 0;
+
+	/*
+	 * This prioritizes EACCES over EXDEV for all actions, including
+	 * renames with RENAME_EXCHANGE.
+	 */
+	if (likely(is_eacces(&layer_masks_parent1, access_request_parent1) ||
+		   is_eacces(&layer_masks_parent2, access_request_parent2)))
+		return -EACCES;
+
+	/*
+	 * Gracefully forbids reparenting if the destination directory
+	 * hierarchy is not a superset of restrictions of the source directory
+	 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
+	 * source or the destination.
+	 */
+	return -EXDEV;
 }
 
 /* Inode hooks */
-- 
2.38.0

