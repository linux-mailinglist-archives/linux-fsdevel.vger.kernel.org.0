Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D772F6A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjFNHtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjFNHtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:49:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316ADE62;
        Wed, 14 Jun 2023 00:49:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f8d61cb36cso4113055e9.1;
        Wed, 14 Jun 2023 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686728954; x=1689320954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WhCuOSSt7Ir+GwHlNoVfQ9jICtVyMrmXnKlFPi1bQ1o=;
        b=GNJbVa11E03e6+eHzByNz0txMxVXSWg/nNz3csXj4YZeVUlFgShmlVvYwFWjZDuXp3
         QjNllnTy/xwc+ScDeHIHVANqxgvZFkITtfZgO81aM9eatfN57Yh+uRZuyQyyxQYHUC2v
         XouW+I3xyYR18LZ2GAqZgc2Vogl/QwMvJDq/q9A2s8ZH8o0UUVMnWc2NTsbL6p8hgPCo
         u4yorN6gI/vwGLPzrPVE+mQJ8eBZCJSuxZzydkM02os9/d7C+0VLRg36OEfJN1HNZobb
         WqsKrW2waCVKxWnY0JU2KTghm3UDbUkZmLvrafoSFrHsWtBi2k0pTbo0EcpZu1LxY53L
         Tgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686728954; x=1689320954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhCuOSSt7Ir+GwHlNoVfQ9jICtVyMrmXnKlFPi1bQ1o=;
        b=jNrR5rXK1uiirk03CY81/G7wKHmPG76Ur1+oZLOysdSYGxbWxoquJLdBMladnO2tqa
         MPqsuR56y6U7BYqOO4UR4KPLLEwUjzhPWVdWi53r1cQMzwVFMvvbA87xU3UH648+/svA
         W5iZgiP3eMJiiVfRxRhPWTSjQpu9KzMrgnjvNYgp56hx9LSePwlo+WJJfuIDS6azYKBj
         OG1bnkWFu2bDA0i8RYPWilitp8vZGPBtxPtsy8LR+FQdetJCb2nye7wHlCFLh/soUC4b
         sTngjXRTcZs2oMgOqY6Z2dTBrzwQC6qz9+3tgoTsA5SRuv8JCvtHFNAq2PafpVRuaxsZ
         C4QQ==
X-Gm-Message-State: AC+VfDxePnt4sISzw5RkoffCNHnKha5KnkjApL5AoPtzxxREJPv7+KR3
        /prC5gQJ2TrY9ztpHWF8YsP1LUhiZ9k=
X-Google-Smtp-Source: ACHHUZ44lB3v2J6yc1dKvAM61ukrNULoGT9kxktaGE0d76BwDZctcsJL9zqAlHbXnueiqt7eZYpshA==
X-Received: by 2002:a05:600c:210d:b0:3f1:7581:eaaf with SMTP id u13-20020a05600c210d00b003f17581eaafmr11807186wml.4.1686728954394;
        Wed, 14 Jun 2023 00:49:14 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000050400b0030ae3a6be4asm17588257wrf.72.2023.06.14.00.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 00:49:14 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v4 0/2] Handle notifications on overlayfs fake path files
Date:   Wed, 14 Jun 2023 10:49:05 +0300
Message-Id: <20230614074907.1943007-1-amir73il@gmail.com>
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

Christain,

A little while ago, Jan and I realized that an unprivileged overlayfs
mount could be used to avert fanotify permission events that were
requested for an inode or sb on the underlying fs.

The [v1] patch set was an attempt to implement Miklos' suggestion
(opt-in to query the fake path) which turned out to affet the vfs in
many places, so Miklos and I agreed on a solution that will be less
intrusive for vfs (opt-in to query the real path).

The [v2] patch set took the less intrusive approach to vfs, but it
also tried a different approach of extending the d_real() interface,
which Miklos did not like.

The [v3] patch goes back to the less intrusive approach to vfs without
complicating d_real() interface, that Miklso and I agreed on during the
[v1] patch set review, so hopefully everyone can be happy with it.

This v4 patch set addresses review comments from yourself and from
Christoph on [v3].

Since the patches are 95% vfs, I think it is better if they are merged
through the vfs tree.

I am hoping to solicit an ACK from Jan and Miklos on the minor changes
in ovl and fsnotify in the 2nd patch.

Thanks,
Amir.

Changes since [v3]:
- Rename struct file_fake to backing_file
- Rename helpers to open_backing_file(), backing_file_real_path()
- Rename FMODE_FAKE_PATH to FMODE_BACKING
- Separate flag from FMODE_NOACCOUNT
- inline the fast-path branch of f_real_path()

Changes since [v2]:
- Restore the file_fake container (Miklos)
- Re-arrange the v1 helpers (Christian)

Changes since [v1]:
- Drop the file_fake container
- Leave f_path fake and special case only fsnotify

[v3] https://lore.kernel.org/linux-unionfs/20230611194706.1583818-1-amir73il@gmail.com/
[v2] https://lore.kernel.org/linux-unionfs/20230611132732.1502040-1-amir73il@gmail.com/
[v1] https://lore.kernel.org/linux-unionfs/20230609073239.957184-1-amir73il@gmail.com/

Amir Goldstein (2):
  fs: use backing_file container for internal files with "fake" f_path
  ovl: enable fsnotify events on underlying real files

 fs/cachefiles/namei.c    |  4 +--
 fs/file_table.c          | 74 +++++++++++++++++++++++++++++++++++-----
 fs/internal.h            |  5 +--
 fs/open.c                | 30 +++++++++-------
 fs/overlayfs/file.c      |  8 ++---
 include/linux/fs.h       | 24 ++++++++++---
 include/linux/fsnotify.h |  3 +-
 7 files changed, 113 insertions(+), 35 deletions(-)

-- 
2.34.1

