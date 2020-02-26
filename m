Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90B17004C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBZNln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:43 -0500
Received: from relay.sw.ru ([185.231.240.75]:44736 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgBZNlY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6ww2-0006rb-RR; Wed, 26 Feb 2020 16:41:11 +0300
Subject: [PATCH RFC 4/5] ext4: Prepare ext4_mb_discard_preallocations() for
 handling EXT4_MB_HINT_GOAL_ONLY
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:41:10 +0300
Message-ID: <158272447070.281342.755800197684231698.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EXT4_MB_HINT_GOAL_ONLY is currently unused. This patch teaches
ext4_mb_discard_preallocations() to discard only that preallocated
range, which contains a specified block, in case of the flag is set.
Otherwise, a preallocated range is not discarded.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/ext4/mballoc.c |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 51a78eb65f3c..b1b3c5526d1a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3894,8 +3894,8 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
  *   1) how many requested
  */
 static noinline_for_stack int
-ext4_mb_discard_group_preallocations(struct super_block *sb,
-					ext4_group_t group, int needed)
+ext4_mb_discard_group_preallocations(struct super_block *sb, ext4_group_t group,
+				     int needed, ext4_fsblk_t goal)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
 	struct buffer_head *bitmap_bh = NULL;
@@ -3947,6 +3947,12 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
 			continue;
 		}
 
+		if (goal != (ext4_fsblk_t)-1 &&
+		    (goal < pa->pa_pstart || goal >= pa->pa_pstart + pa->pa_len)) {
+			spin_unlock(&pa->pa_lock);
+			continue;
+		}
+
 		/* seems this one can be freed ... */
 		pa->pa_deleted = 1;
 
@@ -4462,15 +4468,23 @@ static int ext4_mb_release_context(struct ext4_allocation_context *ac)
 	return 0;
 }
 
-static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
+static int ext4_mb_discard_preallocations(struct super_block *sb,
+					  struct ext4_allocation_context *ac)
 {
-	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
+	ext4_group_t i = 0, ngroups = ext4_get_groups_count(sb);
+	int needed = ac->ac_o_ex.fe_len;
+	ext4_fsblk_t goal = (ext4_fsblk_t)-1;
 	int ret;
 	int freed = 0;
 
+	if (ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY) {
+		i = ac->ac_o_ex.fe_group;
+		ngroups = i + 1;
+		goal = ext4_grp_offs_to_block(ac->ac_sb, &ac->ac_g_ex);
+	}
 	trace_ext4_mb_discard_preallocations(sb, needed);
-	for (i = 0; i < ngroups && needed > 0; i++) {
-		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
+	for (; i < ngroups && needed > 0; i++) {
+		ret = ext4_mb_discard_group_preallocations(sb, i, needed, goal);
 		freed += ret;
 		needed -= ret;
 	}
@@ -4585,7 +4599,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 			ar->len = ac->ac_b_ex.fe_len;
 		}
 	} else {
-		freed  = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
+		freed  = ext4_mb_discard_preallocations(sb, ac);
 		if (freed)
 			goto repeat;
 		*errp = -ENOSPC;


