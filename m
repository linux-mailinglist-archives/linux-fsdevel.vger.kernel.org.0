Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3569759780D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbiHQUal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241972AbiHQUaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:30:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D7A98EE;
        Wed, 17 Aug 2022 13:30:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy5so26528119ejc.3;
        Wed, 17 Aug 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=svi6OaL8K/Etur8WtPrV1gQpFeKDk5ixCmOBfj3/KwI=;
        b=SEUS8d73nsNEDLK86FJHBjhtZ9/PyBfTry+vq0sygqBkXlNbr0DbbbUGVZ6pJm3/Jv
         5I9vkKnbkqXnn451MFHS0EkTb7ZA9XNgX5xJKANKOVZn6Zd+ctzl2nko50ClBAZwX88N
         tP1YntgrJkAggwMKCsn7MySB+DpLCktCOM882IJt/UKb9FXrCvuVv224465u77z++x0O
         Pm98a9Rj2QG1HEshlLFMU6Cs4rQjQkj8GJ7kDBqmmsmGjpr0o+2qvZfUiJYDuUaga5KE
         oW39H8fQaCsU6kmGmlqzgO7vM8pCvUtdj/OplO3IvYZWuLkrQ4ug68kDh3/t028pqjhB
         qmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=svi6OaL8K/Etur8WtPrV1gQpFeKDk5ixCmOBfj3/KwI=;
        b=M2yObFYXTk2kfKurUS3dYLvip8uhJdxW1LpzQwpMvpR6q+UvzHZlMvngaZ77YdVyKy
         vu+60TojxEXciSTMcS1Sc7f3dIwBKiDXO1OMW8TUUffXzGyrIdx1mcSBaR0/gsLNRDlf
         QZcPZ9S1pJa8RjrUWHW328wHCd+sOKUsU3xu2qODMeuDvbDkGn9dZC45sC9jP01caNwI
         mab8Q4zKka62bJj8Ul8Cq5zC4FqLwq8ej+4aozMfsbYuK+MNPg2TO9alGgEyxVVCOx61
         GtiWBn693s/T9snDaf0j6z8XDYPITMVAaYiwunQbWf2M1CuHrM3VyZA504OoySc1m2Ru
         OzkA==
X-Gm-Message-State: ACgBeo1s5+XZUPCr6LvfT8gvXcPGAYrzDvhgiz/zfbSmuL0cUFIVT7Vz
        20GNlCwAPbGrwiJQoYf403gbBhH0v7o=
X-Google-Smtp-Source: AA6agR6KmYqQn8GUUEIeYDEzEL5ToMsEGFleiUI4XBpIhcCN3zCRoda4tfRQaer7W0CtHVbw1Meofw==
X-Received: by 2002:a17:907:2721:b0:731:2aeb:7940 with SMTP id d1-20020a170907272100b007312aeb7940mr18399588ejl.448.1660768222615;
        Wed, 17 Aug 2022 13:30:22 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090653c700b0073b0c2d420dsm512042ejo.217.2022.08.17.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:30:22 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v5 4/4] landlock: Document Landlock's file truncation support
Date:   Wed, 17 Aug 2022 22:30:06 +0200
Message-Id: <20220817203006.21769-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817203006.21769-1-gnoack3000@gmail.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
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
 Documentation/userspace-api/landlock.rst | 52 ++++++++++++++++++++----
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index b8ea59493964..5c10872cb795 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
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
@@ -251,6 +262,24 @@ To be allowed to use :manpage:`ptrace(2)` and related syscalls on a target
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
 Compatibility
 =============
 
@@ -397,6 +426,15 @@ Starting with the Landlock ABI version 2, it is now possible to securely
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
2.37.2

