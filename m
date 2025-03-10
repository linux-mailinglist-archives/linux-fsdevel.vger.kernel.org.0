Return-Path: <linux-fsdevel+bounces-43581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC26A58FFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 10:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2F17A1E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5B9227BA7;
	Mon, 10 Mar 2025 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOQqyqF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF40227563
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Mar 2025 09:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599764; cv=none; b=IfudIcS/7d9bN68SKo004ZLvn6E/axmMjXGAQleGixod2rD45NHwAmU8TAc5BQKqJHQ52UBpKTbPnqEtQC/VHjyR3888WtlXPQCn2/TN8hM1hKX+4yKrQilJ4zC3FERPP7R4moke9lzsvF6oW6B58ewFGtibqsl5jbuP2mnJi5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599764; c=relaxed/simple;
	bh=zDjfWjbFdEQYv+MZY4KF1MUOtn2hxJSXYeXayEikkUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZnKfuSbwttv2U7YFzwtjXbL4hgZ9JNwnjHS2YkIXzA+E48k5E+0yImJNfyFDgZx3Wr8FqrofLMwiUXjeXTs4M8DlQTAK4VYXePM/D0c7pKRuQM7modrNQJpos85Pyw4xUB8FLBSLTMasQ54Z1Ht5rk4RQz8LsFK6G946RZs524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOQqyqF2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741599762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ykl9ssSJxhfI2t++Zcd6/6YCjhY2pZQu3LkERuE7eRE=;
	b=VOQqyqF2NJAeQiooxW4ybXN/nNW79Lfxrq9gzgGmU1JAqNQM8fbLc2V361WK2CauqhSimB
	JMpVJHCBArNdjZOJEq1D7kDxR/aPgkTjIMFVnflsKcIo+aiBkLd8DSdAJ+Yu+gCUllsnWc
	HuCTbtuUTiLCAb4uoZINuPWX2xvpazg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-VUmd8nfCMpqAZDYpzKfSdg-1; Mon,
 10 Mar 2025 05:42:37 -0400
X-MC-Unique: VUmd8nfCMpqAZDYpzKfSdg-1
X-Mimecast-MFC-AGG-ID: VUmd8nfCMpqAZDYpzKfSdg_1741599756
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C097719560B4;
	Mon, 10 Mar 2025 09:42:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 45B6A19560AB;
	Mon, 10 Mar 2025 09:42:35 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Marc Dionne <marc.dionne@auristor.com>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/11] afs: Make afs_lookup_cell() take a trace note
Date: Mon, 10 Mar 2025 09:41:59 +0000
Message-ID: <20250310094206.801057-7-dhowells@redhat.com>
In-Reply-To: <20250310094206.801057-1-dhowells@redhat.com>
References: <20250310094206.801057-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Pass a note to be added to the afs_cell tracepoint to afs_lookup_cell() so
that different callers can be distinguished.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20250224234154.2014840-11-dhowells@redhat.com/ # v1
---
 fs/afs/cell.c              | 13 ++++++++-----
 fs/afs/dynroot.c           |  3 ++-
 fs/afs/internal.h          |  6 ++++--
 fs/afs/mntpt.c             |  3 ++-
 fs/afs/proc.c              |  3 ++-
 fs/afs/super.c             |  3 ++-
 fs/afs/vl_alias.c          |  3 ++-
 include/trace/events/afs.h |  7 ++++++-
 8 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index c2e44cd2eb96..73894180f653 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -233,6 +233,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  * @namesz:	The strlen of the cell name.
  * @vllist:	A colon/comma separated list of numeric IP addresses or NULL.
  * @excl:	T if an error should be given if the cell name already exists.
+ * @trace:	The reason to be logged if the lookup is successful.
  *
  * Look up a cell record by name and query the DNS for VL server addresses if
  * needed.  Note that that actual DNS query is punted off to the manager thread
@@ -241,7 +242,8 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
  */
 struct afs_cell *afs_lookup_cell(struct afs_net *net,
 				 const char *name, unsigned int namesz,
-				 const char *vllist, bool excl)
+				 const char *vllist, bool excl,
+				 enum afs_cell_trace trace)
 {
 	struct afs_cell *cell, *candidate, *cursor;
 	struct rb_node *parent, **pp;
@@ -251,7 +253,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	_enter("%s,%s", name, vllist);
 
 	if (!excl) {
-		cell = afs_find_cell(net, name, namesz, afs_cell_trace_use_lookup);
+		cell = afs_find_cell(net, name, namesz, trace);
 		if (!IS_ERR(cell))
 			goto wait_for_cell;
 	}
@@ -327,7 +329,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	if (excl) {
 		ret = -EEXIST;
 	} else {
-		afs_use_cell(cursor, afs_cell_trace_use_lookup);
+		afs_use_cell(cursor, trace);
 		ret = 0;
 	}
 	up_write(&net->cells_lock);
@@ -382,8 +384,9 @@ int afs_cell_init(struct afs_net *net, const char *rootcell)
 	if (cp && cp < rootcell + len)
 		return -EINVAL;
 
-	/* allocate a cell record for the root cell */
-	new_root = afs_lookup_cell(net, rootcell, len, vllist, false);
+	/* allocate a cell record for the root/workstation cell */
+	new_root = afs_lookup_cell(net, rootcell, len, vllist, false,
+				   afs_cell_trace_use_lookup_ws);
 	if (IS_ERR(new_root)) {
 		_leave(" = %ld", PTR_ERR(new_root));
 		return PTR_ERR(new_root);
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index eb20e231d7ac..4ff2a396dbd4 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -108,7 +108,8 @@ static struct dentry *afs_dynroot_lookup_cell(struct inode *dir, struct dentry *
 		dotted = true;
 	}
 
-	cell = afs_lookup_cell(net, name, len, NULL, false);
+	cell = afs_lookup_cell(net, name, len, NULL, false,
+			       afs_cell_trace_use_lookup_dynroot);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
 		goto out_no_cell;
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 97045e2a455d..24b87ae11524 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1046,8 +1046,10 @@ static inline bool afs_cb_is_broken(unsigned int cb_break,
 extern int afs_cell_init(struct afs_net *, const char *);
 extern struct afs_cell *afs_find_cell(struct afs_net *, const char *, unsigned,
 				      enum afs_cell_trace);
-extern struct afs_cell *afs_lookup_cell(struct afs_net *, const char *, unsigned,
-					const char *, bool);
+struct afs_cell *afs_lookup_cell(struct afs_net *net,
+				 const char *name, unsigned int namesz,
+				 const char *vllist, bool excl,
+				 enum afs_cell_trace trace);
 extern struct afs_cell *afs_use_cell(struct afs_cell *, enum afs_cell_trace);
 extern void afs_unuse_cell(struct afs_net *, struct afs_cell *, enum afs_cell_trace);
 extern struct afs_cell *afs_get_cell(struct afs_cell *, enum afs_cell_trace);
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index 507c25a5b2cb..4a3edb9990b0 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -107,7 +107,8 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		if (size > AFS_MAXCELLNAME)
 			return -ENAMETOOLONG;
 
-		cell = afs_lookup_cell(ctx->net, p, size, NULL, false);
+		cell = afs_lookup_cell(ctx->net, p, size, NULL, false,
+				       afs_cell_trace_use_lookup_mntpt);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%pd'\n", mntpt);
 			return PTR_ERR(cell);
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 12c88d8be3fe..fc7027fc3084 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -122,7 +122,8 @@ static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
 	if (strcmp(buf, "add") == 0) {
 		struct afs_cell *cell;
 
-		cell = afs_lookup_cell(net, name, strlen(name), args, true);
+		cell = afs_lookup_cell(net, name, strlen(name), args, true,
+				       afs_cell_trace_use_lookup_add);
 		if (IS_ERR(cell)) {
 			ret = PTR_ERR(cell);
 			goto done;
diff --git a/fs/afs/super.c b/fs/afs/super.c
index dfc109f48ad5..aa6a3ccf39b5 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -290,7 +290,8 @@ static int afs_parse_source(struct fs_context *fc, struct fs_parameter *param)
 	/* lookup the cell record */
 	if (cellname) {
 		cell = afs_lookup_cell(ctx->net, cellname, cellnamesz,
-				       NULL, false);
+				       NULL, false,
+				       afs_cell_trace_use_lookup_mount);
 		if (IS_ERR(cell)) {
 			pr_err("kAFS: unable to lookup cell '%*.*s'\n",
 			       cellnamesz, cellnamesz, cellname ?: "");
diff --git a/fs/afs/vl_alias.c b/fs/afs/vl_alias.c
index f9e76b604f31..ffcfba1725e6 100644
--- a/fs/afs/vl_alias.c
+++ b/fs/afs/vl_alias.c
@@ -269,7 +269,8 @@ static int yfs_check_canonical_cell_name(struct afs_cell *cell, struct key *key)
 	if (!name_len || name_len > AFS_MAXCELLNAME)
 		master = ERR_PTR(-EOPNOTSUPP);
 	else
-		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false);
+		master = afs_lookup_cell(cell->net, cell_name, name_len, NULL, false,
+					 afs_cell_trace_use_lookup_canonical);
 	kfree(cell_name);
 	if (IS_ERR(master))
 		return PTR_ERR(master);
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 24d99fbc298f..42c3a51db72b 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -208,7 +208,12 @@ enum yfs_cm_operation {
 	EM(afs_cell_trace_use_check_alias,	"USE chk-al") \
 	EM(afs_cell_trace_use_fc,		"USE fc    ") \
 	EM(afs_cell_trace_use_fc_alias,		"USE fc-al ") \
-	EM(afs_cell_trace_use_lookup,		"USE lookup") \
+	EM(afs_cell_trace_use_lookup_add,	"USE lu-add") \
+	EM(afs_cell_trace_use_lookup_canonical,	"USE lu-can") \
+	EM(afs_cell_trace_use_lookup_dynroot,	"USE lu-dyn") \
+	EM(afs_cell_trace_use_lookup_mntpt,	"USE lu-mpt") \
+	EM(afs_cell_trace_use_lookup_mount,	"USE lu-mnt") \
+	EM(afs_cell_trace_use_lookup_ws,	"USE lu-ws ") \
 	EM(afs_cell_trace_use_mntpt,		"USE mntpt ") \
 	EM(afs_cell_trace_use_pin,		"USE pin   ") \
 	EM(afs_cell_trace_use_probe,		"USE probe ") \


