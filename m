Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7631110B243
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfK0PSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 10:18:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25311 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726698AbfK0PSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:18:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574867910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MKRMqYZcMSPOI1ZGGK/kSwrsQZTCaWDdryNtYrwk8A4=;
        b=MTwMRqNu+MeR4QaIT5ScdTi3FY3q4TIbuScZCw7D1Q/tdgkXeTHJIgVCon5MbH5HY3Smfk
        kwpurQunGpQ/srUNR5GqysQLb5Cd1g5u2UjmQ4/O/Ads1THgydWuoyLyKy2gV5YnApSEIr
        nAjbrGSucYE0aWx0G5+mXCDgafrGAco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-GM3JGt2IPoeXL76p6qeU6w-1; Wed, 27 Nov 2019 10:18:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA8C11007271;
        Wed, 27 Nov 2019 15:18:22 +0000 (UTC)
Received: from max.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 477BF1001DE1;
        Wed, 27 Nov 2019 15:18:14 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org
Subject: [PATCH] fs: Fix page_mkwrite off-by-one errors
Date:   Wed, 27 Nov 2019 16:18:11 +0100
Message-Id: <20191127151811.9229-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: GM3JGt2IPoeXL76p6qeU6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a check in block_page_mkwrite meant to determine whether an offset
is within the inode size.  This error has spread to several filesystems
and to iomap_page_mkwrite, so fix those instances as well.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

---

This patch has a trivial conflict with commit "iomap: Fix overflow in
iomap_page_mkwrite" in Darrick's iomap pull request for 5.5:

  https://lore.kernel.org/lkml/20191125190907.GN6219@magnolia/
---
 fs/buffer.c            | 2 +-
 fs/ceph/addr.c         | 2 +-
 fs/ext4/inode.c        | 2 +-
 fs/f2fs/file.c         | 2 +-
 fs/iomap/buffered-io.c | 2 +-
 fs/ubifs/file.c        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 86a38b979323..152d391858d4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2465,7 +2465,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, st=
ruct vm_fault *vmf,
 =09lock_page(page);
 =09size =3D i_size_read(inode);
 =09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_offset(page) > size)) {
+=09    (page_offset(page) >=3D size)) {
 =09=09/* We overload EFAULT to mean page got truncated */
 =09=09ret =3D -EFAULT;
 =09=09goto out_unlock;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7ab616601141..9fa0729ece41 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1575,7 +1575,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *=
vmf)
 =09do {
 =09=09lock_page(page);
=20
-=09=09if ((off > size) || (page->mapping !=3D inode->i_mapping)) {
+=09=09if ((off >=3D size) || (page->mapping !=3D inode->i_mapping)) {
 =09=09=09unlock_page(page);
 =09=09=09ret =3D VM_FAULT_NOPAGE;
 =09=09=09break;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 516faa280ced..6dd4efe2fb63 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6224,7 +6224,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 =09lock_page(page);
 =09size =3D i_size_read(inode);
 =09/* Page got truncated from under us? */
-=09if (page->mapping !=3D mapping || page_offset(page) > size) {
+=09if (page->mapping !=3D mapping || page_offset(page) >=3D size) {
 =09=09unlock_page(page);
 =09=09ret =3D VM_FAULT_NOPAGE;
 =09=09goto out;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 29bc0a542759..3436be01af45 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -71,7 +71,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *v=
mf)
 =09down_read(&F2FS_I(inode)->i_mmap_sem);
 =09lock_page(page);
 =09if (unlikely(page->mapping !=3D inode->i_mapping ||
-=09=09=09page_offset(page) > i_size_read(inode) ||
+=09=09=09page_offset(page) >=3D i_size_read(inode) ||
 =09=09=09!PageUptodate(page))) {
 =09=09unlock_page(page);
 =09=09err =3D -EFAULT;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..d454dbab5133 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1041,7 +1041,7 @@ vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf, c=
onst struct iomap_ops *ops)
 =09lock_page(page);
 =09size =3D i_size_read(inode);
 =09if ((page->mapping !=3D inode->i_mapping) ||
-=09    (page_offset(page) > size)) {
+=09    (page_offset(page) >=3D size)) {
 =09=09/* We overload EFAULT to mean page got truncated */
 =09=09ret =3D -EFAULT;
 =09=09goto out_unlock;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index cd52585c8f4f..ca0148ec77e6 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1564,7 +1564,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fau=
lt *vmf)
=20
 =09lock_page(page);
 =09if (unlikely(page->mapping !=3D inode->i_mapping ||
-=09=09     page_offset(page) > i_size_read(inode))) {
+=09=09     page_offset(page) >=3D i_size_read(inode))) {
 =09=09/* Page got truncated out from underneath us */
 =09=09goto sigbus;
 =09}
--=20
2.20.1

