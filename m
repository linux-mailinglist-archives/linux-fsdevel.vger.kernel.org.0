Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E633DFC07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 09:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhHDHYZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 03:24:25 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43382 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235841AbhHDHYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 03:24:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UhwmYqy_1628061851;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhwmYqy_1628061851)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Aug 2021 15:24:11 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH virtiofsd 0/3] virtiofsd: support per-file DAX
Date:   Wed,  4 Aug 2021 15:24:08 +0800
Message-Id: <20210804072411.1180-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
References: <20210804070653.118123-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As discussed with Vivek Goyal, I tried to make virtiofsd support
per-file DAX by checking if the file is marked with FS_DAX_FL attr. Thus
I need to implement .ioctl() method for passthrough_ll.c (because
FS_DAX_FL attr is get/set by FS_IOC_GETFLAGS/FS_IOC_SETFLAGS ioctl),
something like

```
static struct fuse_lowlevel_ops lo_oper = {
+    .ioctl = lo_ioctl,

+static void lo_ioctl(...)
+{
+	ret = ioctl(fd, FS_IOC_SETFLAGS, ...);
}
```

But unfortunately once virtiofsd calls ioctl() syscall, it directly
exits, and qemu also hangs with 'qemu-system-x86_64: Unexpected
end-of-file before all data were read'. I'm not sure if it's because
ioctl() is not permitted at all for virtiofsd or qemu. Many thanks if
someone familiar with virtualization could help.

The code repository of virtiofsd used is:
gitlab.com/virtio-fs/qemu.git virtio-fs-dev

Thus this patch set is still used for test only, marking files larger
than 1MB shall enable per-file DAX.

Jeffle Xu (3):
  virtiofsd: expand fuse protocol to support per-file DAX
  virtiofsd: support per-file DAX negotiation in FUSE_INIT
  virtiofsd: support per-file DAX in FUSE_LOOKUP

 include/standard-headers/linux/fuse.h | 2 ++
 tools/virtiofsd/fuse_common.h         | 5 +++++
 tools/virtiofsd/fuse_lowlevel.c       | 6 ++++++
 tools/virtiofsd/passthrough_ll.c      | 6 ++++++
 4 files changed, 19 insertions(+)

-- 
2.27.0

