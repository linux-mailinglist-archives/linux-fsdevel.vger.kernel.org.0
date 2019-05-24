Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71E29FB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 22:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403967AbfEXUSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 16:18:40 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:57219 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403773AbfEXUSj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 16:18:39 -0400
Received: by mail-oi1-f201.google.com with SMTP id b10so4046583oie.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kiqJqxPa9FMe/un09kYlU9XPk6LJGKycCrLcq9tmZfQ=;
        b=Anfhow4oytGvhechQ9zPhynVUXijYqC90xGhkZDEgzZrQtziN47vmJAFkY94UCCIlA
         E3qo07I2DuK8VltI8krl/Mr380pl9cVobAYKmPCQ8fX8j1oOllILv+h8K5OlKVThjhQF
         TYSW7SHHMtlyDYgMrLILBQWOFLnGHQqi59qGRQlissn8Zrdz1UcQTFNRTRMWTzhda2kY
         jhmhOf2/lrgpO2q1kI6LDYQ42Y1PjL1IOMK1qscDlGQghyyI22DkZpOb+IdpvJWvkhHt
         aZVl3QpJRqrdcWDJ+9apVpJxVpnt7P5DLhApX2wc2H+XwVkS1Ap2zKuruVCdYtnN/Yas
         ptng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kiqJqxPa9FMe/un09kYlU9XPk6LJGKycCrLcq9tmZfQ=;
        b=E74vhLx5uy3fY6eFk/rSk7XBaG0ugjpQF6TA2atdSyP2vU0t7oRXqSD5WrNDDO3SRX
         pL0wL+VlkB4BCqhg59BFGuNdyyq9PJ5JJ01w+aFbmp52kETsDuevYs6ob8SsaRMjirJH
         S1QAm4gjHmSj5i1h7CMH3+4yTRE5Wh/MKX6I0OMqTa+5E9foDXE2nzeOo6Kaq/nGQbtM
         JIr1bWzjrvBjFJDsTT9yBCEWtk9cT6LeKGXV8iialVWRuh1nICgEe0CJ2xGLZibhtsSh
         7pcgr3+U91odloQqyeKqoXdDbTGKDIb4CuPzFCr1K38oWInhIH74VdAavOALDiXP31X4
         tQrw==
X-Gm-Message-State: APjAAAVwR7olzbEuKTmHzV+CNYbyQHvFF81ycERhq6vGLorswkQd7jjj
        aFt00cd1YpKkX3T7H2wHQWzV7k8pYg==
X-Google-Smtp-Source: APXvYqyxUrB2uWTPtatgkJdyTUHWio2wNv9xxBoB86a//J6xgGeH5e//FZbxRkGNMNApVpTcG5ZuCsGfTQ==
X-Received: by 2002:a9d:7987:: with SMTP id h7mr2154729otm.284.1558729118905;
 Fri, 24 May 2019 13:18:38 -0700 (PDT)
Date:   Fri, 24 May 2019 22:18:17 +0200
Message-Id: <20190524201817.16509-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] binfmt_flat: make load_flat_shared_library() work
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, jannh@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

load_flat_shared_library() is broken: It only calls load_flat_file() if
prepare_binprm() returns zero, but prepare_binprm() returns the number of
bytes read - so this only happens if the file is empty.

Instead, call into load_flat_file() if the number of bytes read is
non-negative. (Even if the number of bytes is zero - in that case,
load_flat_file() will see nullbytes and return a nice -ENOEXEC.)

In addition, remove the code related to bprm creds and stop using
prepare_binprm() - this code is loading a library, not a main executable,
and it only actually uses the members "buf", "file" and "filename" of the
linux_binprm struct. Instead, call kernel_read() directly.

Cc: stable@vger.kernel.org
Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
Signed-off-by: Jann Horn <jannh@google.com>
---
I only found the bug by looking at the code, I have not verified its
existence at runtime.
Also, this patch is compile-tested only.
It would be nice if someone who works with nommu Linux could have a
look at this patch.
akpm's tree is the right one for this patch, right?

 fs/binfmt_flat.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 82a48e830018..e4b59e76afb0 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -856,9 +856,14 @@ static int load_flat_file(struct linux_binprm *bprm,
 
 static int load_flat_shared_library(int id, struct lib_info *libs)
 {
+	/*
+	 * This is a fake bprm struct; only the members "buf", "file" and
+	 * "filename" are actually used.
+	 */
 	struct linux_binprm bprm;
 	int res;
 	char buf[16];
+	loff_t pos = 0;
 
 	memset(&bprm, 0, sizeof(bprm));
 
@@ -872,25 +877,11 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
 	if (IS_ERR(bprm.file))
 		return res;
 
-	bprm.cred = prepare_exec_creds();
-	res = -ENOMEM;
-	if (!bprm.cred)
-		goto out;
-
-	/* We don't really care about recalculating credentials at this point
-	 * as we're past the point of no return and are dealing with shared
-	 * libraries.
-	 */
-	bprm.called_set_creds = 1;
+	res = kernel_read(bprm.file, bprm.buf, BINPRM_BUF_SIZE, &pos);
 
-	res = prepare_binprm(&bprm);
-
-	if (!res)
+	if (res >= 0)
 		res = load_flat_file(&bprm, libs, id, NULL);
 
-	abort_creds(bprm.cred);
-
-out:
 	allow_write_access(bprm.file);
 	fput(bprm.file);
 
-- 
2.22.0.rc1.257.g3120a18244-goog

