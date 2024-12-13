Return-Path: <linux-fsdevel+bounces-37300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAD9F0DEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD3028254F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E81E0DD1;
	Fri, 13 Dec 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4rmuYXD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DA1EB9E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097886; cv=none; b=h//fwKFfw1/RYVNuc9fsRMETzkcApZpIkeu8rzn7SeZ/exrN5wEconhS34MGSAOOfKDo3tUAZHuP3VfuvgqoUjeQ1Rp5xQTwhRgfRZAIM967Ge8D3EDwcMJxYT69cKhU21YFLHEkMGD+lNsLA6rpoousyNuPmINU4b/wTmaLJZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097886; c=relaxed/simple;
	bh=JdOtE9prXCiIruov8qMCnPB6JaU+McaaScCdBsotj5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uylxEBVgoikDlepIqmiY4MJku+eLxObSWpypKGZQWZkFNy8VtVvtBEhpLZ7ARzl9galTMMEmYDY4vMLN828aZwpIDbTIMKBYCTK6h0u/5yAnxPj5odQGRCa8cpgYar3di3aXZbicOF3ps2FvfwkxaDabLGXbHuDeac5VYqGy/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4rmuYXD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KjPETwBK7bWpM5YaAhKCzBXjAnc9nY6CVWmIFTOZIoE=;
	b=Y4rmuYXDBnqUxUZni4c9GSLdUJhoXx/rmPw/TNd1hlVuQ7LEthJPuM0tgXeYfvlSq3Xznc
	OBq+DbYfcB7NoAFaFs4qS2DmgIzthf1NFuU1AmNBcwfQCgDeXv2Wxk0X2uQ5K96jTbqZ96
	afhea9h38jMDYEnJaHelKPL0GpFUIzk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-NT_RY7GvPRmiuXhKw1jMLw-1; Fri,
 13 Dec 2024 08:51:18 -0500
X-MC-Unique: NT_RY7GvPRmiuXhKw1jMLw-1
X-Mimecast-MFC-AGG-ID: NT_RY7GvPRmiuXhKw1jMLw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F191719560BC;
	Fri, 13 Dec 2024 13:51:14 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B296F30044C1;
	Fri, 13 Dec 2024 13:51:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lizhi Xu <lizhi.xu@windriver.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 08/10] netfs: Work around recursion by abandoning retry if nothing read
Date: Fri, 13 Dec 2024 13:50:08 +0000
Message-ID: <20241213135013.2964079-9-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

syzkaller reported recursion with a loop of three calls (netfs_rreq_assess,
netfs_retry_reads and netfs_rreq_terminated) hitting the limit of the stack
during an unbuffered or direct I/O read.

There are a number of issues:

 (1) There is no limit on the number of retries.

 (2) A subrequest is supposed to be abandoned if it does not transfer
     anything (NETFS_SREQ_NO_PROGRESS), but that isn't checked under all
     circumstances.

 (3) The actual root cause, which is this:

	if (atomic_dec_and_test(&rreq->nr_outstanding))
		netfs_rreq_terminated(rreq, ...);

     When we do a retry, we bump the rreq->nr_outstanding counter to
     prevent the final cleanup phase running before we've finished
     dispatching the retries.  The problem is if we hit 0, we have to do
     the cleanup phase - but we're in the cleanup phase and end up
     repeating the retry cycle, hence the recursion.

Work around the problem by limiting the number of retries.  This is based
on Lizhi Xu's patch[1], and makes the following changes:

 (1) Replace NETFS_SREQ_NO_PROGRESS with NETFS_SREQ_MADE_PROGRESS and make
     the filesystem set it if it managed to read or write at least one byte
     of data.  Clear this bit before issuing a subrequest.

 (2) Add a ->retry_count member to the subrequest and increment it any time
     we do a retry.

 (3) Remove the NETFS_SREQ_RETRYING flag as it is superfluous with
     ->retry_count.  If the latter is non-zero, we're doing a retry.

 (4) Abandon a subrequest if retry_count is non-zero and we made no
     progress.

 (5) Use ->retry_count in both the write-side and the read-size.

[?] Question: Should I set a hard limit on retry_count in both read and
    write?  Say it hits 50, we always abandon it.  The problem is that
    these changes only mitigate the issue.  As long as it made at least one
    byte of progress, the recursion is still an issue.  This patch
    mitigates the problem, but does not fix the underlying cause.  I have
    patches that will do that, but it's an intrusive fix that's currently
    pending for the next merge window.

The oops generated by KASAN looks something like:

   BUG: TASK stack guard page was hit at ffffc9000482ff48 (stack is ffffc90004830000..ffffc90004838000)
   Oops: stack guard page: 0000 [#1] PREEMPT SMP KASAN NOPTI
   ...
   RIP: 0010:mark_lock+0x25/0xc60 kernel/locking/lockdep.c:4686
    ...
    mark_usage kernel/locking/lockdep.c:4646 [inline]
    __lock_acquire+0x906/0x3ce0 kernel/locking/lockdep.c:5156
    lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
    local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
    ___slab_alloc+0x123/0x1880 mm/slub.c:3695
    __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
    __slab_alloc_node mm/slub.c:3961 [inline]
    slab_alloc_node mm/slub.c:4122 [inline]
    kmem_cache_alloc_noprof+0x2a7/0x2f0 mm/slub.c:4141
    radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
    idr_get_free+0x528/0xa40 lib/radix-tree.c:1506
    idr_alloc_u32+0x191/0x2f0 lib/idr.c:46
    idr_alloc+0xc1/0x130 lib/idr.c:87
    p9_tag_alloc+0x394/0x870 net/9p/client.c:321
    p9_client_prepare_req+0x19f/0x4d0 net/9p/client.c:644
    p9_client_zc_rpc.constprop.0+0x105/0x880 net/9p/client.c:793
    p9_client_read_once+0x443/0x820 net/9p/client.c:1570
    p9_client_read+0x13f/0x1b0 net/9p/client.c:1534
    v9fs_issue_read+0x115/0x310 fs/9p/vfs_addr.c:74
    netfs_retry_read_subrequests fs/netfs/read_retry.c:60 [inline]
    netfs_retry_reads+0x153a/0x1d00 fs/netfs/read_retry.c:232
    netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
    netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
    netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
    netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
    netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
    netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
    netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
    ...
    netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
    netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
    netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
    netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
    netfs_retry_reads+0x155e/0x1d00 fs/netfs/read_retry.c:235
    netfs_rreq_assess+0x5d3/0x870 fs/netfs/read_collect.c:371
    netfs_rreq_terminated+0xe5/0x110 fs/netfs/read_collect.c:407
    netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:103 [inline]
    netfs_unbuffered_read fs/netfs/direct_read.c:127 [inline]
    netfs_unbuffered_read_iter_locked+0x12f6/0x19b0 fs/netfs/direct_read.c:221
    netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:256
    v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
    do_iter_readv_writev+0x614/0x7f0 fs/read_write.c:832
    vfs_readv+0x4cf/0x890 fs/read_write.c:1025
    do_preadv fs/read_write.c:1142 [inline]
    __do_sys_preadv fs/read_write.c:1192 [inline]
    __se_sys_preadv fs/read_write.c:1187 [inline]
    __x64_sys_preadv+0x22d/0x310 fs/read_write.c:1187
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Closes: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
Signed-off-by: David Howells <dhowells@redhat.com>
Suggested-by: Lizhi Xu <lizhi.xu@windriver.com>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: v9fs@lists.linux.dev
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20241108034020.3695718-1-lizhi.xu@windriver.com/ [1]
---
 fs/9p/vfs_addr.c         |  6 +++++-
 fs/afs/write.c           |  5 ++++-
 fs/netfs/read_collect.c  | 15 +++++++++------
 fs/netfs/read_retry.c    |  6 ++++--
 fs/netfs/write_collect.c |  5 ++---
 fs/netfs/write_issue.c   |  2 ++
 fs/smb/client/cifssmb.c  | 13 +++++++++----
 fs/smb/client/smb2pdu.c  |  9 ++++++---
 include/linux/netfs.h    |  6 +++---
 9 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 819c75233235..3bc9ce6c575e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -57,6 +57,8 @@ static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 	int err, len;
 
 	len = p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	if (len > 0)
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	netfs_write_subrequest_terminated(subreq, len ?: err, false);
 }
 
@@ -80,8 +82,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 	if (pos + total >= i_size_read(rreq->inode))
 		__set_bit(NETFS_SREQ_HIT_EOF, &subreq->flags);
 
-	if (!err)
+	if (!err) {
 		subreq->transferred += total;
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+	}
 
 	netfs_read_subreq_terminated(subreq, err, false);
 }
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 34107b55f834..ccb6aa8027c5 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -122,7 +122,7 @@ static void afs_issue_write_worker(struct work_struct *work)
 	if (subreq->debug_index == 3)
 		return netfs_write_subrequest_terminated(subreq, -ENOANO, false);
 
-	if (!test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+	if (!subreq->retry_count) {
 		set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		return netfs_write_subrequest_terminated(subreq, -EAGAIN, false);
 	}
@@ -149,6 +149,9 @@ static void afs_issue_write_worker(struct work_struct *work)
 	afs_wait_for_operation(op);
 	ret = afs_put_operation(op);
 	switch (ret) {
+	case 0:
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+		break;
 	case -EACCES:
 	case -EPERM:
 	case -ENOKEY:
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 46ce3b7adf07..47ed3a5044e2 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -438,7 +438,7 @@ void netfs_read_subreq_progress(struct netfs_io_subrequest *subreq,
 	     rreq->origin == NETFS_READPAGE ||
 	     rreq->origin == NETFS_READ_FOR_WRITE)) {
 		netfs_consume_read_data(subreq, was_async);
-		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	}
 }
 EXPORT_SYMBOL(netfs_read_subreq_progress);
@@ -497,7 +497,7 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		     rreq->origin == NETFS_READPAGE ||
 		     rreq->origin == NETFS_READ_FOR_WRITE)) {
 			netfs_consume_read_data(subreq, was_async);
-			__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 		}
 		rreq->transferred += subreq->transferred;
 	}
@@ -511,10 +511,13 @@ void netfs_read_subreq_terminated(struct netfs_io_subrequest *subreq,
 		} else {
 			trace_netfs_sreq(subreq, netfs_sreq_trace_short);
 			if (subreq->transferred > subreq->consumed) {
-				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-				__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
-			} else if (!__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
+				/* If we didn't read new data, abandon retry. */
+				if (subreq->retry_count &&
+				    test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
+					__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
+					set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
+				}
+			} else if (test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)) {
 				__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 				set_bit(NETFS_RREQ_NEED_RETRY, &rreq->flags);
 			} else {
diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0350592ea804..0e72e9226fc8 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -56,6 +56,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 				break;
 			if (__test_and_clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
+				__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+				subreq->retry_count++;
 				netfs_reset_iter(subreq);
 				netfs_reissue_read(rreq, subreq);
 			}
@@ -137,7 +139,8 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			stream0->sreq_max_len = subreq->len;
 
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
+			subreq->retry_count++;
 
 			spin_lock_bh(&rreq->lock);
 			list_add_tail(&subreq->rreq_link, &rreq->subrequests);
@@ -213,7 +216,6 @@ static void netfs_retry_read_subrequests(struct netfs_io_request *rreq)
 			subreq->error = -ENOMEM;
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-		__clear_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 	}
 	spin_lock_bh(&rreq->lock);
 	list_splice_tail_init(&queue, &rreq->subrequests);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 82290c92ba7a..ca3a11ed9b54 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -179,7 +179,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 				struct iov_iter source = subreq->io_iter;
 
 				iov_iter_revert(&source, subreq->len - source.count);
-				__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 				netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 				netfs_reissue_write(stream, subreq, &source);
 			}
@@ -234,7 +233,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			/* Renegotiate max_len (wsize) */
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			subreq->retry_count++;
 			stream->prepare_write(subreq);
 
 			part = min(len, stream->sreq_max_len);
@@ -279,7 +278,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq->start		= start;
 			subreq->debug_index	= atomic_inc_return(&wreq->subreq_counter);
 			subreq->stream_nr	= to->stream_nr;
-			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
+			subreq->retry_count	= 1;
 
 			trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 					     refcount_read(&subreq->ref),
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index bf6d507578e5..ff0e82505a0b 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -244,6 +244,8 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_advance(source, size);
 	iov_iter_truncate(&subreq->io_iter, size);
 
+	subreq->retry_count++;
+	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_do_issue_write(stream, subreq);
 }
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index bd42a419458e..6cb1e81993f8 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1319,14 +1319,16 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	if (rdata->result == -ENODATA) {
-		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 		rdata->result = 0;
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 	} else {
 		size_t trans = rdata->subreq.transferred + rdata->got_bytes;
 		if (trans < rdata->subreq.len &&
 		    rdata->subreq.start + trans == ictx->remote_i_size) {
-			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		} else if (rdata->got_bytes > 0) {
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 		}
 	}
 
@@ -1670,10 +1672,13 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		if (written > wdata->subreq.len)
 			written &= 0xFFFF;
 
-		if (written < wdata->subreq.len)
+		if (written < wdata->subreq.len) {
 			result = -ENOSPC;
-		else
+		} else {
 			result = written;
+			if (written > 0)
+				__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
+		}
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 010eae9d6c47..458b53d1f9cb 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4615,6 +4615,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
 			rdata->result = 0;
 		}
+		__set_bit(NETFS_SREQ_MADE_PROGRESS, &rdata->subreq.flags);
 	}
 	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
 			      server->credits, server->in_flight,
@@ -4840,10 +4841,12 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		if (written > wdata->subreq.len)
 			written &= 0xFFFF;
 
-		if (written < wdata->subreq.len)
+		if (written < wdata->subreq.len) {
 			wdata->result = -ENOSPC;
-		else
+		} else if (written > 0) {
 			wdata->subreq.len = written;
+			__set_bit(NETFS_SREQ_MADE_PROGRESS, &wdata->subreq.flags);
+		}
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
@@ -5012,7 +5015,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	}
 #endif
 
-	if (test_bit(NETFS_SREQ_RETRYING, &wdata->subreq.flags))
+	if (wdata->subreq.retry_count > 0)
 		smb2_set_replay(server, &rqst);
 
 	cifs_dbg(FYI, "async write at %llu %u bytes iter=%zx\n",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 5eaceef41e6c..4083d77e3f39 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -185,6 +185,7 @@ struct netfs_io_subrequest {
 	short			error;		/* 0 or error that occurred */
 	unsigned short		debug_index;	/* Index in list (for debugging output) */
 	unsigned int		nr_segs;	/* Number of segs in io_iter */
+	u8			retry_count;	/* The number of retries (0 on initial pass) */
 	enum netfs_io_source	source;		/* Where to read from/write to */
 	unsigned char		stream_nr;	/* I/O stream this belongs to */
 	unsigned char		curr_folioq_slot; /* Folio currently being read */
@@ -194,14 +195,13 @@ struct netfs_io_subrequest {
 #define NETFS_SREQ_COPY_TO_CACHE	0	/* Set if should copy the data to the cache */
 #define NETFS_SREQ_CLEAR_TAIL		1	/* Set if the rest of the read should be cleared */
 #define NETFS_SREQ_SEEK_DATA_READ	3	/* Set if ->read() should SEEK_DATA first */
-#define NETFS_SREQ_NO_PROGRESS		4	/* Set if we didn't manage to read any data */
+#define NETFS_SREQ_MADE_PROGRESS	4	/* Set if we transferred at least some data */
 #define NETFS_SREQ_ONDEMAND		5	/* Set if it's from on-demand read mode */
 #define NETFS_SREQ_BOUNDARY		6	/* Set if ends on hard boundary (eg. ceph object) */
 #define NETFS_SREQ_HIT_EOF		7	/* Set if short due to EOF */
 #define NETFS_SREQ_IN_PROGRESS		8	/* Unlocked when the subrequest completes */
 #define NETFS_SREQ_NEED_RETRY		9	/* Set if the filesystem requests a retry */
-#define NETFS_SREQ_RETRYING		10	/* Set if we're retrying */
-#define NETFS_SREQ_FAILED		11	/* Set if the subreq failed unretryably */
+#define NETFS_SREQ_FAILED		10	/* Set if the subreq failed unretryably */
 };
 
 enum netfs_io_origin {


