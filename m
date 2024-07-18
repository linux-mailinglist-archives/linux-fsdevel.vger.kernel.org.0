Return-Path: <linux-fsdevel+bounces-23955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA86F935254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 22:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA9F282A75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21181144D3E;
	Thu, 18 Jul 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCJANEaF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE561448C9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333263; cv=none; b=YUfmmexQ7BvQ1+cZzP+HuCRVIRyKTUvBYDCRP9AjktpPY30OOTG9vGYx563wFMe7vYXNdYX6EDMcU1KSmQpkRtMthJndW/BkF8UfvQWMcUizNl3JdAIzt0X76ZsfZSW3sFhFOTvUVYQFIqvT+r0n4jc+DVq27/dDn8xGx63tyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333263; c=relaxed/simple;
	bh=ojKpZ8mUkmqzGa4ldtLQG3fnfnae8h/XXGtUI+ny1ec=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=KjUsT4r+/bhT+vmZGSXlLKsmNLUbotry+cV1PEAw86TPuoLSruGhXzPHWqjzLNk5yMz6xEHWKNvsTX5AzipvHSUGSW+U7/pAKdmPlrfoEh+EomXDjvWtYA4pUWpFCTGalCG5193v6AjU8DUQWLIuNrHR0NQ+i5GDKS/Oklv2Ayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCJANEaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721333260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DmlH0QgB+tvgqPO+GHHrGxLxBbwygqax+8V/ANgxhIY=;
	b=dCJANEaFjRB15GnX8n3nrWXsTTOoP3UPbczDhTz1e9lysHWQm4W1HQBzu3gSQXnTO+kTQw
	U3N7BQGE4WaL0itdPx2AUZRkIHoJKrO57XetQX1ZRkMl0k6q1Ra8NAh80OPOLu130768ER
	IXnYkAo9es2rzoMHPrpFcD7ChJWLZcU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-SY9YhU_qP5uwhg0eYlXfTg-1; Thu,
 18 Jul 2024 16:07:36 -0400
X-MC-Unique: SY9YhU_qP5uwhg0eYlXfTg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 738B51956095;
	Thu, 18 Jul 2024 20:07:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E8A01955F40;
	Thu, 18 Jul 2024 20:07:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com,
    Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] netfs: Revert "netfs: Switch debug logging to pr_debug()"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jul 2024 21:07:32 +0100
Message-ID: <1410685.1721333252@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

=20=20=20=20
Revert commit 163eae0fb0d4c610c59a8de38040f8e12f89fd43 to get back the
original operation of the debugging macros.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
cc: Christian Brauner <brauner@kernel.org>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240608151352.22860-2-ukleinek@kernel.org
---
 fs/netfs/buffered_read.c  |   14 +++++++-------
 fs/netfs/buffered_write.c |   12 ++++++------
 fs/netfs/direct_read.c    |    2 +-
 fs/netfs/direct_write.c   |    8 ++++----
 fs/netfs/fscache_cache.c  |    4 ++--
 fs/netfs/fscache_cookie.c |   28 ++++++++++++++--------------
 fs/netfs/fscache_io.c     |   12 ++++++------
 fs/netfs/fscache_main.c   |    2 +-
 fs/netfs/fscache_volume.c |    4 ++--
 fs/netfs/internal.h       |   33 ++++++++++++++++++++++++++++++++-
 fs/netfs/io.c             |   12 ++++++------
 fs/netfs/main.c           |    4 ++++
 fs/netfs/misc.c           |    4 ++--
 fs/netfs/write_collect.c  |   16 ++++++++--------
 fs/netfs/write_issue.c    |   36 ++++++++++++++++++------------------
 15 files changed, 113 insertions(+), 78 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 4c0401dbbfcf..a6bb03bea920 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -117,7 +117,7 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *=
rreq)
 		if (!test_bit(NETFS_RREQ_DONT_UNLOCK_FOLIOS, &rreq->flags)) {
 			if (folio->index =3D=3D rreq->no_unlock_folio &&
 			    test_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags))
-				kdebug("no unlock");
+				_debug("no unlock");
 			else
 				folio_unlock(folio);
 		}
@@ -204,7 +204,7 @@ void netfs_readahead(struct readahead_control *ractl)
 	struct netfs_inode *ctx =3D netfs_inode(ractl->mapping->host);
 	int ret;
=20
-	kenter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
+	_enter("%lx,%x", readahead_index(ractl), readahead_count(ractl));
=20
 	if (readahead_count(ractl) =3D=3D 0)
 		return;
@@ -268,7 +268,7 @@ int netfs_read_folio(struct file *file, struct folio *f=
olio)
 	struct folio *sink =3D NULL;
 	int ret;
=20
-	kenter("%lx", folio->index);
+	_enter("%lx", folio->index);
=20
 	rreq =3D netfs_alloc_request(mapping, file,
 				   folio_file_pos(folio), folio_size(folio),
@@ -508,7 +508,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
=20
 have_folio:
 	*_folio =3D folio;
-	kleave(" =3D 0");
+	_leave(" =3D 0");
 	return 0;
=20
 error_put:
@@ -518,7 +518,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	kleave(" =3D %d", ret);
+	_leave(" =3D %d", ret);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_write_begin);
@@ -536,7 +536,7 @@ int netfs_prefetch_for_write(struct file *file, struct =
folio *folio,
 	size_t flen =3D folio_size(folio);
 	int ret;
=20
-	kenter("%zx @%llx", flen, start);
+	_enter("%zx @%llx", flen, start);
=20
 	ret =3D -ENOMEM;
=20
@@ -567,7 +567,7 @@ int netfs_prefetch_for_write(struct file *file, struct =
folio *folio,
 error_put:
 	netfs_put_request(rreq, false, netfs_rreq_trace_put_discard);
 error:
-	kleave(" =3D %d", ret);
+	_leave(" =3D %d", ret);
 	return ret;
 }
=20
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index ecbc99ec7d36..d583af7a2209 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -56,7 +56,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struc=
t netfs_inode *ctx,
 	struct netfs_group *group =3D netfs_folio_group(folio);
 	loff_t pos =3D folio_file_pos(folio);
=20
-	kenter("");
+	_enter("");
=20
 	if (group !=3D netfs_group && group !=3D NETFS_FOLIO_COPY_TO_CACHE)
 		return NETFS_FLUSH_CONTENT;
@@ -272,12 +272,12 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struc=
t iov_iter *iter,
 		 */
 		howto =3D netfs_how_to_modify(ctx, file, folio, netfs_group,
 					    flen, offset, part, maybe_trouble);
-		kdebug("howto %u", howto);
+		_debug("howto %u", howto);
 		switch (howto) {
 		case NETFS_JUST_PREFETCH:
 			ret =3D netfs_prefetch_for_write(file, folio, offset, part);
 			if (ret < 0) {
-				kdebug("prefetch =3D %zd", ret);
+				_debug("prefetch =3D %zd", ret);
 				goto error_folio_unlock;
 			}
 			break;
@@ -418,7 +418,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct =
iov_iter *iter,
 	}
=20
 	iocb->ki_pos +=3D written;
-	kleave(" =3D %zd [%zd]", written, ret);
+	_leave(" =3D %zd [%zd]", written, ret);
 	return written ? written : ret;
=20
 error_folio_unlock:
@@ -491,7 +491,7 @@ ssize_t netfs_file_write_iter(struct kiocb *iocb, struc=
t iov_iter *from)
 	struct netfs_inode *ictx =3D netfs_inode(inode);
 	ssize_t ret;
=20
-	kenter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(i=
node));
+	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(i=
node));
=20
 	if (!iov_iter_count(from))
 		return 0;
@@ -529,7 +529,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, str=
uct netfs_group *netfs_gr
 	vm_fault_t ret =3D VM_FAULT_RETRY;
 	int err;
=20
-	kenter("%lx", folio->index);
+	_enter("%lx", folio->index);
=20
 	sb_start_pagefault(inode->i_sb);
=20
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index b6debac6205f..10a1e4da6bda 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -33,7 +33,7 @@ ssize_t netfs_unbuffered_read_iter_locked(struct kiocb *i=
ocb, struct iov_iter *i
 	size_t orig_count =3D iov_iter_count(iter);
 	bool async =3D !is_sync_kiocb(iocb);
=20
-	kenter("");
+	_enter("");
=20
 	if (!orig_count)
 		return 0; /* Don't update atime */
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 792ef17bae21..88f2adfab75e 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -37,7 +37,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *=
iocb, struct iov_iter *
 	size_t len =3D iov_iter_count(iter);
 	bool async =3D !is_sync_kiocb(iocb);
=20
-	kenter("");
+	_enter("");
=20
 	/* We're going to need a bounce buffer if what we transmit is going to
 	 * be different in some way to the source buffer, e.g. because it gets
@@ -45,7 +45,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *=
iocb, struct iov_iter *
 	 */
 	// TODO
=20
-	kdebug("uw %llx-%llx", start, end);
+	_debug("uw %llx-%llx", start, end);
=20
 	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp, =
start,
 				      iocb->ki_flags & IOCB_DIRECT ?
@@ -96,7 +96,7 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *=
iocb, struct iov_iter *
 	wreq->cleanup =3D netfs_cleanup_dio_write;
 	ret =3D netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), wreq->len);
 	if (ret < 0) {
-		kdebug("begin =3D %zd", ret);
+		_debug("begin =3D %zd", ret);
 		goto out;
 	}
=20
@@ -143,7 +143,7 @@ ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb,=
 struct iov_iter *from)
 	loff_t pos =3D iocb->ki_pos;
 	unsigned long long end =3D pos + iov_iter_count(from) - 1;
=20
-	kenter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
+	_enter("%llx,%zx,%llx", pos, iov_iter_count(from), i_size_read(inode));
=20
 	if (!iov_iter_count(from))
 		return 0;
diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 288a73c3072d..9397ed39b0b4 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -237,7 +237,7 @@ int fscache_add_cache(struct fscache_cache *cache,
 {
 	int n_accesses;
=20
-	kenter("{%s,%s}", ops->name, cache->name);
+	_enter("{%s,%s}", ops->name, cache->name);
=20
 	BUG_ON(fscache_cache_state(cache) !=3D FSCACHE_CACHE_IS_PREPARING);
=20
@@ -257,7 +257,7 @@ int fscache_add_cache(struct fscache_cache *cache,
=20
 	up_write(&fscache_addremove_sem);
 	pr_notice("Cache \"%s\" added (type %s)\n", cache->name, ops->name);
-	kleave(" =3D 0 [%s]", cache->name);
+	_leave(" =3D 0 [%s]", cache->name);
 	return 0;
 }
 EXPORT_SYMBOL(fscache_add_cache);
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index 4d1e8bf4c615..bce2492186d0 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -456,7 +456,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
 {
 	struct fscache_cookie *cookie;
=20
-	kenter("V=3D%x", volume->debug_id);
+	_enter("V=3D%x", volume->debug_id);
=20
 	if (!index_key || !index_key_len || index_key_len > 255 || aux_data_len >=
 255)
 		return NULL;
@@ -484,7 +484,7 @@ struct fscache_cookie *__fscache_acquire_cookie(
=20
 	trace_fscache_acquire(cookie);
 	fscache_stat(&fscache_n_acquires_ok);
-	kleave(" =3D c=3D%08x", cookie->debug_id);
+	_leave(" =3D c=3D%08x", cookie->debug_id);
 	return cookie;
 }
 EXPORT_SYMBOL(__fscache_acquire_cookie);
@@ -505,7 +505,7 @@ static void fscache_perform_lookup(struct fscache_cooki=
e *cookie)
 	enum fscache_access_trace trace =3D fscache_access_lookup_cookie_end_fail=
ed;
 	bool need_withdraw =3D false;
=20
-	kenter("");
+	_enter("");
=20
 	if (!cookie->volume->cache_priv) {
 		fscache_create_volume(cookie->volume, true);
@@ -519,7 +519,7 @@ static void fscache_perform_lookup(struct fscache_cooki=
e *cookie)
 		if (cookie->state !=3D FSCACHE_COOKIE_STATE_FAILED)
 			fscache_set_cookie_state(cookie, FSCACHE_COOKIE_STATE_QUIESCENT);
 		need_withdraw =3D true;
-		kleave(" [fail]");
+		_leave(" [fail]");
 		goto out;
 	}
=20
@@ -572,7 +572,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie=
, bool will_modify)
 	bool queue =3D false;
 	int n_active;
=20
-	kenter("c=3D%08x", cookie->debug_id);
+	_enter("c=3D%08x", cookie->debug_id);
=20
 	if (WARN(test_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
 		 "Trying to use relinquished cookie\n"))
@@ -636,7 +636,7 @@ void __fscache_use_cookie(struct fscache_cookie *cookie=
, bool will_modify)
 	spin_unlock(&cookie->lock);
 	if (queue)
 		fscache_queue_cookie(cookie, fscache_cookie_get_use_work);
-	kleave("");
+	_leave("");
 }
 EXPORT_SYMBOL(__fscache_use_cookie);
=20
@@ -702,7 +702,7 @@ static void fscache_cookie_state_machine(struct fscache=
_cookie *cookie)
 	enum fscache_cookie_state state;
 	bool wake =3D false;
=20
-	kenter("c=3D%x", cookie->debug_id);
+	_enter("c=3D%x", cookie->debug_id);
=20
 again:
 	spin_lock(&cookie->lock);
@@ -820,7 +820,7 @@ static void fscache_cookie_state_machine(struct fscache=
_cookie *cookie)
 	spin_unlock(&cookie->lock);
 	if (wake)
 		wake_up_cookie_state(cookie);
-	kleave("");
+	_leave("");
 }
=20
 static void fscache_cookie_worker(struct work_struct *work)
@@ -867,7 +867,7 @@ static void fscache_cookie_lru_do_one(struct fscache_co=
okie *cookie)
 		set_bit(FSCACHE_COOKIE_DO_LRU_DISCARD, &cookie->flags);
 		spin_unlock(&cookie->lock);
 		fscache_stat(&fscache_n_cookies_lru_expired);
-		kdebug("lru c=3D%x", cookie->debug_id);
+		_debug("lru c=3D%x", cookie->debug_id);
 		__fscache_withdraw_cookie(cookie);
 	}
=20
@@ -971,7 +971,7 @@ void __fscache_relinquish_cookie(struct fscache_cookie =
*cookie, bool retire)
 	if (retire)
 		fscache_stat(&fscache_n_relinquishes_retire);
=20
-	kenter("c=3D%08x{%d},%d",
+	_enter("c=3D%08x{%d},%d",
 	       cookie->debug_id, atomic_read(&cookie->n_active), retire);
=20
 	if (WARN(test_and_set_bit(FSCACHE_COOKIE_RELINQUISHED, &cookie->flags),
@@ -1050,7 +1050,7 @@ void __fscache_invalidate(struct fscache_cookie *cook=
ie,
 {
 	bool is_caching;
=20
-	kenter("c=3D%x", cookie->debug_id);
+	_enter("c=3D%x", cookie->debug_id);
=20
 	fscache_stat(&fscache_n_invalidates);
=20
@@ -1072,7 +1072,7 @@ void __fscache_invalidate(struct fscache_cookie *cook=
ie,
 	case FSCACHE_COOKIE_STATE_INVALIDATING: /* is_still_valid will catch it */
 	default:
 		spin_unlock(&cookie->lock);
-		kleave(" [no %u]", cookie->state);
+		_leave(" [no %u]", cookie->state);
 		return;
=20
 	case FSCACHE_COOKIE_STATE_LOOKING_UP:
@@ -1081,7 +1081,7 @@ void __fscache_invalidate(struct fscache_cookie *cook=
ie,
 		fallthrough;
 	case FSCACHE_COOKIE_STATE_CREATING:
 		spin_unlock(&cookie->lock);
-		kleave(" [look %x]", cookie->inval_counter);
+		_leave(" [look %x]", cookie->inval_counter);
 		return;
=20
 	case FSCACHE_COOKIE_STATE_ACTIVE:
@@ -1094,7 +1094,7 @@ void __fscache_invalidate(struct fscache_cookie *cook=
ie,
=20
 		if (is_caching)
 			fscache_queue_cookie(cookie, fscache_cookie_get_inval_work);
-		kleave(" [inv]");
+		_leave(" [inv]");
 		return;
 	}
 }
diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index bf4eaeec44fb..38637e5c9b57 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -28,12 +28,12 @@ bool fscache_wait_for_operation(struct netfs_cache_reso=
urces *cres,
=20
 again:
 	if (!fscache_cache_is_live(cookie->volume->cache)) {
-		kleave(" [broken]");
+		_leave(" [broken]");
 		return false;
 	}
=20
 	state =3D fscache_cookie_state(cookie);
-	kenter("c=3D%08x{%u},%x", cookie->debug_id, state, want_state);
+	_enter("c=3D%08x{%u},%x", cookie->debug_id, state, want_state);
=20
 	switch (state) {
 	case FSCACHE_COOKIE_STATE_CREATING:
@@ -52,7 +52,7 @@ bool fscache_wait_for_operation(struct netfs_cache_resour=
ces *cres,
 	case FSCACHE_COOKIE_STATE_DROPPED:
 	case FSCACHE_COOKIE_STATE_RELINQUISHING:
 	default:
-		kleave(" [not live]");
+		_leave(" [not live]");
 		return false;
 	}
=20
@@ -92,7 +92,7 @@ static int fscache_begin_operation(struct netfs_cache_res=
ources *cres,
 	spin_lock(&cookie->lock);
=20
 	state =3D fscache_cookie_state(cookie);
-	kenter("c=3D%08x{%u},%x", cookie->debug_id, state, want_state);
+	_enter("c=3D%08x{%u},%x", cookie->debug_id, state, want_state);
=20
 	switch (state) {
 	case FSCACHE_COOKIE_STATE_LOOKING_UP:
@@ -140,7 +140,7 @@ static int fscache_begin_operation(struct netfs_cache_r=
esources *cres,
 	cres->cache_priv =3D NULL;
 	cres->ops =3D NULL;
 	fscache_end_cookie_access(cookie, fscache_access_io_not_live);
-	kleave(" =3D -ENOBUFS");
+	_leave(" =3D -ENOBUFS");
 	return -ENOBUFS;
 }
=20
@@ -224,7 +224,7 @@ void __fscache_write_to_cache(struct fscache_cookie *co=
okie,
 	if (len =3D=3D 0)
 		goto abandon;
=20
-	kenter("%llx,%zx", start, len);
+	_enter("%llx,%zx", start, len);
=20
 	wreq =3D kzalloc(sizeof(struct fscache_write_request), GFP_NOFS);
 	if (!wreq)
diff --git a/fs/netfs/fscache_main.c b/fs/netfs/fscache_main.c
index bf9b33d26e31..42e98bb523e3 100644
--- a/fs/netfs/fscache_main.c
+++ b/fs/netfs/fscache_main.c
@@ -99,7 +99,7 @@ int __init fscache_init(void)
  */
 void __exit fscache_exit(void)
 {
-	kenter("");
+	_enter("");
=20
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
diff --git a/fs/netfs/fscache_volume.c b/fs/netfs/fscache_volume.c
index 2e2a405ca9b0..cb75c07b5281 100644
--- a/fs/netfs/fscache_volume.c
+++ b/fs/netfs/fscache_volume.c
@@ -264,7 +264,7 @@ static struct fscache_volume *fscache_alloc_volume(cons=
t char *volume_key,
 	fscache_see_volume(volume, fscache_volume_new_acquire);
 	fscache_stat(&fscache_n_volumes);
 	up_write(&fscache_addremove_sem);
-	kleave(" =3D v=3D%x", volume->debug_id);
+	_leave(" =3D v=3D%x", volume->debug_id);
 	return volume;
=20
 err_vol:
@@ -466,7 +466,7 @@ void fscache_withdraw_volume(struct fscache_volume *vol=
ume)
 {
 	int n_accesses;
=20
-	kdebug("withdraw V=3D%x", volume->debug_id);
+	_debug("withdraw V=3D%x", volume->debug_id);
=20
 	/* Allow wakeups on dec-to-0 */
 	n_accesses =3D atomic_dec_return(&volume->n_accesses);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 21e46bc9aa49..7773f3d855a9 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -34,6 +34,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool =
sync);
 /*
  * main.c
  */
+extern unsigned int netfs_debug;
 extern struct list_head netfs_io_requests;
 extern spinlock_t netfs_proc_lock;
 extern mempool_t netfs_request_pool;
@@ -353,12 +354,42 @@ void fscache_create_volume(struct fscache_volume *vol=
ume, bool wait);
  * debug tracing
  */
 #define dbgprintk(FMT, ...) \
-	pr_debug("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
+	printk("[%-6.6s] "FMT"\n", current->comm, ##__VA_ARGS__)
=20
 #define kenter(FMT, ...) dbgprintk("=3D=3D> %s("FMT")", __func__, ##__VA_A=
RGS__)
 #define kleave(FMT, ...) dbgprintk("<=3D=3D %s()"FMT"", __func__, ##__VA_A=
RGS__)
 #define kdebug(FMT, ...) dbgprintk(FMT, ##__VA_ARGS__)
=20
+#ifdef __KDEBUG
+#define _enter(FMT, ...) kenter(FMT, ##__VA_ARGS__)
+#define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
+#define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
+
+#elif defined(CONFIG_NETFS_DEBUG)
+#define _enter(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kenter(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _leave(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kleave(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#define _debug(FMT, ...)			\
+do {						\
+	if (netfs_debug)			\
+		kdebug(FMT, ##__VA_ARGS__);	\
+} while (0)
+
+#else
+#define _enter(FMT, ...) no_printk("=3D=3D> %s("FMT")", __func__, ##__VA_A=
RGS__)
+#define _leave(FMT, ...) no_printk("<=3D=3D %s()"FMT"", __func__, ##__VA_A=
RGS__)
+#define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
+#endif
+
 /*
  * assertions
  */
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c7576481c321..c93851b98368 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -130,7 +130,7 @@ static void netfs_reset_subreq_iter(struct netfs_io_req=
uest *rreq,
 	if (count =3D=3D remaining)
 		return;
=20
-	kdebug("R=3D%08x[%u] ITER RESUB-MISMATCH %zx !=3D %zx-%zx-%llx %x\n",
+	_debug("R=3D%08x[%u] ITER RESUB-MISMATCH %zx !=3D %zx-%zx-%llx %x\n",
 	       rreq->debug_id, subreq->debug_index,
 	       iov_iter_count(&subreq->io_iter), subreq->transferred,
 	       subreq->len, rreq->i_size,
@@ -326,7 +326,7 @@ void netfs_subreq_terminated(struct netfs_io_subrequest=
 *subreq,
 	struct netfs_io_request *rreq =3D subreq->rreq;
 	int u;
=20
-	kenter("R=3D%x[%x]{%llx,%lx},%zd",
+	_enter("R=3D%x[%x]{%llx,%lx},%zd",
 	       rreq->debug_id, subreq->debug_index,
 	       subreq->start, subreq->flags, transferred_or_error);
=20
@@ -435,7 +435,7 @@ netfs_rreq_prepare_read(struct netfs_io_request *rreq,
 	struct netfs_inode *ictx =3D netfs_inode(rreq->inode);
 	size_t lsize;
=20
-	kenter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq=
->i_size);
+	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq=
->i_size);
=20
 	if (rreq->origin !=3D NETFS_DIO_READ) {
 		source =3D netfs_cache_prepare_read(subreq, rreq->i_size);
@@ -518,7 +518,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_req=
uest *rreq,
 	subreq->start		=3D rreq->start + rreq->submitted;
 	subreq->len		=3D io_iter->count;
=20
-	kdebug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted=
);
+	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted=
);
 	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
=20
 	/* Call out to the cache to find out what it can do with the remaining
@@ -570,7 +570,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, boo=
l sync)
 	struct iov_iter io_iter;
 	int ret;
=20
-	kenter("R=3D%x %llx-%llx",
+	_enter("R=3D%x %llx-%llx",
 	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
=20
 	if (rreq->len =3D=3D 0) {
@@ -593,7 +593,7 @@ int netfs_begin_read(struct netfs_io_request *rreq, boo=
l sync)
 	atomic_set(&rreq->nr_outstanding, 1);
 	io_iter =3D rreq->io_iter;
 	do {
-		kdebug("submit %llx + %llx >=3D %llx",
+		_debug("submit %llx + %llx >=3D %llx",
 		       rreq->start, rreq->submitted, rreq->i_size);
 		if (rreq->origin =3D=3D NETFS_DIO_READ &&
 		    rreq->start + rreq->submitted >=3D rreq->i_size)
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index db824c372842..5f0f438e5d21 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -20,6 +20,10 @@ MODULE_LICENSE("GPL");
=20
 EXPORT_TRACEPOINT_SYMBOL(netfs_sreq);
=20
+unsigned netfs_debug;
+module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+
 static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
 mempool_t netfs_request_pool;
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 172808e83ca8..83e644bd518f 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -26,7 +26,7 @@ bool netfs_dirty_folio(struct address_space *mapping, str=
uct folio *folio)
 	struct fscache_cookie *cookie =3D netfs_i_cookie(ictx);
 	bool need_use =3D false;
=20
-	kenter("");
+	_enter("");
=20
 	if (!filemap_dirty_folio(mapping, folio))
 		return false;
@@ -99,7 +99,7 @@ void netfs_invalidate_folio(struct folio *folio, size_t o=
ffset, size_t length)
 	struct netfs_folio *finfo;
 	size_t flen =3D folio_size(folio);
=20
-	kenter("{%lx},%zx,%zx", folio->index, offset, length);
+	_enter("{%lx},%zx,%zx", folio->index, offset, length);
=20
 	if (!folio_test_private(folio))
 		return;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 488147439fe0..426cf87aaf2e 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -161,7 +161,7 @@ static void netfs_retry_write_stream(struct netfs_io_re=
quest *wreq,
 {
 	struct list_head *next;
=20
-	kenter("R=3D%x[%x:]", wreq->debug_id, stream->stream_nr);
+	_enter("R=3D%x[%x:]", wreq->debug_id, stream->stream_nr);
=20
 	if (list_empty(&stream->subrequests))
 		return;
@@ -374,7 +374,7 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 	unsigned int notes;
 	int s;
=20
-	kenter("%llx-%llx", wreq->start, wreq->start + wreq->len);
+	_enter("%llx-%llx", wreq->start, wreq->start + wreq->len);
 	trace_netfs_collect(wreq);
 	trace_netfs_rreq(wreq, netfs_rreq_trace_collect);
=20
@@ -409,7 +409,7 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 		front =3D stream->front;
 		while (front) {
 			trace_netfs_collect_sreq(wreq, front);
-			//kdebug("sreq [%x] %llx %zx/%zx",
+			//_debug("sreq [%x] %llx %zx/%zx",
 			//       front->debug_index, front->start, front->transferred, front->l=
en);
=20
 			/* Stall if there may be a discontinuity. */
@@ -598,7 +598,7 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 out:
 	netfs_put_group_many(wreq->group, wreq->nr_group_rel);
 	wreq->nr_group_rel =3D 0;
-	kleave(" =3D %x", notes);
+	_leave(" =3D %x", notes);
 	return;
=20
 need_retry:
@@ -606,7 +606,7 @@ static void netfs_collect_write_results(struct netfs_io=
_request *wreq)
 	 * that any partially completed op will have had any wholly transferred
 	 * folios removed from it.
 	 */
-	kdebug("retry");
+	_debug("retry");
 	netfs_retry_writes(wreq);
 	goto out;
 }
@@ -621,7 +621,7 @@ void netfs_write_collection_worker(struct work_struct *=
work)
 	size_t transferred;
 	int s;
=20
-	kenter("R=3D%x", wreq->debug_id);
+	_enter("R=3D%x", wreq->debug_id);
=20
 	netfs_see_request(wreq, netfs_rreq_trace_see_work);
 	if (!test_bit(NETFS_RREQ_IN_PROGRESS, &wreq->flags)) {
@@ -684,7 +684,7 @@ void netfs_write_collection_worker(struct work_struct *=
work)
 	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
 		inode_dio_end(wreq->inode);
=20
-	kdebug("finished");
+	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
@@ -744,7 +744,7 @@ void netfs_write_subrequest_terminated(void *_op, ssize=
_t transferred_or_error,
 	struct netfs_io_request *wreq =3D subreq->rreq;
 	struct netfs_io_stream *stream =3D &wreq->io_streams[subreq->stream_nr];
=20
-	kenter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_=
error);
+	_enter("%x[%x] %zd", wreq->debug_id, subreq->debug_index, transferred_or_=
error);
=20
 	switch (subreq->source) {
 	case NETFS_UPLOAD_TO_SERVER:
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index d7c971df8866..ec6cf8707fb0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -99,7 +99,7 @@ struct netfs_io_request *netfs_create_write_req(struct ad=
dress_space *mapping,
 	if (IS_ERR(wreq))
 		return wreq;
=20
-	kenter("R=3D%x", wreq->debug_id);
+	_enter("R=3D%x", wreq->debug_id);
=20
 	ictx =3D netfs_inode(wreq->inode);
 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &wreq->flags))
@@ -159,7 +159,7 @@ static void netfs_prepare_write(struct netfs_io_request=
 *wreq,
 	subreq->max_nr_segs	=3D INT_MAX;
 	subreq->stream_nr	=3D stream->stream_nr;
=20
-	kenter("R=3D%x[%x]", wreq->debug_id, subreq->debug_index);
+	_enter("R=3D%x[%x]", wreq->debug_id, subreq->debug_index);
=20
 	trace_netfs_sreq_ref(wreq->debug_id, subreq->debug_index,
 			     refcount_read(&subreq->ref),
@@ -215,7 +215,7 @@ static void netfs_do_issue_write(struct netfs_io_stream=
 *stream,
 {
 	struct netfs_io_request *wreq =3D subreq->rreq;
=20
-	kenter("R=3D%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len=
);
+	_enter("R=3D%x[%x],%zx", wreq->debug_id, subreq->debug_index, subreq->len=
);
=20
 	if (test_bit(NETFS_SREQ_FAILED, &subreq->flags))
 		return netfs_write_subrequest_terminated(subreq, subreq->error, false);
@@ -272,11 +272,11 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 	size_t part;
=20
 	if (!stream->avail) {
-		kleave("no write");
+		_leave("no write");
 		return len;
 	}
=20
-	kenter("R=3D%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
+	_enter("R=3D%x[%x]", wreq->debug_id, subreq ? subreq->debug_index : 0);
=20
 	if (subreq && start !=3D subreq->start + subreq->len) {
 		netfs_issue_write(wreq, stream);
@@ -288,7 +288,7 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 	subreq =3D stream->construct;
=20
 	part =3D min(subreq->max_len - subreq->len, len);
-	kdebug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part, len);
+	_debug("part %zx/%zx %zx/%zx", subreq->len, subreq->max_len, part, len);
 	subreq->len +=3D part;
 	subreq->nr_segs++;
=20
@@ -319,7 +319,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
 	bool to_eof =3D false, streamw =3D false;
 	bool debug =3D false;
=20
-	kenter("");
+	_enter("");
=20
 	/* netfs_perform_write() may shift i_size around the page or from out
 	 * of the page to beyond it, but cannot move i_size into or through the
@@ -329,7 +329,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
=20
 	if (fpos >=3D i_size) {
 		/* mmap beyond eof. */
-		kdebug("beyond eof");
+		_debug("beyond eof");
 		folio_start_writeback(folio);
 		folio_unlock(folio);
 		wreq->nr_group_rel +=3D netfs_folio_written_back(folio);
@@ -363,7 +363,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
 	}
 	flen -=3D foff;
=20
-	kdebug("folio %zx %zx %zx", foff, flen, fsize);
+	_debug("folio %zx %zx %zx", foff, flen, fsize);
=20
 	/* Deal with discontinuities in the stream of dirty pages.  These can
 	 * arise from a number of sources:
@@ -487,7 +487,7 @@ static int netfs_write_folio(struct netfs_io_request *w=
req,
 		for (int s =3D 0; s < NR_IO_STREAMS; s++)
 			netfs_issue_write(wreq, &wreq->io_streams[s]);
=20
-	kleave(" =3D 0");
+	_leave(" =3D 0");
 	return 0;
 }
=20
@@ -522,7 +522,7 @@ int netfs_writepages(struct address_space *mapping,
 	netfs_stat(&netfs_n_wh_writepages);
=20
 	do {
-		kdebug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
+		_debug("wbiter %lx %llx", folio->index, wreq->start + wreq->submitted);
=20
 		/* It appears we don't have to handle cyclic writeback wrapping. */
 		WARN_ON_ONCE(wreq && folio_pos(folio) < wreq->start + wreq->submitted);
@@ -546,14 +546,14 @@ int netfs_writepages(struct address_space *mapping,
 	mutex_unlock(&ictx->wb_lock);
=20
 	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-	kleave(" =3D %d", error);
+	_leave(" =3D %d", error);
 	return error;
=20
 couldnt_start:
 	netfs_kill_dirty_pages(mapping, wbc, folio);
 out:
 	mutex_unlock(&ictx->wb_lock);
-	kleave(" =3D %d", error);
+	_leave(" =3D %d", error);
 	return error;
 }
 EXPORT_SYMBOL(netfs_writepages);
@@ -590,7 +590,7 @@ int netfs_advance_writethrough(struct netfs_io_request =
*wreq, struct writeback_c
 			       struct folio *folio, size_t copied, bool to_page_end,
 			       struct folio **writethrough_cache)
 {
-	kenter("R=3D%x ic=3D%zu ws=3D%u cp=3D%zu tp=3D%u",
+	_enter("R=3D%x ic=3D%zu ws=3D%u cp=3D%zu tp=3D%u",
 	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied, to_page_end=
);
=20
 	if (!*writethrough_cache) {
@@ -624,7 +624,7 @@ int netfs_end_writethrough(struct netfs_io_request *wre=
q, struct writeback_contr
 	struct netfs_inode *ictx =3D netfs_inode(wreq->inode);
 	int ret;
=20
-	kenter("R=3D%x", wreq->debug_id);
+	_enter("R=3D%x", wreq->debug_id);
=20
 	if (writethrough_cache)
 		netfs_write_folio(wreq, wbc, writethrough_cache);
@@ -657,7 +657,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wre=
q, bool may_wait, size_t
 	loff_t start =3D wreq->start;
 	int error =3D 0;
=20
-	kenter("%zx", len);
+	_enter("%zx", len);
=20
 	if (wreq->origin =3D=3D NETFS_DIO_WRITE)
 		inode_dio_begin(wreq->inode);
@@ -665,7 +665,7 @@ int netfs_unbuffered_write(struct netfs_io_request *wre=
q, bool may_wait, size_t
 	while (len) {
 		// TODO: Prepare content encryption
=20
-		kdebug("unbuffered %zx", len);
+		_debug("unbuffered %zx", len);
 		part =3D netfs_advance_write(wreq, upload, start, len, false);
 		start +=3D part;
 		len -=3D part;
@@ -684,6 +684,6 @@ int netfs_unbuffered_write(struct netfs_io_request *wre=
q, bool may_wait, size_t
 	if (list_empty(&upload->subrequests))
 		netfs_wake_write_collector(wreq, false);
=20
-	kleave(" =3D %d", error);
+	_leave(" =3D %d", error);
 	return error;
 }


