Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A872B3D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjFKTrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKTrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:47:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444BC9;
        Sun, 11 Jun 2023 12:47:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so25289475e9.0;
        Sun, 11 Jun 2023 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686512831; x=1689104831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NMYc5wIB+U7h1zhvSlCUfwgqNM6KIB9uFG44vWYopAM=;
        b=cEvE/2g8FT2zNW+1hRGCMPDzyTVsgn+l5WDQkBeQ6tYp2TBGxreQvF0kc6jJZVGkEF
         98SveGWOp+oYZp+/0Rn7MM9i2KH2mF6UwKxF18m4ujOQtKGDp4NMBgTDoAeoqBVnFCyl
         tY52amH91MuRPHHi8VdBbGElZHEaTuBRZOWTIA3PVlXf7N7bEnCsdIRHT4nckeFviFtF
         ecEKM7skvj3QX/DX/L3eilQs1VxeTS4fVTvLwpo21iDX2O0/rNUJ4KsTRvZPv9emdyIa
         VfoUSNBrHFR5asjZ4JKAbQ3iNxdgZapPFmGr37/Zc3l+eZOSrW3RaEyr+oGwkd5B1mTr
         oP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512831; x=1689104831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMYc5wIB+U7h1zhvSlCUfwgqNM6KIB9uFG44vWYopAM=;
        b=N99/jZdZQRo6nSrKqBEwWLSJjrcbawvSX8pEzSvDCLwRgIeoqD/eKpntPPNQfUpbm9
         5uZG4SEIy1l9rcC2O6+Yt/UT+tBcU2BElb0N8oYnXCulgaYnld1HehGr3FGW/KqCI/5K
         yQF5SVPva0QX78OYkuz28Fj0up/DZMkOxW2yiaZQ6KLwloN81534VALxn5LDh0pkJCru
         jwKZ4R9QEACBhcXARPFhXzLKhngycxPxUoqD+GpdggB86fDrvJSZXJHnQgarMFYDma5+
         o9VUOzQBJ4LVBj4OsOjxejB7cHmsTZ13F/vxAWHqy1KG6+NVYPteSMUMcNgWJ14nj7tE
         zTbw==
X-Gm-Message-State: AC+VfDyFm/ewHqpxKuIUJ5K8oQSa5RNQDKjS9H8FVbvykuVmrQEBRYLI
        LONUL1QGXpK2ZOMPomw8N/E=
X-Google-Smtp-Source: ACHHUZ7OnW7BCC1batbNnWG3goTD2qr3+YggpIYHpqJMxQd8DjsURH10KId3cC72kR+h6pqVnM4NaA==
X-Received: by 2002:a1c:740d:0:b0:3f7:26f8:4cc0 with SMTP id p13-20020a1c740d000000b003f726f84cc0mr4630185wmc.17.1686512831230;
        Sun, 11 Jun 2023 12:47:11 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c211a00b003f42314832fsm9221902wml.18.2023.06.11.12.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:47:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v3 0/2] Handle notifications on overlayfs fake path files
Date:   Sun, 11 Jun 2023 22:47:04 +0300
Message-Id: <20230611194706.1583818-1-amir73il@gmail.com>
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

Third attempt with the eye towards simplifying d_real() interface.

Like v2, most of the vfs code should remain unaffected by this
expect for the special fsnotify case that we wanted to fix.

Thanks,
Amir.

Changes since v2:
- Restore the file_fake container (Miklos)
- Re-arrange the v1 helpers (Christian)

Changes since v1:
- Drop the file_fake container
- Leave f_path fake and special case only fsnotify

Amir Goldstein (2):
  fs: use fake_file container for internal files with fake f_path
  ovl: enable fsnotify events on underlying real files

 fs/cachefiles/namei.c    |  2 +-
 fs/file_table.c          | 91 +++++++++++++++++++++++++++++++++-------
 fs/internal.h            |  5 ++-
 fs/namei.c               | 16 +++----
 fs/open.c                | 28 ++++++++-----
 fs/overlayfs/file.c      |  6 +--
 include/linux/fs.h       | 15 ++++---
 include/linux/fsnotify.h |  3 +-
 8 files changed, 121 insertions(+), 45 deletions(-)

-- 
2.34.1

