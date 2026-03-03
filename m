Return-Path: <linux-fsdevel+bounces-79226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL1jFXDrpmnjZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:08:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CE41F1141
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 15:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2832B31B3CCC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C436C3624AE;
	Tue,  3 Mar 2026 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIIw2wAB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05C358393;
	Tue,  3 Mar 2026 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545776; cv=none; b=Cyo4pYQYLUf7iUB/I6qksA6iQ+3lQUWR8P0xXu0Gw45S7pLRdNxsthUNMxgoY/WZFMo308B3O3tSV9KnY0/8gJ+QVf7IDZsawg9BP40Xaf7FRpH1+IodwIfbjh2SOfFP6cszl6Fq+8Uwcfq6OxB0VQBIdX2Yn+9ojBBET/H2kRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545776; c=relaxed/simple;
	bh=h1wcd65W5zs2eQUWT7gXxS1QFuH0m7DMN6iquDR9cEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JL3or9JykTGo5iIuhwuqkNceReL3zab0uJvGf+Yogr3NqlSMJ222yvQKy7bymm64uRXHwmpBhVW4pIcU9adnRGb+V7f2XTOY85qu88eQagSgbewL68uSg/Sh+UUWRvGCjCZWFH7OvTNTSM0HsLOeYInbt5MepA1gxHwCR99y61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIIw2wAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B835DC19422;
	Tue,  3 Mar 2026 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545775;
	bh=h1wcd65W5zs2eQUWT7gXxS1QFuH0m7DMN6iquDR9cEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JIIw2wABtVNItboNQ0RYihXT/bfcrwy+i9dXNGc0aLX2w/N8wW0KHf2O4FabvWi1R
	 zbARXVU91ISnbWbPbjqD+/rufBRtclUsxXRUjIe5k3yIvVZfpXjDbWWK3PuNwL8+W1
	 wuEG42FUzA54RFcbFutjY68wnLXyeNQLK+mus4xArwExgVaYuL0GVo6r/eDG3HPpwo
	 fYSWprGuw4gv/FUdXMmNLA5/zhu68pAwv0QmCDup0tcYP5AJl8/9dG43KfWt1yQ48l
	 ub9jht1jfFaakRv4O6XhyHsxn5k+wnnVErnA2ROwVh397mySVuJZVFGaSVf8leypd4
	 IBIUnivXy8GpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:17 +0100
Subject: [PATCH RFC DRAFT POC 06/11] fs: add file_open_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-6-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=h1wcd65W5zs2eQUWT7gXxS1QFuH0m7DMN6iquDR9cEQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3ZPmFfwWX7tcZszeYoPP/bbaTZFhl1bpFy5ZP25e
 29Ohy5M7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIyZkMf6WFp2VeLPe7522y
 L/pO8j7Hvr1FXS/PaTt8WTtFk++v6HGG/+VHb8hPrr7vIBA5qbZ+fsVX3UWCOUvLlY6IJJi9tg2
 eyQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: F1CE41F1141
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79226-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a helper to allow the few users that need it to open a file in
init's fs_struct from a kernel thread.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c          | 25 +++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 26 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..bc97d66b6348 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1342,6 +1342,31 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 }
 EXPORT_SYMBOL(filp_open);
 
+/**
+ * filp_open_init - open file resolving paths against init's root
+ *
+ * @filename:	path to open
+ * @flags:	open flags as per the open(2) second argument
+ * @mode:	mode for the new file if O_CREAT is set, else ignored
+ *
+ * Same as filp_open() but path resolution is done relative to init's
+ * root (using pid1_fs) instead of current->fs. Intended for kernel
+ * threads that need to open files by absolute path after being rooted
+ * in nullfs.
+ */
+struct file *filp_open_init(const char *filename, int flags, umode_t mode)
+{
+	struct open_flags op;
+	struct open_how how = build_open_how(flags, mode);
+	int err = build_open_flags(&how, &op);
+	if (err)
+		return ERR_PTR(err);
+	op.lookup_flags |= LOOKUP_IN_INIT;
+	CLASS(filename_kernel, name)(filename);
+	return do_file_open(AT_FDCWD, name, &op);
+}
+EXPORT_SYMBOL(filp_open_init);
+
 struct file *file_open_root(const struct path *root,
 			    const char *filename, int flags, umode_t mode)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..bc0430e72c74 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2459,6 +2459,7 @@ int do_sys_open(int dfd, const char __user *filename, int flags,
 		umode_t mode);
 extern struct file *file_open_name(struct filename *, int, umode_t);
 extern struct file *filp_open(const char *, int, umode_t);
+extern struct file *filp_open_init(const char *, int, umode_t);
 extern struct file *file_open_root(const struct path *,
 				   const char *, int, umode_t);
 static inline struct file *file_open_root_mnt(struct vfsmount *mnt,

-- 
2.47.3


