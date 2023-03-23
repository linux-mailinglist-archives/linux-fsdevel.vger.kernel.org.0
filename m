Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BD26C6ED4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjCWR3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjCWR3H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:29:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0C3C0C
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 10:29:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso2784613pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 10:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679592546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMZZ6Tcdapuhof/i/nzGFRj0fuePe+lfLjf6gEGMDaA=;
        b=JJQB8Vr7MplIrOqQUE8j55kUWU8R1tdzDxkeHZs3Z7Nt8qpYMbNhVkS8ZIlr7Uw7Xw
         YwPNZFfFX4igQz695AHv9CN6P3BZHPaJp3F0FAGBeEo/0TNWPHXta+l7PQTNTu3gmuoD
         qNfnrAc2JdgzK2eOYF5ncFkLnUQc+hFpc5ehSEYBqqZgX2/tXtuc+sRUJBeUnS9EIl3T
         F+kNvm169HmX4YwjNGFORfoXD7bseQzue33WIjaqPHRIX7h4RlMf5gEqyrwNe8vOabaO
         2H9kV7PGuUFH9m7PX5eHbOrslRKoUVAoqUM74pygwOGaVfEWvv+pvqgSXauPrqCvMcjj
         6DwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMZZ6Tcdapuhof/i/nzGFRj0fuePe+lfLjf6gEGMDaA=;
        b=hY1iRwkVqQGwg1wmui1YsbpOTRRB7Lw7ZLJC1s0tbiq6Xfk3hWo4gCa2fW/i7bI81a
         DO3MCLT+fgEulSg7Ydzmg1a87vfr19ssGHJlRT+CwEsmukA9zN3n2o7emPTJh455R4d5
         INPk7Wobs7Q0u6ap47fG84odZaTc+cveZfJ0OgdIvw/6CSPac0E1ByUelyfCGJdCgUx3
         XScz2gIP9PlxFzNulzVdGAbFrAiRgef95shBsyuwtZcGnjE19jG57mT/aYYXMGR5DKUN
         8XM0+8YF58jlUmbaS2VYz0oXwDjoFK3/F+P0ceAS/4zk86C9UXZ/WzV7mjmvUYKa10c+
         AULw==
X-Gm-Message-State: AO0yUKX2NJ/wL8z0idThokhSDkiRJ5lPo3GJ4TAmtUYViio+kZ5VvYK5
        2CP50gYEj9MxD3ESHucVnaEKxjaG4n9bdbGQ
X-Google-Smtp-Source: AK7set+u9tUFLPhTIUjtBT8TxguYuKCL7Y8+0lU2tr8K8Iyjx83VlHZ5GwHr+11lqr4smZ3/h/bDpA==
X-Received: by 2002:a05:6a20:49a9:b0:da:5ab7:8cf3 with SMTP id fs41-20020a056a2049a900b000da5ab78cf3mr3492515pzb.30.1679592545666;
        Thu, 23 Mar 2023 10:29:05 -0700 (PDT)
Received: from pop-os.lan ([14.232.107.112])
        by smtp.gmail.com with ESMTPSA id s10-20020a62e70a000000b00593e4e6516csm10706427pfh.124.2023.03.23.10.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:29:05 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     brauner@kernel.org, sforshee@kernel.org, shuah@kernel.org
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] selftests mount: Fix mount_setattr_test builds failed
Date:   Fri, 24 Mar 2023 00:28:59 +0700
Message-Id: <20230323172859.89085-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When compiling selftests with target mount_setattr I encountered some errors with the below messages:
mount_setattr_test.c: In function ‘mount_setattr_thread’:
mount_setattr_test.c:343:16: error: variable ‘attr’ has initializer but incomplete type
  343 |         struct mount_attr attr = {
      |                ^~~~~~~~~~

These errors are might be because of linux/mount.h is not included. This patch resolves that issue.

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 582669ca38e9..7ca13a924e34 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -18,6 +18,7 @@
 #include <grp.h>
 #include <stdbool.h>
 #include <stdarg.h>
+#include "linux/mount.h"
 
 #include "../kselftest_harness.h"
 
-- 
2.34.1

