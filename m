Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512686AFD41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 04:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCHDKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 22:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCHDKk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:10:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08EFA6BEA
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 19:10:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so917334pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 19:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mu++duLa1HYXQoRgD8CJqzoZQ47PM9+K5ZhAEIOsBg=;
        b=t5MN5n7flANBYusBMPHvSi5UTma9LxmdEzfB5UIPRgjv5UWMPr5ZDk53ddKJLuIAtw
         Ou5IgUxYkSII/HL/91pnnv+QAfBgghSTfymF2almtDsRgcIy2cQm4jTqxGko1Aj2AkTQ
         CAKeRmbK5SxP7gV7C5P0+AGBtRBwtGDRRFCujj8OnnBiaV2UO5RmB3uGasv0+ejdE+X1
         UwOKh4rYsD3QoBORHoAftlk91QjWt0rTNIqOz65Q9Gc40kEUPrfC/UyX5GzdmwRdTGcK
         S0S1SUxF6b7IzTn7rTC/hrwEjm8+cnRUxu4Fk1yeEcrqSUjCC0z117xetTn27GKTN1K2
         7C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678245039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mu++duLa1HYXQoRgD8CJqzoZQ47PM9+K5ZhAEIOsBg=;
        b=WQgTuellAvaWx59IoI0GQnssoPw85pTwQS51QENoMdX3L+wLUatlP4Aky1imMpUyin
         k7KzhT5uZ1VwUUM3vcr1i9Z8ylg1wv6yHz5lfH1+n08xuoH5rNN6tmsrQd3fndmXyEWm
         h298agGXxcz0wB1ybAz9o+QzfKRuTZdjDZ0seF1HFxY/Y0hfQ8wUwqX93U27gEapWqM8
         chKXeqHuzQqCkf5ivRzsnjLwXvWWuDZA59MI8MpThKhYwbq/kNY2ZIWuHafEBj3h68VH
         6sjwv3YWOn3jEtEM5ySLowM24cB0x/1IMr/I1kSATLH1h/oLxs5hqUu3fpA4K1SF6lvs
         nUjw==
X-Gm-Message-State: AO0yUKW1XYMkhChqkQiya5v7BICVhw0VHrnfUE15IX05tUkehw+24xOY
        AUYqE06s76WRtVTH7ixe42Af4wfQSheXiVit0KM=
X-Google-Smtp-Source: AK7set8M2ScOuiqCNSCuBPsWpJDEEIvkejGDWgouRr3gzVyj9Y3Lq/WSxoivIRhwTIh17X3FhAu+hg==
X-Received: by 2002:a17:90a:f111:b0:237:779d:7022 with SMTP id cc17-20020a17090af11100b00237779d7022mr1308675pjb.3.1678245039062;
        Tue, 07 Mar 2023 19:10:39 -0800 (PST)
Received: from localhost.localdomain ([50.233.106.125])
        by smtp.gmail.com with ESMTPSA id o44-20020a17090a0a2f00b0023440af7aafsm7995806pjo.9.2023.03.07.19.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:10:38 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] pipe: set FMODE_NOWAIT on pipes
Date:   Tue,  7 Mar 2023 20:10:33 -0700
Message-Id: <20230308031033.155717-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308031033.155717-1-axboe@kernel.dk>
References: <20230308031033.155717-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The read/write path is now prepared to deal with IOCB_NOWAIT, hence
enable support for that via setting FMODE_NOWAIT on new pipes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 10366a6cb5b6..9db274f9baa5 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -994,6 +994,9 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	audit_fd_pair(fdr, fdw);
 	fd[0] = fdr;
 	fd[1] = fdw;
+	/* pipe groks IOCB_NOWAIT */
+	files[0]->f_mode |= FMODE_NOWAIT;
+	files[1]->f_mode |= FMODE_NOWAIT;
 	return 0;
 
  err_fdr:
-- 
2.39.2

