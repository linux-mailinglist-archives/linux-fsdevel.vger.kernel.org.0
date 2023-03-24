Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0866C7564
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 03:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCXCPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 22:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCXCPD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:15:03 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CC2A6E3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 19:14:31 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso3727957pjb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679624067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjZ8tIr/PF8OJoYSDIjMzoT6havTlKl8dZ9y/Hrp13w=;
        b=qKECIUkHVbjZx7eY07qrnQUNaRjut4Aq+BCaYeyZW3CbhzrPFyHxWkBwxz3M6pEXLH
         9nK+tSd5Ece2GHNkYeTq0ab3JStx/jBtBZENITfvCjitU8N5nDDlkGAnomH568vIYV1Y
         oD6ve+pKeIZ18KIDN+NlqJk3jh0B4DUH2eHz/Rrg+n/4RpKO/2PMg0s154MqnGIiYvni
         cnqQWbN/lANKekY4gQ5VAlOKHGwfJPil70hl7KBg2tbnXELpbBV0ENunlZ6emYmZDiuV
         /CArHbuFUCQOwkOI+oYbE4jbLYMfj7LsSh1k776KD9fne3OpuXo8kpadq5cxrlV8euHs
         hNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679624067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjZ8tIr/PF8OJoYSDIjMzoT6havTlKl8dZ9y/Hrp13w=;
        b=lPAp4LHsshP5L/OUWzsx0wy3MVkMx03CZISkBPKEwrNzpSDNZKIgnMeo+bMALM6d5Z
         Gwu/qYjde9RGAz4qSA/TvRZ+1ovSTalKxqmlYfauAC6cfMje4Gjm1hBvrWNdmwuLuo+a
         s9LAtG/EsYhxstUPzOZiXdStfbVn2wRlRJ8y8BIWm7yvdpp0z9Fw1MvVxOqtswA4CSq4
         xH1dj7xhviRnR7fLmdMmIaLR2RGd7jgqgwK3GlCAxxLlHLFm6b/wviFd+9E/rK7D+ceE
         AiBwMyumlqvbjxLDKH7YJXfuG/458D3yH7pJ8nbbUp6xDtuFKVEFHgwKw9GaidSQdvm7
         se0g==
X-Gm-Message-State: AO0yUKUpz0g1Pvl6lU7bDyf5qV/bS72pV5nSYuy/pVkkzy01HQc+a03x
        76IpE3ZG7gN97s7gAxebrZEQXXm6mE1lDdlgdyw=
X-Google-Smtp-Source: AK7set8OImd5shd8MnxakXcmYgfHCdt7YJw9IFjm44AA+74PF6ay96ajaQUMywf4qOtIzLWNeAc73g==
X-Received: by 2002:a05:6a20:811a:b0:d5:7704:f362 with SMTP id g26-20020a056a20811a00b000d57704f362mr1382121pza.56.1679624066965;
        Thu, 23 Mar 2023 19:14:26 -0700 (PDT)
Received: from pop-os.lan ([14.232.107.112])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78150000000b005825b8e0540sm12547010pfn.204.2023.03.23.19.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 19:14:26 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     sforshee@kernel.org
Cc:     brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
        tuananhlfc@gmail.com
Subject: [PATCH v2 1/1] selftests mount: Fix mount_setattr_test builds failed
Date:   Fri, 24 Mar 2023 09:14:15 +0700
Message-Id: <20230324021415.17416-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZByVac3GsD7RFuaj@do-x1extreme>
References: <ZByVac3GsD7RFuaj@do-x1extreme>
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

These errors might be because of linux/mount.h is not included. This patch resolves that issue.

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
Thanks for replying so quickly, this is my first patch to the kernel. I
changed the include to use angle bracket as your suggestion.

 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 582669ca38e9..c6a8c732b802 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -18,6 +18,7 @@
 #include <grp.h>
 #include <stdbool.h>
 #include <stdarg.h>
+#include <linux/mount.h>
 
 #include "../kselftest_harness.h"
 
-- 
2.34.1

