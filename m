Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3BC15CC5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBMUYr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727926AbgBMUYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IAY2w5m5A+eioJ5oHT8xTyzWNhcSLI/RhwQbztvcyaU=;
        b=HYCDVheKxGdL9m5BcY+2+ZRHllBhTknns8i4KMQKL58SiP6zrK6XhjIUry333zfl6yzzgZ
        TcvvIYsIyjGuDs8T2W7Bsq74a2xCFmeEX9Ip3Baoun6pwcB6PyG81Ai3t3N6lfmuTbYCDx
        QGhCys3Gjo6W23Kq5Wa9paIwwoND2Fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-WCmtbwjDOI-o6W5Sps6d4g-1; Thu, 13 Feb 2020 15:24:42 -0500
X-MC-Unique: WCmtbwjDOI-o6W5Sps6d4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1F36801E6C;
        Thu, 13 Feb 2020 20:24:40 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8601510027A4;
        Thu, 13 Feb 2020 20:24:38 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/7] f2fs: Switch to page_mkwrite_check_truncate in f2fs_vm_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:21 +0100
Message-Id: <20200213202423.23455-6-agruenba@redhat.com>
In-Reply-To: <20200213202423.23455-1-agruenba@redhat.com>
References: <20200213202423.23455-1-agruenba@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the "page has been truncated" logic in page_mkwrite_check_truncate
instead of reimplementing it here.  Other than with the existing code,
fail with -EFAULT / VM_FAULT_NOPAGE when page_offset(page) =3D=3D size he=
re
as well, as should be expected.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0d4da644df3b..0d5ac7a92230 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -52,7 +52,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault =
*vmf)
 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 	struct dnode_of_data dn;
 	bool need_alloc =3D true;
-	int err =3D 0;
+	int offset, err =3D 0;
=20
 	if (unlikely(f2fs_cp_error(sbi))) {
 		err =3D -EIO;
@@ -91,11 +91,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_faul=
t *vmf)
 	file_update_time(vmf->vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
-	if (unlikely(page->mapping !=3D inode->i_mapping ||
-			page_offset(page) > i_size_read(inode) ||
-			!PageUptodate(page))) {
+	offset =3D -EFAULT;
+	if (likely(PageUptodate(page)))
+		offset =3D page_mkwrite_check_truncate(page, inode);
+	if (unlikely(offset < 0)) {
 		unlock_page(page);
-		err =3D -EFAULT;
+		err =3D offset;
 		goto out_sem;
 	}
=20
@@ -124,14 +125,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fau=
lt *vmf)
 	if (PageMappedToDisk(page))
 		goto out_sem;
=20
-	/* page is wholly or partially inside EOF */
-	if (((loff_t)(page->index + 1) << PAGE_SHIFT) >
-						i_size_read(inode)) {
-		loff_t offset;
-
-		offset =3D i_size_read(inode) & ~PAGE_MASK;
+	if (offset !=3D PAGE_SIZE)
 		zero_user_segment(page, offset, PAGE_SIZE);
-	}
 	set_page_dirty(page);
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
--=20
2.24.1

