Return-Path: <linux-fsdevel+bounces-25983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E53952407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 22:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4EA1F247F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870161C7B9A;
	Wed, 14 Aug 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnNmZP0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37731E3CB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668106; cv=none; b=A2nEsRInvENF/Pud5GEGqYVN3GPvMapi6jUquG9GMRjp1oxltPfNSjKr3lSObvz/oxvxozwfAnDwZmudtNwFJqApG81B88Jb9B9N2yB6kSyY/mpZWYK1QoREOCFo9F2JugSQa019Iu9Al2zuFfpELvLFJ01wKhN5ysDilNalc18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668106; c=relaxed/simple;
	bh=5pAIXjfJBXF3A4eahO2YDfWF2KoE+EQ2EQOBB1JQ55M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGl9kLvxMAK6ETie7f+cyyk48uxB8o02FKzAyknIzUiPabx1Eenk3F9fFO5eUdpLh6Vy3m/r0alHzC6On8wH4NaWqVWm36PZJK0ak6YnSDbHajUSW8gmbcI9SSSgoausxL+DXZPJXg3lMTzKz2LwDRkPe1xSTiHh8rhFXHlH3qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnNmZP0I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iwp88PKNI4mMdeB9eXHleWn+X4nv/CC8OxS+odKjs5Q=;
	b=hnNmZP0IUcV4iNGICxGTmyU2IEpDYqFgT0ByT7PxyeUDIxLhwyIJhmnpw+63nkjCZUDP/7
	x+d0jyOvlT1mBCSc0gQu1eZHU8B2MgJQrXMriUxmYXnkhG09y94BRlbLobxnfWOGt836Qp
	45us+bYlqO5dHhDt8hyx8z4v6+1FGW0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-7X87DD1LN9GwpLr3LM1nyg-1; Wed,
 14 Aug 2024 16:41:41 -0400
X-MC-Unique: 7X87DD1LN9GwpLr3LM1nyg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47CCD1954B11;
	Wed, 14 Aug 2024 20:41:38 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C92FB1955E8C;
	Wed, 14 Aug 2024 20:41:32 +0000 (UTC)
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
Subject: [PATCH v2 21/25] cachefiles, netfs: Fix write to partial block at EOF
Date: Wed, 14 Aug 2024 21:38:41 +0100
Message-ID: <20240814203850.2240469-22-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Because it uses DIO writes, cachefiles is unable to make a write to the
backing file if that write is not aligned to and sized according to the
backing file's DIO block alignment.  This makes it tricky to handle a write
to the cache where the EOF on the network file is not correctly aligned.

To get around this, netfslib attempts to tell the driver it is calling how
much more data there is available beyond the EOF that it can use to pad the
write (netfslib preclears the part of the folio above the EOF).  However,
it tries to tell the cache what the maximum length is, but doesn't
calculate this correctly; and, in any case, cachefiles actually ignores the
value and just skips the block.

Fix this by:

 (1) Change the value passed to indicate the amount of extra data that can
     be added to the operation (now ->submit_extendable_to).  This is much
     simpler to calculate as it's just the end of the folio minus the top
     of the data within the folio - rather than having to account for data
     spread over multiple folios.

 (2) Make cachefiles add some of this data if the subrequest it is given
     ends at the network file's i_size if the extra data is sufficient to
     pad out to a whole block.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/io.c      | 14 ++++++++++++++
 fs/netfs/read_pgpriv2.c |  4 ++--
 fs/netfs/write_issue.c  |  5 ++---
 include/linux/netfs.h   |  2 +-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 5b82ba7785cd..6a821a959b59 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -648,6 +648,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	struct netfs_cache_resources *cres = &wreq->cache_resources;
 	struct cachefiles_object *object = cachefiles_cres_object(cres);
 	struct cachefiles_cache *cache = object->volume->cache;
+	struct netfs_io_stream *stream = &wreq->io_streams[subreq->stream_nr];
 	const struct cred *saved_cred;
 	size_t off, pre, post, len = subreq->len;
 	loff_t start = subreq->start;
@@ -661,6 +662,7 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	if (off) {
 		pre = CACHEFILES_DIO_BLOCK_SIZE - off;
 		if (pre >= len) {
+			fscache_count_dio_misfit();
 			netfs_write_subrequest_terminated(subreq, len, false);
 			return;
 		}
@@ -671,10 +673,22 @@ static void cachefiles_issue_write(struct netfs_io_subrequest *subreq)
 	}
 
 	/* We also need to end on the cache granularity boundary */
+	if (start + len == wreq->i_size) {
+		size_t part = len % CACHEFILES_DIO_BLOCK_SIZE;
+		size_t need = CACHEFILES_DIO_BLOCK_SIZE - part;
+
+		if (part && stream->submit_extendable_to >= need) {
+			len += need;
+			subreq->len += need;
+			subreq->io_iter.count += need;
+		}
+	}
+
 	post = len & (CACHEFILES_DIO_BLOCK_SIZE - 1);
 	if (post) {
 		len -= post;
 		if (len == 0) {
+			fscache_count_dio_misfit();
 			netfs_write_subrequest_terminated(subreq, post, false);
 			return;
 		}
diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index 9439461d535f..ba5af89d37fa 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -97,7 +97,7 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 	if (netfs_buffer_append_folio(wreq, folio, false) < 0)
 		return -ENOMEM;
 
-	cache->submit_max_len = fsize;
+	cache->submit_extendable_to = fsize;
 	cache->submit_off = 0;
 	cache->submit_len = flen;
 
@@ -112,10 +112,10 @@ static int netfs_pgpriv2_copy_folio(struct netfs_io_request *wreq, struct folio
 		wreq->io_iter.iov_offset = cache->submit_off;
 
 		atomic64_set(&wreq->issued_to, fpos + cache->submit_off);
+		cache->submit_extendable_to = fsize - cache->submit_off;
 		part = netfs_advance_write(wreq, cache, fpos + cache->submit_off,
 					   cache->submit_len, to_eof);
 		cache->submit_off += part;
-		cache->submit_max_len -= part;
 		if (part > cache->submit_len)
 			cache->submit_len = 0;
 		else
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 975436d3dc3f..f7d59f0bb8c2 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -283,6 +283,7 @@ int netfs_advance_write(struct netfs_io_request *wreq,
 	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
 	subreq->len += part;
 	subreq->nr_segs++;
+	stream->submit_extendable_to -= part;
 
 	if (subreq->len >= stream->sreq_max_len ||
 	    subreq->nr_segs >= stream->sreq_max_segs ||
@@ -424,7 +425,6 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 */
 	for (int s = 0; s < NR_IO_STREAMS; s++) {
 		stream = &wreq->io_streams[s];
-		stream->submit_max_len = fsize;
 		stream->submit_off = foff;
 		stream->submit_len = flen;
 		if ((stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
@@ -432,7 +432,6 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		     fgroup == NETFS_FOLIO_COPY_TO_CACHE)) {
 			stream->submit_off = UINT_MAX;
 			stream->submit_len = 0;
-			stream->submit_max_len = 0;
 		}
 	}
 
@@ -462,10 +461,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		wreq->io_iter.iov_offset = stream->submit_off;
 
 		atomic64_set(&wreq->issued_to, fpos + stream->submit_off);
+		stream->submit_extendable_to = fsize - stream->submit_off;
 		part = netfs_advance_write(wreq, stream, fpos + stream->submit_off,
 					   stream->submit_len, to_eof);
 		stream->submit_off += part;
-		stream->submit_max_len -= part;
 		if (part > stream->submit_len)
 			stream->submit_len = 0;
 		else
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c0f0c9c87d86..5eaceef41e6c 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -135,7 +135,7 @@ struct netfs_io_stream {
 	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
 	unsigned int		submit_off;	/* Folio offset we're submitting from */
 	unsigned int		submit_len;	/* Amount of data left to submit */
-	unsigned int		submit_max_len;	/* Amount I/O can be rounded up to */
+	unsigned int		submit_extendable_to; /* Amount I/O can be rounded up to */
 	void (*prepare_write)(struct netfs_io_subrequest *subreq);
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */


