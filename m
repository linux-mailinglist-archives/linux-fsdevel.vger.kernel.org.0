Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021454BEC7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiBUVXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbiBUVXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:17 -0500
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Feb 2022 13:22:51 PST
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23802715
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znr6sSwzMqHjD;
        Mon, 21 Feb 2022 22:15:12 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znr4VDvzljTgK;
        Mon, 21 Feb 2022 22:15:12 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 03/11] landlock: Create find_rule() from unmask_layers()
Date:   Mon, 21 Feb 2022 22:25:14 +0100
Message-Id: <20220221212522.320243-4-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

This refactoring will be useful in a following commit.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-4-mic@digikod.net
---
 security/landlock/fs.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4048e3c04d75..0bcb27f2360a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -180,23 +180,36 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 /* Access-control management */
 
-static inline layer_mask_t unmask_layers(
+/*
+ * The lifetime of the returned rule is tied to @domain.
+ *
+ * Returns NULL if no rule is found or if @dentry is negative.
+ */
+static inline const struct landlock_rule *find_rule(
 		const struct landlock_ruleset *const domain,
-		const struct path *const path,
-		const access_mask_t access_request, layer_mask_t layer_mask)
+		const struct dentry *const dentry)
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
 	rule = landlock_find_rule(domain,
 			rcu_dereference(landlock_inode(inode)->object));
 	rcu_read_unlock();
+	return rule;
+}
+
+static inline layer_mask_t unmask_layers(
+		const struct landlock_rule *const rule,
+		const access_mask_t access_request, layer_mask_t layer_mask)
+{
+	size_t layer_level;
+
 	if (!rule)
 		return layer_mask;
 
@@ -207,8 +220,9 @@ static inline layer_mask_t unmask_layers(
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
@@ -266,8 +280,9 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 	while (true) {
 		struct dentry *parent_dentry;
 
-		layer_mask = unmask_layers(domain, &walker_path,
-				access_request, layer_mask);
+		layer_mask = unmask_layers(find_rule(domain,
+					walker_path.dentry), access_request,
+				layer_mask);
 		if (layer_mask == 0) {
 			/* Stops when a rule from each layer grants access. */
 			allowed = true;
-- 
2.35.1

