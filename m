Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE35F1D5A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJAPuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJAPtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6311447;
        Sat,  1 Oct 2022 08:49:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lc7so14618933ejb.0;
        Sat, 01 Oct 2022 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f+KOAWe0KhtMfqIYi9lmduYl89HXgRqfpeb+3Xps7X0=;
        b=JCZpl02+JQmwy/XJQKMYNcAoaoIfWYjZpvqR9X+JB6HoFgWbkul+aEo0fKEdLmzck2
         QGvVjFHtokL4tBwAF+ZCIzKsID6ExoMDxhGbRjOV76Le2u19FzBqBUav6HskZLKqFjvZ
         +uNVQ/p7nWzCFVtsETinntlJUHZvircrgsbmF52Eyr5Rl2QFkfI8UgFAAzbX+Ed8PBZa
         dgMYg4NLUpsAZwMajjHIk9oPqmKFUQrf6qfRZJ0esNwn0U+CCRWN+d9PvIwAspJhPANd
         K1WAgsZ558q2Asnis41Aphsh1yzhJN3PDq0N53oKKmu8MW423qCIVOS6gxz4AT5TeoH9
         hiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f+KOAWe0KhtMfqIYi9lmduYl89HXgRqfpeb+3Xps7X0=;
        b=fLJylHi6k3hB/HqB9lKlZLvh12QSB399u9c3rN4OubrVBkwy4jVUYfaAJr4Fd/MUj5
         tkOdMohUNBvQ417NWrGbiTow7b8h16uftGZF1XTm52qNib8OdnXx3faEj36qJX5k4+SE
         bkc/ax3cbrpGs/zoV533jZEyizJ8M91eS/OhAVcDVn5jPwdonYOZoQcAzUXtzIcEu1no
         3thsul+1ye+HNlwZW/cNzl71RrEdvkJS5EQvrivzQCG06b1Lh9SlwHzyP+6cWMwXWfBK
         I4hVZbRp729n5WMwjiMjiIozjlGyoYgPstw6HQQiBZbPog2ABFj8Kk++ip5Y6eKUGtif
         m0yw==
X-Gm-Message-State: ACrzQf3nxLWkOsQQ/xwgnU7DOalgSj+SpCvVpzz8154D7Uf2HpccG0Gc
        38C9pG59BVPppNs4KFrSttrjEFtrH3U=
X-Google-Smtp-Source: AMsMyM7JjgB5TM0RJ2FVWlXc+NxkH/6IIkNeynX+ipuNTXA2D0Xb8F13w2ZCBTX4TwaY6yPRQ2kstg==
X-Received: by 2002:a17:906:4fcf:b0:781:cb5a:dfa5 with SMTP id i15-20020a1709064fcf00b00781cb5adfa5mr9705827ejw.213.1664639382909;
        Sat, 01 Oct 2022 08:49:42 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:42 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 9/9] landlock: Document Landlock's file truncation support
Date:   Sat,  1 Oct 2022 17:49:08 +0200
Message-Id: <20221001154908.49665-10-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 Documentation/userspace-api/landlock.rst | 66 +++++++++++++++++++++---
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8ea59493964..44d6f598b63d 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: May 2022
+:Date: October 2022
 
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
@@ -69,16 +70,27 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the `LANDLOCK_ACCESS_FS_REFER` access right which is only supported
-starting with the second version of the ABI.
+remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
+access rights, which are only supported starting with the second and third
+version of the ABI.
 
 .. code-block:: c
 
     int abi;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
-    if (abi < 2) {
+    if (abi < 0) {
+        perror("The running kernel does not enable to use Landlock");
+        return 0;  /* Degrade gracefully if Landlock is not handled. */
+    }
+    switch (abi) {
+    case 1:
+        /* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
+        __attribute__((fallthrough));
+    case 2:
+        /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -127,8 +139,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-`LANDLOCK_ACCESS_FS_REFER` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -251,6 +263,37 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
 process, a sandboxed process should have a subset of the target process rules,
 which means the tracee must be in a sub-domain of the tracer.
 
+Truncating files
+----------------
+
+The operations covered by ``LANDLOCK_ACCESS_FS_WRITE_FILE`` and
+``LANDLOCK_ACCESS_FS_TRUNCATE`` both change the contents of a file and sometimes
+overlap in non-intuitive ways.  It is recommended to always specify both of
+these together.
+
+A particularly surprising example is :manpage:`creat(2)`.  The name suggests
+that this system call requires the rights to create and write files.  However,
+it also requires the truncate right if an existing file under the same name is
+already present.
+
+It should also be noted that truncating files does not require the
+``LANDLOCK_ACCESS_FS_WRITE_FILE`` right.  Apart from the :manpage:`truncate(2)`
+system call, this can also be done through :manpage:`open(2)` with the flags
+``O_RDONLY | O_TRUNC``.
+
+When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE``
+right is associated with the newly created file descriptor and will be used for
+subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavior is
+similar to opening a file for reading or writing, where permissions are checked
+during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
+:manpage:`write(2)` calls.
+
+As a consequence, it is possible to have multiple open file descriptors for the
+same file, where one grants the right to truncate the file and the other does
+not.  It is also possible to pass such file descriptors between processes,
+keeping their Landlock properties, even when these processes do not have an
+enforced Landlock ruleset.
+
 Compatibility
 =============
 
@@ -397,6 +440,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
 control renaming and linking thanks to the new `LANDLOCK_ACCESS_FS_REFER`
 access right.
 
+File truncation (ABI < 3)
+-------------------------
+
+File truncation could not be denied before the third Landlock ABI, so it is
+always allowed when using a kernel that only supports the first or second ABI.
+
+Starting with the Landlock ABI version 3, it is now possible to securely control
+truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.37.3

