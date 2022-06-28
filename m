Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4729055EFD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiF1Uqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiF1Uq0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADE6C2A97C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 13:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656449184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxAXLtt/qHvFpa3MozdupVmWHjm0h9gbo/SJ35DEqEU=;
        b=H9fzeCJsOUvfqZkVUjaJgi4GGNJybM0X2d89DR3bgVJzJqtct7VzjcIEdgdR3Edzc+NZHl
        BKR37vSTgruC4h+HAD6mJZym7Hw95R3mFL2Y7c6sqEsvaJvv0aptwSmoiu+kWDiGeI1a4O
        j07UrP/Onwimm5W8jRXvteq4KWOgaZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-Jj1d7vLEMh2BLGWcJF-AOw-1; Tue, 28 Jun 2022 16:46:20 -0400
X-MC-Unique: Jj1d7vLEMh2BLGWcJF-AOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E737818A6584;
        Tue, 28 Jun 2022 20:46:19 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.193.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0026C40D282F;
        Tue, 28 Jun 2022 20:46:18 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/5] gfs2: Mark the remaining process-independent glock holders as GL_NOPID
Date:   Tue, 28 Jun 2022 22:46:11 +0200
Message-Id: <20220628204611.651126-6-agruenba@redhat.com>
In-Reply-To: <20220628204611.651126-1-agruenba@redhat.com>
References: <20220628204611.651126-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the GL_NOPID flag for the remaining glock holders which are not
associated with the current process.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/inode.c      |  6 ++++--
 fs/gfs2/ops_fstype.c | 14 ++++++++------
 fs/gfs2/super.c      |  3 ++-
 fs/gfs2/util.c       |  6 ++++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c8ec876f33ea..e211ed8636b5 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -143,7 +143,8 @@ struct inode *gfs2_inode_lookup(struct super_block *sb, unsigned int type,
 
 		if (blktype != GFS2_BLKST_UNLINKED)
 			gfs2_cancel_delete_work(io_gl);
-		error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED, GL_EXACT,
+		error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED,
+					   GL_EXACT | GL_NOPID,
 					   &ip->i_iopen_gh);
 		gfs2_glock_put(io_gl);
 		if (unlikely(error))
@@ -720,7 +721,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 	error = insert_inode_locked4(inode, ip->i_no_addr, iget_test, &ip->i_no_addr);
 	BUG_ON(error);
 
-	error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED, GL_EXACT, &ip->i_iopen_gh);
+	error = gfs2_glock_nq_init(io_gl, LM_ST_SHARED, GL_EXACT | GL_NOPID,
+				   &ip->i_iopen_gh);
 	if (error)
 		goto fail_gunlock2;
 
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index c9b423c874a3..904a2d47c4b3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -403,7 +403,8 @@ static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
 
 	error = gfs2_glock_nq_num(sdp,
 				  GFS2_MOUNT_LOCK, &gfs2_nondisk_glops,
-				  LM_ST_EXCLUSIVE, LM_FLAG_NOEXP | GL_NOCACHE,
+				  LM_ST_EXCLUSIVE,
+				  LM_FLAG_NOEXP | GL_NOCACHE | GL_NOPID,
 				  mount_gh);
 	if (error) {
 		fs_err(sdp, "can't acquire mount glock: %d\n", error);
@@ -413,7 +414,7 @@ static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
 	error = gfs2_glock_nq_num(sdp,
 				  GFS2_LIVE_LOCK, &gfs2_nondisk_glops,
 				  LM_ST_SHARED,
-				  LM_FLAG_NOEXP | GL_EXACT,
+				  LM_FLAG_NOEXP | GL_EXACT | GL_NOPID,
 				  &sdp->sd_live_gh);
 	if (error) {
 		fs_err(sdp, "can't acquire live glock: %d\n", error);
@@ -689,7 +690,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 	iput(pn);
 	pn = NULL;
 	ip = GFS2_I(sdp->sd_sc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0,
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
 				   &sdp->sd_sc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
@@ -778,7 +779,7 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		error = gfs2_glock_nq_num(sdp, sdp->sd_lockstruct.ls_jid,
 					  &gfs2_journal_glops,
 					  LM_ST_EXCLUSIVE,
-					  LM_FLAG_NOEXP | GL_NOCACHE,
+					  LM_FLAG_NOEXP | GL_NOCACHE | GL_NOPID,
 					  &sdp->sd_journal_gh);
 		if (error) {
 			fs_err(sdp, "can't acquire journal glock: %d\n", error);
@@ -788,7 +789,8 @@ static int init_journal(struct gfs2_sbd *sdp, int undo)
 		ip = GFS2_I(sdp->sd_jdesc->jd_inode);
 		sdp->sd_jinode_gl = ip->i_gl;
 		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED,
-					   LM_FLAG_NOEXP | GL_EXACT | GL_NOCACHE,
+					   LM_FLAG_NOEXP | GL_EXACT |
+					   GL_NOCACHE | GL_NOPID,
 					   &sdp->sd_jinode_gh);
 		if (error) {
 			fs_err(sdp, "can't acquire journal inode glock: %d\n",
@@ -959,7 +961,7 @@ static int init_per_node(struct gfs2_sbd *sdp, int undo)
 	pn = NULL;
 
 	ip = GFS2_I(sdp->sd_qc_inode);
-	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0,
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, GL_NOPID,
 				   &sdp->sd_qc_gh);
 	if (error) {
 		fs_err(sdp, "can't lock local \"qc\" file: %d\n", error);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index bdb773e5c88f..90db4a289269 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -346,7 +346,8 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	}
 
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_EXCLUSIVE,
-				   LM_FLAG_NOEXP, &sdp->sd_freeze_gh);
+				   LM_FLAG_NOEXP | GL_NOPID,
+				   &sdp->sd_freeze_gh);
 	if (error)
 		goto out;
 
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index 8241029a2a5d..95d733dd3c25 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -226,7 +226,8 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	fs_warn(sdp, "Requesting recovery of jid %d.\n",
 		sdp->sd_lockstruct.ls_jid);
-	gfs2_holder_reinit(LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | LM_FLAG_NOEXP,
+	gfs2_holder_reinit(LM_ST_EXCLUSIVE,
+			   LM_FLAG_TRY_1CB | LM_FLAG_NOEXP | GL_NOPID,
 			   &sdp->sd_live_gh);
 	msleep(GL_GLOCK_MAX_HOLD);
 	/*
@@ -251,7 +252,8 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 			fs_warn(sdp, "Unable to recover our journal jid %d.\n",
 				sdp->sd_lockstruct.ls_jid);
 		gfs2_glock_dq_wait(&sdp->sd_live_gh);
-		gfs2_holder_reinit(LM_ST_SHARED, LM_FLAG_NOEXP | GL_EXACT,
+		gfs2_holder_reinit(LM_ST_SHARED,
+				   LM_FLAG_NOEXP | GL_EXACT | GL_NOPID,
 				   &sdp->sd_live_gh);
 		gfs2_glock_nq(&sdp->sd_live_gh);
 	}
-- 
2.35.1

