Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 070F510685C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKVIxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:53:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23502 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726248AbfKVIxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmwN6nJWv5k8szIzmN3/bjbE0iYtiPVnxJ/OtUqIXeo=;
        b=b8sVm2yAfFFfp5rYoZU0dFJHmXyJJI8ByZyjnwMZ2/JRM0/dLRswyOmAmlnwoni0XFJJDV
        Me3TEFoczuDC/xOpjhJlT48bsVCdME5HLdEAFWwIjYHnzFvhjhSLz+MGxIKqm3Ua+t0HsZ
        IXZhgl4jsVoNGbBUNj83i/yljklzXAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-DFKTzBSrOuOZHI1kVzBI4g-1; Fri, 22 Nov 2019 03:53:29 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 513DE593A0;
        Fri, 22 Nov 2019 08:53:28 +0000 (UTC)
Received: from orion.redhat.com (unknown [10.40.205.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10E91608F3;
        Fri, 22 Nov 2019 08:53:26 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, darrick.wong@oracle.com, sandeen@sandeen.net
Subject: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
Date:   Fri, 22 Nov 2019 09:53:17 +0100
Message-Id: <20191122085320.124560-3-cmaiolino@redhat.com>
In-Reply-To: <20191122085320.124560-1-cmaiolino@redhat.com>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DFKTzBSrOuOZHI1kVzBI4g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the direct usage of ->bmap method by a bmap() call.

Changelog:
=09V6:
=09=09- ASSERT only if filesystem does not support bmap() to
=09=09  match the original logic
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/cachefiles/rdwr.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 44a3ce1e4ce4..1dc97f2d6201 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -396,7 +396,7 @@ int cachefiles_read_or_alloc_page(struct fscache_retrie=
val *op,
 =09struct cachefiles_object *object;
 =09struct cachefiles_cache *cache;
 =09struct inode *inode;
-=09sector_t block0, block;
+=09sector_t block;
 =09unsigned shift;
 =09int ret;
=20
@@ -412,7 +412,6 @@ int cachefiles_read_or_alloc_page(struct fscache_retrie=
val *op,
=20
 =09inode =3D d_backing_inode(object->backer);
 =09ASSERT(S_ISREG(inode->i_mode));
-=09ASSERT(inode->i_mapping->a_ops->bmap);
 =09ASSERT(inode->i_mapping->a_ops->readpages);
=20
 =09/* calculate the shift required to use bmap */
@@ -428,12 +427,14 @@ int cachefiles_read_or_alloc_page(struct fscache_retr=
ieval *op,
 =09 *   enough for this as it doesn't indicate errors, but it's all we've
 =09 *   got for the moment
 =09 */
-=09block0 =3D page->index;
-=09block0 <<=3D shift;
+=09block =3D page->index;
+=09block <<=3D shift;
+
+=09ret =3D bmap(inode, &block);
+=09ASSERT(ret < 0);
=20
-=09block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
 =09_debug("%llx -> %llx",
-=09       (unsigned long long) block0,
+=09       (unsigned long long) (page->index << shift),
 =09       (unsigned long long) block);
=20
 =09if (block) {
@@ -711,7 +712,6 @@ int cachefiles_read_or_alloc_pages(struct fscache_retri=
eval *op,
=20
 =09inode =3D d_backing_inode(object->backer);
 =09ASSERT(S_ISREG(inode->i_mode));
-=09ASSERT(inode->i_mapping->a_ops->bmap);
 =09ASSERT(inode->i_mapping->a_ops->readpages);
=20
 =09/* calculate the shift required to use bmap */
@@ -728,7 +728,7 @@ int cachefiles_read_or_alloc_pages(struct fscache_retri=
eval *op,
=20
 =09ret =3D space ? -ENODATA : -ENOBUFS;
 =09list_for_each_entry_safe(page, _n, pages, lru) {
-=09=09sector_t block0, block;
+=09=09sector_t block;
=20
 =09=09/* we assume the absence or presence of the first block is a
 =09=09 * good enough indication for the page as a whole
@@ -736,13 +736,14 @@ int cachefiles_read_or_alloc_pages(struct fscache_ret=
rieval *op,
 =09=09 *   good enough for this as it doesn't indicate errors, but
 =09=09 *   it's all we've got for the moment
 =09=09 */
-=09=09block0 =3D page->index;
-=09=09block0 <<=3D shift;
+=09=09block =3D page->index;
+=09=09block <<=3D shift;
+
+=09=09ret =3D bmap(inode, &block);
+=09=09ASSERT(!ret);
=20
-=09=09block =3D inode->i_mapping->a_ops->bmap(inode->i_mapping,
-=09=09=09=09=09=09      block0);
 =09=09_debug("%llx -> %llx",
-=09=09       (unsigned long long) block0,
+=09=09       (unsigned long long) (page->index << shift),
 =09=09       (unsigned long long) block);
=20
 =09=09if (block) {
--=20
2.23.0

