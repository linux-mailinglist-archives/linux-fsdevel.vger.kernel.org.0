Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA3D22DB4B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 04:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGZCE1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 22:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgGZCE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:04:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36BBC0619D2
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 19:04:26 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so2961421qvl.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 19:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Omdab1nC5MtSModjV2PS7fPsUJ+lDgcnp0n1JPTjxRo=;
        b=YMwNAYIX8mFOI7SAohY0EXyneQkLsbKI/55OHSL4POy90WKjrWT7T0bEST+X/H+3wV
         tz3rPlwfeABkbiKw+Lwilgn4o61YnXv/xm9/E38LQWujC0vkdC4Zg0QvRWDTFGyNvadd
         QjZoIoz9146mbVyAwiCce/zNKtBIwPQ7JjXqu6+f9gIohhOpIS4KylfUZWwVKY7tm8vJ
         ItP44HhvNmiinuTlfGdKWkLokGamprvTZW0iB8ryznQsvv5FrVglV4x5nNA/6b17A88n
         tE34iMJTwoFnKXsNXRI+gQRBQKGPUzu8pMT6lEMt0S+j8EZOST8WEu/oDJY4t0CpeIYz
         u1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Omdab1nC5MtSModjV2PS7fPsUJ+lDgcnp0n1JPTjxRo=;
        b=GGE8BCNu3dT6VtJXYSvgHbMOz9onOqPw601bUCTKDPvsN7VSH1HuaxJ/YPTylblvJq
         1nB+JJLbgZA9pJOFPKumF7INw2qFheYAlvjrDSF11XYFUT1xpJJ60/OtbsqLKzrb6fhR
         7G4zzBdbyKWrv2bjZgP8GCgJTzP5nkrHp7KN2uXKrjHBghCMTIAwN2NrhWGTucE/xS+H
         X2XG7t4FxxyCC1PKIDvFP6/7MeOgZl7FLQaE/i6FAi81DwRMrxj0RflqNAw5CdhnGEjo
         5KQ8lDZHcrqwcWn6ELGsl1JzUMY0GL17mMb5gp1BktkfOZKje+9pWWUI3DJM9jfUCt8k
         ZJvg==
X-Gm-Message-State: AOAM530R3WBt+0PPN7p2lfaztRNmYI0ubI4bUbuR5tdvBXd6/tEfxbkw
        rmxMsZ8tElF5mjN09DBnhpditA==
X-Google-Smtp-Source: ABdhPJyu2yaYA5YqCBXbtUuWqfBWJxFzSIYLeivhZi6g24tvrR/LD6i0Lr1beQ4D7FQtBVIz3jVCQQ==
X-Received: by 2002:a0c:a2c1:: with SMTP id g59mr16889122qva.138.1595729066049;
        Sat, 25 Jul 2020 19:04:26 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id p17sm12624093qkj.69.2020.07.25.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 19:04:25 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     Pascal Bouchareine <kalou@tfz.net>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH v3] This command attaches a description to a file descriptor for troubleshooting purposes. The free string is displayed in the process fdinfo file for that fd /proc/pid/fdinfo/fd.
Date:   Fri, 24 Jul 2020 22:15:47 -0700
Message-Id: <20200725051547.3718-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725045921.2723-1-kalou@tfz.net>
References: <20200725045921.2723-1-kalou@tfz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One intended usage is to allow processes to self-document sockets
for netstat and friends to report

Signed-off-by: Pascal Bouchareine <kalou@tfz.net>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/fcntl.c                         | 19 +++++++++++++++++++
 fs/file_table.c                    |  2 ++
 fs/proc/fd.c                       |  5 +++++
 include/linux/fs.h                 |  3 +++
 include/uapi/linux/fcntl.h         |  5 +++++
 6 files changed, 37 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 996f3cfe7030..ae8045650836 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1918,6 +1918,9 @@ A typical output is::
 	flags:	0100002
 	mnt_id:	19
 
+An optional 'desc' is set if the process documented its usage of
+the file via the fcntl command F_SET_DESCRIPTION.
+
 All locks associated with a file descriptor are shown in its fdinfo too::
 
     lock:       1: FLOCK  ADVISORY  WRITE 359 00:13:11691 0 EOF
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..c1ef724a906e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -319,6 +319,22 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	}
 }
 
+static long fcntl_set_description(struct file *file, char __user *desc)
+{
+	char *d;
+
+	d = strndup_user(desc, MAX_FILE_DESC_SIZE);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	spin_lock(&file->f_lock);
+	kfree(file->f_description);
+	file->f_description = d;
+	spin_unlock(&file->f_lock);
+
+	return 0;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -426,6 +442,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_SET_DESCRIPTION:
+		err = fcntl_set_description(filp, argp);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..6673a48d2ea1 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -272,6 +272,8 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	kfree(file->f_description);
+
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..60b3ff971b2b 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -57,6 +57,11 @@ static int seq_show(struct seq_file *m, void *v)
 		   (long long)file->f_pos, f_flags,
 		   real_mount(file->f_path.mnt)->mnt_id);
 
+	spin_lock(&file->f_lock);
+	if (file->f_description)
+		seq_printf(m, "desc:\t%s\n", file->f_description);
+	spin_unlock(&file->f_lock);
+
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
 		goto out;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..09717bfa4e3b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -980,6 +980,9 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+
+#define MAX_FILE_DESC_SIZE 256
+	char                    *f_description;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..f86ff6dc45c7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -55,6 +55,11 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Set file description
+ */
+#define F_SET_DESCRIPTION	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.25.1

