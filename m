Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2F167A2E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjAXTbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjAXTa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBA34DE00;
        Tue, 24 Jan 2023 11:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26AA161330;
        Tue, 24 Jan 2023 19:30:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D7C433D2;
        Tue, 24 Jan 2023 19:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588642;
        bh=ZAUsaWYTub94bC3FBm1YHd+cmQFcFGWfOwXUfMYvsgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4h6R51QaN8AT5BKwNEs+I5soWrCOhg/WjvVsdn9NKnN9Jl1ynWg94uD7pa0TGPTq
         o9bvSWC3jzUHihT/etGf0IpRSdlybIZQSX9avNj0Q/n6xuAa3shD5I6ABBmTbB0R8L
         aIRqYcanGDCrDMsit8Ej2eO/Fh0py+2XhhV+2DO/CSHW0EMF1L2EeCQfQ9N0RtkOuv
         W+xWyRFu4Hk6vHgFx37e+XGO8WHAK0FsYp4BOrTI0ghgyL8ycmGqUjxTibAZbSCq2/
         nrDEBz8Sv1EdOXzW0KstwHjPJmX0AgE6ZL51vAwk1dJRt/p9F0lipNZH+1dePdj3Ju
         Mww3bzuwBPLIQ==
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
Subject: [PATCH v8 RESEND 6/8] nfsd: move nfsd4_change_attribute to nfsfh.c
Date:   Tue, 24 Jan 2023 14:30:23 -0500
Message-Id: <20230124193025.185781-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a pretty big function for inlining. Move it to being
non-inlined.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsfh.c | 27 +++++++++++++++++++++++++++
 fs/nfsd/nfsfh.h | 29 +----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 8c52b6c9d31a..ac89e25e7733 100644
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
index 513e028b0bbe..4e0ecf0ae2cf 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -293,34 +293,7 @@ static inline void fh_clear_pre_post_attrs(struct svc_fh *fhp)
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
2.39.1

