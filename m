Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E0955EFCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 22:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiF1UqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiF1UqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3F22A422
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656449180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etd/HiWPRFylPp9B1UP6EMuDHvBVBKKMEBDyPqA1sCk=;
        b=aLACLbjOYVIwb1WKD/PZKpEyzi1F1vsW4B3wBinAs6PCmj21O/CFMmG9sugHfg+V4ibx6W
        tcatHRTVLxEV3JCCi957Hw6+g/UGd9iksGVoiR4bvLr/Mxm8Pt1e2Tk8rhXZ+gfaznkolj
        dhWCkKquJn9EZlMZbYxQoXlTuomzC8o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-448-6--e8s4GMk2NY6qk63AJOQ-1; Tue, 28 Jun 2022 16:46:17 -0400
X-MC-Unique: 6--e8s4GMk2NY6qk63AJOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB886294EDD1;
        Tue, 28 Jun 2022 20:46:16 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.193.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDB88404E4C8;
        Tue, 28 Jun 2022 20:46:15 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/5] gfs2: Add GL_NOPID flag for process-independent glock holders
Date:   Tue, 28 Jun 2022 22:46:09 +0200
Message-Id: <20220628204611.651126-4-agruenba@redhat.com>
In-Reply-To: <20220628204611.651126-1-agruenba@redhat.com>
References: <20220628204611.651126-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a GL_NOPID flag to indicate that once a glock holder has been acquired, it
won't be associated with the current process anymore.  This is useful for iopen
and flock glocks which are associated with open files, as well as journal glock
holders and similar which are associated with the filesystem.

Once GL_NOPID is used for all applicable glocks (see the next patches),
processes will no longer be falsely reported as holding glocks which they are
not actually holding in the glocks dump file.  Unlike before, when a process is
reported as having "(ended)", this will indicate an actual bug.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 41 +++++++++++++++++++++++++++++++----------
 fs/gfs2/glock.h |  1 +
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index aa35f5d4eb54..480b3d2b00e8 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1465,6 +1465,15 @@ void gfs2_print_dbg(struct seq_file *seq, const char *fmt, ...)
 	va_end(args);
 }
 
+static inline bool pid_is_meaningful(const struct gfs2_holder *gh)
+{
+        if (!(gh->gh_flags & GL_NOPID))
+                return true;
+        if (gh->gh_state == LM_ST_UNLOCKED)
+                return true;
+        return false;
+}
+
 /**
  * add_to_queue - Add a holder to the wait queue (but look for recursion)
  * @gh: the holder structure to add
@@ -1501,10 +1510,17 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
-		if (unlikely(gh2->gh_owner_pid == gh->gh_owner_pid &&
-		    (gh->gh_gl->gl_ops->go_type != LM_TYPE_FLOCK) &&
-		    !test_bit(HIF_MAY_DEMOTE, &gh2->gh_iflags)))
-			goto trap_recursive;
+		if (likely(gh2->gh_owner_pid != gh->gh_owner_pid))
+			continue;
+		if (gh->gh_gl->gl_ops->go_type == LM_TYPE_FLOCK)
+			continue;
+		if (test_bit(HIF_MAY_DEMOTE, &gh2->gh_iflags))
+			continue;
+		if (!pid_is_meaningful(gh2))
+			continue;
+		goto trap_recursive;
+	}
+	list_for_each_entry(gh2, &gl->gl_holders, gh_list) {
 		if (try_futile &&
 		    !(gh2->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB))) {
 fail:
@@ -2319,19 +2335,24 @@ static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 static void dump_holder(struct seq_file *seq, const struct gfs2_holder *gh,
 			const char *fs_id_buf)
 {
-	struct task_struct *gh_owner = NULL;
+	const char *comm = "(none)";
+	pid_t owner_pid = 0;
 	char flags_buf[32];
 
 	rcu_read_lock();
-	if (gh->gh_owner_pid)
+	if (pid_is_meaningful(gh)) {
+		struct task_struct *gh_owner;
+
+		comm = "(ended)";
+		owner_pid = pid_nr(gh->gh_owner_pid);
 		gh_owner = pid_task(gh->gh_owner_pid, PIDTYPE_PID);
+		if (gh_owner)
+			comm = gh_owner->comm;
+	}
 	gfs2_print_dbg(seq, "%s H: s:%s f:%s e:%d p:%ld [%s] %pS\n",
 		       fs_id_buf, state2str(gh->gh_state),
 		       hflags2str(flags_buf, gh->gh_flags, gh->gh_iflags),
-		       gh->gh_error,
-		       gh->gh_owner_pid ? (long)pid_nr(gh->gh_owner_pid) : -1,
-		       gh_owner ? gh_owner->comm : "(ended)",
-		       (void *)gh->gh_ip);
+		       gh->gh_error, (long)owner_pid, comm, (void *)gh->gh_ip);
 	rcu_read_unlock();
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index c0ae9100a0bc..e764ebeba54c 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -91,6 +91,7 @@ enum {
 #define GL_ASYNC		0x0040
 #define GL_EXACT		0x0080
 #define GL_SKIP			0x0100
+#define GL_NOPID		0x0200
 #define GL_NOCACHE		0x0400
   
 /*
-- 
2.35.1

