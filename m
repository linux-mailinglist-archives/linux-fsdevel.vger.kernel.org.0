Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE03E8A9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhHKG4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 02:56:47 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47324 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234878AbhHKG4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 02:56:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UifQe5k_1628664981;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UifQe5k_1628664981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Aug 2021 14:56:21 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [virtiofsd PATCH v2 0/4] virtiofsd: support per-file DAX
Date:   Wed, 11 Aug 2021 14:56:17 +0800
Message-Id: <20210811065621.12737-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I mentioned in virtiofsd PATCH v1 that virtiofsd exits once ioctl() is
called. After depper investigation into this issue, I find that it is
because ioctl() is blocked out the whitelist of seccomp of virtiofsd.

To support ioctl, ioctl syscall shall be added into the whitelist (see patch
1).

And this is the complete workable version for virtiofsd:
- virtiofsd now supports FUSE_IOCTL now, though currently only
  FS_IOC_G[S]ETFLAGS/FS_IOC_FSG[S]ETXATTR are supported.
- During FUSE_INIT, virtiofsd advertise support for per-file DAX only
  when the backend fs is ext4/xfs.
- FS_IOC_SETFLAGS/FS_IOC_FSSETXATTR FUSE_IOCTL will be directed to host,
  so that FS_DAX_FL could be flushed to backed fs persistently.
- During FUSE_LOOKUP, virtiofsd will decide DAX shall be enabled for
  current file according to if this file is marked with FS_DAX_FL in the
  backend fs.


PS.
In the current implementation, the kernel always advertise
FUSE_PERFILE_DAX no matter whether it's mounted with '-o dax=inode' or
not. It can be fixed in the next version, and I need more feedbacks so far.

Any comment on this whole series is welcome.

Jeffle Xu (4):
  virtiofsd: add .ioctl() support
  virtiofsd: expand fuse protocol to support per-file DAX
  virtiofsd: support per-file DAX negotiation in FUSE_INIT
  virtiofsd: support per-file DAX in FUSE_LOOKUP

 include/standard-headers/linux/fuse.h |   2 +
 tools/virtiofsd/fuse_common.h         |   5 ++
 tools/virtiofsd/fuse_lowlevel.c       |   6 ++
 tools/virtiofsd/passthrough_ll.c      | 115 ++++++++++++++++++++++++++
 tools/virtiofsd/passthrough_seccomp.c |   1 +
 5 files changed, 129 insertions(+)

-- 
2.27.0

