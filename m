Return-Path: <linux-fsdevel+bounces-59189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4BAB35E1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76859463B9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2A271475;
	Tue, 26 Aug 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IcShUiI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AD8283FDF;
	Tue, 26 Aug 2025 11:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208561; cv=none; b=X/gMA8IxL5zWLhONwg9c29sb/pCJR7pFfuk4RbrbcxreY9wHroluUxKS7PyJvDLxQH7A/r7rbvLLh9z9t4nr2VUkA9YvCzuI3CJ+s23qx7OOPW1ml9T2Zgw3GjhxygXMBIiXY4K7mEYZdijAqdC0gPUx0tNopmG1mR+jO69BV9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208561; c=relaxed/simple;
	bh=O4ilg1ofWDSjuj/rNuWc7ORpM+wszMRU9S7La3OFnpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiHtvUTx6PMp1mF1VdyNErgPrSSEUsz9BH/pSO1dy33aPXTF7FBS7FO9MXlspdp4zZqShuyiq0KVLFOiASAtvfGfWnnbvfWHjFedZW+6+nFwie4cL5b86BSyL7JIMJC2qYFkj6YP+5QEqy2LlNg72FInN7MWhCVQ0xW0n9p9G/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0IcShUiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C137BC113CF;
	Tue, 26 Aug 2025 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208561;
	bh=O4ilg1ofWDSjuj/rNuWc7ORpM+wszMRU9S7La3OFnpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0IcShUiIAk3SHPTiazIopS5Q6E30InM7jNMhlYO8I96FtIvWD522ACrrIJ9IjdaAB
	 K9ZQ2Lq1TGM1b4902VAJ7/WFCc9NkGnzGdOn2h/qWXjMAVXObtxw8eghabtqnQD+fi
	 u2zTR/SG/lVGyhnq39B31ZOrRoElmoAvGn3tabws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaoli Feng <fengxiaoli0714@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 158/322] netfs: Fix unbuffered write error handling
Date: Tue, 26 Aug 2025 13:09:33 +0200
Message-ID: <20250826110919.721484270@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit a3de58b12ce074ec05b8741fa28d62ccb1070468 ]

If all the subrequests in an unbuffered write stream fail, the subrequest
collector doesn't update the stream->transferred value and it retains its
initial LONG_MAX value.  Unfortunately, if all active streams fail, then we
take the smallest value of { LONG_MAX, LONG_MAX, ... } as the value to set
in wreq->transferred - which is then returned from ->write_iter().

LONG_MAX was chosen as the initial value so that all the streams can be
quickly assessed by taking the smallest value of all stream->transferred -
but this only works if we've set any of them.

Fix this by adding a flag to indicate whether the value in
stream->transferred is valid and checking that when we integrate the
values.  stream->transferred can then be initialised to zero.

This was found by running the generic/750 xfstest against cifs with
cache=none.  It splices data to the target file.  Once (if) it has used up
all the available scratch space, the writes start failing with ENOSPC.
This causes ->write_iter() to fail.  However, it was returning
wreq->transferred, i.e. LONG_MAX, rather than an error (because it thought
the amount transferred was non-zero) and iter_file_splice_write() would
then try to clean up that amount of pipe bufferage - leading to an oops
when it overran.  The kernel log showed:

    CIFS: VFS: Send error in write = -28

followed by:

    BUG: kernel NULL pointer dereference, address: 0000000000000008

with:

    RIP: 0010:iter_file_splice_write+0x3a4/0x520
    do_splice+0x197/0x4e0

or:

    RIP: 0010:pipe_buf_release (include/linux/pipe_fs_i.h:282)
    iter_file_splice_write (fs/splice.c:755)

Also put a warning check into splice to announce if ->write_iter() returned
that it had written more than it was asked to.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Reported-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220445
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/915443.1755207950@warthog.procyon.org.uk
cc: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: netfs@lists.linux.dev
cc: linux-cifs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Dropped read_collect.c hunk ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/write_collect.c |   10 ++++++++--
 fs/netfs/write_issue.c   |    4 ++--
 fs/splice.c              |    3 +++
 include/linux/netfs.h    |    1 +
 4 files changed, 14 insertions(+), 4 deletions(-)

--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -433,6 +433,7 @@ reassess_streams:
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -538,6 +539,7 @@ void netfs_write_collection_worker(struc
 	struct netfs_io_request *wreq = container_of(work, struct netfs_io_request, work);
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -568,12 +570,16 @@ void netfs_write_collection_worker(struc
 			netfs_put_request(wreq, false, netfs_rreq_trace_put_work);
 			return;
 		}
-		if (stream->transferred < transferred)
+		if (stream->transferred_valid &&
+		    stream->transferred < transferred) {
 			transferred = stream->transferred;
+			transferred_valid = true;
+		}
 	}
 
 	/* Okay, declare that all I/O is complete. */
-	wreq->transferred = transferred;
+	if (transferred_valid)
+		wreq->transferred = transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -115,12 +115,12 @@ struct netfs_io_request *netfs_create_wr
 	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
-	wreq->io_streams[0].transferred		= LONG_MAX;
+	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
 	wreq->io_streams[1].collected_to	= start;
-	wreq->io_streams[1].transferred		= LONG_MAX;
+	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -744,6 +744,9 @@ iter_file_splice_write(struct pipe_inode
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
+		WARN_ONCE(ret > sd.total_len - left,
+			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+			  ret, sd.total_len, left);
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,7 @@ struct netfs_io_stream {
 	bool			active;		/* T if stream is active */
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
+	bool			transferred_valid; /* T is ->transferred is valid */
 };
 
 /*



