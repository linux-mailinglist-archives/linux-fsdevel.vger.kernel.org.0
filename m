Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502FD5513A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiFTJEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiFTJEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:04:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235B2DDE;
        Mon, 20 Jun 2022 02:04:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id l6so1009035plg.11;
        Mon, 20 Jun 2022 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qwu79I2l+uWlGBEX5hSLo/V35aBaNRjfSf5b/2UWaVY=;
        b=hGaNeZSTw7/UlsXa54x+kasmHh+nJsL4N7NX7ZIuKJCH7uq/Ty58e1WKqP5EfIZRXE
         nOBHwHbWjZhwrLApVpQJTV6qWSKdSdtgxTu7LQhOfhayPLBcCqKlSLte/1GfUBcFZ6Kn
         qcxbX5Q6uGTZ7hueBn0cYgod8luxd82Ktx1pmprftDedvZ8b3iork+pzcY98pd9F/6Fu
         A8+EDmUXiyJlftw7IRzvaWa1k7Txkvh7aX98pBfHjQ7dtJnxtUeq+z7kOixVN3UJzWRJ
         vYrZ/uiWTTocqUj+4NGj4c8EjHZQq06T+vO15/NM3S8R1luH7hcPdbroQG7v9muMXmeV
         EKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qwu79I2l+uWlGBEX5hSLo/V35aBaNRjfSf5b/2UWaVY=;
        b=Si150Tf5ynwmqh47rWJCmjymIuerTZ2yq95aIipRww3knNP+MwYZTnJf2u8z02QI6a
         sCcyIOcjk3apPP3OxnCFx126BLEUGUthy5j1JwqAvv9gSy2nekobGa+mHaM1ZMXan1+w
         +SUEY0PpH4wVxb83+KMpPCho2HSNsJirtpD2Z33t6azR7rmNLR5n5MJ0the4/BmpWd2O
         XdqFSKUxvNI5oMWzJTSJmvO/wVR6Dg2t5mJBwrHwQ0Pyxhq4Zp+mWTDBnk6bPb/AfToe
         eCix3P2FdKOSaxOZSmG3rZDvVs+MOB11xjl2S+xLSoM+ooYuWWlqzt5u+Nh3e4RUp9l+
         +lPg==
X-Gm-Message-State: AJIora9O5ppM/xtvI8FXHLkEf5N8p9KjE9DFGwKu3ZdEwKznd+aMXigf
        zWTsC+3+4u4Ip7FLM3Whx6yP4Cl3exc=
X-Google-Smtp-Source: AGRyM1tY5oEsd3gjhYvG++Tr2b5ZYbKO7gbc6nBOgHtnBLkDr9xwhJQL2hQvrL8Qldk/iA00RmGPRA==
X-Received: by 2002:a17:903:22c9:b0:163:e49d:648c with SMTP id y9-20020a17090322c900b00163e49d648cmr22730847plg.54.1655715887372;
        Mon, 20 Jun 2022 02:04:47 -0700 (PDT)
Received: from localhost ([2406:7400:63:5d34:e6c2:4c64:12ae:aa11])
        by smtp.gmail.com with ESMTPSA id p9-20020a62b809000000b00522cae827f6sm4201768pfe.197.2022.06.20.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:04:47 -0700 (PDT)
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCHv2 0/4] submit_bh: Drop unnecessary return values and API users
Date:   Mon, 20 Jun 2022 14:34:33 +0530
Message-Id: <cover.1655715329.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

submit_bh/submit_bh_wbc are non-blocking functions which just submits
the bio and returns. The caller of submit_bh/submit_bh_wbc needs to wait
on buffer till I/O completion and then check buffer head's b_state field
to know if there was any I/O error.

Hence there is no need for these functions to have any return type.
Even now they always returns 0. Hence drop the return value and make
their return type as void to avoid any confusion.

RFC -> PATCHv2
===============
1. Added Patch-2 to fix ntfs_submit_bh_for_read() caller.
2. Added Reviewed-by from Christoph.

Ritesh Harjani (4):
  jbd2: Drop useless return value of submit_bh
  fs/ntfs: Drop useless return value of submit_bh from ntfs_submit_bh_for_read
  fs/buffer: Drop useless return value of submit_bh
  fs/buffer: Make submit_bh & submit_bh_wbc return type as void

 fs/buffer.c                 | 19 ++++++++-----------
 fs/jbd2/commit.c            | 11 +++++------
 fs/jbd2/journal.c           |  6 ++----
 fs/ntfs/file.c              |  4 ++--
 include/linux/buffer_head.h |  2 +-
 5 files changed, 18 insertions(+), 24 deletions(-)

--
2.35.3

