Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E20A1E71BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438169AbgE2Alt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438134AbgE2Als (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:41:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42E3C08C5C7;
        Thu, 28 May 2020 17:41:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeT5m-00HFgJ-5z; Fri, 29 May 2020 00:41:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 2/5] i915: switch copy_perf_config_registers_or_number() to unsafe_put_user()
Date:   Fri, 29 May 2020 01:41:42 +0100
Message-Id: <20200529004145.4111807-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529004145.4111807-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529004145.4111807-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and the rest of query_perf_config_data() to normal uaccess primitives

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/i915/i915_query.c | 46 ++++++++++++++-------------------------
 drivers/gpu/drm/i915/i915_reg.h   |  2 +-
 2 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index ad8e55fe1e59..e75c528ebbe0 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -154,10 +154,6 @@ static int can_copy_perf_config_registers_or_number(u32 user_n_regs,
 	if (user_n_regs < kernel_n_regs)
 		return -EINVAL;
 
-	if (!access_ok(u64_to_user_ptr(user_regs_ptr),
-		       2 * sizeof(u32) * kernel_n_regs))
-		return -EFAULT;
-
 	return 0;
 }
 
@@ -166,6 +162,7 @@ static int copy_perf_config_registers_or_number(const struct i915_oa_reg *kernel
 						u64 user_regs_ptr,
 						u32 *user_n_regs)
 {
+	u32 __user *p = u64_to_user_ptr(user_regs_ptr);
 	u32 r;
 
 	if (*user_n_regs == 0) {
@@ -175,25 +172,19 @@ static int copy_perf_config_registers_or_number(const struct i915_oa_reg *kernel
 
 	*user_n_regs = kernel_n_regs;
 
-	for (r = 0; r < kernel_n_regs; r++) {
-		u32 __user *user_reg_ptr =
-			u64_to_user_ptr(user_regs_ptr + sizeof(u32) * r * 2);
-		u32 __user *user_val_ptr =
-			u64_to_user_ptr(user_regs_ptr + sizeof(u32) * r * 2 +
-					sizeof(u32));
-		int ret;
-
-		ret = __put_user(i915_mmio_reg_offset(kernel_regs[r].addr),
-				 user_reg_ptr);
-		if (ret)
-			return -EFAULT;
+	if (!user_write_access_begin(p, 2 * sizeof(u32) * kernel_n_regs))
+		return -EFAULT;
 
-		ret = __put_user(kernel_regs[r].value, user_val_ptr);
-		if (ret)
-			return -EFAULT;
+	for (r = 0; r < kernel_n_regs; r++, p += 2) {
+		unsafe_put_user(i915_mmio_reg_offset(kernel_regs[r].addr),
+				p, Efault);
+		unsafe_put_user(kernel_regs[r].value, p + 1, Efault);
 	}
-
+	user_write_access_end();
 	return 0;
+Efault:
+	user_write_access_end();
+	return -EFAULT;
 }
 
 static int query_perf_config_data(struct drm_i915_private *i915,
@@ -229,10 +220,7 @@ static int query_perf_config_data(struct drm_i915_private *i915,
 		return -EINVAL;
 	}
 
-	if (!access_ok(user_query_config_ptr, total_size))
-		return -EFAULT;
-
-	if (__get_user(flags, &user_query_config_ptr->flags))
+	if (get_user(flags, &user_query_config_ptr->flags))
 		return -EFAULT;
 
 	if (flags != 0)
@@ -245,7 +233,7 @@ static int query_perf_config_data(struct drm_i915_private *i915,
 		BUILD_BUG_ON(sizeof(user_query_config_ptr->uuid) >= sizeof(uuid));
 
 		memset(&uuid, 0, sizeof(uuid));
-		if (__copy_from_user(uuid, user_query_config_ptr->uuid,
+		if (copy_from_user(uuid, user_query_config_ptr->uuid,
 				     sizeof(user_query_config_ptr->uuid)))
 			return -EFAULT;
 
@@ -259,7 +247,7 @@ static int query_perf_config_data(struct drm_i915_private *i915,
 		}
 		rcu_read_unlock();
 	} else {
-		if (__get_user(config_id, &user_query_config_ptr->config))
+		if (get_user(config_id, &user_query_config_ptr->config))
 			return -EFAULT;
 
 		oa_config = i915_perf_get_oa_config(perf, config_id);
@@ -267,8 +255,7 @@ static int query_perf_config_data(struct drm_i915_private *i915,
 	if (!oa_config)
 		return -ENOENT;
 
-	if (__copy_from_user(&user_config, user_config_ptr,
-			     sizeof(user_config))) {
+	if (copy_from_user(&user_config, user_config_ptr, sizeof(user_config))) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -314,8 +301,7 @@ static int query_perf_config_data(struct drm_i915_private *i915,
 
 	memcpy(user_config.uuid, oa_config->uuid, sizeof(user_config.uuid));
 
-	if (__copy_to_user(user_config_ptr, &user_config,
-			   sizeof(user_config))) {
+	if (copy_to_user(user_config_ptr, &user_config, sizeof(user_config))) {
 		ret = -EFAULT;
 		goto out;
 	}
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 59e64acc2c56..3733b9e20976 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -186,7 +186,7 @@ typedef struct {
 
 #define INVALID_MMIO_REG _MMIO(0)
 
-static inline u32 i915_mmio_reg_offset(i915_reg_t reg)
+static __always_inline u32 i915_mmio_reg_offset(i915_reg_t reg)
 {
 	return reg.reg;
 }
-- 
2.11.0

