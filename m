Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B8D4EADB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiC2MxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 08:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiC2MxA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:53:00 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB717E0FB
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 05:51:01 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvR4lCRzMprp1;
        Tue, 29 Mar 2022 14:50:59 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvR2glxzlhMCK;
        Tue, 29 Mar 2022 14:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558259;
        bh=cGKkI5dIAlnDd39MT7GxV5PbbTi1yoIW7hnT3vZmRfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LX4efo/pLMuI6/U7ALHvLtfakZ2dPNyJF6F36JolZPTYGTB83Az99kayzwM2HZR2I
         VTazgEvGj4bR0mczQ6b+I8028BdNcRzblhsHk8DAN6dOZESAxNSIxtWUyAui7N58A6
         hvTytlS+qnukZlFELNwBd0ZS9yoA/ykcigr+Z8NM=
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 02/12] landlock: Reduce the maximum number of layers to 16
Date:   Tue, 29 Mar 2022 14:51:07 +0200
Message-Id: <20220329125117.1393824-3-mic@digikod.net>
In-Reply-To: <20220329125117.1393824-1-mic@digikod.net>
References: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

The maximum number of nested Landlock domains is currently 64.  Because
of the following fix and to help reduce the stack size, let's reduce it
to 16.  This seems large enough for a lot of use cases (e.g. sandboxed
init service, spawning a sandboxed SSH service, in nested sandboxed
containers).  Reducing the number of nested domains may also help to
discover misuse of Landlock (e.g. creating a domain per rule).

Add and use a dedicated layer_mask_t typedef to fit with the number of
layers.  This might be useful when changing it and to keep it consistent
with the maximum number of layers.

Reviewed-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220329125117.1393824-3-mic@digikod.net
---

Changes since v1:
* Add Reviewed-by: Paul Moore.
* Update documentation to reflect this change.
---
 Documentation/userspace-api/landlock.rst   |  4 ++--
 security/landlock/fs.c                     | 13 +++++--------
 security/landlock/limits.h                 |  2 +-
 security/landlock/ruleset.h                |  4 ++++
 tools/testing/selftests/landlock/fs_test.c |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index f35552ff19ba..b68e7a51009f 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -267,8 +267,8 @@ restrict such paths with dedicated ruleset flags.
 Ruleset layers
 --------------
 
-There is a limit of 64 layers of stacked rulesets.  This can be an issue for a
-task willing to enforce a new ruleset in complement to its 64 inherited
+There is a limit of 16 layers of stacked rulesets.  This can be an issue for a
+task willing to enforce a new ruleset in complement to its 16 inherited
 rulesets.  Once this limit is reached, sys_landlock_restrict_self() returns
 E2BIG.  It is then strongly suggested to carefully build rulesets once in the
 life of a thread, especially for applications able to launch other applications
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 9de2a460a762..4048e3c04d75 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -180,10 +180,10 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 
 /* Access-control management */
 
-static inline u64 unmask_layers(
+static inline layer_mask_t unmask_layers(
 		const struct landlock_ruleset *const domain,
 		const struct path *const path,
-		const access_mask_t access_request, u64 layer_mask)
+		const access_mask_t access_request, layer_mask_t layer_mask)
 {
 	const struct landlock_rule *rule;
 	const struct inode *inode;
@@ -209,11 +209,11 @@ static inline u64 unmask_layers(
 	 */
 	for (i = 0; i < rule->num_layers; i++) {
 		const struct landlock_layer *const layer = &rule->layers[i];
-		const u64 layer_level = BIT_ULL(layer->level - 1);
+		const layer_mask_t layer_bit = BIT_ULL(layer->level - 1);
 
 		/* Checks that the layer grants access to the full request. */
 		if ((layer->access & access_request) == access_request) {
-			layer_mask &= ~layer_level;
+			layer_mask &= ~layer_bit;
 
 			if (layer_mask == 0)
 				return layer_mask;
@@ -228,12 +228,9 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 {
 	bool allowed = false;
 	struct path walker_path;
-	u64 layer_mask;
+	layer_mask_t layer_mask;
 	size_t i;
 
-	/* Make sure all layers can be checked. */
-	BUILD_BUG_ON(BITS_PER_TYPE(layer_mask) < LANDLOCK_MAX_NUM_LAYERS);
-
 	if (!access_request)
 		return 0;
 	if (WARN_ON_ONCE(!domain || !path))
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 458d1de32ed5..126d1ec04d34 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -13,7 +13,7 @@
 #include <linux/limits.h>
 #include <uapi/linux/landlock.h>
 
-#define LANDLOCK_MAX_NUM_LAYERS		64
+#define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
 #define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_MAKE_SYM
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 7e7cac68e443..0128c56ee7ff 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -23,6 +23,10 @@ typedef u16 access_mask_t;
 /* Makes sure all filesystem access rights can be stored. */
 static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
 
+typedef u16 layer_mask_t;
+/* Makes sure all layers can be checked. */
+static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
+
 /**
  * struct landlock_layer - Access rights for a given layer
  */
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10c9a1e4ebd9..99838cac970b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1080,7 +1080,7 @@ TEST_F_FORK(layout1, max_layers)
 	const int ruleset_fd = create_ruleset(_metadata, ACCESS_RW, rules);
 
 	ASSERT_LE(0, ruleset_fd);
-	for (i = 0; i < 64; i++)
+	for (i = 0; i < 16; i++)
 		enforce_ruleset(_metadata, ruleset_fd);
 
 	for (i = 0; i < 2; i++) {
-- 
2.35.1

