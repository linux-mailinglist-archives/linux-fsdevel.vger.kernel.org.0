Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6517115CC59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBMUYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 15:24:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727926AbgBMUYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 15:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581625481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vlxo1nx7BalMfC2VSU4oKmB2UgE3wRf52tiqPzNnaGY=;
        b=RI87dwrXRJIhpMHOI4UQv3g5tkvQJAryZHDfy1QKS4eS1l7XMNGlrZVJDAivvjPS3Vxpol
        TsW1JASLhfLDFD6zdE38uw5Sa+zPq9JEQrFV1HIfx06W21WXCzYDR+fjqpO2rsi3/w8P/9
        SFH3thaB1ciSZLGxg2yQhc9NegOLIA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-86J8RduONh-1EMQ_820JFA-1; Thu, 13 Feb 2020 15:24:39 -0500
X-MC-Unique: 86J8RduONh-1EMQ_820JFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C25F800D50;
        Thu, 13 Feb 2020 20:24:38 +0000 (UTC)
Received: from max.home.com (ovpn-204-60.brq.redhat.com [10.40.204.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E7F11001B0B;
        Thu, 13 Feb 2020 20:24:35 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Richard Weinberger <richard@nod.at>
Cc:     linux-fsdevel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 4/7] ext4: Switch to page_mkwrite_check_truncate in ext4_page_mkwrite
Date:   Thu, 13 Feb 2020 21:24:20 +0100
Message-Id: <20200213202423.23455-5-agruenba@redhat.com>
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
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1305b810c44a..4e00a6014fb3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5902,13 +5902,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf=
)
 {
 	struct vm_area_struct *vma =3D vmf->vma;
 	struct page *page =3D vmf->page;
-	loff_t size;
 	unsigned long len;
 	int err;
 	vm_fault_t ret;
 	struct file *file =3D vma->vm_file;
 	struct inode *inode =3D file_inode(file);
-	struct address_space *mapping =3D inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
 	int retries =3D 0;
@@ -5938,18 +5936,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf=
)
 	}
=20
 	lock_page(page);
-	size =3D i_size_read(inode);
-	/* Page got truncated from under us? */
-	if (page->mapping !=3D mapping || page_offset(page) > size) {
+	err =3D page_mkwrite_check_truncate(page, inode);
+	if (err < 0) {
 		unlock_page(page);
-		ret =3D VM_FAULT_NOPAGE;
-		goto out;
+		goto out_ret;
 	}
+	len =3D err;
=20
-	if (page->index =3D=3D size >> PAGE_SHIFT)
-		len =3D size & ~PAGE_MASK;
-	else
-		len =3D PAGE_SIZE;
 	/*
 	 * Return if we have all the buffers mapped. This avoids the need to do
 	 * journal_start/journal_stop which can block and take a long time
--=20
2.24.1

