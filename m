Return-Path: <linux-fsdevel+bounces-43582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D5AA59005
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0663A8799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849A8227EA7;
	Mon, 10 Mar 2025 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiEbenx0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E038E227B8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599767; cv=none; b=K4ZOyG9XrXDW5G2fU7YffZPhl7ZwamjJdutMduiSaXG2+FJrsB+CG29m0GgwfcNsaiddAvcioVEz8SjJT2flLMACeolf5OFmlDsrEXfX6DutEzG4bF3rZJMXpozGmnWG7mOwao+rTucsWmZSLdColvyxqMKllIu+r7yf32+jl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599767; c=relaxed/simple;
	bh=mnwr0qJt2k8Iix3QGp5xkW79KQcIIw/eqMdZgRCKhHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFiipbd7p7qyJ90R2fH0FKTs0anXJ+0rxDEVGrX90TE/+ylNOjxMhvo598VnH9ZCpm5gfYlDcO0LKbN5x62OPr1r/esFhsAz0PbC9z2fYIw2bNTzdCnlZrznvYqWtOXLxYJtBQFuGya2Ce8w1mgnLBZ4q2DuRqQVD6Q1ERTbNmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiEbenx0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mrpYWalYw7EJxA/nUrbhkuC60QhcJ0mNDk/XtiF2k4=;
	b=HiEbenx0XapvfjnLUfcquGOTeXfPwDDOleOJ7qdfLBruvESOoXRbV1sDupxPaUWKhbVodI
	RXJ/JY85YqdxUgKRcyHVgJc/jQgT4pymSRkjcPqBpUbspTimOXz5eONUixE84BkRRoVNh/
	SM6i6O1Nc6l2zE+ep34sRBMk/YjfzLY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-G7KWNf_hOZSMNOdZ4au04g-1; Mon,
 10 Mar 2025 05:42:40 -0400
X-MC-Unique: G7KWNf_hOZSMNOdZ4au04g-1
X-Mimecast-MFC-AGG-ID: G7KWNf_hOZSMNOdZ4au04g_1741599759
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6662E19560A3;
	Mon, 10 Mar 2025 09:42:39 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC55D19560AD;
	Mon, 10 Mar 2025 09:42:37 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/11] afs: Drop the net parameter from afs_unuse_cell()
Date: Mon, 10 Mar 2025 09:42:00 +0000
Message-ID: <20250310094206.801057-8-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove the redundant net parameter to afs_unuse_cell() as cell->net can be
used instead.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-12-dhowells@redhat.com/ # v1
---
 fs/afs/cell.c              | 12 ++++++------
 fs/afs/dynroot.c           |  4 ++--
 fs/afs/internal.h          |  2 +-
 fs/afs/mntpt.c             |  2 +-
 fs/afs/proc.c              |  2 +-
 fs/afs/super.c             |  9 ++++-----
 fs/afs/vl_alias.c          |  4 ++--
 include/trace/events/afs.h |  1 +
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 73894180f653..acbf35b4c9ed 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -339,7 +339,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 		goto wait_for_cell;
 	goto error_noput;
 error:
-	afs_unuse_cell(net, cell, afs_cell_trace_unuse_lookup);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_lookup_error);
 error_noput:
 	_leave(" = %d [error]", ret);
 	return ERR_PTR(ret);
@@ -402,7 +402,7 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 				       lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
 
-	afs_unuse_cell(net, old_root, afs_cell_trace_unuse_ws);
+	afs_unuse_cell(old_root, afs_cell_trace_unuse_ws);
 	_leave(" = 0");
 	return 0;
 }
@@ -520,7 +520,7 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	trace_afs_cell(cell->debug_id, r, atomic_read(&cell->active), afs_cell_trace_free);
 
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
-	afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
+	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
 	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
@@ -608,7 +608,7 @@ struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
  * Record a cell becoming less active.  When the active counter reaches 1, it
  * is scheduled for destruction, but may get reactivated.
  */
-void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_trace reason)
+void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason)
 {
 	unsigned int debug_id;
 	time64_t now, expire_delay;
@@ -632,7 +632,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
 	WARN_ON(a == 0);
 	if (a == 1)
 		/* 'cell' may now be garbage collected. */
-		afs_set_cell_timer(net, expire_delay);
+		afs_set_cell_timer(cell->net, expire_delay);
 }
 
 /*
@@ -957,7 +957,7 @@ void afs_cell_purge(struct afs_net *net)
 	ws = rcu_replace_pointer(net->ws_cell, NULL,
 				 lockdep_is_held(&net->cells_lock));
 	up_write(&net->cells_lock);
-	afs_unuse_cell(net, ws, afs_cell_trace_unuse_ws);
+	afs_unuse_cell(ws, afs_cell_trace_unuse_ws);
 
 	_debug("del timer");
 	if (del_timer_sync(&net->cells_timer))
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 4ff2a396dbd4..011c63350df1 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -125,7 +125,7 @@ static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *
 	return d_splice_alias(inode, dentry);
 
 out:
-	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_lookup_dynroot);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_lookup_dynroot);
 out_no_cell:
 	if (!inode)
 		return d_splice_alias(inode, dentry);
@@ -167,7 +167,7 @@ static void afs_dynroot_d_release(struct dentry *dentry)
 {
 	struct afs_cell *cell = dentry->d_fsdata;
 
-	afs_unuse_cell(cell->net, cell, afs_cell_trace_unuse_dynroot_mntpt);
+	afs_unuse_cell(cell, afs_cell_trace_unuse_dynroot_mntpt);
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 24b87ae11524..9c8dfde758c3 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1051,7 +1051,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *vllist, bool excl,
 				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_trace);
-extern void afs_unuse_cell(struct afs_net *, struct afs_cell *, enum afs_cell_trace);
+void afs_unuse_cell(struct afs_cell *cell, enum afs_cell_trace reason);
 extern struct afs_cell *afs_get_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_see_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_put_cell(struct afs_cell *, enum afs_cell_trace);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 4a3edb9990b0..45cee6534122 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -87,7 +87,7 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		ctx->force = true;
 	}
 	if (ctx->cell) {
-		afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_mntpt);
+		afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_mntpt);
 		ctx->cell = NULL;
 	}
 	if (test_bit(AFS_VNODE_PSEUDODIR, &vnode->flags)) {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index fc7027fc3084..9a3d8eb5da43 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -130,7 +130,7 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 		}
 
 		if (test_and_set_bit(AFS_CELL_FL_NO_GC, &cell->flags))
-			afs_unuse_cell(net, cell, afs_cell_trace_unuse_no_pin);
+			afs_unuse_cell(cell, afs_cell_trace_unuse_no_pin);
 	} else {
 		goto inval;
 	}
diff --git a/fs/afs/super.c b/fs/afs/super.c
index aa6a3ccf39b5..25b306db6992 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -297,7 +297,7 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 			       cellnamesz, cellnamesz, cellname ?: "");
 			return PTR_ERR(cell);
 		}
-		afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_parse);
+		afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_parse);
 		afs_see_cell(cell, afs_cell_trace_see_source);
 		ctx->cell = cell;
 	}
@@ -394,7 +394,7 @@ static int afs_validate_fc(struct fs_context *fc)
 				ctx->key = NULL;
 				cell = afs_use_cell(ctx->cell->alias_of,
 						    afs_cell_trace_use_fc_alias);
-				afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_fc);
+				afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_fc);
 				ctx->cell = cell;
 				goto reget_key;
 			}
@@ -520,9 +520,8 @@ static struct afs_super_info *afs_alloc_sbi(struct fs_context *fc)
 static void afs_destroy_sbi(struct afs_super_info *as)
 {
 	if (as) {
-		struct afs_net *net = afs_net(as->net_ns);
 		afs_put_volume(as->volume, afs_volume_trace_put_destroy_sbi);
-		afs_unuse_cell(net, as->cell, afs_cell_trace_unuse_sbi);
+		afs_unuse_cell(as->cell, afs_cell_trace_unuse_sbi);
 		put_net(as->net_ns);
 		kfree(as);
 	}
@@ -605,7 +604,7 @@ static void afs_free_fc(struct fs_context *fc)
 
 	afs_destroy_sbi(fc->s_fs_info);
 	afs_put_volume(ctx->volume, afs_volume_trace_put_free_fc);
-	afs_unuse_cell(ctx->net, ctx->cell, afs_cell_trace_unuse_fc);
+	afs_unuse_cell(ctx->cell, afs_cell_trace_unuse_fc);
 	key_put(ctx->key);
 	kfree(ctx);
 }
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index ffcfba1725e6..709b4cdb723e 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -205,11 +205,11 @@ static int afs_query_for_alias(struct afs_cell *cell, struct key *key)
 			goto is_alias;
 
 		if (mutex_lock_interruptible(&cell->net->proc_cells_lock) < 0) {
-			afs_unuse_cell(cell->net, p, afs_cell_trace_unuse_check_alias);
+			afs_unuse_cell(p, afs_cell_trace_unuse_check_alias);
 			return -ERESTARTSYS;
 		}
 
-		afs_unuse_cell(cell->net, p, afs_cell_trace_unuse_check_alias);
+		afs_unuse_cell(p, afs_cell_trace_unuse_check_alias);
 	}
 
 	mutex_unlock(&cell->net->proc_cells_lock);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 42c3a51db72b..82d20c28dc0d 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -197,6 +197,7 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
 	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
 	EM(afs_cell_trace_unuse_lookup_dynroot,	"UNU lu-dyn") \
+	EM(afs_cell_trace_unuse_lookup_error,	"UNU lu-err") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
 	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \


