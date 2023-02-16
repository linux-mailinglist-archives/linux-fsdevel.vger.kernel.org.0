Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89998699F44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 22:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBPVts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 16:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjBPVt2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7044C3E1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676584110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gp2W96yfCpLFU4rVrbJwG/yzMjTMitm55rNRmKmTZrE=;
        b=TkB81QY+3l2GhvqWEkL50p3kIqAPkXNFQJ2syCUjjv0KmYDmCGlsP3ZGmmws5DAlkSklOt
        FASKFGTeak5GRPMdmrYoZhTQODyJR+HSZSd3MkniJ7//MQyKA++uQOBxwbEbDhr1krcvjA
        FWIgcMZV3LNDf+wbJIGZgsf0+aL9xU0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-t-XLGBKJN1OaorYTO7C7CA-1; Thu, 16 Feb 2023 16:48:25 -0500
X-MC-Unique: t-XLGBKJN1OaorYTO7C7CA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2CB738123AF;
        Thu, 16 Feb 2023 21:48:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BB9E492B15;
        Thu, 16 Feb 2023 21:48:22 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 06/17] splice: Export filemap/direct_splice_read()
Date:   Thu, 16 Feb 2023 21:47:34 +0000
Message-Id: <20230216214745.3985496-7-dhowells@redhat.com>
In-Reply-To: <20230216214745.3985496-1-dhowells@redhat.com>
References: <20230216214745.3985496-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filemap_splice_read() and direct_splice_read() should be exported.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-cifs@vger.kernel.org
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/splice.c  | 1 +
 mm/filemap.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 4c6332854b63..928c7be2f318 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -373,6 +373,7 @@ ssize_t direct_splice_read(struct file *in, loff_t *ppos,
 	kfree(bv);
 	return ret;
 }
+EXPORT_SYMBOL(direct_splice_read);
 
 /**
  * generic_file_splice_read - splice data from file to a pipe
diff --git a/mm/filemap.c b/mm/filemap.c
index 8c7b135c8e23..570f86578f7c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2969,6 +2969,7 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 
 	return total_spliced ? total_spliced : error;
 }
+EXPORT_SYMBOL(filemap_splice_read);
 
 static inline loff_t folio_seek_hole_data(struct xa_state *xas,
 		struct address_space *mapping, struct folio *folio,

