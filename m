Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D00107BB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 00:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKVXxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 18:53:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40353 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKVXxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574466830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOGkY4foGqbdnpZbcMiOQpwjMwXw9GwTN5p3QDTd77E=;
        b=FWeJYkywRLw89xbD1pdwqkyHuBW6Yskgb5LGaWgmydLkzced8TWtIg4LHx/AxcUl6Qz0Af
        4g1eBfSKhvgvtgGsHAk5xaQGUSdERD1MgIkw0rPECIY4LH/EkxdOyAcUeCmyqFVkJPWF7E
        jGf+cWKXGYRgZY0cf9pjqYFIPwXmaTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-ccp0u32WPuykWAMXE7w2NQ-1; Fri, 22 Nov 2019 18:53:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EB3B107ACE3;
        Fri, 22 Nov 2019 23:53:46 +0000 (UTC)
Received: from max.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA83B5C1BB;
        Fri, 22 Nov 2019 23:53:42 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>, cluster-devel@redhat.com,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [RFC PATCH 3/3] gfs2: Rework read and page fault locking
Date:   Sat, 23 Nov 2019 00:53:24 +0100
Message-Id: <20191122235324.17245-4-agruenba@redhat.com>
In-Reply-To: <20191122235324.17245-1-agruenba@redhat.com>
References: <20191122235324.17245-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ccp0u32WPuykWAMXE7w2NQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the glock lock taking code from the ->readpage and ->readpages
address space operations to the ->read_iter file and ->fault vm
operations.

To avoid taking the lock even when an operation can be satisfied out of
the page cache, try the operation without taking the lock first.  When
that fails, take the lock and repeat the opeation.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/aops.c | 36 ++++++---------------------
 fs/gfs2/file.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index b9fe975d7625..4aa6c952eb90 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -515,26 +515,10 @@ static int __gfs2_readpage(void *file, struct page *p=
age)
=20
 static int gfs2_readpage(struct file *file, struct page *page)
 {
-=09struct address_space *mapping =3D page->mapping;
-=09struct gfs2_inode *ip =3D GFS2_I(mapping->host);
-=09struct gfs2_holder gh;
 =09int error;
=20
-=09unlock_page(page);
-=09gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-=09error =3D gfs2_glock_nq(&gh);
-=09if (unlikely(error))
-=09=09goto out;
-=09error =3D AOP_TRUNCATED_PAGE;
-=09lock_page(page);
-=09if (page->mapping =3D=3D mapping && !PageUptodate(page))
-=09=09error =3D __gfs2_readpage(file, page);
-=09else
-=09=09unlock_page(page);
-=09gfs2_glock_dq(&gh);
-out:
-=09gfs2_holder_uninit(&gh);
-=09if (error && error !=3D AOP_TRUNCATED_PAGE)
+=09error =3D __gfs2_readpage(file, page);
+=09if (error)
 =09=09lock_page(page);
 =09return error;
 }
@@ -602,18 +586,12 @@ static int gfs2_readpages(struct file *file, struct a=
ddress_space *mapping,
 =09struct inode *inode =3D mapping->host;
 =09struct gfs2_inode *ip =3D GFS2_I(inode);
 =09struct gfs2_sbd *sdp =3D GFS2_SB(inode);
-=09struct gfs2_holder gh;
-=09int ret;
+=09int ret =3D 0;
=20
-=09gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
-=09ret =3D gfs2_glock_nq(&gh);
-=09if (unlikely(ret))
-=09=09goto out_uninit;
-=09if (!gfs2_is_stuffed(ip))
-=09=09ret =3D mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
-=09gfs2_glock_dq(&gh);
-out_uninit:
-=09gfs2_holder_uninit(&gh);
+=09if (gfs2_is_stuffed(ip))
+=09=09goto out;
+=09ret =3D mpage_readpages(mapping, pages, nr_pages, gfs2_block_map);
+out:
 =09if (unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags)))
 =09=09ret =3D -EIO;
 =09return ret;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 997b326247e2..207d39996353 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -524,8 +524,34 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *v=
mf)
 =09return block_page_mkwrite_return(ret);
 }
=20
+static vm_fault_t gfs2_fault(struct vm_fault *vmf)
+{
+=09struct inode *inode =3D file_inode(vmf->vma->vm_file);
+=09struct gfs2_inode *ip =3D GFS2_I(inode);
+=09struct gfs2_holder gh;
+=09vm_fault_t ret;
+=09int err;
+
+=09vmf->flags |=3D FAULT_FLAG_CACHED;
+=09ret =3D filemap_fault(vmf);
+=09vmf->flags &=3D ~FAULT_FLAG_CACHED;
+=09if (!(ret & VM_FAULT_RETRY))
+=09=09return ret;
+=09gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+=09err =3D gfs2_glock_nq(&gh);
+=09if (err) {
+=09=09ret =3D block_page_mkwrite_return(err);
+=09=09goto out_uninit;
+=09}
+=09ret =3D filemap_fault(vmf);
+=09gfs2_glock_dq(&gh);
+out_uninit:
+=09gfs2_holder_uninit(&gh);
+=09return ret;
+}
+
 static const struct vm_operations_struct gfs2_vm_ops =3D {
-=09.fault =3D filemap_fault,
+=09.fault =3D gfs2_fault,
 =09.map_pages =3D filemap_map_pages,
 =09.page_mkwrite =3D gfs2_page_mkwrite,
 };
@@ -778,15 +804,51 @@ static ssize_t gfs2_file_direct_write(struct kiocb *i=
ocb, struct iov_iter *from)
=20
 static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to=
)
 {
+=09struct gfs2_inode *ip;
+=09struct gfs2_holder gh;
+=09size_t written =3D 0;
 =09ssize_t ret;
=20
+=09gfs2_holder_mark_uninitialized(&gh);
 =09if (iocb->ki_flags & IOCB_DIRECT) {
 =09=09ret =3D gfs2_file_direct_read(iocb, to);
 =09=09if (likely(ret !=3D -ENOTBLK))
 =09=09=09return ret;
 =09=09iocb->ki_flags &=3D ~IOCB_DIRECT;
 =09}
-=09return generic_file_read_iter(iocb, to);
+=09iocb->ki_flags |=3D IOCB_CACHED;
+=09ret =3D generic_file_read_iter(iocb, to);
+=09iocb->ki_flags &=3D ~IOCB_CACHED;
+=09if (ret >=3D 0) {
+=09=09if (!iov_iter_count(to))
+=09=09=09return ret;
+=09=09written =3D ret;
+=09} else {
+=09=09switch(ret) {
+=09=09case -EAGAIN:
+=09=09=09if (iocb->ki_flags & IOCB_NOWAIT)
+=09=09=09=09return ret;
+=09=09=09break;
+=09=09case -ECANCELED:
+=09=09=09break;
+=09=09default:
+=09=09=09return ret;
+=09=09}
+=09}
+=09ip =3D GFS2_I(iocb->ki_filp->f_mapping->host);
+=09gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+=09ret =3D gfs2_glock_nq(&gh);
+=09if (ret)
+=09=09goto out_uninit;
+=09ret =3D generic_file_read_iter(iocb, to);
+=09if (ret > 0)
+=09=09written +=3D ret;
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_glock_dq(&gh);
+out_uninit:
+=09if (gfs2_holder_initialized(&gh))
+=09=09gfs2_holder_uninit(&gh);
+=09return written ? written : ret;
 }
=20
 /**
--=20
2.20.1

