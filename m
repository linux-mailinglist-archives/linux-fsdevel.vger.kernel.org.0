Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B48C51DD28
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443593AbiEFQNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443650AbiEFQN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 12:13:28 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6526D978
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 09:09:41 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwW82g1CzMqHNk;
        Fri,  6 May 2022 18:09:40 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwW80zpPzlhMCN;
        Fri,  6 May 2022 18:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853380;
        bh=OPou4LaG4nibi6nIHK9dfnm9z5ahTygUlm7kPplYxSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ismxciN4bw698P1aiBDxt8RKeqUWGYnPzrcXlq9bfStXM6bXXueXXZKh5J6pVIt0D
         ETfHv37R7k00OzFPzrZni4Yi1KcKrmNQrK1ZiWNn5RbodZ3RoeU1onawbAI5zVWGjj
         zZZ7u/ae9oFu0i1pLXncXEAQonqygZmIWLJyRZAc=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 03/12] landlock: Create find_rule() from unmask_layers()
Date:   Fri,  6 May 2022 18:10:53 +0200
Message-Id: <20220506161102.525323-4-mic@digikod.net>
In-Reply-To: <20220506161102.525323-1-mic@digikod.net>
References: <20220506161102.525323-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This refactoring will be useful in a following commit.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506161102.525323-4-mic@digikod.net
---

Changes since v2:
* Format with clang-format and rebase.

Changes since v1:
* Add Reviewed-by: Paul Moore.
---
 security/landlock/fs.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index f48c0a3b1e75..20953bff8fd5 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -183,23 +183,36 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 /* Access-control management */
 
-static inline layer_mask_t
-unmask_layers(const struct landlock_ruleset *const domain,
-	      const struct path *const path, const access_mask_t access_request,
-	      layer_mask_t layer_mask)
+/*
+ * The lifetime of the returned rule is tied to @domain.
+ *
+ * Returns NULL if no rule is found or if @dentry is negative.
+ */
+static inline const struct landlock_rule *
+find_rule(const struct landlock_ruleset *const domain,
+	  const struct dentry *const dentry)
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
-	size_t i;
 
-	if (d_is_negative(path->dentry))
-		/* Ignore nonexistent leafs. */
-		return layer_mask;
-	inode = d_backing_inode(path->dentry);
+	/* Ignores nonexistent leafs. */
+	if (d_is_negative(dentry))
+		return NULL;
+
+	inode = d_backing_inode(dentry);
 	rcu_read_lock();
 	rule = landlock_find_rule(
 		domain, rcu_dereference(landlock_inode(inode)->object));
 	rcu_read_unlock();
+	return rule;
+}
+
+static inline layer_mask_t unmask_layers(const struct landlock_rule *const rule,
+					 const access_mask_t access_request,
+					 layer_mask_t layer_mask)
+{
+	size_t layer_level;
+
 	if (!rule)
 		return layer_mask;
 
@@ -210,8 +223,9 @@ unmask_layers(const struct landlock_ruleset *const domain,
 	 * the remaining layers for each inode, from the first added layer to
 	 * the last one.
 	 */
-	for (i = 0; i < rule->num_layers; i++) {
-		const struct landlock_layer *const layer = &rule->layers[i];
+	for (layer_level = 0; layer_level < rule->num_layers; layer_level++) {
+		const struct landlock_layer *const layer =
+			&rule->layers[layer_level];
 		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
 
 		/* Checks that the layer grants access to the full request. */
@@ -269,8 +283,9 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	while (true) {
 		struct dentry *parent_dentry;
 
-		layer_mask = unmask_layers(domain, &walker_path, access_request,
-					   layer_mask);
+		layer_mask =
+			unmask_layers(find_rule(domain, walker_path.dentry),
+				      access_request, layer_mask);
 		if (layer_mask == 0) {
 			/* Stops when a rule from each layer grants access. */
 			allowed = true;
-- 
2.35.1

