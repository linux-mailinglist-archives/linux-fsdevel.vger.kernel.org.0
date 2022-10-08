Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFD5F84B5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJHKJs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJHKJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:46 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5512F67;
        Sat,  8 Oct 2022 03:09:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so15840018ejb.13;
        Sat, 08 Oct 2022 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FuCoIWD2t78PwWblywGhp3stRwE/o0mS9jcK6KpYrk=;
        b=HQinCFyD7FAy1a1BwqInnsIPGuJ+HVpiCSmQo/sgcHmjwPizttRFLZBhf7FCl0v9JL
         uCzEB4mqBtzB07o41bymoCUZl9uYstkLy7g7OgsUcLLVzRnI9k7VvWiQ1rOL1AcziHp4
         OhUyJt8CamwIxs+VnRZLqUceY7hZ+yjFj7VyIWhOfHpzWLN4kFFdNJapAUkEPgiPI8/9
         h8dJ8wAXAUaxM1zimBXlv7hlEM9JshguFiIXLRBkU0sgU0OFR9Ajpk1Is6jnLwlFDYcd
         10c7OW3rGi2xoNntx8vY3K4IXLmBzecdB+YyUBG7IFxpeIIZqDh4/B4CAwSivxdZve2Y
         ZyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FuCoIWD2t78PwWblywGhp3stRwE/o0mS9jcK6KpYrk=;
        b=tZsRiWFPynxi5J/Zn0F4NqQtVZlA8xz4TqXpj+oYY4Q2NR/TLWBeKPbvTD3y0OWllg
         FlI7uSP37F76It/V0vwOXpT4l6SFc1VNVyYyFUlCm6POOp7LGWMdNEX7GuEzkSWDNHu3
         ayk7L2/oPG+5PoGj1480T8Vj6KqP7G+cNuvyX6jGzFAkji5b6JMxruCdMsYGTrk4S626
         OSw2ElgJ2k0TjamKdgC8MRVsYNnkJHmHTJf+9F//lAqxEQ2g5HIVHFydql0Tt8uoDKlx
         V/lsculscM6isd0cJUqgIpsPQczP7HOGNr2voh6QHU4yIkZcVoST5wdE7p2wA/8iP6wZ
         6u6w==
X-Gm-Message-State: ACrzQf2Bc1oHzbF/DoLqEgeCOq4ObN5Ni2UtVs22QoAZ+lrvH7TfRk0x
        nbvF4I6KUjFedj4KgJ4X4iSU0zdSCaw=
X-Google-Smtp-Source: AMsMyM4Uvyo7nla/F0VVsDLXadaxvRoiP6LtalTj3yv2zAaU7e116jqWteVmu2xIP9pcVwS/JoW99w==
X-Received: by 2002:a17:907:3e11:b0:78d:9918:217f with SMTP id hp17-20020a1709073e1100b0078d9918217fmr1270586ejc.742.1665223781249;
        Sat, 08 Oct 2022 03:09:41 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:40 -0700 (PDT)
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
Subject: [PATCH v9 02/11] landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
Date:   Sat,  8 Oct 2022 12:09:28 +0200
Message-Id: <20221008100935.73706-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008100935.73706-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
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

