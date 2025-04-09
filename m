Return-Path: <linux-fsdevel+bounces-46103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E13AA829A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C54D17595E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2A26773C;
	Wed,  9 Apr 2025 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kho+6j4Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70A266B56;
	Wed,  9 Apr 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210861; cv=none; b=lAzIBqZlsw6iey0E1jBTJHXx6ou4ENljmVPrnthParADIOrNhixsHJ9+NbibUXjJSWYdayPVp3C6m2bDhXO2ZQlZ32kCsX1M7GYL2llZ8sUo85oVl4Qbuh/9BFzmNm5gl0JB+nmRqNpavYw3sCPhGkkBsZZPEndPWX84Y4Fsuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210861; c=relaxed/simple;
	bh=c0N6Fza0g9HjjjobGuVNSq/z9YsYE454v/mgmkIlmvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKfUSS4WXyztX4d1Uvj371TFpG3KXkIvAlwN8spagMuhjKU4V7/M7P1cBt69WGc+B/+LKQkVnoCz4tdAXFqly/KZNWSn8QHgkKAle0TSqizcqkb5hUM6SfleD96CCZ9B7brCJE17IcPmUAT4+MZ+e7ULuOeiPUY+mey7YN6Brcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kho+6j4Y; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0kPV6Tj4EuIgJXikf2OOLqOU4d8vMhpT68L7Cbr79NM=; b=kho+6j4Ye5KDTWD9hmZAleaf0h
	OyKh98TkbISHF2M4PIm/0M1ZQmDQpaS52b7sA6WDKAxEp4KkELgFnRzch1XHnVJkWfrtfR5YxMOTi
	tA5AF5r+apGbnph/p+9THcHj00M29u21eYCV7uT7h3pzaLX+EgiGAImVRLYvwkhmm+bEpGGzC/niC
	4f5LWxc+xmNPrWVOHUqyTcRMe/tB6iENkDACyqt2BJu/SfRVvFtKZI6AB+jRdt0HP/rAufnK5FMLL
	mzeLPjgE7sixMdmIEzj6We/7GWAAVjOuZ8SnZ1RT8L+/CEGawQH2L4h0VoqkvVXpNTueFh6F/BWy0
	wVswWZ3g==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u2Wv4-00EBVR-8P; Wed, 09 Apr 2025 17:00:50 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 09 Apr 2025 12:00:41 -0300
Subject: [PATCH 1/3] ovl: Make ovl_cache_entry_find support casefold
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250409-tonyk-overlayfs-v1-1-3991616fe9a3@igalia.com>
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
In-Reply-To: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Theodore Tso <tytso@mit.edu>, Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To add overlayfs support casefold filesystems, make
ovl_cache_entry_find() support casefold dentries.

For the casefold support, just comparing the strings does not work
because we need the dentry enconding, so make this function find the
equivalent dentry for a giving directory, if any.

Also, if two strings are not equal, strncmp() return value sign can be
either positive or negative and this information can be used to optimize
the walk in the rb tree. utf8_strncmp(), in the other hand, just return
true or false, so replace the rb walk with a normal rb_next() function.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/overlayfs/ovl_entry.h |  1 +
 fs/overlayfs/readdir.c   | 32 +++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index cb449ab310a7a89aafa0ee04ee7ff6c8141dd7d5..2ee52da85ba3e3fd704415a7ee4e9b7da88bb019 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -90,6 +90,7 @@ struct ovl_fs {
 	bool no_shared_whiteout;
 	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
 	errseq_t errseq;
+	bool casefold;
 };
 
 /* Number of lower layers, not including data-only layers */
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 881ec5592da52dfb27a588496582e7084b2fbd3b..68f4a83713e9beab604fd23319d60567ef1feeca 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -92,21 +92,31 @@ static bool ovl_cache_entry_find_link(const char *name, int len,
 }
 
 static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
-						    const char *name, int len)
+						    const char *name, int len,
+						    struct dentry *upper)
 {
+	struct ovl_fs *ofs = OVL_FS(upper->d_sb);
 	struct rb_node *node = root->rb_node;
-	int cmp;
+	struct qstr q = { .name = name, .len = len };
 
 	while (node) {
 		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
+		struct dentry *p_dentry, *real_dentry = NULL;
+
+		if (ofs->casefold && upper) {
+			p_dentry = ovl_lookup_upper(ofs, p->name, upper, p->len);
+			if (!IS_ERR(p_dentry)) {
+				real_dentry = ovl_dentry_real(p_dentry);
+				if (d_same_name(real_dentry, real_dentry->d_parent, &q))
+					return p;
+			}
+		}
 
-		cmp = strncmp(name, p->name, len);
-		if (cmp > 0)
-			node = p->node.rb_right;
-		else if (cmp < 0 || len < p->len)
-			node = p->node.rb_left;
-		else
-			return p;
+		if (!real_dentry)
+			if (!strncmp(name, p->name, len))
+				return p;
+
+		node = rb_next(&p->node);
 	}
 
 	return NULL;
@@ -204,7 +214,7 @@ static bool ovl_fill_lowest(struct ovl_readdir_data *rdd,
 {
 	struct ovl_cache_entry *p;
 
-	p = ovl_cache_entry_find(rdd->root, name, namelen);
+	p = ovl_cache_entry_find(rdd->root, name, namelen, rdd->dentry);
 	if (p) {
 		list_move_tail(&p->l_node, &rdd->middle);
 	} else {
@@ -678,7 +688,7 @@ static bool ovl_fill_real(struct dir_context *ctx, const char *name,
 	} else if (rdt->cache) {
 		struct ovl_cache_entry *p;
 
-		p = ovl_cache_entry_find(&rdt->cache->root, name, namelen);
+		p = ovl_cache_entry_find(&rdt->cache->root, name, namelen, NULL);
 		if (p)
 			ino = p->ino;
 	} else if (rdt->xinobits) {

-- 
2.49.0


