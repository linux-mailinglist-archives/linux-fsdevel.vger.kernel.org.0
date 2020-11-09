Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB92AB44E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 11:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgKIKEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 05:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgKIKEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:04:09 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1B1C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 02:04:09 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so7630628pfm.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vE1j5lHbqxQRKVy7z5J1WFsmYZl69+h2qLPTKyWvFbk=;
        b=gj96iORM+Z/N0YzkFX0vmc5d1lP4rs0MAW3lSc/KhzdHwi+Hsq7+WAlvKXH1OGPPNZ
         8j0FMEjv47g6PlTX545Kq2aZqmGpZsczEe5hZi/2g9ovAZzGffqE4i4MCqt66Dyvc/1k
         c189DuLz4fl1pgUi3rKv1Oaakpc5qp5EbkjuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vE1j5lHbqxQRKVy7z5J1WFsmYZl69+h2qLPTKyWvFbk=;
        b=pFKK1WyJdL1qS5sch2jeUwH8UKxLOq3V2LzdzjsW2xnDR4rAYp2byFLQvh7O282sYe
         U3Mj6FsjdCSI+5cIiGPu9ribQlxum+jh2xhtyKRIjFxDWgu7TV6LoHYqm/1gtYWuLzwp
         TwXGIgjnbtcdfnVOsfzUgWJCqpyGOKcoKMbogqms/m4oJd0X1ZPPeDMYJnWlUTCRFcA9
         /yaRJ/j5XMJMV2vAtoY/JSM5h5j4OD5oLTGJ4oQsWKDXZTFrDDAvWJTb4WQybcoF4dr3
         ZbzQ8skVuywqn8aXREFMaYxpj7Zwb0ZU63CFq+LG3B3mj7CT+FXfazSWT0VL6U7t3Oeh
         ZHsw==
X-Gm-Message-State: AOAM531zSPvEKDM84cgN9PyAM//Lcmw0/cKZTiiNp+vZtE3hkiPdLHlK
        R1M/P0Hlj4KGbw5+8rJtXoqAOw==
X-Google-Smtp-Source: ABdhPJxtTnUaPkN7+f2uNq2Hyh53FmJRVRjvwSip7t0e5oTfBMTifAvekA4K1gVAOqCDYwW7EfHvww==
X-Received: by 2002:a17:90a:e605:: with SMTP id j5mr12420718pjy.118.1604916248844;
        Mon, 09 Nov 2020 02:04:08 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f693:9fff:fef4:2537])
        by smtp.gmail.com with ESMTPSA id 145sm9841668pga.11.2020.11.09.02.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:04:08 -0800 (PST)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 2/2] fuse: Implement O_TMPFILE support
Date:   Mon,  9 Nov 2020 19:03:43 +0900
Message-Id: <20201109100343.3958378-3-chirantan@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201109100343.3958378-1-chirantan@chromium.org>
References: <20201109100343.3958378-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement support for O_TMPFILE by re-using the existing infrastructure
for mkdir, symlink, mknod, etc. The server should reply to the tmpfile
request by sending a fuse_entry_out describing the newly created
tmpfile.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/dir.c  | 21 +++++++++++++++++++++
 fs/fuse/file.c |  3 ++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff7dbeb16f88d..1ab52e7ec1625 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -751,6 +751,26 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
 	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
 }
 
+static int fuse_tmpfile(struct inode *dir, struct dentry *entry, umode_t mode)
+{
+	struct fuse_tmpfile_in inarg;
+	struct fuse_mount *fm = get_fuse_mount(dir);
+	FUSE_ARGS(args);
+
+	if (!fm->fc->dont_mask)
+		mode &= ~current_umask();
+
+	memset(&inarg, 0, sizeof(inarg));
+	inarg.mode = mode;
+	inarg.umask = current_umask();
+	args.opcode = FUSE_TMPFILE;
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(inarg);
+	args.in_args[0].value = &inarg;
+
+	return create_new_entry(fm, &args, dir, entry, S_IFREG);
+}
+
 static int fuse_symlink(struct inode *dir, struct dentry *entry,
 			const char *link)
 {
@@ -1818,6 +1838,7 @@ static const struct inode_operations fuse_dir_inode_operations = {
 	.listxattr	= fuse_listxattr,
 	.get_acl	= fuse_get_acl,
 	.set_acl	= fuse_set_acl,
+	.tmpfile	= fuse_tmpfile,
 };
 
 static const struct file_operations fuse_dir_operations = {
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c03034e8c1529..8ecf85699a014 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -39,7 +39,8 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 	FUSE_ARGS(args);
 
 	memset(&inarg, 0, sizeof(inarg));
-	inarg.flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+	inarg.flags =
+		file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY | O_TMPFILE);
 	if (!fm->fc->atomic_o_trunc)
 		inarg.flags &= ~O_TRUNC;
 	args.opcode = opcode;
-- 
2.29.2.222.g5d2a92d10f8-goog

