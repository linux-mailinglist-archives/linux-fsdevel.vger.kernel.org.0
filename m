Return-Path: <linux-fsdevel+bounces-62636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC19B9B477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1BDF162C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F95A328584;
	Wed, 24 Sep 2025 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPbegmgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE1F326D53;
	Wed, 24 Sep 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737238; cv=none; b=JPWkKrU9PYhBPn7MBZUJRuu5AsI+FE26jnD8NM/q67P/znlJfyGqpldyIPIFF9aEwXgSN8Cj1i2wRLUczjfk26TmnJlKrsPjOTrUpoQoJf+9wPuT05qdyvLp6lPjp4cFwHLsrA60LTxyKo4Z2sTdCyJshkhoQyNbYZH1TV6fbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737238; c=relaxed/simple;
	bh=Y4eaTSy9ISCzDuTt9W9niJAfpSqVViIhOjEgWhRxjxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHMoJW+4U5106sONaT4OCMfirYJt/tEKBtHlWLv1RyjbE3R17J9aLxBzYv5OxxWIxaysl+nyusKjDPmqvBGODQiftV4YFjED6zoE6io/NOER4Ofv8waeti9BD6CWndbwAlXZ36i0cv7Flm42cr3Y3UV2oBlVqw1qppSranqgsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPbegmgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3589C116B1;
	Wed, 24 Sep 2025 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758737237;
	bh=Y4eaTSy9ISCzDuTt9W9niJAfpSqVViIhOjEgWhRxjxM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TPbegmgQImwlNGnGxPexsTAXR4SIn7UbKyh+H/rAA5c0y15tTox3bLOIlLiLm67Ir
	 /UppABPV5+qV2JYX3m1PqJDoonMKFxTXrHcxzUXIzKiGfgwXdJwP+uJtueTH16pees
	 PrxgvuklooUGnk7gKjiJO7dbljEECom7ivhxgVZSlX31MGXAL9FMWu0xLjDqJ+MZlV
	 TJni47keD6Rpf4wisrwxs0TTledpZMv0+F4JnIGii/go7UpQL/hZUBMY7F2SRrcL3A
	 nWHR7+tid7qyUf27qGFP/I+uKytG44WnbYQ1x2I8ACZcR4fno6iyEB4izK4zZFzTy4
	 dWH3EHCe+b7CA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Sep 2025 14:06:04 -0400
Subject: [PATCH v3 18/38] filelock: add an inode_lease_ignore_mask helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-dir-deleg-v3-18-9f3af8bc5c40@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
In-Reply-To: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Paulo Alcantara <pc@manguebit.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Paulo Alcantara <pc@manguebit.org>
Cc: Rick Macklem <rick.macklem@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-doc@vger.kernel.org, netfs@lists.linux.dev, ecryptfs@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Y4eaTSy9ISCzDuTt9W9niJAfpSqVViIhOjEgWhRxjxM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo1DMOKMxveyLhycpY1zxCZlV5uk8CwCdBp14Kb
 VaqEtxXRe2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaNQzDgAKCRAADmhBGVaC
 FSEmD/9Y/JVUS0yfk/725OG2wKiha2lTpXKvmOxR29tCVXQBbNRTK2dXJsMJhS2JEgPMcemsN59
 BlTDqTKYXh6KjRTWHrlouxUG37ry8QTudGbK+rM7rk+5cW8i860BWz7wZAQF8sIewmO0iWnDMV2
 NQuSglEMjTArCt44+IQ6JWLZWH+wiWXktIY+oZi/chBMzl4pkv28H5azHMJzaDE/sVfcuYRludk
 PirkoN4p/JVUOKhTqSvq2HJwn5k3itv/lL6dwrfkFdIeezLh/8XXsQVf5zjuOc0qSnLNeOMdO6Q
 LLqKAry6NZ9l60KWWE35GZKIlQieHuSiTv3mmUptXMJN/CnBW+5XdbsgWei4IVOiPZlVjYnK1Qk
 exUal7JhpdbqaEKq1IAg+yBhIkhy1DSZs5SwHBo/4fFKj/Mq5uYfs2+ks0llAPvXtVecXNtEPep
 alFRj+OCMT92Ji8oL19nhuR3mVjlMAXORZEc2j/ffpZKTav4aXHRnz6yS1/TEJ4JZn4Tfqs5zqp
 pyDuQ9ZvY7bNT+ngS9y9mBquQ3VfG3piQNiNLSESF8AHirBjt6PnTek/uAzAv3nGT4iNtsMIkgP
 vR0sH74DFkk5Q7MlIDQyaDT36MJloNjD+JxlB933ZD0Ya20Q+6Nh6z5LKV3JIDaO5CSjGFFeaa5
 u6IXzK49aOSkqbA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new routine that returns a mask of all dir change events that are
currently ignored by any leases. nfsd will use this to determine how to
configure the fsnotify_mark mask.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c               | 32 ++++++++++++++++++++++++++++++++
 include/linux/filelock.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index d26372ea890cbcd1a47209adeca6778ec23449ab..79d8991b5ec43ac006acb73182fc53d5aff5d42d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1526,6 +1526,38 @@ any_leases_conflict(struct inode *inode, struct file_lease *breaker)
 	return false;
 }
 
+#define IGNORE_MASK	(FL_IGN_DIR_CREATE | FL_IGN_DIR_DELETE | FL_IGN_DIR_RENAME)
+
+/**
+ * inode_lease_ignore_mask - return union of all ignored inode events for this inode
+ * @inode: inode of which to get ignore mask
+ *
+ * Walk the list of leases, and return the result of all of
+ * their FL_IGN_DIR_* bits or'ed together.
+ */
+u32
+inode_lease_ignore_mask(struct inode *inode)
+{
+	struct file_lock_context *ctx;
+	struct file_lock_core *flc;
+	u32 mask = 0;
+
+	ctx = locks_inode_context(inode);
+	if (!ctx)
+		return 0;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		mask |= flc->flc_flags & IGNORE_MASK;
+		/* If we already have everything, we can stop */
+		if (mask == IGNORE_MASK)
+			break;
+	}
+	spin_unlock(&ctx->flc_lock);
+	return mask;
+}
+EXPORT_SYMBOL_GPL(inode_lease_ignore_mask);
+
 static bool
 ignore_dir_deleg_break(struct file_lease *fl, unsigned int flags)
 {
diff --git a/include/linux/filelock.h b/include/linux/filelock.h
index 0f0e56490c7ba4242c1caa79c68ab1db459609d8..b35cb5dd85ff7e5dbb7712718613f4ddcd5839a5 100644
--- a/include/linux/filelock.h
+++ b/include/linux/filelock.h
@@ -249,6 +249,7 @@ int generic_setlease(struct file *, int, struct file_lease **, void **priv);
 int kernel_setlease(struct file *, int, struct file_lease **, void **);
 int vfs_setlease(struct file *, int, struct file_lease **, void **);
 int lease_modify(struct file_lease *, int, struct list_head *);
+u32 inode_lease_ignore_mask(struct inode *inode);
 
 struct notifier_block;
 int lease_register_notifier(struct notifier_block *);

-- 
2.51.0


