Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04C51A7264
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 06:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405238AbgDNETN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 00:19:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39405 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405149AbgDNETG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 00:19:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id g32so5455945pgb.6;
        Mon, 13 Apr 2020 21:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=poV2Gq3cnOyqeOUmPYdgy85BjQ09uingBc0EV8v87Ns=;
        b=UgxEuzbuhSV+yWxnQm04MVRWR/0uFbgrcOgpHZ3DfwGuWHn6NO6RO0507UO19yJScO
         WRZzwXcu9YmcX4Wzo1C3MzI1+MbBR17UsMWnmpSr2PUJa83U2lwIwHzhedgsi0xfpsfP
         fGaLorF/XXcAWyRRkZ3jurv25i29wJ+0YAslmgERc8VMcmRB4sZ0KVyt+TbB2UJn8N15
         UM4SHs+BmFsmDxiEhsyKXhoZa5tauS3mMO9OvECqLZFuC7TMfOUOeyYSCWzMAiI9EBwA
         XP/qX2GZ6QFI/gny0mtDiuhmmGJpHZy/Irzy1iftvvtSm7itLHwgLyhpYQsAW9saBMZq
         29gQ==
X-Gm-Message-State: AGi0PuY8U3lb8kijD8t5bkxh7QnHBgV8oLc+GNJF9ofa31RRHb5sefxd
        zPBtteGCmzWu6qflVvrAOYM=
X-Google-Smtp-Source: APiQypIPVTvGDIP97mlZYr8HYNDrY3xOgxZ6XX7zeOVslg6foBZORtgdB4RsrxGGv5idwWedLPG2vA==
X-Received: by 2002:a63:140c:: with SMTP id u12mr13690380pgl.243.1586837945624;
        Mon, 13 Apr 2020 21:19:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l30sm8257941pgu.29.2020.04.13.21.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 21:19:04 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id CDA6140277; Tue, 14 Apr 2020 04:19:03 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/5] blktrace: fix use after free
Date:   Tue, 14 Apr 2020 04:18:57 +0000
Message-Id: <20200414041902.16769-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After two iterations of RFCs I think this is ready now. I've taken
the feedback from the last series, both on code and commit log.
I've also extended the commit log on the last patch to also explain
how the original shift to async request_queue removal turned out
to actually be a userspace regression and added a respective fixes
tag for it.

You can find these patches on my 20200414-dev-blkqueue-defer-removal-patch-v1
branch based on linux-next tag next-20200414 on kernel.org [0].

Further review and rants are appreciated.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200414-dev-blkqueue-defer-removal

Luis Chamberlain (5):
  block: move main block debugfs initialization to its own file
  blktrace: fix debugfs use after free
  blktrace: refcount the request_queue during ioctl
  mm/swapfile: refcount block and queue before using
    blkcg_schedule_throttle()
  block: revert back to synchronous request_queue removal

 block/Makefile               |  1 +
 block/blk-core.c             | 28 ++++++++++++++++--------
 block/blk-debugfs.c          | 27 ++++++++++++++++++++++++
 block/blk-mq-debugfs.c       |  5 -----
 block/blk-sysfs.c            | 41 ++++++++++++++++++------------------
 block/blk.h                  | 17 +++++++++++++++
 include/linux/blkdev.h       |  7 +++---
 include/linux/blktrace_api.h |  1 -
 kernel/trace/blktrace.c      | 25 ++++++++++++----------
 mm/swapfile.c                | 14 ++++++++++--
 10 files changed, 114 insertions(+), 52 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

