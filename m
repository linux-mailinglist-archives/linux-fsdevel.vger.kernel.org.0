Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB714179AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbhIXRVR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344146AbhIXRUO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6DQnexwniQ/NKSS0cOEbgPfeH+oSvyPP6EWb64AW6A=;
        b=aa/OIEapE4cegS3uCH9XI1d5VvEVDVoidX2KDxKDvMHndjZr+EqVUD6WOdxll2G+5wMw9E
        y/KUvvXzhHtTBNgToXnQpg2Zdt4gzN9/54Hh3o2QOa4E16Z9jOWodGyCCNEripVG3cvGwR
        cm9GFXBTruOJ7y1bMOAGjLv1g06UUe4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-x1QTI5CYO5S4aviDytbwsg-1; Fri, 24 Sep 2021 13:18:37 -0400
X-MC-Unique: x1QTI5CYO5S4aviDytbwsg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EBCA84A5E1;
        Fri, 24 Sep 2021 17:18:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90BDA5D9DD;
        Fri, 24 Sep 2021 17:18:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 4/9] Introduce IOCB_SWAP kiocb flag to trigger REQ_SWAP
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com, dhowells@redhat.com,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:32 +0100
Message-ID: <163250391274.2330363.16176856646027970865.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an IOCB_SWAP flag for the kiocb struct such that the REQ_SWAP
will get set on lower level operation structures in generic code.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Darrick J. Wong <djwong@kernel.org>
cc: linux-xfs@vger.kernel.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 fs/direct-io.c      |    2 ++
 include/linux/bio.h |    2 ++
 include/linux/fs.h  |    1 +
 3 files changed, 5 insertions(+)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..76eec0a68fa4 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1216,6 +1216,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
 		dio->op_flags |= REQ_HIPRI;
+	if (iocb->ki_flags & IOCB_SWAP)
+		dio->op_flags |= REQ_SWAP;
 
 	/*
 	 * For AIO O_(D)SYNC writes we need to defer completions to a workqueue
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 00952e92eae1..b01133727494 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -787,6 +787,8 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 	bio->bi_opf |= REQ_HIPRI;
 	if (!is_sync_kiocb(kiocb))
 		bio->bi_opf |= REQ_NOWAIT;
+	if (kiocb->ki_flags & IOCB_SWAP)
+		bio->bi_opf |= REQ_SWAP;
 }
 
 struct bio *blk_next_bio(struct bio *bio, unsigned int nr_pages, gfp_t gfp);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c909ca6c0eb6..c20f4423e2f1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -321,6 +321,7 @@ enum rw_hint {
 #define IOCB_NOIO		(1 << 20)
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
+#define IOCB_SWAP		(1 << 22)	/* Operation on a swapfile */
 
 struct kiocb {
 	struct file		*ki_filp;


