Return-Path: <linux-fsdevel+bounces-78354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ov7KuvcnmkTXgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:28:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A521967A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4651308F8DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2C39449E;
	Wed, 25 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B3n9gPOS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E421393DF4;
	Wed, 25 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018721; cv=none; b=JiaX+CzhmXaNdc7LJj3hwEXCGH0P0DAHUYlxXc8OALPE5GrTfbVoyWAWkgth+vPClUhTde30hm3IbMf2MNoFHF6HBqCfrQEeoH/pLXmX4vBWOLN4MJGhJ7JpMUD8Utz+O2owV6jEpwhXxIJC8zhW1oHGrTwFZt0u3eZLOXMpwl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018721; c=relaxed/simple;
	bh=LXipgu/gi1Nc+PULiJhx0dVsXZWHHNgh0npXMeV5JhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j860f3nuTI2qSe0papA92pxd75WWcaYMOy2V38NaCJhOplyUcKoE3Yj4FqOto0B2DbOwrBsdNvgt7xae+bkBxZiSSePWrusovch/DH5sZ60gh+1UdTuLKMOA5rtFPW6ZURmvVPxLQ7yrJvB4DQcZrTropivCrU5X+jVsVWn8mIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B3n9gPOS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=saZDrpINJVghEJy5/rEMg4b8oT1k8DDbtqGwK8JORVI=; b=B3n9gPOSWnZvre2b+n1POsGQf7
	UgvcZLGgApRdg9eLKYzC9ujYCc6OvVAEurm1NDdjjNVJk+/3OJcnOVSz2ksHYP7qpqxazkZT1KLDV
	bOLOI3R3W6f2Esdk/gC/I4ac7a1XIOvyo6ijoHGvEc3Tc6jFXlh5ubIyI1SQGn+PuIck4b6eJUrQe
	wKQIBN+6IYlichc3b4LsNhcn7CygoMtf4g/VatkfQnkutoccGWbqHIQyIp6rTJGS39qFbFDNx2Gme
	BIRjmlpklNpMJXYkkFZ69UaqarWNynZmzpGeXitkTAt9ViazegmyfoLNSjn1rk+8ZVmfoRyDv5jtq
	EFKqgtVA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvD0m-005CmE-MC; Wed, 25 Feb 2026 12:25:00 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kevin Chen <kchen@ddn.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matt Harvey <mharvey@jumptrading.com>,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v3 1/8] fuse: simplify fuse_lookup_name() interface
Date: Wed, 25 Feb 2026 11:24:32 +0000
Message-ID: <20260225112439.27276-2-luis@igalia.com>
In-Reply-To: <20260225112439.27276-1-luis@igalia.com>
References: <20260225112439.27276-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78354-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[szeredi.hu,gmail.com,ddn.com,bsbernd.com,kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: 25A521967A7
X-Rspamd-Action: no action

fuse_lookup_name() requires a struct fuse_entry_out to be passed in.
However, the only caller that really needs it is fuse_lookup().  And even
this function only cares about the dentry time.

This patch simplifies fuse_lookup_name() so that it doesn't require a struct
as a parameter, replacing it by a local variable.  Instead, there'll be an
(optional) out argument, that can be used to return the dentry time.

Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c    | 36 +++++++++++++++++++-----------------
 fs/fuse/fuse_i.h |  2 +-
 fs/fuse/inode.c  |  7 ++-----
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ef297b867060..e3000affff88 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -548,10 +548,11 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 }
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+		     u64 *time, struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
+	struct fuse_entry_out outarg;
 	struct fuse_forget_link *forget;
 	u64 attr_version, evict_ctr;
 	int err;
@@ -570,30 +571,34 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, name, &outarg);
 	err = fuse_simple_request(fm, &args);
 	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
+	if (err || !outarg.nodeid)
 		goto out_put_forget;
 
 	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
+	if (fuse_invalid_attr(&outarg.attr))
 		goto out_put_forget;
-	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+	if (outarg.nodeid == FUSE_ROOT_ID && outarg.generation != 0) {
 		pr_warn_once("root generation should be zero\n");
-		outarg->generation = 0;
+		outarg.generation = 0;
 	}
 
-	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
-			   &outarg->attr, ATTR_TIMEOUT(outarg),
+	*inode = fuse_iget(sb, outarg.nodeid, outarg.generation,
+			   &outarg.attr, ATTR_TIMEOUT(&outarg),
 			   attr_version, evict_ctr);
 	err = -ENOMEM;
 	if (!*inode) {
-		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
+		fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
 		goto out;
 	}
 	err = 0;
 
+	if (time)
+		*time = fuse_time_to_jiffies(outarg.entry_valid,
+					     outarg.entry_valid_nsec);
+
  out_put_forget:
 	kfree(forget);
  out:
@@ -603,12 +608,11 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 				  unsigned int flags)
 {
-	struct fuse_entry_out outarg;
 	struct fuse_conn *fc;
 	struct inode *inode;
 	struct dentry *newent;
+	u64 time = 0;
 	int err, epoch;
-	bool outarg_valid = true;
 	bool locked;
 
 	if (fuse_is_bad(dir))
@@ -619,12 +623,10 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+			       &time, &inode);
 	fuse_unlock_inode(dir, locked);
-	if (err == -ENOENT) {
-		outarg_valid = false;
+	if (err == -ENOENT)
 		err = 0;
-	}
 	if (err)
 		goto out_err;
 
@@ -639,8 +641,8 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 
 	entry = newent ? newent : entry;
 	entry->d_time = epoch;
-	if (outarg_valid)
-		fuse_change_entry_timeout(entry, &outarg);
+	if (time)
+		fuse_dentry_settime(entry, time);
 	else
 		fuse_invalidate_entry_cache(entry);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3184ef864cf0..6178a012f36c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1149,7 +1149,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			u64 evict_ctr);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode);
+		     u64 *time, struct inode **inode);
 
 /**
  * Send FORGET command
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 38ca362ee2ca..8231c207abea 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1089,14 +1089,12 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 
 	inode = ilookup5(sb, handle->nodeid, fuse_inode_eq, &handle->nodeid);
 	if (!inode) {
-		struct fuse_entry_out outarg;
 		const struct qstr name = QSTR_INIT(".", 1);
 
 		if (!fc->export_support)
 			goto out_err;
 
-		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
-				       &inode);
+		err = fuse_lookup_name(sb, handle->nodeid, &name, NULL, &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1190,14 +1188,13 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	struct fuse_conn *fc = get_fuse_conn(child_inode);
 	struct inode *inode;
 	struct dentry *parent;
-	struct fuse_entry_out outarg;
 	int err;
 
 	if (!fc->export_support)
 		return ERR_PTR(-ESTALE);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, &outarg, &inode);
+			       &dotdot_name, NULL, &inode);
 	if (err) {
 		if (err == -ENOENT)
 			return ERR_PTR(-ESTALE);

