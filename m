Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CA48C5EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 15:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354066AbiALOZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 09:25:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30476 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354063AbiALOZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641997504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jh2XMK2V1qwBVBuPzTSyQq9w2BxxDUBNOa2vzTa/taQ=;
        b=JsqRagowuor9n9fNOVy9WahzZFiyGhKotbIf9zZxRyJrNEYnFVcDLqUTivUx52Pteb3BqQ
        G9/Nqm8iNmva2b7qlmw/CNxLkFm+kJhn/n3YB+BJ8M43WI2M/LgK8nz8JMQli+rAJoVNS4
        FWSHVat14jklIuwPwHVpeg7NOU5IidA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-edat2x0lMjaF_ZJwJmzBYA-1; Wed, 12 Jan 2022 09:25:01 -0500
X-MC-Unique: edat2x0lMjaF_ZJwJmzBYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 707C883DBE3;
        Wed, 12 Jan 2022 14:25:00 +0000 (UTC)
Received: from bfoster.redhat.com (unknown [10.22.8.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D835C85883;
        Wed, 12 Jan 2022 14:24:59 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2] namei: clear nd->root.mnt before O_CREAT unlazy
Date:   Wed, 12 Jan 2022 09:24:59 -0500
Message-Id: <20220112142459.544276-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

v2:
- Refactor to a more granular helper to avoid confusion with
  complete_walk().
- Update the commit log description with some reasoning on functionality
  of the helper and side effects of clearing the mnt pointer.
v1: https://lore.kernel.org/linux-fsdevel/20220105180259.115760-1-bfoster@redhat.com/

Hi all,

This v2 incorporates some tweaks based on Al's feedback. Al expressed
some concern over potential confusion of the complete_walk_rcu() helper
as an alternative for complete_walk(), presumably because this _rcu()
naming convention is used as such elsewhere. While thinking about a
better name, it seemed cleaner to just reduce the scope of the helper to
minimal logic. I'm still not totally sure on the name, but that can be
changed (or we could always just open code it).

Ian,

I dropped your R-b tag from v1 since the logic did change a bit, so
another look is appreciated. Thanks.

Brian

 fs/namei.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1f9d2187c765..a72e144a0a37 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -856,6 +856,18 @@ static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
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
@@ -872,15 +884,8 @@ static int complete_walk(struct nameidata *nd)
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
 
@@ -3326,7 +3331,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	} else {
 		/* create side of things */
 		if (nd->flags & LOOKUP_RCU) {
-			if (!try_to_unlazy(nd))
+			if (!nd_reset_root_and_unlazy(nd))
 				return ERR_PTR(-ECHILD);
 		}
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-- 
2.31.1

