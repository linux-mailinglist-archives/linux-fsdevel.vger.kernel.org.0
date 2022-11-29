Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AE663CB94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 00:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiK2XIy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 18:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiK2XIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:08:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833E1A05E
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 15:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669763267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uy7IXj/tOz3ki8gdHM6mp4HDMFVx1fz2jO0ljUt3EkQ=;
        b=CsxCxY+eHNvhK5oCqkTtNqlPKC1POUOkaRFSrepB36M64SZ+sMw/dmDvv5ICkXQRjQ1ZQK
        6prOeUMOfLgsMnokwuTxjkcn/TdUQMdtKib9C8bg6VyRZxEzIqguh/UU35vg83CoabHi1c
        oCeyyU8AeCEJjNjeWmEWclm8gXlqqO8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-czH_BrYgOX2jsNcES1R43A-1; Tue, 29 Nov 2022 18:07:44 -0500
X-MC-Unique: czH_BrYgOX2jsNcES1R43A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E91BA3804535;
        Tue, 29 Nov 2022 23:07:43 +0000 (UTC)
Received: from pasta.redhat.com (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85E3440C6EC4;
        Tue, 29 Nov 2022 23:07:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] gfs2: Shut down frozen filesystem on last unmount
Date:   Wed, 30 Nov 2022 00:07:35 +0100
Message-Id: <20221129230736.3462830-4-agruenba@redhat.com>
In-Reply-To: <20221129230736.3462830-1-agruenba@redhat.com>
References: <20221129230736.3462830-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

So far, when a frozen filesystem is last unmouted, it turns into a
zombie rather than being shut down; to shut it down, it needs to be
remounted and thawed first.

That's silly for local filesystems, but it's worse for filesystems like
gfs2 which freeze a filesystem cluster-wide when fsfreeze is called on
one of the nodes.  Only the node that initiated a freeze is allowed to
thaw the filesystem it again.  On the other nodes, the only way to shut
down the remotely frozen filesystem is to power off.

Change that on gfs2 so that frozen filesystems are immediately shut down
when they are last unmounted and removed from the filesystem namespace.
This doesn't require writing to the filesystem, so the remaining cluster
nodes remain undisturbed.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glops.c | 17 +++--------------
 fs/gfs2/super.c | 27 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index ceadb2d2d948..d73d1944543f 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -555,25 +555,13 @@ static void inode_go_dump(struct seq_file *seq, struct gfs2_glock *gl,
 static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-	struct super_block *sb = sdp->sd_vfs;
 
 	if (!remote ||
 	    gl->gl_state != LM_ST_SHARED ||
 	    gl->gl_demote_state != LM_ST_UNLOCKED)
 		return;
 
-	/*
-	 * Try to get an active super block reference to prevent racing with
-	 * unmount (see trylock_super()).  But note that unmount isn't the only
-	 * place where a write lock on s_umount is taken, and we can fail here
-	 * because of things like remount as well.
-	 */
-	if (down_read_trylock(&sb->s_umount)) {
-		atomic_inc(&sb->s_active);
-		up_read(&sb->s_umount);
-		if (!queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work))
-			deactivate_super(sb);
-	}
+	queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work);
 }
 
 /**
@@ -588,7 +576,8 @@ static int freeze_go_xmote_bh(struct gfs2_glock *gl)
 	struct gfs2_log_header_host head;
 	int error;
 
-	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags) &&
+	    !test_bit(SDF_FROZEN, &sdp->sd_flags)) {
 		j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
 
 		error = gfs2_find_jhead(sdp->sd_jdesc, &head, false);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index ce0e6d5e0e47..0c6a9e09b5cb 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -533,7 +533,8 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 
 void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 {
-	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
+	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags) &&
+				!test_bit(SDF_FROZEN, &sdp->sd_flags);
 
 	gfs2_flush_delete_work(sdp);
 	if (!log_write_allowed && current == sdp->sd_quotad_process)
@@ -606,6 +607,7 @@ static void gfs2_put_super(struct super_block *sb)
 
 	/*  Release stuff  */
 
+	flush_work(&sdp->sd_freeze_work);
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 
 	iput(sdp->sd_jindex);
@@ -667,7 +669,10 @@ static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
 	struct super_block *sb = sdp->sd_vfs;
 	int error;
 
-	error = freeze_super(sb);
+	if (!activate_super(sb))
+		return -EBUSY;
+	error = freeze_active_super(sb);
+	deactivate_super(sb);
 	if (error)
 		return error;
 
@@ -685,10 +690,22 @@ static int gfs2_enforce_thaw(struct gfs2_sbd *sdp)
 	struct super_block *sb = sdp->sd_vfs;
 	int error;
 
-	error = gfs2_freeze_lock_shared(sdp, 0);
+	error = gfs2_freeze_lock_shared(sdp, GL_ASYNC);
 	if (error)
 		goto fail;
-	error = thaw_super(sb);
+wait_longer:
+	error = gfs2_glock_async_wait(1, &sdp->sd_freeze_gh, 5 * HZ);
+	if (error && error != -ESTALE)
+		goto fail;
+	if (!activate_super(sb))
+		return -EBUSY;
+	if (error != 0) {
+		/* We don't have the lock, yet. */
+		deactivate_super(sb);
+		goto wait_longer;
+	}
+	error = thaw_active_super(sb);
+	deactivate_super(sb);
 	if (!error)
 		return 0;
 
@@ -701,7 +718,6 @@ static int gfs2_enforce_thaw(struct gfs2_sbd *sdp)
 void gfs2_freeze_func(struct work_struct *work)
 {
 	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
-	struct super_block *sb = sdp->sd_vfs;
 	int error;
 
 	mutex_lock(&sdp->sd_freeze_mutex);
@@ -724,7 +740,6 @@ void gfs2_freeze_func(struct work_struct *work)
 
 out_unlock:
 	mutex_unlock(&sdp->sd_freeze_mutex);
-	deactivate_super(sb);
 out:
 	if (error)
 		fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n", error);
-- 
2.38.1

