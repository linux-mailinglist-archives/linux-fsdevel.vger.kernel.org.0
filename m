Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539007B1A9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjI1LUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjI1LTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:19:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC62D4B;
        Thu, 28 Sep 2023 04:05:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F98C43391;
        Thu, 28 Sep 2023 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899142;
        bh=9I3VHyY35UotQhyUrdlY07m/1CcXBFl8HcZX1pCcZAg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=IXmIq2lNI89BP8ueuoBKzaSvH81WQbpDTUJc/EW8eTXoGoLVK8LICU3B8YGTRtzSj
         1N8/xtJy/GZ/sMWvb1rhwpBD4mnmRwjk0vy5aVeiIyQ0s2D4DYY50e9Wf7s/TOrdOX
         PKcVbUB7Pd8uVaE1xnCFHJf7vm1ug5x7l1LHVAVJuhS0c+xN83wGgKLTAjWJoUqpd1
         JHbKLr5iU8fsddqBt3+/+SBrcPtm42PIfMoT1nsMoe1N1Mo6iCizAHoDjS3zA0P6Ao
         0oedckcqSp9FuAPa+yJNf6M48VlT/Hm5a2zwplR/chg2jUyISsRmcpMbooy936jDo0
         l7lEoPq+UXO2w==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 75/87] fs/vboxsf: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:24 -0400
Message-ID: <20230928110413.33032-74-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/vboxsf/utils.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 83f20dd15522..72ac9320e6a3 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -126,12 +126,12 @@ int vboxsf_init_inode(struct vboxsf_sbi *sbi, struct inode *inode,
 	do_div(allocated, 512);
 	inode->i_blocks = allocated;
 
-	inode->i_atime = ns_to_timespec64(
-				 info->access_time.ns_relative_to_unix_epoch);
+	inode_set_atime_to_ts(inode,
+			      ns_to_timespec64(info->access_time.ns_relative_to_unix_epoch));
 	inode_set_ctime_to_ts(inode,
 			      ns_to_timespec64(info->change_time.ns_relative_to_unix_epoch));
-	inode->i_mtime = ns_to_timespec64(
-			   info->modification_time.ns_relative_to_unix_epoch);
+	inode_set_mtime_to_ts(inode,
+			      ns_to_timespec64(info->modification_time.ns_relative_to_unix_epoch));
 	return 0;
 }
 
@@ -194,7 +194,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	struct vboxsf_sbi *sbi;
 	struct vboxsf_inode *sf_i;
 	struct shfl_fsobjinfo info;
-	struct timespec64 prev_mtime;
+	struct timespec64 mtime, prev_mtime;
 	struct inode *inode;
 	int err;
 
@@ -202,7 +202,7 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 		return -EINVAL;
 
 	inode = d_inode(dentry);
-	prev_mtime = inode->i_mtime;
+	prev_mtime = inode_get_mtime(inode);
 	sf_i = VBOXSF_I(inode);
 	sbi = VBOXSF_SBI(dentry->d_sb);
 	if (!sf_i->force_restat) {
@@ -225,7 +225,8 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	 * page-cache for it.  Note this also gets triggered by our own writes,
 	 * this is unavoidable.
 	 */
-	if (timespec64_compare(&inode->i_mtime, &prev_mtime) > 0)
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&mtime, &prev_mtime) > 0)
 		invalidate_inode_pages2(inode->i_mapping);
 
 	return 0;
-- 
2.41.0

