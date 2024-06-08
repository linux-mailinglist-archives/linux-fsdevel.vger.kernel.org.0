Return-Path: <linux-fsdevel+bounces-21286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74990123B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9741D282581
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDDE178387;
	Sat,  8 Jun 2024 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWkbB6if"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359856446;
	Sat,  8 Jun 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717859644; cv=none; b=Db5zOmvqrxp0F8Y9XJKVuQXAImL7BP2UOTuUOyhKvnj9UvIdjh1XOsW2hn/5dE5oh/S6nMlJDy5heqr+gAVA+hlSVsNAyuHuO0pyP13cugYQOXF8BqK1tWvTDaSllpg72CzF75BONEa6zBeIBN/UbvrsXZl6ry6Fcom1ixzFsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717859644; c=relaxed/simple;
	bh=TYLhq/7OLYs7NxdH1ND7YwFqNnesbbtR5DaoXUkCwPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sbuGBYQT9cjGNXPqsixpzZdHTeNyudlkY0DceGwswsvtojK/ix5YOa2tPbdcL8++H+cqreRrDKQm7r0sQ4+8cN1q6pbpihRPQNFdTAjKGqTVAXVJ1/fu/n2FT2qJO4Cmqh5pk0FnqRHkE3L1gIeGWKiFnoY1B3DzPbuBqpr+WOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWkbB6if; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA6A9C2BD11;
	Sat,  8 Jun 2024 15:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717859643;
	bh=TYLhq/7OLYs7NxdH1ND7YwFqNnesbbtR5DaoXUkCwPk=;
	h=From:To:Cc:Subject:Date:From;
	b=pWkbB6ifd4vMHk0hLUkWgNlnjxKdbKIeV/pd/6hphLaaRokJAZ43pffvjPeG7RNHM
	 Bn+TcK0mooLuyckpGeUFNHkv/88cjunNkoQ5DjPe7kGBVDBqsrUf0o79DVn9zpV95K
	 MMV8gEQRJyZZZtTPaxo1Bw1LtEBDGRaU9YbGlGQlGd4yufFvKuDyb9LLMiM/W9YN6e
	 3j/SWl7CR9OnSCXFNeW7t+8+rdm0k05Yvicxoo02caUj8bzreHhhKO7Ag+YHWh6yOP
	 7GdfM94G+f4CFABskVSCkF1jcyIZ2djnb1OoC3uyjYDGvtF1H4WLozgBjiotgRafw+
	 NRiTuRavAWw+Q==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] netfs: Switch debug logging to pr_debug()
Date: Sat,  8 Jun 2024 17:13:51 +0200
Message-ID: <20240608151352.22860-2-ukleinek@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=29772; i=ukleinek@kernel.org; h=from:subject; bh=TYLhq/7OLYs7NxdH1ND7YwFqNnesbbtR5DaoXUkCwPk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmZHUxWCBxBNfEYLcWGIqZathDMQhrlvYoO4OAQ W8p7+e+LdWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZmR1MQAKCRCPgPtYfRL+ Thw+B/9ECcdFXQthRzg0xElUpNrGlFBc2Ixg+fRz9c0ePgmv+PFOJ16C3/BLzf5WAaFvQbl4dz8 tMTx/qBP48LLrJY/HFOBe2qG5tJsAJt2wWKhoRhGlOQW2S9nFJVrNGp3V1lj1uEdMYTM9RSrAnJ BlKG07z+gKxF908QnPvwvAFiew4YZMOrNEKf9bO13/Lqhyw2X33wyrQxiyvrWU8qFbU+Y605R8n ZCGUSjakzQeUBypEL3ihoYg+DsbcY+5hvTHoNvRiPP28ktgtU35i4Cqhvdudm9iL2X7zC6VYZj8 WwbsfDPGoUmjoF+Od0dx66I6rhJgNBPd503IyEFj1sQN13jV
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Instead of inventing a custom way to conditionally enable debugging,
just make use of pr_debug(), which also has dynamic debugging facilities
and is more likely known to someone who hunts a problem in the netfs
code. Also drop the module parameter netfs_debug which didn't have any
effect without further source changes. (The variable netfs_debug was
only used in #ifdef blocks for cpp vars that don't exist; Note that
CONFIG_NETFS_DEBUG isn't settable via kconfig, a variable with that name
never existed in the mainline and is probably just taken over (and
renamed) from similar custom debug logging implementations.)

Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 fs/netfs/buffered_read.c  | 14 +++++++-------
 fs/netfs/buffered_write.c | 12 ++++++------
 fs/netfs/direct_read.c    |  2 +-
 fs/netfs/direct_write.c   |  8 ++++----
 fs/netfs/fscache_cache.c  |  4 ++--
 fs/netfs/fscache_cookie.c | 28 ++++++++++++++--------------
 fs/netfs/fscache_io.c     | 12 ++++++------
 fs/netfs/fscache_main.c   |  2 +-
 fs/netfs/fscache_volume.c |  4 ++--
 fs/netfs/internal.h       | 33 +--------------------------------
 fs/netfs/io.c             | 12 ++++++------
 fs/netfs/main.c           |  4 ----
 fs/netfs/misc.c           |  4 ++--
 fs/netfs/write_collect.c  | 16 ++++++++--------
 fs/netfs/write_issue.c    | 36 ++++++++++++++++++------------------
 15 files changed, 78 insertions(+), 113 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index a6bb03bea920..4c0401dbbfcf 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -117,7 +117,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq)
 		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
 			if (folio->index == rreq->no_unlock_folio &&
 			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				_debug("no unlock");
+				kdebug("no unlock");
 			else
 				folio_unlock(folio);
 		}
@@ -204,7 +204,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	struct netfs_inode *ctx = netfs_inode(ractl->mapping->host);
 	int ret;
 
-	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
+	kenter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
 
 	if (readahead_count(ractl) == 0)
 		return;
@@ -268,7 +268,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	struct folio *sink = NULL;
 	int ret;
 
-	_enter("%lx", folio->index);
+	kenter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
 				   folio_file_pos(folio), folio_size(folio),
@@ -508,7 +508,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 
 have_folio:
 	*_folio = folio;
-	_leave(" = 0");
+	kleave(" = 0");
 	return 0;
 
 error_put:
@@ -518,7 +518,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	_leave(" = %d", ret);
+	kleave(" = %d", ret);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_write_begin);
@@ -536,7 +536,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 	size_t flen = folio_size(folio);
 	int ret;
 
-	_enter("%zx @%llx", flen, start);
+	kenter("%zx @%llx", flen, start);
 
 	ret = -ENOMEM;
 
@@ -567,7 +567,7 @@ int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 error_put:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
 error:
-	_leave(" = %d", ret);
+	kleave(" = %d", ret);
 	return ret;
 }
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1121601536d1..42b48a2b99cd 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -56,7 +56,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 	struct netfs_group *group = netfs_folio_group(folio);
 	loff_t pos = folio_file_pos(folio);
 
-	_enter("");
+	kenter("");
 
 	if (group != netfs_group && group != NETFS_FOLIO_COPY_TO_CACHE)
 		return NETFS_FLUSH_CONTENT;
@@ -272,12 +272,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		howto = netfs_how_to_modify(ctx, file, folio, netfs_group,
 					    flen, offset, part, maybe_trouble);
-		_debug("howto %u", howto);
+		kdebug("howto %u", howto);
 		switch (howto) {
 		case NETFS_JUST_PREFETCH:
 			ret = netfs_prefetch_for_write(file, folio, offset, part);
 			if (ret < 0) {
-				_debug("prefetch = %zd", ret);
+				kdebug("prefetch = %zd", ret);
 				goto error_folio_unlock;
 			}
 			break;
@@ -418,7 +418,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	iocb->ki_pos += written;
-	_leave(" = %zd [%zd]", written, ret);
+	kleave(" = %zd [%zd]", written, ret);
 	return written ? written : ret;
 
 error_folio_unlock:
@@ -491,7 +491,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct netfs_inode *ictx = netfs_inode(inode);
 	ssize_t ret;
 
-	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+	kenter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
 
 	if (!iov_iter_count(from))
 		return 0;
@@ -528,7 +528,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	vm_fault_t ret = VM_FAULT_RETRY;
 	int err;
 
-	_enter("%lx", folio->index);
+	kenter("%lx", folio->index);
 
 	sb_start_pagefault(inode->i_sb);
 
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index 10a1e4da6bda..b6debac6205f 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -33,7 +33,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *iocb, struct iov_iter *i
 	size_t orig_count = iov_iter_count(iter);
 	bool async = !is_sync_kiocb(iocb);
 
-	_enter("");
+	kenter("");
 
 	if (!orig_count)
 		return 0; /* Don't update atime */
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index f516460e994e..cce072abfd18 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -37,7 +37,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	size_t len = iov_iter_count(iter);
 	bool async = !is_sync_kiocb(iocb);
 
-	_enter("");
+	kenter("");
 
 	/* We're going to need a bounce buffer if what we transmit is going to
 	 * be different in some way to the source buffer, e.g. because it gets
@@ -45,7 +45,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	 */
 	// TODO
 
-	_debug("uw %llx-%llx", start, end);
+	kdebug("uw %llx-%llx", start, end);
 
 	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp, start,
 				      iocb->ki_flags & IOCB_DIRECT ?
@@ -95,7 +95,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 	wreq->cleanup = netfs_cleanup_dio_write;
 	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_iter_count(&wreq->io_iter));
 	if (ret < 0) {
-		_debug("begin = %zd", ret);
+		kdebug("begin = %zd", ret);
 		goto out;
 	}
 
@@ -142,7 +142,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t pos = iocb->ki_pos;
 	unsigned long long end = pos + iov_iter_count(from) - 1;
 
-	_enter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
+	kenter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
 
 	if (!iov_iter_count(from))
 		return 0;
diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..288a73c3072d 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -237,7 +237,7 @@ int fscache_add_cache(struct fscache_cache *cache,
 {
 	int n_accesses;
 
-	_enter("{%s,%s}", ops->name, cache->name);
+	kenter("{%s,%s}", ops->name, cache->name);
 
 	BUG_ON(fscache_cache_state(cache) != FSCACHE_CACHE_IS_PREPARING);
 
@@ -257,7 +257,7 @@ int fscache_add_cache(struct fscache_cache *cache,
 
 	up_write(&fscache_addremove_sem);
 	pr_notice("Cache \"%s\" added (type %s)\n", cache->name, ops->name);
-	_leave(" = 0 [%s]", cache->name);
+	kleave(" = 0 [%s]", cache->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscache_add_cache);
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index bce2492186d0..4d1e8bf4c615 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -456,7 +456,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 {
 	struct fscache_cookie *cookie;
 
-	_enter("V=%x", volume->debug_id);
+	kenter("V=%x", volume->debug_id);
 
 	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len > 255)
 		return NULL;
@@ -484,7 +484,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 
 	trace_fscache_acquire(cookie);
 	fscache_stat(&fscache_n_acquires_ok);
-	_leave(" = c=%08x", cookie->debug_id);
+	kleave(" = c=%08x", cookie->debug_id);
 	return cookie;
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
@@ -505,7 +505,7 @@ static void fscache_perform_lookup(struct fscache_cookie *cookie)
 	enum fscache_access_trace trace = fscache_access_lookup_cookie_end_failed;
 	bool need_withdraw = false;
 
-	_enter("");
+	kenter("");
 
 	if (!cookie->volume->cache_priv) {
 		fscache_create_volume(cookie->volume, true);
@@ -519,7 +519,7 @@ static void fscache_perform_lookup(struct fscache_cookie *cookie)
 		if (cookie->state != FSCACHE_COOKIE_STATE_FAILED)
 			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
 		need_withdraw = true;
-		_leave(" [fail]");
+		kleave(" [fail]");
 		goto out;
 	}
 
@@ -572,7 +572,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 	bool queue = false;
 	int n_active;
 
-	_enter("c=%08x", cookie->debug_id);
+	kenter("c=%08x", cookie->debug_id);
 
 	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
 		 "Trying to use relinquished cookie\n"))
@@ -636,7 +636,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie, bool will_modify)
 	spin_unlock(&cookie->lock);
 	if (queue)
 		fscache_queue_cookie(cookie, fscache_cookie_get_use_work);
-	_leave("");
+	kleave("");
 }
 EXPORT_SYMBOL(__fscache_use_cookie);
 
@@ -702,7 +702,7 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 	enum fscache_cookie_state state;
 	bool wake = false;
 
-	_enter("c=%x", cookie->debug_id);
+	kenter("c=%x", cookie->debug_id);
 
 again:
 	spin_lock(&cookie->lock);
@@ -820,7 +820,7 @@ static void fscache_cookie_state_machine(struct fscache_cookie *cookie)
 	spin_unlock(&cookie->lock);
 	if (wake)
 		wake_up_cookie_state(cookie);
-	_leave("");
+	kleave("");
 }
 
 static void fscache_cookie_worker(struct work_struct *work)
@@ -867,7 +867,7 @@ static void fscache_cookie_lru_do_one(struct fscache_cookie *cookie)
 		set_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
 		spin_unlock(&cookie->lock);
 		fscache_stat(&fscache_n_cookies_lru_expired);
-		_debug("lru c=%x", cookie->debug_id);
+		kdebug("lru c=%x", cookie->debug_id);
 		__fscache_withdraw_cookie(cookie);
 	}
 
@@ -971,7 +971,7 @@ void __fscache_relinquish_cookie(struct fscache_cookie *cookie, bool retire)
 	if (retire)
 		fscache_stat(&fscache_n_relinquishes_retire);
 
-	_enter("c=%08x{%d},%d",
+	kenter("c=%08x{%d},%d",
 	       cookie->debug_id, atomic_read(&cookie->n_active), retire);
 
 	if (WARN(test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
@@ -1050,7 +1050,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 {
 	bool is_caching;
 
-	_enter("c=%x", cookie->debug_id);
+	kenter("c=%x", cookie->debug_id);
 
 	fscache_stat(&fscache_n_invalidates);
 
@@ -1072,7 +1072,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 	case FSCACHE_COOKIE_STATE_INVALIDATING: /* is_still_valid will catch it */
 	default:
 		spin_unlock(&cookie->lock);
-		_leave(" [no %u]", cookie->state);
+		kleave(" [no %u]", cookie->state);
 		return;
 
 	case FSCACHE_COOKIE_STATE_LOOKING_UP:
@@ -1081,7 +1081,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 		fallthrough;
 	case FSCACHE_COOKIE_STATE_CREATING:
 		spin_unlock(&cookie->lock);
-		_leave(" [look %x]", cookie->inval_counter);
+		kleave(" [look %x]", cookie->inval_counter);
 		return;
 
 	case FSCACHE_COOKIE_STATE_ACTIVE:
@@ -1094,7 +1094,7 @@ void __fscache_invalidate(struct fscache_cookie *cookie,
 
 		if (is_caching)
 			fscache_queue_cookie(cookie, fscache_cookie_get_inval_work);
-		_leave(" [inv]");
+		kleave(" [inv]");
 		return;
 	}
 }
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..bf4eaeec44fb 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -28,12 +28,12 @@ bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
 
 again:
 	if (!fscache_cache_is_live(cookie->volume->cache)) {
-		_leave(" [broken]");
+		kleave(" [broken]");
 		return false;
 	}
 
 	state = fscache_cookie_state(cookie);
-	_enter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
+	kenter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
 
 	switch (state) {
 	case FSCACHE_COOKIE_STATE_CREATING:
@@ -52,7 +52,7 @@ bool fscache_wait_for_operation(struct netfs_cache_resources *cres,
 	case FSCACHE_COOKIE_STATE_DROPPED:
 	case FSCACHE_COOKIE_STATE_RELINQUISHING:
 	default:
-		_leave(" [not live]");
+		kleave(" [not live]");
 		return false;
 	}
 
@@ -92,7 +92,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 	spin_lock(&cookie->lock);
 
 	state = fscache_cookie_state(cookie);
-	_enter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
+	kenter("c=%08x{%u},%x", cookie->debug_id, state, want_state);
 
 	switch (state) {
 	case FSCACHE_COOKIE_STATE_LOOKING_UP:
@@ -140,7 +140,7 @@ static int fscache_begin_operation(struct netfs_cache_resources *cres,
 	cres->cache_priv = NULL;
 	cres->ops = NULL;
 	fscache_end_cookie_access(cookie, fscache_access_io_not_live);
-	_leave(" = -ENOBUFS");
+	kleave(" = -ENOBUFS");
 	return -ENOBUFS;
 }
 
@@ -224,7 +224,7 @@ void __fscache_write_to_cache(struct fscache_cookie *cookie,
 	if (len == 0)
 		goto abandon;
 
-	_enter("%llx,%zx", start, len);
+	kenter("%llx,%zx", start, len);
 
 	wreq = kzalloc(sizeof(struct fscache_write_request), GFP_NOFS);
 	if (!wreq)
diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
index 42e98bb523e3..bf9b33d26e31 100644
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -99,7 +99,7 @@ int __init fscache_init(void)
  */
 void __exit fscache_exit(void)
 {
-	_enter("");
+	kenter("");
 
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index cdf991bdd9de..fbdc428aaea9 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -251,7 +251,7 @@ static struct fscache_volume *fscache_alloc_volume(const char *volume_key,
 	fscache_see_volume(volume, fscache_volume_new_acquire);
 	fscache_stat(&fscache_n_volumes);
 	up_write(&fscache_addremove_sem);
-	_leave(" = v=%x", volume->debug_id);
+	kleave(" = v=%x", volume->debug_id);
 	return volume;
 
 err_vol:
@@ -452,7 +452,7 @@ void fscache_withdraw_volume(struct fscache_volume *volume)
 {
 	int n_accesses;
 
-	_debug("withdraw V=%x", volume->debug_id);
+	kdebug("withdraw V=%x", volume->debug_id);
 
 	/* Allow wakeups on dec-to-0 */
 	n_accesses = atomic_dec_return(&volume->n_accesses);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 95e281a8af78..de59e39e39a7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -34,7 +34,6 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync);
 /*
  * main.c
  */
-extern unsigned int netfs_debug;
 extern struct list_head netfs_io_requests;
 extern spinlock_t netfs_proc_lock;
 extern mempool_t netfs_request_pool;
@@ -365,42 +364,12 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
  * debug tracing
  */
 #define dbgprintk(FMT, ...) \
-	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+	pr_debug("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
 
 #define kenter(FMT, ...) dbgprintk("==> %s("FMT")", __func__, ##__VA_ARGS__)
 #define kleave(FMT, ...) dbgprintk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
 #define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
 
-#ifdef __KDEBUG
-#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
-#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
-#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
-
-#elif defined(CONFIG_NETFS_DEBUG)
-#define _enter(FMT, ...)			\
-do {						\
-	if (netfs_debug)			\
-		kenter(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#define _leave(FMT, ...)			\
-do {						\
-	if (netfs_debug)			\
-		kleave(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#define _debug(FMT, ...)			\
-do {						\
-	if (netfs_debug)			\
-		kdebug(FMT, ##__VA_ARGS__);	\
-} while (0)
-
-#else
-#define _enter(FMT, ...) no_printk("==> %s("FMT")", __func__, ##__VA_ARGS__)
-#define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
-#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
-#endif
-
 /*
  * assertions
  */
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c93851b98368..c7576481c321 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -130,7 +130,7 @@ static void netfs_reset_subreq_iter(struct netfs_io_request *rreq,
 	if (count == remaining)
 		return;
 
-	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x\n",
+	kdebug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x\n",
 	       rreq->debug_id, subreq->debug_index,
 	       iov_iter_count(&subreq->io_iter), subreq->transferred,
 	       subreq->len, rreq->i_size,
@@ -326,7 +326,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
 	struct netfs_io_request *rreq = subreq->rreq;
 	int u;
 
-	_enter("R=%x[%x]{%llx,%lx},%zd",
+	kenter("R=%x[%x]{%llx,%lx},%zd",
 	       rreq->debug_id, subreq->debug_index,
 	       subreq->start, subreq->flags, transferred_or_error);
 
@@ -435,7 +435,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 	struct netfs_inode *ictx = netfs_inode(rreq->inode);
 	size_t lsize;
 
-	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
+	kenter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
 
 	if (rreq->origin != NETFS_DIO_READ) {
 		source = netfs_cache_prepare_read(subreq, rreq->i_size);
@@ -518,7 +518,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 	subreq->start		= rreq->start + rreq->submitted;
 	subreq->len		= io_iter->count;
 
-	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
+	kdebug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
 	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
 
 	/* Call out to the cache to find out what it can do with the remaining
@@ -570,7 +570,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	struct iov_iter io_iter;
 	int ret;
 
-	_enter("R=%x %llx-%llx",
+	kenter("R=%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
 
 	if (rreq->len == 0) {
@@ -593,7 +593,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter = rreq->io_iter;
 	do {
-		_debug("submit %llx + %llx >= %llx",
+		kdebug("submit %llx + %llx >= %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
 		if (rreq->origin == NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >= rreq->i_size)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 5f0f438e5d21..db824c372842 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -20,10 +20,6 @@ MODULE_LICENSE("GPL");
 
 EXPORT_TRACEPOINT_SYMBOL(netfs_sreq);
 
-unsigned netfs_debug;
-module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
-
 static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
 mempool_t netfs_request_pool;
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index bc1fc54fb724..607dd6327a60 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -107,7 +107,7 @@ bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio)
 	struct fscache_cookie *cookie = netfs_i_cookie(ictx);
 	bool need_use = false;
 
-	_enter("");
+	kenter("");
 
 	if (!filemap_dirty_folio(mapping, folio))
 		return false;
@@ -180,7 +180,7 @@ void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	struct netfs_folio *finfo;
 	size_t flen = folio_size(folio);
 
-	_enter("{%lx},%zx,%zx", folio->index, offset, length);
+	kenter("{%lx},%zx,%zx", folio->index, offset, length);
 
 	if (!folio_test_private(folio))
 		return;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 60112e4b2c5e..79058e238660 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -161,7 +161,7 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 {
 	struct list_head *next;
 
-	_enter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
+	kenter("R=%x[%x:]", wreq->debug_id, stream->stream_nr);
 
 	if (list_empty(&stream->subrequests))
 		return;
@@ -374,7 +374,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	unsigned int notes;
 	int s;
 
-	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
+	kenter("%llx-%llx", wreq->start, wreq->start + wreq->len);
 	trace_netfs_collect(wreq);
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
 
@@ -409,7 +409,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 		front = stream->front;
 		while (front) {
 			trace_netfs_collect_sreq(wreq, front);
-			//_debug("sreq [%x] %llx %zx/%zx",
+			//kdebug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->len);
 
 			/* Stall if there may be a discontinuity. */
@@ -598,7 +598,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 out:
 	netfs_put_group_many(wreq->group, wreq->nr_group_rel);
 	wreq->nr_group_rel = 0;
-	_leave(" = %x", notes);
+	kleave(" = %x", notes);
 	return;
 
 need_retry:
@@ -606,7 +606,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 	 * that any partially completed op will have had any wholly transferred
 	 * folios removed from it.
 	 */
-	_debug("retry");
+	kdebug("retry");
 	netfs_retry_writes(wreq);
 	goto out;
 }
@@ -621,7 +621,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 	size_t transferred;
 	int s;
 
-	_enter("R=%x", wreq->debug_id);
+	kenter("R=%x", wreq->debug_id);
 
 	netfs_see_request(wreq, netfs_rreq_trace_see_work);
 	if (!test_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags)) {
@@ -684,7 +684,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 	if (wreq->origin == NETFS_DIO_WRITE)
 		inode_dio_end(wreq->inode);
 
-	_debug("finished");
+	kdebug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
@@ -743,7 +743,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 	struct netfs_io_request *wreq = subreq->rreq;
 	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
 
-	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
+	kenter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_error);
 
 	switch (subreq->source) {
 	case NETFS_UPLOAD_TO_SERVER:
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index e190043bc0da..f61f30ed8546 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -99,7 +99,7 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	if (IS_ERR(wreq))
 		return wreq;
 
-	_enter("R=%x", wreq->debug_id);
+	kenter("R=%x", wreq->debug_id);
 
 	ictx = netfs_inode(wreq->inode);
 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
@@ -159,7 +159,7 @@ static void netfs_prepare_write(struct netfs_io_request *wreq,
 	subreq->max_nr_segs	= INT_MAX;
 	subreq->stream_nr	= stream->stream_nr;
 
-	_enter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
+	kenter("R=%x[%x]", wreq->debug_id, subreq->debug_index);
 
 	trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 			     refcount_read(&subreq->ref),
@@ -215,7 +215,7 @@ static void netfs_do_issue_write(struct netfs_io_stream *stream,
 {
 	struct netfs_io_request *wreq = subreq->rreq;
 
-	_enter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
+	kenter("R=%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len);
 
 	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 		return netfs_write_subrequest_terminated(subreq, subreq->error, false);
@@ -272,11 +272,11 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 	size_t part;
 
 	if (!stream->avail) {
-		_leave("no write");
+		kleave("no write");
 		return len;
 	}
 
-	_enter("R=%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
+	kenter("R=%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
 
 	if (subreq && start != subreq->start + subreq->len) {
 		netfs_issue_write(wreq, stream);
@@ -288,7 +288,7 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 	subreq = stream->construct;
 
 	part = min(subreq->max_len - subreq->len, len);
-	_debug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part, len);
+	kdebug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part, len);
 	subreq->len += part;
 	subreq->nr_segs++;
 
@@ -319,7 +319,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	bool to_eof = false, streamw = false;
 	bool debug = false;
 
-	_enter("");
+	kenter("");
 
 	/* netfs_perform_write() may shift i_size around the page or from out
 	 * of the page to beyond it, but cannot move i_size into or through the
@@ -329,7 +329,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 
 	if (fpos >= i_size) {
 		/* mmap beyond eof. */
-		_debug("beyond eof");
+		kdebug("beyond eof");
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		wreq->nr_group_rel += netfs_folio_written_back(folio);
@@ -363,7 +363,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	}
 	flen -= foff;
 
-	_debug("folio %zx %zx %zx", foff, flen, fsize);
+	kdebug("folio %zx %zx %zx", foff, flen, fsize);
 
 	/* Deal with discontinuities in the stream of dirty pages.  These can
 	 * arise from a number of sources:
@@ -487,7 +487,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		for (int s = 0; s < NR_IO_STREAMS; s++)
 			netfs_issue_write(wreq, &wreq->io_streams[s]);
 
-	_leave(" = 0");
+	kleave(" = 0");
 	return 0;
 }
 
@@ -522,7 +522,7 @@ int netfs_writepages(struct address_space *mapping,
 	netfs_stat(&netfs_n_wh_writepages);
 
 	do {
-		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
+		kdebug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
 
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
@@ -546,14 +546,14 @@ int netfs_writepages(struct address_space *mapping,
 	mutex_unlock(&ictx->wb_lock);
 
 	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-	_leave(" = %d", error);
+	kleave(" = %d", error);
 	return error;
 
 couldnt_start:
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
 	mutex_unlock(&ictx->wb_lock);
-	_leave(" = %d", error);
+	kleave(" = %d", error);
 	return error;
 }
 EXPORT_SYMBOL(netfs_writepages);
@@ -590,7 +590,7 @@ int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
-	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
+	kenter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied, to_page_end);
 
 	if (!*writethrough_cache) {
@@ -624,7 +624,7 @@ int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_contr
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	int ret;
 
-	_enter("R=%x", wreq->debug_id);
+	kenter("R=%x", wreq->debug_id);
 
 	if (writethrough_cache)
 		netfs_write_folio(wreq, wbc, writethrough_cache);
@@ -652,7 +652,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 	loff_t start = wreq->start;
 	int error = 0;
 
-	_enter("%zx", len);
+	kenter("%zx", len);
 
 	if (wreq->origin == NETFS_DIO_WRITE)
 		inode_dio_begin(wreq->inode);
@@ -660,7 +660,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 	while (len) {
 		// TODO: Prepare content encryption
 
-		_debug("unbuffered %zx", len);
+		kdebug("unbuffered %zx", len);
 		part = netfs_advance_write(wreq, upload, start, len, false);
 		start += part;
 		len -= part;
@@ -679,6 +679,6 @@ int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t
 	if (list_empty(&upload->subrequests))
 		netfs_wake_write_collector(wreq, false);
 
-	_leave(" = %d", error);
+	kleave(" = %d", error);
 	return error;
 }

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.43.0


