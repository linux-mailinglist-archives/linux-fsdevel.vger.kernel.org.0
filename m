Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCB21B17C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDTU6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbgDTU6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:17 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E34C061A0C;
        Mon, 20 Apr 2020 13:58:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x18so13971900wrq.2;
        Mon, 20 Apr 2020 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SHn0IUO/wMyWf4dmZUNBbUc0aQhvnXEYVuFtFRS3HPk=;
        b=sYOvvc8pHTWkwLYyRhZCTaQv3HQfMB2rRRWZeysxNcQYbmmUOp2p3z72BwtJKY42cO
         D9O4GMHQugm296ZulvGVy0+bGU4QYzNx8wYsTtxch2rQk1pGGo8AUetdwwzkg2mRKPMI
         So4vh3Kn155oQtk193g2rUc5BHZ2DRoNrUtEqT1p9T1TZ0e41zhabPWE2PYPe92Tm7Nh
         O59mOM3iTwUAmkO4rPafQr8wG/VpIOXxY61N4mh9C0MI8xSONe68JPzqCDOjRi0o4UtO
         3FlMKKGoq2fd1gc0ocdRS+E5OdTykTDNftuMU95Foie7gc8he7WYm7uqQ7+CzfKHpXVX
         lkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SHn0IUO/wMyWf4dmZUNBbUc0aQhvnXEYVuFtFRS3HPk=;
        b=eno/8QSMYAb2omJEbKdVJ80Q3EedQLwHwKf7nUPW2odXfl0eByWY81oS3aDEdtBlXe
         OVZVQu/5+rrrFaEylRCMf3j2lckNJjhZbSN9JNN81KkVMUeTJO8BTVk6JsMJkr23dyKR
         odDZw/91LsV3VOe7VGCiH/hmj5F1D04zQrwvtC6J1hJpeHXkpbJqY46AaEl3kp1aVRET
         a19XnSPCzQcZYLTx8nj0PAUYdnhgr/WwncOMnHI4DiR70zzlnU8MRgbrxYun9kWZ9AK4
         fUSetp/ax/AhN1UwNgjdLJ/51KOAbUlBQirvIOO48gultjGrYr5SZv2X3MSLBwsbYJVf
         e6sA==
X-Gm-Message-State: AGi0PuZsocrNEg+2t0LYxROvxNpT3XU5aHQozt3DQwPYK4QBj8VjVbpJ
        czE5sq9iWpfRLXBKc3RoMg==
X-Google-Smtp-Source: APiQypLKNc2450WVam91XBOVv47aWlD4TeLe7WSZEd1VlY2LCaKg56Ic/Ldct6oBg/DIOV9rh1Ftiw==
X-Received: by 2002:a5d:4ac6:: with SMTP id y6mr20438480wrs.212.1587416296043;
        Mon, 20 Apr 2020 13:58:16 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:15 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 09/15] proc: s/p/tsk/
Date:   Mon, 20 Apr 2020 23:57:37 +0300
Message-Id: <20200420205743.19964-9-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"p" will be used for pointeg to string start, use "tsk" as the best
identifier name.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/fd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..e098302b5101 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -228,16 +228,16 @@ static struct dentry *proc_lookupfd_common(struct inode *dir,
 static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 			      instantiate_t instantiate)
 {
-	struct task_struct *p = get_proc_task(file_inode(file));
+	struct task_struct *tsk = get_proc_task(file_inode(file));
 	struct files_struct *files;
 	unsigned int fd;
 
-	if (!p)
+	if (!tsk)
 		return -ENOENT;
 
 	if (!dir_emit_dots(file, ctx))
 		goto out;
-	files = get_files_struct(p);
+	files = get_files_struct(tsk);
 	if (!files)
 		goto out;
 
@@ -259,7 +259,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 
 		len = snprintf(name, sizeof(name), "%u", fd);
 		if (!proc_fill_cache(file, ctx,
-				     name, len, instantiate, p,
+				     name, len, instantiate, tsk,
 				     &data))
 			goto out_fd_loop;
 		cond_resched();
@@ -269,7 +269,7 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 out_fd_loop:
 	put_files_struct(files);
 out:
-	put_task_struct(p);
+	put_task_struct(tsk);
 	return 0;
 }
 
-- 
2.24.1

