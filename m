Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B4155C651
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiF0Py4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 11:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbiF0Pyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:54:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266F91AE;
        Mon, 27 Jun 2022 08:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7616061050;
        Mon, 27 Jun 2022 15:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C4AC341CA;
        Mon, 27 Jun 2022 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656345292;
        bh=rQJtfHaBAwV7zXXVjuuuhOzb0gVtOs6s3tVC+0pew00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWzg/0Ehz1NVCYj5fxGGskJfNH4efNRaSMZmp0vNpDjQeVSAzNXfpdXdvFVnVxegA
         Y5sVZ6W8j9s9gBtbblMdMgzpvjojDNPCsEBip5uNO5HlrCc9uZYq/3gBWWb2Bv9Ow3
         lTuNxt0gWfv/AQIJfwduhL2vXhViuWClP+l1zE5K2owng921dZtL2v+F4oHz/meoha
         IQlRO3f5mTG8sIUVsF3b+l+XaTlbsPaiuFVEU6uigtO+7GUe/lonB7GHZn/SQdacAe
         GmjgfKAh8mfUWoRXhfa1lW7HnAbR6SAPmWw8/SmYNzgk5gJKkxPCqaS2hPYDAV0K9s
         D8J2sIflwgoXw==
From:   Jeff Layton <jlayton@kernel.org>
To:     xiubli@redhat.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/2] libceph: add new iov_iter-based ceph_msg_data_type and ceph_osd_data_type
Date:   Mon, 27 Jun 2022 11:54:48 -0400
Message-Id: <20220627155449.383989-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627155449.383989-1-jlayton@kernel.org>
References: <20220627155449.383989-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an iov_iter to the unions in ceph_msg_data and ceph_msg_data_cursor.
Instead of requiring a list of pages or bvecs, we can just use an
iov_iter directly, and avoid extra allocations.

We assume that the pages represented by the iter are pinned such that
they shouldn't incur page faults, which is the case for the iov_iters
created by netfs.

While working on this, Al Viro informed me that he was going to change
iov_iter_get_pages to auto-advance the iterator as that pattern is more
or less required for ITER_PIPE anyway. We emulate that here for now by
advancing in the _next op and tracking that amount in the "lastlen"
field.

In the event that _next is called twice without an intervening
_advance, we revert the iov_iter by the remaining lastlen before
calling iov_iter_get_pages.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ceph/messenger.h  |  8 ++++
 include/linux/ceph/osd_client.h |  4 ++
 net/ceph/messenger.c            | 85 +++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c           | 27 +++++++++++
 4 files changed, 124 insertions(+)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 9fd7255172ad..2eaaabbe98cb 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -123,6 +123,7 @@ enum ceph_msg_data_type {
 	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
 #endif /* CONFIG_BLOCK */
 	CEPH_MSG_DATA_BVECS,	/* data source/destination is a bio_vec array */
+	CEPH_MSG_DATA_ITER,	/* data source/destination is an iov_iter */
 };
 
 #ifdef CONFIG_BLOCK
@@ -224,6 +225,7 @@ struct ceph_msg_data {
 			bool		own_pages;
 		};
 		struct ceph_pagelist	*pagelist;
+		struct iov_iter		iter;
 	};
 };
 
@@ -248,6 +250,10 @@ struct ceph_msg_data_cursor {
 			struct page	*page;		/* page from list */
 			size_t		offset;		/* bytes from list */
 		};
+		struct {
+			struct iov_iter		iov_iter;
+			unsigned int		lastlen;
+		};
 	};
 };
 
@@ -605,6 +611,8 @@ void ceph_msg_data_add_bio(struct ceph_msg *msg, struct ceph_bio_iter *bio_pos,
 #endif /* CONFIG_BLOCK */
 void ceph_msg_data_add_bvecs(struct ceph_msg *msg,
 			     struct ceph_bvec_iter *bvec_pos);
+void ceph_msg_data_add_iter(struct ceph_msg *msg,
+			    struct iov_iter *iter);
 
 struct ceph_msg *ceph_msg_new2(int type, int front_len, int max_data_items,
 			       gfp_t flags, bool can_fail);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 6ec3cb2ac457..ef0ad534b6c5 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -108,6 +108,7 @@ enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_BIO,
 #endif /* CONFIG_BLOCK */
 	CEPH_OSD_DATA_TYPE_BVECS,
+	CEPH_OSD_DATA_TYPE_ITER,
 };
 
 struct ceph_osd_data {
@@ -131,6 +132,7 @@ struct ceph_osd_data {
 			struct ceph_bvec_iter	bvec_pos;
 			u32			num_bvecs;
 		};
+		struct iov_iter		iter;
 	};
 };
 
@@ -501,6 +503,8 @@ void osd_req_op_extent_osd_data_bvecs(struct ceph_osd_request *osd_req,
 void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
 					 unsigned int which,
 					 struct ceph_bvec_iter *bvec_pos);
+void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
+				unsigned int which, struct iov_iter *iter);
 
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6056c8f7dd4c..604f025034ab 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -964,6 +964,69 @@ static bool ceph_msg_data_pagelist_advance(struct ceph_msg_data_cursor *cursor,
 	return true;
 }
 
+static void ceph_msg_data_iter_cursor_init(struct ceph_msg_data_cursor *cursor,
+					size_t length)
+{
+	struct ceph_msg_data *data = cursor->data;
+
+	cursor->iov_iter = data->iter;
+	cursor->lastlen = 0;
+	iov_iter_truncate(&cursor->iov_iter, length);
+	cursor->resid = iov_iter_count(&cursor->iov_iter);
+}
+
+static struct page *ceph_msg_data_iter_next(struct ceph_msg_data_cursor *cursor,
+						size_t *page_offset,
+						size_t *length)
+{
+	struct page *page;
+	ssize_t len;
+
+	if (cursor->lastlen)
+		iov_iter_revert(&cursor->iov_iter, cursor->lastlen);
+
+	len = iov_iter_get_pages(&cursor->iov_iter, &page, PAGE_SIZE,
+				 1, page_offset);
+	BUG_ON(len < 0);
+
+	cursor->lastlen = len;
+
+	/*
+	 * FIXME: Al Viro says that he will soon change iov_iter_get_pages
+	 * to auto-advance the iterator. Emulate that here for now.
+	 */
+	iov_iter_advance(&cursor->iov_iter, len);
+
+	/*
+	 * FIXME: The assumption is that the pages represented by the iov_iter
+	 * 	  are pinned, with the references held by the upper-level
+	 * 	  callers, or by virtue of being under writeback. Eventually,
+	 * 	  we'll get an iov_iter_get_pages variant that doesn't take page
+	 * 	  refs. Until then, just put the page ref.
+	 */
+	VM_BUG_ON_PAGE(!PageWriteback(page) && page_count(page) < 2, page);
+	put_page(page);
+
+	*length = min_t(size_t, len, cursor->resid);
+	return page;
+}
+
+static bool ceph_msg_data_iter_advance(struct ceph_msg_data_cursor *cursor,
+					size_t bytes)
+{
+	BUG_ON(bytes > cursor->resid);
+	cursor->resid -= bytes;
+
+	if (bytes < cursor->lastlen) {
+		cursor->lastlen -= bytes;
+	} else {
+		iov_iter_advance(&cursor->iov_iter, bytes - cursor->lastlen);
+		cursor->lastlen = 0;
+	}
+
+	return cursor->resid;
+}
+
 /*
  * Message data is handled (sent or received) in pieces, where each
  * piece resides on a single page.  The network layer might not
@@ -991,6 +1054,9 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 	case CEPH_MSG_DATA_BVECS:
 		ceph_msg_data_bvecs_cursor_init(cursor, length);
 		break;
+	case CEPH_MSG_DATA_ITER:
+		ceph_msg_data_iter_cursor_init(cursor, length);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		/* BUG(); */
@@ -1038,6 +1104,9 @@ struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 	case CEPH_MSG_DATA_BVECS:
 		page = ceph_msg_data_bvecs_next(cursor, page_offset, length);
 		break;
+	case CEPH_MSG_DATA_ITER:
+		page = ceph_msg_data_iter_next(cursor, page_offset, length);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		page = NULL;
@@ -1076,6 +1145,9 @@ void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor, size_t bytes)
 	case CEPH_MSG_DATA_BVECS:
 		new_piece = ceph_msg_data_bvecs_advance(cursor, bytes);
 		break;
+	case CEPH_MSG_DATA_ITER:
+		new_piece = ceph_msg_data_iter_advance(cursor, bytes);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		BUG();
@@ -1874,6 +1946,19 @@ void ceph_msg_data_add_bvecs(struct ceph_msg *msg,
 }
 EXPORT_SYMBOL(ceph_msg_data_add_bvecs);
 
+void ceph_msg_data_add_iter(struct ceph_msg *msg,
+			    struct iov_iter *iter)
+{
+	struct ceph_msg_data *data;
+
+	data = ceph_msg_data_add(msg);
+	data->type = CEPH_MSG_DATA_ITER;
+	data->iter = *iter;
+
+	msg->data_length += iov_iter_count(&data->iter);
+}
+EXPORT_SYMBOL(ceph_msg_data_add_iter);
+
 /*
  * construct a new message with given type, size
  * the new msg has a ref count of 1.
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 75761537c644..2a7e46524e71 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -171,6 +171,13 @@ static void ceph_osd_data_bvecs_init(struct ceph_osd_data *osd_data,
 	osd_data->num_bvecs = num_bvecs;
 }
 
+static void ceph_osd_iter_init(struct ceph_osd_data *osd_data,
+			       struct iov_iter *iter)
+{
+	osd_data->type = CEPH_OSD_DATA_TYPE_ITER;
+	osd_data->iter = *iter;
+}
+
 static struct ceph_osd_data *
 osd_req_op_raw_data_in(struct ceph_osd_request *osd_req, unsigned int which)
 {
@@ -264,6 +271,22 @@ void osd_req_op_extent_osd_data_bvec_pos(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bvec_pos);
 
+/**
+ * osd_req_op_extent_osd_iter - Set up an operation with an iterator buffer
+ * @osd_req: The request to set up
+ * @which: ?
+ * @iter: The buffer iterator
+ */
+void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
+				unsigned int which, struct iov_iter *iter)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
+	ceph_osd_iter_init(osd_data, iter);
+}
+EXPORT_SYMBOL(osd_req_op_extent_osd_iter);
+
 static void osd_req_op_cls_request_info_pagelist(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
@@ -346,6 +369,8 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 #endif /* CONFIG_BLOCK */
 	case CEPH_OSD_DATA_TYPE_BVECS:
 		return osd_data->bvec_pos.iter.bi_size;
+	case CEPH_OSD_DATA_TYPE_ITER:
+		return iov_iter_count(&osd_data->iter);
 	default:
 		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
 		return 0;
@@ -954,6 +979,8 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 #endif
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BVECS) {
 		ceph_msg_data_add_bvecs(msg, &osd_data->bvec_pos);
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_ITER) {
+		ceph_msg_data_add_iter(msg, &osd_data->iter);
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
 	}
-- 
2.36.1

