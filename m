Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D14529EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbiEQKIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 06:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245685AbiEQKIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 06:08:22 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB69D2ED7F;
        Tue, 17 May 2022 03:08:01 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id h24so11204185pgh.12;
        Tue, 17 May 2022 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:organization;
        bh=XirZj8YFIR81LcKLoX97oORj6xzfdV7S5MX65+2CLz0=;
        b=Mzn7wKRUYL1xO0lf6gAk+G5Rq7I7nO/qmJjeOzcHY3rXXNU+P9UQsoitXXOcd4tQrn
         f8K9kZc7urOnMIgJNmHeobgpFoAD1LOQIYz96Zz1cNEgQC+4EgmDxTVucluCPTQ7D5CH
         i27Dkt4dbK2VuPXOGnpMOmjbChGpe+/XCT+5TGQnfY+U7+34yvwcDBZd+Z5OC1+4IEKS
         6yZ3xP3PeC4cHLwKyrUFuouzpovvxSgbROmvXVFqgEJDrip4LuQXHkQEcEkM9Qh53Q9n
         asT7QELcr0gpTUCby75Exw2kimZbdiYZ0yKmKmoNKPPiUdg7E+GhSj0oDUJTmvSX7Ls/
         FlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:organization;
        bh=XirZj8YFIR81LcKLoX97oORj6xzfdV7S5MX65+2CLz0=;
        b=Bhq2AwGdAH7J+l+r1nxCdW7YyAaBkFbFZr6XqqzPreBKCL+4tG6g/ia3rnjobHF1nm
         EaIfUzPiSpGQKhO/hBxMlqA4WhRo0l2rf1bf8TKv9Pi3+1XdWGona5mArfJ/KloRknSU
         dK0Id3nbhf/NsM3r+3f06OHcRrDDtjlqrrCyjh871Cs22fR+xQiMIqzINps89+nyNn12
         YXgM+Mptp4n5T1SXGWcQaoexHhs/azumGXfnNfv6dJ/bXNPQsHuSaNL1AGCs+ya31MfN
         FTKxyB7BmsiWxyNwgr2YZlgL4LGwUwsYDFz8ZVGXLD2vHOfjG9QVgp64A6Iqd+yqTf2L
         M/1w==
X-Gm-Message-State: AOAM5305oEMP2CeAV7rwg64kpfLxvBejDnpLpwfZET3tjKvLBnREtjGp
        xlVG10tgjK7uQxqe6w3BOmk=
X-Google-Smtp-Source: ABdhPJx0VuG2VFcMFwgstvt2psvsUO/1bOhamnb5nDHp48rxtFe2cCqXPlH4FPKyG+YiCA1zJCYixA==
X-Received: by 2002:a63:1312:0:b0:3f2:678b:d166 with SMTP id i18-20020a631312000000b003f2678bd166mr8890693pgl.279.1652782080721;
        Tue, 17 May 2022 03:08:00 -0700 (PDT)
Received: from localhost.localdomain ([219.91.171.244])
        by smtp.googlemail.com with ESMTPSA id a10-20020a631a0a000000b003c6ab6ba06csm8202595pga.79.2022.05.17.03.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 03:08:00 -0700 (PDT)
From:   Dharmendra Singh <dharamhans87@gmail.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, bschubert@ddn.com
Subject: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
Date:   Tue, 17 May 2022 15:37:41 +0530
Message-Id: <20220517100744.26849-1-dharamhans87@gmail.com>
X-Mailer: git-send-email 2.17.1
Organization: DDN STORAGE
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In FUSE, as of now, uncached lookups are expensive over the wire.
E.g additional latencies and stressing (meta data) servers from
thousands of clients. These lookup calls possibly can be avoided
in some cases. Incoming three patches address this issue.


Fist patch handles the case where we are creating a file with O_CREAT.
Before we go for file creation, we do a lookup on the file which is most
likely non-existent. After this lookup is done, we again go into libfuse
to create file. Such lookups where file is most likely non-existent, can
be avoided.

Second patch handles the case where we open first time a file/dir
but do a lookup first on it. After lookup is performed we make another
call into libfuse to open the file. Now these two separate calls into
libfuse can be combined and performed as a single call into libfuse.

Here is the link to performance numbers
https://lore.kernel.org/linux-fsdevel/20220322121212.5087-1-dharamhans87@gmail.com/


Dharmendra Singh (3):
  FUSE: Avoid lookups in fuse create
  FUSE: Rename fuse_create_open() to fuse_atomic_common()
  Implement atomic lookup + open

 fs/fuse/dir.c             | 149 +++++++++++++++++++++++++++++++++-----
 fs/fuse/fuse_i.h          |   9 +++
 include/uapi/linux/fuse.h |   5 +-
 3 files changed, 143 insertions(+), 20 deletions(-)

---
v4: Addressed all comments and refactored the code into 3 patches for extended 
    create and atomic open. Dropped the patch for optimizing lookup in
    d_revalidate().
---

