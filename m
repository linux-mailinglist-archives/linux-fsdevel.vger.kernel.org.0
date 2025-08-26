Return-Path: <linux-fsdevel+bounces-59185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3430B35B6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D696361819
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1C34A30A;
	Tue, 26 Aug 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AdFVZWzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25173346A07;
	Tue, 26 Aug 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207096; cv=none; b=baABdjtWfanX/8bkVKkIHBaOEWtBJSEtwBF330BCGZP4No0qs4jwfOqAHIesoDh3NhePSV+jxVvG+FFRe/XyFaE8Fnw9mcEKn5wOqpAeZGVcFttTxwhXuzOfdSKVQOhHf58CiD6J2H7376qpU9SET1nnAvtWi1ZZVgPWZLJgrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207096; c=relaxed/simple;
	bh=Y7AwznA5BMvQAxHYM2NsSWm1PH3p4s+aHTL24ME0qOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui3ERWmM6BKL8j4KfqXFWAW97n2KmsiyJ4Q7GwUwSRkbTWUUYv7teSidLOIDzCQi62r5oTAh95Da6GsaW0978ovCuTF6KTZFz9ZLDeJ/BEHcVTSZuygTNQjHAxIeQ38oGGJw0OoYTtVC6piXZtLTaR6IGYrDsOGg5TIgzELCHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AdFVZWzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3E3C113CF;
	Tue, 26 Aug 2025 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207096;
	bh=Y7AwznA5BMvQAxHYM2NsSWm1PH3p4s+aHTL24ME0qOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdFVZWzbB3UgBrY4i6jz0ESHryU2y3rEnpCBZxXBX9EG8iAEFK4KLm3aHPmCYTQLS
	 OKZp9MIevUY3d/bBFkHYxHCqE8mBKCwSYrtjFgIpu8TJD73lT4fzCCxNr5Y89c18Y4
	 o29Np7H/ncqb5uy7PlbkQXcCOovuw4E2AsR3iy1Q=
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
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.16 019/457] netfs: Fix unbuffered write error handling
Date: Tue, 26 Aug 2025 13:05:03 +0200
Message-ID: <20250826110937.803379923@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit a3de58b12ce074ec05b8741fa28d62ccb1070468 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_collect.c  |    4 +++-
 fs/netfs/write_collect.c |   10 ++++++++--
 fs/netfs/write_issue.c   |    4 ++--
 fs/splice.c              |    3 +++
 include/linux/netfs.h    |    1 +
 5 files changed, 17 insertions(+), 5 deletions(-)

--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -281,8 +281,10 @@ reassess:
 		} else if (test_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags)) {
 			notes |= MADE_PROGRESS;
 		} else {
-			if (!stream->failed)
+			if (!stream->failed) {
 				stream->transferred += transferred;
+				stream->transferred_valid = true;
+			}
 			if (front->transferred < front->len)
 				set_bit(NETFS_RREQ_SHORT_TRANSFER, &rreq->flags);
 			notes |= MADE_PROGRESS;
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -254,6 +254,7 @@ reassess_streams:
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -356,6 +357,7 @@ bool netfs_write_collection(struct netfs
 {
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -376,12 +378,16 @@ bool netfs_write_collection(struct netfs
 			continue;
 		if (!list_empty(&stream->subrequests))
 			return false;
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
@@ -118,12 +118,12 @@ struct netfs_io_request *netfs_create_wr
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
@@ -739,6 +739,9 @@ iter_file_splice_write(struct pipe_inode
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



