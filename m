Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8789C72B1D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFKMYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKMYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 08:24:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1C2E9
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 05:24:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so3326530f8f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 05:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686486274; x=1689078274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOgDZuA/Ne0uV6u38MWgzlbIysftVWCg15yBtiUMvOU=;
        b=c7Fhay2d6ls1Kdq62Dl39xx+cU0x8aValLTiiz+hy1MESMsad/7Db1h6Zv3jDxLs8j
         8K3Jju0kLkUsD7VfObV6Slglgy7hsPi9fNmyPmDOxMnKv0KeMWlnxxULycX5DzLuSVNm
         KwingQGrbc+m3en7FHG+SCLH9jTtk1PM1FSDPyLxHJ0XgdHHNsJGdt2t7ljF8tATAJ5S
         6KybDgoLaHdvHEvL/BF9IHfyNb11VTiPn2IigEdAmtg8hxLDlzmBVpgBsk28qhaMYGEP
         yPs/x2hCIK/xBb7bB+G/TMg7XpY9ju/jjG/bmqtXSAJOwduQ3JvoiZt0reb1lG1EEL95
         hefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686486274; x=1689078274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOgDZuA/Ne0uV6u38MWgzlbIysftVWCg15yBtiUMvOU=;
        b=UV7k3be9n0TpeeMOaqcx/NklNNyZH9IBytacolozFKFzIOd3SHQFZanxEwRKJO657a
         swtP1Ct6gCZgTUVDRX75IAkFuCrq2RDOYFver5aGDu1SI9eOR6t+vstMkuTvweV/MWrF
         +kku3/N5RyPLUGAL/pfkIiiJ8xBB8Hj5h8A0kPDPPt+IeNEAYJFEeSGe0WlZqcm1CnZ+
         5MhQZiqtdrMUZqUwFnvkByNR02qv12wAsIsjEGf/liv2XBp4PpvoC+nKvijF9eXb8wUR
         35cSw0c07XOVETV8u2m3vNjpxZ35i7XKnpJu3VACgwLMhPW1FeL130QG5MATQz0GtUhQ
         VJaw==
X-Gm-Message-State: AC+VfDzfv1GnI7vtKuhrrSW1V/HuSAxbd1f1Lqo6FuGfXSjFObtJBKCc
        FL8wwyylpM2wI39tyXaW+27F/K1Ig9g=
X-Google-Smtp-Source: ACHHUZ6lOTxe69jtWlKK9z70d5wjDCjHUOOmnR86X36tuzj+UFnNBh8F34b9EeaabI0WINTHmFaUWw==
X-Received: by 2002:adf:f4cc:0:b0:30f:b9a2:92c5 with SMTP id h12-20020adff4cc000000b0030fb9a292c5mr1828458wrp.49.1686486273842;
        Sun, 11 Jun 2023 05:24:33 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b003063db8f45bsm9486669wri.23.2023.06.11.05.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 05:24:33 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: move fsnotify_open() hook into do_dentry_open()
Date:   Sun, 11 Jun 2023 15:24:29 +0300
Message-Id: <20230611122429.1499617-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsnotify_open() hook is called only from high level system calls
context and not called for the very many helpers to open files.

This may makes sense for many of the special file open cases, but it is
inconsistent with fsnotify_close() hook that is called for every last
fput() of on a file object with FMODE_OPENED.

As a result, it is possible to observe ACCESS, MODIFY and CLOSE events
without ever observing an OPEN event.

Fix this inconsistency by replacing all the fsnotify_open() hooks with
a single hook inside do_dentry_open().

If there are special cases that would like to opt-out of the possible
overhead of fsnotify() call in fsnotify_open(), they would probably also
want to avoid the overhead of fsnotify() call in the rest of the fsnotify
hooks, so they should be opening that file with the __FMODE_NONOTIFY flag.

However, in the majority of those cases, the s_fsnotify_connectors
optimization in fsnotify_parent() would be sufficient to avoid the
overhead of fsnotify() call anyway.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

I found out about this problem when I tested the work to remove
FMODE_NONOTIFY from overlayfs internal files - even after I enabled
notifications on the underlying fs, the LTS tests [2] did not observe
the OPEN events.

Because this change is independent of the ovl work and has implications
on other subsystems as well (e.g. cachefiles), I think it is better
if the change came through your tree.

This change has a potential to regress some micro-benchmarks, so if
you could queue it up for soaking in linux-next that would be great.

Thanks,
Amir.


[1] https://lore.kernel.org/linux-fsdevel/20230609073239.957184-1-amir73il@gmail.com/
[2] https://github.com/amir73il/ltp/commits/ovl_encode_fid

 fs/exec.c            | 5 -----
 fs/fhandle.c         | 1 -
 fs/open.c            | 6 +++++-
 io_uring/openclose.c | 1 -
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a466e797c8e2..238473de1ec5 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -152,8 +152,6 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
 			 path_noexec(&file->f_path)))
 		goto exit;
 
-	fsnotify_open(file);
-
 	error = -ENOEXEC;
 
 	read_lock(&binfmt_lock);
@@ -934,9 +932,6 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (err)
 		goto exit;
 
-	if (name->name[0] != '\0')
-		fsnotify_open(file);
-
 out:
 	return file;
 
diff --git a/fs/fhandle.c b/fs/fhandle.c
index fd0d6a3b3699..6ea8d35a9382 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -242,7 +242,6 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 		retval =  PTR_ERR(file);
 	} else {
 		retval = fd;
-		fsnotify_open(file);
 		fd_install(fd, file);
 	}
 	path_put(&path);
diff --git a/fs/open.c b/fs/open.c
index 4478adcc4f3a..81444ebf6091 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -969,6 +969,11 @@ static int do_dentry_open(struct file *f,
 		}
 	}
 
+	/*
+	 * Once we return a file with FMODE_OPENED, __fput() will call
+	 * fsnotify_close(), so we need fsnotify_open() here for symetry.
+	 */
+	fsnotify_open(f);
 	return 0;
 
 cleanup_all:
@@ -1358,7 +1363,6 @@ static long do_sys_openat2(int dfd, const char __user *filename,
 			put_unused_fd(fd);
 			fd = PTR_ERR(f);
 		} else {
-			fsnotify_open(f);
 			fd_install(fd, f);
 		}
 	}
diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index a1b98c81a52d..10ca57f5bd24 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -150,7 +150,6 @@ int io_openat2(struct io_kiocb *req, unsigned int issue_flags)
 
 	if ((issue_flags & IO_URING_F_NONBLOCK) && !nonblock_set)
 		file->f_flags &= ~O_NONBLOCK;
-	fsnotify_open(file);
 
 	if (!fixed)
 		fd_install(ret, file);
-- 
2.34.1

