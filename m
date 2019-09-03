Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29CA6782
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfICLgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 07:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32915 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICLgp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:36:45 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F01964120
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2019 11:36:45 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id x12so1273311wrs.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 04:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGcPW4T34ae7tNxlUwxnVZ0/61lVgJvDaZezCMEfty0=;
        b=j6qBQ/hsaDrHjQsHLlYGtvG4LLbLmZCn3X3GPmdFkOHUiCWp3ebMdgThpz959T8jZE
         3sAaE787IqWUd4lLzpOGFGDKw+WXnKqINwztgELAeoP73EzdsnjV+DQP3V450RAIUgOl
         BUtPesi8tLkuN/RvYbEVjYtalOnH3z4zdmYUFFYeuj2UsYdRYwlJ6OwpLsxCSMjGu/Sw
         ig/Ncu5z+76h5pOxA9FCQQHpxTyl/eb9lZOM+1PS8332CO6Cuac1kfJWdaURKCsKVE2A
         yP1HTBb2b+3ovIQu7ZTiIWoQD/0rHAUJnilTJp14ulD1bylcTN9+bicrqg01IXk3sczb
         R+1Q==
X-Gm-Message-State: APjAAAUu6CsdL9Do5txsXjSTofWdz4MAqodAJaUeP2PB4x8MDPP//eBH
        X4Mpr9qjnrAczC5G53PFa7VbHNKqwg7/kpYo2szztu+cE1dsh7LQjhay+au7h+eYyV9zqPaotsm
        BgJMdVSryIw8ttHTBTUAG0Pt7Hg==
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr3687300wmg.8.1567510603833;
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyzWjg0szrb+YUGwCwQvjNCX1ob1wbHEAcXkUzc8v8wkG64USQFu1THbZDWaltyHnhnlFKCgg==
X-Received: by 2002:a1c:d10b:: with SMTP id i11mr3687281wmg.8.1567510603655;
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v186sm40446906wmb.5.2019.09.03.04.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:36:43 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH v4 00/16] virtio-fs: shared file system for virtual machines
Date:   Tue,  3 Sep 2019 13:36:24 +0200
Message-Id: <20190903113640.7984-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Posting latest version to virtio mailing list as well.  I guess patches 15
and 16 are most interesting to the virt community.

The reasons for creating a new fs are spelled out in the previous posting:

https://lore.kernel.org/linux-fsdevel/20190821173742.24574-1-vgoyal@redhat.com/

Git tree for this version is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#virtiofs-v4

Thanks,
Miklos

---
David Howells (3):
  vfs: Create fs_context-aware mount_bdev() replacement
  fuse: convert to use the new mount API
  vfs: subtype handling moved to fuse

Miklos Szeredi (2):
  fuse: delete dentry if timeout is zero
  fuse: dissociate DESTROY from fuseblk

Stefan Hajnoczi (7):
  fuse: export fuse_end_request()
  fuse: export fuse_len_args()
  fuse: export fuse_get_unique()
  fuse: extract fuse_fill_super_common()
  fuse: add fuse_iqueue_ops callbacks
  virtio-fs: add virtiofs filesystem
  virtio-fs: add Documentation/filesystems/virtiofs.rst

Vivek Goyal (4):
  fuse: export fuse_send_init_request()
  fuse: export fuse_dequeue_forget() function
  fuse: separate fuse device allocation and installation in fuse_conn
  fuse: allow skipping control interface and forced unmount

 Documentation/filesystems/index.rst    |   10 +
 Documentation/filesystems/virtiofs.rst |   60 ++
 MAINTAINERS                            |   11 +
 fs/fs_context.c                        |   16 +-
 fs/fuse/Kconfig                        |   11 +
 fs/fuse/Makefile                       |    1 +
 fs/fuse/cuse.c                         |    4 +-
 fs/fuse/dev.c                          |   93 +-
 fs/fuse/dir.c                          |   28 +-
 fs/fuse/fuse_i.h                       |  118 ++-
 fs/fuse/inode.c                        |  464 +++++-----
 fs/fuse/virtio_fs.c                    | 1072 ++++++++++++++++++++++++
 fs/namespace.c                         |    2 -
 fs/proc_namespace.c                    |    2 +-
 fs/super.c                             |  116 ++-
 include/linux/fs_context.h             |   10 +-
 include/uapi/linux/virtio_fs.h         |   19 +
 include/uapi/linux/virtio_ids.h        |    1 +
 18 files changed, 1774 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/filesystems/virtiofs.rst
 create mode 100644 fs/fuse/virtio_fs.c
 create mode 100644 include/uapi/linux/virtio_fs.h

-- 
2.21.0

