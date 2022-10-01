Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665725F1D4E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJAPts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJAPtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ACE57200;
        Sat,  1 Oct 2022 08:49:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m15so9451725edb.13;
        Sat, 01 Oct 2022 08:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WYGzG1vcyrsp2tnVlNOZmgENBWTEGj4PMTm9f1JokF0=;
        b=FFdBN4p51I1fzrf4rpzWCI3vdFNE+l+QRb1olEzF192zkEnv5g8t0hYOClpPZERTyJ
         KPwQdoCd5NT1SmooweXAggraqksux9CFI86AAKsZX35WOUWcvzBnG11Dhfxyq3Vh2Oqz
         Ad+dQ4tzacVuDwEbGoUAfLoKI6WVpk4JidQ+JLiipr0ACOuRkcWADjmUGC7Iam0oQId9
         jO+9RW3JhMniqgzoBIUq0uW3eY/5NYqHOaP71oS+yqbxmlB1eXn8gQS8dzaj31lH9cgi
         cI0Y4NylejsVVKG82VStwglfFpUPZf2J9uLiaPzqCTrODddbUFGi0mhV+6y3dCc7fQDw
         lM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WYGzG1vcyrsp2tnVlNOZmgENBWTEGj4PMTm9f1JokF0=;
        b=G3jaeyLw+fNJqbe7sl2VQPotSZmE4k0bYLLrxMaUvp9lxnIG+xfAagqwU3aUDjC6XG
         GRdBXrNdd2wbm5JkECMugU0Ae16KItgKGxSquJtUMeai5xCF2cuhaBBYUT4cdD1eZSN2
         KLBAy6lLl+oAc3db5m9StMu4Hpfa1xpgNvPD1TleskC0ukNNotwuEoM6ilOM7/udzXpX
         6RB4WpsX0nPUxFonRtg1lz6tCofhMeo3WvZpO7gyQCB/+d/TSryDssnqVO67/9HbymlL
         KhLMSzAmV1+9PKLT534eP6kUOm1+NiVShNdE3eHcIJmFZSfN7wGtpvnWvr7DE92P6WU/
         eMFA==
X-Gm-Message-State: ACrzQf02k6thp9jg+PHlpMSXdh7TjySNugHeRa2alH88p9BwVHAO6TS8
        33Vjas4/N7GfXEhFvutDY+uBXNy9IiI=
X-Google-Smtp-Source: AMsMyM7WX9cabImwpz1uGLCh8j+VL2foGUZDV4SiBwk8vDsyFMBw/TVwUNsJxNJbmzqVKtpKJCxLEA==
X-Received: by 2002:a05:6402:34d5:b0:451:335c:2f1e with SMTP id w21-20020a05640234d500b00451335c2f1emr11835643edc.160.1664639369113;
        Sat, 01 Oct 2022 08:49:29 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:28 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 3/9] landlock: Refactor check_access_path_dual() into is_access_to_paths_allowed()
Date:   Sat,  1 Oct 2022 17:49:02 +0200
Message-Id: <20221001154908.49665-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
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

* Rename it to is_access_to_paths_allowed()
* Make it return true iff the access is allowed
* Calculate the EXDEV/EACCES error code in the one place where it's needed

Suggested-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 89 +++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a9dbd99d9ee7..083dd3d359de 100644
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
+ * - false otherwise
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
- * handles walking on the same mount point and only check one set of accesses.
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
2.37.3

