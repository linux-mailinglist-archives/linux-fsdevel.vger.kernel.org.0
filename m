Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 419261997A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbgCaNhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 09:37:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44637 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgCaNhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:37:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id j188so17339885lfj.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2020 06:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aU5iLCuWaH4zxyOLw8e9l2ANSFZT9vUFLRpaEbsCIeI=;
        b=M2bf+eVpkauwEFyb4CxmjaPvpl1N7Yad7zfCQI7ftWmBLkeJPC0XXouWV2QI8hxZp0
         SWvodVcZIL6Bb/b/rJIkQwkInHpjgZ5o+LFL4a9Pq3M4CqV+zv5VdnUEa/Y9J4upA+Im
         9Jw34jRSN6kWPZ+k5VsdGo8jY+lJaogNfFrBKMbUo/M+wp9QThZUUdUXu+DGnXp8u5k2
         KPhTqiN5HAQpCWvh1il9cj1mhxWhSyWq/d4wVo+nmE3Zy9I/KddzW5kBlWk/4bQIKCOR
         Av5ZU2ntiH08RXx7Vy7fMOQlQY1fz06o4VosndadGp4GHJG5h/oOYOtMMvQhx/Kp3hXh
         clpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aU5iLCuWaH4zxyOLw8e9l2ANSFZT9vUFLRpaEbsCIeI=;
        b=k5Ga3ik2KqsLFHxIiB7oaXNetcduNJmZ8RBg25WA+VheAiIMhYuNPmQx5HQfzhaD5T
         FN2t+3/sio5y0ZZPt3fUiyy3VGp/e1F479yXdY7vU4EA5FpkdXwwAMegSKI/IBrAIiIb
         rdiJM+8bb2B2k4iCJpD40gP2cYivKL7XMl6AG8wE6ay+4dIG+2hs2f39DOh5j/QSK4jH
         bmxXLBYttSca7Gzw5gD2TyQO35GLkVqtPn33cB6JG8eWDdABoJCKHWwY8hfNJsfbPkUI
         w5P1mPW5YHFyF9Kn9DHGYLhgal+fqcyX4aL8ThAbwr13KytJRqAUJJqc1UxmGEusL/5J
         MADQ==
X-Gm-Message-State: AGi0PubOzU1PR3nxq3V0U4Y4olsvlnOZCHpH35BTaMjCyx1eT+/QzhOt
        mCd2eTQwre2jCL5ytb4m9CV9LA==
X-Google-Smtp-Source: APiQypKT2+uqdUkMNinUZ7US4h3EuWA+Qnq8u+r/x9eYKAF8W37lj90IU1/6iLzyAQ3J8dNMc7hMJw==
X-Received: by 2002:a19:ad43:: with SMTP id s3mr11555874lfd.63.1585661866597;
        Tue, 31 Mar 2020 06:37:46 -0700 (PDT)
Received: from localhost.localdomain (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id x128sm9837994lff.67.2020.03.31.06.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 06:37:45 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] fcntl: Add 32bit filesystem mode
Date:   Tue, 31 Mar 2020 15:35:36 +0200
Message-Id: <20200331133536.3328-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It was brought to my attention that this bug from 2018 was
still unresolved: 32 bit emulators like QEMU were given
64 bit hashes when running 32 bit emulation on 64 bit systems.

This adds a fcntl() operation to set the underlying filesystem
into 32bit mode even if the file hanle was opened using 64bit
mode without the compat syscalls.

Programs that need the 32 bit file system behavior need to
issue a fcntl() system call such as in this example:

  #define F_SET_FILE_32BIT_FS (1024 + 15)

  int main(int argc, char** argv) {
    DIR* dir;
    int err;
    int fd;

    dir = opendir("/boot");
    fd = dirfd(dir);
    err = fcntl(fd, F_SET_FILE_32BIT_FS);
    if (err) {
      printf("fcntl() failed! err=%d\n", err);
      return 1;
    }
    printf("dir=%p\n", dir);
    printf("readdir(dir)=%p\n", readdir(dir));
    printf("errno=%d: %s\n", errno, strerror(errno));
    return 0;
  }

This can be pretty hard to test since C libraries and linux
userspace security extensions aggressively filter the parameters
that are passed down and allowed to commit into actual system
calls.

Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://bugs.launchpad.net/qemu/+bug/1805913
Link: https://lore.kernel.org/lkml/87bm56vqg4.fsf@mid.deneb.enyo.de/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205957
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 fs/fcntl.c                       | 4 ++++
 include/uapi/linux/fcntl.h       | 9 +++++++++
 tools/include/uapi/linux/fcntl.h | 9 +++++++++
 tools/perf/trace/beauty/fcntl.c  | 3 ++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..d194b1265bd4 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -426,6 +426,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_SET_FILE_32BIT_FS:
+		filp->f_mode |= FMODE_32BITHASH;
+		err = 0;
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index ca88b7bce553..b9ad934147e8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -73,6 +73,15 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define F_SET_FILE_32BIT_FS	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index ca88b7bce553..b9ad934147e8 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -73,6 +73,15 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/*
+ * This instructs the kernel to provide 32bit semantics (such as hashes) from
+ * the file system layer, when running a userland that depend on 32bit
+ * semantics on a kernel that supports 64bit userland, but does not use the
+ * compat ioctl() for e.g. open(), so that the kernel would otherwise assume
+ * that the userland process is capable of dealing with 64bit semantics.
+ */
+#define F_SET_FILE_32BIT_FS	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Types of directory notifications that may be requested.
  */
diff --git a/tools/perf/trace/beauty/fcntl.c b/tools/perf/trace/beauty/fcntl.c
index 56ef83b3d130..da80264678cb 100644
--- a/tools/perf/trace/beauty/fcntl.c
+++ b/tools/perf/trace/beauty/fcntl.c
@@ -94,7 +94,8 @@ size_t syscall_arg__scnprintf_fcntl_arg(char *bf, size_t size, struct syscall_ar
 	    cmd == F_OFD_SETLK || cmd == F_OFD_SETLKW || cmd == F_OFD_GETLK ||
 	    cmd == F_GETOWN_EX || cmd == F_SETOWN_EX ||
 	    cmd == F_GET_RW_HINT || cmd == F_SET_RW_HINT ||
-	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT)
+	    cmd == F_GET_FILE_RW_HINT || cmd == F_SET_FILE_RW_HINT ||
+	    cmd == F_SET_FILE_32BIT_FS)
 		return syscall_arg__scnprintf_hex(bf, size, arg);
 
 	return syscall_arg__scnprintf_long(bf, size, arg);
-- 
2.25.1

