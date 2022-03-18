Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5544DE3D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 22:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbiCRWA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 18:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241220AbiCRWAz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:00:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389DAF9549
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 14:59:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s8so10559935pfk.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=TMeyZ9NnVRM5GREL8gFa0wSK7oQqM4TfIg29eo0Xlc8=;
        b=VGABW2s0R5TfwfeDe8ybLbH1k5L+My8+JAIm0UNuuKF7kDM1Azc8telsmTF8Bl126a
         9BYJbAdjxkZUu+8Ni1YlzzR7JSTXUg5hFUrT5U/GRngayw4PIsKm8dYNfZtDuxWXqJdy
         MF2LrYk0n688uf1Gd/3iKXUwwFUYC8ARiHcZxvyAYhl3dG5ydAuZWKyjpQbnV4ehseCB
         s+4uUoycFZiV+1ZUqTHxo3QZoIVgKlTXKfQEabDjha442yr82x/OJhVvalOjBLsFGXn9
         UYMS/z3/9+96qtQPJ7C8mPTy+6qFbfec2CZLQ+mMcFLH5S+EF0ZW1Xnl5VCG5ecVyM3T
         mVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=TMeyZ9NnVRM5GREL8gFa0wSK7oQqM4TfIg29eo0Xlc8=;
        b=zkoHNFb+VHNasKwXYSqobP6KFtKC2yXjuksLWThPmfGtLDpdxFw7rLnVm0gR/bWuv6
         gIkBt/cplmkTMpWnO80Ey6QtFgGLd2brkVFuV42S0lX+WwJt5R3605fPwblCCwaXopsP
         B0VpzDSsvHo0QrKStk0NnHNJ41MseweJXaIwrai1x0TjY4KFokX83xVGgP3SjIVW3h19
         5Psio8j7u9uNmle7LZH32N8q0P62cOxlJFUJJfkHrODqy44U7l/Hk+rmJJpy5bYSZJ9S
         zryfWMDcTa6RpAm8gK7BfqczZLklvOEO3UI2XSPaDigHdrx5+FZSuicVt+xtiQIfDy0X
         OY9g==
X-Gm-Message-State: AOAM530tRy956cpb3rcU/xuD5rGNYeMexVvjga3v6hBj3bTukkRYp1PN
        3IZJS4e4XjrotLNEE0LyqgelfA==
X-Google-Smtp-Source: ABdhPJwstiJLeh3J1jqEV65XlkLuUjE3fTbLTq9jczVR8TvRS5c+HHT6m20zD3QyYwfdhMX2IcsqyQ==
X-Received: by 2002:a63:6b81:0:b0:380:4fc1:ee7b with SMTP id g123-20020a636b81000000b003804fc1ee7bmr9497789pgc.298.1647640775660;
        Fri, 18 Mar 2022 14:59:35 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w12-20020a056a0014cc00b004f790cdbf9dsm11212815pfu.183.2022.03.18.14.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 14:59:35 -0700 (PDT)
Message-ID: <212e39c2-2e2a-24af-647b-67f3168ea558@kernel.dk>
Date:   Fri, 18 Mar 2022 15:59:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] File system related bio_alloc() cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

On top of the core block driver branch, here are a set of fs related
cleanups to bio allocations.

Please pull!


The following changes since commit 451f0b6f4c44d7b649ae609157b114b71f6d7875:

  block: default BLOCK_LEGACY_AUTOLOAD to y (2022-02-27 14:49:23 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/alloc-cleanups-2022-03-18

for you to fetch changes up to 64bf0eef0171912f7c2f3ea30ee6ad7a2ad0a511:

  f2fs: pass the bio operation to bio_alloc_bioset (2022-03-08 17:59:03 -0700)

----------------------------------------------------------------
for-5.18/alloc-cleanups-2022-03-18

----------------------------------------------------------------
Christoph Hellwig (5):
      mpage: pass the operation to bio_alloc
      ext4: pass the operation to bio_alloc
      nilfs2: pass the operation to bio_alloc
      f2fs: don't pass a bio to f2fs_target_device
      f2fs: pass the bio operation to bio_alloc_bioset

 fs/ext4/page-io.c  |  7 ++---
 fs/f2fs/data.c     | 89 ++++++++++++++++++++++++------------------------------
 fs/f2fs/f2fs.h     |  2 +-
 fs/mpage.c         | 50 +++++++++++++-----------------
 fs/nilfs2/segbuf.c | 20 ++++++------
 5 files changed, 73 insertions(+), 95 deletions(-)

-- 
Jens Axboe

