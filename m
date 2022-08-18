Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1B597DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 07:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242969AbiHRFFF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 01:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiHRFFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 01:05:04 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F79F19A;
        Wed, 17 Aug 2022 22:04:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 81so534784pfz.10;
        Wed, 17 Aug 2022 22:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=zqyIaGt/ExqtQmslvy9xLCDQR0MrGNhaTrbDsaW27oI=;
        b=RzmzR3eAdxOXzboQinMz32niTOdFBYn3Mf29kgMNnSAW2rzWPcMPm8/p/44uxJ8nCS
         fsdzbWE18EYaI/JJQlHF2BcVWX8GX4+YT7q3X0HkDhEddW9Jd69nzXF1RT88Qo8Ur82h
         RBTxVzHXkhO99IB+oxNeXeV4CyAemFfqZYFIS9BGU8GgWl2XRKBgyEbRfTK6Fb8H2fzC
         peC9WSv1u0QegTkBdeAy+zf+P8DTuMlqSwy0cDmDEQp8DdKPaKVFsPfxCZcb0umHOLDW
         Lyvst7Fx/A9qPxt6cjRKQe7rfgHmMPkrStk+mzR8Y+tw68vkPkMSymEyu/W7yHgzB77T
         URhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=zqyIaGt/ExqtQmslvy9xLCDQR0MrGNhaTrbDsaW27oI=;
        b=yXVd4iYY/JcrHtXD08Drrg9EOIFcUAsedQpYbAMnt8dpWHeIQSne3/bRgGDngFT3ck
         6vAGbEjY3RpYIuQYE/xymGwpgRKUi7cCO72aXf2S2n5wpmRr0PqxWhDPpny0xbd4dl0/
         y10snXPW8XBLgPdccqsGEfpSiuLmr2Fhi0Ov+EhZLEc4rIEj+vjIUTRaY2NFsjHJMdhq
         9RavBmkqgZX1JLemCuou6F4faAai3U44Hh8hmQPCZdtGupLwCKm9/N300ZCFN0p+8cCx
         T4qwvfdVIgwKY5iC9q088RShlb5TQ31KGDfoIjhYPaE+5iZY5GLwgRxtmgJ3860fvdMz
         yNAg==
X-Gm-Message-State: ACgBeo0p9PJ8sGCqJKtEWgjZkVDmIJ1ZaK2h3/Msy8e1C5XDNoCpF7hR
        pvKC9BIESVhf98q7cflPYcG9p4KxiWE=
X-Google-Smtp-Source: AA6agR71ckaXfe+LO01tzSzvuueKremnthqSkRj6McdiTjcD/DeXMRpwfxI4QvKm8R2stgNS7YCv7w==
X-Received: by 2002:a63:1b55:0:b0:41e:2cc8:4296 with SMTP id b21-20020a631b55000000b0041e2cc84296mr1225831pgm.510.1660799098528;
        Wed, 17 Aug 2022 22:04:58 -0700 (PDT)
Received: from localhost ([2406:7400:63:e947:599c:6cd1:507f:801e])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a404500b001faaed06ce2sm425762pjg.28.2022.08.17.22.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 22:04:58 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        linux-ntfs-dev@lists.sourceforge.net,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCHv3 0/4] submit_bh: Drop unnecessary return value
Date:   Thu, 18 Aug 2022 10:34:36 +0530
Message-Id: <cover.1660788334.git.ritesh.list@gmail.com>
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

PATCHv2 -> PATCHv3
===================
1. Rebased on top of the latest 6.0-rc1 release.
   Recently REQ_OP_** req operations and REQ_** flags were combined as one
   parameter (blk_opf_t type) to submit_bh() API.
2. Since the patch series remains trivial on rebase, I have retained the
   reviewed-by from Jan and Christoph.

RFC -> PATCHv2
===============
1. Added Patch-2 to fix ntfs_submit_bh_for_read() caller.
2. Added Reviewed-by from Christoph.

Ritesh Harjani (IBM) (4):
  jbd2: Drop useless return value of submit_bh
  fs/ntfs: Drop useless return value of submit_bh from ntfs_submit_bh_for_read
  fs/buffer: Drop useless return value of submit_bh
  fs/buffer: Make submit_bh & submit_bh_wbc return type as void

 fs/buffer.c                 | 23 ++++++++++-------------
 fs/jbd2/commit.c            | 10 ++++------
 fs/jbd2/journal.c           |  9 ++++-----
 fs/ntfs/file.c              |  4 ++--
 include/linux/buffer_head.h |  2 +-
 5 files changed, 21 insertions(+), 27 deletions(-)

--
2.35.3

