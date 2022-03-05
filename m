Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6931C4CE5BC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Mar 2022 17:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiCEQFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiCEQFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:05:35 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2C54BCA;
        Sat,  5 Mar 2022 08:04:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so6671279wma.4;
        Sat, 05 Mar 2022 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aI1kTSJlZCn6rF/b3gjxXvp8qotZbFaZ/Pvew62pBcE=;
        b=AAiHZ/vqILwHzCHEOOWothYV5SvTsEwlDIYzqEbw+ti46tVsM2+69sFPF1VrhfhSl4
         8xqAxhPmYVzIWrbg9toQN4WgYULcoFI/M8RTB42FA6FrSf3xKB2uEiS6YqArZHeA1md5
         7jKua0rm9tDbo5ZFq+y6fFRy8Dfu+N2FOE3rPYxNVKXHytmQl8ZVKCo9vgRFZtaajMG+
         Mh15ztHBkWrGLHWnWuzsWseahC+IESDkSmv6T7EV5PljInndr8CsQm9Yb0gotxi/rWfm
         0DiMlie27kI5kt7dN2QHgY/pLZ0t6l/WisaynwOydT58h6jPZxtyi6T+CrnrZY079fiU
         9W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aI1kTSJlZCn6rF/b3gjxXvp8qotZbFaZ/Pvew62pBcE=;
        b=skQ75UM2emmvXugtMdIPpDjuyyllyGm1yOlym7MrL7AfCY3qahw5oblyYdCVe5pxWq
         XTmAfKo+bMeNlR19jiHEMnNUYZZeBtrKSSsKgKRqfk7gpFksglYTKlIZ9CLlJi+P0X30
         TNroLeS8hJiz8dkga5HYy9org0vgo1N8+owYQL2OBK9bP7BO6wKI5+Xc8dt+gDPJe4t+
         ClTeTyR6vyt3lj84IpLkg3jrV8eAY+t/tbqkK47n5vNfREQ2rF5MEOhKO152oel8V5Hv
         pLjCVi9VaB3BI3f2FKixhdBjqLGJJEymAeC6ZfZUx2chO6+tosVlBGsUD92TeZ9PHBc2
         kiUg==
X-Gm-Message-State: AOAM530eHebuLwwEu2y1grpinjeqeVdPu3Jg+XXzWm/JFqKSt/omNcXv
        kQ69MkDXpiEu7Ncj+15pObiG8joaxN8=
X-Google-Smtp-Source: ABdhPJzgX5GZP4r5MA8tuA72HG+BIxF7n7MruKdyXRDBLKLj+eS6/ZL7t+HlhLhnUxa3ulZ+81T6jw==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr11961550wmj.98.1646496281007;
        Sat, 05 Mar 2022 08:04:41 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d5985000000b001f0122f63e1sm1650717wri.85.2022.03.05.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:04:40 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 0/9] Generic per-sb io stats
Date:   Sat,  5 Mar 2022 18:04:15 +0200
Message-Id: <20220305160424.1040102-1-amir73il@gmail.com>
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

I ran some micro benchmarks on v3 patch [1] which demonstrated up to
20% slowdown for some workloads (many small reads/writes in a small VM).
This revision adds the "relaxed" percpu counter helpers to mitigate
the iostats counters overhead.

With the relaxed counters, the micro benchmarks that I ran did not
demonstrate any measurable overhead on xfs, on overlayfs over xfs
and overlayfs over tmpfs.

Dave Chinner asked why the io stats should not be enabled for all
filesystems.  That change seems too bold for me so instead, I included
an extra patch to auto-enable per-sb io stats for blockdev filesystems.

Should you decide to take the patches for enabling io stats for
overlayfs and/or fuse through your tree, it is up to you to whether you
want to take this patch as well or leave it out until more people have
a chance to test it and run more performance tests on their setups.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20220301184221.371853-1-amir73il@gmail.com/

Changes since v3:
- Use "relaxed" counters to reduce performance overhead
- Opt-in to per-sb io stats via fs_flags (dchinner)
- Add patch to auto-enable io stats for all blockdev fs (dchinner)

Changes since v2:
- Change from per-mount to per-sb io stats (szeredi)
- Avoid percpu loop when reading mountstats (dchinner)

Changes since v1:
- Opt-in for per-mount io stats for overlayfs and fuse

Amir Goldstein (9):
  lib/percpu_counter: add helpers for "relaxed" counters
  lib/percpu_counter: add helpers for arrays of counters
  fs: tidy up fs_flags definitions
  fs: add optional iostats counters to struct super_block
  fs: collect per-sb io stats
  fs: report per-sb io stats
  ovl: opt-in for per-sb io stats
  fuse: opt-in for per-sb io stats
  fs: enable per-sb io stats for all blockdev filesystems

 fs/Kconfig                     |   8 ++
 fs/fuse/inode.c                |   3 +-
 fs/nfsd/export.c               |  10 ++-
 fs/nfsd/nfscache.c             |   5 +-
 fs/nfsd/stats.c                |  37 +---------
 fs/nfsd/stats.h                |   3 -
 fs/overlayfs/super.c           |   3 +-
 fs/proc_namespace.c            |  16 ++++
 fs/read_write.c                |  88 ++++++++++++++++------
 fs/super.c                     |  11 +++
 include/linux/fs.h             |  25 ++++---
 include/linux/fs_iostats.h     | 130 +++++++++++++++++++++++++++++++++
 include/linux/percpu_counter.h |  48 ++++++++++++
 lib/percpu_counter.c           |  27 +++++++
 14 files changed, 337 insertions(+), 77 deletions(-)
 create mode 100644 include/linux/fs_iostats.h

-- 
2.25.1

