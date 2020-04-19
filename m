Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A481AFDB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDSTpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:43 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33992 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgDSTpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:43 -0400
Received: by mail-pj1-f68.google.com with SMTP id q16so3964008pje.1;
        Sun, 19 Apr 2020 12:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nBDa0rXFg9iHiCCMSKdC08ZVJ5XJ1HD+NLLqlL75QE=;
        b=VZ9lJynRjwhVOzBhr/090oEVTfHvBAjUakYCvEmwHJNI/Eic4xKL00g28UQ/7kkRGT
         vSKpJ2BlInjVsGPkIGUoymgEaddOpUnrLPzaCRbBA0EZRuMcdk1zyY/7V7jiLDu+1AXT
         PDvPeqAHkJyb6eIz7AR3sIl5nKn2V85iAinrAN05a0sZJLwJY5Iqyhkg6hTwNdJforI2
         fEqVBufo1r9eRyW89gwT4kqhcufSAT46AUdxe6hl5v283WFCwmBDcqzyqP/QkYxn+ktY
         v5jkI8M6k1qTkmxWaFdqsaAYa0FEXpgxDr5B4cEVBetLgdRUrbEj/WwxyJRCj0NlEYEO
         KzbQ==
X-Gm-Message-State: AGi0PuZ5Mu0ALFPcNosNOwHirjQmN/IZ3VkFSHqESlnzBzWGDBB1hyNu
        YRq9zjL9z+75NjQm+eCSE/o=
X-Google-Smtp-Source: APiQypJayFgKefqgg6H/JR67sswmZGgea+8/ivT+/Vf5pPT068xt+HAMYcOsqSUtrFH/BBGo5pJ52w==
X-Received: by 2002:a17:90a:9202:: with SMTP id m2mr8028414pjo.109.1587325540421;
        Sun, 19 Apr 2020 12:45:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id i8sm22879992pgr.82.2020.04.19.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7E737403EA; Sun, 19 Apr 2020 19:45:38 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 00/10] block: fix blktrace debugfs use after free
Date:   Sun, 19 Apr 2020 19:45:19 +0000
Message-Id: <20200419194529.4872-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Upstream kernel.org korg#205713 [0] states that there is a UAF in the
core debugfs debugfs_remove() function, and has gone through pushing for
a CVE for this, CVE-2019-19770 [1].

This patch series disputes that CVE, and shows how the issue was just
a complex misuse of debugfs within blktrace and fixes it.

On this v2 I've dropped two patches from my last series which are not
needed to ensure we can move back to a synchronous request_queue
removal. I've also addressed Ming's feedback on ensuring we keep
functionality working for when paritions are used for a blktrace.  That
effort lead me to ensuring we don't try to overwrite the request_queue
debugfs_dir, and add sanity checks in place so that what we give back
only what is expected.

Although my v1 patches also had fixed the kernel splat we get when we
try to reproduce the issue:

debugfs: Directory 'loop0' with parent 'block' already present!

This v2 series now provides a clear explanation for *why* this was
ultimately one of the reasons why we ended up with a crash.

The commit log for the actual fix, patch 3/10, "blktrace: fix debugfs
use after free" has also been extended to provide a better explanation
as to *how* overwriting the debugfs_dir leads to an eventual panic with
blktrace. I hope that helps, as it seems the root cause was still not
well explained in the commit log.

To make review easier, I've also added some helper functions with no
functional changes at first, and only extended them later.

Also changed is blk_queue_debugfs_register() to return an int, we do
this to not make the fact that we don't check for errors on
register_disk() or add_disk() any worse.

After the patch 3/10 "blktrace: fix debugfs use after free", is applied,
with the pr_warns(), and prior to reverting back to synchronous request_queue
removal, if we try to reproduce the issue with break-blktrace [2]'s
./run_0001.sh script, we'd see::

blk_debugfs: loop0 : registering request_queue debugfs directory twice is not allowed
blktrace: loop0: request_queue parent is gone

And sometimes only:

blk_debugfs: loop0 : registering request_queue debugfs directory twice is not allowed

After we revert back to synchronous request_queue removal this should no
longer be possible, and if it is, we want to hear about it. To help with
this two patches are added which change pr_warn() to BUG_ON()s after we flip
back to synchronous request_queue removal.

Note that on patch 6/10 "blk-debugfs: upgrade warns to BUG_ON() if
directory" I explain the syfs layout between a gendisk and the
request_queue. By reverting back to synchronous request_queue removal,
if someone manages to figure out a way to create a clash with
registering block devices, we expect to see a sysfs clash now instead of
a clash with debugfs, as the debugfs directory is removed now always
first, prior to clearing out the sysfs dir. *If* there are races
possible in these areas, we want to hear about them, and the BUG_ON()s
should make it clearer *where* the real issue is coming from.

Having an asynchronous request_queue removal has exposed other bugs
lingering around, however most importantly I think its revealing more
the value of adding error handling for __device_add_disk() and friends.
If its encouraged I could take a stab at finally addressing that for
good.

You can find this code on my git tree, on the 20200417-blktrace-fixes
branch, which is based on linux-next tag next-20200417 [3].

[0] https://bugzilla.kernel.org/show_bug.cgi?id=205713                          
[1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770 
[2] https://github.com/mcgrof/break-blktrace
[3] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200417-blktrace-fixes

Luis Chamberlain (10):
  block: move main block debugfs initialization to its own file
  blktrace: move blktrace debugfs creation to helper function
  blktrace: fix debugfs use after free
  block: revert back to synchronous request_queue removal
  blktrace: upgrade warns to BUG_ON() on unexpected circmunstances
  blk-debugfs: upgrade warns to BUG_ON() if directory is already found
  blktrace: move debugfs file creation to its own function
  blktrace: add checks for created debugfs files on setup
  block: panic if block debugfs dir is not created
  block: put_device() if device_add() fails

 block/Makefile               |   1 +
 block/blk-core.c             |  28 +++++---
 block/blk-debugfs.c          |  39 ++++++++++++
 block/blk-mq-debugfs.c       |   5 --
 block/blk-sysfs.c            |  47 ++++++++------
 block/blk.h                  |  18 ++++++
 block/genhd.c                |   4 +-
 include/linux/blkdev.h       |   7 +-
 include/linux/blktrace_api.h |   1 +
 kernel/trace/blktrace.c      | 120 +++++++++++++++++++++++++++++++----
 10 files changed, 218 insertions(+), 52 deletions(-)
 create mode 100644 block/blk-debugfs.c

-- 
2.25.1

