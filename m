Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC95BF065
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 00:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiITWnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 18:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiITWnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:43:49 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A448170E5E;
        Tue, 20 Sep 2022 15:43:47 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id go6so4610201pjb.2;
        Tue, 20 Sep 2022 15:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7uw/f9c+nCZzXgzwmcjTyDKtXN+DLD2VFzYdXOsZOpU=;
        b=IzcJdo0UzYquJxVmvKD140KMxFdgIP23H9rRpoLxNk/GSF+up9Wwr3I8XU94m3z8lM
         MXB7w8alaJ2QzO8oVo+bPlleQP7NmlWtS+b1Uh6ZzP90ZUbH/eN0kIJfiBhkhpwZ/Ya2
         4b1Hm/quFI1iPJVVdl/uHfj2MdSAa7IoQe9ZW5u5TiBYYC7J7Txr4NJWs40aTZ4SI5yu
         utLC3QBO/F3QSK2N88QwgQJ+/OZ4bzdrBN4xJJXvjiy6CTNv4n78XcnodI0Gn2jDzayI
         qJRCUw5LJBO0AoE0z9wjxROtMKv/SwTVShUQOdZzVCDx6YNvh0hI6J2nr8igxtFxT1Ws
         u3og==
X-Gm-Message-State: ACrzQf2wWXvT5QqKLfQlfn9qif1ZFewtfT/ZbJSkaYuWCSyCGt4X6iFv
        yn7SYzdyvAnKJnMmstom2XU=
X-Google-Smtp-Source: AMsMyM6Z0MEMytSfwzOz9A2ZFVNUUlkrHHJbqTump5CVAkYp6ziqGuh5Y5R/uJ8LWmAfPxY74CfYCA==
X-Received: by 2002:a17:903:2d0:b0:172:b63b:3a1e with SMTP id s16-20020a17090302d000b00172b63b3a1emr1816144plk.76.1663713827127;
        Tue, 20 Sep 2022 15:43:47 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id 13-20020a62140d000000b0053e93aa8fb9sm451352pfu.71.2022.09.20.15.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:43:46 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v7 0/3] ksmbd patches included vfs changes
Date:   Wed, 21 Sep 2022 07:43:35 +0900
Message-Id: <20220920224338.22217-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset contains vfs changes that are needed to fix racy issue
in ksmbd. Added the 1/3 patch by Al's additional review comment.

v7:
  - constify struct path.
  - recreate patch-set base on recent Al's patches.
v6:
  - rename __lookup_hash() to lookup_one_qstr_excl and export.
  - change dget() to dget_parent() in unlink.
  - lock parent of open file in smb2_open() to make file_present
    worthable.
v5:
  - add lock_rename_child() helper.
  - remove d_is_symlink() check for new_path.dentry.
  - use lock_rename_child() helper instead of lock_rename().
  - use dget() instead of dget_parent().
  - check that old_child is still hashed.
  - directly check child->parent instead of using take_dentry_name_snapshot().
v4:
   - switch the order of 3/4 and 4/4 patch.
   - fix vfs_path_parent_lookup() parameter description mismatch.
v3:
  - use dget_parent + take_dentry_name_snapshot() to check stability of source
    rename in smb2_vfs_rename().
v2:
  - add filename_lock to avoid racy issue from fp->filename. (Sergey Senozhatsky)
  - fix warning: variable 'old_dentry' is used uninitialized (kernel
    test robot)

Al Viro (1):
  fs: introduce lock_rename_child() helper

Namjae Jeon (2):
  ksmbd: remove internal.h include
  ksmbd: fix racy issue from using ->d_parent and ->d_name

 fs/internal.h         |   2 -
 fs/ksmbd/smb2pdu.c    | 145 ++++-----------
 fs/ksmbd/vfs.c        | 415 +++++++++++++++++-------------------------
 fs/ksmbd/vfs.h        |  19 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            | 103 ++++++++---
 include/linux/namei.h |   9 +
 7 files changed, 299 insertions(+), 399 deletions(-)

-- 
2.25.1

