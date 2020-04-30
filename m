Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6A1C09AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgD3Vwk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 17:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgD3Vwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:52:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F516C035495
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:37 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t12so5822087edw.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zgDZM2QEe3TNlL7K8Bymnn7KFg8gtWAYwvoscbSiu6Q=;
        b=OzIVTd/Umg4BVW2aaVD56kjxL6YFqh9+OD6bVaTZVRy+i4nWJDwNaMQa0xOWi1277g
         GyVKMF5l+tnx41ET1wxad6lBPs2dNE1uQlDhQ4rtQPvw0bAsMzKrpqqGKVEbHjnvYezZ
         j4wGcwya12ynLd7YCBTQX26T8Ye4g+/cpG7E/fnP1lF9grC4usJLWmMZq+InP+U3KX7n
         8w/OzB2gjAdJhu1U0VIejTzTFW2+ByPGNkUUZ3DjlPsxPMy6LSR7Ua08fx+TPgvHl6VZ
         mRtku5j5TUkRqrYFkRlw/U0Thbr2FeZJLFqWiPiKKH0bsAM99MdJ1/SbAOM4QRFpqp/i
         YGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zgDZM2QEe3TNlL7K8Bymnn7KFg8gtWAYwvoscbSiu6Q=;
        b=hWK+uhsvLmvZRlbz8RjY8Egbkhl494WJPTA9zcC7MKaisz4asDWEeh5UELB/6NFifB
         oZvrhn+OiS8jGF5d4/hY2NVv8wqyruA8unhdNjdeCdOwWEp8hURQQTD5i0fhz90w2LDO
         m95lqPhF22mgy1yPnB93myIjcXrWo45wYvrsw9bPSkxe3+GIfUOPqYCjxGKBorAKmLyc
         pvCvzG9L0Mp0whR6oiweMAh1S92u5GpJILcLBz1lqxq3tkbMVl7JBNlxy5QJD0K+buiV
         2JQTO3Qo5A1h22+hEAlR2eF2X8k8polj/+DwaEBG1sr1SzCYNzn2Gog4K3naOptx1XgO
         w5XQ==
X-Gm-Message-State: AGi0PuZZVnQ7Z3VekYBZ/2seICACpuApyJqGy9VnqbXkZsbgbjjjFbAK
        UCQHv8S0Tw11+RPT97wC4uBTWricxkM=
X-Google-Smtp-Source: APiQypJD8RUe9YBETXgY/U8ynUxBhxdy0riV5Q6OnOvIOkE3/Aqn5u1ovU/CZeP2lL35E59nHYm0TA==
X-Received: by 2002:a05:6402:319c:: with SMTP id di28mr1049635edb.185.1588283556033;
        Thu, 30 Apr 2020 14:52:36 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:b82f:dfc:5e2a:e7cc])
        by smtp.gmail.com with ESMTPSA id f13sm92022ejd.2.2020.04.30.14.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:52:34 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH V2 0/9] Introduce attach/clear_page_private to cleanup code
Date:   Thu, 30 Apr 2020 23:44:41 +0200
Message-Id: <20200430214450.10662-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Based on the previous thread [1], this patchset introduces attach_page_private
and clear_page_private to replace attach_page_buffers and __clear_page_buffers.
Thanks a lot for the constructive suggestions and comments from Christoph,
Matthew and Dave.

And sorry for cross post to different lists since it modifies different subsystems.

RFC -> RFC V2:

1. rename the new functions and add comments for them.
2. change the return type of attach_page_private.
3. call attach_page_private(newpage, clear_page_private(page)) to cleanup code further.
4. avoid potential use-after-free in orangefs.

[1]. https://lore.kernel.org/linux-fsdevel/20200420221424.GH5820@bombadil.infradead.org/

Thanks,
Guoqing

Guoqing Jiang (9):
  include/linux/pagemap.h: introduce attach/clear_page_private
  md: remove __clear_page_buffers and use attach/clear_page_private
  btrfs: use attach/clear_page_private
  fs/buffer.c: use attach/clear_page_private
  f2fs: use attach/clear_page_private
  iomap: use attach/clear_page_private
  ntfs: replace attach_page_buffers with attach_page_private
  orangefs: use attach/clear_page_private
  buffer_head.h: remove attach_page_buffers

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
 include/linux/pagemap.h     | 35 +++++++++++++++++++++++++++++++++++
 12 files changed, 67 insertions(+), 118 deletions(-)

-- 
2.17.1

