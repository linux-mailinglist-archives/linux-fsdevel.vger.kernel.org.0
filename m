Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9B37B403D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjI3MZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjI3MZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:25:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF27BD;
        Sat, 30 Sep 2023 05:25:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27761d85b31so7905502a91.3;
        Sat, 30 Sep 2023 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696076733; x=1696681533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxFdnF+d4GELCyBnxXMqf2wy+/Apt8AHrNw5TDGtQhE=;
        b=d96W7SC/Db06Z1PHimRnUIqL+POqHf9wkiU/0C0PNmovXeNkcHN/gOdzn4O7/DaYSz
         voDivJJ5Ek+xU7OZmHNAx3L9qGG87LYBPNFxvVXi0WztBU/+9eNczaqNoEg0LTVc3zcF
         N6oL2XKHwNPTnq+00//Uuw3YtDJp2mYSQOJq6g8rWeX3jiDwVdkaqJW+nGOJt09Q4ebJ
         mWC7CuzGh9ia6cq6XSddZUcOMH1gGQnNeuchOlMangsm/IgqltIU/MsCXpopRgrZXh1r
         tLQzaMkfd3Ye2tmV8qF7NG1uIxsStw8z6dpEWBhfz4rdNDwj6hC0sV9ObRUMv5smrQqH
         EMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696076733; x=1696681533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxFdnF+d4GELCyBnxXMqf2wy+/Apt8AHrNw5TDGtQhE=;
        b=qXP7SVKl0v1TQBX15z7Aa+BswS44BzpL+DTfbWfOGKmZ0e2Uqv3dLp1H5ztaRs0ar/
         xCHFlFmRiq1GwCjbDZms+uqCvqdVE+ijvQQ2hoEUvhOWGVmWgzjs+tdp1RKxRogncehI
         dm/fv8g/gvTOhbrBWV22EJWrcHNho9kTkVgO0UOB8gwtlvqdqaoLUK4BD4M4SPvFN0Hs
         61LHVYRxof0C7h4/s9a+wT/uBqtQiW89lrj3bPe6ixaiWALoAfejAU4s9/os6QGBf/OM
         jvqmCotrZHu5Vlw8D5uacGT7+cAHLo0vMkNBZZLVX40BrvBZ+KeA3gypqD5KNGNWUaku
         RsEw==
X-Gm-Message-State: AOJu0YzG0gONugrCXBYI2AIn3jIjFlgupzd9tHDCzT1sYxeK2OOMt2Jt
        cYHasdMM5vflW0YR/ZaIhTIU3m7EzCVViIHh
X-Google-Smtp-Source: AGHT+IEK0Xg6qzH2Dm4yIDx6l93pGNsG8+Wuig0p6FBvwt9f5BaAcmHS/LJYC3ybdLbpAIlHcN2gnw==
X-Received: by 2002:a17:90a:5217:b0:274:9409:bbca with SMTP id v23-20020a17090a521700b002749409bbcamr5793346pjh.3.1696076733186;
        Sat, 30 Sep 2023 05:25:33 -0700 (PDT)
Received: from swarup-virtual-machine.localdomain ([171.76.87.78])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a178900b0027463889e72sm3301661pja.55.2023.09.30.05.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 05:25:32 -0700 (PDT)
From:   Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
To:     shuah@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        swarupkotikalapudi@gmail.com
Subject: [PATCH] selftests:proc add missing field KSM in smaps_rollup[] array
Date:   Sat, 30 Sep 2023 17:55:23 +0530
Message-Id: <20230930122523.118173-1-swarupkotikalapudi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Missing field KSM is added in g_smaps_rollup[] array as it
fixes assert in function test_proc_pid_smaps_rollup()

Without this patchset test fails for "proc-empty-vm" as can be seen below:
$make TARGETS="proc" kselftest
...
  selftests: proc: proc-empty-vm
  proc-empty-vm: proc-empty-vm.c:299: test_proc_pid_smaps_rollup:
   Assertion `rv == sizeof(g_smaps_rollup) - 1' failed.
  /usr/bin/timeout: the monitored command dumped core
  Aborted
  not ok 5 selftests: proc: proc-empty-vm # exit=134
...

With this patchset test passes for "proc-empty-vm" as can be seen below:
$make TARGETS="proc" kselftest
....
timeout set to 45
selftests: proc: proc-empty-vm
ok 5 selftests: proc: proc-empty-vm
....

Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
---
 tools/testing/selftests/proc/proc-empty-vm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/proc/proc-empty-vm.c b/tools/testing/selftests/proc/proc-empty-vm.c
index b16c13688b88..ee71ce52cb6a 100644
--- a/tools/testing/selftests/proc/proc-empty-vm.c
+++ b/tools/testing/selftests/proc/proc-empty-vm.c
@@ -267,6 +267,7 @@ static const char g_smaps_rollup[] =
 "Private_Dirty:         0 kB\n"
 "Referenced:            0 kB\n"
 "Anonymous:             0 kB\n"
+"KSM:                   0 kB\n"
 "LazyFree:              0 kB\n"
 "AnonHugePages:         0 kB\n"
 "ShmemPmdMapped:        0 kB\n"
-- 
2.34.1

