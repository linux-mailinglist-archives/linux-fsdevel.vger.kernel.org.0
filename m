Return-Path: <linux-fsdevel+bounces-24485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06A93FB1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 18:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7351C224C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4815FA68;
	Mon, 29 Jul 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtkyWau/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BDF19149E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270174; cv=none; b=MxIdQInd6hvdQNfsHfqo/GlXaOw+d9fnA+wpDuQrIgj2QoAwk3YoRuyEkVnbhTtGrlYJhxd7914kzTFWoSf7VO5v0W4PBlDA3sqAwq8ZGj8Owk36d7SBpZeuOzJTk3Fy7S1xWP69IuIPjrvZDaO5Hn+6XTaVuQUdkhuL9/CokUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270174; c=relaxed/simple;
	bh=mEZDR3R4Iua+bEclDMGOq8gGhZC5ndWd0x/NbqX3cQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCsT6MgQzRBMhbTUwLylMKcjvjY60TvzsEqvb/QdD+626LvvZXSfduoN5nw+EmnJJDUA1rXiM5FN+1XY859D0FigBgUIA+j7PCeqWdDc/HD2WW4pdZd4boi370JfQ6PxQfH1MxcDBUU1GfA8F4+kEUlguGJ1cqkWxHOZeS8aqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtkyWau/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722270171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkUmafKnkjrKfRYrg113wMsu3lfIhzrdFfYQD3AXCyI=;
	b=VtkyWau/NiP6SOiaenUbxetUXta8JemmYzR/rrgYYIXwwU3wA+4ySvIu86qYPhidMrs6xW
	rzEhAouAbqwJOvTpvJXKpvJXxi1AjhGVhghyWcpTPO9wv2xumJYG0ophW76pyN1fIWGJAj
	+pchVdYEPWH3h2NKVt1gYBSu22W9P7g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Tsf-DznPP_awNvwyCq8cTw-1; Mon,
 29 Jul 2024 12:22:45 -0400
X-MC-Unique: Tsf-DznPP_awNvwyCq8cTw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0862E1955F6A;
	Mon, 29 Jul 2024 16:22:43 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E6E81955D42;
	Mon, 29 Jul 2024 16:22:36 +0000 (UTC)
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
Subject: [PATCH 20/24] cachefiles, netfs: Fix write to partial block at EOF
Date: Mon, 29 Jul 2024 17:19:49 +0100
Message-ID: <20240729162002.3436763-21-dhowells@redhat.com>
In-Reply-To: <20240729162002.3436763-1-dhowells@redhat.com>
References: <20240729162002.3436763-1-dhowells@redhat.com>
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
 fs/cachefiles/io.c     | 14 ++++++++++++++
 fs/netfs/write_issue.c |  5 ++---
 include/linux/netfs.h  |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

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
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 43cec03c6514..87a5aeb77073 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -280,6 +280,7 @@ static int netfs_advance_write(struct netfs_io_request *wreq,
 	_debug("part %zx/%zx %zx/%zx", subreq->len, stream->sreq_max_len, part, len);
 	subreq->len += part;
 	subreq->nr_segs++;
+	stream->submit_extendable_to -= part;
 
 	if (subreq->len >= stream->sreq_max_len ||
 	    subreq->nr_segs >= stream->sreq_max_segs ||
@@ -421,7 +422,6 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	 */
 	for (int s = 0; s < NR_IO_STREAMS; s++) {
 		stream = &wreq->io_streams[s];
-		stream->submit_max_len = fsize;
 		stream->submit_off = foff;
 		stream->submit_len = flen;
 		if ((stream->source == NETFS_WRITE_TO_CACHE && streamw) ||
@@ -429,7 +429,6 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 		     fgroup == NETFS_FOLIO_COPY_TO_CACHE)) {
 			stream->submit_off = UINT_MAX;
 			stream->submit_len = 0;
-			stream->submit_max_len = 0;
 		}
 	}
 
@@ -459,10 +458,10 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
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
index be1686f0fe34..d34ef6beed62 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -137,7 +137,7 @@ struct netfs_io_stream {
 	unsigned int		sreq_max_segs;	/* 0 or max number of segments in an iterator */
 	unsigned int		submit_off;	/* Folio offset we're submitting from */
 	unsigned int		submit_len;	/* Amount of data left to submit */
-	unsigned int		submit_max_len;	/* Amount I/O can be rounded up to */
+	unsigned int		submit_extendable_to; /* Amount I/O can be rounded up to */
 	void (*prepare_write)(struct netfs_io_subrequest *subreq);
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */


