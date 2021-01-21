Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3872FEB17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbhAUNGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59232 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731038AbhAUNEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611234204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHMmIqJjVSXuOxOyvvSpx0s118xXuqYQsAQM4Fcb2h4=;
        b=f5LMy7uJyy+wYvgXRp43EwPAtO1HMONZAKbXuRqnUwvc7EVPbgukbJoidf+DdAHWJ3VFkv
        JRuRlM00uOy4b8jeA9hfLSdyFUDS+ci1rXyWXfUJV/oK5WjmWO5RA9QsWxXGDUvBPEpkZP
        n0GVqMjYvmSoctE6/KESQI4cIJhwjWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-yRBRSeCIMoi6JD62BBVB0Q-1; Thu, 21 Jan 2021 08:03:21 -0500
X-MC-Unique: yRBRSeCIMoi6JD62BBVB0Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64F4C59;
        Thu, 21 Jan 2021 13:03:20 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72A7560BF3;
        Thu, 21 Jan 2021 13:03:19 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] vboxsf: Honor excl flag to the dir-inode create op
Date:   Thu, 21 Jan 2021 14:03:14 +0100
Message-Id: <20210121130317.146506-2-hdegoede@redhat.com>
In-Reply-To: <20210121130317.146506-1-hdegoede@redhat.com>
References: <20210121130317.146506-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Honor the excl flag to the dir-inode create op, instead of behaving
as if it is always set.

Note the old behavior still worked most of the time since a non-exclusive
open only calls the create op, if there is a race and the file is created
between the dentry lookup and the calling of the create call.

While at it change the type of the is_dir parameter to the
vboxsf_dir_create() helper from an int to a bool, to be consistent with
the use of bool for the excl parameter.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/dir.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 4d569f14a8d8..c3e68ad6c0f4 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -253,7 +253,7 @@ static int vboxsf_dir_instantiate(struct inode *parent, struct dentry *dentry,
 }
 
 static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
-			     umode_t mode, int is_dir)
+			     umode_t mode, bool is_dir, bool excl)
 {
 	struct vboxsf_inode *sf_parent_i = VBOXSF_I(parent);
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
@@ -261,10 +261,12 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 	int err;
 
 	params.handle = SHFL_HANDLE_NIL;
-	params.create_flags = SHFL_CF_ACT_CREATE_IF_NEW |
-			      SHFL_CF_ACT_FAIL_IF_EXISTS |
-			      SHFL_CF_ACCESS_READWRITE |
-			      (is_dir ? SHFL_CF_DIRECTORY : 0);
+	params.create_flags = SHFL_CF_ACT_CREATE_IF_NEW | SHFL_CF_ACCESS_READWRITE;
+	if (is_dir)
+		params.create_flags |= SHFL_CF_DIRECTORY;
+	if (excl)
+		params.create_flags |= SHFL_CF_ACT_FAIL_IF_EXISTS;
+
 	params.info.attr.mode = (mode & 0777) |
 				(is_dir ? SHFL_TYPE_DIRECTORY : SHFL_TYPE_FILE);
 	params.info.attr.additional = SHFLFSOBJATTRADD_NOTHING;
@@ -291,13 +293,13 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 static int vboxsf_dir_mkfile(struct inode *parent, struct dentry *dentry,
 			     umode_t mode, bool excl)
 {
-	return vboxsf_dir_create(parent, dentry, mode, 0);
+	return vboxsf_dir_create(parent, dentry, mode, false, excl);
 }
 
 static int vboxsf_dir_mkdir(struct inode *parent, struct dentry *dentry,
 			    umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, 1);
+	return vboxsf_dir_create(parent, dentry, mode, true, true);
 }
 
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
-- 
2.28.0

