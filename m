Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4234AF1E22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKFTCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 14:02:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727411AbfKFTCr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573066966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kxdmMHHUCiwD411i+Ffa8FviPIgnmJlk/z+ts63ZbWE=;
        b=SRRkmXEwJNvL5e7dhX6bb/gdDYlKNsZnJKlx9z7uiExWrY7Y3NnHiuJ1DpfF1ghq0dFx8d
        aip312DtXPHLrIaTUmxXw9lXDFXXU17g8xYkq7BapJpqFND1ZJQ/TjtoUrB+ZnPZVegG9E
        xPd3GWQQS7JILyhz6j4aoIyxQthTHUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-7sL43AozOKCWRjovtywQqw-1; Wed, 06 Nov 2019 14:02:44 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41131005500;
        Wed,  6 Nov 2019 19:02:43 +0000 (UTC)
Received: from max.com (unknown [10.40.206.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7A5160872;
        Wed,  6 Nov 2019 19:02:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] fs: Fix overflow in block_page_mkwrite
Date:   Wed,  6 Nov 2019 20:02:39 +0100
Message-Id: <20191106190239.20860-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7sL43AozOKCWRjovtywQqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On architectures where ssize_t is wider than pgoff_t, the expression
((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
offset, which we already compute here anyway.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..da3f33b70249 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2459,21 +2459,21 @@ int block_page_mkwrite(struct vm_area_struct *vma, =
struct vm_fault *vmf,
 =09struct page *page =3D vmf->page;
 =09struct inode *inode =3D file_inode(vma->vm_file);
 =09unsigned long end;
-=09loff_t size;
+=09loff_t offset, size;
 =09int ret;
=20
 =09lock_page(page);
 =09size =3D i_size_read(inode);
-=09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_offset(page) > size)) {
+=09offset =3D page_offset(page);
+=09if (page->mapping !=3D inode->i_mapping || offset > size) {
 =09=09/* We overload EFAULT to mean page got truncated */
 =09=09ret =3D -EFAULT;
 =09=09goto out_unlock;
 =09}
=20
 =09/* page is wholly or partially inside EOF */
-=09if (((page->index + 1) << PAGE_SHIFT) > size)
-=09=09end =3D size & ~PAGE_MASK;
+=09if (offset > size - PAGE_SIZE)
+=09=09end =3D offset_in_page(size);
 =09else
 =09=09end =3D PAGE_SIZE;
=20
--=20
2.20.1

