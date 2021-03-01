Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF1328C22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhCASqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:46:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240522AbhCASnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614624116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vJTPoKRc5hjsGEMzZZfHDz964+M69nLcLHy1/PRWxRw=;
        b=RXUjdab5b+JOOkTi8qBCM+KO2AQeuUxzdpTXgvjtqzcThiJ5RiK0vIH+detgWpUauX9u5a
        sC3SDKcYy1pIKWMSgvGzvBA2oHIbazIW22VPtAgNSdy1E1rpbvBdxafcXS+kCWjm0KKoAF
        eK+PJmddEzIN5PrIe8XeIoxsNoCQqtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-g5aF24abMy6ZMYV4ZNQt9w-1; Mon, 01 Mar 2021 13:41:53 -0500
X-MC-Unique: g5aF24abMy6ZMYV4ZNQt9w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EAA110051A8;
        Mon,  1 Mar 2021 18:41:52 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D342F19D6C;
        Mon,  1 Mar 2021 18:41:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Ludovic Pouzenc <bugreports@pouzenc.fr>
Subject: [PATCH resend 4/4] vboxsf: Add support for the atomic_open directory-inode op
Date:   Mon,  1 Mar 2021 19:41:43 +0100
Message-Id: <20210301184143.29878-5-hdegoede@redhat.com>
In-Reply-To: <20210301184143.29878-1-hdegoede@redhat.com>
References: <20210301184143.29878-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Opening a new file is done in 2 steps on regular filesystems:

1. Call the create inode-op on the parent-dir to create an inode
to hold the meta-data related to the file.
2. Call the open file-op to get a handle for the file.

vboxsf however does not really use disk-backed inodes because it
is based on passing through file-related system-calls through to
the hypervisor. So both steps translate to an open(2) call being
passed through to the hypervisor. With the handle returned by
the first call immediately being closed again.

Making 2 open calls for a single open(..., O_CREATE, ...) calls
has 2 problems:

a) It is not really efficient.
b) It actually breaks some apps.

An example of b) is doing a git clone inside a vboxsf mount.
When git clone tries to create a tempfile to store the pak
files which is downloading the following happens:

1. vboxsf_dir_mkfile() gets called with a mode of 0444 and succeeds.
2. vboxsf_file_open() gets called with file->f_flags containing
O_RDWR. When the host is a Linux machine this fails because doing
a open(..., O_RDWR) on a file which exists and has mode 0444 results
in an -EPERM error.

Other network-filesystems and fuse avoid the problem of needing to
pass 2 open() calls to the other side by using the atomic_open
directory-inode op.

This commit fixes git clone not working inside a vboxsf mount,
by adding support for the atomic_open directory-inode op.
As an added bonus this should also make opening new files faster.

The atomic_open implementation is modelled after the atomic_open
implementations from the 9p and fuse code.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Reported-by: Ludovic Pouzenc <bugreports@pouzenc.fr>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/dir.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index caabc7a446ef..07422996a93d 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -308,6 +308,53 @@ static int vboxsf_dir_mkdir(struct user_namespace *mnt_userns,
 	return vboxsf_dir_create(parent, dentry, mode, true, true, NULL);
 }
 
+static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
+				  struct file *file, unsigned int flags, umode_t mode)
+{
+	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
+	struct vboxsf_handle *sf_handle;
+	struct dentry *res = NULL;
+	u64 handle;
+	int err;
+
+	if (d_in_lookup(dentry)) {
+		res = vboxsf_dir_lookup(parent, dentry, 0);
+		if (IS_ERR(res))
+			return PTR_ERR(res);
+
+		if (res)
+			dentry = res;
+	}
+
+	/* Only creates */
+	if (!(flags & O_CREAT) || d_really_is_positive(dentry))
+		return finish_no_open(file, res);
+
+	err = vboxsf_dir_create(parent, dentry, mode, false, flags & O_EXCL, &handle);
+	if (err)
+		goto out;
+
+	sf_handle = vboxsf_create_sf_handle(d_inode(dentry), handle, SHFL_CF_ACCESS_READWRITE);
+	if (IS_ERR(sf_handle)) {
+		vboxsf_close(sbi->root, handle);
+		err = PTR_ERR(sf_handle);
+		goto out;
+	}
+
+	err = finish_open(file, dentry, generic_file_open);
+	if (err) {
+		/* This also closes the handle passed to vboxsf_create_sf_handle() */
+		vboxsf_release_sf_handle(d_inode(dentry), sf_handle);
+		goto out;
+	}
+
+	file->private_data = sf_handle;
+	file->f_mode |= FMODE_CREATED;
+out:
+	dput(res);
+	return err;
+}
+
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
 {
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
@@ -428,6 +475,7 @@ const struct inode_operations vboxsf_dir_iops = {
 	.lookup  = vboxsf_dir_lookup,
 	.create  = vboxsf_dir_mkfile,
 	.mkdir   = vboxsf_dir_mkdir,
+	.atomic_open = vboxsf_dir_atomic_open,
 	.rmdir   = vboxsf_dir_unlink,
 	.unlink  = vboxsf_dir_unlink,
 	.rename  = vboxsf_dir_rename,
-- 
2.30.1

