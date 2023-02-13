Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28077694F65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Feb 2023 19:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjBMSb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Feb 2023 13:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjBMSb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:31:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40D1C7C0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 10:31:52 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id v13so3979284iln.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1676313111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhELXdf05zY7CUQbBTvzj+Gb4RqQa3WJ6RXbjMshAvY=;
        b=NZV5uVS4lxJPp6p+1qBjsjYANGdxCjU7BFs2Bw5/LGTp+ssG20JBv/nuomJtaEkAar
         kWcxozx9PDBw6h5DQipSxnERGEJfQHqgMPDd7uF3YZdckcLeIE/Rq8wnigt9JVrWqJxr
         s9zdbhYDTE49SrvplNgADwzRqwTIFnNNmGRr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676313111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhELXdf05zY7CUQbBTvzj+Gb4RqQa3WJ6RXbjMshAvY=;
        b=BPO0ovNwNiAShYd1blwAXOyNJEcFQDtAldnZ1kN3pust4T7A51L3fwwD5DMq/B5d2Y
         a/53q5SP4sWCEX0idxGkM/8oVJluGwu5CAmZSZmNf6Wc1C8kIlrsauJHw3oACg2TbRYU
         UJ3sk0HMkzIR/MmjQ+LicDXWgwIenXBhQtFhzUbV4S/OTd5pieTYjPn6ahfCgExo1SO7
         m14twySCxQ800txrofHt44g9UBxb8CndVAIJLmVU3xewzjnGrSiad92usZADk62w8zPq
         R2XitkvvF8ew/MTtMa056qSjKle5dB15C+h4ZqfQvkGg8TdJ3wLbTOXFEMT7O7QpolXk
         MfdQ==
X-Gm-Message-State: AO0yUKWScso0ainyK+qjlJrDiDKwNsaTmbstf+vVH6Sc3DuChrqxPKDf
        keP4nYS/5trSDb3YCGi4fIxufA==
X-Google-Smtp-Source: AK7set8mpQPw2+GHtj5ZOfErydEdxIXuNq2fH1Iph/NA7mZTRndHLsb8zko5n9EIpwjE1fYaXs0icQ==
X-Received: by 2002:a92:d7c4:0:b0:313:fb1b:2f86 with SMTP id g4-20020a92d7c4000000b00313fb1b2f86mr14498260ilq.0.1676313111559;
        Mon, 13 Feb 2023 10:31:51 -0800 (PST)
Received: from shuah-tx13.internal ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t25-20020a02ccb9000000b0036cc14af7adsm4148662jap.149.2023.02.13.10.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:31:50 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, brauner@kernel.org, sforshee@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mount_setattr: fix redefine struct mount_attr build error
Date:   Mon, 13 Feb 2023 11:31:49 -0700
Message-Id: <20230213183149.231779-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following build error due to redefining struct mount_attr by
removing duplicate define from mount_setattr_test.c

gcc -g -isystem .../tools/testing/selftests/../../../usr/include -Wall -O2 -pthread     mount_setattr_test.c  -o .../tools/testing/selftests/mount_setattr/mount_setattr_test
mount_setattr_test.c:107:8: error: redefinition of ‘struct mount_attr’
  107 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/mount.h:32,
                 from mount_setattr_test.c:10:
.../usr/include/linux/mount.h:129:8: note: originally defined here
  129 | struct mount_attr {
      |        ^~~~~~~~~~
make: *** [../lib.mk:145: .../tools/testing/selftests/mount_setattr/mount_setattr_test] Error 1

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 8c5fea68ae67..582669ca38e9 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -103,13 +103,6 @@
 	#else
 		#define __NR_mount_setattr 442
 	#endif
-
-struct mount_attr {
-	__u64 attr_set;
-	__u64 attr_clr;
-	__u64 propagation;
-	__u64 userns_fd;
-};
 #endif
 
 #ifndef __NR_open_tree
-- 
2.37.2

