Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19E1415CC56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgBMUYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38151 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727609AbgBMUYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnIwQ36PAuYJKj04cVkizzS1/0imgTxxjR+ggRy2CGk=;
        b=RfmlOiBMIMlR1ulk8APC4lt1hGWEJQmbS7xFmUCI3yHdMfD5wc0iGiTUij7BydaovbZKzF
        og0QG5FgnFqBIVM3K2ounWmcbyp3hnyEyN0vimbLGtXyzUk1FS1PBkoSGx7wMhda7lEuZ8
        K+3U3IwxOCYiBNO77HnY/f2Ahn6BndI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-FIkxOjaKMXOlws7gnFuW0w-1; Thu, 13 Feb 2020 15:24:35 -0500
X-MC-Unique: FIkxOjaKMXOlws7gnFuW0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72345800EB8;
        Thu, 13 Feb 2020 20:24:33 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FC911001B0B;
        Thu, 13 Feb 2020 20:24:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 2/7] fs: Switch to page_mkwrite_check_truncate in block_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:18 +0100
Message-Id: <20200213202423.23455-3-agruenba@redhat.com>
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
---
 fs/buffer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b8d28370cfd7..31a9a02878a2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2499,23 +2499,13 @@ int block_page_mkwrite(struct vm_area_struct *vma=
, struct vm_fault *vmf,
 	struct page *page =3D vmf->page;
 	struct inode *inode =3D file_inode(vma->vm_file);
 	unsigned long end;
-	loff_t size;
 	int ret;
=20
 	lock_page(page);
-	size =3D i_size_read(inode);
-	if ((page->mapping !=3D inode->i_mapping) ||
-	    (page_offset(page) > size)) {
-		/* We overload EFAULT to mean page got truncated */
-		ret =3D -EFAULT;
+	ret =3D page_mkwrite_check_truncate(page, inode);
+	if (ret < 0)
 		goto out_unlock;
-	}
-
-	/* page is wholly or partially inside EOF */
-	if (((page->index + 1) << PAGE_SHIFT) > size)
-		end =3D size & ~PAGE_MASK;
-	else
-		end =3D PAGE_SIZE;
+	end =3D ret;
=20
 	ret =3D __block_write_begin(page, 0, end, get_block);
 	if (!ret)
--=20
2.24.1

