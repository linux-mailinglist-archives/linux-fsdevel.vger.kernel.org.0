Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147D51B943F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Apr 2020 23:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZVts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgDZVts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 17:49:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224EEC061A10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so12494585eju.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2020 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B/ch82HyLL2sQr6H4MnBtI01Q2APZPEwf2QyxgsQ6bE=;
        b=C6afFiFVw7S0hp7bZfWbrthZh1ZM4P0cPOjHJRBn6u9FP10tTEn/l9PF9XDRdD8hMo
         FUIrdIh1+RRAC9QGXGHot7NgMt2xGErdp+XECWu7Xzb0EX5KTbKhvF+L50f4kDwIb9So
         4wNDrn75HXesak3RnaipqHpOlJiRhdKeiuEqu3ZpU9WCEMyT6/rejd6XdAW+L4S9lcXw
         YxiK82m+la85q5kQVx+hB6+Da8ZUJgkGasRb1JGDV0i+peuqRo9nQMmkU6z3k1pEH1Yp
         Hw1UA6NpC8Zl8bIXKZaA8x4GfNQ5f/48jy6FByERebcqavePWSRXbVzCkG8ENpvyi7CA
         9GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B/ch82HyLL2sQr6H4MnBtI01Q2APZPEwf2QyxgsQ6bE=;
        b=HAeVEOZz6mc/jDm0855sXjjBImdPFkDv9akw2d3gJWoA6KIk6iq/WRToxKdnOiieWO
         rUPq1VWySbG6XBj4QLHZ6E0MHEu0w6mRkZl87A3gUZsk4s0fubrbKA0zpAEFwcS0MBCd
         fXEpStStGVjKKN7Ohhxs7ZW+D6TPn9/ynwQd/v0lNb4IOX7cwCDKJEH6K1LI/a7Fn45b
         u9+Qs/HVlK6EdsJzuvUxNIbM+TdK/Rdc+7yDvUP5RGjLpLkRwZi7OOraq1ptCieia11U
         NIXlvGLAYGS6osHO12rEYI8LFzfRP7qnWLoA8q6/eXiJLgB7qierd+6o7C65Vu4FbbBR
         LCYA==
X-Gm-Message-State: AGi0Pua4kkioD+nnYfajhcWU06o/nj2vbUDeibnBrYQEslABgPvyEBjF
        0ludFESe6FkYru1YiZ8Dy3WJGQCQMT2i1w==
X-Google-Smtp-Source: APiQypJvZ+T3DNh77lS28NFcUDhKHPlb8mG+//KC43nxkgc5XB59Rte8JmfAZ14qijs1rpUFCNHBVw==
X-Received: by 2002:a17:906:74c:: with SMTP id z12mr17510376ejb.87.1587937786516;
        Sun, 26 Apr 2020 14:49:46 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:fab1:56ff:feab:56b1])
        by smtp.gmail.com with ESMTPSA id ce18sm2270108ejb.61.2020.04.26.14.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 14:49:45 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, david@fromorbit.com, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [RFC PATCH 0/9] Introduce set/clear_fs_page_private to cleanup code
Date:   Sun, 26 Apr 2020 23:49:16 +0200
Message-Id: <20200426214925.10970-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Based on the previous thread [1], this patchset introduces set_fs_page_private
and clear_fs_page_private to replace attach_page_buffers and __clear_page_buffers.
Thanks a lot for the constructive suggestion from Matthew and Dave.

And sorry for cross post to different lists since it modifies different subsystems.

[1]. https://lore.kernel.org/linux-fsdevel/20200420221424.GH5820@bombadil.infradead.org/

Thanks,
Guoqing

Guoqing Jiang (9):
  include/linux/pagemap.h: introduce set/clear_fs_page_private
  md: remove __clear_page_buffers and use set/clear_fs_page_private
  btrfs: use set/clear_fs_page_private
  fs/buffer.c: use set/clear_fs_page_private
  f2fs: use set/clear_fs_page_private
  iomap: use set/clear_fs_page_private
  ntfs: replace attach_page_buffers with set_fs_page_private
  orangefs: use set/clear_fs_page_private
  buffer_head.h: remove attach_page_buffers

 drivers/md/md-bitmap.c      | 12 ++----------
 fs/btrfs/disk-io.c          |  4 +---
 fs/btrfs/extent_io.c        | 21 ++++++---------------
 fs/btrfs/inode.c            | 17 ++++-------------
 fs/buffer.c                 | 16 ++++------------
 fs/f2fs/f2fs.h              | 11 ++---------
 fs/iomap/buffered-io.c      | 14 +++-----------
 fs/ntfs/aops.c              |  2 +-
 fs/ntfs/mft.c               |  2 +-
 fs/orangefs/inode.c         | 24 ++++++------------------
 include/linux/buffer_head.h |  8 --------
 include/linux/pagemap.h     | 22 ++++++++++++++++++++++
 12 files changed, 52 insertions(+), 101 deletions(-)

-- 
2.17.1

