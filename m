Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38904F4D3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581765AbiDEXkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573554AbiDETWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:22:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632473E0DB;
        Tue,  5 Apr 2022 12:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AB56B81F6B;
        Tue,  5 Apr 2022 19:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0503FC385A1;
        Tue,  5 Apr 2022 19:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186437;
        bh=gFp0s2+yOcXsxdx+8FwxESNn106vn66cOvnAIMvKYsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsI1yGO5xbYAMRP+i5E4Cubrv3Faw4rfQwY+423rZ6IyILXWi/UVtF9IXBaZ74/cY
         YZEUqMyQk4EMV9V3S3jSi2IAM7DqaPSbNcDfW0Ejr/z/0dJdfQAQ0ixi+kvNt514kE
         bgAahZ/++1hP+6TyivNQ8X4bEpOxYz4r8ptcfSeE+kHI56pwrnkiLWYe1MXkJcO6Xu
         VSlJPqyYzNm+VMd+4EQX7NUfEiruPnZ+46ahMdmpGqjGjqmaCijz55i2ea1VlGKnjF
         jyTCJPP6/RZac+VTbaqI8Kv149wFgV6jpJ8trlqdSOYGunrAt5aD4ANDjKiu8jyDVw
         Q3NtEK2o+UCZg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 06/59] libceph: add sparse read support to msgr1
Date:   Tue,  5 Apr 2022 15:19:37 -0400
Message-Id: <20220405192030.178326-7-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add 2 new fields to ceph_connection_v1_info to track the necessary info
in sparse reads. Skip initializing the cursor for a sparse read.

Break out read_partial_message_section into a wrapper around a new
read_partial_message_chunk function that doesn't zero out the crc first.

Add new helper functions to drive receiving into the destinations
provided by the sparse_read state machine.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ceph/messenger.h |  4 ++
 net/ceph/messenger_v1.c        | 98 +++++++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 7f09a4213834..f4adbfee56d5 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -337,6 +337,10 @@ struct ceph_connection_v1_info {
 
 	int in_base_pos;     /* bytes read */
 
+	/* sparse reads */
+	struct kvec in_sr_kvec; /* current location to receive into */
+	u64 in_sr_len;		/* amount of data in this extent */
+
 	/* message in temps */
 	u8 in_tag;           /* protocol control byte */
 	struct ceph_msg_header in_hdr;
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index 6b014eca3a13..bf385e458a01 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -160,9 +160,9 @@ static size_t sizeof_footer(struct ceph_connection *con)
 
 static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 {
-	/* Initialize data cursor */
-
-	ceph_msg_data_cursor_init(&msg->cursor, msg, data_len);
+	/* Initialize data cursor if it's not a sparse read */
+	if (!msg->sparse_read)
+		ceph_msg_data_cursor_init(&msg->cursor, msg, data_len);
 }
 
 /*
@@ -967,9 +967,9 @@ static void process_ack(struct ceph_connection *con)
 	prepare_read_tag(con);
 }
 
-static int read_partial_message_section(struct ceph_connection *con,
-					struct kvec *section,
-					unsigned int sec_len, u32 *crc)
+static int read_partial_message_chunk(struct ceph_connection *con,
+				      struct kvec *section,
+				      unsigned int sec_len, u32 *crc)
 {
 	int ret, left;
 
@@ -985,11 +985,91 @@ static int read_partial_message_section(struct ceph_connection *con,
 		section->iov_len += ret;
 	}
 	if (section->iov_len == sec_len)
-		*crc = crc32c(0, section->iov_base, section->iov_len);
+		*crc = crc32c(*crc, section->iov_base, section->iov_len);
 
 	return 1;
 }
 
+static inline int read_partial_message_section(struct ceph_connection *con,
+					       struct kvec *section,
+					       unsigned int sec_len, u32 *crc)
+{
+	*crc = 0;
+	return read_partial_message_chunk(con, section, sec_len, crc);
+}
+
+static int read_sparse_msg_extent(struct ceph_connection *con, u32 *crc)
+{
+	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
+	bool do_bounce = ceph_test_opt(from_msgr(con->msgr), RXBOUNCE);
+
+	if (do_bounce && unlikely(!con->bounce_page)) {
+		con->bounce_page = alloc_page(GFP_NOIO);
+		if (!con->bounce_page) {
+			pr_err("failed to allocate bounce page\n");
+			return -ENOMEM;
+		}
+	}
+
+	while (cursor->sr_resid > 0) {
+		struct page *page, *rpage;
+		size_t off, len;
+		int ret;
+
+		page = ceph_msg_data_next(cursor, &off, &len, NULL);
+		rpage = do_bounce ? con->bounce_page : page;
+
+		/* clamp to what remains in extent */
+		len = min_t(int, len, cursor->sr_resid);
+		ret = ceph_tcp_recvpage(con->sock, rpage, (int)off, len);
+		if (ret <= 0)
+			return ret;
+		*crc = ceph_crc32c_page(*crc, rpage, off, ret);
+		ceph_msg_data_advance(cursor, (size_t)ret);
+		cursor->sr_resid -= ret;
+		if (do_bounce)
+			memcpy_page(page, off, rpage, off, ret);
+	}
+	return 1;
+}
+
+static int read_sparse_msg_data(struct ceph_connection *con)
+{
+	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
+	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
+	u32 crc = 0;
+	int ret = 1;
+
+	if (do_datacrc)
+		crc = con->in_data_crc;
+
+	do {
+		if (con->v1.in_sr_kvec.iov_base)
+			ret = read_partial_message_chunk(con,
+							 &con->v1.in_sr_kvec,
+							 con->v1.in_sr_len,
+							 &crc);
+		else if (cursor->sr_resid > 0)
+			ret = read_sparse_msg_extent(con, &crc);
+
+		if (ret <= 0) {
+			if (do_datacrc)
+				con->in_data_crc = crc;
+			return ret;
+		}
+
+		memset(&con->v1.in_sr_kvec, 0, sizeof(con->v1.in_sr_kvec));
+		ret = con->ops->sparse_read(con, cursor,
+				(char **)&con->v1.in_sr_kvec.iov_base);
+		con->v1.in_sr_len = ret;
+	} while (ret > 0);
+
+	if (do_datacrc)
+		con->in_data_crc = crc;
+
+	return ret < 0 ? ret : 1;	/* must return > 0 to indicate success */
+}
+
 static int read_partial_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
@@ -1180,7 +1260,9 @@ static int read_partial_message(struct ceph_connection *con)
 		if (!m->num_data_items)
 			return -EIO;
 
-		if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE))
+		if (m->sparse_read)
+			ret = read_sparse_msg_data(con);
+		else if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE))
 			ret = read_partial_msg_data_bounce(con);
 		else
 			ret = read_partial_msg_data(con);
-- 
2.35.1

