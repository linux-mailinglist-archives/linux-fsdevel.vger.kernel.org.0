Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C041D5E2A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 May 2020 05:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgEPDUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 23:20:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39209 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgEPDUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 23:20:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id s20so1696420plp.6;
        Fri, 15 May 2020 20:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YV3/UWo+QrQjEja7xqDM3mkCEeETF9cGsA9Cr+G6NWM=;
        b=Z37A7EP+6v4s6kT6k1m145k6R++940Z/SrKirRm+f1x32VMckBJlBXIa09ppvEMRDM
         hCVNuk2m9N28ZZuNLAnSQKG6NQq/FO8OYMC7USZge96hcgXmAq5TyN5aD6aGRg4ZVSfo
         8t6/Ltr6JthLAJ59tEzdYeLb9PwhaUEs3zpfTzP2DQb4teQB4GX8r6e5YEwxzZtG30IV
         ags6nD0PQOSTCEIJqAL0Iq2HUbbIXKwnS+oZVoh1RB+KFGMGRvnHZxrb1fnzpRuqwWO9
         n9x/RkAPyj2pdRPLoi3VFGGUkZ8BFTioflAjR+gwLZ0nsOhdeBOJtWqV6c5lD7KmkJ1F
         E9qg==
X-Gm-Message-State: AOAM533w2hbNN9B/RhuLFdVBWyjpsnbbIqQ+JkZNAuGXaHwsgqMHoY0I
        B8WTQEB/ETIZA3anlqDQm24=
X-Google-Smtp-Source: ABdhPJyX70yrh/cMjp+9Dz4fChywx1PSJecwmDqWYDJSH2DMWbAhrLB6vr4UVE2r+Lo9hAtfEQDoiw==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr6510510pla.40.1589599200697;
        Fri, 15 May 2020 20:20:00 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m19sm2543770pjv.30.2020.05.15.20.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 20:19:59 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 99D78404B0; Sat, 16 May 2020 03:19:58 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 0/7] block: fix blktrace debugfs use after free
Date:   Sat, 16 May 2020 03:19:49 +0000
Message-Id: <20200516031956.2605-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On this v5 I've split up the first patch into 3, one for comments,
another for context / might_sleep() updates, and the last the big
revert back to synchronous request_queue removal. I didn't update
the context for the put / decrements for gendisk & request_queue
as they would be updated in the next patch.

Since the first 3 patches are a reflection of the original one, I've
left the Reviewed-by's collected in place.

I've changed the kzalloc() / snprintf() to just kasprintf() as requested
by Bart. Since it was not clear that we don't have the bdev on
do_blk_trace_setup() for the patch titled "blktrace: break out of
blktrace setup on concurrent calls", I've added a comment so that
someone doesn't later try to add a dev_printk() or the like.

I've also addressed a compilation issue with debugfs disabled reported
by 0-day on the patch titled "blktrace: fix debugfs use after free". It
was missing a "static inline" on a function. I've also moved the new
declarations underneath the "#ifdef CONFIG_BLOCK" on include/linux/genhd.h,
I previously had them outside of this block.

I've left in place the scsi-generic blktrace suppport given I didn't receive any
feedback to kill it. This ensures this works as it used to.

Since these are minor changes I've given this a spin with break-blktrace
tests I have written and also ran blktrace with a scsi-generic media
changer. Both sg0 (the controller) and sg1 worked as expected.

These changes are based on linux-next tag next-20200515, and can also be
found on my git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200515-blktrace-fixes

Luis Chamberlain (7):
  block: add docs for gendisk / request_queue refcount helpers
  block: clarify context for gendisk / request_queue refcount increment
    helpers
  block: revert back to synchronous request_queue removal
  block: move main block debugfs initialization to its own file
  blktrace: fix debugfs use after free
  blktrace: break out of blktrace setup on concurrent calls
  loop: be paranoid on exit and prevent new additions / removals

 block/Makefile               |  10 +-
 block/blk-core.c             |  32 ++++--
 block/blk-debugfs.c          | 197 +++++++++++++++++++++++++++++++++++
 block/blk-mq-debugfs.c       |   5 -
 block/blk-sysfs.c            |  46 ++++----
 block/blk.h                  |  24 +++++
 block/bsg.c                  |   2 +
 block/genhd.c                |  73 ++++++++++++-
 block/partitions/core.c      |   9 ++
 drivers/block/loop.c         |   4 +
 drivers/scsi/ch.c            |   1 +
 drivers/scsi/sg.c            |  75 +++++++++++++
 drivers/scsi/st.c            |   2 +
 include/linux/blkdev.h       |   6 +-
 include/linux/blktrace_api.h |   1 -
 include/linux/genhd.h        |  69 ++++++++++++
 kernel/trace/blktrace.c      |  37 +++++--
 17 files changed, 545 insertions(+), 48 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.26.2

