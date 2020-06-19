Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94894201CB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393485AbgFSUsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:48:17 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40201 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390990AbgFSUrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:40 -0400
Received: by mail-pj1-f66.google.com with SMTP id s88so4770921pjb.5;
        Fri, 19 Jun 2020 13:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dQaXAvki8sYaKGwXLR52YNJf2NEdQTW2gAe2FMsltcA=;
        b=Ute210DxdatIamZY5Oc/gcWO5bYLJXAtQ4L6cvUlJTM8QPaauqQ3E+AXQCFfidkqOy
         N0w9HK8ht3UNDlGeU7DKsfV6p8KBNxXlnKKd1w1it2mO8JrzqO1AOjb5EGB2tHVz61oy
         vZ3tvDyRNPnJPcucwvJsnOe38z6AW/YxCYrJvwdQP8Kz3LuaoEMNhc7zYGUj5pdGB+Af
         aI8FLMX/NaI6aMb3JxcmAnXc1NgShk3FWV4ABjc9VmVQHHxxlHrLEIuljfT8PspuqKff
         hEYBYBhPGCtayBlO87vJKqQAOx2SeNwS5oMqMrQtYAXRiP90YkPzjBjIAF2Hz0vHHiex
         llrQ==
X-Gm-Message-State: AOAM533CrDKG49n7PzYPVpMqmT+TFbhHX6miLVV4yX0aP7V6WYJ3+k2U
        x+u/3PLUimotnstiGaZGv1g=
X-Google-Smtp-Source: ABdhPJz6FN8us6j2Rb6yY2Uaymx8u9Kkw3oC6l3CKk046JMwY9HetI2SAwZYSEdr1v4YyRVw1clOUQ==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr5207584pjb.36.1592599659656;
        Fri, 19 Jun 2020 13:47:39 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id fa13sm5801738pjb.39.2020.06.19.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 14F9F4063E; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 0/8] blktrace: fix debugfs use after free
Date:   Fri, 19 Jun 2020 20:47:22 +0000
Message-Id: <20200619204730.26124-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Its been a fun ride, but all patch series come to an end. My hope is
that this is it. The simplification of the fix is considerable now,
with only a few lines of code and with no data structure changes.

We were only creating the debugfs_dir upon initialization only if
you had CONFIG_BLK_DEBUG_FS for for make_request block drivers
(multiqueue). That's where the UAF bug could happen. Folks liked
the idea of open coding the debugfs initialization even if
CONFIG_BLK_DEBUG_FS was disabled, given that debugfs code will
simply ignore that code if debugfs is disabled, but to make
the fix easier to backport, that shift is done now in another
patch. Likewise, although we were only creating the debugfs_dir
only for make_request block drivers (multiqueue), the same new
additional patch also creates the debugfs_dir for request-based
block drivers. That *begged* us to just rename the mutex to
clarify its for the debugfs_dir, blktrace then just becomes
its biggest user.

The only patches changed here is the last one from the last series,
which actually fixed the UAF oops, and that one is now split in 3
patches, which makes a secondary fix much clearer.

I've waited a while to post these, to let 0-day give me its blessings,
both for Linus' tree and linux-next. No issues have been found. I've
also taken time to run blktests prior and after this series and I have
found no regressions. In fact, I think I should just extend blktests
with the break-blktrace tests, I'll do that later.

Luis Chamberlain (8):
  block: add docs for gendisk / request_queue refcount helpers
  block: clarify context for refcount increment helpers
  block: revert back to synchronous request_queue removal
  blktrace: annotate required lock on do_blk_trace_setup()
  loop: be paranoid on exit and prevent new additions / removals
  blktrace: fix debugfs use after free
  blktrace: ensure our debugfs dir exists
  block: create the request_queue debugfs_dir on registration

 block/blk-core.c        | 31 +++++++++++++----
 block/blk-mq-debugfs.c  |  5 ---
 block/blk-sysfs.c       | 52 ++++++++++++++++------------
 block/blk.h             |  2 --
 block/genhd.c           | 73 ++++++++++++++++++++++++++++++++++++++-
 drivers/block/loop.c    |  4 +++
 include/linux/blkdev.h  |  7 ++--
 kernel/trace/blktrace.c | 76 ++++++++++++++++++++++++-----------------
 8 files changed, 179 insertions(+), 71 deletions(-)

-- 
2.26.2

