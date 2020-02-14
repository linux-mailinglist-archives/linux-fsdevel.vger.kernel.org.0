Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C84615F779
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 21:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgBNUKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 15:10:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26635 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387674AbgBNUKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581711030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5MUR2fYcYNZELAsIimq6QK7pZxouJvx3DcRiy23f4FE=;
        b=ArwThhZtnMSrKyTPdejl5dFr3NHSB2xtNQ0sYYANvCNg6j7ZiAOwygxLTPUYvbi/sUyKgr
        w+P0YLFk7as2cUvCu+AGEtHNxveANfVt0CzEp3sXmZR5UVXRWec86QcicHy2jFh4HvjGhy
        IcnMtVEt5Q89ChkuzugFTympOUmsvuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-f02SJm4DMfuxmanYA5ACnA-1; Fri, 14 Feb 2020 15:10:27 -0500
X-MC-Unique: f02SJm4DMfuxmanYA5ACnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D706713E2;
        Fri, 14 Feb 2020 20:10:25 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4CC05C115;
        Fri, 14 Feb 2020 20:10:22 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kbuild test robot <lkp@intel.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2] fs: Un-inline page_mkwrite_check_truncate
Date:   Fri, 14 Feb 2020 21:10:20 +0100
Message-Id: <20200214201020.52527-1-agruenba@redhat.com>
In-Reply-To: <20200213202423.23455-2-agruenba@redhat.com>
References: <20200213202423.23455-1-agruenba@redhat.com> <20200213202423.23455-2-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Per review comments from Jan and Ted, un-inline page_mkwrite_check_trunca=
te
and move it to mm/filemap.c.  This function doesn't seem worth inlining.

v2: Define page_mkwrite_check_truncate outside the CONFIG_MMU guard in
mm/filemap.c to allow block_page_mkwrite to use this helper on
ARCH=3Dm68k.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
---
 include/linux/pagemap.h | 28 +---------------------------
 mm/filemap.c            | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ccb14b6a16b5..6c9c5b88924d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -636,32 +636,6 @@ static inline unsigned long dir_pages(struct inode *=
inode)
 			       PAGE_SHIFT;
 }
=20
-/**
- * page_mkwrite_check_truncate - check if page was truncated
- * @page: the page to check
- * @inode: the inode to check the page against
- *
- * Returns the number of bytes in the page up to EOF,
- * or -EFAULT if the page was truncated.
- */
-static inline int page_mkwrite_check_truncate(struct page *page,
-					      struct inode *inode)
-{
-	loff_t size =3D i_size_read(inode);
-	pgoff_t index =3D size >> PAGE_SHIFT;
-	int offset =3D offset_in_page(size);
-
-	if (page->mapping !=3D inode->i_mapping)
-		return -EFAULT;
-
-	/* page is wholly inside EOF */
-	if (page->index < index)
-		return PAGE_SIZE;
-	/* page is wholly past EOF */
-	if (page->index > index || !offset)
-		return -EFAULT;
-	/* page is partially inside EOF */
-	return offset;
-}
+int page_mkwrite_check_truncate(struct page *page, struct inode *inode);
=20
 #endif /* _LINUX_PAGEMAP_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..eac4f7e84823 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2305,6 +2305,34 @@ generic_file_read_iter(struct kiocb *iocb, struct =
iov_iter *iter)
 }
 EXPORT_SYMBOL(generic_file_read_iter);
=20
+/**
+ * page_mkwrite_check_truncate - check if page was truncated
+ * @page: the page to check
+ * @inode: the inode to check the page against
+ *
+ * Returns the number of bytes in the page up to EOF,
+ * or -EFAULT if the page was truncated.
+ */
+int page_mkwrite_check_truncate(struct page *page, struct inode *inode)
+{
+	loff_t size =3D i_size_read(inode);
+	pgoff_t index =3D size >> PAGE_SHIFT;
+	int offset =3D offset_in_page(size);
+
+	if (page->mapping !=3D inode->i_mapping)
+		return -EFAULT;
+
+	/* page is wholly inside EOF */
+	if (page->index < index)
+		return PAGE_SIZE;
+	/* page is wholly past EOF */
+	if (page->index > index || !offset)
+		return -EFAULT;
+	/* page is partially inside EOF */
+	return offset;
+}
+EXPORT_SYMBOL(page_mkwrite_check_truncate);
+
 #ifdef CONFIG_MMU
 #define MMAP_LOTSAMISS  (100)
 /*
--=20
2.24.1

