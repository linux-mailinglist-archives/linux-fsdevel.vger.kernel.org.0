Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74B5F0F8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiI3QDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiI3QCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:02:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C11B0E31;
        Fri, 30 Sep 2022 09:02:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nb11so9974419ejc.5;
        Fri, 30 Sep 2022 09:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3yKms8AKRzFfDi33PhwXrFrwuGPdadmIT5ZGKIDnFV8=;
        b=HUjcbO5qLJL7WhMNzFFYSeT2a5hNyYd+VbCLDZ1E5WE/w7qTCbjxBZKzrz1JE1e/PP
         LEAxmLnyHCyHEfR1V0sydyzOLCi8/dbxOChArQS3vigArM6l1WFOOVVDkthvJpx0EbJb
         8N9OssMrfXdCPOZ83LQwdyllDXYN46jsvb8i93lX3RbXQQZ05rnWWiqk2XW63JuBma9U
         xG9CfQsLuLRvGE830+40tQ0SGvGj98NQozDeyx2fEhprWoa7YJhn72sGtEsfY0KgaM3t
         1IYww6hGXGXN8Z4iUc/NQsl0/9KVowa5lLSPsi9hxMwk6u1g1SM+BgDpph9rNp6Me8Xn
         bi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3yKms8AKRzFfDi33PhwXrFrwuGPdadmIT5ZGKIDnFV8=;
        b=ShgbkU51mJHaOKSSEod8WJ+9kUSIbxR8j2njqQN+hVrVfDAzls+RnryhhY5X3/xpjI
         P1SktwXnw2a02jsMSU2dRVCdGcckN/HSl06St90TlznPYlk7Mvz+lZa9Z0ZpKBrgKPxl
         FabTD1MNRp+jhYMLuIqD07oHIJmpNfhji4WaX1Y1zMT9H8vjrGaRzqMPbGBEtlpzdwP5
         ustZHzfHGMpeRLX0Fd2nhvW11NPqP4sJ54EyKaaFT7Gi3kVIaWKBY9/tRbv7nGQLfxUM
         wBZaPS215hkEG8nwHZSCoRSvkjI2sulQk/0CqTNihMrzsr6Nrh7JqfCJo4vwaiYkhm0Q
         Gyxw==
X-Gm-Message-State: ACrzQf2DpGIPfP5oJNflhq5QNn+qogwd0A+jaYX1aH2Y/B9IwTiymZ+C
        pLQzNV0fURIdaca5M02N+bR0v/xnXnc=
X-Google-Smtp-Source: AMsMyM71Xfnl7pGLFZKvWI7hVFP4JDPanUWCO92/4jNSgbGKb48qeuV1lNCErW1UCKK/z2ODbm9hYQ==
X-Received: by 2002:a17:906:8a57:b0:781:9705:df89 with SMTP id gx23-20020a1709068a5700b007819705df89mr7067153ejc.266.1664553735400;
        Fri, 30 Sep 2022 09:02:15 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b004588ef795easm927583edx.34.2022.09.30.09.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:02:15 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v7 7/7] landlock: Document Landlock's file truncation support
Date:   Fri, 30 Sep 2022 18:01:44 +0200
Message-Id: <20220930160144.141504-8-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930160144.141504-1-gnoack3000@gmail.com>
References: <20220930160144.141504-1-gnoack3000@gmail.com>
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
index b8ea59493964..408029b120bd 100644
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

