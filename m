Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE11600D2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJQK6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJQK5a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:57:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A770D61708;
        Mon, 17 Oct 2022 03:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E0D86105A;
        Mon, 17 Oct 2022 10:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB448C433D6;
        Mon, 17 Oct 2022 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666004246;
        bh=LBaEFSh5DOeyzDGsOyxhMwQpssm5JK6u2HESg5ybNII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcdT6b7mb+oJp742oGeuVIMOfw8oEZ0enQ18wg8Ay/lNdbFfxNrtDJeG5LwPho5dD
         mjrEEtQNE5tTDsZ3XJBuv/1zzQ2QeaSuOG/cCyWcsUY7eJIEeSErX+E+vAIFJQsC55
         N0s4+1Hq8cIO6nsNFLSxEB+742ItXHY3Kedw1srG/T4sW8IkT4hPE77/++e78jtlwu
         /K5Vs5K3g2tUySh+SylFTQGTzwZWsWsW8g3y1rdekQXDShurEUkxEr/O+y+NwuXVZ7
         V0SmxQbcJ+ulid2bOfa6XXx920Zn48b/9WwRFyMGnJFHPxLoEn+tBpw6zmF+eqKvTC
         tpSNnThfThorQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 6/9] nfsd: move nfsd4_change_attribute to nfsfh.c
Date:   Mon, 17 Oct 2022 06:57:06 -0400
Message-Id: <20221017105709.10830-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017105709.10830-1-jlayton@kernel.org>
References: <20221017105709.10830-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a pretty big function for inlining. Move it to being
non-inlined.

Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h | 29 +----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index d73434200df9..7030d9209903 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -748,3 +748,30 @@ enum fsid_source fsid_source(const struct svc_fh *fhp)
 		return FSIDSOURCE_UUID;
 	return FSIDSOURCE_DEV;
 }
+
+/*
+ * We could use i_version alone as the change attribute.  However,
+ * i_version can go backwards after a reboot.  On its own that doesn't
+ * necessarily cause a problem, but if i_version goes backwards and then
+ * is incremented again it could reuse a value that was previously used
+ * before boot, and a client who queried the two values might
+ * incorrectly assume nothing changed.
+ *
+ * By using both ctime and the i_version counter we guarantee that as
+ * long as time doesn't go backwards we never reuse an old value.
+ */
+u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode)
+{
+	if (inode->i_sb->s_export_op->fetch_iversion)
+		return inode->i_sb->s_export_op->fetch_iversion(inode);
+	else if (IS_I_VERSION(inode)) {
+		u64 chattr;
+
+		chattr =  stat->ctime.tv_sec;
+		chattr <<= 30;
+		chattr += stat->ctime.tv_nsec;
+		chattr += inode_query_iversion(inode);
+		return chattr;
+	} else
+		return time_to_chattr(&stat->ctime);
+}
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index c3ae6414fc5c..4c223a7a91d4 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -291,34 +291,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
 	fhp->fh_pre_saved = false;
 }
 
-/*
- * We could use i_version alone as the change attribute.  However,
- * i_version can go backwards after a reboot.  On its own that doesn't
- * necessarily cause a problem, but if i_version goes backwards and then
- * is incremented again it could reuse a value that was previously used
- * before boot, and a client who queried the two values might
- * incorrectly assume nothing changed.
- *
- * By using both ctime and the i_version counter we guarantee that as
- * long as time doesn't go backwards we never reuse an old value.
- */
-static inline u64 nfsd4_change_attribute(struct kstat *stat,
-					 struct inode *inode)
-{
-	if (inode->i_sb->s_export_op->fetch_iversion)
-		return inode->i_sb->s_export_op->fetch_iversion(inode);
-	else if (IS_I_VERSION(inode)) {
-		u64 chattr;
-
-		chattr =  stat->ctime.tv_sec;
-		chattr <<= 30;
-		chattr += stat->ctime.tv_nsec;
-		chattr += inode_query_iversion(inode);
-		return chattr;
-	} else
-		return time_to_chattr(&stat->ctime);
-}
-
+u64 nfsd4_change_attribute(struct kstat *stat, struct inode *inode);
 extern void fh_fill_pre_attrs(struct svc_fh *fhp);
 extern void fh_fill_post_attrs(struct svc_fh *fhp);
 extern void fh_fill_both_attrs(struct svc_fh *fhp);
-- 
2.37.3

