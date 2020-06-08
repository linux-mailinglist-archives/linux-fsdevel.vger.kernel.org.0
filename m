Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0464B1F1E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgFHRBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:01:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43870 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbgFHRBc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:01:32 -0400
Received: by mail-pg1-f195.google.com with SMTP id 185so8999294pgb.10;
        Mon, 08 Jun 2020 10:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qUXzgbRX2wKZYMA8ok0uoS1JUpyLuZc0+BTfrQx3Bi8=;
        b=JGEuQvRaHyHT1vd8fp6D4LuxLAYmsC6Toq5m+9Gh2aUZFzkW67oW/hXzZQBvB1olnl
         DqV8UoXaRiYiRt36GyrpaNYMLI42yaRYrh78/qgqdRPG9wek0pIUAg/KaYQhc3niLMEn
         h6P1ysCXm15E4gGAoHS1SnemypG76Fo84hmmkqm7dRXejqOJX2dML/Zzf3gHYbAGFl+z
         pk6Wef+0i1946rz6xwakvMSD1ciQF+KqP6cF6+WpBgZlQxaPLHzXAJS/zqoYzJGOHwrh
         LqIQfh9+WY+JFVxkp80XvITJKefiZ/g3wPco1R99JmQ3Eszyjkz+RYG2GY3epKEC7jFV
         Mehg==
X-Gm-Message-State: AOAM530GAWfn8BrhUFF8xMtiIU0sdRMdOdigF82vDFmKiecoqyxGP8aO
        tSBqz9fLNejfFjYjzUISSlM=
X-Google-Smtp-Source: ABdhPJxAdCHgKvd/QmgBvDw7T4q6bq0lGS5DH72sx0NO830E9BqR93jPtM6XpNPD7SkanCzM5xJylA==
X-Received: by 2002:a62:ee0b:: with SMTP id e11mr3788583pfi.185.1591635690050;
        Mon, 08 Jun 2020 10:01:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x77sm7839391pfc.4.2020.06.08.10.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:28 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DBD5D403AB; Mon,  8 Jun 2020 17:01:27 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 0/8] block: fix blktrace debugfs use after free
Date:   Mon,  8 Jun 2020 17:01:20 +0000
Message-Id: <20200608170127.20419-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is v6 of the blktrace fixes which address the debugfs use after
free. I've followed the strategy suggested by Christoph of open coding
the solution in place, and extended it with the required work for
partitions and scsi-generic. Jan's blktrace sparse fix ended up
depending on one of my patch, "blktrace: break out of blktrace setup
on concurrent calls", and so he has sent those for inclusion prior to my
series. This series would have to be applied after those two patches
from Jan are merged then.

Since the patch "blktrace: fix debugfs use after free" ends up being the
only one modified lately, I've moved that patch to be the last one in
the series now.

You can find these on my git tree branch 20200608-blktrace-fixes based
on linux-next 20200608 [0].

Hopefully this is it.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200608-blktrace-fixes

Luis Chamberlain (6):
  block: add docs for gendisk / request_queue refcount helpers
  block: clarify context for refcount increment helpers
  block: revert back to synchronous request_queue removal
  blktrace: annotate required lock on do_blk_trace_setup()
  loop: be paranoid on exit and prevent new additions / removals
  blktrace: fix debugfs use after free

 block/blk-core.c             | 27 ++++++++++--
 block/blk-mq-debugfs.c       |  5 ---
 block/blk-sysfs.c            | 83 +++++++++++++++++++++++++++---------
 block/blk.h                  |  2 -
 block/genhd.c                | 73 ++++++++++++++++++++++++++++++-
 block/partitions/core.c      |  3 ++
 drivers/block/loop.c         |  4 ++
 drivers/scsi/sg.c            |  3 ++
 include/linux/blkdev.h       |  6 +--
 include/linux/blktrace_api.h |  1 -
 include/linux/genhd.h        |  1 +
 kernel/trace/blktrace.c      | 55 ++++++++++++++++++------
 12 files changed, 214 insertions(+), 49 deletions(-)

-- 
2.26.2

