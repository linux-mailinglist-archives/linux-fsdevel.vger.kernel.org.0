Return-Path: <linux-fsdevel+bounces-7601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBCA8284D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 12:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7201C23FAB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 11:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3139AD1;
	Tue,  9 Jan 2024 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBIIHDaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4E38F9A
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704799257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Zmt8qPNtA4BbCqgJuw0LKGT28DtGNcpxFrcZYWG/0=;
	b=gBIIHDaJgcyRlUaUhCwBISagy1JqabLMBC7WHYrGxR8yrpf3/blcEVIeRVGeRRl1cMsbG6
	vlJzH8mu+yQLvfaE0KfYJtmdVpfbCnudGyx4XlbIWBWZlKpC8aRw7rjrC3cyiOpwIv3G2i
	88jAM0eICBK+YTilrPlfN9kLDQbSvV8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-aZtDJMnWPAi-V2MIXSUMUQ-1; Tue,
 09 Jan 2024 06:20:54 -0500
X-MC-Unique: aZtDJMnWPAi-V2MIXSUMUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28F8329AA3AF;
	Tue,  9 Jan 2024 11:20:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CD382166B32;
	Tue,  9 Jan 2024 11:20:50 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	linux-cachefs@redhat.com,
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
Subject: [PATCH 4/6] netfs: Fix the loop that unmarks folios after writing to the cache
Date: Tue,  9 Jan 2024 11:20:21 +0000
Message-ID: <20240109112029.1572463-5-dhowells@redhat.com>
In-Reply-To: <20240109112029.1572463-1-dhowells@redhat.com>
References: <20240109112029.1572463-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In the loop in netfs_rreq_unmark_after_write() that removes the PG_fscache
from folios after they've been written to the cache, as soon as we remove
the mark from a multipage folio, it can get split - and then we might see a
fragment of folio again.

Guard against this by advancing the 'unlocked' tracker to the index of the
last page in the folio to avoid a double removal of the PG_fscache mark.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c | 1 +
 fs/netfs/io.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 6cd8f7422e9a..0b2b7a60dabc 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -698,6 +698,7 @@ static void netfs_pages_written_back(struct netfs_io_request *wreq)
 	end_wb:
 		if (folio_test_fscache(folio))
 			folio_end_fscache(folio);
+		xas_advance(&xas, folio_next_index(folio) - 1);
 		folio_end_writeback(folio);
 	}
 
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 5b5af96cd4b9..4309edf33862 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -126,7 +126,7 @@ static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
 			 */
 			if (have_unlocked && folio_index(folio) <= unlocked)
 				continue;
-			unlocked = folio_index(folio);
+			unlocked = folio_next_index(folio) - 1;
 			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
 			folio_end_fscache(folio);
 			have_unlocked = true;


