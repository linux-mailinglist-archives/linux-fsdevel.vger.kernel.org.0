Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E0056036C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jun 2022 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiF2Om3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jun 2022 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbiF2OmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:42:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345139148;
        Wed, 29 Jun 2022 07:42:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r20so22836823wra.1;
        Wed, 29 Jun 2022 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eI9CQLpWygNGy4yl/tWF9cKiFCPEVrJqU/3ubCQYgks=;
        b=RzqyZ0fegsKON41cB34MB/Z+1RaI7S6nE54qlrLmfWAPMAO+dJKUhfaKAI/kLlbcIe
         aQKgyRcGEwCwvW/dlgcjSSof+O7MkYpcr3/MnQHQn9Na1iIvejMsIEsde5jJDLGq6eFn
         BeFkgTQMh33z+in0ZlsQ89MCy9aCP6NDyOQ2z7Kq4Pi9sj55smg5Hrk6nEYVOuOOGwI6
         JCTorEyy40LKZE4uXqbLjFZukYytO+uz1ESJaGCY04imyqFKJL3QPE8phmjidlOGUs28
         sYZKRltT/hZ4kor9L3IaGiZgX7PyVMY4czlcuX7WVN5gtiqSI7CH5UE8RCcGeu/HeHeB
         lPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eI9CQLpWygNGy4yl/tWF9cKiFCPEVrJqU/3ubCQYgks=;
        b=fhsyQbaCnei6TuVdnupQXHfRUsYCodO3EAjPAICV2aUAT53UPMr2T/lRa4Od/nsU/1
         IyxVU4EnQCofGeUny9VFm6TWwMBJfB9BDhocmok64HKsuYe0S0idYK/RRXTXFOE2Udvr
         /ZbXncdJGX4naGatzVeOYY91u3O9iTo8TCHE2jfmeAAtwgmBbhdG6o85220AkosumyDg
         +tU7yzmahjvFvo+k8+q50aWoc485pqU7JuK1CuadjcF5aCxDtkqhH4FPrbPFBT2k9E1X
         0/9vl1ic09WOQje4Qz/3uWgdBLbnuiVtiuXxKYS5EBN5WlodYIppQe/NVH80mBFvkukS
         TONA==
X-Gm-Message-State: AJIora81VyUx/x3FS2U7MVU08K2gI4/1TwzaqMASm7EQKwICLWFaIp/f
        axRLwpP/c+T+Oa1dJKDURPw=
X-Google-Smtp-Source: AGRyM1vp5qcwOM3ySCshstV/s72WlpOMrLDacER1VnP4uBL/Kgn4stLO4hLbIcdnOMrMEeRC07PKtQ==
X-Received: by 2002:a05:6000:711:b0:21b:b9a0:601e with SMTP id bs17-20020a056000071100b0021bb9a0601emr3545006wrb.388.1656513735916;
        Wed, 29 Jun 2022 07:42:15 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b0039c747a1e8fsm3562085wmq.7.2022.06.29.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:42:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 0/3] New fanotify API for ignoring events
Date:   Wed, 29 Jun 2022 17:42:07 +0300
Message-Id: <20220629144210.2983229-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Hi Jan,

As we discussed [1], here is the implementation of the new
FAN_MARK_IGNORE API, to try and sort the historic mess of
FAN_MARK_IGNORED_MASK.

We use the opportunity of the new API to further restict the events
and flags that are allowed in ignore mask of a non-dir inode mark and
we require FAN_MARK_IGNORED_SURV_MODIFY for dir/mount/sb ignore mark
to remove from the test matrix a lot of notsensical combinations.

I extended the LTP tests [2] to cover the bug that you pointed out
in [v1] review. I verified that the 6 relevant test cases fail with
the buggy v1 version and pass in this version.

The man page draft [3] has been updated to reflect the new restrictions,
some of which have already been added by a Fixes patch [4].

Thanks,
Amir.

Changes since [v2]:
- Rebase on top of API restriction patch
- Require FAN_MARK_IGNORED_SURV_MODIFY for dir/mount/sb ignore mark
- Add test coverage and update man page with new restrictions

Changes since [v1]:
- Replace "sticky" semantics with EEXITS error
- Simplify EINVAL checks
- Add missing ignore mask accessors
- Add fsnotify_effective_ignore_mask() helper to fix bug

[v1] https://lore.kernel.org/linux-fsdevel/20220620134551.2066847-1-amir73il@gmail.com/
[v2] https://lore.kernel.org/linux-fsdevel/20220624143538.2500990-1-amir73il@gmail.com/
[1] https://lore.kernel.org/linux-fsdevel/20220428123824.ssq72ovqg2nao5f4@quack3.lan/
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
[4] https://lore.kernel.org/linux-fsdevel/20220627174719.2838175-1-amir73il@gmail.com/

Amir Goldstein (3):
  fanotify: prepare for setting event flags in ignore mask
  fanotify: cleanups for fanotify_mark() input validations
  fanotify: introduce FAN_MARK_IGNORE

 fs/notify/fanotify/fanotify.c      |  19 ++---
 fs/notify/fanotify/fanotify.h      |   2 +
 fs/notify/fanotify/fanotify_user.c | 110 ++++++++++++++++++++++-------
 fs/notify/fdinfo.c                 |   6 +-
 fs/notify/fsnotify.c               |  21 +++---
 include/linux/fanotify.h           |  14 ++--
 include/linux/fsnotify_backend.h   |  89 +++++++++++++++++++++--
 include/uapi/linux/fanotify.h      |   8 +++
 8 files changed, 212 insertions(+), 57 deletions(-)

-- 
2.25.1

