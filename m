Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0044C936B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 19:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiCASnU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 13:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiCASnT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 13:43:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ADC2AD3;
        Tue,  1 Mar 2022 10:42:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b5so21999314wrr.2;
        Tue, 01 Mar 2022 10:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vLWjZLiCgt7J8tD1cvWy0HmD9TGfbY7gITgVAS69YxY=;
        b=FDXRqbQ2x+BhkC0JQaPX6kuPk+mWWgJBqIIty6HIx5vdTebOREczeIYXuFSBGm9u1D
         b3PkmYWj1hSZHiKl52mQodm2qrmDVFtcF9el32LubJRs20lFl90q8FO32QkYk7ZmEYiJ
         V7PGrkuyKU6jD1513ApxAyGBxxm1XlmVXKkfMquBYfr9P3QKYpzkLXnqqfUELzGFLMM6
         3iOIC82Rv+eb783r8gF8IQptAB6J+9ZnRBlFdMsxeqmKzPh/8g0woaoy3r46VWYwCHsD
         SyWC05FkD5Ek6rHaeZ0/TPlmPxmgNmGYhS5tTXPnSmVnUSVeCxFmTwPJ8toBUhnRYNAo
         jx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vLWjZLiCgt7J8tD1cvWy0HmD9TGfbY7gITgVAS69YxY=;
        b=bMqBcooHpo9Ic48SzMCnTAHDWxjZCln6mQHHt7xGFvlMGhWcFTz8vZOXlEwwRndYod
         3ifmgsVwab9S7uDWkEhZzaVgrvy8daNSFaQqKNs/nUGZYajuorK4BV6ePhuWd1KrJynb
         5tebe0ORP92xb3Yi5fXLldPQJxVgyn436f19NR6q/I7dzdBJgfFmmaUdImwncwbd0FQW
         c2MiyMwDqJ+KNrsul20sL+rAhLISZscNCZwXA3UrfEFKkDhK/CO7YSo0KwWGUvFE7Oek
         XWRvXp5fWebpzgspIypMZU/wcnL3fA00z2oUMdPiseBlU8sjRKvgwLmvRvx3Z7RduAN1
         3CTQ==
X-Gm-Message-State: AOAM532OcjHrkpKE+sUmucAg0etUZXF0XPMCaoe9+5tkFMfJfmgtL+5O
        nTU7lxJm4/JIuMWCogLXgek8HxHYCCg=
X-Google-Smtp-Source: ABdhPJxyF14dQoDRfHGTnen8PPZKWf39hq8Tl/3YYqOL02DaQr9kQ2og856cmSqQd0xUcl68RSnb5w==
X-Received: by 2002:a5d:4890:0:b0:1ed:9d4e:f8ef with SMTP id g16-20020a5d4890000000b001ed9d4ef8efmr20825410wrq.595.1646160156482;
        Tue, 01 Mar 2022 10:42:36 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d4dc1000000b001eeadc98c0csm14020381wru.101.2022.03.01.10.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:42:36 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 0/6] Generic per-sb io stats
Date:   Tue,  1 Mar 2022 20:42:15 +0200
Message-Id: <20220301184221.371853-1-amir73il@gmail.com>
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

Miklos,

Following your feedback on v2 [1], I moved the iostats to per-sb.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20220228113910.1727819-1-amir73il@gmail.com/

Changes since v2:
- Change from per-mount to per-sb io stats (szeredi)
- Avoid percpu loop when reading mountstats (dchinner)

Changes since v1:
- Opt-in for per-mount io stats for overlayfs and fuse

Amir Goldstein (6):
  lib/percpu_counter: add helpers for arrays of counters
  fs: add optional iostats counters to struct super_block
  fs: collect per-sb io stats
  fs: report per-sb io stats
  ovl: opt-in for per-sb io stats
  fuse: opt-in for per-sb io stats

 fs/Kconfig                     |   8 +++
 fs/fuse/inode.c                |   5 ++
 fs/nfsd/export.c               |   7 +-
 fs/nfsd/nfscache.c             |   5 +-
 fs/nfsd/stats.c                |  37 +---------
 fs/nfsd/stats.h                |   3 -
 fs/overlayfs/super.c           |   5 ++
 fs/proc_namespace.c            |  16 +++++
 fs/read_write.c                |  88 ++++++++++++++++-------
 fs/super.c                     |   2 +
 include/linux/fs.h             |  10 ++-
 include/linux/fs_iostats.h     | 127 +++++++++++++++++++++++++++++++++
 include/linux/percpu_counter.h |  28 ++++++++
 lib/percpu_counter.c           |  27 +++++++
 14 files changed, 300 insertions(+), 68 deletions(-)
 create mode 100644 include/linux/fs_iostats.h

-- 
2.25.1

