Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDE754706
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGOGbY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOGbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:31:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241F2726;
        Fri, 14 Jul 2023 23:31:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso4448582e87.0;
        Fri, 14 Jul 2023 23:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689402681; x=1691994681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMG7wTQbZgtvRAjXxvDRBfTlBYDJSMqNb7e8GUc53lM=;
        b=pAv+jxyH76FC6T3jDKYL7A3HvGy6QUpIzkrsU4RtcEw301wJz2nCTdY8V2n7dFTNhp
         jVsqaSevGNVB0yo4V3j4XJIqBPb5O+i2i7Vl1gpBgEfO2gRNnXY13TV3zZVbAvENrT7y
         ks36RjjO+R1v+6IUQM+zHnXwQZhIcVBXnZ5bbgT8FfHZnN8Bol5rGO9l41zewA9COZqu
         Tr/FiTWfWiISMsRfeghcbHAu8rvcSV3LNoxb8v28zIMurHVxw1diWLCZydE/JEpwZfas
         QEw+ZDyQd61EqsbHhz8CyX4O14B3STOCEkSeF6Zkaq75HFhkHLg5ZMa0M3XzD/5azhFK
         rXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689402681; x=1691994681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMG7wTQbZgtvRAjXxvDRBfTlBYDJSMqNb7e8GUc53lM=;
        b=S8Jku/Q+0fRPi52GIY+aJsBLJD3CjiGIwv2Qyf3jdpW/+LNA4Pa1d2LeZaVC6op6zh
         tmlvrmQD5/LFoo8aaZGPDIZgEC198tUqoxgOp/3FKRoEj4EvECT7KENxJxJ5lSZgFtce
         Ek/QswWHqkYp/wnWQntIG63JRx/VQiRvHr0uJx9MrL+/G63T8K5VTbF4HSNfL0Djqj9r
         2n/VCb8uanizYNoquEstyszTiVa4d2VaJ/U6t3LRMBOEtiF6ymyQlcat/NQqYKfAJRLo
         rJpN33ZVzq4a2FsRx+9463tXoI/Ec8O4ouQF84rA5A4/COZ/89zTaAovYGWQffm4Y0ee
         azFg==
X-Gm-Message-State: ABy/qLbmwZNpzR4MzMld+mFZotAtCXw3i1xztpiVBMzydaS35Q58oFdq
        RD5Ln40+Y5LTScpDrdXd2+L84QfrOwA=
X-Google-Smtp-Source: APBJJlGkwy46fnfBKXp7aCVMgW27058MPFvPXXfmuxXMvDsNCQvY91voAe4+X6ZgjryDbQ8FcwWaVA==
X-Received: by 2002:a05:6512:5c1:b0:4f8:83f:babe with SMTP id o1-20020a05651205c100b004f8083fbabemr4725768lfo.62.1689402680717;
        Fri, 14 Jul 2023 23:31:20 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003fbe36a4ce6sm2957360wmi.10.2023.07.14.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:31:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 6.1 0/4] xfs inodegc fixes for 6.1.y (from v6.4)
Date:   Sat, 15 Jul 2023 09:31:10 +0300
Message-Id: <20230715063114.1485841-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg,

This is a fine selected set of backports from 6.4.
Patch 4 fixes a fix that was already backported to 5.15.y.
Patch 1 fixes a fix that is wanted in 5.15.y and this was the trigger
for creating this 6.1 backport series.

Leah will take care for the 5.15.y backports, but it may take some time.
None of these are relevant before 5.15.

These backpors have gone through the usual xfs review and testing.

Thanks,
Amir.

Darrick J. Wong (4):
  xfs: explicitly specify cpu when forcing inodegc delayed work to run
    immediately
  xfs: check that per-cpu inodegc workers actually run on that cpu
  xfs: disable reaping in fscounters scrub
  xfs: fix xfs_inodegc_stop racing with mod_delayed_work

 fs/xfs/scrub/common.c     | 26 -------------------------
 fs/xfs/scrub/common.h     |  2 --
 fs/xfs/scrub/fscounters.c | 13 ++++++-------
 fs/xfs/scrub/scrub.c      |  2 --
 fs/xfs/scrub/scrub.h      |  1 -
 fs/xfs/xfs_icache.c       | 40 ++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_mount.h        |  3 +++
 fs/xfs/xfs_super.c        |  3 +++
 8 files changed, 45 insertions(+), 45 deletions(-)

-- 
2.34.1

