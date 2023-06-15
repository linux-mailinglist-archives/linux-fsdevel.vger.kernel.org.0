Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB179731666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbjFOLWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjFOLWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421772686;
        Thu, 15 Jun 2023 04:22:40 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f642a24568so10370223e87.2;
        Thu, 15 Jun 2023 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828158; x=1689420158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0KtpcFwjpJl3c1PhNfsCXQR8nYsWg9z5dk75zopHRY=;
        b=T4GeQTgVd5ztM6IRa6O+T6tmhDDYvD0ZLu4k7gqx/xjrX8vWhSza30qOWZXRUBL+F8
         kmq4eWkXIRL90rCIam3fo2cMYww3jD5PO/0KgpVPqPx6QGQRh0JQbbgDL1ITa8e+Kt4o
         fJtyoy+f00+1Cr1We2ssONl1iLRhaeea6EcJNQEwKuOWNjABRQA8P/1y1j09mMZawOg+
         JIrxPu2aIbRPrcdVdJ3wxMCxKaczA2TyqwaZXU77X/wcxLb4b1B2WcePS8VQVFf+xMga
         k/nRzuIOFrsHpNv/DHUGmZN8SFlnumyHLFzUCy53G09NrD4Xow9BWdZJFMSCOt4tGQum
         TAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828158; x=1689420158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0KtpcFwjpJl3c1PhNfsCXQR8nYsWg9z5dk75zopHRY=;
        b=GE1oB8NKpLe78WpBu8Q73zN8sylnwdO47aPyW8Cs4Ew6SmuCZUble9EkgTMie/eH0n
         eBY5uruKb7w0rgOoAXvf4KUDujpg3Mq9ZWKuOiudzpb4RpnGN5/aUAu75qhw0zLYwcMo
         Gx6rt8aSnm5lrOcr/EC5xs35c/vs35BLkepO5OqdRrmltwFuZCFZS2hbtbdCXPqKr44a
         EV76SNJ9HKSjZUV448Bu0RJytGMwi6lsq5iyjJilqPcv0nkfHHtJvxGl9eznCpWoeINn
         bImkC4+OMG364KEySXQQ7riNN7ocN+FQnGEzlZI7UxTt6SBAzAWBW7x6x6hco3JhEVx2
         6hiw==
X-Gm-Message-State: AC+VfDwAKhPmewK1SfLu+D/3Ze2/oXAc+wVC3GuAlx8zq+MbiHJBX+6x
        gW8op3XM9p3bjj1bIxnb++CUVTYX218=
X-Google-Smtp-Source: ACHHUZ7c9woY31p++kW21MxwkF+GnBlVv0iMWHfDmmCV/xnK51uhsAu5Y45jt40mmRLOqdXoAC+bcQ==
X-Received: by 2002:a19:7708:0:b0:4f7:6727:548e with SMTP id s8-20020a197708000000b004f76727548emr2954604lfc.64.1686828158155;
        Thu, 15 Jun 2023 04:22:38 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 0/5] Handle notifications on overlayfs fake path files
Date:   Thu, 15 Jun 2023 14:22:24 +0300
Message-Id: <20230615112229.2143178-1-amir73il@gmail.com>
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

Christian,

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

This v5 patch set addresses review comments from yourself and from
Christoph on [v3] and [v4].

Since the patches are 95% vfs, I think it is better if they are merged
through the vfs tree.

I am still hoping to solicit an ACK from Miklos on the ovl change
in the last patch.

Thanks,
Amir.

Changes since [v4]:
- ACK from Jan for fsnotify patch
- Do not use backing_file for cachefiles (brauner)
- Consistent naming scheme *_*file_open() (brauner)
- Split patches and better documentation (hch)

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

[v4] https://lore.kernel.org/linux-unionfs/20230614074907.1943007-1-amir73il@gmail.com/
[v3] https://lore.kernel.org/linux-unionfs/20230611194706.1583818-1-amir73il@gmail.com/
[v2] https://lore.kernel.org/linux-unionfs/20230611132732.1502040-1-amir73il@gmail.com/
[v1] https://lore.kernel.org/linux-unionfs/20230609073239.957184-1-amir73il@gmail.com/

Amir Goldstein (5):
  fs: rename {vfs,kernel}_tmpfile_open()
  fs: use a helper for opening kernel internal files
  fs: move kmem_cache_zalloc() into alloc_empty_file*() helpers
  fs: use backing_file container for internal files with "fake" f_path
  ovl: enable fsnotify events on underlying real files

 fs/cachefiles/namei.c    | 10 ++---
 fs/file_table.c          | 91 ++++++++++++++++++++++++++++++++--------
 fs/internal.h            |  5 ++-
 fs/namei.c               | 24 ++++++-----
 fs/open.c                | 75 ++++++++++++++++++++++++++++-----
 fs/overlayfs/file.c      |  8 ++--
 fs/overlayfs/overlayfs.h |  5 ++-
 include/linux/fs.h       | 32 ++++++++++----
 include/linux/fsnotify.h |  3 +-
 9 files changed, 192 insertions(+), 61 deletions(-)

-- 
2.34.1

