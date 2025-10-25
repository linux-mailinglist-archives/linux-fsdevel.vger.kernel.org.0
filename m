Return-Path: <linux-fsdevel+bounces-65628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF7AC09659
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2447F34E40F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513173043B5;
	Sat, 25 Oct 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKl1YArx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61272F5A2D;
	Sat, 25 Oct 2025 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409173; cv=none; b=N9RSm4FRBbVx5wtiujo9fOSCW/DjomuyMCoMQZM5q0NibKalYFro/S4xhCrnXB52V6F+sLp+4U7kfaI+8gkYbl4rGirc0frdzGtbJBAyCeclrG7irz/FW++fgecr9oS7b4dQrPgpxMxbXzZ0/Du8AvJnjZw0oa1/YFWNSRN2LKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409173; c=relaxed/simple;
	bh=9HkRSYhRyPFwC+Ebch60U0eOkF+niXbkC6onf51bdM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHZE2rG0UUVZnLhtrbPqQyEgC8nc1kueuas8flsAdO8V72dwIhNEpaQuhrc3+o4+2RsG5UGjelm3KyaFSAjbTsynvo4bzyotpjyU7XIoZrU31znZ1tdQKmQz+HJTxwkdAQUN+Ew7qRTVgHuUgqxinRLkN05HsiXs624We8962Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKl1YArx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57969C4CEFB;
	Sat, 25 Oct 2025 16:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409173;
	bh=9HkRSYhRyPFwC+Ebch60U0eOkF+niXbkC6onf51bdM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKl1YArxQnIvCurA5cukZnrwpGSRwJ6hqDT/lT40+Okk8pS/RvkQ4Gu8CrGRVNiKr
	 qgTSo4DU1MaNj2i6/V/ANQXHAZ8x7vLXQJCVpbLAFPRbnOQRQ2oia5h6cn84DZynSI
	 uU54CXAn2JIOHxx4njL8mUwfuNhmS1Sr0cyyFIhItr1zbwF5PO7n00ClH22nD3+QJY
	 8E17Oj816ia6ivtstsKd0IUO3CK+oNDyyLwNJApUPoAGrGf13ubI3gb59jM+OGLgD0
	 pTBe4S6lhITezZdtZxjI9LBk8RqrKOsjkVv4+27Xitc4XpzPrCc5yiFqg9RQ6zOIhZ
	 Z5O0jeOYVT5Zw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	vgoyal@redhat.com,
	linux-fsdevel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.17] virtio_fs: fix the hash table using in virtio_fs_enqueue_req()
Date: Sat, 25 Oct 2025 11:57:41 -0400
Message-ID: <20251025160905.3857885-230-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 7dbe6442487743ad492d9143f1f404c1f4a05e0e ]

The original commit be2ff42c5d6e ("fuse: Use hash table to link
processing request") converted fuse_pqueue->processing to a hash table,
but virtio_fs_enqueue_req() was not updated to use it correctly.
So use fuse_pqueue->processing as a hash table, this make the code
more coherent

Co-developed-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

**Why This Is A Bugfix**
- The earlier change “fuse: Use hash table to link processing request”
  (be2ff42c5d6e) converted `fuse_pqueue->processing` from a single list
  to a hash table. You can see the hash table parameters and the data
  structure:
  - `FUSE_PQ_HASH_BITS` and `FUSE_PQ_HASH_SIZE`: fs/fuse/fuse_i.h:546
  - `struct fuse_pqueue { struct list_head *processing; }`:
    fs/fuse/fuse_i.h:556
  - Allocation as an array of `list_head` buckets: fs/fuse/inode.c:1622
- Responses are looked up by hashing the request ID and searching only
  that bucket:
  - `fuse_request_find()` iterates `&fpq->processing[hash]`:
    fs/fuse/dev.c:2131
- Before this fix, `virtio_fs_enqueue_req()` added every request to the
  list head pointer (effectively bucket 0) instead of the hashed bucket.
  That makes replies unfindable for non-zero buckets, leading to -ENOENT
  on reply processing and stuck/hung requests.

**What The Patch Changes**
- Export the hash function so virtio-fs can use it:
  - `fuse_req_hash()` now exported: fs/fuse/dev.c:321
- Ensure virtio-fs adds requests to the correct bucket:
  - Include FUSE device internals: fs/fuse/virtio_fs.c:23
  - Compute the bucket: `hash = fuse_req_hash(req->in.h.unique);`:
    fs/fuse/virtio_fs.c:1445
  - Enqueue into the correct bucket: `list_add_tail(&req->list,
    &fpq->processing[hash]);`: fs/fuse/virtio_fs.c:1447
  - Function definition location for context: fs/fuse/virtio_fs.c:1370

**Impact and Risk**
- User-visible bugfix: Without this, replies cannot be matched to
  requests (except those hashing to bucket 0), causing request
  completion failures and potential hangs in virtio-fs workloads.
- Small and contained: Two files touched; logic change is limited to
  correctly hashing and inserting into the right bucket, plus exporting
  a helper symbol.
- No architectural changes: Keeps the existing hash-table design; simply
  uses it correctly.
- Stable-friendly: Minimal risk of regression, no new features, fixes
  incorrect behavior.

**Backport Conditions**
- This should be backported to any stable series that already includes
  the conversion of `processing` to a hash table (be2ff42c5d6e). If a
  stable series predates that change (i.e., `processing` is still a
  single list), this patch is not applicable.
- The export `EXPORT_SYMBOL_GPL(fuse_req_hash)` (fs/fuse/dev.c:321) is
  required so `virtio_fs` can link against it. This is an internal, GPL-
  only symbol used by in-tree code and is appropriate for stable.

 fs/fuse/dev.c       | 1 +
 fs/fuse/virtio_fs.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dbf53c7bc8535..612d4da6d7d91 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -322,6 +322,7 @@ unsigned int fuse_req_hash(u64 unique)
 {
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
 }
+EXPORT_SYMBOL_GPL(fuse_req_hash);
 
 /*
  * A new request is available, wake fiq->waitq
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 76c8fd0bfc75d..1751cd6e3d42b 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -20,6 +20,7 @@
 #include <linux/cleanup.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 /* Used to help calculate the FUSE connection's max_pages limit for a request's
  * size. Parts of the struct fuse_req are sliced into scattergather lists in
@@ -1384,7 +1385,7 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 	unsigned int out_sgs = 0;
 	unsigned int in_sgs = 0;
 	unsigned int total_sgs;
-	unsigned int i;
+	unsigned int i, hash;
 	int ret;
 	bool notify;
 	struct fuse_pqueue *fpq;
@@ -1444,8 +1445,9 @@ static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
 
 	/* Request successfully sent. */
 	fpq = &fsvq->fud->pq;
+	hash = fuse_req_hash(req->in.h.unique);
 	spin_lock(&fpq->lock);
-	list_add_tail(&req->list, fpq->processing);
+	list_add_tail(&req->list, &fpq->processing[hash]);
 	spin_unlock(&fpq->lock);
 	set_bit(FR_SENT, &req->flags);
 	/* matches barrier in request_wait_answer() */
-- 
2.51.0


