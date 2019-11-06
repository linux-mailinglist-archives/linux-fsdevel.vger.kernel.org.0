Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6826DF1E32
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2019 20:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfKFTEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Nov 2019 14:04:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53930 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727410AbfKFTEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573067048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mWTSqOOTt3Dk2ZPvesbfsapc/5QXTzyY0nl7eR6Zqto=;
        b=H5IPwGRGnMVmVXMXRnJYf9j+trPtCon5B6RnCIR06KlMitfBCrTH5cIPnQgYV2gZTPYF7E
        Qpx89o2dBgVxZydikS9UGJMyz8+DNGXrrwgtMPg9QUrVlgwI//9zlpxeJUc5E8o4k7sYXi
        wcQr1+hL05e24tO3Qc2yJ9QAVLxWEMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-y9o0P_5YOvyqcIpOWoYuDA-1; Wed, 06 Nov 2019 14:04:05 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C63D800C72;
        Wed,  6 Nov 2019 19:04:03 +0000 (UTC)
Received: from max.com (unknown [10.40.206.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD991001B35;
        Wed,  6 Nov 2019 19:04:02 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     linux-xfs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
Date:   Wed,  6 Nov 2019 20:04:00 +0100
Message-Id: <20191106190400.20969-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: y9o0P_5YOvyqcIpOWoYuDA-1
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
 fs/iomap/buffered-io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..a30ea7ecb790 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1040,20 +1040,19 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,=
 const struct iomap_ops *ops)
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
+=09if (offset > size - PAGE_SIZE)
 =09=09length =3D offset_in_page(size);
 =09else
 =09=09length =3D PAGE_SIZE;
=20
-=09offset =3D page_offset(page);
 =09while (length > 0) {
 =09=09ret =3D iomap_apply(inode, offset, length,
 =09=09=09=09IOMAP_WRITE | IOMAP_FAULT, ops, page,
--=20
2.20.1

