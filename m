Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128CC5E5DC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiIVIpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVIoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94845AC4C
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PgZm2+lys5sGNQde1I+ZduColks0iv+i8YmNGJ+rDfU=;
        b=FsYzQiYY4K3NjXcAx5Ag2Emm2wfAR3eEq0tdUZYw4ikmiqJqT7J2V6oNhrfF7HKfrIg2z2
        1tseapLyrqMwjUH3YwXzW7tJAkeP+iymloKJo35kgZ8TrGD3lihNLndgCvQOZjn9xrIFcO
        v6X8uRtKdan1LDY5jZKpUTPbuiSzsrA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-245-SsKLWZXUPpmqbV-gcicu1Q-1; Thu, 22 Sep 2022 04:44:46 -0400
X-MC-Unique: SsKLWZXUPpmqbV-gcicu1Q-1
Received: by mail-ed1-f69.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so6167171edd.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PgZm2+lys5sGNQde1I+ZduColks0iv+i8YmNGJ+rDfU=;
        b=AsWtbIpq7GPIW85sGs0e/ihOeB0vwQ2tfyE9d181VMqUsOC3M7WVrn3hrC7Of9RoTM
         J5sTq/4hoXgip8WtmEevW3XbKTSMc7MZt9KcHznrs29jHK9Ej+3CcW8dylfoOBBWA7cB
         J5IcZ8OxnWLoBHhtJcrKSR0ufvKKyIsR/dfIktIVY2FhQYSukLQKiFQ6J/+qKd0G49S9
         dCpmDcpSshmeCn2xRM7kLig8fcWXVwB7x5+TcIL85Rsd5eb+Yd7HwCqLaxq64XU7jEhX
         wojCl7HtRodB3jelvifHrhv3LuzuMxNld0IBLFghOl8S1GVUyFY5/EbSgg0bAsFzIzNP
         YV8Q==
X-Gm-Message-State: ACrzQf3DZkPs4qxDDabLZa8pQWnErIdSVRVHKynBgGg7xMAcKFECG1LI
        Y8j1jdTfjirq8uy8BBf5p72ZQ1jpSF651uemntPWBUQ+y0uX4X9dBmQSdtjj7g07JwGkYJLGQf+
        pqOP2n/nbVryOGfV/PcZBkSnxMV21H2fsd6gl57a23M4CnUTTJuBw2/yUYFlk58uyDRonYgciOG
        dg3w==
X-Received: by 2002:a17:907:a051:b0:77a:e136:6ad2 with SMTP id gz17-20020a170907a05100b0077ae1366ad2mr1812607ejc.764.1663836284811;
        Thu, 22 Sep 2022 01:44:44 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6zF+YS8G/XLituA/UrRgjazaaA5N7qNzvj1jDHv69qJm3y9TW+B7U7t9xKC8HELNpfCWQ32Q==
X-Received: by 2002:a17:907:a051:b0:77a:e136:6ad2 with SMTP id gz17-20020a170907a05100b0077ae1366ad2mr1812588ejc.764.1663836284589;
        Thu, 22 Sep 2022 01:44:44 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 00/10] fuse tmpfile
Date:   Thu, 22 Sep 2022 10:44:32 +0200
Message-Id: <20220922084442.2401223-1-mszeredi@redhat.com>
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

Another update...

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#fuse-tmpfile-v4

V4:
 - add a patch to clean up cachefiles' in-use marking helpers
 - don't access child after dput in vfs_tmpfile()
 - rename tmpfile_open() to vfs_tmpfile_open()
 - clean up error path in fuse_tmpfile()
 - patch description improvements

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

Miklos Szeredi (9):
  vfs: add vfs_tmpfile_open() helper
  cachefiles: tmpfile error handling cleanup
  cachefiles: only pass inode to *mark_inode_inuse() helpers
  cachefiles: use vfs_tmpfile_open() helper
  ovl: use vfs_tmpfile_open() helper
  vfs: make vfs_tmpfile() static
  vfs: move open right after ->tmpfile()
  vfs: open inside ->tmpfile()
  fuse: implement ->tmpfile()

 Documentation/filesystems/locking.rst |   3 +-
 Documentation/filesystems/porting.rst |  10 +++
 Documentation/filesystems/vfs.rst     |   6 +-
 fs/bad_inode.c                        |   2 +-
 fs/btrfs/inode.c                      |   8 +-
 fs/cachefiles/namei.c                 | 110 +++++++++++---------------
 fs/dcache.c                           |   4 +-
 fs/ext2/namei.c                       |   6 +-
 fs/ext4/namei.c                       |   6 +-
 fs/f2fs/namei.c                       |  13 +--
 fs/fuse/dir.c                         |  24 +++++-
 fs/fuse/fuse_i.h                      |   3 +
 fs/hugetlbfs/inode.c                  |  42 ++++------
 fs/minix/namei.c                      |   6 +-
 fs/namei.c                            |  88 +++++++++++++--------
 fs/overlayfs/copy_up.c                | 108 +++++++++++++------------
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
 27 files changed, 299 insertions(+), 232 deletions(-)

-- 
2.37.3

