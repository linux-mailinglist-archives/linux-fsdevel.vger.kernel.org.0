Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE59660AE1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jan 2023 01:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbjAGAfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 19:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbjAGAfL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81CB848ED
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 16:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673051625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGWJ4LMGHChPk//xt2k7uAo8nBEnHMnbPGaKlxdycgE=;
        b=NhM059CE0EDv9F1x+ey8OQ9y1f44NpSDLSWFMzOXcknTbpzxJNHRHZujfCAMIU8VhWRqrE
        HvTvddOS0SqqjuEXfGPs7VSw+KATspUVu6JO4sIMk5HYMzMPMKcSOyroRZ+VIIdnHsTd+p
        OxUPiGLoQ3K/O1jscKJ3WLtCdTZJw3M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-VzApHa_0PpqWIvDSAziNAg-1; Fri, 06 Jan 2023 19:33:40 -0500
X-MC-Unique: VzApHa_0PpqWIvDSAziNAg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E455101A52E;
        Sat,  7 Jan 2023 00:33:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 63AB4492B06;
        Sat,  7 Jan 2023 00:33:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 1/7] iov_iter: Change the direction macros into an enum
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Jan 2023 00:33:37 +0000
Message-ID: <167305161763.1521586.6593798818336440133.stgit@warthog.procyon.org.uk>
In-Reply-To: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
References: <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change the ITER_SOURCE and ITER_DEST direction macros into an enum and
provide three new helper functions:

 iov_iter_dir() - returns the iterator direction
 iov_iter_is_dest() - returns true if it's an ITER_DEST iterator
 iov_iter_is_source() - returns true if it's an ITER_SOURCE iterator

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
---

 include/linux/uio.h |   32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 9f158238edba..4b0f4a773d90 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,8 +29,10 @@ enum iter_type {
 	ITER_UBUF,
 };
 
-#define ITER_SOURCE	1	// == WRITE
-#define ITER_DEST	0	// == READ
+enum iter_dir {
+	ITER_DEST	= 0,	// == READ
+	ITER_SOURCE	= 1,	// == WRITE
+} __mode(byte);
 
 struct iov_iter_state {
 	size_t iov_offset;
@@ -39,9 +41,9 @@ struct iov_iter_state {
 };
 
 struct iov_iter {
-	u8 iter_type;
+	enum iter_type iter_type __mode(byte);
 	bool nofault;
-	bool data_source;
+	enum iter_dir data_source;
 	bool user_backed;
 	union {
 		size_t iov_offset;
@@ -114,9 +116,29 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline enum iter_dir iov_iter_dir(const struct iov_iter *i)
+{
+	return i->data_source;
+}
+
+static inline bool iov_iter_is_source(const struct iov_iter *i)
+{
+	return iov_iter_dir(i) == ITER_SOURCE; /* ie. WRITE */
+}
+
+static inline bool iov_iter_is_dest(const struct iov_iter *i)
+{
+	return iov_iter_dir(i) == ITER_DEST; /* ie. READ */
+}
+
+static inline bool iov_iter_dir_valid(enum iter_dir direction)
+{
+	return direction == ITER_DEST || direction == ITER_SOURCE;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
-	return i->data_source ? WRITE : READ;
+	return iov_iter_dir(i) == ITER_SOURCE ? WRITE : READ;
 }
 
 static inline bool user_backed_iter(const struct iov_iter *i)


