Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF36715CC5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgBMUYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44843 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727938AbgBMUYs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jwKR0CnG4/7jIZO0QFfvC7ZnXn9Hg1xkhj3v1/ri4WQ=;
        b=EfnIfyt9M18WMk1zK0jcr5fQe6654lv1LDq24r4KM8MKVSEkIzkjm5115feWndlcQW9GC7
        h+R8RBYyiw8TNTeVdYV4YT73OUCVwJ0q2URETke8RbASnF0X60oRB+j6dKfWuF+3G1vYBu
        LrGVIyjFi0GuGwieZlRueOPIyNBwtMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-wDwSgUGyMT25CZ-7sroD1w-1; Thu, 13 Feb 2020 15:24:46 -0500
X-MC-Unique: wDwSgUGyMT25CZ-7sroD1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B213107ACC7;
        Thu, 13 Feb 2020 20:24:45 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EAFE100032E;
        Thu, 13 Feb 2020 20:24:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 7/7] btrfs: Switch to page_mkwrite_check_truncate in btrfs_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:23 +0100
Message-Id: <20200213202423.23455-8-agruenba@redhat.com>
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
instead of reimplementing it here.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5b3ec93ff911..532cc4aa9222 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8441,16 +8441,15 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vm=
f)
 		goto out_noreserve;
 	}
=20
-	ret =3D VM_FAULT_NOPAGE; /* make the VM retry the fault */
 again:
 	lock_page(page);
-	size =3D i_size_read(inode);
=20
-	if ((page->mapping !=3D inode->i_mapping) ||
-	    (page_start >=3D size)) {
-		/* page got truncated out from underneath us */
+	ret2 =3D page_mkwrite_check_truncate(page, inode);
+	if (ret2 < 0) {
+		ret =3D block_page_mkwrite_return(ret2);
 		goto out_unlock;
 	}
+	zero_start =3D ret2;
 	wait_on_page_writeback(page);
=20
 	lock_extent_bits(io_tree, page_start, page_end, &cached_state);
@@ -8471,6 +8470,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 		goto again;
 	}
=20
+	size =3D i_size_read(inode);
 	if (page->index =3D=3D ((size - 1) >> PAGE_SHIFT)) {
 		reserved_space =3D round_up(size - page_start,
 					  fs_info->sectorsize);
@@ -8502,12 +8502,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf=
)
 		goto out_unlock;
 	}
=20
-	/* page is wholly or partially inside EOF */
-	if (page_start + PAGE_SIZE > size)
-		zero_start =3D offset_in_page(size);
-	else
-		zero_start =3D PAGE_SIZE;
-
 	if (zero_start !=3D PAGE_SIZE) {
 		kaddr =3D kmap(page);
 		memset(kaddr + zero_start, 0, PAGE_SIZE - zero_start);
--=20
2.24.1

