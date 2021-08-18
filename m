Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED73F04DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbhHRNel (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 09:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233722AbhHRNek (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629293645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9atu5PWpeWQekmjZpl8cMY0yO4zwVLTKAR4uiWOjOtw=;
        b=UBZIchvoEQBBKwZZ5mBcIee5nTCXID8N8G12NCj5QQR5V4Ge6nuk/Bcugb2cz5ZUszaoHO
        yvWK95eThrVcjDO8xi/zTqJve1mBzd6Rilxn3R4fpn1ucQQP0w6knFpNQtRGgVNHdQJHI7
        SV3o4cFN/WUkFMD5bq/Zr1m+wKeav9E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322--XyFNIkbMdC4F8cenQeteg-1; Wed, 18 Aug 2021 09:34:04 -0400
X-MC-Unique: -XyFNIkbMdC4F8cenQeteg-1
Received: by mail-ed1-f71.google.com with SMTP id m16-20020a056402511000b003bead176527so1041166edd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 06:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9atu5PWpeWQekmjZpl8cMY0yO4zwVLTKAR4uiWOjOtw=;
        b=WDghCFs65SlhJD2W1QdpgiUdZWBC0CBUsScmtLKrfVHDUFDm59s7Oru8qFrdeubgBu
         aiNPqQm4aeQZZZDZxqkaz6t8lJKzGy7UevZZdsjqws5zhC35s9cZmrR/WMJd5b3DcDgd
         EiF0xxhDD16hI1IBjDCQMsWVE4L3Sz5WZBPbNUpux0L8jg5zuzBddUzwn9HyMf5K52SM
         Uaw3C4RJ9nFKikLhvG2oie6zWYb8oGpL3R55L6/uBTlrfBaqBjn2fk/tFtKLsEemRJ5K
         hN5e+aGHumV0jZ9T50pOdhT13lQT99CMwIo576c3ytjHCskj+EKVoylLbsAPmCAlE6/7
         T5tw==
X-Gm-Message-State: AOAM532jxDvLwyFCOYIKkipD8E3ECF36G2RImXDGJvPu7HGkiHCNv/aS
        DYFYkqkbZjFb0P/TmebAcSDdAsseDnpbToxFUAu11GZxFM9c/6KHUec9eBucZggZn+LykhDY0jY
        mmy39G8YdiVhf9viGmK/8YKNsHw==
X-Received: by 2002:aa7:d319:: with SMTP id p25mr10394129edq.197.1629293643194;
        Wed, 18 Aug 2021 06:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRQYRpxw2Qhgc/ZAxOVdRSo4vUAvMeMIWE5ubx7bGW0c4xOeoVYQTT6WJ6FOemMkD1YFUpUQ==
X-Received: by 2002:aa7:d319:: with SMTP id p25mr10394085edq.197.1629293642713;
        Wed, 18 Aug 2021 06:34:02 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id kg18sm2090922ejc.9.2021.08.18.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 06:34:02 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 0/2] allow overlayfs to do RCU lookups
Date:   Wed, 18 Aug 2021 15:33:58 +0200
Message-Id: <20210818133400.830078-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'd really like to fix this in some form, but not getting any response
[1][2][3].

Al, Linus, can you please comment?

I'm happy to take this through the overlayfs tree, just need an ACK for the
VFS API change.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/20210323160629.228597-1-mszeredi@redhat.com/
[2] https://lore.kernel.org/linux-fsdevel/CAJfpegv4ttfCZY0DPm+SSc85eL5m3jqhdOS_avu1+WMZhdg7iA@mail.gmail.com/
[3] https://lore.kernel.org/linux-fsdevel/20210810120807.456788-1-mszeredi@redhat.com/

v2: just a minor fix for the CONFIG_FS_POSIX_ACL=n case.
---
Miklos Szeredi (2):
  vfs: add flags argument to ->get_acl() callback
  ovl: enable RCU'd ->get_acl()

 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     |  2 +-
 fs/9p/acl.c                           |  5 ++++-
 fs/9p/acl.h                           |  2 +-
 fs/bad_inode.c                        |  2 +-
 fs/btrfs/acl.c                        |  5 ++++-
 fs/btrfs/ctree.h                      |  2 +-
 fs/ceph/acl.c                         |  5 ++++-
 fs/ceph/super.h                       |  2 +-
 fs/erofs/xattr.c                      |  5 ++++-
 fs/erofs/xattr.h                      |  2 +-
 fs/ext2/acl.c                         |  5 ++++-
 fs/ext2/acl.h                         |  2 +-
 fs/ext4/acl.c                         |  5 ++++-
 fs/ext4/acl.h                         |  2 +-
 fs/f2fs/acl.c                         |  5 ++++-
 fs/f2fs/acl.h                         |  2 +-
 fs/fuse/acl.c                         |  5 ++++-
 fs/fuse/fuse_i.h                      |  2 +-
 fs/gfs2/acl.c                         |  5 ++++-
 fs/gfs2/acl.h                         |  2 +-
 fs/jffs2/acl.c                        |  5 ++++-
 fs/jffs2/acl.h                        |  2 +-
 fs/jfs/acl.c                          |  5 ++++-
 fs/jfs/jfs_acl.h                      |  2 +-
 fs/nfs/nfs3_fs.h                      |  2 +-
 fs/nfs/nfs3acl.c                      |  5 ++++-
 fs/ocfs2/acl.c                        |  5 ++++-
 fs/ocfs2/acl.h                        |  2 +-
 fs/orangefs/acl.c                     |  5 ++++-
 fs/orangefs/orangefs-kernel.h         |  2 +-
 fs/overlayfs/inode.c                  |  6 +++++-
 fs/overlayfs/overlayfs.h              |  2 +-
 fs/posix_acl.c                        | 10 ++++++++--
 fs/reiserfs/acl.h                     |  2 +-
 fs/reiserfs/xattr_acl.c               |  5 ++++-
 fs/xfs/xfs_acl.c                      |  5 ++++-
 fs/xfs/xfs_acl.h                      |  4 ++--
 include/linux/fs.h                    |  7 ++++++-
 include/linux/posix_acl.h             |  3 ++-
 40 files changed, 106 insertions(+), 42 deletions(-)

-- 
2.31.1

