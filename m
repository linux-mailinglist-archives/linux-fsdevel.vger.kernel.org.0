Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09E107BAD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2019 00:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKVXxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 18:53:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33463 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726705AbfKVXxm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 18:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574466821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvAGjXKzggaIcjor/eU/2AoEyqgwEZJGtnOKutcJ+6k=;
        b=EuBBMcP3R9KIehvnddA7lDPlfznXcpOCwY1T4dFsmK56aSaOB9pme7DAMJiwx7Y1ZOyHnr
        jdL/ewlnEgAN745LCCd55cp5c/OSItcY4y6oVwQ4NYnswvjkUxHw3wrdkriiWo1hITJXi/
        /obLBqa2cs9XyUyOWp0nidt88QRviIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-ZgnG4BKfPseZDtuQScqjhQ-1; Fri, 22 Nov 2019 18:53:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73D761005509;
        Fri, 22 Nov 2019 23:53:38 +0000 (UTC)
Received: from max.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E21FE5C1BB;
        Fri, 22 Nov 2019 23:53:34 +0000 (UTC)
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
Subject: [RFC PATCH 1/3] fs: Add IOCB_CACHED flag for generic_file_read_iter
Date:   Sat, 23 Nov 2019 00:53:22 +0100
Message-Id: <20191122235324.17245-2-agruenba@redhat.com>
In-Reply-To: <20191122235324.17245-1-agruenba@redhat.com>
References: <20191122235324.17245-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ZgnG4BKfPseZDtuQScqjhQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an IOCB_CACHED flag which indicates to generic_file_read_iter that
it should only look at the page cache, without triggering any filesystem
I/O for the actual request or for readahead.  When filesystem I/O would
be triggered, an error code should be returned instead.

This allows the caller to perform a tentative read out of the page
cache, and to retry the read after taking the necessary steps when the
requested pages are not cached.

When readahead would be triggered, we return -ECANCELED instead of
-EAGAIN.  This allows to distinguish attempted readheads from attempted
reads (with IOCB_NOWAIT).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 include/linux/fs.h |  1 +
 mm/filemap.c       | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..4ca5e2885452 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -314,6 +314,7 @@ enum rw_hint {
 #define IOCB_SYNC=09=09(1 << 5)
 #define IOCB_WRITE=09=09(1 << 6)
 #define IOCB_NOWAIT=09=09(1 << 7)
+#define IOCB_CACHED=09=09(1 << 8)
=20
 struct kiocb {
 =09struct file=09=09*ki_filp;
diff --git a/mm/filemap.c b/mm/filemap.c
index 85b7d087eb45..024ff0b5fcb6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2046,7 +2046,7 @@ static ssize_t generic_file_buffered_read(struct kioc=
b *iocb,
=20
 =09=09page =3D find_get_page(mapping, index);
 =09=09if (!page) {
-=09=09=09if (iocb->ki_flags & IOCB_NOWAIT)
+=09=09=09if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED))
 =09=09=09=09goto would_block;
 =09=09=09page_cache_sync_readahead(mapping,
 =09=09=09=09=09ra, filp,
@@ -2056,12 +2056,16 @@ static ssize_t generic_file_buffered_read(struct ki=
ocb *iocb,
 =09=09=09=09goto no_cached_page;
 =09=09}
 =09=09if (PageReadahead(page)) {
+=09=09=09if (iocb->ki_flags & IOCB_CACHED) {
+=09=09=09=09error =3D -ECANCELED;
+=09=09=09=09goto out;
+=09=09=09}
 =09=09=09page_cache_async_readahead(mapping,
 =09=09=09=09=09ra, filp, page,
 =09=09=09=09=09index, last_index - index);
 =09=09}
 =09=09if (!PageUptodate(page)) {
-=09=09=09if (iocb->ki_flags & IOCB_NOWAIT) {
+=09=09=09if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED)) {
 =09=09=09=09put_page(page);
 =09=09=09=09goto would_block;
 =09=09=09}
@@ -2266,6 +2270,13 @@ static ssize_t generic_file_buffered_read(struct kio=
cb *iocb,
  *
  * This is the "read_iter()" routine for all filesystems
  * that can use the page cache directly.
+ *
+ * In the IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN should=
 be
+ * returned if completing the request would require I/O; this does not pre=
vent
+ * readahead.  The IOCB_CACHED flag indicates that -EAGAIN should be retur=
ned
+ * as under the IOCB_NOWAIT flag, and that -ECANCELED should be returned w=
hen
+ * readhead would be triggered.
+ *
  * Return:
  * * number of bytes copied, even for partial reads
  * * negative error code if nothing was read
@@ -2286,7 +2297,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov=
_iter *iter)
 =09=09loff_t size;
=20
 =09=09size =3D i_size_read(inode);
-=09=09if (iocb->ki_flags & IOCB_NOWAIT) {
+=09=09if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_CACHED)) {
 =09=09=09if (filemap_range_has_page(mapping, iocb->ki_pos,
 =09=09=09=09=09=09   iocb->ki_pos + count - 1))
 =09=09=09=09return -EAGAIN;
--=20
2.20.1

