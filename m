Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC02FEE0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbhAUPHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:07:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732272AbhAUPHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611241535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OUbkRuwDLgmYjwVzvGDO9jQkHW5p0rC61Ve5x+8a1xY=;
        b=g9VO3qHwW82onTRtD26lCZDLTxVn0Q5EY/ef5No3NbBdeHtQDPtNwievlyKgVDZglcobW3
        RDPFvbPLvBKz1r47H99Z5Sn//XoUlV2ZLoEo6NgGzMXyYkpJM/14h7V7OL/NJm++DQFoPd
        4dNP26gno6iDvVvTEdzPbZnERsGBnFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-26V8fiCJNneXEOfcP9SDDg-1; Thu, 21 Jan 2021 10:05:30 -0500
X-MC-Unique: 26V8fiCJNneXEOfcP9SDDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E104190D342;
        Thu, 21 Jan 2021 15:05:29 +0000 (UTC)
Received: from x1.localdomain (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BE1119CAC;
        Thu, 21 Jan 2021 15:05:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] vboxsf: Make vboxsf_dir_create() return the handle for the created file
Date:   Thu, 21 Jan 2021 16:05:20 +0100
Message-Id: <20210121150522.147236-3-hdegoede@redhat.com>
In-Reply-To: <20210121150522.147236-1-hdegoede@redhat.com>
References: <20210121150522.147236-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make vboxsf_dir_create() optionally return the vboxsf-handle for
the created file. This is a preparation patch for adding atomic_open
support.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 fs/vboxsf/dir.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index c3e68ad6c0f4..0664787f2b74 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -253,7 +253,7 @@ static int vboxsf_dir_instantiate(struct inode *parent, struct dentry *dentry,
 }
 
 static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
-			     umode_t mode, bool is_dir, bool excl)
+			     umode_t mode, bool is_dir, bool excl, u64 *handle_ret)
 {
 	struct vboxsf_inode *sf_parent_i = VBOXSF_I(parent);
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(parent->i_sb);
@@ -278,28 +278,32 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 	if (params.result != SHFL_FILE_CREATED)
 		return -EPERM;
 
-	vboxsf_close(sbi->root, params.handle);
-
 	err = vboxsf_dir_instantiate(parent, dentry, &params.info);
 	if (err)
-		return err;
+		goto out;
 
 	/* parent directory access/change time changed */
 	sf_parent_i->force_restat = 1;
 
-	return 0;
+out:
+	if (err == 0 && handle_ret)
+		*handle_ret = params.handle;
+	else
+		vboxsf_close(sbi->root, params.handle);
+
+	return err;
 }
 
 static int vboxsf_dir_mkfile(struct inode *parent, struct dentry *dentry,
 			     umode_t mode, bool excl)
 {
-	return vboxsf_dir_create(parent, dentry, mode, false, excl);
+	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
 }
 
 static int vboxsf_dir_mkdir(struct inode *parent, struct dentry *dentry,
 			    umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, true, true);
+	return vboxsf_dir_create(parent, dentry, mode, true, true, NULL);
 }
 
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
-- 
2.28.0

