Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78D8328C19
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 19:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhCASpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 13:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240507AbhCASnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 13:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614624112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P3g4CNWzWkQlCkSCAUjqzAiPfhgW0Llm7plcqAZ2jg=;
        b=FqKJy97rNcYizCAzfPdNbSl7DnEWo4CGx37kPabD1rDafnf267OWojYsEE6dH2FJ01eHEI
        QOnUW+qFYJ16RvQxgzA+z9ybc68P2+QFrrlraeAnaC6ZULcF7zRYzcvFefZqR7jCPjFpXt
        aAFXaTDgR54TuhSDqU2q+jkWC9mlyyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-M8x69jykOcOfWq1BRIWL6A-1; Mon, 01 Mar 2021 13:41:49 -0500
X-MC-Unique: M8x69jykOcOfWq1BRIWL6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2682EC1A0;
        Mon,  1 Mar 2021 18:41:47 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-84.ams2.redhat.com [10.36.112.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A0191A26A;
        Mon,  1 Mar 2021 18:41:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH resend 1/4] vboxsf: Honor excl flag to the dir-inode create op
Date:   Mon,  1 Mar 2021 19:41:40 +0100
Message-Id: <20210301184143.29878-2-hdegoede@redhat.com>
In-Reply-To: <20210301184143.29878-1-hdegoede@redhat.com>
References: <20210301184143.29878-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 7aee0ec63ade..8af75d5589bb 100644
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
@@ -292,14 +294,14 @@ static int vboxsf_dir_mkfile(struct user_namespace *mnt_userns,
 			     struct inode *parent, struct dentry *dentry,
 			     umode_t mode, bool excl)
 {
-	return vboxsf_dir_create(parent, dentry, mode, 0);
+	return vboxsf_dir_create(parent, dentry, mode, false, excl);
 }
 
 static int vboxsf_dir_mkdir(struct user_namespace *mnt_userns,
 			    struct inode *parent, struct dentry *dentry,
 			    umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, 1);
+	return vboxsf_dir_create(parent, dentry, mode, true, true);
 }
 
 static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
-- 
2.30.1

