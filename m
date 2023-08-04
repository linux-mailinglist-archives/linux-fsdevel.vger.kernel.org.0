Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FFA770144
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHDNRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjHDNQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8CE4ED7
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rCroQnGwP6ReYl8bRAbrswP6dCB/MYi7V8I25lVTiBY=;
        b=I+y9PbgslGxbV2FdRF+SEc8Gn5quoiWCmbT87dNsr4R5cS7jFHhsV/8K3ZyCOOPMrP7szz
        XXCUHzPZKMzmSpi8fcgbSeHeU3Tf3JsZnc+8RF4jnaSEqnvObSHSJ3KzN2g751V8dJANtz
        SUQCMPwNXern4FWn2imH/nUo9LGOzuU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-fdGOafsgOcWmy19g8uwIkA-1; Fri, 04 Aug 2023 09:14:05 -0400
X-MC-Unique: fdGOafsgOcWmy19g8uwIkA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CA741C060E6;
        Fri,  4 Aug 2023 13:14:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F81B40282C;
        Fri,  4 Aug 2023 13:14:03 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 17/18] ceph: Remove CEPH_MSG_DATA_PAGES and its helpers
Date:   Fri,  4 Aug 2023 14:13:26 +0100
Message-ID: <20230804131327.2574082-18-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

---
 include/linux/ceph/messenger.h | 26 ++-------
 net/ceph/messenger.c           | 98 +---------------------------------
 net/ceph/osd_client.c          |  2 -
 3 files changed, 5 insertions(+), 121 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index a2489e266bff..f48657eef648 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -118,23 +118,14 @@ struct ceph_messenger {
 enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
 	CEPH_MSG_DATA_DATABUF,	/* data source/destination is a data buffer */
-	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
 	CEPH_MSG_DATA_ITER,	/* data source/destination is an iov_iter */
 };
 
 struct ceph_msg_data {
 	enum ceph_msg_data_type		type;
-	struct iov_iter			iter;
 	bool				release_dbuf;
-	union {
-		struct ceph_databuf	*dbuf;
-		struct {
-			struct page	**pages;
-			size_t		length;		/* total # bytes */
-			unsigned int	offset;		/* first page */
-			bool		own_pages;
-		};
-	};
+	struct iov_iter			iter;
+	struct ceph_databuf		*dbuf;
 };
 
 struct ceph_msg_data_cursor {
@@ -144,17 +135,8 @@ struct ceph_msg_data_cursor {
 	size_t			resid;		/* bytes not yet consumed */
 	int			sr_resid;	/* residual sparse_read len */
 	bool			need_crc;	/* crc update needed */
-	union {
-		struct {				/* pages */
-			unsigned int	page_offset;	/* offset in page */
-			unsigned short	page_index;	/* index in array */
-			unsigned short	page_count;	/* pages in array */
-		};
-		struct {
-			struct iov_iter		iov_iter;
-			unsigned int		lastlen;
-		};
-	};
+	struct iov_iter		iov_iter;
+	unsigned int		lastlen;
 };
 
 /*
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 5b28c27858b2..acbdd086cd7a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -710,70 +710,6 @@ void ceph_con_discard_requeued(struct ceph_connection *con, u64 reconnect_seq)
 	}
 }
 
-/*
- * For a page array, a piece comes from the first page in the array
- * that has not already been fully consumed.
- */
-static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
-					size_t length)
-{
-	struct ceph_msg_data *data = cursor->data;
-	int page_count;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
-
-	BUG_ON(!data->pages);
-	BUG_ON(!data->length);
-
-	cursor->resid = min(length, data->length);
-	page_count = calc_pages_for(data->offset, (u64)data->length);
-	cursor->page_offset = data->offset & ~PAGE_MASK;
-	cursor->page_index = 0;
-	BUG_ON(page_count > (int)USHRT_MAX);
-	cursor->page_count = (unsigned short)page_count;
-	BUG_ON(length > SIZE_MAX - cursor->page_offset);
-}
-
-static struct page *
-ceph_msg_data_pages_next(struct ceph_msg_data_cursor *cursor,
-					size_t *page_offset, size_t *length)
-{
-	struct ceph_msg_data *data = cursor->data;
-
-	BUG_ON(data->type != CEPH_MSG_DATA_PAGES);
-
-	BUG_ON(cursor->page_index >= cursor->page_count);
-	BUG_ON(cursor->page_offset >= PAGE_SIZE);
-
-	*page_offset = cursor->page_offset;
-	*length = min_t(size_t, cursor->resid, PAGE_SIZE - *page_offset);
-	return data->pages[cursor->page_index];
-}
-
-static bool ceph_msg_data_pages_advance(struct ceph_msg_data_cursor *cursor,
-						size_t bytes)
-{
-	BUG_ON(cursor->data->type != CEPH_MSG_DATA_PAGES);
-
-	BUG_ON(cursor->page_offset + bytes > PAGE_SIZE);
-
-	/* Advance the cursor page offset */
-
-	cursor->resid -= bytes;
-	cursor->page_offset = (cursor->page_offset + bytes) & ~PAGE_MASK;
-	if (!bytes || cursor->page_offset)
-		return false;	/* more bytes to process in the current page */
-
-	if (!cursor->resid)
-		return false;   /* no more data */
-
-	/* Move on to the next page; offset is already at 0 */
-
-	BUG_ON(cursor->page_index >= cursor->page_count);
-	cursor->page_index++;
-	return true;
-}
-
 static void ceph_msg_data_iter_cursor_init(struct ceph_msg_data_cursor *cursor,
 					size_t length)
 {
@@ -844,9 +780,6 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 	size_t length = cursor->total_resid;
 
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGES:
-		ceph_msg_data_pages_cursor_init(cursor, length);
-		break;
 	case CEPH_MSG_DATA_ITER:
 		ceph_msg_data_iter_cursor_init(cursor, length);
 		break;
@@ -883,9 +816,6 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	struct page *page;
 
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGES:
-		page = ceph_msg_data_pages_next(cursor, page_offset, length);
-		break;
 	case CEPH_MSG_DATA_ITER:
 		page = ceph_msg_data_iter_next(cursor, page_offset, length);
 		break;
@@ -913,9 +843,6 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 
 	BUG_ON(bytes > cursor->resid);
 	switch (cursor->data->type) {
-	case CEPH_MSG_DATA_PAGES:
-		new_piece = ceph_msg_data_pages_advance(cursor, bytes);
-		break;
 	case CEPH_MSG_DATA_ITER:
 		new_piece = ceph_msg_data_iter_advance(cursor, bytes);
 		break;
@@ -1644,12 +1571,8 @@ static struct ceph_msg_data *ceph_msg_data_add(struct ceph_msg *msg)
 
 static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 {
-	if (data->release_dbuf) {
+	if (data->release_dbuf)
 		ceph_databuf_release(data->dbuf);
-	} else if (data->type == CEPH_MSG_DATA_PAGES && data->own_pages) {
-		int num_pages = calc_pages_for(data->offset, data->length);
-		ceph_release_page_vector(data->pages, num_pages);
-	}
 }
 
 void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf)
@@ -1670,25 +1593,6 @@ void ceph_msg_data_add_databuf(struct ceph_msg *msg, struct ceph_databuf *dbuf)
 }
 EXPORT_SYMBOL(ceph_msg_data_add_databuf);
 
-void ceph_msg_data_add_pages(struct ceph_msg *msg, struct page **pages,
-			     size_t length, size_t offset, bool own_pages)
-{
-	struct ceph_msg_data *data;
-
-	BUG_ON(!pages);
-	BUG_ON(!length);
-
-	data = ceph_msg_data_add(msg);
-	data->type = CEPH_MSG_DATA_PAGES;
-	data->pages = pages;
-	data->length = length;
-	data->offset = offset & ~PAGE_MASK;
-	data->own_pages = own_pages;
-
-	msg->data_length += length;
-}
-EXPORT_SYMBOL(ceph_msg_data_add_pages);
-
 void ceph_msg_data_add_iter(struct ceph_msg *msg,
 			    struct iov_iter *iter)
 {
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 70f81a0b62c0..6fb78ae14f03 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -829,8 +829,6 @@ EXPORT_SYMBOL(osd_req_op_alloc_hint_init);
 static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 				struct ceph_osd_data *osd_data)
 {
-	u64 length = ceph_osd_data_length(osd_data);
-
 	if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
 		ceph_msg_data_add_iter(msg, &osd_data->iter);
 	} else {

