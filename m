Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116963E59A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 14:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbhHJMIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 08:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233179AbhHJMIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628597292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=70ZHj0e/G2BjF0qu80h7rVUL9ZmoCs0npJRWccY1LHM=;
        b=QXnt/uzOtzOwOSj2DdK8bIGKda0ouH72WcTAdzM2DY83uW3uoNs4rE6QS1J9b+T2vsD+Rq
        RstVTDdgiyEZureF4HHLWf2SJJL0IJ+QseI3OXjvhDKOAJT0de4dpva9c5rK8hmso+bMmM
        HTXxuvpP4twt/H1TXt6HnnzjLV+lyIg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-1iLo8XxjMtWJD8yRbXnisg-1; Tue, 10 Aug 2021 08:08:11 -0400
X-MC-Unique: 1iLo8XxjMtWJD8yRbXnisg-1
Received: by mail-ej1-f71.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so5517962eje.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 05:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70ZHj0e/G2BjF0qu80h7rVUL9ZmoCs0npJRWccY1LHM=;
        b=KNbvZs1nvGxRFpOkxPCCijZuRcTO5iHqI+pM1piXi+MZc5n+wXuTyqL0iunfeOoGwL
         RHCLFKCL29xjo2tKHwIrx9Zq1HF97sI27xoZne367YgxXbnqVJVoPP3hxthjBQBfOPWr
         PaOfyfWDRTdDqRHoNmstvlJfu05BlXu9iBDDhXUidgdy5GCsfbVK6XqCyxvoUdxZkof1
         agSVCIfHd2PlL6ZOIwuH7n34EN2SINKUXYFzJmi2yqe+tz6raj3ce1DUv+au1dGlSDUF
         qPcDYMaQOzX8+wIt2hFJeh2vFe+H7iPU+JDfrYUgd0ADt3ypcTksDEqt1U9ucCMbBk1/
         R+Cw==
X-Gm-Message-State: AOAM532ANFQnUUi0gYfYfGb5wgq1FqL+cSJRC6AHxMfSQUTfFSPYVuGr
        FGKzkAE5FIgBu28sm3caT2XsW9oR7nsvRb3uJ1GuSN1xeJfqybzIeMFB1OrOHQ6zEp6fQEMmCxQ
        xZKHjcVxtyQzCUBTcqOuTktnZ6g==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr27273139eje.321.1628597290061;
        Tue, 10 Aug 2021 05:08:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzR0lHRTWqCIJUXhezLaRhmTRQnvFBVh9FIq/tTZJaz9LLJLVcV9H2kglC1W1U9s9048PKdJw==
X-Received: by 2002:a17:906:2a8e:: with SMTP id l14mr27273125eje.321.1628597289914;
        Tue, 10 Aug 2021 05:08:09 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id p5sm6804900ejl.73.2021.08.10.05.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 05:08:09 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 0/2] allow overlayfs to do RCU lookups
Date:   Tue, 10 Aug 2021 14:08:05 +0200
Message-Id: <20210810120807.456788-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This mini-series enables RCU lookups for overlayfs.

Al, can you take this into your tree, or at least ack the vfs changes so I
can push this to the overlayfs tree?

Thanks,
Miklos

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
 39 files changed, 104 insertions(+), 41 deletions(-)

-- 
2.31.1

