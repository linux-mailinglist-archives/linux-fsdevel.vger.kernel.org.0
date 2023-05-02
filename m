Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63706F441C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjEBMsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 08:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjEBMs0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 08:48:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1310D59D8;
        Tue,  2 May 2023 05:48:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062db220a3so1417276f8f.0;
        Tue, 02 May 2023 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683031703; x=1685623703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JooDqQHtb6tzP9frEgY2kAPOSpeIW6/2YPfInBxKMsI=;
        b=fxp9GBxOUXAYc9XvyjEQt1VV3L7DXkzp/o9k8tN6ufqmPR3+p7mc/zqiNT+6fDujqr
         dwViXaREasIX6+ZtPTUy4P8PRiFFiAFNfcuIFvjj+uRSEy9q2eT7TUBWirPu8FtVC+wi
         iXupLRxKw693p4XXmNuacYjttMDNmr1YhcP4E0JOM/MXrzlXCxKXXddDX1oIMmqG3Ref
         U6gJYszGYjCJuS1rWM0ISxnAzwYw/H3hs2itjHNKDuc+YKV6O2RQMBuc+obL5MIlRZjb
         W9COsueOSAwIxhC9Ig0RuVgw/aUn22CcirwhFv2/9Kys+SevUQB4/zlSQHATzm3qG6TK
         Jcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683031703; x=1685623703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JooDqQHtb6tzP9frEgY2kAPOSpeIW6/2YPfInBxKMsI=;
        b=hjNIbS8KFJAHdMBDp0VGGzdtZmOGxqyuhp49Zjb3jngC6b1sPgOcyOU/Eh1TAEYVtx
         5mQZ3QC8pUqSFj2t4BeCJXL6pTmwzdaVth+9L2FWPsOWhuoqZ3e9XZn81+wINMogr7lg
         6aQ0+EtrXxoLhXcM8SVK1ufj9J7kJRqE9HhCvpntUu7Lhx46lZ+X5tWeqxpqM1wHXTel
         6kr9bGWHvyUFDfpISTYTfQXeXH92z3Hdt4iWVcU95uIJRUvpopFuEstFTgSFSQ9xkWSI
         HhFPAQfP0kPI7ag0zgclq9jeydhVwaWb4R8YsPGl/HEIqj5BIyasNUZ/Ce0z90bG2hhm
         1iIg==
X-Gm-Message-State: AC+VfDxL9xEEgmtAxjPKhq4uQosTBHEwN0q1NT+xlAnuGO04FosVpVuZ
        kJZt3pfqJ/lilVJv/N66GUs=
X-Google-Smtp-Source: ACHHUZ64f4ZE78idc6pi+50aWLIFmp6qAgX12q2FScHycyYGhjhEYZGkqYT/kkqxAfcLu5f/GQIsHg==
X-Received: by 2002:adf:e30f:0:b0:2f6:9368:63c5 with SMTP id b15-20020adfe30f000000b002f6936863c5mr11708964wrj.10.1683031703199;
        Tue, 02 May 2023 05:48:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id d9-20020a5d6dc9000000b00304adbeeabbsm14226259wrz.99.2023.05.02.05.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 05:48:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 0/4] Prepare for supporting more filesystems with fanotify
Date:   Tue,  2 May 2023 15:48:13 +0300
Message-Id: <20230502124817.3070545-1-amir73il@gmail.com>
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

Jan,

Following v2 incorporates a few fixes and ACKs from review of v1 [1].

While fanotify relaxes the requirements for filesystems to support
reporting fid to require only the ->encode_fh() operation, there are
currently no new filesystems that meet the relaxed requirements.

Patches to add ->encode_fh() to overlay with default configuation
are available on my github branch [2].  I will re-post them after
this patch set will be approved.

Based on the discussion on the UAPI alternatives, I kept the
AT_HANDLE_FID UAPI, which seems the simplest of them all.

There is an LTP test [3] that tests reporting fid from overlayfs,
which also demonstrates the use of AT_HANDLE_FID for requesting a
non-decodeable file handle by userspace and there is a man page
draft [4] for the documentation of the AT_HANDLE_FID flags.

Thanks,
Amir.

Changes since v1:
- Fixes to Kerneldoc (Chuck)
- Added ACKs (Chuck,Jeff)
- Explain the logic of requiring ->s_export_op (Jan)
- Added man page draft

[1] https://lore.kernel.org/linux-fsdevel/20230425130105.2606684-1-amir73il@gmail.com/
[2] https://github.com/amir73il/linux/commits/exportfs_encode_fid
[3] https://github.com/amir73il/ltp/commits/exportfs_encode_fid
[4] https://github.com/amir73il/man-pages/commits/exportfs_encode_fid

Amir Goldstein (4):
  exportfs: change connectable argument to bit flags
  exportfs: add explicit flag to request non-decodeable file handles
  exportfs: allow exporting non-decodeable file handles to userspace
  fanotify: support reporting non-decodeable file handles

 Documentation/filesystems/nfs/exporting.rst |  4 +--
 fs/exportfs/expfs.c                         | 33 ++++++++++++++++++---
 fs/fhandle.c                                | 22 +++++++++-----
 fs/nfsd/nfsfh.c                             |  5 ++--
 fs/notify/fanotify/fanotify.c               |  4 +--
 fs/notify/fanotify/fanotify_user.c          |  7 ++---
 fs/notify/fdinfo.c                          |  2 +-
 include/linux/exportfs.h                    | 18 +++++++++--
 include/uapi/linux/fcntl.h                  |  5 ++++
 9 files changed, 74 insertions(+), 26 deletions(-)

-- 
2.34.1

