Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA866D2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbjAPXKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjAPXJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:09:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B82201D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AXGRyxrMRjzyNrjh13JZHEue2NHbrOxKU/9FUI9urUA=;
        b=ZC7InEO/20UsqM0wBy8uaRx85t+cfUfrCHKKj6O1jmLnveFzqho8dHi7n1gQi+Isk/grRx
        lY0oetTprlRoXGsgwd16e5iQ5+3l9GV7rBG2R5R9TsshNy5DBt7MB1ynIja9902MGOHPtI
        56IjfJBhy+rP7LBTq/6+lK7fH0rDQ4U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-49nb9eXwM3SfZlrM7W4EnA-1; Mon, 16 Jan 2023 18:08:40 -0500
X-MC-Unique: 49nb9eXwM3SfZlrM7W4EnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE2282A59556;
        Mon, 16 Jan 2023 23:08:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A01352166B26;
        Mon, 16 Jan 2023 23:08:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 05/34] iov_iter: Change the direction macros into an enum
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:08:38 +0000
Message-ID: <167391051810.2311931.8545361041888737395.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Link: https://lore.kernel.org/r/167305161763.1521586.6593798818336440133.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344726413.2425628.317218805692680763.stgit@warthog.procyon.org.uk/ # v5
---

 include/linux/uio.h |   30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 365e26c405f2..8d0dabfcb2fe 100644
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
@@ -114,6 +116,26 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
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
 static inline bool user_backed_iter(const struct iov_iter *i)
 {
 	return i->user_backed;


