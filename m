Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5C135A22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgAINa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:30:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729894AbgAINa5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=byrKCEhaLJHpefyXaNaEhPVEwhIGAC7cpoxRKOr8+YE=;
        b=TSvTswvd10/+xli19g8JXGnqsTE76qq+u050oZW66EjsRSFkr/f9mbdVvJPjncVVyETWZR
        VVjmJoDwwzoPc6Vi4ZiAERJesUpfeYfZyvmVqpsS4R6EJPsuP9Q4dEnp2EymZzsWMd3Kgd
        6DQK0hil4esMp1BSKENyG44bElhEWdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-2dklwYbTOA-lvC6xpC-whg-1; Thu, 09 Jan 2020 08:30:55 -0500
X-MC-Unique: 2dklwYbTOA-lvC6xpC-whg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E0771005514;
        Thu,  9 Jan 2020 13:30:54 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22DFF60C88;
        Thu,  9 Jan 2020 13:30:52 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
Date:   Thu,  9 Jan 2020 14:30:42 +0100
Message-Id: <20200109133045.382356-3-cmaiolino@redhat.com>
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the direct usage of ->bmap method by a bmap() call.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 44a3ce1e4ce4..1dc97f2d6201 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -396,7 +396,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retr=
ieval *op,
 	struct cachefiles_object *object;
 	struct cachefiles_cache *cache;
 	struct inode *inode;
-	sector_t block0, block;
+	sector_t block;
 	unsigned shift;
 	int ret;
=20
@@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retr=
ieval *op,
=20
 	inode =3D d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
=20
 	/* calculate the shift required to use bmap */
@@ -428,12 +427,14 @@ int cachefiles_read_or_alloc_page(struct fscache_re=
trieval *op,
 	 *   enough for this as it doesn't indicate errors, but it's all we've
 	 *   got for the moment
 	 */
-	block0 =3D page->index;
-	block0 <<=3D shift;
+	block =3D page->index;
+	block <<=3D shift;
+
+	ret =3D bmap(inode, &block);
+	ASSERT(ret < 0);
=20
-	block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
 	_debug("%llx -> %llx",
-	       (unsigned long long) block0,
+	       (unsigned long long) (page->index << shift),
 	       (unsigned long long) block);
=20
 	if (block) {
@@ -711,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_ret=
rieval *op,
=20
 	inode =3D d_backing_inode(object->backer);
 	ASSERT(S_ISREG(inode->i_mode));
-	ASSERT(inode->i_mapping->a_ops->bmap);
 	ASSERT(inode->i_mapping->a_ops->readpages);
=20
 	/* calculate the shift required to use bmap */
@@ -728,7 +728,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_ret=
rieval *op,
=20
 	ret =3D space ? -ENODATA : -ENOBUFS;
 	list_for_each_entry_safe(page, _n, pages, lru) {
-		sector_t block0, block;
+		sector_t block;
=20
 		/* we assume the absence or presence of the first block is a
 		 * good enough indication for the page as a whole
@@ -736,13 +736,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_r=
etrieval *op,
 		 *   good enough for this as it doesn't indicate errors, but
 		 *   it's all we've got for the moment
 		 */
-		block0 =3D page->index;
-		block0 <<=3D shift;
+		block =3D page->index;
+		block <<=3D shift;
+
+		ret =3D bmap(inode, &block);
+		ASSERT(!ret);
=20
-		block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping,
-						      block0);
 		_debug("%llx -> %llx",
-		       (unsigned long long) block0,
+		       (unsigned long long) (page->index << shift),
 		       (unsigned long long) block);
=20
 		if (block) {
--=20
2.23.0

