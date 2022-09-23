Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2645E7C77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIWODl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 10:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiIWODj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547D13D1DC
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Sep 2022 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663941817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sAlC4iwzNEi+7cfcprc1N+wypP71ApsIj+KX65Cgw0I=;
        b=ZOhcsbhjIbMDOPJerytewQ73JAjfSrJLYDRjLridikN+dA7dHkhIppPy5m5/CsK1sRejWR
        1lZeS+jKYD8n6afXIg/867QbVkRPMH7d4nBuCQKxJ6CDBHcUa5/OGkO17CokSv8dGdDcKo
        ADQgzZX/m3BCJPZDQb7r2Z4s4DI47hU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-Q8svLQRfPmugFLA80W5xYQ-1; Fri, 23 Sep 2022 10:03:35 -0400
X-MC-Unique: Q8svLQRfPmugFLA80W5xYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 837D9872855;
        Fri, 23 Sep 2022 14:03:35 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.32.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54C0A2024CBE;
        Fri, 23 Sep 2022 14:03:35 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>
Subject: [PATCH v2 RESEND] namei: clear nd->root.mnt before O_CREAT unlazy
Date:   Fri, 23 Sep 2022 10:03:34 -0400
Message-Id: <20220923140334.514276-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The unlazy sequence of an rcuwalk lookup occurs a bit earlier than
normal for O_CREAT lookups (i.e. in open_last_lookups()). The create
logic here historically invoked complete_walk(), which clears the
nd->root.mnt pointer when appropriate before the unlazy.  This
changed in commit 72287417abd1 ("open_last_lookups(): don't abuse
complete_walk() when all we want is unlazy"), which refactored the
create path to invoke unlazy_walk() and not consider nd->root.mnt.

This tweak negatively impacts performance on a concurrent
open(O_CREAT) workload to multiple independent mounts beneath the
root directory. This attributes to increased spinlock contention on
the root dentry via legitimize_root(), to the point where the
spinlock becomes the primary bottleneck over the directory inode
rwsem of the individual submounts. For example, the completion rate
of a 32k thread aim7 create/close benchmark that repeatedly passes
O_CREAT to open preexisting files drops from over 700k "jobs per
minute" to 30, increasing the overall test time from a few minutes
to over an hour.

A similar, more simplified test to create a set of opener tasks
across a set of submounts can demonstrate the problem more quickly.
For example, consider sets of 100 open/close tasks each running
against 64 independent filesystem mounts (i.e. 6400 tasks total),
with each task completing 10k iterations before it exits. On an
80xcpu box running v5.16.0-rc2, this test completes in 50-55s. With
this patch applied, the same test completes in 10-15s.

This is not the most realistic workload in the world as it factors
out inode allocation in the filesystem. The contention can also be
avoided by more selective use of O_CREAT or via use of relative
pathnames. That said, this regression appears to be an unintentional
side effect of code cleanup and might be unexpected for users.
Restore original behavior prior to commit 72287417abd1 by factoring
the nd->root handling logic from complete_walk() into a new helper
and invoke that from both places.

Note that the LOOKUP_CACHE logic is not required here because it is
incompatible with O_CREAT. Otherwise the tradeoff for this change is
that this may impact behavior when an absolute path O_CREAT lookup
lands on a symlink that contains another absolute path. The unlazy
sequence of the create lookup now clears the nd->root mount pointer,
which means that once we read said link via step_into(), the
subsequent nd_jump_root() calls into set_root() to grab the mount
pointer again (from refwalk mode). This is historical behavior for
O_CREAT and less common than the current behavior of a typical
create lookup unnecessarily legitimizing the root dentry.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

Al,

It looks like this one fell through the cracks from the last time I
posted it [1]. IIRC, the change in v2 was to try and address your
concern around the factoring and unclear helper naming of the original
v1 [2]. Any chance of getting this version pulled? Thanks.

Brian

[1] https://lore.kernel.org/linux-fsdevel/20220112142459.544276-1-bfoster@redhat.com/
[2] https://lore.kernel.org/linux-fsdevel/20220105180259.115760-1-bfoster@redhat.com/

 fs/namei.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..083b8b6bc566 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -858,6 +858,18 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 		return 1;
 }
 
+static inline bool nd_reset_root_and_unlazy(struct nameidata *nd)
+{
+	/*
+	 * We don't want to zero nd->root for scoped-lookups or
+	 * externally-managed nd->root.
+	 */
+	if (!(nd->state & ND_ROOT_PRESET))
+		if (!(nd->flags & LOOKUP_IS_SCOPED))
+			nd->root.mnt = NULL;
+	return try_to_unlazy(nd);
+}
+
 /**
  * complete_walk - successful completion of path walk
  * @nd:  pointer nameidata
@@ -874,15 +886,8 @@ static int complete_walk(struct nameidata *nd)
 	int status;
 
 	if (nd->flags & LOOKUP_RCU) {
-		/*
-		 * We don't want to zero nd->root for scoped-lookups or
-		 * externally-managed nd->root.
-		 */
-		if (!(nd->state & ND_ROOT_PRESET))
-			if (!(nd->flags & LOOKUP_IS_SCOPED))
-				nd->root.mnt = NULL;
 		nd->flags &= ~LOOKUP_CACHED;
-		if (!try_to_unlazy(nd))
+		if (!nd_reset_root_and_unlazy(nd))
 			return -ECHILD;
 	}
 
@@ -3457,7 +3462,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-			if (!try_to_unlazy(nd))
+			if (!nd_reset_root_and_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-- 
2.37.2

