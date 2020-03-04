Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E217960A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgCDRAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:00:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33247 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729995AbgCDQ7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ljm8bumTyb/4W3KUJ3oIqUfg3wZGMAKiuOFC8bfSc0U=;
        b=ddEzXkXbkvi57QGeUzg0NXrEJ8TFVZTKdc4kfXK2POC5coLvwIQeFzRB6w+2smp5iHwMQ7
        UsBgiqk7v9gX1hwsR5D8t8AzTSanWIr1Vf75ihUQAT2WYJhzOh2TNcwONSG+deuGB711A1
        MIxDtuGHugaM6n/cn7CuvJj/6K1Iwsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-ygJdFtY3NkStZ0nPmlTODw-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: ygJdFtY3NkStZ0nPmlTODw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 459D3DB65;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EF7273893;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 78406225814; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com
Subject: [PATCH 14/20] fuse,dax: add DAX mmap support
Date:   Wed,  4 Mar 2020 11:58:39 -0500
Message-Id: <20200304165845.3081-15-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

Add DAX mmap() support.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/file.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9effdd3dc6d6..303496e6617f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2870,10 +2870,15 @@ static const struct vm_operations_struct fuse_fil=
e_vm_ops =3D {
 	.page_mkwrite	=3D fuse_page_mkwrite,
 };
=20
+static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
 static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff =3D file->private_data;
=20
+	/* DAX mmap is superior to direct_io mmap */
+	if (IS_DAX(file_inode(file)))
+		return fuse_dax_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
@@ -2892,9 +2897,63 @@ static int fuse_file_mmap(struct file *file, struc=
t vm_area_struct *vma)
 	return 0;
 }
=20
+static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
+				   enum page_entry_size pe_size, bool write)
+{
+	vm_fault_t ret;
+	struct inode *inode =3D file_inode(vmf->vma->vm_file);
+	struct super_block *sb =3D inode->i_sb;
+	pfn_t pfn;
+
+	if (write)
+		sb_start_pagefault(sb);
+
+	ret =3D dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
+
+	if (ret & VM_FAULT_NEEDDSYNC)
+		ret =3D dax_finish_sync_fault(vmf, pe_size, pfn);
+
+	if (write)
+		sb_end_pagefault(sb);
+
+	return ret;
+}
+
+static vm_fault_t fuse_dax_fault(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE,
+				vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_huge_fault(struct vm_fault *vmf,
+			       enum page_entry_size pe_size)
+{
+	return __fuse_dax_fault(vmf, pe_size, vmf->flags & FAULT_FLAG_WRITE);
+}
+
+static vm_fault_t fuse_dax_page_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static vm_fault_t fuse_dax_pfn_mkwrite(struct vm_fault *vmf)
+{
+	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+}
+
+static const struct vm_operations_struct fuse_dax_vm_ops =3D {
+	.fault		=3D fuse_dax_fault,
+	.huge_fault	=3D fuse_dax_huge_fault,
+	.page_mkwrite	=3D fuse_dax_page_mkwrite,
+	.pfn_mkwrite	=3D fuse_dax_pfn_mkwrite,
+};
+
 static int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return -EINVAL; /* TODO */
+	file_accessed(file);
+	vma->vm_ops =3D &fuse_dax_vm_ops;
+	vma->vm_flags |=3D VM_MIXEDMAP | VM_HUGEPAGE;
+	return 0;
 }
=20
 static int convert_fuse_file_lock(struct fuse_conn *fc,
@@ -3940,6 +3999,7 @@ static const struct file_operations fuse_file_opera=
tions =3D {
 	.release	=3D fuse_release,
 	.fsync		=3D fuse_fsync,
 	.lock		=3D fuse_file_lock,
+	.get_unmapped_area =3D thp_get_unmapped_area,
 	.flock		=3D fuse_file_flock,
 	.splice_read	=3D generic_file_splice_read,
 	.splice_write	=3D iter_file_splice_write,
--=20
2.20.1

