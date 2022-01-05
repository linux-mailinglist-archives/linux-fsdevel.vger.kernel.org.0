Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8BC4857DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 19:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242688AbiAESDE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 13:03:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242686AbiAESDD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641405782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=S1qUAxYXkU/UKH+717qJdM5UOe1+cv20Xw7cUSOE+Y8=;
        b=eUlL7VadEavLljb2hYKjwg5KM36XuxRAaNW5lsMRyzLyxyHBq0LdWY0OJIKhuFAnxR8Btf
        jnK6GBhyj07COBJ7OFWJX3mPbb42uEobJzI4vojedWU9E9DsQOrogSr0C+W5CDwPoYkWPE
        W7Pk7E0FJakk09CEIjL+5vIJ7tW+tDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-Aepn0ABWMleDR30G5Agg9w-1; Wed, 05 Jan 2022 13:03:01 -0500
X-MC-Unique: Aepn0ABWMleDR30G5Agg9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91AB21800D50
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 18:03:00 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5019477466
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jan 2022 18:03:00 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] namei: clear nd->root.mnt before O_CREAT unlazy
Date:   Wed,  5 Jan 2022 13:02:59 -0500
Message-Id: <20220105180259.115760-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
the rcu logic from complete_walk() into a new helper and invoke that
from both places.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/namei.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..b32fcbc99929 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -856,6 +856,22 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
 		return 1;
 }
 
+static inline bool complete_walk_rcu(struct nameidata *nd)
+{
+	if (nd->flags & LOOKUP_RCU) {
+		/*
+		 * We don't want to zero nd->root for scoped-lookups or
+		 * externally-managed nd->root.
+		 */
+		if (!(nd->state & ND_ROOT_PRESET))
+			if (!(nd->flags & LOOKUP_IS_SCOPED))
+				nd->root.mnt = NULL;
+		nd->flags &= ~LOOKUP_CACHED;
+		return try_to_unlazy(nd);
+	}
+	return true;
+}
+
 /**
  * complete_walk - successful completion of path walk
  * @nd:  pointer nameidata
@@ -871,18 +887,8 @@ static int complete_walk(struct nameidata *nd)
 	struct dentry *dentry = nd->path.dentry;
 	int status;
 
-	if (nd->flags & LOOKUP_RCU) {
-		/*
-		 * We don't want to zero nd->root for scoped-lookups or
-		 * externally-managed nd->root.
-		 */
-		if (!(nd->state & ND_ROOT_PRESET))
-			if (!(nd->flags & LOOKUP_IS_SCOPED))
-				nd->root.mnt = NULL;
-		nd->flags &= ~LOOKUP_CACHED;
-		if (!try_to_unlazy(nd))
-			return -ECHILD;
-	}
+	if (!complete_walk_rcu(nd))
+		return -ECHILD;
 
 	if (unlikely(nd->flags & LOOKUP_IS_SCOPED)) {
 		/*
@@ -3325,10 +3331,9 @@ static const char *open_last_lookups(struct nameidata *nd,
 		BUG_ON(nd->flags & LOOKUP_RCU);
 	} else {
 		/* create side of things */
-		if (nd->flags & LOOKUP_RCU) {
-			if (!try_to_unlazy(nd))
-				return ERR_PTR(-ECHILD);
-		}
+		if (!complete_walk_rcu(nd))
+			return ERR_PTR(-ECHILD);
+
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
 		if (unlikely(nd->last.name[nd->last.len]))
-- 
2.31.1

