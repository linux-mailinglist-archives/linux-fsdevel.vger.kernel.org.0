Return-Path: <linux-fsdevel+bounces-15586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F07B8890688
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66FDFB260A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825212FB35;
	Thu, 28 Mar 2024 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIyMPPJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9EB82894
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645186; cv=none; b=WDoBPjueMZz9vmpd4ZgWDXmCFU+WkdZo2LfxVXG74Tyl+YRKlTcHt0VL+5r9pSDAVNS2Vt6fwGNn1+Xif/GEU1ZRI+LCa7uxomSPhNTHdMSQqLzhxFeCbUtDICczrPP5OEAZfo5kWsifVZT5UiV9PhWeVYwd4d4aWoDLExkGyB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645186; c=relaxed/simple;
	bh=91203nhPa825Pcw3EKi4vZbAvQwkqupVawlE3FIuJdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mh07uSdxp3QmPKarx99H0UgzMsULDs6Esy83028LtPflkxbsM16g1+XsY2/96rKoKJSl+xu0azy5xDIYkRYYqfw1SrKfEz8wy8t2l1AwnXyG2cG2ngXGnheOlf3pEDukLFAycXzDTfJyv5+QQQcCsBhwjX/EmCwtZlX+mxJlzew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIyMPPJN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tzNFrIx51OPZGYIohrzRvwjxtNHaaHVdYPKmPKDLG9U=;
	b=gIyMPPJNqytII+0o88KMpRldCVK+jeAfW/kr+j2awz8f0KTbw0kBm8i7fsv4EP4bEXH2Hj
	TN+4wKMKGuOSrHpNaqTwSlaY4F34kzGScxo3nz2WAp3aIy99JB7XBEqFvzQ5T9LBbazpgp
	mrmA1y3l+XNHt8o1egL9HuHFasquJHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-M-9TrocPM52Eo_XJTQe1gg-1; Thu,
 28 Mar 2024 12:59:38 -0400
X-MC-Unique: M-9TrocPM52Eo_XJTQe1gg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1748D28EC105;
	Thu, 28 Mar 2024 16:59:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D6D84492BD0;
	Thu, 28 Mar 2024 16:59:33 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	linux-cachefs@redhat.com
Subject: [PATCH v6 04/15] cifs: Make wait_mtu_credits take size_t args
Date: Thu, 28 Mar 2024 16:57:55 +0000
Message-ID: <20240328165845.2782259-5-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Make the wait_mtu_credits functions use size_t for the size and num
arguments rather than unsigned int as netfslib uses size_t/ssize_t for
arguments and return values to allow for extra capacity.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsglob.h  |  4 ++--
 fs/smb/client/cifsproto.h |  2 +-
 fs/smb/client/file.c      | 17 ++++++++++-------
 fs/smb/client/smb2ops.c   |  4 ++--
 fs/smb/client/transport.c |  4 ++--
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ff86ab3d6166..6436d360b9f4 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -546,8 +546,8 @@ struct smb_version_operations {
 	/* writepages retry size */
 	unsigned int (*wp_retry_size)(struct inode *);
 	/* get mtu credits */
-	int (*wait_mtu_credits)(struct TCP_Server_Info *, unsigned int,
-				unsigned int *, struct cifs_credits *);
+	int (*wait_mtu_credits)(struct TCP_Server_Info *, size_t,
+				size_t *, struct cifs_credits *);
 	/* adjust previously taken mtu credits to request size */
 	int (*adjust_credits)(struct TCP_Server_Info *server,
 			      struct cifs_credits *credits,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 010601a89fe5..95b5fa385196 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -121,7 +121,7 @@ extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *,
 extern int cifs_check_receive(struct mid_q_entry *mid,
 			struct TCP_Server_Info *server, bool log_error);
 extern int cifs_wait_mtu_credits(struct TCP_Server_Info *server,
-				 unsigned int size, unsigned int *num,
+				 size_t size, size_t *num,
 				 struct cifs_credits *credits);
 extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *,
 			struct kvec *, int /* nvec to send */,
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index c5850a1c484f..76bfefa9b669 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2704,7 +2704,8 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	struct cifs_credits *credits = &credits_on_stack;
 	struct cifsFileInfo *cfile = NULL;
 	unsigned long long i_size = i_size_read(inode), max_len;
-	unsigned int xid, wsize;
+	unsigned int xid;
+	size_t wsize;
 	size_t len = folio_size(folio);
 	long count = wbc->nr_to_write;
 	int rc;
@@ -3206,7 +3207,7 @@ static int
 cifs_resend_wdata(struct cifs_io_subrequest *wdata, struct list_head *wdata_list,
 	struct cifs_aio_ctx *ctx)
 {
-	unsigned int wsize;
+	size_t wsize;
 	struct cifs_credits credits;
 	int rc;
 	struct TCP_Server_Info *server = wdata->server;
@@ -3341,7 +3342,8 @@ cifs_write_from_iter(loff_t fpos, size_t len, struct iov_iter *from,
 	do {
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
-		unsigned int wsize, nsegs = 0;
+		unsigned int nsegs = 0;
+		size_t wsize;
 
 		if (signal_pending(current)) {
 			rc = -EINTR;
@@ -3778,7 +3780,7 @@ static int cifs_resend_rdata(struct cifs_io_subrequest *rdata,
 			struct list_head *rdata_list,
 			struct cifs_aio_ctx *ctx)
 {
-	unsigned int rsize;
+	size_t rsize;
 	struct cifs_credits credits;
 	int rc;
 	struct TCP_Server_Info *server;
@@ -3852,10 +3854,10 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 		     struct cifs_aio_ctx *ctx)
 {
 	struct cifs_io_subrequest *rdata;
-	unsigned int rsize, nsegs, max_segs = INT_MAX;
+	unsigned int nsegs, max_segs = INT_MAX;
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
-	size_t cur_len, max_len;
+	size_t cur_len, max_len, rsize;
 	int rc;
 	pid_t pid;
 	struct TCP_Server_Info *server;
@@ -4451,12 +4453,13 @@ static void cifs_readahead(struct readahead_control *ractl)
 	 * Chop the readahead request up into rsize-sized read requests.
 	 */
 	while ((nr_pages = ra_pages)) {
-		unsigned int i, rsize;
+		unsigned int i;
 		struct cifs_io_subrequest *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
 		struct folio *folio;
 		pgoff_t fsize;
+		size_t rsize;
 
 		/*
 		 * Find out if we have anything cached in the range of
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index b185b07ea86b..2413006e5f39 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -217,8 +217,8 @@ smb2_get_credits(struct mid_q_entry *mid)
 }
 
 static int
-smb2_wait_mtu_credits(struct TCP_Server_Info *server, unsigned int size,
-		      unsigned int *num, struct cifs_credits *credits)
+smb2_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
+		      size_t *num, struct cifs_credits *credits)
 {
 	int rc = 0;
 	unsigned int scredits, in_flight;
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index e52967de59e6..5a69a7430ffa 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -691,8 +691,8 @@ wait_for_compound_request(struct TCP_Server_Info *server, int num,
 }
 
 int
-cifs_wait_mtu_credits(struct TCP_Server_Info *server, unsigned int size,
-		      unsigned int *num, struct cifs_credits *credits)
+cifs_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
+		      size_t *num, struct cifs_credits *credits)
 {
 	*num = size;
 	credits->value = 0;


