Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F39118519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 11:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfLJK31 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 05:29:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23212 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727502AbfLJK31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 05:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575973765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jMWFdNn7fGRj5bb8TeBaOUbpmWFLdAqVHKxYwniQW98=;
        b=V3T2OjrQWePLI/8TwX3p8kUTFGhMMJDu1zjI10oYGPPohkA97ecXvkZIi6cpJxnX0PgoSz
        YzK/JeVunGQdnER/6dp05ZCNvauNBN9RvrxSBR0Kwh/aCs6R+bLrfL0uH30gGU/kcbtuph
        GDEcwcAKRV4NV/TSFsmXmW6mKW7yfjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-xB3QapzcOfqmzqUbwfKu9g-1; Tue, 10 Dec 2019 05:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC637183B72B;
        Tue, 10 Dec 2019 10:29:21 +0000 (UTC)
Received: from max.com (ovpn-205-78.brq.redhat.com [10.40.205.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E385160568;
        Tue, 10 Dec 2019 10:29:17 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
Subject: [PATCH] iomap: Export iomap_page_create and iomap_set_range_uptodate
Date:   Tue, 10 Dec 2019 11:29:16 +0100
Message-Id: <20191210102916.842-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: xB3QapzcOfqmzqUbwfKu9g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These two functions are needed by filesystems for converting inline
("stuffed") inodes into non-inline inodes.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/buffered-io.c | 6 ++++--
 include/linux/iomap.h  | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 828444e14d09..e8f6d7ba4e3c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -41,7 +41,7 @@ static inline struct iomap_page *to_iomap_page(struct pag=
e *page)
=20
 static struct bio_set iomap_ioend_bioset;
=20
-static struct iomap_page *
+struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
 {
 =09struct iomap_page *iop =3D to_iomap_page(page);
@@ -64,6 +64,7 @@ iomap_page_create(struct inode *inode, struct page *page)
 =09SetPagePrivate(page);
 =09return iop;
 }
+EXPORT_SYMBOL(iomap_page_create);
=20
 static void
 iomap_page_release(struct page *page)
@@ -164,7 +165,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigne=
d off, unsigned len)
 =09spin_unlock_irqrestore(&iop->uptodate_lock, flags);
 }
=20
-static void
+void
 iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 {
 =09if (PageError(page))
@@ -175,6 +176,7 @@ iomap_set_range_uptodate(struct page *page, unsigned of=
f, unsigned len)
 =09else
 =09=09SetPageUptodate(page);
 }
+EXPORT_SYMBOL(iomap_set_range_uptodate);
=20
 static void
 iomap_read_finish(struct iomap_page *iop, struct page *page)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..b00f9bc396b1 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -13,6 +13,7 @@
 struct address_space;
 struct fiemap_extent_info;
 struct inode;
+struct iomap_page;
 struct iomap_writepage_ctx;
 struct iov_iter;
 struct kiocb;
@@ -152,6 +153,10 @@ loff_t iomap_apply(struct inode *inode, loff_t pos, lo=
ff_t length,
 =09=09unsigned flags, const struct iomap_ops *ops, void *data,
 =09=09iomap_actor_t actor);
=20
+struct iomap_page *iomap_page_create(struct inode *inode, struct page *pag=
e);
+void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned le=
n);
+
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *fro=
m,
 =09=09const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
--=20
2.20.1

