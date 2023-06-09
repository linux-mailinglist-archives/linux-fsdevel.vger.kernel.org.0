Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4F3729134
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjFIHeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjFIHeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:34:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8C635BC;
        Fri,  9 Jun 2023 00:33:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3094910b150so1513046f8f.0;
        Fri, 09 Jun 2023 00:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686295965; x=1688887965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g2eujyCd25zUMgSaf/dyBUoYUZcYxK23G6Yx2fQ5qfU=;
        b=feSIuHlBKmsKWVRVBdxafqOjQItATePp7rVzQJr33Bxj3fO4XguB7qpvwNd8P1o+qu
         5BKg+tiwY+5PyrXZ2XI+NRuFOS15RqonsV0FiOg6WEMNQS5v4ISBzrsnlhPzGnl3FOoO
         L/GjHR32Iy2zMkphMVdvOQI1njphujhUVMFf1mcMMbYhvj97Zea1GFtEqMTqpKRn2Hb/
         D8R3QbNvDnTqREQYhhkjk5afb2NJPyXSvynqAnhHuucnJLCslbsbZEAQw5WJ5CQTiulM
         R9/fFR5FCOia5obEeVJ9PnHbOs8bV31reurUyWZHzW8l9dw35U/C7AVNGCb2CJ14ogV2
         ZleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295965; x=1688887965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2eujyCd25zUMgSaf/dyBUoYUZcYxK23G6Yx2fQ5qfU=;
        b=GB/Q6/DwjRKlfxFuoTwbvlHY4oE90TVm34cGVToExL34cdZJKLGBBr0hcJZlCu8CZR
         nVh8/jDsjOupSv32rVYAvQsAN/MUJA+1SxVzb7h70MIkNu7feQDxKxjyWkEi4YFD5PpA
         /CA8St1XBJvXW3gceDjZiRwzbtaPxMx45ix+duD8L5uEL6cFBU4axF2WomAnNSuzakjE
         YyAtdOmMUFo4JZyCeQLjZU3DdRah/sit/Xhk643X/WPdv44EFpoTDTfp4ZvCwXoQICZJ
         O3JmNPANhY9+/bfOEx89ZhC0Q4lmykNrrIqPhSKLqFWgB11AZnpom6bhZzPCeYu8TkCa
         Za5w==
X-Gm-Message-State: AC+VfDymIs2fuoGqnc4395jG6Q/xMRSBBqQFSzrJyuW0Ii9EBFDjx3cC
        ZiJcEGM+KZI3GEjzNx1k0eM=
X-Google-Smtp-Source: ACHHUZ6jh7/JWfjzsjLAT18MtA26eE5abR2YNaSlc2UIYVtRCW1PoS5PooctEu28HKzN2/Jdt/mrrg==
X-Received: by 2002:adf:f38b:0:b0:30e:3d28:ba75 with SMTP id m11-20020adff38b000000b0030e3d28ba75mr399694wro.28.1686295964957;
        Fri, 09 Jun 2023 00:32:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm3624528wrf.94.2023.06.09.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:32:44 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 0/3] Reduce impact of overlayfs fake path files
Date:   Fri,  9 Jun 2023 10:32:36 +0300
Message-Id: <20230609073239.957184-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Miklos,

This is the solution that we discussed for removing FMODE_NONOTIFY
from overlayfs real files.

My branch [1] has an extra patch for remove FMODE_NONOTIFY, but
I am still testing the ovl-fsnotify interaction, so we can defer
that step to later.

I wanted to post this series earlier to give more time for fsdevel
feedback and if these patches get your blessing and the blessing of
vfs maintainers, it is probably better that they will go through the
vfs tree.

I've tested that overlay "fake" path are still shown in /proc/self/maps
and in the /proc/self/exe and /proc/self/map_files/ symlinks.

The audit and tomoyo use of file_fake_path() is not tested
(CC maintainers), but they both look like user displayed paths,
so I assumed they's want to preserve the existing behavior
(i.e. displaying the fake overlayfs path).

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/ovl_fake_path

Amir Goldstein (3):
  fs: use fake_file container for internal files with fake f_path
  fs: use file_fake_path() to get path of mapped files for display
  fs: store fake path in file_fake along with real path

 fs/cachefiles/namei.c  |  2 +-
 fs/file_table.c        | 85 ++++++++++++++++++++++++++++++++++--------
 fs/internal.h          |  5 ++-
 fs/namei.c             |  2 +-
 fs/open.c              |  9 +++--
 fs/overlayfs/file.c    |  2 +-
 fs/proc/base.c         |  8 ++--
 fs/seq_file.c          |  2 +-
 include/linux/fs.h     | 13 ++++---
 kernel/audit.c         |  3 +-
 kernel/fork.c          |  5 ++-
 security/tomoyo/util.c |  3 +-
 12 files changed, 102 insertions(+), 37 deletions(-)

-- 
2.34.1

