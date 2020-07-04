Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6521463F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 16:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgGDODB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 10:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGDODB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:03:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB100208E4;
        Sat,  4 Jul 2020 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593871380;
        bh=xs1zP9GNU8J5zuCbFQztvpkhuGbsiHC1+/zg9xzu7G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpZ0pA1TFa+d/hZn3AL6AcUd7ZENK1xNVj8odkHqPPyY/k78tHYQYezmJxQjUanaf
         yaqnmszrddcDQ2uX3TnpoOqWWBYiP7nlYrxBEatzLVpvJRmuULaSskUTC2oEgnck9s
         x2jmAwrItpBJc/andHUDEUToFaLwXQ7KwFaJrN7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] readfile: implement readfile syscall
Date:   Sat,  4 Jul 2020 16:02:47 +0200
Message-Id: <20200704140250.423345-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200704140250.423345-1-gregkh@linuxfoundation.org>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's a tiny syscall, meant to allow a user to do a single "open this
file, read into this buffer, and close the file" all in a single shot.

Should be good for reading "tiny" files like sysfs, procfs, and other
"small" files.

There is no restarting the syscall, this is a "simple" syscall, with the
attempt to make reading "simple" files easier with less syscall
overhead.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/open.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 6cd48a61cda3..4469faa9379c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1370,3 +1370,53 @@ int stream_open(struct inode *inode, struct file *filp)
 }
 
 EXPORT_SYMBOL(stream_open);
+
+static struct file *readfile_open(int dfd, const char __user *filename,
+				  struct open_flags *op)
+{
+	struct filename *tmp;
+	struct file *f;
+
+	tmp = getname(filename);
+	if (IS_ERR(tmp))
+		return (struct file *)tmp;
+
+	f = do_filp_open(dfd, tmp, op);
+	if (!IS_ERR(f))
+		fsnotify_open(f);
+
+	putname(tmp);
+	return f;
+}
+
+SYSCALL_DEFINE5(readfile, int, dfd, const char __user *, filename,
+		char __user *, buffer, size_t, bufsize, int, flags)
+{
+	struct open_flags op;
+	struct open_how how;
+	struct file *file;
+	loff_t pos = 0;
+	int retval;
+
+	/* only accept a small subset of O_ flags that make sense */
+	if ((flags & (O_NOFOLLOW | O_NOATIME)) != flags)
+		return -EINVAL;
+
+	/* add some needed flags to be able to open the file properly */
+	flags |= O_RDONLY | O_LARGEFILE;
+
+	how = build_open_how(flags, 0000);
+	retval = build_open_flags(&how, &op);
+	if (retval)
+		return retval;
+
+	file = readfile_open(dfd, filename, &op);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	retval = vfs_read(file, buffer, bufsize, &pos);
+
+	filp_close(file, NULL);
+
+	return retval;
+}
-- 
2.27.0

