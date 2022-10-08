Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE155F84EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 13:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJHLNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiJHLNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 07:13:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA0E50F9E;
        Sat,  8 Oct 2022 04:13:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k2so16156731ejr.2;
        Sat, 08 Oct 2022 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCqE9e12XoBqA5RscNmFvGeITIorfGLdOj2bFbTji74=;
        b=EyjeljUZ0zV6Z8u3UFOaFlCImS4ar8/ivtmgCiAy2D+hgNHEsVluG1yeRxBxm6Kt86
         yO6c5hQN8pCJRXutyIny62vlqYvKIAyueApI0CH+XnSwxsNRXSn4vrsyaSdLYMBFPsd4
         3m0aHEbbcAEkd40jLmwTQy1WKYcG+/KuEPeYX7RN7FAlusBleTdv6EAZMFhV2tU03iP6
         WMC0wgiVQSZDniAyab2KKBv4m9jsukBlpHxmwbWdiRPHvskceTQZuCATMFcI6zm0IpM4
         8BGfrV7JPApABaDAkwPCLlQIqr7c5f4AhOHj0JL9TQ0/EP3wl/SpzLl9IYmmPoJWlcDa
         ZXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCqE9e12XoBqA5RscNmFvGeITIorfGLdOj2bFbTji74=;
        b=zhOq8kyywKZAO6mAll9lZHbUUZfXu43eyI8RK+WoKFOJWdl5qpM8Lm2O2XNEgtmzVB
         ajHF/mmWTxELLJ5xLuWPxxSyjStx/V2zflnfVRMm0Iu6ZMMW1Ys8m9oOy95VZ9e+krbB
         ZvLVVq0A2l02FPXBuEpMDCREarlMaUiLnkny5Pcjo0tlFyjpg4+xV7vZ10B1BOexygrh
         hNoS/ASsrcRolSFk8wSwDuW3RYMMif4nAuhEdw5DK6mGeFrk7S+dfjUjgBsZf+PGH9nk
         8O9gEDGlNUYrtoa5HO/5xCttXM+LCvyr6Nqxg790PgHXTjiWkgDcDHh2b80duPjtpHRm
         suCg==
X-Gm-Message-State: ACrzQf1N0E5ghlhFQDYkKJQTGxQRcvIx9FSIsRYdvMHG4lEeEJwY6jsr
        qkqj8edKoPTVTSUp22Sv0y//bwj8o/Y=
X-Google-Smtp-Source: AMsMyM6j0trNAW6VhtifcXgmxCCwsixLUApSU4//Ai6NfudocS11tkyTMzd8dXB/h1HUc5IwAwrHlw==
X-Received: by 2002:a17:907:1c98:b0:78d:3b06:dc8f with SMTP id nb24-20020a1709071c9800b0078d3b06dc8fmr7363353ejc.58.1665227619607;
        Sat, 08 Oct 2022 04:13:39 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id kt25-20020a1709079d1900b0078d886c871bsm1740312ejc.70.2022.10.08.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 04:13:39 -0700 (PDT)
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
Date:   Sat,  8 Oct 2022 13:13:36 +0200
Message-Id: <20221008111336.74806-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008111336.74806-1-gnoack3000@gmail.com>
References: <20221008111336.74806-1-gnoack3000@gmail.com>
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

