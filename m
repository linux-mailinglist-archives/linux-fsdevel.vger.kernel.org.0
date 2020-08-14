Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872FE244409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Aug 2020 05:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgHND5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 23:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHND5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:57:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B26C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so7267879qkf.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqQTcE8OeHpaauD8pedadIVKN4wJE4wCvdlEy6whEus=;
        b=ZKYsHZrNG6TPK2onXgFXhs8i86GF2T+1GmWoXgb8w0ubJG5cm80B7iPXmbIHm+elBT
         arwFQ8LvJNxI5TCW7WxokIejMqEK8GbVMlo9dvRzFAJe7Wr8zSTPbqpYZrhm5x0hEjkj
         fwQwpWTfhaLoOJw0QJyT7CPhOfG8cTKK88ot9+eFf9IImU6qn6kpkLz0w5fLcWBk++On
         uRJMsOgGr5zPwICP/dtUis8xhGrqgBzXBQWjvrlMyu6LhVj29pBQIuiZIDZ6v2nWISBk
         6nn2uSLOZo4C3M2SBiRiiD6hg39fY7r408UD2ZjInSdcPcJgexW2237YChFhM+T/bfgR
         2qyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqQTcE8OeHpaauD8pedadIVKN4wJE4wCvdlEy6whEus=;
        b=W0YYAWT1NVzGS151iox7vOQYe71NkurZ/gU6YQ0s5Iuxs3pMnmJpDZmbKYkl1aOHkE
         TJ58sOf2YpApI1UsdK5OlkbqqDS14LwhWYY0Mf9ocYNRFg/vpaF/l+A37uhvjOtyNABs
         OIOk0VjpkS2yYbFq8rJSBhB4wGt4O3U2Z24F9Yw9VUx1xPdQ5R00ImgpJhMOZOscvrCw
         7XkP5OnCuKt3IXxaNpjIvRp7S760y1P+WrmJMnqoh5vhalKlXwJEpERcY3x+BKeP6++v
         B1dA2ckCoulhI/A9eU9Ut+VEjrA/WzYGit5WPaP9nn0Nvv1nv5CPyIHE5oFqvpnxC4cj
         gGVw==
X-Gm-Message-State: AOAM532gdI6/4u0PC3ug5ufFNvVquwuZbeqiKp6uix+AOWhlsEBWBwU8
        9Lf+ZvcJ9Pqq3ygQAm7JZBqZdw==
X-Google-Smtp-Source: ABdhPJyNbykq5KBipHryqnmMCPTSNRFo+kmVANRBs4dxE9Bo0HEvV3/pxiA/P6AaP1CWHr5PWvyU1g==
X-Received: by 2002:a05:620a:c08:: with SMTP id l8mr381427qki.57.1597377438042;
        Thu, 13 Aug 2020 20:57:18 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id k11sm7229460qkk.93.2020.08.13.20.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:57:17 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     Pascal Bouchareine <kalou@tfz.net>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH v4 2/2] fcntl: introduce F_SET_DESCRIPTION
Date:   Thu, 13 Aug 2020 20:54:53 -0700
Message-Id: <20200814035453.210716-3-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814035453.210716-1-kalou@tfz.net>
References: <20200814035453.210716-1-kalou@tfz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This command attaches a description to a file descriptor for
troubleshooting purposes. The free string is displayed in the
process fdinfo file for that fd /proc/pid/fdinfo/fd.

One intended usage is to allow processes to self-document sockets
for netstat and friends to report

Signed-off-by: Pascal Bouchareine <kalou@tfz.net>
---
 fs/fcntl.c                 | 21 +++++++++++++++++++++
 fs/file_table.c            |  2 ++
 fs/proc/fd.c               |  5 +++++
 include/linux/fs.h         |  3 +++
 include/uapi/linux/fcntl.h |  5 +++++
 5 files changed, 36 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..9fbeaaf02802 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -319,6 +319,24 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	}
 }
 
+static long fcntl_set_description(struct file *file, char __user *desc)
+{
+	char *d, *old;
+
+	d = strndup_user(desc, MAX_FILE_DESC_SIZE, GFP_KERNEL_ACCOUNT);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	spin_lock(&file->f_lock);
+	old = file->f_description;
+	file->f_description = d;
+	spin_unlock(&file->f_lock);
+
+	kfree(old);
+
+	return 0;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -426,6 +444,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
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
index f5abba86107d..a2a683d603b6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -980,6 +980,9 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+
+#define MAX_FILE_DESC_SIZE 256
+	char			*f_description;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..465385e52f49 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -55,6 +55,11 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Set file description
+ */
+#define F_SET_DESCRIPTION      (F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.25.1

