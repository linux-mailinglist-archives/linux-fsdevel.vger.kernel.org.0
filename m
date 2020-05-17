Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A1B1D6D93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgEQVrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgEQVrZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0029C05BD09
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f134so7394570wmf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/66Q+jWEKaVzaANJQrJ1aosdAcx3vTMrVmbrCAkWcIc=;
        b=Nh6nIwgMiHyOKSXIXrkxyg6h4r1BqAxzS0PC879X4g/NMz8yKEN9eFrgTPhobK9Loq
         nXrMwJkULWxg1iAgX82GF93KXlbTnVoD8ZW2Y98BizMccCYQVJV74xIAuYzdZyDKPn4j
         JyYKbcRA2raiYPw8yKhOG0kl1SgH7bOS40sx63sRVeR9Tu3Flyb5UPlAhULtks5znzTZ
         x2nxtuSYCcgdC+BekliM+Od5t3tDIcirXncgRwc4GNz+BHxJhpzPe5GP7riVXyzNcxyE
         kipQHsJiWZjyAxbN/21K9VieDYSsRbz8XUu4Tq/OrVy7c3p7sN43pV10w5JCvgpjwb0Z
         Tv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/66Q+jWEKaVzaANJQrJ1aosdAcx3vTMrVmbrCAkWcIc=;
        b=PKnyRpYKTbuilsak4TITRuZsoxivj29V4Gwo1dbCI7ulccBwilkNLNTxT3eJijGPH5
         GVpS8dqamd80xIzS/Omm2b/HjBi5iwBeNu4Pd0gww1IWnSSIkPqNgN751XyA6IPKnLOP
         ideFmLkVTgeHszmSxkDPTKYabwoioLBPxxCjNL4/8vkeukhX0YjxCxy138x/cYOzluYR
         d9dt65rtP0me0io6RTgp+KGHpyHGBlhMY7voEoHFHBLwKYWUDDS+hHOKNIPhfgWX654a
         kQEDK5MKI0LtwJpoXRwWxkTgNpIpMxcZFLZ5627B1LLdClSBzRgzRq6hvXlKBgNAs1N0
         h7VQ==
X-Gm-Message-State: AOAM530ouKHybRbvPGIgOAmTwblNXwprOFTWPOgq6HzPUfMTTfWNxjR+
        Nqex5A1VyR/WBRgoc9I8TkQVGYvIwn4=
X-Google-Smtp-Source: ABdhPJykv0hPTOO8SWPrgIv19eiT5W7uOOLBSoT/g/C4P4s+o3VbWEN31O/jaeh0pIghqPK+8K76Fg==
X-Received: by 2002:a05:600c:2219:: with SMTP id z25mr15529781wml.128.1589752042279;
        Sun, 17 May 2020 14:47:22 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 00/10] Introduce attach/detach_page_private to cleanup code
Date:   Sun, 17 May 2020 23:47:08 +0200
Message-Id: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hell Andrew and Al,

Since no more feedback from RFC V3, I suppose the series could be ready
for merge. And Song has already acked the md patch, then all the rest
patches are for fs and mm. 

So, if no further comments for the patchset, could you consider to queue
them from either of your tree to avoid potential build issue? Thank you!

RFC V3: https://lore.kernel.org/lkml/20200507214400.15785-1-guoqing.jiang@cloud.ionos.com/
RFC V3: https://lore.kernel.org/lkml/20200430214450.10662-1-guoqing.jiang@cloud.ionos.com/
RFC: https://lore.kernel.org/lkml/20200426214925.10970-1-guoqing.jiang@cloud.ionos.com/

Thanks,
Guoqing

No change since RFC V3.

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

