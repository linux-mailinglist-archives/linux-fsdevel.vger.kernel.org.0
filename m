Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DC97B3E16
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjI3FA5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjI3FA5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:00:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB21B9;
        Fri, 29 Sep 2023 22:00:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5859b1c92a0so1386497a12.2;
        Fri, 29 Sep 2023 22:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050055; x=1696654855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMv4JB25eIKmXmuOUK/GNC/1oaLVZUgAaz4JD4n4uhE=;
        b=Kft86MASrOJ8TXsgsreVvDHLifX8thNK6ZcWZaFQJEUubjXdZcIXx2zCu5q4sYtLOt
         QRsIh1R4LHvHCKBu/27nu7wu/Q49Gm6Hjxi6KFh9d7/PmtbGiMNWnSA2CkvK2KoTlwQG
         s2/mr7kKQH0E0WDkvhm1F4cD/rNPnHNHewNuOj2J9yxWRNxgpPwxWQNxbIw0Wrj2U56U
         /u5HqG+Ga6m7HrkJCqXjHn1b1/cdQyQEX1gjW5uQiX8EVVPPbSyA9UIKATH30rUZ1/XK
         ZRuyhjE+Fas4xzcbVXNcLW/6AKPA23bF8vXr3WnaqGlH2FjG91s1wJF1uoupkzYmJ1Bo
         AaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050055; x=1696654855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMv4JB25eIKmXmuOUK/GNC/1oaLVZUgAaz4JD4n4uhE=;
        b=BPVEMZuJVLNw+D623m3M/Xhqgp9A4yVldq7HDVzFLOEz1jhUo4ZLvwXePSjKM2MdRC
         E2TAFhLuLqOOagnpHM44ljicJtapz6Wm5n0r+F6wbozZeIUvxwKrrB4AQnIxaICgw3VW
         /1vqeumCqsIAHGgY6KgoYO0pLS5vtIGqkEeTEH6UAZrbXera9ib8hEe93yjxl6h3KThV
         Qx9SFKnstaD+bOzzh6A9wMeHOmsEGHij8jRL2VCUQOcuJDnfn0AKIHr3tXGgGM3UMYbm
         2Q0iDO/xRHREJdZkWrxk2yR0Ibwgmr5kGaghRviEJ52ceE42WV1vC/0suEjIo/CmcQzz
         Fc4w==
X-Gm-Message-State: AOJu0YwehaIQbrB5LdPK/aYDg8tMjCZhHsnG3R2DWEtaow4aic49SLdk
        y0byZZH3WBNrQjxHc9oe+Dw=
X-Google-Smtp-Source: AGHT+IHEyw4lfkxUjp25/av55WX2JNQOlp3J+w5pJyYGH7FskZJbrM1NAXXH9nMa42u1tsDTLAb/FA==
X-Received: by 2002:a05:6a20:729c:b0:15e:bb88:b76e with SMTP id o28-20020a056a20729c00b0015ebb88b76emr6804458pzk.14.1696050054633;
        Fri, 29 Sep 2023 22:00:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:00:54 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 00/29] const xattr tables
Date:   Sat, 30 Sep 2023 02:00:04 -0300
Message-Id: <20230930050033.41174-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

The 's_xattr' field of 'struct super_block' currently requires a mutable
table of 'struct xattr_handler' entries (although each handler itself is
const). However, no code in vfs actually modifies the tables.

So this series changes the type of 's_xattr' to allow const tables, and
modifies existing file system to move their tables to .rodata. This is
desirable because these tables contain entries with function pointers in
them; moving them to .rodata makes it considerably less likely to be
modified accidentally or maliciously at runtime.

I found this while writing Rust abstractions for vfs.

Wedson Almeida Filho (29):
  xattr: make the xattr array itself const
  ext4: move ext4_xattr_handlers to .rodata
  9p: move xattr-related structs to .rodata
  afs: move afs_xattr_handlers to .rodata
  btrfs: move btrfs_xattr_handlers to .rodata
  ceph: move ceph_xattr_handlers to .rodata
  ecryptfs: move ecryptfs_xattr_handlers to .rodata
  erofs: move erofs_xattr_handlers and xattr_handler_map to .rodata
  ext2: move ext2_xattr_handlers and ext2_xattr_handler_map to .rodata
  f2fs: move f2fs_xattr_handlers and f2fs_xattr_handler_map to .rodata
  fuse: move fuse_xattr_handlers to .rodata
  gfs2: move gfs2_xattr_handlers_max to .rodata
  hfs: move hfs_xattr_handlers to .rodata
  hfsplus: move hfsplus_xattr_handlers to .rodata
  jffs2: move jffs2_xattr_handlers to .rodata
  jfs: move jfs_xattr_handlers to .rodata
  kernfs: move kernfs_xattr_handlers to .rodata
  nfs: move nfs4_xattr_handlers to .rodata
  ntfs3: move ntfs_xattr_handlers to .rodata
  ocfs2: move ocfs2_xattr_handlers and ocfs2_xattr_handler_map to
    .rodata
  orangefs: move orangefs_xattr_handlers to .rodata
  reiserfs: move reiserfs_xattr_handlers to .rodata
  smb: move cifs_xattr_handlers to .rodata
  squashfs: move squashfs_xattr_handlers to .rodata
  ubifs: move ubifs_xattr_handlers to .rodata
  xfs: move xfs_xattr_handlers to .rodata
  overlayfs: move xattr tables to .rodata
  shmem: move shmem_xattr_handlers to .rodata
  net: move sockfs_xattr_handlers to .rodata

 fs/9p/xattr.c                 | 8 ++++----
 fs/9p/xattr.h                 | 2 +-
 fs/afs/internal.h             | 2 +-
 fs/afs/xattr.c                | 2 +-
 fs/btrfs/xattr.c              | 2 +-
 fs/btrfs/xattr.h              | 2 +-
 fs/ceph/super.h               | 2 +-
 fs/ceph/xattr.c               | 2 +-
 fs/ecryptfs/ecryptfs_kernel.h | 2 +-
 fs/ecryptfs/inode.c           | 2 +-
 fs/erofs/xattr.c              | 2 +-
 fs/erofs/xattr.h              | 4 ++--
 fs/ext2/xattr.c               | 4 ++--
 fs/ext2/xattr.h               | 2 +-
 fs/ext4/xattr.c               | 2 +-
 fs/ext4/xattr.h               | 2 +-
 fs/f2fs/xattr.c               | 4 ++--
 fs/f2fs/xattr.h               | 2 +-
 fs/fuse/fuse_i.h              | 2 +-
 fs/fuse/xattr.c               | 2 +-
 fs/gfs2/super.h               | 4 ++--
 fs/gfs2/xattr.c               | 4 ++--
 fs/hfs/attr.c                 | 2 +-
 fs/hfs/hfs_fs.h               | 2 +-
 fs/hfsplus/xattr.c            | 2 +-
 fs/hfsplus/xattr.h            | 2 +-
 fs/jffs2/xattr.c              | 2 +-
 fs/jffs2/xattr.h              | 2 +-
 fs/jfs/jfs_xattr.h            | 2 +-
 fs/jfs/xattr.c                | 2 +-
 fs/kernfs/inode.c             | 2 +-
 fs/kernfs/kernfs-internal.h   | 2 +-
 fs/nfs/nfs.h                  | 2 +-
 fs/nfs/nfs4_fs.h              | 2 +-
 fs/nfs/nfs4proc.c             | 2 +-
 fs/ntfs3/ntfs_fs.h            | 2 +-
 fs/ntfs3/xattr.c              | 2 +-
 fs/ocfs2/xattr.c              | 4 ++--
 fs/ocfs2/xattr.h              | 2 +-
 fs/orangefs/orangefs-kernel.h | 2 +-
 fs/orangefs/xattr.c           | 2 +-
 fs/overlayfs/super.c          | 4 ++--
 fs/reiserfs/reiserfs.h        | 2 +-
 fs/reiserfs/xattr.c           | 2 +-
 fs/smb/client/cifsfs.h        | 2 +-
 fs/smb/client/xattr.c         | 2 +-
 fs/squashfs/squashfs.h        | 2 +-
 fs/squashfs/xattr.c           | 2 +-
 fs/ubifs/ubifs.h              | 2 +-
 fs/ubifs/xattr.c              | 2 +-
 fs/xattr.c                    | 6 +++---
 fs/xfs/xfs_xattr.c            | 2 +-
 fs/xfs/xfs_xattr.h            | 2 +-
 include/linux/fs.h            | 2 +-
 include/linux/pseudo_fs.h     | 2 +-
 mm/shmem.c                    | 2 +-
 net/socket.c                  | 2 +-
 57 files changed, 69 insertions(+), 69 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.34.1

