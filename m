Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EABB1A3C12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgDIVpk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 17:45:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43883 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgDIVpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:45:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id l1so129033pff.10;
        Thu, 09 Apr 2020 14:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gy1UfSr56zzS49pk3P0leehV/LFyixVBPxU1Vl/ddsw=;
        b=qNGQhR0K1sHgMSL09FKzUNO0VDZhBunTcCuJmjYt09v4UY7O8LNb6IwgubOByrPSFX
         prRWw7I/vwAo/O2noEteLWNnocEjay/PBZEOh4oirzr4PU7twQJn1wO52rdYH/+SeU3l
         doLuBQ1oFixqlSimikeuiypbfdDepzje4dzLKGD2j1xhW9BP68rz1GK6x7QaD23cPJTD
         4f1I7Cu4q7vcbiXMdLgxllpB2hnpxN8NlmFQG/zFvBrFamrEoPTDVZJK8AZM+1fbOeoL
         1EYdu/ztS4iY1U1mmupe3Ht+QmGtMTbIUAYCzyok/uvb+oUGAOPOkww3hldXPn09lSHW
         7MWQ==
X-Gm-Message-State: AGi0PuY2hI0caNgSY1+JeAwAvabHEYEYwPe+6l4NP7fujmXZE0P3cL79
        hsayvsKqcwglr3ofS3qUtJ8=
X-Google-Smtp-Source: APiQypIRu35uCdJrL/5JzRDGZkG7eCJZdWSQQYH/I+boGDvDxSG5cHBQsRqIpIeV686q3aFn7ST2rg==
X-Received: by 2002:aa7:8bda:: with SMTP id s26mr1667719pfd.142.1586468739160;
        Thu, 09 Apr 2020 14:45:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c15sm67565pgk.66.2020.04.09.14.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:45:37 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1753940246; Thu,  9 Apr 2020 21:45:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v2 0/5] blktrace: fix use after free
Date:   Thu,  9 Apr 2020 21:45:25 +0000
Message-Id: <20200409214530.2413-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes a use after free on block trace. This v2 adjusts the
commit log feedback from the first iteration, and also expands on the
series to include a few additional fixes which would be needed for us
to continue with a synchronous request_queue removal. The refcount added
for blktrace resolves the kobject issues pointed out by yukuai. Note
that CONFIG_DEBUG_KOBJECT_RELEASE purposely was added to create
situations where drivers misbehave, and so you should not use it to
test expected userspace behaviour, but just to catch possible kernel
issues. For details refer to the commit which introduced it, which
actually helps a bit more than just reading the kconfig description,
its commit was c817a67ecba7 ("kobject: delayed kobject release: help
find buggy drivers"). This series also fixes a small build issue
discovered by 0-day.

The QUEUE_FLAG_DEFER_REMOVAL flag is added as part of the last patch,
just in case for now. However, given creative use of refcounting
I don't think we need it anymore. An example use case of creative
use of refcounting is provided for mm/swapfile.

I've extended break-blktrace [0] with 3 test cases which now pass
for the most part:

run_0001.sh
run_0002.sh
run_0003.sh

The exception to this is when we get an EBUSY on loopback removal. This
only happens every now and then, and upon further investigation, I
suspect this is happening due to the same race Dave Chinner ran into
with using loopback devices and fstests, which made explicit loopback
destruction lazy via commit a1ecac3b0656 ("loop: Make explicit loop
device destruction lazy"). Further eyeballs on this are appreciated,
perhaps break-blktrace can be extended a bit to account for this.

After a bit of brushing up, I am considering just upstreaming this
as a self tests for blktrace, instead of keeping this out of tree.

Worth noting as well was that it seems odd we didn't consider the
userspace impact of commit dc9edc44de6c ("block: Fix a blk_exit_rl()
regression") merged on v4.12 moved, as that deferral work sure did
have an impact what userspace can expect upon device removal or races
on addition/removal. Its not clear if mentioning any of this on the
commit logs is worth it... Shouldn't have that deferral been a
userspace regression?

If you want this on a git tree you can find it on my 20200409-blktrace-fix-uaf
branch on kernel.org based on linux-next next-20200409.

Feedback, reviews, rants are all greatly appreciated.

[0] https://github.com/mcgrof/break-blktrace
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200409-blktrace-fix-uaf

Luis Chamberlain (5):
  block: move main block debugfs initialization to its own file
  blktrace: fix debugfs use after free
  blktrace: ref count the request_queue during ioctl
  mm/swapfile: refcount block and queue before using
    blkcg_schedule_throttle()
  block: revert back to synchronous request_queue removal

 block/Makefile               |  1 +
 block/blk-core.c             |  9 +-------
 block/blk-debugfs.c          | 27 ++++++++++++++++++++++
 block/blk-mq-debugfs.c       |  5 -----
 block/blk-sysfs.c            | 43 +++++++++++++++++++++++++++++-------
 block/blk.h                  | 17 ++++++++++++++
 include/linux/blkdev.h       |  7 +++++-
 include/linux/blktrace_api.h |  1 -
 kernel/trace/blktrace.c      | 25 ++++++++++++---------
 mm/swapfile.c                | 11 +++++++++
 10 files changed, 112 insertions(+), 34 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

