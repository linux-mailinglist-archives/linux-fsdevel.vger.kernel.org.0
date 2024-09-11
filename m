Return-Path: <linux-fsdevel+bounces-29125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DD8975AF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 21:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C46B23B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36961BBBE4;
	Wed, 11 Sep 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LL7sM1tI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8FA1BBBD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083810; cv=none; b=KBKGd62Ft6QpBUOYM20gh7JbC7HyQDkBdmhfUNunm2vXoB3sGwf3HctymejuuEmZ+UknxKQpeiMiNpGL/a4z3y82zYbQR21WpqGNRW2MEWYTqi/qvQahnSk+GQEGdX8gLexqx2+IYsbBlmXHeH5qu9iHa8mZzJvjSFDReEE+7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083810; c=relaxed/simple;
	bh=b0DIzDjefkkxIZVUa0LCGDeo2ORRu3b4jeXiOOM3Qbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAoPTEw+CIK0qTLEN4lqullXrww5iAr7IhqKAosk/vsPPM2t9L3f+r5lkLIjP/M0XVPMOQrezzz7T8T8oT21Cnkik2539CXCer9XEAYYsL5ggBfG+Qtlb6jXVfs5m73hF7fObEfRu5VCJt50bCSWt9T8/3uVc8uaVK8UiClcWXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LL7sM1tI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726083807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U+XcdzScwVO/r6qG4M59lsPhXqd4i/rpYxME40qGAug=;
	b=LL7sM1tIHpgsgFqvgQh2mvfUIv0Ro9zhqpqiBAaOSOB14U/KrDfJ4qci4oxzFCz8QEvC5z
	amWDrt5hbP2gE9kRG9ARuM53TBU+qjr7YbsQXr9wT34Lje2N6q9PG9mCoiAhCn7CuRYi75
	IZYnNXU9hiuWv2OiwlY3uipT2eWRPes=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-HAkiu9dPMEqc1DtdfAwQzA-1; Wed,
 11 Sep 2024 15:43:24 -0400
X-MC-Unique: HAkiu9dPMEqc1DtdfAwQzA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB20C1956083;
	Wed, 11 Sep 2024 19:43:21 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.7])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 27DC81956096;
	Wed, 11 Sep 2024 19:43:17 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Neil Brown <neilb@suse.de>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Ahring Oder Aring <aahringo@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gfs2@lists.linux.dev,
	ocfs2-devel@lists.linux.dev
Subject: [PATCH v1 3/4] NLM/NFSD: Fix lock notifications for async-capable filesystems
Date: Wed, 11 Sep 2024 15:42:59 -0400
Message-ID: <865c40da44af67939e8eb560d17a26c9c50f23e0.1726083391.git.bcodding@redhat.com>
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>
References: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Instead of checking just the exportfs flag, use the new
locks_can_async_lock() helper which allows NLM and NFSD to once again
support lock notifications for all filesystems which use posix_lock_file().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svclock.c  |  5 ++---
 fs/nfsd/nfs4state.c | 19 ++++---------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 1f2149db10f2..cbb87455a66d 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -30,7 +30,6 @@
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/lockd/nlm.h>
 #include <linux/lockd/lockd.h>
-#include <linux/exportfs.h>
 
 #define NLMDBG_FACILITY		NLMDBG_SVCLOCK
 
@@ -496,7 +495,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 				(long long)lock->fl.fl_end,
 				wait);
 
-	if (!exportfs_lock_op_is_async(inode->i_sb->s_export_op)) {
+	if (!locks_can_async_lock(nlmsvc_file_file(file)->f_op)) {
 		async_block = wait;
 		wait = 0;
 	}
@@ -550,7 +549,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 	 * requests on the underlaying ->lock() implementation but
 	 * only one nlm_block to being granted by lm_grant().
 	 */
-	if (exportfs_lock_op_is_async(inode->i_sb->s_export_op) &&
+	if (locks_can_async_lock(nlmsvc_file_file(file)->f_op) &&
 	    !list_empty(&block->b_list)) {
 		spin_unlock(&nlm_blocked_lock);
 		ret = nlm_lck_blocked;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a366fb1c1b9b..a061987abee3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7953,9 +7953,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	fp = lock_stp->st_stid.sc_file;
 	switch (lock->lk_type) {
 		case NFS4_READW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
-				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_READ_LT:
 			spin_lock(&fp->fi_lock);
@@ -7966,9 +7963,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			type = F_RDLCK;
 			break;
 		case NFS4_WRITEW_LT:
-			if (nfsd4_has_session(cstate) ||
-			    exportfs_lock_op_is_async(sb->s_export_op))
-				flags |= FL_SLEEP;
 			fallthrough;
 		case NFS4_WRITE_LT:
 			spin_lock(&fp->fi_lock);
@@ -7988,15 +7982,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	/*
-	 * Most filesystems with their own ->lock operations will block
-	 * the nfsd thread waiting to acquire the lock.  That leads to
-	 * deadlocks (we don't want every nfsd thread tied up waiting
-	 * for file locks), so don't attempt blocking lock notifications
-	 * on those filesystems:
-	 */
-	if (!exportfs_lock_op_is_async(sb->s_export_op))
-		flags &= ~FL_SLEEP;
+	if (lock->lk_type & (NFS4_READW_LT | NFS4_WRITEW_LT) &&
+		nfsd4_has_session(cstate) &&
+		locks_can_async_lock(nf->nf_file->f_op))
+			flags |= FL_SLEEP;
 
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
-- 
2.44.0


