Return-Path: <linux-fsdevel+bounces-62663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE3B9B922
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C89421AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D77123957D;
	Wed, 24 Sep 2025 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YpKMst4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24D1FDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740191; cv=none; b=mIVTwcT1SjJfjBFifrIK8BOJblDTCeBnpnP+atEn9aPR43wQLydoIrcJlCiGPMFFUnanNjrocDsfYz18tjHf2OsEjQlT3PnuavbrmmyaW3XIIco4R1YIfCBPJuxc/K97kmw+n5p/3TcA/g8ukmjSAjB5lQc1gK0db3k1dfDR/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740191; c=relaxed/simple;
	bh=wOcAqZl1JI68IzNngstGphMuEGO5U8h+VuAv9zHSQ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cuh3xo/bXQGSDmP+pEXasxZVnx6xr+230Lz/y9RXtizTohWd7U2AVXPJjET+z8VCDHzoSEAQ58D8dDD8veoWI/FS1hnfIC5OJJQrJ2215xpuzEkb62gfmZLZTOaAH6GfM0xj1PuFuQBm/A3mkWhZePiOtkP6y9+A8kYiwmxfqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YpKMst4k; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb78ead12so29743166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 11:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1758740187; x=1759344987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9lhfP2OZ52ysQ5LfjO7ep695Hkv0EfLGngVu/eUSBaE=;
        b=YpKMst4kIsDiXMxLiC1xigBYVp63B/RfGI70kSYUioCZnzkETbghZbkD1kjzsWyn4l
         WjqORsYtiOHI7kMQNHHzlTMr8Fw79lUNrz1RT962AblrQiws4VGLc9v7OxUvuDmyNemM
         sE/SJPoBduE+i+W2Otkdx1Bj08FL7npFBmwfAJLOL8vwpHy6yrVv/SHFp0gXyOpVOpIf
         LSVSc4B9oL6ItFBL+piq1KQ5+fASr+N5xB/46rbWSJM5i6lXAgGaoYBxdOKzG+AD0oh2
         gGsjtsHSg7UdBT3NdVMFauBxw5QApiHEu0Yv/ulN1BkfzAQ4lwQqp6C5ttABpLQP7VN+
         HNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758740187; x=1759344987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9lhfP2OZ52ysQ5LfjO7ep695Hkv0EfLGngVu/eUSBaE=;
        b=N7r/rpurYB26MErEXpXaz65ZWNlyztWW5tXqERY+s29gK3TkBs3h65aJa9TbxBV8WT
         ExcegEh2TeyutNrYOISEvUz1HjcSKKuXe1aHJ7QBpwi/hkCxWn0MKp97095Ylh8ngcLh
         bRUjy5BXp4pGTU2NA9bQvxQY9shDa+iOdPJqb4rnXbWG+JEbLDVxA/5s5Uy1G8an/74Q
         +Q0Dzs62FwZ6MtoeFiA36AxA+Ze6j4fO58W5V1nK9YLlSdcIBdUIcXiugDXzUIoQTQcu
         tInd1hrY0UmCBV5AjqLZevEmukvgdezuKo0JR5e4m61GFTZK2QQr7JDvBBrtqr9/WCTx
         YE6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXW161OEClOicecDE+PqXxegPgCJwCSTTRIeD0pRASUFMg4SjVH8p9e2m1teap3fDUv7jh6pLVIhJ1YeCXd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzskhx4dhJE1lmWL0vAczQGfrd8UNTGEt3hRznVeegFmt9E3yDF
	QBVcIb7f2mJ9NfKEDH9VWZ4ir5iE1zIaQ31oq0rhodmEaMGOIMW7P+Z4yH86kWZyO6Y=
X-Gm-Gg: ASbGnctYHe3o2Y+dvPk+AKE9LlAkNfHzcVojoTvjGQIb8bjx6IL9xV9xc/ezMS4iN24
	0I8xTw7PFh7Kz67UnxOuF0QZpARm3gefNkouo4HCZF30/OZhsbmXyjQ0DJq7y8qYpSUUM1vgK44
	ZvKYTJTZ1e7TmdcM/6AZ7+pDnNGHPcf23nIlPO39Gj45FQSXmwEZgaJbbTsAvFqlCbKfoQKyLnO
	VWK6UkdAg/9AHn38YILCiMS8VENqtXEY6K+OW4o/Z8vdfacaU3YDCGxG0YN8w+Khk5XkqX0bbjm
	MKjpL0DZQACuZz0wsh9aFV+4WLASMfVo+iDtH2Nk/R4vRk6/L+xCaraWZiQVpHT+G2wwmAC8v5Y
	okLpKCW+1AJDeMEAdN3QVnTHiAkZB9O6EwOowJOAVL/0LTea+DwenCk/+S2exGc94UaZsij3VzV
	AbS37wBy8EykZ2uBRH1faDDA==
X-Google-Smtp-Source: AGHT+IFR342wd3phGnjhQe0vWt6Gm99yDbsvhyzRLEinRfJmOZ355Wfish6N1jEsDgQcgz3cbsb8EA==
X-Received: by 2002:a17:907:6e90:b0:b04:2a50:3c1b with SMTP id a640c23a62f3a-b34bc9720fcmr91166766b.53.1758740186383;
        Wed, 24 Sep 2025 11:56:26 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f090200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f09:200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b286fa30a7bsm1058104666b.29.2025.09.24.11.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:56:26 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] fs/netfs: fix reference leak
Date: Wed, 24 Sep 2025 20:55:56 +0200
Message-ID: <20250924185558.3395930-1-max.kellermann@ionos.com>
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
(with RCU protection to protect against concurrent access by
netfs_requests_seq_start()).

All code paths that fail early have been changed to call
netfs_put_failed_request() instead of netfs_put_request().
Additionally, I have added a netfs_put_request() call to
netfs_unbuffered_read() as explained above because the
netfs_put_failed_request() approach does not work there.

Fixes: 20d72b00ca81 ("netfs: Fix the request's work item to not require a ref")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: free the request with call_rcu() because a proc reader might
  be accessing it (suggested by David Howells)
---
 fs/netfs/buffered_read.c | 10 +++++-----
 fs/netfs/direct_read.c   |  7 ++++++-
 fs/netfs/direct_write.c  |  6 +++++-
 fs/netfs/internal.h      |  1 +
 fs/netfs/objects.c       | 28 +++++++++++++++++++++++++---
 fs/netfs/read_pgpriv2.c  |  2 +-
 fs/netfs/read_single.c   |  2 +-
 fs/netfs/write_issue.c   |  3 +--
 8 files changed, 45 insertions(+), 14 deletions(-)

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
index e8c99738b5bb..39d5e13f7248 100644
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
 
@@ -167,6 +173,22 @@ void netfs_put_request(struct netfs_io_request *rreq, enum netfs_rreq_ref_trace
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
+	netfs_free_request(&rreq->cleanup_work);
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


