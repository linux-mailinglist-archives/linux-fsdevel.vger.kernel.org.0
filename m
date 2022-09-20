Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9964B5BEDD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiITTgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiITTgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99988760E9
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IMzCUbeUYJR4dxFroLd9psezzMiiv8P/5qCsste1/8=;
        b=KWZbv4WCpI5uzWznoxZSwW2JwCZYE4t7evUH8jvse8mcY+GaBDcpH229PWfCJc8vK8DZ6t
        Z8fRsphJMn2rYMaeum3PcoA6TelkwVEI5ZvCqdD8xSQ1rPlA3b7Yk8GZXW06Qh6J0qVmHA
        A2udX+t/rX5WC13i451nhnaU0smWqjw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-DCQ-EfKnNNiEgZMeSUD7Kw-1; Tue, 20 Sep 2022 15:36:35 -0400
X-MC-Unique: DCQ-EfKnNNiEgZMeSUD7Kw-1
Received: by mail-ej1-f72.google.com with SMTP id sb32-20020a1709076da000b0077faea20701so1950681ejc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=9IMzCUbeUYJR4dxFroLd9psezzMiiv8P/5qCsste1/8=;
        b=eGA9u/XORy07i/gT0k8CXWiRK5+DyC989hQLdQHXDtw6PVBM7PMdFm/QoOLx7xCv1L
         DwxLMRLi+itAI83HP6HhYOIkkabTNOcwfgwYJyxc1rv45VdC6W4kVJBbnHeiY1Gcos+2
         liNyLhnZwbhX1YxVsBj1MiJu0QM+3lEcHIq4zhlhqElQicTSJzWbQALM7ixZklCXPRng
         /mplAshErQBlLkDkIiaVOKWhsqR64Oo0G7VclFZa9n6TqgCAL8y+zmFzdpzB80Webjn7
         f7L16U7nVVSputF4BZ4w9TWyikQYuuCtFeYS81w+x0BIZnhj8nU/4Olyv68mj4vYA/gm
         zpFQ==
X-Gm-Message-State: ACrzQf0urMn18mikLo3KR5PXE5+VXKbRea9DveEx+6Pm+xFgA/UwlF6Y
        wfDL4PO1v/TD3KKMWXHH+h3Fk5f+fSYzZ9D1cFBTyGjFm138li7p5ZlN2AQN8WiDohAzRXNYBX6
        ebKBl+yZijd9w8oJgN6YT40qCsFAfbeBEQuIPHnw6HrMGM9469HsnaNbB32E5jlpuDIWzOkaO/b
        D7+g==
X-Received: by 2002:a05:6402:40d1:b0:44f:e974:f981 with SMTP id z17-20020a05640240d100b0044fe974f981mr22282837edb.222.1663702594076;
        Tue, 20 Sep 2022 12:36:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ODSlC8sjRPubnBaSPhFPjshsFsZUdVLOf6hJJK6aWBTFud4pYj4/NkwFiaFXd+1QvpVDKAw==
X-Received: by 2002:a05:6402:40d1:b0:44f:e974:f981 with SMTP id z17-20020a05640240d100b0044fe974f981mr22282814edb.222.1663702593790;
        Tue, 20 Sep 2022 12:36:33 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:33 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 0/9] fuse tmpfile
Date:   Tue, 20 Sep 2022 21:36:23 +0200
Message-Id: <20220920193632.2215598-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

This should address your comments.

No xfstests regressions on xfs or overlayfs.  Also tested overlayfs on
fuse.

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile-v3

V3:
 - add bits to Documentation/
 - add hugetlbfs cleanup
 - overlayfs copy-up: move opening target file to caller 

V2:
 - rename finish_tmpfile() to finish_open_simple()
 - fix warning reported by kernel test robot
 - patch description improvements

---
Al Viro (1):
  hugetlbfs: cleanup mknod and tmpfile

Miklos Szeredi (8):
  cachefiles: tmpfile error handling cleanup
  vfs: add tmpfile_open() helper
  cachefiles: use tmpfile_open() helper
  ovl: use tmpfile_open() helper
  vfs: make vfs_tmpfile() static
  vfs: move open right after ->tmpfile()
  vfs: open inside ->tmpfile()
  fuse: implement ->tmpfile()

 Documentation/filesystems/locking.rst |   3 +-
 Documentation/filesystems/porting.rst |  10 +++
 Documentation/filesystems/vfs.rst     |   6 +-
 fs/bad_inode.c                        |   2 +-
 fs/btrfs/inode.c                      |   8 +-
 fs/cachefiles/namei.c                 |  67 +++++++---------
 fs/dcache.c                           |   4 +-
 fs/ext2/namei.c                       |   6 +-
 fs/ext4/namei.c                       |   6 +-
 fs/f2fs/namei.c                       |  13 ++--
 fs/fuse/dir.c                         |  25 +++++-
 fs/fuse/fuse_i.h                      |   3 +
 fs/hugetlbfs/inode.c                  |  42 ++++------
 fs/minix/namei.c                      |   6 +-
 fs/namei.c                            |  84 ++++++++++++--------
 fs/overlayfs/copy_up.c                | 108 ++++++++++++++------------
 fs/overlayfs/overlayfs.h              |  14 ++--
 fs/overlayfs/super.c                  |  10 ++-
 fs/overlayfs/util.c                   |   2 +-
 fs/ramfs/inode.c                      |   6 +-
 fs/ubifs/dir.c                        |   7 +-
 fs/udf/namei.c                        |   6 +-
 fs/xfs/xfs_iops.c                     |  16 ++--
 include/linux/dcache.h                |   3 +-
 include/linux/fs.h                    |  16 +++-
 include/uapi/linux/fuse.h             |   6 +-
 mm/shmem.c                            |   6 +-
 27 files changed, 279 insertions(+), 206 deletions(-)

-- 
2.37.3

