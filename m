Return-Path: <linux-fsdevel+bounces-326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856307C8AE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A511C21135
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6134224C8;
	Fri, 13 Oct 2023 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVims7Dy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2A721A08
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:20:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B35130
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ0EH3j50U389igBFANhTwAFPV4cR9SbiJMpaWBP0sQ=;
	b=HVims7DyKlCDp2ugaDsFI3W41AqFPYIJc9a9Vd8L+D9a52VboKt53WPdUfohGlZmSKlxjV
	TIbHtxtwimwoE12XqiDiBVJB/pKHKsAx78x1Vb/K8IZ0idbnd+LsJVZqRZpw63ZVF+WY5u
	rDiBVDjXHFqBRImLXIBur+dL34AAORc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-YdQnHyJONxOiGOy-PV0Gow-1; Fri, 13 Oct 2023 12:06:27 -0400
X-MC-Unique: YdQnHyJONxOiGOy-PV0Gow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D0E085A5BF;
	Fri, 13 Oct 2023 16:06:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DDB741C060DF;
	Fri, 13 Oct 2023 16:06:22 +0000 (UTC)
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
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 34/53] netfs: Make netfs_skip_folio_read() take account of blocksize
Date: Fri, 13 Oct 2023 17:04:03 +0100
Message-ID: <20231013160423.2218093-35-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index e06461ef0bfa..de696aaaefbd 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -337,6 +337,7 @@ EXPORT_SYMBOL(netfs_read_folio);
 
 /*
  * Prepare a folio for writing without reading first
+ * @ctx: File context
  * @folio: The folio being prepared
  * @pos: starting position for the write
  * @len: length of write
@@ -350,32 +351,41 @@ EXPORT_SYMBOL(netfs_read_folio);
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
@@ -454,7 +464,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	 * to preload the granule.
 	 */
 	if (!netfs_is_cache_enabled(ctx) &&
-	    netfs_skip_folio_read(folio, pos, len, false)) {
+	    netfs_skip_folio_read(ctx, folio, pos, len, false)) {
 		netfs_stat(&netfs_n_rh_write_zskip);
 		goto have_folio_no_wait;
 	}


