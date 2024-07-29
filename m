Return-Path: <linux-fsdevel+bounces-24470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A593FAA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5B81C22254
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3571802AB;
	Mon, 29 Jul 2024 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfuzsH/2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE615ECF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270062; cv=none; b=id5EBRocrx13psLDhtYoIZD9bVB3GwTov456x3DjHksWq7cjutb3NTggOABxSekCFPdZCRsIqW7Vhw78r7etZtRbxxo1PcfpGehWljtCAwwyVukihKokO6x7muFV8cG682+amUiVBe6xfpcs3gYZYga14+ey3V8WoRg6qV07v6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270062; c=relaxed/simple;
	bh=tpw79WNaNznyqPf7ZEeQwqGJD8vgjCCtTTOZsubXf8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnA6UWfHOmVSnZh5POEquLwW3ldk1rJO+4A12QI+X/2bset+In14CO/7Nc0+ystRNECMVzNYqEzYSpAU0cai5TXzjqG0cTQ/mSAS7ntbNHLfh4XKTelv5A+ngx7nRQ1DACEnu+GKa5fcypEaWk5N3+nM3yB28bQc4yy24EoxxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfuzsH/2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUFCaiugpQYRsuEnxZTlF3tGbrZhW5QbLwbK4E9lOBQ=;
	b=hfuzsH/27If8/eofW7FETJunV/d9Tpj+ThfLqXEKNHH3iskKSx9tLOp5YT3LNQRx8aGf1n
	zbBM030L1R6tFRfG0Al9jyGkAilXO4RWSGBIAv6lNqadS6nk/CanvBMZ/ROZmQD/rS2oO2
	gPmZV3hmFxYI2wcBPMUQXxFupARWh90=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-FCXZkqGIMZuAIFUfd4yfzw-1; Mon,
 29 Jul 2024 12:20:56 -0400
X-MC-Unique: FCXZkqGIMZuAIFUfd4yfzw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD0DA19560B4;
	Mon, 29 Jul 2024 16:20:52 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C18E719560AE;
	Mon, 29 Jul 2024 16:20:46 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/24] netfs: Reduce number of conditional branches in netfs_perform_write()
Date: Mon, 29 Jul 2024 17:19:34 +0100
Message-ID: <20240729162002.3436763-6-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Reduce the number of conditional branches in netfs_perform_write() by
merging in netfs_how_to_modify() and then creating a separate if-statement
for each way we might modify a folio.  Note that this means replicating the
data copy in each path.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_write.c    | 299 ++++++++++++++++-------------------
 include/trace/events/netfs.h |   2 -
 2 files changed, 134 insertions(+), 167 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 4726c315453c..fba5b238455b 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -13,91 +13,22 @@
 #include <linux/pagevec.h>
 #include "internal.h"
 
-/*
- * Determined write method.  Adjust netfs_folio_traces if this is changed.
- */
-enum netfs_how_to_modify {
-	NETFS_FOLIO_IS_UPTODATE,	/* Folio is uptodate already */
-	NETFS_JUST_PREFETCH,		/* We have to read the folio anyway */
-	NETFS_WHOLE_FOLIO_MODIFY,	/* We're going to overwrite the whole folio */
-	NETFS_MODIFY_AND_CLEAR,		/* We can assume there is no data to be downloaded. */
-	NETFS_STREAMING_WRITE,		/* Store incomplete data in non-uptodate page. */
-	NETFS_STREAMING_WRITE_CONT,	/* Continue streaming write. */
-	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
-};
-
-static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
+static void __netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
-	void *priv = folio_get_private(folio);
-
-	if (netfs_group && (!priv || priv == NETFS_FOLIO_COPY_TO_CACHE))
+	if (netfs_group)
 		folio_attach_private(folio, netfs_get_group(netfs_group));
-	else if (!netfs_group && priv == NETFS_FOLIO_COPY_TO_CACHE)
-		folio_detach_private(folio);
 }
 
-/*
- * Decide how we should modify a folio.  We might be attempting to do
- * write-streaming, in which case we don't want to a local RMW cycle if we can
- * avoid it.  If we're doing local caching or content crypto, we award that
- * priority over avoiding RMW.  If the file is open readably, then we also
- * assume that we may want to read what we wrote.
- */
-static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
-						    struct file *file,
-						    struct folio *folio,
-						    void *netfs_group,
-						    size_t flen,
-						    size_t offset,
-						    size_t len,
-						    bool maybe_trouble)
+static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
-	struct netfs_folio *finfo = netfs_folio_info(folio);
-	struct netfs_group *group = netfs_folio_group(folio);
-	loff_t pos = folio_pos(folio);
-
-	_enter("");
-
-	if (group != netfs_group && group != NETFS_FOLIO_COPY_TO_CACHE)
-		return NETFS_FLUSH_CONTENT;
-
-	if (folio_test_uptodate(folio))
-		return NETFS_FOLIO_IS_UPTODATE;
-
-	if (pos >= ctx->zero_point)
-		return NETFS_MODIFY_AND_CLEAR;
-
-	if (!maybe_trouble && offset == 0 && len >= flen)
-		return NETFS_WHOLE_FOLIO_MODIFY;
-
-	if (file->f_mode & FMODE_READ)
-		goto no_write_streaming;
-
-	if (netfs_is_cache_enabled(ctx)) {
-		/* We don't want to get a streaming write on a file that loses
-		 * caching service temporarily because the backing store got
-		 * culled.
-		 */
-		goto no_write_streaming;
-	}
+	void *priv = folio_get_private(folio);
 
-	if (!finfo)
-		return NETFS_STREAMING_WRITE;
-
-	/* We can continue a streaming write only if it continues on from the
-	 * previous.  If it overlaps, we must flush lest we suffer a partial
-	 * copy and disjoint dirty regions.
-	 */
-	if (offset == finfo->dirty_offset + finfo->dirty_len)
-		return NETFS_STREAMING_WRITE_CONT;
-	return NETFS_FLUSH_CONTENT;
-
-no_write_streaming:
-	if (finfo) {
-		netfs_stat(&netfs_n_wh_wstream_conflict);
-		return NETFS_FLUSH_CONTENT;
+	if (unlikely(priv != netfs_group)) {
+		if (netfs_group && (!priv || priv == NETFS_FOLIO_COPY_TO_CACHE))
+			folio_attach_private(folio, netfs_get_group(netfs_group));
+		else if (!netfs_group && priv == NETFS_FOLIO_COPY_TO_CACHE)
+			folio_detach_private(folio);
 	}
-	return NETFS_JUST_PREFETCH;
 }
 
 /*
@@ -177,13 +108,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		.range_end	= iocb->ki_pos + iter->count,
 	};
 	struct netfs_io_request *wreq = NULL;
-	struct netfs_folio *finfo;
-	struct folio *folio, *writethrough = NULL;
-	enum netfs_how_to_modify howto;
-	enum netfs_folio_trace trace;
+	struct folio *folio = NULL, *writethrough = NULL;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
-	loff_t i_size, pos = iocb->ki_pos, from, to;
+	loff_t i_size, pos = iocb->ki_pos;
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble = false;
 
@@ -213,15 +141,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	do {
+		struct netfs_folio *finfo;
+		struct netfs_group *group;
+		unsigned long long fpos;
 		size_t flen;
 		size_t offset;	/* Offset into pagecache folio */
 		size_t part;	/* Bytes to write to folio */
 		size_t copied;	/* Bytes copied from user */
 
-		ret = balance_dirty_pages_ratelimited_flags(mapping, bdp_flags);
-		if (unlikely(ret < 0))
-			break;
-
 		offset = pos & (max_chunk - 1);
 		part = min(max_chunk - offset, iov_iter_count(iter));
 
@@ -247,7 +174,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		}
 
 		flen = folio_size(folio);
-		offset = pos & (flen - 1);
+		fpos = folio_pos(folio);
+		offset = pos - fpos;
 		part = min_t(size_t, flen - offset, part);
 
 		/* Wait for writeback to complete.  The writeback engine owns
@@ -265,71 +193,52 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			goto error_folio_unlock;
 		}
 
-		/* See if we need to prefetch the area we're going to modify.
-		 * We need to do this before we get a lock on the folio in case
-		 * there's more than one writer competing for the same cache
-		 * block.
+		/* Decide how we should modify a folio.  We might be attempting
+		 * to do write-streaming, in which case we don't want to a
+		 * local RMW cycle if we can avoid it.  If we're doing local
+		 * caching or content crypto, we award that priority over
+		 * avoiding RMW.  If the file is open readably, then we also
+		 * assume that we may want to read what we wrote.
 		 */
-		howto = netfs_how_to_modify(ctx, file, folio, netfs_group,
-					    flen, offset, part, maybe_trouble);
-		_debug("howto %u", howto);
-		switch (howto) {
-		case NETFS_JUST_PREFETCH:
-			ret = netfs_prefetch_for_write(file, folio, offset, part);
-			if (ret < 0) {
-				_debug("prefetch = %zd", ret);
-				goto error_folio_unlock;
-			}
-			break;
-		case NETFS_FOLIO_IS_UPTODATE:
-		case NETFS_WHOLE_FOLIO_MODIFY:
-		case NETFS_STREAMING_WRITE_CONT:
-			break;
-		case NETFS_MODIFY_AND_CLEAR:
-			zero_user_segment(&folio->page, 0, offset);
-			break;
-		case NETFS_STREAMING_WRITE:
-			ret = -EIO;
-			if (WARN_ON(folio_get_private(folio)))
-				goto error_folio_unlock;
-			break;
-		case NETFS_FLUSH_CONTENT:
-			trace_netfs_folio(folio, netfs_flush_content);
-			from = folio_pos(folio);
-			to = from + folio_size(folio) - 1;
-			folio_unlock(folio);
-			folio_put(folio);
-			ret = filemap_write_and_wait_range(mapping, from, to);
-			if (ret < 0)
-				goto error_folio_unlock;
-			continue;
-		}
-
-		if (mapping_writably_mapped(mapping))
-			flush_dcache_folio(folio);
-
-		copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
-
-		flush_dcache_folio(folio);
-
-		/* Deal with a (partially) failed copy */
-		if (copied == 0) {
-			ret = -EFAULT;
-			goto error_folio_unlock;
+		finfo = netfs_folio_info(folio);
+		group = netfs_folio_group(folio);
+
+		if (unlikely(group != netfs_group) &&
+		    group != NETFS_FOLIO_COPY_TO_CACHE)
+			goto flush_content;
+
+		if (folio_test_uptodate(folio)) {
+			if (mapping_writably_mapped(mapping))
+				flush_dcache_folio(folio);
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
+			netfs_set_group(folio, netfs_group);
+			trace_netfs_folio(folio, netfs_folio_is_uptodate);
+			goto copied;
 		}
 
-		trace = (enum netfs_folio_trace)howto;
-		switch (howto) {
-		case NETFS_FOLIO_IS_UPTODATE:
-		case NETFS_JUST_PREFETCH:
-			netfs_set_group(folio, netfs_group);
-			break;
-		case NETFS_MODIFY_AND_CLEAR:
+		/* If the page is above the zero-point then we assume that the
+		 * server would just return a block of zeros or a short read if
+		 * we try to read it.
+		 */
+		if (fpos >= ctx->zero_point) {
+			zero_user_segment(&folio->page, 0, offset);
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
 			zero_user_segment(&folio->page, offset + copied, flen);
-			netfs_set_group(folio, netfs_group);
+			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
-			break;
-		case NETFS_WHOLE_FOLIO_MODIFY:
+			trace_netfs_folio(folio, netfs_modify_and_clear);
+			goto copied;
+		}
+
+		/* See if we can write a whole folio in one go. */
+		if (!maybe_trouble && offset == 0 && part >= flen) {
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
 			if (unlikely(copied < part)) {
 				maybe_trouble = true;
 				iov_iter_revert(iter, copied);
@@ -337,16 +246,53 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 				folio_unlock(folio);
 				goto retry;
 			}
-			netfs_set_group(folio, netfs_group);
+			__netfs_set_group(folio, netfs_group);
 			folio_mark_uptodate(folio);
-			break;
-		case NETFS_STREAMING_WRITE:
+			trace_netfs_folio(folio, netfs_whole_folio_modify);
+			goto copied;
+		}
+
+		/* We don't want to do a streaming write on a file that loses
+		 * caching service temporarily because the backing store got
+		 * culled and we don't really want to get a streaming write on
+		 * a file that's open for reading as ->read_folio() then has to
+		 * be able to flush it.
+		 */
+		if ((file->f_mode & FMODE_READ) ||
+		    netfs_is_cache_enabled(ctx)) {
+			if (finfo) {
+				netfs_stat(&netfs_n_wh_wstream_conflict);
+				goto flush_content;
+			}
+			ret = netfs_prefetch_for_write(file, folio, offset, part);
+			if (ret < 0) {
+				_debug("prefetch = %zd", ret);
+				goto error_folio_unlock;
+			}
+			/* Note that copy-to-cache may have been set. */
+
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
+			netfs_set_group(folio, netfs_group);
+			trace_netfs_folio(folio, netfs_just_prefetch);
+			goto copied;
+		}
+
+		if (!finfo) {
+			ret = -EIO;
+			if (WARN_ON(folio_get_private(folio)))
+				goto error_folio_unlock;
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
 			if (offset == 0 && copied == flen) {
-				netfs_set_group(folio, netfs_group);
+				__netfs_set_group(folio, netfs_group);
 				folio_mark_uptodate(folio);
-				trace = netfs_streaming_filled_page;
-				break;
+				trace_netfs_folio(folio, netfs_streaming_filled_page);
+				goto copied;
 			}
+
 			finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
 			if (!finfo) {
 				iov_iter_revert(iter, copied);
@@ -358,9 +304,18 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			finfo->dirty_len = copied;
 			folio_attach_private(folio, (void *)((unsigned long)finfo |
 							     NETFS_FOLIO_INFO));
-			break;
-		case NETFS_STREAMING_WRITE_CONT:
-			finfo = netfs_folio_info(folio);
+			trace_netfs_folio(folio, netfs_streaming_write);
+			goto copied;
+		}
+
+		/* We can continue a streaming write only if it continues on
+		 * from the previous.  If it overlaps, we must flush lest we
+		 * suffer a partial copy and disjoint dirty regions.
+		 */
+		if (offset == finfo->dirty_offset + finfo->dirty_len) {
+			copied = copy_folio_from_iter_atomic(folio, offset, part, iter);
+			if (unlikely(copied == 0))
+				goto copy_failed;
 			finfo->dirty_len += copied;
 			if (finfo->dirty_offset == 0 && finfo->dirty_len == flen) {
 				if (finfo->netfs_group)
@@ -369,17 +324,25 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 					folio_detach_private(folio);
 				folio_mark_uptodate(folio);
 				kfree(finfo);
-				trace = netfs_streaming_cont_filled_page;
+				trace_netfs_folio(folio, netfs_streaming_cont_filled_page);
+			} else {
+				trace_netfs_folio(folio, netfs_streaming_write_cont);
 			}
-			break;
-		default:
-			WARN(true, "Unexpected modify type %u ix=%lx\n",
-			     howto, folio->index);
-			ret = -EIO;
-			goto error_folio_unlock;
+			goto copied;
 		}
 
-		trace_netfs_folio(folio, trace);
+		/* Incompatible write; flush the folio and try again. */
+	flush_content:
+		trace_netfs_folio(folio, netfs_flush_content);
+		folio_unlock(folio);
+		folio_put(folio);
+		ret = filemap_write_and_wait_range(mapping, fpos, fpos + flen - 1);
+		if (ret < 0)
+			goto error_folio_unlock;
+		continue;
+
+	copied:
+		flush_dcache_folio(folio);
 
 		/* Update the inode size if we moved the EOF marker */
 		pos += copied;
@@ -401,6 +364,10 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		folio_put(folio);
 		folio = NULL;
 
+		ret = balance_dirty_pages_ratelimited_flags(mapping, bdp_flags);
+		if (unlikely(ret < 0))
+			break;
+
 		cond_resched();
 	} while (iov_iter_count(iter));
 
@@ -421,6 +388,8 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	_leave(" = %zd [%zd]", written, ret);
 	return written ? written : ret;
 
+copy_failed:
+	ret = -EFAULT;
 error_folio_unlock:
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index da23484268df..fc5dbd19f120 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -128,7 +128,6 @@
 	E_(netfs_sreq_trace_put_terminated,	"PUT TERM   ")
 
 #define netfs_folio_traces					\
-	/* The first few correspond to enum netfs_how_to_modify */	\
 	EM(netfs_folio_is_uptodate,		"mod-uptodate")	\
 	EM(netfs_just_prefetch,			"mod-prefetch")	\
 	EM(netfs_whole_folio_modify,		"mod-whole-f")	\
@@ -138,7 +137,6 @@
 	EM(netfs_flush_content,			"flush")	\
 	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
-	/* The rest are for writeback */			\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
 	EM(netfs_folio_trace_clear_cc,		"clear-cc")	\


