Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FA79A56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjIKIGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 04:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjIKIGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:06:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FF1CD7;
        Mon, 11 Sep 2023 01:06:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so3811835f8f.3;
        Mon, 11 Sep 2023 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694419566; x=1695024366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XDXBfh7oY4pmFmGSF4PND0R5OaSxpWXbzV+EwmN9Pdw=;
        b=Exth6Ca9CLd3UXafGJSXVaY+v1jFTIAeKdkbwOksZM3AuyBL46VowEeo3FV6t3M9jI
         BgbTaL6rRGGB9Q1IOuA63qBo5FJlOQqnw+sXZ6lU1hAlv7U8q0Dq4DDgRXlzxXQosd/r
         0/u2xSghQEvN7IY9is/P8vc5700qZ5WvFgMwM41SVf+HyOIY9orMrskQgf/1xaV0tlb7
         7SeKFv9t0w7iwFvYJPi8GbPDwvrrj+GHSa1saBlLJ1+KGMcADtraRe86IN+CpGcFb9bl
         HvTA3dgNovmmvFWby64FiKch+5AaX0AFsTV/zfq4K9jJoD5SuMGDh55A0eC+mbJkawd2
         fMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694419566; x=1695024366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XDXBfh7oY4pmFmGSF4PND0R5OaSxpWXbzV+EwmN9Pdw=;
        b=xAzmHjZAsSdHt+4HlzvKgQmSmgZFlHlbQ33yhIAqolcEhhHKoSWtPKz/ixVsAZKQXX
         jZufGOQg5gSwrCs1x/MWzxskK1r6HiVNGRPlTAPUOmDdiAUafBDZ1Yh6EEMlmFBTcfXd
         b83Cb3vQNU8enG15hOUewl6ZakdYmemgC2YFvZ6i5zsiw8f6wQp086P8LZGfkUJhX9DQ
         pzGSUjO49HcOKEj2nTnbhBL2QXfh2pT0lG+6qbrwByNFKIOyKzHkk/LnDDXX8aMFE3ZR
         3LxKAiA+obBPtMCYbsQ9VYXQruMi2c16iF9fUZCxprwLvqz8wSYZ7OttZHrm3iRfyroK
         FMLg==
X-Gm-Message-State: AOJu0YxJto23nNfdw4IKtcMKgdMkFIB4lgF2of5fXNh/hwt8XOUtmlh/
        jmlMVNvOQAfgX671B8CIVn4=
X-Google-Smtp-Source: AGHT+IFdax2hVRIOrZsTiUvyn39s51JCtfiYuOHBeWdbv0V7Ww7JkD8FS7pTk1aCIKgGSX/58mOh7Q==
X-Received: by 2002:a05:6000:137b:b0:314:1b36:f440 with SMTP id q27-20020a056000137b00b003141b36f440mr6505126wrz.70.1694419566094;
        Mon, 11 Sep 2023 01:06:06 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5589000000b003141e629cb6sm9216396wrv.101.2023.09.11.01.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:06:05 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.6-rc2
Date:   Mon, 11 Sep 2023 11:06:01 +0300
Message-Id: <20230911080601.3145430-1-amir73il@gmail.com>
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

Hi Linus,

Please pull these two fixes for pretty old regressions.
They have no relation to the ovl updates in 6.6-rc1, except for
the timing. They were reported late in the merge window.

I could have sent the fixes last week, during the merge window,
but they are not so urgent, so I preferred to test them against rc1.

This branch has been sitting in linux-next for over a week and
it has gone through all the usual overlayfs test routines.

The branch merges cleanly with master branch of the moment
and I even signed it this time ;)

Thanks,
Amir.

----------------------------------------------------------------

The following changes since commit 92901222f83d988617aee37680cb29e1a743b5e4:

  Merge tag 'f2fs-for-6-6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2023-09-02 15:37:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git tags/ovl-fixes-6.6-rc2

for you to fetch changes up to 724768a39374d35b70eaeae8dd87048a2ec7ae8e:

  ovl: fix incorrect fdput() on aio completion (2023-09-04 18:27:38 +0300)

----------------------------------------------------------------
overlayfs fixes for 6.6-rc2

----------------------------------------------------------------
Amir Goldstein (2):
      ovl: fix failed copyup of fileattr on a symlink
      ovl: fix incorrect fdput() on aio completion

 fs/overlayfs/copy_up.c | 3 ++-
 fs/overlayfs/file.c    | 9 +++------
 2 files changed, 5 insertions(+), 7 deletions(-)
