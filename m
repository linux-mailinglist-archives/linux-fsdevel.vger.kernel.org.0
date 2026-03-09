Return-Path: <linux-fsdevel+bounces-79743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCoXMpiGrmnKFgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:36:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201F2358B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78F70300C5B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 08:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFD52727F3;
	Mon,  9 Mar 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0tZw+A2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC0D169AD2;
	Mon,  9 Mar 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773045384; cv=none; b=gXrzJLNACKQSt/sdIbKy3YRIcjNbwG1bcNv1XzXQnsGKRDk6CLx5CMkqyztLprl9n6gAQAdFKSLXPklppACBRjnphRvcvW9tDFWRiGvh55nfs95KCNs64Z0ql+rcTreMAdB9WcP62hrbmN/DqHR9yrqtdA5ANf/VbK2suOsDGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773045384; c=relaxed/simple;
	bh=98Et67B5IeLorzkSf+DdzhUp/9E8SiMRZ4t/sh44fek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o7j7ROLHF3AUlKbgVTmwnzY4LCdgo3x4iNrn2zyA1j1cJZ0E3xhGbaJUMx6IIfyn0ekUmIpDc7mNxPA6uq2EfysfcRLC7Equ+bYBmwFzrbqIW/ky5fgUnu1Qqh/AAhrgOgRZoy+F7AOoQSVJrg1sccz1z97gBlbyx8MKdDYytZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0tZw+A2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 008B5C4CEF7;
	Mon,  9 Mar 2026 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773045384;
	bh=98Et67B5IeLorzkSf+DdzhUp/9E8SiMRZ4t/sh44fek=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F0tZw+A22wskrzRAfXU6AUPivBXW2PEOCcTNojOe1rc/aR/dbkuaHVVMBJARHc0/8
	 l7hEVCP/G0T9TzYili0skBrpifg3F+zoh9YLkR0FD1X4mlh+WXJDufGiD0EpnaXiZa
	 hV5aUFpHE9vdH5sicEDIiVIFZfPVREFqIUrails7ZjHRvI0rkDHDDHD7O2B1IsUhmu
	 uStlC+3pg5ewkLxAvhDPBUHKBm0j5XlmWLIlEzngXdmED9a25SxBbvPCeypKTVj5Ax
	 /fh1+aBbIGsFil1+WtXrUZKckOE8lvqLGXsygUK88OaqzozMFEDM4PH9YFPfgF9TAA
	 DbSO7b6QkewLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA6AEF370F;
	Mon,  9 Mar 2026 08:36:23 +0000 (UTC)
From: Cheng Ding via B4 Relay <devnull+cding.ddn.com@kernel.org>
Date: Mon, 09 Mar 2026 16:35:57 +0800
Subject: [PATCH v3] fuse: invalidate page cache after sync and async direct
 writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-xfstests-generic-451-v3-1-bb6ad2f59512@ddn.com>
X-B4-Tracking: v=1; b=H4sIAGyGrmkC/3WOwQqDMBBEf0Vy7paYGMGe+h+lh5hNNNAmJZGgi
 P/eVSjtpYc9zDLzZlaWbfI2s0u1smSLzz4GEvJUMTPqMFjwSJoJLloueQuzy5PNU4bBBooaaFQ
 NziJ3HSrNO8Uo+krW+fnA3u6kR5+nmJajpdT79wOUoPMSDKCPoOmMNiN1hqIfHvVEa6DUQA295
 g55I1ojr4jhbOKT7egifnF/9hVBiE72AlVDrqb/IrZtewMs0GitBQEAAA==
X-Change-ID: 20260306-xfstests-generic-451-fed0f9d5a095
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, 
 Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cheng Ding <cding@ddn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773045382; l=6170;
 i=cding@ddn.com; s=20260306; h=from:subject:message-id;
 bh=w/sm1B9ghtDKBX1+JbHHriYeIpWZkXGqCIgWBh7X6IY=;
 b=88TUcsvlpCd21MKLkdqq8S//oRJpWFR/D1f+CZ8I+aLbHF2ldTYeYgYzLVdKAyDOuOEY8a8ON
 Mr2kr5frjsGDNZLz4UI5jk1Vdt5wYIKtBruqZT0h4XOPQZLSRj5jlBE
X-Developer-Key: i=cding@ddn.com; a=ed25519;
 pk=dzzlP8PhiZl3jtcAzbjIIv0kgtoA95fHdILVyjaeePk=
X-Endpoint-Received: by B4 Relay for cding@ddn.com/20260306 with
 auth_id=667
X-Original-From: Cheng Ding <cding@ddn.com>
Reply-To: cding@ddn.com
X-Rspamd-Queue-Id: 3201F2358B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79743-lists,linux-fsdevel=lfdr.de,cding.ddn.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[cding@ddn.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-fsdevel@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.951];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Cheng Ding <cding@ddn.com>

Fixes xfstests generic/451, similar to how commit b359af8275a9 ("fuse:
Invalidate the page cache after FOPEN_DIRECT_IO write") fixes xfstests
generic/209.

Signed-off-by: Cheng Ding <cding@ddn.com>
---
Changes in v3:
- Address review comments: fix typo
- Address review comments: move sb_init_dio_done_wq() to fuse_direct_IO()
  Note: We could skip sb_init_dio_done_wq() when io->blocking is true, but
  I opted to keep the change simpler.
- Link to v2: https://lore.kernel.org/r/20260306-xfstests-generic-451-v2-1-93b2d540304b@ddn.com

Changes in v2:
- Address review comments: move invalidation from fuse_direct_io() to
  fuse_direct_write_iter()
- Link to v1: https://lore.kernel.org/r/20260303-async-dio-aio-cache-invalidation-v1-1-fba0fd0426c3@ddn.com
---
 fs/fuse/file.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++-----------
 fs/fuse/fuse_i.h |  1 +
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b1bb7153cb78..c43fe74cdd46 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -23,6 +23,8 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/iomap.h>
 
+int sb_init_dio_done_wq(struct super_block *sb);
+
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
 			  struct fuse_open_out *outargp)
@@ -629,6 +631,19 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
 	return io->bytes < 0 ? io->size : io->bytes;
 }
 
+static void fuse_aio_invalidate_worker(struct work_struct *work)
+{
+	struct fuse_io_priv *io = container_of(work, struct fuse_io_priv, work);
+	struct address_space *mapping = io->iocb->ki_filp->f_mapping;
+	ssize_t res = fuse_get_res_by_io(io);
+	pgoff_t start = io->offset >> PAGE_SHIFT;
+	pgoff_t end = (io->offset + res - 1) >> PAGE_SHIFT;
+
+	invalidate_inode_pages2_range(mapping, start, end);
+	io->iocb->ki_complete(io->iocb, res);
+	kref_put(&io->refcnt, fuse_io_release);
+}
+
 /*
  * In case of short read, the caller sets 'pos' to the position of
  * actual end of fuse request in IO request. Otherwise, if bytes_requested
@@ -661,10 +676,11 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 	spin_unlock(&io->lock);
 
 	if (!left && !io->blocking) {
+		struct inode *inode = file_inode(io->iocb->ki_filp);
+		struct address_space *mapping = io->iocb->ki_filp->f_mapping;
 		ssize_t res = fuse_get_res_by_io(io);
 
 		if (res >= 0) {
-			struct inode *inode = file_inode(io->iocb->ki_filp);
 			struct fuse_conn *fc = get_fuse_conn(inode);
 			struct fuse_inode *fi = get_fuse_inode(inode);
 
@@ -673,6 +689,17 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 			spin_unlock(&fi->lock);
 		}
 
+		if (io->write && res > 0 && mapping->nrpages) {
+			/*
+			 * As in generic_file_direct_write(), invalidate after the
+			 * write, to invalidate read-ahead cache that may have competed
+			 * with the write.
+			 */
+			INIT_WORK(&io->work, fuse_aio_invalidate_worker);
+			queue_work(inode->i_sb->s_dio_done_wq, &io->work);
+			return;
+		}
+
 		io->iocb->ki_complete(io->iocb, res);
 	}
 
@@ -1738,15 +1765,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (res > 0)
 		*ppos = pos;
 
-	if (res > 0 && write && fopen_direct_io) {
-		/*
-		 * As in generic_file_direct_write(), invalidate after the
-		 * write, to invalidate read-ahead cache that may have competed
-		 * with the write.
-		 */
-		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
-	}
-
 	return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);
@@ -1785,6 +1803,8 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct address_space *mapping = inode->i_mapping;
+	loff_t pos = iocb->ki_pos;
 	ssize_t res;
 	bool exclusive;
 
@@ -1801,6 +1821,16 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 					     FUSE_DIO_WRITE);
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
+		if (res > 0 && mapping->nrpages) {
+			/*
+			 * As in generic_file_direct_write(), invalidate after
+			 * write, to invalidate read-ahead cache that may have
+			 * with the write.
+			 */
+			invalidate_inode_pages2_range(mapping,
+				pos >> PAGE_SHIFT,
+				(pos + res - 1) >> PAGE_SHIFT);
+		}
 	}
 	fuse_dio_unlock(iocb, exclusive);
 
@@ -2826,6 +2856,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	size_t count = iov_iter_count(iter), shortened = 0;
 	loff_t offset = iocb->ki_pos;
 	struct fuse_io_priv *io;
+	bool async = ff->fm->fc->async_dio;
 
 	pos = offset;
 	inode = file->f_mapping->host;
@@ -2834,6 +2865,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	if ((iov_iter_rw(iter) == READ) && (offset >= i_size))
 		return 0;
 
+	if ((iov_iter_rw(iter) == WRITE) && async && !inode->i_sb->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode->i_sb);
+		if (ret < 0)
+			return ret;
+	}
+
 	io = kmalloc_obj(struct fuse_io_priv);
 	if (!io)
 		return -ENOMEM;
@@ -2849,7 +2886,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * By default, we want to optimize all I/Os with async request
 	 * submission to the client filesystem if supported.
 	 */
-	io->async = ff->fm->fc->async_dio;
+	io->async = async;
 	io->iocb = iocb;
 	io->blocking = is_sync_kiocb(iocb);
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..6e8c8cf6b2c8 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -377,6 +377,7 @@ union fuse_file_args {
 /** The request IO state (for asynchronous processing) */
 struct fuse_io_priv {
 	struct kref refcnt;
+	struct work_struct work;
 	int async;
 	spinlock_t lock;
 	unsigned reqs;

---
base-commit: 3c9332f821aa11552f19c331c5aa5299c78c7c94
change-id: 20260306-xfstests-generic-451-fed0f9d5a095

Best regards,
-- 
Cheng Ding <cding@ddn.com>



