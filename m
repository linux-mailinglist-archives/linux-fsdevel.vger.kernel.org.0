Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E121362C1E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 02:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbhDPX71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 19:59:27 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:45040 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbhDPX7Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:59:24 -0400
Received: by mail-pj1-f52.google.com with SMTP id q14-20020a17090a430eb02901503aaee02bso4378103pjg.3;
        Fri, 16 Apr 2021 16:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x0uRodafTirCXU5FMfsH3yjU20L03rJMI/NnxoW2Es=;
        b=DvnjMyEF4V5mgy4d6dUyolO26PKnRWvNMGydO6scZeILvJewoh6y84yEaoucTJ9TIN
         qISAUywqx6T+ca6S54wNG+fqsc3WQT3DR+Q2XrdGOd0nuRC78+0612hjPY1KMxwJVO88
         UkPejb2174hHZ/Xmg8pGBudJDeNbs2iujSt1Ww6xQ63LFDlUC046zoSjJSjghQYH3jVD
         tafc2jFgUGX3c9iPYvhgR9CiRrWQgbG8OXo16LH/Nzx2vmBpkGlDs9EjxRDKymZVHJuU
         gMqYF13BaOSuFJW/MZopBQjxMZikNWeD4rSfGy7lxCxRlkrHBqArM3Ddsaf1M8G6N/8l
         fzsA==
X-Gm-Message-State: AOAM532qLp+hlSfuek5ksDmYxD+amNYP0NKJ20skuoeLrbcWs1fwExtg
        1DvR4mbnfKEeTwEdEztIGy8=
X-Google-Smtp-Source: ABdhPJz5VGE8ymtWzHhurc5HK3og7Uo6QgwUurR3Gov4US+K1PgU75zyDGjTueMrFBlt2rZ0CdXmyQ==
X-Received: by 2002:a17:90a:5d93:: with SMTP id t19mr12332420pji.211.1618617538910;
        Fri, 16 Apr 2021 16:58:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s9sm5682937pfc.192.2021.04.16.16.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:58:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E850641505; Fri, 16 Apr 2021 23:58:54 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        jeyu@kernel.org, ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] fs/kernel_read_file: use usermodehelper_read_trylock() as a stop gap
Date:   Fri, 16 Apr 2021 23:58:50 +0000
Message-Id: <20210416235850.23690-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20210416235850.23690-1-mcgrof@kernel.org>
References: <20210416235850.23690-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The VFS lacks support to do automatic freeze / thaw of filesystems
on the suspend / resume cycle. This can cause some issues, namely
stalls when we have reads/writes during the suspend / resume cycle.

Although for module loading / kexec the probability of this happening
is extremely low, maybe even impossible, its a known real issue with
the request_firmare() API which it does direct fs read. For this reason
only be chatty about the issue on the call used by the firmware API.

Lukas Middendorf has reported an easy situation to reproduce, which can
be caused by questionably buggy drivers which call the request_firmware()
API on resume.

All you have to do is do the suspend / resume cycle using a driver
which will call request_firmware() on resume on a fresh XFS or
btrfs filesystem which has random files but the target file present:

for n in {1..1000}; do
	dd if=/dev/urandom of=/lib/firmware/file$( printf %03d "$n" ).bin bs=1 count=$((RANDOM + 1024 ))
done

You can reproduce this either with a buggy driver or by using the
test_firmware driver with the new hooks added to test this case.

No other request_firmware() calls can be triggered for this hang to work.
The hang occurs because:

request_firmware() -->
kernel_read_file_from_path_initns() -->
file_open_root() -->
  btrfs_lookup() --> ... -->
  btrfs_search_slot() --> read_block_for_search() -->
        --> read_tree_block() --> btree_read_extent_buffer_pages() -->
        --> submit_one_bio() --> btrfs_submit_metadata_bio() -->
        --> btrfsic_submit_bio() --> submit_bio()
                --> this completes and then
        --> wait_on_page_locked() on the first page
        --> never returns

The endless wait for the read which the piece of hardware never got
stalls resume as sync calls are all asynchronous.

The VFS fs freeze work fixes this issue, however it requires a bit
more work, which may take a while to land upstream, and so for now
this provides a simple stop-gap solution.

We can remove this stop-gap solution once the kernel gets VFS
fs freeze / thaw support.

Cc: rafael@kernel.org
Cc: jack@suse.cz
Cc: bvanassche@acm.org
Cc: kernel@tuxforce.de
Cc: mchehab@kernel.org
Cc: keescook@chromium.org
Reported-by: Lukas Middendorf <kernel@tuxforce.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/kernel_read_file.c | 37 +++++++++++++++++++++++++++++++++++--
 kernel/kexec_file.c   |  9 ++++++++-
 kernel/module.c       |  8 +++++++-
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 90d255fbdd9b..f82d8534bf39 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -4,6 +4,7 @@
 #include <linux/kernel_read_file.h>
 #include <linux/security.h>
 #include <linux/vmalloc.h>
+#include <linux/umh.h>
 
 /**
  * kernel_read_file() - read file contents into a kernel buffer
@@ -134,12 +135,20 @@ int kernel_read_file_from_path(const char *path, loff_t offset, void **buf,
 	if (!path || !*path)
 		return -EINVAL;
 
+	ret = usermodehelper_read_trylock();
+	if (ret)
+		return ret;
+
 	file = filp_open(path, O_RDONLY, 0);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		usermodehelper_read_unlock();
 		return PTR_ERR(file);
+	}
 
 	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
+
+	usermodehelper_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path);
@@ -160,13 +169,37 @@ int kernel_read_file_from_path_initns(const char *path, loff_t offset,
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
+	/*
+	 * Note: we may be incorrectly called on a driver's resume callback.
+	 *
+	 * The kernel's power management may be busy bringing us to suspend
+	 * or trying to get us back to resume. If we try to do a direct write
+	 * during this time a block driver may never get that request, and the
+	 * filesystem can wait forever. This requires proper VFS work, which
+	 * is not yet ready.
+	 *
+	 * Likewise busy trying here is not possible as well as we'd be holding
+	 * up the kernel's pm resume, and waiting will not allow use to thaw
+	 * the filesystem, we'd just wait forever. Best we can do is
+	 * communuicate the problem so that drivers use the firwmare cache or
+	 * implement their own prior to resume.
+	 */
+	ret = usermodehelper_read_trylock();
+	if (ret) {
+		pr_warn_once("Trying direct fs read while not allowed");
+		return ret;
+	}
+
 	file = file_open_root(root.dentry, root.mnt, path, O_RDONLY, 0);
 	path_put(&root);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		usermodehelper_read_unlock();
 		return PTR_ERR(file);
+	}
 
 	ret = kernel_read_file(file, offset, buf, buf_size, file_size, id);
 	fput(file);
+	usermodehelper_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kernel_read_file_from_path_initns);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 33400ff051a8..d19a01836128 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -226,10 +226,16 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret;
 	void *ldata;
 
+	ret = usermodehelper_read_trylock();
+	if (ret)
+		return ret;
+
 	ret = kernel_read_file_from_fd(kernel_fd, 0, &image->kernel_buf,
 				       INT_MAX, NULL, READING_KEXEC_IMAGE);
-	if (ret < 0)
+	if (ret < 0) {
+		usermodehelper_read_unlock();
 		return ret;
+	}
 	image->kernel_buf_len = ret;
 
 	/* Call arch image probe handlers */
@@ -291,6 +297,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	/* In case of error, free up all allocated memory in this function */
 	if (ret)
 		kimage_file_post_load_cleanup(image);
+	usermodehelper_read_unlock();
 	return ret;
 }
 
diff --git a/kernel/module.c b/kernel/module.c
index b5dd92e35b02..9058a104610d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4140,13 +4140,19 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 		      |MODULE_INIT_IGNORE_VERMAGIC))
 		return -EINVAL;
 
+	err = usermodehelper_read_trylock();
+	if (err)
+		return err;
 	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
 				       READING_MODULE);
-	if (err < 0)
+	if (err < 0) {
+		usermodehelper_read_unlock();
 		return err;
+	}
 	info.hdr = hdr;
 	info.len = err;
 
+	usermodehelper_read_unlock();
 	return load_module(&info, uargs, flags);
 }
 
-- 
2.29.2

