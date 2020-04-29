Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E91BD669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgD2Hqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 03:46:33 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37452 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgD2Hqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:46:33 -0400
Received: by mail-pj1-f68.google.com with SMTP id a7so433898pju.2;
        Wed, 29 Apr 2020 00:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NYubAi/xyHN/Pt3WLLDfx9xZYmA2QF+HOc1wknCJjyE=;
        b=GRVpuSICDDEMtu3XtVD1g71gFPyq25bQVNgOCvuQ6rb6vPCIdZLLdNSc4TJRJBlFKQ
         b9jCVkwSKfOQTugMOJghCGGcDtGPmC8RZaO47jzLyAe0540nNuPUT2MdoiHfeCOz4Tsp
         ztGe+W3PH5cdFL9sr2WCbjjWS6sI7PEA2YKMAObzVc750KoLizJHbJZYYjajfsKKmSRe
         U78O3ER6GJ90k4q+0cJqZv9wdzA4XPuK7soi3+RvSjcuhg/Ouj8xJ5+Jlvv3Deipd8hO
         Zh+RBHdTgnpLnwrBU/9GqA5tJDs6ICTbYa7Pllt8+uBLk/uM9Z5yaeTnclBgu/EEpJtV
         z5xg==
X-Gm-Message-State: AGi0Pub8XD9+hXY3i3fp4niqgVK15y2a/opJIq1dTnNhdTv+vE6xArTO
        yhh+VCpjAXoS1pIiGvwT27o=
X-Google-Smtp-Source: APiQypIfWlYu4r9gGMTIUxtKPyw+8rsye9CqmxwCOpf6XM6xFBrcbMQA0lW6oMqBferHgjxE4Y6RAA==
X-Received: by 2002:a17:90a:8c85:: with SMTP id b5mr1555073pjo.187.1588146392532;
        Wed, 29 Apr 2020 00:46:32 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 141sm411722pfz.171.2020.04.29.00.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 00:46:30 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B9830403AB; Wed, 29 Apr 2020 07:46:29 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 0/6] block: fix blktrace debugfs use after free
Date:   Wed, 29 Apr 2020 07:46:21 +0000
Message-Id: <20200429074627.5955-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alrighty, here is v3 with all the BUG_*() crap removed, and moving
to just create the debugfs directory needed for the partitions as well
at initialization. This allows us to get rid of the pesky
debugfs_lookup() calls which has made this code very awkward, and
allowed us to find surprising bugs when we went with an
asynchronous request_queue removal.

I'll note that I still see this:

debugfs: Directory 'loop0' with parent 'block' already present!

But only for break-blktrace [0] run_0004.sh. But since we don't
have any more races with blktrace, this has pushed me to look
into disk registration / deletion. I'll be posting patches soon
about some changes to help with that, on the error handling.

If, after these patches, you however find the root cause to this
let me know!

Also, if folks don't disagree, I'll likely follow up to just merge
break-blktrace as a self-test for blktrace. We can later expand on it
upstream instead.

These patches are based on linux-next tag next-20200428, you can find
the code on my 20200428-blktrace-fixes branch [1].

[0] https://github.com/mcgrof/break-blktrace
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200428-blktrace-fixes

Luis Chamberlain (6):
  block: revert back to synchronous request_queue removal
  block: move main block debugfs initialization to its own file
  blktrace: move blktrace debugfs creation to helper function
  blktrace: fix debugfs use after free
  blktrace: break out of blktrace setup on concurrent calls
  loop: be paranoid on exit and prevent new additions / removals

 block/Makefile               |  1 +
 block/blk-core.c             | 32 ++++++++++++----
 block/blk-debugfs.c          | 44 ++++++++++++++++++++++
 block/blk-mq-debugfs.c       |  5 ---
 block/blk-sysfs.c            | 47 ++++++++++++-----------
 block/blk.h                  | 18 +++++++++
 block/genhd.c                | 73 +++++++++++++++++++++++++++++++++++-
 block/partitions/core.c      |  3 ++
 drivers/block/loop.c         |  4 ++
 drivers/scsi/sg.c            |  2 +
 include/linux/blkdev.h       |  7 ++--
 include/linux/blktrace_api.h |  1 -
 include/linux/genhd.h        | 18 +++++++++
 kernel/trace/blktrace.c      | 39 ++++++++++++++++---
 14 files changed, 249 insertions(+), 45 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

