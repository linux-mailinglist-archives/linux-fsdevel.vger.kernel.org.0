Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA1B615115
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 18:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiKARxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKARxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:53:53 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21401C90A;
        Tue,  1 Nov 2022 10:53:52 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso13536374pjc.2;
        Tue, 01 Nov 2022 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T616rnlmF8gGpKRw2WeKaNrtP39/7G6HvF59mTmvBVA=;
        b=bnPVjS1B/4HTUkdEBkWa3ra8fQa70pnyxpgCSzvdkJWi36b6XnC9by2aLIVrilNPVn
         cvoX3p9xLVrKUGdJUXhp7rcYN4dwf8F7bGWleayA2dWJ3u1P5v2q+fsJDtnXhSaOqLqi
         0cRjFkarEzgAJKJCX0dFtVauHeWnB9kHE0UVFwzvQbhtOR1a9dYYSLNuVDC7SiZS2u22
         aTJMhodgdJ6pZ3yhqr4biboWA5O06Q/wh3YBDCfWA/HlwFkTGXHiNZf+ZErE1mvfBw47
         0pwRQE5oXG5rucB23PyXBv6lTkb65BCi+kL8u9p6i0+vu7lo1ca/fwW0g9RH4dP18Tfv
         doTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T616rnlmF8gGpKRw2WeKaNrtP39/7G6HvF59mTmvBVA=;
        b=OayjTE9ZipQmxYdNggtIOJqHrusz97f7/FHxA7kHt0OMpB1wsm9yrePMv1qt/Y7psv
         PMPYSyCb6zdxoag1KhL6OT3sUcnNzbKB7sOvPlR2jxcB+4z03i6itjTPqDa/ZCNCRU8x
         rXmN0i+WjBpuxPdNwSvh/MQZoDzqijc5WGT+0wxOMQPRX1JFriMUYgKw3uXGtYQ9Y3bb
         M+tvVlzve5q291AOsqOj1mxiE5DN4gARDAb3+l+JVh9NxFo8Nh5ZswVu81dKh4ZE2aBG
         NcDsstd63bGgfDgyHO/h3NAyrH6NXtaV0YmCg90f21HpvXYS8PBWhTXgDsZlX1BsJ+Ut
         AkIw==
X-Gm-Message-State: ACrzQf0P23sHlr/t8gwz2DGLEj7Czn+9SgnO7Nd6nB3sUD1LYUbTt44R
        M4BcCrBdh5w5Ej7eIiWKqYA7CGle7dabWA==
X-Google-Smtp-Source: AMsMyM5pRis2psFXZCe/ULdaya3CpiLSHEOZX7IOaQRnUoJQ004k/RC0rCEx/hilvIg1AJhCi23mjA==
X-Received: by 2002:a17:903:247:b0:179:b5e1:54b7 with SMTP id j7-20020a170903024700b00179b5e154b7mr20496732plh.84.1667325232412;
        Tue, 01 Nov 2022 10:53:52 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id e26-20020a056a0000da00b0056b9124d441sm6797987pfj.218.2022.11.01.10.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:53:51 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, miklos@szeredi.hu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 0/5] Removing the lru_cache_add() wrapper
Date:   Tue,  1 Nov 2022 10:53:21 -0700
Message-Id: <20221101175326.13265-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset replaces all calls of lru_cache_add() with the folio
equivalent: folio_add_lru(). This is allows us to get rid of the wrapper 
The series passes xfstests and the userfaultfd selftests.

I haven't been able to hit the fuse_try_move_page() function, so I
haven't been able to test those changes. Since replace_page_cache_page()
is only called by fuse_try_move_page() I haven't been able to test that
as well. Testing and review of both would be beneficial.

Vishal Moola (Oracle) (5):
  filemap: Convert replace_page_cache_page() to
    replace_page_cache_folio()
  fuse: Convert fuse_try_move_page() to use folios
  userfualtfd: Replace lru_cache functions with folio_add functions
  khugepage: Replace lru_cache_add() with folio_add_lru()
  folio-compat: Remove lru_cache_add()

 fs/fuse/dev.c           | 55 +++++++++++++++++++++--------------------
 include/linux/pagemap.h |  2 +-
 include/linux/swap.h    |  1 -
 mm/filemap.c            | 52 +++++++++++++++++++-------------------
 mm/folio-compat.c       |  6 -----
 mm/khugepaged.c         | 11 ++++++---
 mm/truncate.c           |  2 +-
 mm/userfaultfd.c        |  6 +++--
 mm/workingset.c         |  2 +-
 9 files changed, 67 insertions(+), 70 deletions(-)

-- 
2.38.1

