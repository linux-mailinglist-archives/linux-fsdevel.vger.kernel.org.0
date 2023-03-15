Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5036BBFD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 23:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCOWf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 18:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCOWf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:35:26 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11D917CFE;
        Wed, 15 Mar 2023 15:35:25 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so3785121pjz.1;
        Wed, 15 Mar 2023 15:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678919725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyIknLOmhzXiRoeU62yIbB8smoLHFOuKjVdK+xM/klk=;
        b=fsPqbkulYXa4J+YJFEMda8IUhygHMczIib266Vb4cWBlq7cCEdKgpcKng9Oxf2wG/5
         mvqGk6EcUrAp1foz4N8rueSjpdTj6p1XCqzdHuwIlSviGt5pykuSkTQu8Qu5o7Ss6+Kn
         ti+VbpHy9i+n1SDFwhUDo1KjDKSPwZcVDsMnhE0AaFpq9NQlMaNQnQO3NRS3gsZ+uUjm
         pHUnisxg1yOwv0CNa6L4KVKTNptXhvTUJcFf0WCC55RCw/br6Cfuj0PuUts8IMSOoApp
         B6puqwqe03EsoAaWh4v1jbVqglGzFDtfc115NhW3uWBYYzk4r1ZpsFV4L2+oBMaRtyHO
         sYQQ==
X-Gm-Message-State: AO0yUKUhVI7M6o8MrNeq+zQUO/tNIviMah1Om72v0Wey+ZfBXFuufGjO
        5NhERRC+udwdNoARF7WgmEo=
X-Google-Smtp-Source: AK7set+cWTYvzBSpsMO56TkYaNURayM6M25c0VMhLLAr5NPvHbOrGCLSoY6YJLbQcjeQ1rqMIxkBxA==
X-Received: by 2002:a05:6a20:3d03:b0:d3:a13a:4c35 with SMTP id y3-20020a056a203d0300b000d3a13a4c35mr1418018pzi.6.1678919725103;
        Wed, 15 Mar 2023 15:35:25 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id c12-20020aa781cc000000b005dc70330d9bsm4034369pfn.26.2023.03.15.15.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:35:24 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        brauner@kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v8 0/3] ksmbd patches included vfs changes
Date:   Thu, 16 Mar 2023 07:34:32 +0900
Message-Id: <20230315223435.5139-1-linkinjeon@kernel.org>
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

v8:
  - Don't call vfs_path_lookup() to avoid repeat lookup, Instead, lookup
    last component after locking the parent that got from vfs_path_parent_lookup
    helper.
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
 fs/ksmbd/smb2pdu.c    | 147 ++++----------
 fs/ksmbd/vfs.c        | 435 ++++++++++++++++++------------------------
 fs/ksmbd/vfs.h        |  19 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            | 125 +++++++++---
 include/linux/namei.h |   9 +
 7 files changed, 342 insertions(+), 400 deletions(-)

-- 
2.25.1

