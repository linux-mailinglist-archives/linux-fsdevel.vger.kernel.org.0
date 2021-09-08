Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F45403D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352261AbhIHP7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 11:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352235AbhIHP7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631116680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbQzC7br2QR47nelEQ9R48gv7v+e1vkBF1lmmWQuUCs=;
        b=DwZOfpbSD81QT6r0KV/me9UWriopTF+mzyAoescBsp1w/HiiU0NfIfaGU75LiaRsnEu6Qt
        wnbRr5Qpr9BtfUFQEGFhM3SvuHrdHLMvVub/JgS0+NezxgbEiXsTU+sReO4fWTL3owtTmj
        ccAP7lQcHThDnxPbQ7MiwZ8426/jRc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-USkpU9pkNHKdNP2Ewc9i5w-1; Wed, 08 Sep 2021 11:57:57 -0400
X-MC-Unique: USkpU9pkNHKdNP2Ewc9i5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BECFA84A5E1;
        Wed,  8 Sep 2021 15:57:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5C85A6A8E7;
        Wed,  8 Sep 2021 15:57:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/6] afs: Add missing vnode validation checks
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, markus.suvanto@gmail.com,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 Sep 2021 16:57:53 +0100
Message-ID: <163111667354.283156.12720698333342917516.stgit@warthog.procyon.org.uk>
In-Reply-To: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
References: <163111665183.283156.17200205573146438918.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

afs_d_revalidate() should only be validating the directory entry it is
given and the directory to which that belongs; it shouldn't be validating
the inode/vnode to which that dentry points.  Besides, validation need to
be done even if we don't call afs_d_revalidate() - which might be the case
if we're starting from a file descriptor.

In order for afs_d_revalidate() to be fixed, validation points must be
added in some other places.  Certain directory operations, such as
afs_unlink(), already check this, but not all and not all file operations
either.

Note that the validation of a vnode not only checks to see if the
attributes we have are correct, but also gets a promise from the server to
notify us if that file gets changed by a third party.

Add the following checks:

 - Check the vnode we're going to make a hard link to.
 - Check the vnode we're going to move/rename.
 - Check the vnode we're going to read from.
 - Check the vnode we're going to write to.
 - Check the vnode we're going to sync.
 - Check the vnode we're going to make a mapped page writable for.

Some of these aren't strictly necessary as we're going to perform a server
operation that might get the attributes anyway from which we can determine
if something changed - though it might not get us a callback promise.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/dir.c   |   11 +++++++++++
 fs/afs/file.c  |   16 +++++++++++++++-
 fs/afs/write.c |   17 +++++++++++++++--
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ac829e63c570..a8e3ae55f1f9 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -1792,6 +1792,10 @@ static int afs_link(struct dentry *from, struct inode *dir,
 		goto error;
 	}
 
+	ret = afs_validate(vnode, op->key);
+	if (ret < 0)
+		goto error_op;
+
 	afs_op_set_vnode(op, 0, dvnode);
 	afs_op_set_vnode(op, 1, vnode);
 	op->file[0].dv_delta = 1;
@@ -1805,6 +1809,8 @@ static int afs_link(struct dentry *from, struct inode *dir,
 	op->create.reason	= afs_edit_dir_for_link;
 	return afs_do_sync_operation(op);
 
+error_op:
+	afs_put_operation(op);
 error:
 	d_drop(dentry);
 	_leave(" = %d", ret);
@@ -1989,6 +1995,11 @@ static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	if (IS_ERR(op))
 		return PTR_ERR(op);
 
+	ret = afs_validate(vnode, op->key);
+	op->error = ret;
+	if (ret < 0)
+		goto error;
+
 	afs_op_set_vnode(op, 0, orig_dvnode);
 	afs_op_set_vnode(op, 1, new_dvnode); /* May be same as orig_dvnode */
 	op->file[0].dv_delta = 1;
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6688fff14b0b..4c8d786b53e0 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -24,12 +24,13 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static void afs_readahead(struct readahead_control *ractl);
+static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
 	.release	= afs_release,
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
+	.read_iter	= afs_file_read_iter,
 	.write_iter	= afs_file_write,
 	.mmap		= afs_file_mmap,
 	.splice_read	= generic_file_splice_read,
@@ -503,3 +504,16 @@ static int afs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		vma->vm_ops = &afs_vm_ops;
 	return ret;
 }
+
+static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
+	struct afs_file *af = iocb->ki_filp->private_data;
+	int ret;
+
+	ret = afs_validate(vnode, af->key);
+	if (ret < 0)
+		return ret;
+
+	return generic_file_read_iter(iocb, iter);
+}
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 66b235266893..32a764c24284 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -807,6 +807,7 @@ int afs_writepages(struct address_space *mapping,
 ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
+	struct afs_file *af = iocb->ki_filp->private_data;
 	ssize_t result;
 	size_t count = iov_iter_count(from);
 
@@ -822,6 +823,10 @@ ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (!count)
 		return 0;
 
+	result = afs_validate(vnode, af->key);
+	if (result < 0)
+		return result;
+
 	result = generic_file_write_iter(iocb, from);
 
 	_leave(" = %zd", result);
@@ -835,13 +840,18 @@ ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
  */
 int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct inode *inode = file_inode(file);
-	struct afs_vnode *vnode = AFS_FS_I(inode);
+	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
+	struct afs_file *af = file->private_data;
+	int ret;
 
 	_enter("{%llx:%llu},{n=%pD},%d",
 	       vnode->fid.vid, vnode->fid.vnode, file,
 	       datasync);
 
+	ret = afs_validate(vnode, af->key);
+	if (ret < 0)
+		return ret;
+
 	return file_write_and_wait_range(file, start, end);
 }
 
@@ -855,11 +865,14 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
+	struct afs_file *af = file->private_data;
 	unsigned long priv;
 	vm_fault_t ret = VM_FAULT_RETRY;
 
 	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, page->index);
 
+	afs_validate(vnode, af->key);
+
 	sb_start_pagefault(inode->i_sb);
 
 	/* Wait for the page to be written to the cache before we allow it to


