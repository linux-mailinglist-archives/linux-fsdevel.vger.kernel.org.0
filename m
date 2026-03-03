Return-Path: <linux-fsdevel+bounces-79227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDu+JfnopmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:58:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9221F0E01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50CB33049ACE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E3364924;
	Tue,  3 Mar 2026 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF4jAPtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B981282F3C;
	Tue,  3 Mar 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545778; cv=none; b=X1ZSxtTl+KnADLd13F9XsB22mo1Yavj7hDshz831MHdT7bf/2n4ser9lzRAflFZDDXi28yxzGMiRPGEn+crlhsSNpG5p+LyJZwni8Fg56/ewKTdWklOFZ3WUDPPLEegOqNk9GsPfU0B4x89dzF2BzDgEoVEmDDjb97NeU71P1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545778; c=relaxed/simple;
	bh=Rd97hp5Sb2SQumjj0ys3LJKvu37X6SG0d3207zpR8cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItWmUBmCVM75CxjD+fEcu+sBYzTjGTDhLLTOENTCFBtcVenI+pRS5rwdOkiUFHdDFP7qb06Vx603yPqUr+yd8ubkecCLE0zjc79JY7C5wPto6+gBKJn1tWYjJn6Q3Iq0h8D04+NDV/CXaIKVjQLedkEnVeyKVz0u7ClW11KQxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF4jAPtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1942EC2BC9E;
	Tue,  3 Mar 2026 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545778;
	bh=Rd97hp5Sb2SQumjj0ys3LJKvu37X6SG0d3207zpR8cQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cF4jAPttDUp96GpnVaXGr7kvIHQ1LKriskkdYgfy3c8pMqt4nrJJ2UaiBLuGggzpT
	 oc0DtU2byev6zS0ZZumwQ+FncTxzcIhVIWpJxpfHh5aQEuheg7lLJ9BJzHE2Pg239M
	 YWV9CWdcsav1hIOlD/JlzVslDPy+vk/NVD9tXxQ85gjS7YeGxB+Ww9rVldpesUiWUG
	 VFRm6fuEuaoMmdGlSfk/uJcwNes0a11mRjwc72m6C3RUW16jepuwWmvVpexHJE3F7x
	 z1wG/PLN+nZtqU0f9qOO9hj9p+ccHgANWg9OYBsWrC6+n4n8zkAB5dJ1YIjiBfTmQM
	 puQOZf5lq6fnA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:18 +0100
Subject: [PATCH RFC DRAFT POC 07/11] block: add bdev_file_open_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-7-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=3393; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Rd97hp5Sb2SQumjj0ys3LJKvu37X6SG0d3207zpR8cQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3bvica7Sl2JXrnbhXdqnkTMk5q0eeZsg8Spd4KbQ
 rVbFnUe7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhImhLD/+JMw1f/+p5KWc9n
 Tvo+VzJ33Wb1w69Xmj6Mel+tHO9pMpWR4aONfOmsLaKNigk+yq1TtnJWGgTpl61/H9MSzyO5PTi
 YFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 8D9221F0E01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79227-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a helper to open a block device from a kthread.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c           | 60 +++++++++++++++++++++++++++++++++++++-------------
 include/linux/blkdev.h |  2 ++
 2 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ed022f8c48c7..79152c3ffa76 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1083,6 +1083,20 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 }
 EXPORT_SYMBOL(bdev_file_open_by_dev);
 
+static int validate_bdev(const struct path *path, dev_t *dev)
+{
+	struct inode *inode;
+
+	inode = d_backing_inode(path->dentry);
+	if (!S_ISBLK(inode->i_mode))
+		return -ENOTBLK;
+	if (!may_open_dev(path))
+		return -EACCES;
+
+	*dev = inode->i_rdev;
+	return 0;
+}
+
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 				    void *holder,
 				    const struct blk_holder_ops *hops)
@@ -1107,6 +1121,35 @@ struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 }
 EXPORT_SYMBOL(bdev_file_open_by_path);
 
+struct file *bdev_file_open_init(const char *path, blk_mode_t mode,
+				 void *holder,
+				 const struct blk_holder_ops *hops)
+{
+	struct path p __free(path_put) = {};
+	struct file *file;
+	dev_t dev;
+	int error;
+
+	error = kern_path(path, LOOKUP_FOLLOW | LOOKUP_IN_INIT, &p);
+	if (error)
+		return ERR_PTR(error);
+
+	error = validate_bdev(&p, &dev);
+	if (error)
+		return ERR_PTR(error);
+
+	file = bdev_file_open_by_dev(dev, mode, holder, hops);
+	if (!IS_ERR(file) && (mode & BLK_OPEN_WRITE)) {
+		if (bdev_read_only(file_bdev(file))) {
+			fput(file);
+			file = ERR_PTR(-EACCES);
+		}
+	}
+
+	return file;
+}
+EXPORT_SYMBOL(bdev_file_open_init);
+
 static inline void bd_yield_claim(struct file *bdev_file)
 {
 	struct block_device *bdev = file_bdev(bdev_file);
@@ -1211,8 +1254,7 @@ EXPORT_SYMBOL(bdev_fput);
  */
 int lookup_bdev(const char *pathname, dev_t *dev)
 {
-	struct inode *inode;
-	struct path path;
+	struct path path __free(path_put) = {};
 	int error;
 
 	if (!pathname || !*pathname)
@@ -1222,19 +1264,7 @@ int lookup_bdev(const char *pathname, dev_t *dev)
 	if (error)
 		return error;
 
-	inode = d_backing_inode(path.dentry);
-	error = -ENOTBLK;
-	if (!S_ISBLK(inode->i_mode))
-		goto out_path_put;
-	error = -EACCES;
-	if (!may_open_dev(&path))
-		goto out_path_put;
-
-	*dev = inode->i_rdev;
-	error = 0;
-out_path_put:
-	path_put(&path);
-	return error;
+	return validate_bdev(&path, dev);
 }
 EXPORT_SYMBOL(lookup_bdev);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d463b9b5a0a5..9070979b6616 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1773,6 +1773,8 @@ struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct file *bdev_file_open_by_path(const char *path, blk_mode_t mode,
 		void *holder, const struct blk_holder_ops *hops);
+struct file *bdev_file_open_init(const char *path, blk_mode_t mode,
+		void *holder, const struct blk_holder_ops *hops);
 int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops);
 void bd_abort_claiming(struct block_device *bdev, void *holder);

-- 
2.47.3


