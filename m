Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302A5F84F9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJHLSa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiJHLS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:18:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD34D26F;
        Sat,  8 Oct 2022 04:18:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id k2so16171142ejr.2;
        Sat, 08 Oct 2022 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCqE9e12XoBqA5RscNmFvGeITIorfGLdOj2bFbTji74=;
        b=Mc4cFSxZtwA/sDJ40eW+H2GgdAF86Y1598mToQUqMSrusl6xQfIe1zvNXA4eBGxan6
         ClkBIK1Jnpnzo9dbOZieAGKUWNmRwIuTZZy6ajTEMbaxGjYmc2fC2oD3bkADlA7vO3c3
         SE3wuyAiFNU355N9frrxMYOiSvKB5pvS4b0UImPYAAq6l2zuhZ7wV8DaD22+/6Y+kiY4
         3LJN1Qemjfnn0dX1Q2me508n+uLDCkvKXyTPptvq0lbzrBT4BMydYvT4mWIU/t4c4gHt
         eybD6htWzUXifbXpGHgWxHScpWhfeicJZMK+jXeT8B5Fidutki8qQMdo7+1xEHH6v4yG
         J3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCqE9e12XoBqA5RscNmFvGeITIorfGLdOj2bFbTji74=;
        b=Vu+roTiN5iPrVv+HGQ9IYz+SJLV119p21ce/ypjkdjgDmY/AVDBDtSXmCZTWUBtfgR
         zpNuGi/e1Sc6Ajbc7AFkB1PsOM+K7YWWtWoBkJmw3SjFaVkA3vObI00zsX1Vx4+vNPY3
         MZL1MxHutIHcJ3oUGx0Yp26MZcs67ctkwTz9eVK0G9nye3AZAiE+cLOOqhBW+BO+kDJU
         KDOsFpv7xoRv5VWCXCcyDfTvfCR5XzwxmoGiyI41Wrqb9rHHC6uWzPXQMldkLFGP9syR
         kHSOuwsck9Bo++jDMnkk+duyaxgkAtuItlFKCJPpYziK8NAyS//wNbt5c5OBv0CtDbB+
         5sow==
X-Gm-Message-State: ACrzQf2DG7T3kczaqfd59AyPC24lw31cP8QM2bh+wKzi6Ya5U1dJ1zdB
        jGPVpkB5fnuwga1jKIsphegRsLU8s4k=
X-Google-Smtp-Source: AMsMyM4HQbxs2uOdzHepyw1r3znobYMqMayzagWAynLBuy10ibyYIszzsWEzucrGDVE9s+73N2vvKQ==
X-Received: by 2002:a17:907:608f:b0:787:a1ae:1d3b with SMTP id ht15-20020a170907608f00b00787a1ae1d3bmr7422718ejc.431.1665227905811;
        Sat, 08 Oct 2022 04:18:25 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906218100b0073ddd36ba8csm2580136eju.145.2022.10.08.04.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:18:25 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v9 11/11] landlock: Document Landlock's file truncation support
Date:   Sat,  8 Oct 2022 13:18:14 +0200
Message-Id: <20221008111814.75251-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008111814.75251-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
 <20221008111814.75251-1-gnoack3000@gmail.com>
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
 Documentation/userspace-api/landlock.rst | 67 +++++++++++++++++++++---
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index cec780c2f497..d8cd8cd9ce25 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -8,7 +8,7 @@ Landlock: unprivileged access control
 =====================================
 
 :Author: Mickaël Salaün
-:Date: September 2022
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
@@ -69,16 +70,28 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the ``LANDLOCK_ACCESS_FS_REFER`` access right which is only supported
-starting with the second version of the ABI.
+remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
+access rights, which are only supported starting with the second and third
+version of the ABI.
 
 .. code-block:: c
 
     int abi;
 
     abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
-    if (abi < 2) {
+    if (abi < 0) {
+        /* Degrades gracefully if Landlock is not handled. */
+        perror("The running kernel does not enable to use Landlock");
+        return 0;
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
@@ -127,8 +140,8 @@ descriptor.
 
 It may also be required to create rules following the same logic as explained
 for the ruleset creation, by filtering access rights according to the Landlock
-ABI version.  In this example, this is not required because
-``LANDLOCK_ACCESS_FS_REFER`` is not allowed by any rule.
+ABI version.  In this example, this is not required because all of the requested
+``allowed_access`` rights are already available in ABI 1.
 
 We now have a ruleset with one rule allowing read access to ``/usr`` while
 denying all other handled accesses for the filesystem.  The next step is to
@@ -252,6 +265,37 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
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
 
@@ -398,6 +442,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
 control renaming and linking thanks to the new ``LANDLOCK_ACCESS_FS_REFER``
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
2.38.0

