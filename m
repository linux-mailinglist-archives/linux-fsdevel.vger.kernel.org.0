Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F81B17B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDTU6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgDTU6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E78C061A0F;
        Mon, 20 Apr 2020 13:58:18 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so13929852wrs.6;
        Mon, 20 Apr 2020 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QRT1wzQMBmwwO+9Yk8Tpugr8OoDuhlvGMhmG6vAGJg=;
        b=VErFtc8p5FgVeV8QdilC2z2fbaXoDv1sAJ2HJ6HfBg0NvTE5SxKcxkMi4QjrhWQZGg
         06buzM1cahhmxIeYk0841s2YLJugZTpE0Q4S0Y3QVD2dJeH0gT+Es1BaaXpqN9+m+R/3
         Ij7ryhVlFwha5TH3Q6E1JOpyXHeF6oGXAPA1ojHZQBIGWeqJsw0vxmLCe6hRYTQMFQb7
         iVpcvVq6LHq0Flml+wMu1kDbY/hjxYwIi+DSp3G3fhB5guV+aPOFnDIeZuSfE54a6/xn
         TJERmfZP4kuyP8EY+6P03MuaJ7dI9w//VylifFrm2sFE4AJjdBmNflscjDjH2gutX40O
         WqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QRT1wzQMBmwwO+9Yk8Tpugr8OoDuhlvGMhmG6vAGJg=;
        b=ka4Lt7gpwVxVQC1tYHWbVid3UqTAuKDWDktoKSUHJeTCSY11lqCzb58+bErllbMtP9
         j7BhQnQidr7USDo53+YeoRwRympJFCX02xn6MxNhuFIFSinqiAbv9jVwvYm40zxF4YcY
         Y+NazAD5OY4QK3ruLrni2Ed5RKJIzqMCqvdNAk/8hRoon9KJxDfXEKX7vgcYkll2M20/
         Ekgmr4hf1lEq7gqCV6FevwH1V1ayRxtKgYdvoV3CsRzOBQqUTpQr+oh7BCqntR7Sxy/z
         Z0nGD3Z0KrAUVy7O3sSVq6fcEBU9RPy4FAWWFHx0dP1s8OWbyqzdm8gTAR6BGG9N5U0t
         0xwA==
X-Gm-Message-State: AGi0PuanPKiSJGPUZZ3aO72RqmwbyqQFv9qdYk9ZOlAUFopmjkbEXVy6
        LOt5KKgKjL3RNLrvK7O3SQ==
X-Google-Smtp-Source: APiQypJBSz5LvNopVn2RdIRZMSwcIYUjBLodra6RphmAEVV9nHKmGlP/m2QDhq9pp0T9AZNnJLOLEQ==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr21203077wri.67.1587416296986;
        Mon, 20 Apr 2020 13:58:16 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:16 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 10/15] print_integer, proc: rewrite /proc/*/fd via print_integer()
Date:   Mon, 20 Apr 2020 23:57:38 +0300
Message-Id: <20200420205743.19964-10-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/fd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index e098302b5101..059a3404c785 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -247,8 +247,8 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 	     fd++, ctx->pos++) {
 		struct file *f;
 		struct fd_data data;
-		char name[10 + 1];
-		unsigned int len;
+		char buf[10];
+		char *p = buf + sizeof(buf);
 
 		f = fcheck_files(files, fd);
 		if (!f)
@@ -257,9 +257,9 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
 		rcu_read_unlock();
 		data.fd = fd;
 
-		len = snprintf(name, sizeof(name), "%u", fd);
+		p = _print_integer_u32(p, fd);
 		if (!proc_fill_cache(file, ctx,
-				     name, len, instantiate, tsk,
+				     p, buf + sizeof(buf) - p, instantiate, tsk,
 				     &data))
 			goto out_fd_loop;
 		cond_resched();
-- 
2.24.1

