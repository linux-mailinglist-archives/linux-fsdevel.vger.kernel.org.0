Return-Path: <linux-fsdevel+bounces-60975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65DCB53EA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 00:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F197AA8D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 22:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36DC2ED85E;
	Thu, 11 Sep 2025 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NrQVbjPN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793E02ED855
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757629512; cv=none; b=gEc/jaS0wbWg3SnCD7L8wkRntJF/i0aIw2RrLZouIkk9djNpk1oGoNci/jypZYbgXCkQ5YQuAXRPuYE+cC6SYoVWfQiPwe4sDA8Ob9dxmQUrBWYhHJxRGBMMcViS4lsiYlKuPSd/8y/wEeHd49j5vOrWP8u6C6+nmboSxvEek20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757629512; c=relaxed/simple;
	bh=OLA6H3dOKdGtTjWb6cUYqb9i0nz6g5+/PTRkGJGAb6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmvmwAfxXgD+9Yv3FuwGsP3W0sK4e0GINArhaz/pm88FIKeUQE0ewSqxN/OFT43qYpky7TOxMhj+bWJoDQurSXIluGLIV9iLOrqSSax2ItxuQSikl9PhKKFoaNkLvoaaBvjrwDeXeYNJpE4JOfuc0KAFzu1HCYp2YBAH4NydyIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NrQVbjPN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e4aeaa57b9so1212295f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757629508; x=1758234308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HU88kHOl9gAPudh0H7aVaOnm6bfOSCFa9GmnAENnw4=;
        b=NrQVbjPNdwUAYiYO2ELcne7Nh17RAhefXmL8NTpPHYat5DYPsje+3rmY4mKr3XTCsz
         SmXmsUyA9kDHg+DyToPD1XtIFBHZsd2dNu4viU6XsMofAvU6LY/co3C0rf/lbqkO3TRL
         Fq1+ARSW24Sm3MEGGpoFgP6yHbYx/IOTbv4qI2CUkKYamblBHojqSlIBKA7d3G9PmI3T
         DKbxqxbWSnJNrPJFm1c6Q0W3SWaQrJOhwan6XhauOHWof48P9NcYLH1aTj1HO/imN/DH
         tdjcPtfO8BT4NPGX2FIPArQlCr1jBk1vlw+CUIhkf43bmmoTYsl3mSdrI92VXPSUAXKx
         UQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757629508; x=1758234308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0HU88kHOl9gAPudh0H7aVaOnm6bfOSCFa9GmnAENnw4=;
        b=sw5QzaUtv8CVL5HJHtosIHbdpV7LT6HQK3sA98cIFjW0y+fhnB5TwsEHqLTXA1vrKX
         sohSZvUFjqNUhyi47zrduIVjF0qK/yjm8Cp+uUlffZ8o2BhRPuoYxEBj5l09ZZSMvxGX
         9Zk42vCP9HVIXxqwFQeNdww8wroaR9bC5I38RbVP9LpS/fByl1RZ6vheDZdSADUUR1ee
         0YN76m4aN9wgI5Pt015mrRPCv6aTHygDip4ZEpfDUCj119L1DBH3CJAcwuRWHyP3qYG0
         NTcM+BfoS9mbvgPibodAtaCPuoZ7wosuVKKXTpdUiguz79IhzCOMXP5xnvvMQUrvOfdq
         t+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXJKbsiZANPGARjMyV4SchOCaWBCjEKbY61rKNugC/b6qM/rQmJf5TTXvjANidXanvAfgft4DhBQPme/ASM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23ppdghoZRTv1a/Ong6P8d6p78EOLn4mgcbk73GN+TAhWFzF4
	SGlDo4jIIw5ZRI7KrERXA4cSrPYliqQkUQmOrwGNO3yvEidKgXD23je2Ua1Y/12UL4Q=
X-Gm-Gg: ASbGncuGMf4WAjAPtn7ICTmQBZPagRNw55eE9rrw6Lhj3beha1lxkc61XLN8J3gLgqY
	Fizi4kFIJeRdpbK91U/xHrPzBE4wA+jNW/dLxC+tHAz46kgTE/2JltT01qItDQ2TKdAN0Hv3qSy
	r69LDWji8+SpXFj8ZIFDXOqIR92aHXj9lcBiHEo0ZIpZ5QW2B/nUf0zZ/GbVgO40czzj0lCPUk8
	TrCI+CfevETDOuhiU8B/7CThFaEIqNpOscGTfinJahVwlHTnwx32LKBbvhfm1qcd02sh0KY890x
	61rm0GRGqjAZakSIdQY9jQyJlt9AqB+/1d+MfuHf7zmMh1Lc2raZsUbEQzPe2EYOujgbYKNUZLs
	1syV80Kln8k2CgYhZWsREWS6hS2hJlwYs6Tmt3SakO3FCHwZscduWHGLgPrRQGO40eycXZK6EnV
	2+AJSpmeO634mfECn9iWQQv+cF98jyhAAKMQ==
X-Google-Smtp-Source: AGHT+IFzUWHt1FmF+C/wk/FOIlG+YUuC9WWFQbrDsh7m4yHC7FeXyz7QWRRtcdcrtgXf+5CuR6yXoQ==
X-Received: by 2002:a5d:5c84:0:b0:3e5:f1e2:6789 with SMTP id ffacd0b85a97d-3e765a22eafmr700299f8f.59.1757629507723;
        Thu, 11 Sep 2025 15:25:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f31f700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f31:f700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156b0a8sm42537815e9.3.2025.09.11.15.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 15:25:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-stable@vger.kernel.org
Subject: [PATCH] fs/netfs: fix reference leak
Date: Fri, 12 Sep 2025 00:24:59 +0200
Message-ID: <20250911222501.1417765-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 20d72b00ca81 ("netfs: Fix the request's work item to not
require a ref") modified netfs_alloc_request() to initialize the
reference counter to 2 instead of 1.  The rationale was that the
requet's "work" would release the second reference after completion
(via netfs_{read,write}_collection_worker()).  That works most of the
time if all goes well.

However, it leaks this additional reference if the request is released
before the I/O operation has been submitted: the error code path only
decrements the reference counter once and the work item will never be
queued because there will never be a completion.

This has caused outages of our whole server cluster today because
tasks were blocked in netfs_wait_for_outstanding_io(), leading to
deadlocks in Ceph (another bug that I will address soon in another
patch).  This was caused by a netfs_pgpriv2_begin_copy_to_cache() call
which failed in fscache_begin_write_operation().  The leaked
netfs_io_request was never completed, leaving `netfs_inode.io_count`
with a positive value forever.

All of this is super-fragile code.  Finding out which code paths will
lead to an eventual completion and which do not is hard to see:

- Some functions like netfs_create_write_req() allocate a request, but
  will never submit any I/O.

- netfs_unbuffered_read_iter_locked() calls netfs_unbuffered_read()
  and then netfs_put_request(); however, netfs_unbuffered_read() can
  also fail early before submitting the I/O request, therefore another
  netfs_put_request() call must be added there.

A rule of thumb is that functions that return a `netfs_io_request` do
not submit I/O, and all of their callers must be checked.

For my taste, the whole netfs code needs an overhaul to make reference
counting easier to understand and less fragile & obscure.  But to fix
this bug here and now and produce a patch that is adequate for a
stable backport, I tried a minimal approach that quickly frees the
request object upon early failure.

I decided against adding a second netfs_put_request() each time
because that would cause code duplication which obscures the code
further.  Instead, I added the function netfs_put_failed_request()
which frees such a failed request synchronously under the assumption
that the reference count is exactly 2 (as initially set by
netfs_alloc_request() and never touched), verified by a
WARN_ON_ONCE().  It then deinitializes the request object (without
going through the "cleanup_work" indirection) and frees the allocation
(without the "call_rcu" indirection).  This should be safe because
this is the same context that allocated/initialized the request and
nobody else has a pointer to this object.

All code paths that fail early have been changed to call
netfs_put_failed_request() instead of netfs_put_request().
Additionally, I have added a netfs_put_request() call to
netfs_unbuffered_read() as explained above because the
netfs_put_failed_request() approach does not work there.

Fixes: 20d72b00ca81 ("netfs: Fix the request's work item to not require a ref")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/buffered_read.c | 10 +++++-----
 fs/netfs/direct_read.c   |  7 ++++++-
 fs/netfs/direct_write.c  |  6 +++++-
 fs/netfs/internal.h      |  1 +
 fs/netfs/objects.c       | 32 +++++++++++++++++++++++++++++---
 fs/netfs/read_pgpriv2.c  |  2 +-
 fs/netfs/read_single.c   |  2 +-
 fs/netfs/write_issue.c   |  3 +--
 8 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 18b3dc74c70e..37ab6f28b5ad 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -369,7 +369,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	return netfs_put_request(rreq, netfs_rreq_trace_put_return);
 
 cleanup_free:
-	return netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	return netfs_put_failed_request(rreq);
 }
 EXPORT_SYMBOL(netfs_readahead);
 
@@ -472,7 +472,7 @@ static int netfs_read_gaps(struct file *file, struct folio *folio)
 	return ret < 0 ? ret : 0;
 
 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -532,7 +532,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	return ret < 0 ? ret : 0;
 
 discard:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 alloc_error:
 	folio_unlock(folio);
 	return ret;
@@ -699,7 +699,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	return 0;
 
 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 error:
 	if (folio) {
 		folio_unlock(folio);
@@ -754,7 +754,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	return ret < 0 ? ret : 0;
 
 error_put:
-	netfs_put_request(rreq, netfs_rreq_trace_put_discard);
+	netfs_put_failed_request(rreq);
 error:
 	_leave(" = %d", ret);
 	return ret;
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a05e13472baf..a498ee8d6674 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -131,6 +131,7 @@ static ssize_t netfs_unbuffered_read(struct netfs_io_request *rreq, bool sync)
 
 	if (rreq->len == 0) {
 		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
+		netfs_put_request(rreq, netfs_rreq_trace_put_discard);
 		return -EIO;
 	}
 
@@ -205,7 +206,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (user_backed_iter(iter)) {
 		ret = netfs_extract_user_iter(iter, rreq->len, &rreq->buffer.iter, 0);
 		if (ret < 0)
-			goto out;
+			goto error_put;
 		rreq->direct_bv = (struct bio_vec *)rreq->buffer.iter.bvec;
 		rreq->direct_bv_count = ret;
 		rreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
@@ -238,6 +239,10 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	if (ret > 0)
 		orig_count -= ret;
 	return ret;
+
+error_put:
+	netfs_put_failed_request(rreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_read_iter_locked);
 
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index a16660ab7f83..a9d1c3b2c084 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -57,7 +57,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 			n = netfs_extract_user_iter(iter, len, &wreq->buffer.iter, 0);
 			if (n < 0) {
 				ret = n;
-				goto out;
+				goto error_put;
 			}
 			wreq->direct_bv = (struct bio_vec *)wreq->buffer.iter.bvec;
 			wreq->direct_bv_count = n;
@@ -101,6 +101,10 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 out:
 	netfs_put_request(wreq, netfs_rreq_trace_put_return);
 	return ret;
+
+error_put:
+	netfs_put_failed_request(wreq);
+	return ret;
 }
 EXPORT_SYMBOL(netfs_unbuffered_write_iter_locked);
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index d4f16fefd965..4319611f5354 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -87,6 +87,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 void netfs_get_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
 void netfs_clear_subrequests(struct netfs_io_request *rreq);
 void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace what);
+void netfs_put_failed_request(struct netfs_io_request *rreq);
 struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_request *rreq);
 
 static inline void netfs_see_request(struct netfs_io_request *rreq,
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index e8c99738b5bb..9a3fbb73325e 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -116,10 +116,8 @@ static void netfs_free_request_rcu(struct rcu_head *rcu)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 
-static void netfs_free_request(struct work_struct *work)
+static void netfs_deinit_request(struct netfs_io_request *rreq)
 {
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, cleanup_work);
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	unsigned int i;
 
@@ -149,6 +147,14 @@ static void netfs_free_request(struct work_struct *work)
 
 	if (atomic_dec_and_test(&ictx->io_count))
 		wake_up_var(&ictx->io_count);
+}
+
+static void netfs_free_request(struct work_struct *work)
+{
+	struct netfs_io_request *rreq =
+		container_of(work, struct netfs_io_request, cleanup_work);
+
+	netfs_deinit_request(rreq);
 	call_rcu(&rreq->rcu, netfs_free_request_rcu);
 }
 
@@ -167,6 +173,26 @@ void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace
 	}
 }
 
+/*
+ * Free a request (synchronously) that was just allocated but has
+ * failed before it could be submitted.
+ */
+void netfs_put_failed_request(struct netfs_io_request *rreq)
+{
+	/* new requests have two references (see
+	 * netfs_alloc_request(), and this function is only allowed on
+	 * new request objects
+	 */
+	WARN_ON_ONCE(refcount_read(&rreq->ref) != 2);
+
+	trace_netfs_rreq_ref(rreq->debug_id, 0, netfs_rreq_trace_put_failed);
+
+	netfs_deinit_request(rreq);
+
+	mempool_free(rreq, rreq->netfs_ops->request_pool ?: &netfs_request_pool);
+	netfs_stat_d(&netfs_n_rh_rreq);
+}
+
 /*
  * Allocate and partially initialise an I/O request structure.
  */
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 8097bc069c1d..a1489aa29f78 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -118,7 +118,7 @@ static struct netfs_io_request *netfs_pgpriv2_begin_copy_to_cache(
 	return creq;
 
 cancel_put:
-	netfs_put_request(creq, netfs_rreq_trace_put_return);
+	netfs_put_failed_request(creq);
 cancel:
 	rreq->copy_to_cache = ERR_PTR(-ENOBUFS);
 	clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &rreq->flags);
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fa622a6cd56d..5c0dc4efc792 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -189,7 +189,7 @@ ssize_t netfs_read_single(struct inode *inode, struct file *file, struct iov_ite
 	return ret;
 
 cleanup_free:
-	netfs_put_request(rreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(rreq);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_read_single);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 0584cba1a043..dd8743bc8d7f 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -133,8 +133,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 
 	return wreq;
 nomem:
-	wreq->error = -ENOMEM;
-	netfs_put_request(wreq, netfs_rreq_trace_put_failed);
+	netfs_put_failed_request(wreq);
 	return ERR_PTR(-ENOMEM);
 }
 
-- 
2.47.3


