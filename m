Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25A01C9D99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEGVoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGVoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:18 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD6C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t12so6761268edw.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=P/Uxm8WJTzq78ynhVicYHDZPtqRu1XH16x/cAF/+cO8=;
        b=RTA0Qpozn0gf5IlvdzhJe9faA2tLyc+M18gYbapWmEybjegaUApJHd/BozIGf0VNuC
         toHUgjug/NLRp2smPMRTlVhR2Rwtio5qBJTXsCb5EDWeMTYm6ozlWAkzzCzp7jVl6DOU
         6ncrW3w9rHSrbrjhxz/hvbmiE5+boJzTeXGHct1PiNJiKP3kYfIf4axpm6MMII9mLhYF
         eliOYBRbyDXIGWFxSApJHuxto1X+uEbFNOTBDS7KR0HWstCFFfdd2m2LBTrVM7x6aQ9c
         BkLbCAcf8z7cnnl2mQ7doiREcsx2z4wwpje++yIBHqFx9n2omFLL0ncNMH/do0DH8fks
         lvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/Uxm8WJTzq78ynhVicYHDZPtqRu1XH16x/cAF/+cO8=;
        b=GKpnNkdEfeskCBhPleALwv8jxN4KtPTjDVLAe/6OpNTpTknc+g+EpYCHS3otej3jvn
         l2TlC1qjrro5AtatjBU2uM08JZLA78MJLfpnLNJVQ5eVdDfbIfYG6mMUK3g33IU95KcK
         6ofNaADVZn2qKtoCPlQxGC858sPlNw0W43PrI4Bm6Qqe5t5qaogbeL5wX9qaRV1IHOax
         02S5WNWmlqWc5AuXIzVL5xvKSWZFnBugnb/OpxokrvplccgzDxps7yTLsBiwC97bLzRp
         7Z7BCdtsLJgCheKEfXFRRyCJR+GESYzTeDud2K+Ds+YsWU0RQdQfBp1nOSYzeQePjk6v
         KdRg==
X-Gm-Message-State: AGi0Pua+xYa1i5nGSi8SXBY1PUq3QpOV/CdPtaspLXAlJZST6LrJh0C6
        dCJiw68PYHTCU1cxXYgpzlL11bjwmoM=
X-Google-Smtp-Source: APiQypLCk1OU9FRlIMNCpJvBaEgq8st+iAcnPir0Yd+Gt2UqsyC+O4XA6UhV8pJWiHK1w5UEtqE9yA==
X-Received: by 2002:a05:6402:3129:: with SMTP id dd9mr14179355edb.121.1588887856645;
        Thu, 07 May 2020 14:44:16 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:15 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH V3 0/9] Introduce attach/detach_page_private to cleanup code
Date:   Thu,  7 May 2020 23:43:50 +0200
Message-Id: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Based on the previous thread [1], this patchset introduces attach_page_private
and detach_page_private to replace attach_page_buffers and __clear_page_buffers.
Thanks a lot for the constructive suggestions and comments from Christoph,
Matthew and Dave.

And sorry for cross post to different lists since it modifies different subsystems.

RFC V2 -> RFC V3:
1. rename clear_page_private to detach_page_private.
2. Update the comments for attach/detach_page_private from Mattew.
3. add one patch to call new function in mm/migrate.c as suggested by Mattew, but
   use the conservative way to keep the orginal semantics [2].


RFC -> RFC V2:
1. rename the new functions and add comments for them.
2. change the return type of attach_page_private.
3. call attach_page_private(newpage, clear_page_private(page)) to cleanup code further.
4. avoid potential use-after-free in orangefs.

[1]. https://lore.kernel.org/linux-fsdevel/20200420221424.GH5820@bombadil.infradead.org/
[2]. https://lore.kernel.org/lkml/e4d5ddc0-877f-6499-f697-2b7c0ddbf386@cloud.ionos.com/

Thanks,
Guoqing

Guoqing Jiang (10):
  include/linux/pagemap.h: introduce attach/detach_page_private
  md: remove __clear_page_buffers and use attach/detach_page_private
  btrfs: use attach/detach_page_private
  fs/buffer.c: use attach/detach_page_private
  f2fs: use attach/detach_page_private
  iomap: use attach/detach_page_private
  ntfs: replace attach_page_buffers with attach_page_private
  orangefs: use attach/detach_page_private
  buffer_head.h: remove attach_page_buffers
  mm/migrate.c: call detach_page_private to cleanup code

 drivers/md/md-bitmap.c      | 12 ++----------
 fs/btrfs/disk-io.c          |  4 +---
 fs/btrfs/extent_io.c        | 21 ++++++---------------
 fs/btrfs/inode.c            | 23 +++++------------------
 fs/buffer.c                 | 16 ++++------------
 fs/f2fs/f2fs.h              | 11 ++---------
 fs/iomap/buffered-io.c      | 19 ++++---------------
 fs/ntfs/aops.c              |  2 +-
 fs/ntfs/mft.c               |  2 +-
 fs/orangefs/inode.c         | 32 ++++++--------------------------
 include/linux/buffer_head.h |  8 --------
 include/linux/pagemap.h     | 37 +++++++++++++++++++++++++++++++++++++
 mm/migrate.c                |  5 +----
 13 files changed, 70 insertions(+), 122 deletions(-)

-- 
2.17.1

