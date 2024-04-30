Return-Path: <linux-fsdevel+bounces-18312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E48B70FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 12:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31C91F2185A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D712CDBB;
	Tue, 30 Apr 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTgqEuHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1491D12C487;
	Tue, 30 Apr 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474310; cv=none; b=Q9aubPVc4m9Ka/q82CAwJrb86rdcpB4VGDZC5E7hWyGQKtlnRzO6YQw8Zv8rWUXH8jpKYK0hnAzkQ3YzuPUSr7DnmPc6/b3MU7Lbn/CFQhSe4aZ4lIuZRDtwvar3ABHH80dpqprl1ymlqQFq4rPWlllF1CtTNrN4PgGtWHDHqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474310; c=relaxed/simple;
	bh=EqxWaXJkaKi6EmeJ/uq2stp+6OiNQwCUC8ehr0Ve1Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAQXgjuOKCZq3Ay/N2oodpK1zKQwvHINYo8VNmcBJvEYrVDC8WYIkUTqT8sSymkVcSIV3C9cjFm7WAYpIXdNR17YfhK/teN+ZvxMjNFKhLUopXYfH61hNDvfSq+L30gzI6gybSESrX9lH5/c3WgPI4wg1n0tdoRU4W+fkzjhok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTgqEuHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5788EC4AF18;
	Tue, 30 Apr 2024 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474309;
	bh=EqxWaXJkaKi6EmeJ/uq2stp+6OiNQwCUC8ehr0Ve1Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTgqEuHgqQKdUci1Z3du65415M3GJ2TVlGxYZfvpPUKLshBl6qKVOcxYk5o3+hZEe
	 mWLr+NFj5WD7vWLX3sIjMxcZyd3TmFgb5xbQWVGrpuiABOigLaqyH3dO05hIAki7/a
	 b0/2sOxS15AAryy15gc/F9THApVMUTySCFlDObTg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 119/228] netfs: Fix the pre-flush when appending to a file in writethrough mode
Date: Tue, 30 Apr 2024 12:38:17 +0200
Message-ID: <20240430103107.242045835@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit c97f59e276d4e93480f29a70accbd0d7273cf3f5 ]

In netfs_perform_write(), when the file is marked NETFS_ICTX_WRITETHROUGH
or O_*SYNC or RWF_*SYNC was specified, write-through caching is performed
on a buffered file.  When setting up for write-through, we flush any
conflicting writes in the region and wait for the write to complete,
failing if there's a write error to return.

The issue arises if we're writing at or above the EOF position because we
skip the flush and - more importantly - the wait.  This becomes a problem
if there's a partial folio at the end of the file that is being written out
and we want to make a write to it too.  Both the already-running write and
the write we start both want to clear the writeback mark, but whoever is
second causes a warning looking something like:

    ------------[ cut here ]------------
    R=00000012: folio 11 is not under writeback
    WARNING: CPU: 34 PID: 654 at fs/netfs/write_collect.c:105
    ...
    CPU: 34 PID: 654 Comm: kworker/u386:27 Tainted: G S ...
    ...
    Workqueue: events_unbound netfs_write_collection_worker
    ...
    RIP: 0010:netfs_writeback_lookup_folio

Fix this by making the flush-and-wait unconditional.  It will do nothing if
there are no folios in the pagecache and will return quickly if there are
no folios in the region specified.

Further, move the WBC attachment above the flush call as the flush is going
to attach a WBC and detach it again if it is not present - and since we
need one anyway we might as well share it.

Fixes: 41d8e7673a77 ("netfs: Implement a write-through caching option")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404161031.468b84f-oliver.sang@intel.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/2150448.1714130115@warthog.procyon.org.uk
Reviewed-by: Jeffrey Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/buffered_write.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 8f13ca8fbc74d..267b622d923b1 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -172,15 +172,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
 		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
 	    ) {
-		if (pos < i_size_read(inode)) {
-			ret = filemap_write_and_wait_range(mapping, pos, pos + iter->count);
-			if (ret < 0) {
-				goto out;
-			}
-		}
-
 		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
 
+		ret = filemap_write_and_wait_range(mapping, pos, pos + iter->count);
+		if (ret < 0) {
+			wbc_detach_inode(&wbc);
+			goto out;
+		}
+
 		wreq = netfs_begin_writethrough(iocb, iter->count);
 		if (IS_ERR(wreq)) {
 			wbc_detach_inode(&wbc);
-- 
2.43.0




