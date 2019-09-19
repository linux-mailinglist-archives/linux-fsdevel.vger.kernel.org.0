Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4CAB737E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfISGx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 02:53:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35639 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731504AbfISGx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:53:59 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so1647484pfw.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUUhMDT2yBGZdNqjQ9RKk1UhdRgrpXRQODGGuHoUiyU=;
        b=y8ajRS9oUVZ1bADIkM7x4Gf/BkdDJbsd0JE9Z3OdUZRSMdqPOM1FMo39DHHxAkNlf+
         tX9WuSpS5U+pACa0z+N818dx4UZuw0DdrRNY6N1N8SIAMH6v+6cEyclfjcnZ2AOY6KSy
         wMydZ5L98lZ5KAIPf7NPSJCiqEE909fQqzvSeYz3Vw/yjnnZXpXNJrfcFpyWiZ/tDUPr
         jKjwVz+orcnYl0w0VUpgiUWJXkkM2mD67xuxPmiiIVE8Mm1yRQ2fHYw/He3fvcZOVQ7m
         aDHDZHqsK93do+wi8b/t1RgUIQr6pLL7Zhb+zriMRFz6h6gajUU4etR5foS0CcyJhdUv
         N79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dUUhMDT2yBGZdNqjQ9RKk1UhdRgrpXRQODGGuHoUiyU=;
        b=mVAwKkev5yJiaSt6kyXaIRXwMenFPQozRyn1Gieqoun6pgtk9jJD7040Bv8TLk0pGo
         BQtkzFVUA/N6/ZSjs0M7kK0ncW1pr1pOf+uwA7WKj+wf7QgRJXnFmjuKNQxIw6SW9yFU
         fddUN8wv8RmRA9quSGcbhvCuRMYXzlvW2xlzrPVHFE7ilJrdOLPIj8muhjtKHHkdMh/t
         f8fgemFqt9draEKAOgtLpoW8igiZzyb7WVmh8e53wWWiijXwRZMCwZf3VRodEx/OXv2f
         G4VPg0PIYTVftU2bx11E11VmcQZ1L0HawgL11n1H/x+nQhEsfFZ1+kQzRBt8VB3l95L9
         YbRw==
X-Gm-Message-State: APjAAAWE/73FxaHZGEpB8rFIBsZhB667FWkoReXc7k97v5EgTcxCNzGy
        uPVGE1M1xv0MnzJupN2dZdfpzrm/BTM=
X-Google-Smtp-Source: APXvYqyPlQLlGr03xTZPu5fxpHXDm0f0L1rUjv9PyUrVtZVxo0n1K+iVfmM/ITE1KrEVNLcIHJIwDg==
X-Received: by 2002:a63:c203:: with SMTP id b3mr7764841pgd.450.1568876036487;
        Wed, 18 Sep 2019 23:53:56 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::332b])
        by smtp.gmail.com with ESMTPSA id m24sm6623615pgj.71.2019.09.18.23.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 23:53:55 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH 0/3] fs: interface for directly writing encoded (e.g., compressed) data
Date:   Wed, 18 Sep 2019 23:53:43 -0700
Message-Id: <cover.1568875700.git.osandov@fb.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hello,

This patch series adds an API for writing compressed data directly to
the filesystem. It is based on my previous series which added a
Btrfs-specific ioctl [1], but this is now an extension to pwritev2() as
suggested by Dave Chinner [2]. I've included a man page patch describing
the API in detail. A test case and example program are available [3].

The use case that I have in mind is Btrfs send/receive: currently, when
sending data from one compressed filesystem to another, the sending side
decompresses the data and the receiving side recompresses it before
writing it out. This is wasteful and can be avoided if we can just send
and write compressed extents. The send part will be implemented in a
separate series, as this API can stand alone.

Patch 1 is a prep patch. Patch 2 adds the interface in the VFS. Patch 3
implements it in Btrfs.

This series is based on Linus' tree as of commit
b41dae061bbd722b9d7fa828f35d22035b218e18.

Please share any comments on the API or implementation. Thanks!

1: https://lore.kernel.org/linux-fsdevel/cover.1567623877.git.osandov@fb.com/
2: https://lore.kernel.org/linux-fsdevel/20190906212710.GI7452@vader/
3: https://github.com/osandov/xfstests/tree/btrfs-compressed-write

Omar Sandoval (3):
  fs: pass READ/WRITE to kiocb_set_rw_flags()
  fs: add RWF_ENCODED for writing compressed data
  btrfs: implement encoded (compressed) writes

 fs/aio.c                |   9 +-
 fs/btrfs/compression.c  |   6 +-
 fs/btrfs/compression.h  |   5 +-
 fs/btrfs/ctree.h        |   4 +
 fs/btrfs/file.c         |  40 +++++++--
 fs/btrfs/inode.c        | 190 +++++++++++++++++++++++++++++++++++++++-
 fs/io_uring.c           |   9 +-
 fs/read_write.c         |   2 +-
 include/linux/fs.h      |  18 +++-
 include/uapi/linux/fs.h |  24 ++++-
 mm/filemap.c            |  75 +++++++++++++---
 11 files changed, 344 insertions(+), 38 deletions(-)

-- 
2.23.0

