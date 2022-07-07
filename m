Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A556A1FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbiGGMcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiGGMca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:32:30 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4852A205F7;
        Thu,  7 Jul 2022 05:32:30 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 145so18217454pga.12;
        Thu, 07 Jul 2022 05:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0+3gGGHGSRYILkmDsrdHu4ItFEdxRLioJSHJJ5TE8ec=;
        b=cSs9vZgE+tb2a7TBnoGBxyrAgHme3glfhV/BXSPFcj/6Go1VBaY5F1PBh+v5szLEt/
         jlImtFArS4U43kVjaTPtT/FOaoJcCHwfRNb82ZXWpbek8iFpRwMlH+5+WiHgqPKLnh2N
         OfLgpIzASwgIo3p/NcnC1aOIFS08/bbOJzQBnX0kJ1obYMqhnM6cyp1nKeS1UAVu+s3B
         oMUaFome+GjtbPETuKpFPSwgbwMQFO031EuAaAp4i/SjJ4b1GWKHjCo8jozp/StwdR1S
         Gf+xh94nLzdo1g7rtXvM+EGsis3xFqv0GbNMgk5RPC/nblBDY8BtqhHHRT5S32sfYCsW
         gqEg==
X-Gm-Message-State: AJIora9toFUhbdln6/yBnJhODnOeK0OP7kKFd4cOW7WzVtjmy6IwlodO
        itMLp4jG0OJVKBgLr3Z2L74=
X-Google-Smtp-Source: AGRyM1uKX4ZWeLr7/42CVS6WpTmR79kaOZ+VG4CggRVyf/GhbFknZMj8TV+3CmLndckVmJ2ccB8W0g==
X-Received: by 2002:a05:6a00:170e:b0:525:4cac:fa65 with SMTP id h14-20020a056a00170e00b005254cacfa65mr52927549pfc.40.1657197149682;
        Thu, 07 Jul 2022 05:32:29 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm25825227pgk.76.2022.07.07.05.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:32:29 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v6 0/3] ksmbd patches included vfs changes
Date:   Thu,  7 Jul 2022 21:32:02 +0900
Message-Id: <20220707123205.6902-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset contains vfs changes that are needed to fix racy issue
in ksmbd. Added the 1/3 patch by Al's additional review comment.

Al Viro (1):
  fs: introduce lock_rename_child() helper

Namjae Jeon (2):
  ksmbd: remove internal.h include
  ksmbd: fix racy issue from using ->d_parent and ->d_name

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
 fs/ksmbd/smb2pdu.c    | 146 ++++-----------
 fs/ksmbd/vfs.c        | 415 +++++++++++++++++-------------------------
 fs/ksmbd/vfs.h        |  19 +-
 fs/ksmbd/vfs_cache.c  |   5 +-
 fs/namei.c            | 103 ++++++++---
 include/linux/namei.h |   9 +
 7 files changed, 299 insertions(+), 400 deletions(-)

-- 
2.34.1

