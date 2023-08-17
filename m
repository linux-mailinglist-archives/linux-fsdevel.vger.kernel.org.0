Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6C77F625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350653AbjHQMNs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 08:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350723AbjHQMNZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EE735B7;
        Thu, 17 Aug 2023 05:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274368; x=1723810368;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HTyGUgCfjVfJAYjNanvpti5hjy96bJX7OuvmYkznDJA=;
  b=HPdp8Iy+28PhRiLDlX2d3Kmm8nDAIGojbjFChASz4WlQG6LBbF1XkZmg
   4UZEdltSO1EdwLkljl+c/+Wh/8VDmevavM9heu2CGfruObhTfRKcAcgIt
   phZxtn1cYqdACr7CXvWw/VHg9Af5euct4dHYebmFsFl6fYvBSKN6tF6Bt
   W0C5kxgb1qfo/mxmkvOsx8/Iffg9TD9xjFPuM9mXQdCgxuyJX/ZuXQj5J
   OXjralFUQYgx45jcWLdJrPXfB9RhNXiCZIjB6zXYF79usbFemYMZ833vn
   myR8DG1cvQAHp//sLECijnLCBpqEcYGS60BC8FUwUGELdIi8hdYJIqBCz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362943216"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="362943216"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:12:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="908385095"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="908385095"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 17 Aug 2023 05:12:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5DE52DE4; Thu, 17 Aug 2023 15:12:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] fs/affs: Rename local toupper() to fn() to avoid confusion
Date:   Thu, 17 Aug 2023 15:12:17 +0300
Message-Id: <20230817121217.501549-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A compiler may see the collision with the toupper() defined in ctype.h:

 fs/affs/namei.c:159:19: warning: unused variable 'toupper' [-Wunused-variable]
   159 |         toupper_t toupper = affs_get_toupper(sb);

To prevent this from happening, rename toupper local variable to fn.

Initially this had been introduced by 24579a881513 ("v2.4.3.5 -> v2.4.3.6")
in the history.git by history group.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/affs/namei.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index d12ccfd2a83d..2fe4a5832fcf 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -43,7 +43,7 @@ affs_get_toupper(struct super_block *sb)
  * Note: the dentry argument is the parent dentry.
  */
 static inline int
-__affs_hash_dentry(const struct dentry *dentry, struct qstr *qstr, toupper_t toupper, bool notruncate)
+__affs_hash_dentry(const struct dentry *dentry, struct qstr *qstr, toupper_t fn, bool notruncate)
 {
 	const u8 *name = qstr->name;
 	unsigned long hash;
@@ -57,7 +57,7 @@ __affs_hash_dentry(const struct dentry *dentry, struct qstr *qstr, toupper_t tou
 	hash = init_name_hash(dentry);
 	len = min(qstr->len, AFFSNAMEMAX);
 	for (; len > 0; name++, len--)
-		hash = partial_name_hash(toupper(*name), hash);
+		hash = partial_name_hash(fn(*name), hash);
 	qstr->hash = end_name_hash(hash);
 
 	return 0;
@@ -80,7 +80,7 @@ affs_intl_hash_dentry(const struct dentry *dentry, struct qstr *qstr)
 }
 
 static inline int __affs_compare_dentry(unsigned int len,
-		const char *str, const struct qstr *name, toupper_t toupper,
+		const char *str, const struct qstr *name, toupper_t fn,
 		bool notruncate)
 {
 	const u8 *aname = str;
@@ -106,7 +106,7 @@ static inline int __affs_compare_dentry(unsigned int len,
 		return 1;
 
 	for (; len > 0; len--)
-		if (toupper(*aname++) != toupper(*bname++))
+		if (fn(*aname++) != fn(*bname++))
 			return 1;
 
 	return 0;
@@ -135,7 +135,7 @@ affs_intl_compare_dentry(const struct dentry *dentry,
  */
 
 static inline int
-affs_match(struct dentry *dentry, const u8 *name2, toupper_t toupper)
+affs_match(struct dentry *dentry, const u8 *name2, toupper_t fn)
 {
 	const u8 *name = dentry->d_name.name;
 	int len = dentry->d_name.len;
@@ -148,7 +148,7 @@ affs_match(struct dentry *dentry, const u8 *name2, toupper_t toupper)
 		return 0;
 
 	for (name2++; len > 0; len--)
-		if (toupper(*name++) != toupper(*name2++))
+		if (fn(*name++) != fn(*name2++))
 			return 0;
 	return 1;
 }
@@ -156,12 +156,12 @@ affs_match(struct dentry *dentry, const u8 *name2, toupper_t toupper)
 int
 affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len)
 {
-	toupper_t toupper = affs_get_toupper(sb);
+	toupper_t fn = affs_get_toupper(sb);
 	u32 hash;
 
 	hash = len = min(len, AFFSNAMEMAX);
 	for (; len > 0; len--)
-		hash = (hash * 13 + toupper(*name++)) & 0x7ff;
+		hash = (hash * 13 + fn(*name++)) & 0x7ff;
 
 	return hash % AFFS_SB(sb)->s_hashsize;
 }
@@ -171,7 +171,7 @@ affs_find_entry(struct inode *dir, struct dentry *dentry)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
-	toupper_t toupper = affs_get_toupper(sb);
+	toupper_t fn = affs_get_toupper(sb);
 	u32 key;
 
 	pr_debug("%s(\"%pd\")\n", __func__, dentry);
@@ -189,7 +189,7 @@ affs_find_entry(struct inode *dir, struct dentry *dentry)
 		bh = affs_bread(sb, key);
 		if (!bh)
 			return ERR_PTR(-EIO);
-		if (affs_match(dentry, AFFS_TAIL(sb, bh)->name, toupper))
+		if (affs_match(dentry, AFFS_TAIL(sb, bh)->name, fn))
 			return bh;
 		key = be32_to_cpu(AFFS_TAIL(sb, bh)->hash_chain);
 	}
-- 
2.40.0.1.gaa8946217a0b

