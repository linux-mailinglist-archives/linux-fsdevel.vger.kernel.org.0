Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6422DA11
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGYV3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 17:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgGYV3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 17:29:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32193C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 14:29:01 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so9581072qtt.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2020 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vUjQUwq1PEERKf5qY60lLL26f/JpD/pXHJh6zM3IeM=;
        b=SiQ/TcpGmb4nIYR2tjY/C67/FDysFa43NfqWK5sh5Hx2lBSouWujK2NCbEsIJebtEd
         tojt5nScJQqxhwQo2UT4dTfanai5SFMOeWM3wbW2UGRg/GOgnXrFEu/+mFWQ3MnP1Yb7
         iMIa5ei9q/lAJLiOifV8v6LOAScv3Ps1y6rYztN9UHKw8j7NHb25Lzv4hXbmkJ4ZZYg6
         litzpjUq08/OFHnunvH80Kxv3oeAUNDmMr2UPu50xH7f+jQM2uBSoF1ZXUtvMz5kxJyC
         FVpx8B3J2ThVo5Hi2QwlBjTh8zv5peDOyKYjaeT0RI9ziaedfbYAhVswskDLXAA8ax/E
         xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9vUjQUwq1PEERKf5qY60lLL26f/JpD/pXHJh6zM3IeM=;
        b=RyAvepJBzsOhARxwTbluZamID/PofrfZNnlap/+iW7/y5OzykJlAOIn9FdTNZwTlWc
         qXRhA/0cVrXwkxfIKFiZfWRs+XmMf5RIViIj72IM7skfcEz3lBrRw8Fto5YQWGwvqFgA
         +viDG3MJOPQzjxTv3YB7NFueTHjIV7Ar4s029DHuL4PdCt2C4XgA1fJT8PRrvMH4bfBZ
         eoHi/K0cxuwIkMSS/3uIvkvNQqHPtzRRQtJW+ya8ZqX2IVGfOc3qoLNHWzwFOhnGZw9k
         939xj36fdJdvgoeXRsd76r2tz1AxYaZqI49Ew8U3kCnLGk+DlZn5OZ0ZQkcg8USMvKCS
         joNg==
X-Gm-Message-State: AOAM530XimSD/0XfDUqnpcM9JXCDXh0gA8WdxlAnH/Mf5d98ib77SKdi
        GGHQiGJaAA4oVZeZfe0brhz9Uw==
X-Google-Smtp-Source: ABdhPJz+WCEHOOOvq9Cyg192KCiTDbh0OP4VCr5T++Wwp2jd2SAHr3ridCcBzehvmcV6KJxYgmQmvQ==
X-Received: by 2002:ac8:4411:: with SMTP id j17mr15433311qtn.77.1595712540240;
        Sat, 25 Jul 2020 14:29:00 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id w1sm11597735qkj.90.2020.07.25.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 14:28:59 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     Pascal Bouchareine <kalou@tfz.net>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] proc,fcntl: introduce F_SET_DESCRIPTION
Date:   Fri, 24 Jul 2020 17:40:43 -0700
Message-Id: <20200725004043.32326-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
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

More context sent earlier this week: https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/T/#u

 Documentation/filesystems/proc.rst |  3 +++
 fs/fcntl.c                         | 19 +++++++++++++++++++
 fs/proc/fd.c                       |  5 +++++
 include/linux/fs.h                 |  3 +++
 include/uapi/linux/fcntl.h         |  5 +++++
 5 files changed, 35 insertions(+)


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

