Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A55B274D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 21:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIHT7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 15:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIHT64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:58:56 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88C1114A46;
        Thu,  8 Sep 2022 12:58:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bq9so15076378wrb.4;
        Thu, 08 Sep 2022 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QRKJty4JdUmvaojGTlGrAJV1Z6zD33ZGAy1IL0bKdMs=;
        b=KqfnRH5VosRmystPbhSAtj3K7cPU3jJ3nRVWtglrC5Ta6W/gmdfIcjpp5lgBCDfGbt
         PU2wacbSrFX7l8FmrPNAApVzbUHXBKgug8jfPmTnbHwisOWwtqGz8FgVK8qgN/0TUmA/
         xkWF8b45LDY4ckvdv1W4RgWqR1QgOy7YiIs8zDY910CsTwBE9kbINEijgJO6gA11Prjo
         jCoOqg5RekhMY3lH+BNBmuE9CGdT106yC5aMIYNlkuMeDkNBPfjibwEBfXqfzS9IspWU
         NECLu/AUQEGKO6IQunaPKGjZgBSJvBRUy9TNVuhaZXzv0bnoaZxNlGtGPi5Mf+FlhdEb
         YK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QRKJty4JdUmvaojGTlGrAJV1Z6zD33ZGAy1IL0bKdMs=;
        b=PymZloFvtPz/Up6424LYRAnO2LaPZF3Tylt/aGROPBgBkt6Bdwd6YeJNaE7rwOcqgB
         FZEwy+LpaQi/iNLEgd+cScTw6nM+xpasCpR8LGiCR3of0qBhordgpeI7gaW9GvZXQpA2
         22OvLwZjSc+Wy+2kX2Lj0DWVQ9Sm+B39rjo97CzdkdVKiEABP0zQ6zktkLxYEvHKxbcg
         FjYnQ1omvvHens8wbfBqk3XTuPuIdC2UgodK8gpUT0FJ3AFOytNf5ehhJA0PC5DhQRYi
         z6/AR+2clHt77u2AkkHbZg6xRh1ngbJI/8DT2FJko6TAxWEbXq8zMMuIUzDgwcvRcBGU
         vAaQ==
X-Gm-Message-State: ACgBeo0dlfkZnPB2skyA/kvCyz+swwq2npH0lVJxJWmB8IRw1Uc1td9J
        13J4Kq3+WAt7mvCn1P5laQFouNm4fuA=
X-Google-Smtp-Source: AA6agR6tuunq4wfCM8i9Q2HWeE3h5hTtepy8+aBJKIZ1qsf1At0cxfqmrQ8Bo+hTCpNWOvgJ6w8WWA==
X-Received: by 2002:a05:6000:12c5:b0:228:d235:4daa with SMTP id l5-20020a05600012c500b00228d2354daamr6158841wrx.595.1662667095297;
        Thu, 08 Sep 2022 12:58:15 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c2d5600b003a541d893desm3360682wmg.38.2022.09.08.12.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 12:58:14 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v6 5/5] landlock: Document Landlock's file truncation support
Date:   Thu,  8 Sep 2022 21:58:05 +0200
Message-Id: <20220908195805.128252-6-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908195805.128252-1-gnoack3000@gmail.com>
References: <20220908195805.128252-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the LANDLOCK_ACCESS_FS_TRUNCATE flag in the tutorial.

Adapt the backwards compatibility example and discussion to remove the
truncation flag where needed.

Point out potential surprising behaviour related to truncate.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 62 +++++++++++++++++++++---
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8ea59493964..57802fd1e09b 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: May 2022
+:Date: September 2022
 
 The goal of Landlock is to enable to restrict ambient rights (e.g. global
 filesystem access) for a set of processes.  Because Landlock is a stackable
@@ -60,7 +60,8 @@ the need to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_FIFO |
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
-            LANDLOCK_ACCESS_FS_REFER,
+            LANDLOCK_ACCESS_FS_REFER |
+            LANDLOCK_ACCESS_FS_TRUNCATE,
     };
 
 Because we may not know on which kernel version an application will be
@@ -69,16 +70,26 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
-starting with the second version of the ABI.
+remove the `LANDLOCK_ACCESS_FS_REFER` or `LANDLOCK_ACCESS_FS_TRUNCATE` access
+rights, which are only supported starting with the second and third version of
+the ABI.
 
 .. code-block:: c
 
     int abi;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
-    if (abi < 2) {
-        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+    switch (abi) {
+    case -1:
+            perror("The running kernel does not enable to use Landlock");
+            return 1;
+    case 1:
+            /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+            __attribute__((fallthrough));
+    case 2:
+            /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+            ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -127,8 +138,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -251,6 +262,32 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+Truncating files
+----------------
+
+The operations covered by `LANDLOCK_ACCESS_FS_WRITE_FILE` and
+`LANDLOCK_ACCESS_FS_TRUNCATE` both change the contents of a file and sometimes
+overlap in non-intuitive ways.  It is recommended to always specify both of
+these together.
+
+A particularly surprising example is :manpage:`creat(2)`.  The name suggests
+that this system call requires the rights to create and write files.  However,
+it also requires the truncate right if an existing file under the same name is
+already present.
+
+It should also be noted that truncating files does not require the
+`LANDLOCK_ACCESS_FS_WRITE_FILE` right.  Apart from the :manpage:`truncate(2)`
+system call, this can also be done through :manpage:`open(2)` with the flags
+`O_RDONLY | O_TRUNC`.
+
+When opening a file, the availability of the `LANDLOCK_ACCESS_FS_TRUNCATE` right
+is associated with the newly created file descriptor and will be used for
+subsequent truncation attempts using :manpage:`ftruncate(2)`.  It is possible to
+have multiple open file descriptors for the same file, where one grants the
+right to truncate the file and the other does not.  It is also possible to pass
+such file descriptors between processes, keeping their Landlock properties, even
+when these processes don't have an enforced Landlock ruleset.
+
 Compatibility
 =============
 
@@ -397,6 +434,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
 control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
 access right.
 
+File truncation (ABI < 3)
+-------------------------
+
+File truncation could not be denied before the third Landlock ABI, so it is
+always allowed when using a kernel that only supports the first or second ABI.
+
+Starting with the Landlock ABI version 3, it is now possible to securely control
+truncation thanks to the new `LANDLOCK_ACCESS_FS_TRUNCATE` access right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.37.3

