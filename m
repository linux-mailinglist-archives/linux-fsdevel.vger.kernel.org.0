Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7454C186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 08:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbiFOF6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiFOF6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:58:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFB2B263
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:14 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 31so8814945pgv.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKivPnUDV0RH/3at3XRIS7bnNh4XH34G9qda9gPGH/M=;
        b=SXum5tLB9BjjmoKd4xrDm30WFHuOqQo7W3kqV/ka1eQEHVRsImuJ2hODRlICaUpYH+
         kWXyXviNBKSrkS2t/w6QZbdoRNiNqiizRFKAyGwFeIdTInCkinVnq1i0+yxjLSHgNSfM
         cbYPxSxpmOW5a8b07jiUSEWV7OSkGBMl0kTZz2LkuXYDnhdWLMzEZhL7IK/QqVmReVg3
         kVXSG3fb27pvBaKOLMSEkBwcSBwrMxDf2b0Pf94G3ya73q3NOZLD4Rr5sNoyn7U/WnSe
         wgsD/teprSD2IlgerkdioO9Ojny0kLei+6OvImu09XSyKwMXn1C7Z0xAH6JkT3L2BQEa
         XLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oKivPnUDV0RH/3at3XRIS7bnNh4XH34G9qda9gPGH/M=;
        b=gHtgZ6tSogIzMm+Q71Z6a2q7TcIeuC9TbnGJ55OJQjmex4Ae2b80+0aNhoFuViGDww
         WOtLDACs8z0p9mIbf3ctq6n7QEyCEGFRL1WsR4nZ6ebhwlr/BbqyvGW3sLDeU8twfRwM
         x21mPgjyYfXzNH5VvKtVPiGAgvUrhGJtXlJt0U/nsxm9p8qQ6MBzzoiKssvcTAcjCmmE
         T6qTZYwPX6kznDGfSaPbxmzmIs13di7T2bm8Yk51Rs90vDLfWBY3DJBO2apnOMXk8XUI
         rdtibaaUFhWmxcNhLXjbpAhagEeHH1XXDHZECh0fiP0L6VlnfY7BEXyd8HltRZ9oyvHX
         HdsA==
X-Gm-Message-State: AOAM532QV/b1lPoUpJGJ+83CeI1TbJodKwkRUEfrCyVNafS8VqlB9W1l
        eYS7astUdlfjbShg8RZQ5Xz5SYByDrCSxjk=
X-Google-Smtp-Source: ABdhPJzPD+gNFPqEJCnchPWWal4tYztbd+XVgCprF4xb4bvgtfkh4HXrp7kMfZ1KyHtgTn5kVFLIJw==
X-Received: by 2002:a63:5522:0:b0:405:1ff7:33dd with SMTP id j34-20020a635522000000b004051ff733ddmr7667470pgb.86.1655272693595;
        Tue, 14 Jun 2022 22:58:13 -0700 (PDT)
Received: from localhost ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78d4d000000b0051c70fd5263sm8673339pfe.169.2022.06.14.22.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:58:11 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] Allow skipping abort interface for virtiofs
Date:   Wed, 15 Jun 2022 13:57:53 +0800
Message-Id: <20220615055755.197-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit 15c8e72e88e0 ("fuse: allow skipping control
interface and forced unmount") tries to remove the control
interface for virtio-fs since it does not support aborting
requests which are being processed. But it doesn't work now.

This series fixes the bug, but only remove the abort interface
instead since other interfaces should be useful.

V1 to V2:
- Split the patch into two part [Vivek]

Xie Yongji (2):
  fuse: Remove unused "no_control" related code
  virtiofs: allow skipping abort interface

 fs/fuse/control.c   | 4 ++--
 fs/fuse/fuse_i.h    | 6 +++---
 fs/fuse/inode.c     | 2 +-
 fs/fuse/virtio_fs.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.20.1

