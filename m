Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B404BEC74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiBUVXT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:23:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiBUVXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:17 -0500
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B113126F0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znr2D7BzMqK3b;
        Mon, 21 Feb 2022 22:15:12 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znr0TjLzlhPJX;
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
Subject: [PATCH v1 02/11] landlock: Reduce the maximum number of layers to 16
Date:   Mon, 21 Feb 2022 22:25:13 +0100
Message-Id: <20220221212522.320243-3-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221212522.320243-1-mic@digikod.net>
References: <20220221212522.320243-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
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

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221212522.320243-3-mic@digikod.net
---
 security/landlock/fs.c                     | 13 +++++--------
 security/landlock/limits.h                 |  2 +-
 security/landlock/ruleset.h                |  4 ++++
 tools/testing/selftests/landlock/fs_test.c |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

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

