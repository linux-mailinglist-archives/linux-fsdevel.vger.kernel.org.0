Return-Path: <linux-fsdevel+bounces-5254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A12E8095F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C332819F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24065732B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWDme+1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A245272A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 13:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7Yf3Gyz2poDrlJ/i6bRFpW4r3T86H5wARr3qsse2RM=;
	b=CWDme+1ekjhtrVS6iDAqvMCwDF6Kp1KXMq+algqyi2q3qa+Exoi73uKQ5KSiJzzlvhnLed
	I+rMsMDTocM15RpZ6kmIpevS1JLWxthAaPttEToDJNXtMIjqwgGqMm7MtwIAYa/rPBPrIL
	fiD/IN23tOnFoW0Tw9zxHAZfO7Ft5BE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-8zEOlF5DPGemNRiwVlcCcg-1; Thu,
 07 Dec 2023 16:24:17 -0500
X-MC-Unique: 8zEOlF5DPGemNRiwVlcCcg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A78C93C40B58;
	Thu,  7 Dec 2023 21:24:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1024B1C060AF;
	Thu,  7 Dec 2023 21:24:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/59] netfs: Make netfs_skip_folio_read() take account of blocksize
Date: Thu,  7 Dec 2023 21:21:43 +0000
Message-ID: <20231207212206.1379128-37-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Make netfs_skip_folio_read() take account of blocksize such as crypto
blocksize.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_read.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 0d47e5ea6870..8b27ef2e78ca 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -331,6 +331,7 @@ EXPORT_SYMBOL(netfs_read_folio);
 
 /*
  * Prepare a folio for writing without reading first
+ * @ctx: File context
  * @folio: The folio being prepared
  * @pos: starting position for the write
  * @len: length of write
@@ -344,32 +345,41 @@ EXPORT_SYMBOL(netfs_read_folio);
  * If any of these criteria are met, then zero out the unwritten parts
  * of the folio and return true. Otherwise, return false.
  */
-static bool netfs_skip_folio_read(struct folio *folio, loff_t pos, size_t len,
-				 bool always_fill)
+static bool netfs_skip_folio_read(struct netfs_inode *ctx, struct folio *folio,
+				  loff_t pos, size_t len, bool always_fill)
 {
 	struct inode *inode = folio_inode(folio);
-	loff_t i_size = i_size_read(inode);
+	loff_t i_size = i_size_read(inode), low, high;
 	size_t offset = offset_in_folio(folio, pos);
 	size_t plen = folio_size(folio);
+	size_t min_bsize = 1UL << ctx->min_bshift;
+
+	if (likely(min_bsize == 1)) {
+		low = folio_file_pos(folio);
+		high = low + plen;
+	} else {
+		low = round_down(pos, min_bsize);
+		high = round_up(pos + len, min_bsize);
+	}
 
 	if (unlikely(always_fill)) {
-		if (pos - offset + len <= i_size)
-			return false; /* Page entirely before EOF */
+		if (low < i_size)
+			return false; /* Some part of the block before EOF */
 		zero_user_segment(&folio->page, 0, plen);
 		folio_mark_uptodate(folio);
 		return true;
 	}
 
-	/* Full folio write */
-	if (offset == 0 && len >= plen)
+	/* Full page write */
+	if (pos == low && high == pos + len)
 		return true;
 
-	/* Page entirely beyond the end of the file */
-	if (pos - offset >= i_size)
+	/* pos beyond last page in the file */
+	if (low >= i_size)
 		goto zero_out;
 
 	/* Write that covers from the start of the folio to EOF or beyond */
-	if (offset == 0 && (pos + len) >= i_size)
+	if (pos == low && (pos + len) >= i_size)
 		goto zero_out;
 
 	return false;
@@ -448,7 +458,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	 * to preload the granule.
 	 */
 	if (!netfs_is_cache_enabled(ctx) &&
-	    netfs_skip_folio_read(folio, pos, len, false)) {
+	    netfs_skip_folio_read(ctx, folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_folio_no_wait;
 	}


