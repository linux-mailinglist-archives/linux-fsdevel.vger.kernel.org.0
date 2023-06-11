Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA172B213
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjFKN1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjFKN1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:27:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C3DE57;
        Sun, 11 Jun 2023 06:27:39 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso34544865e9.0;
        Sun, 11 Jun 2023 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686490058; x=1689082058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SUythJtyf4D6pVFb37cdEXL1QhgyDpOkZ6Klz3pGZ3Y=;
        b=pYktIgsFkOwv4jxz3hqYcDyh+TquaUdu3vTC+qfsSBi3kVqLsVh0dm7M7khPDoBmVl
         tR7iqHCgauLP2Q+UgTm9bx15+iu9QuFrZkK1w39owylAJJsf7dwV0VGsB1bL4cVWO8CN
         Zxsz2N/gSjMwtRkiHL8mrHeYPe3PBGRXK1D8RQvMONRGGmIflpKf6oi6FtJthe2dPR4x
         C8ls97Qb6XbzJaCipklJ5A8m627cP4YCqZLO8msWmqF/VbACvsPX7QFL3zlPteQHJYnu
         Cl3c9HxrEH04xny4csH6s5O4Sq4LZxULbBG+nN4zGnDOO4MKGEg5mzrgQBvL0e0k1wNf
         mZdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686490058; x=1689082058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SUythJtyf4D6pVFb37cdEXL1QhgyDpOkZ6Klz3pGZ3Y=;
        b=VUQ04ssh1FkVkdEK8lMhH4pwzQa64eV1caSYN6Sx2i3q4A2P5AcB+Y2MXVGnDwFhn4
         cGd3eZPArXCfIw/cHSCNyf79U8Bn4VBFJqBpKzUkIkff5F5vB/wzUNgwmJdYHtfeZcZV
         ej6Q1EKypJm5dNXOxa/xhmKXy5q6HWicewrbiAxdjZDb8l3I7INm//yW1bOj8WIH02Ot
         vgw86iFPgE+QVnspFGEd9nSz79FF3wHWynacY2p5XOyAmx5O6flnHA7zLeZFbNPZ75//
         Lk9GyK8yHcQa8G31zwpyvCjkPhWXCLuzSupR9qg4JvssCiuhgswLS0ZFXHXv4S0tr+uK
         DmgQ==
X-Gm-Message-State: AC+VfDwyytkdKqepMSTyS+wRj0gsj+SNWSTiHSVKT481idQarcax5iBe
        GC8Ih8gQT7J9R5GSzn1+VXg=
X-Google-Smtp-Source: ACHHUZ4e8CjHkDYZn5H/j86r+cboslhQduNUNr1Iycn2ruo/TifEK1gWXGZuM1iIkcW0sxd7Ey06Pw==
X-Received: by 2002:adf:f791:0:b0:306:30ea:a060 with SMTP id q17-20020adff791000000b0030630eaa060mr3107993wrp.51.1686490058303;
        Sun, 11 Jun 2023 06:27:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm9593940wrr.46.2023.06.11.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 06:27:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
Date:   Sun, 11 Jun 2023 16:27:29 +0300
Message-Id: <20230611132732.1502040-1-amir73il@gmail.com>
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

The first solution that we discussed for removing FMODE_NONOTIFY
from overlayfs real files using file_fake container got complicated.

This alternative solution is less intrusive to vfs and all the vfs
code should remian unaffected expect for the special fsnotify case
that we want to fix.

Thanks,
Amir.

Changes since v1:
- Drop the file_fake container
- Leave f_path fake and special case only fsnotify

[1] https://github.com/amir73il/linux/commits/ovl_real_path

Amir Goldstein (3):
  fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
  fs: introduce f_real_path() helper
  ovl: enable fsnotify events on underlying real files

 Documentation/filesystems/locking.rst |  3 ++-
 Documentation/filesystems/vfs.rst     |  3 ++-
 fs/file_table.c                       | 29 ++++++++++++++++++++++++---
 fs/internal.h                         |  5 +++--
 fs/namei.c                            |  2 +-
 fs/open.c                             |  2 +-
 fs/overlayfs/file.c                   |  4 ++--
 fs/overlayfs/super.c                  | 27 ++++++++++++++++---------
 include/linux/dcache.h                | 11 ++++++----
 include/linux/fs.h                    |  8 +++++---
 include/linux/fsnotify.h              |  6 ++++--
 11 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.34.1

