Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227204103F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 07:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241864AbhIRFGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 01:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbhIRFGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E338FC061757;
        Fri, 17 Sep 2021 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=REleVeJdVPAjpr9HeQ2cRfmfpLS6DlhRbk/XlbxpQOE=; b=QzR7NY5Fd+cQRWfTaqtKiaRDUV
        7qaA68e8dCYZLdZDm52bd5Qv5sR8TTBOZtQE2sCzurKg7c4TAWpBZDfN8TPQFeQSNO0NNCAtRXKjd
        +eW3WMTgmid5sptLhXA8FJEmBlDDVf/KtTSKj+aW7kly6s9LnI/NMzthxasKWR5NSQLkhSLVM1N5u
        q1Adv1Z46q6/pEFTCp7nSmls2dmWNOgw+lx+r5+0oX0xV2Kao7Y0j7mDWXvE6bcj7F8AJvIRQqINN
        tMgQ1XPNN3YpvzDsgq5TLOS7BYsXE3otLzEfvuOIUw3CP1bbCUEEiwC/PHluEyP631IqjSvAFSbeM
        f3vzE3og==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRSWf-00FP4e-CH; Sat, 18 Sep 2021 05:04:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        mcgrof@kernel.org, reinette.chatre@intel.com, fenghua.yu@intel.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: [PATCH v7 10/12] test_sysfs: enable deadlock tests by default
Date:   Fri, 17 Sep 2021 22:04:28 -0700
Message-Id: <20210918050430.3671227-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that sysfs has the deadlock race fixed with module removal,
enable the deadlock tests module removal tests. They were left
disabled by default as otherwise you would deadlock your system

./tools/testing/selftests/sysfs/sysfs.sh -t 0027
Running test: sysfs_test_0027 - run #0
Test for possible rmmod deadlock while writing x ... ok

./tools/testing/selftests/sysfs/sysfs.sh -t 0028
Running test: sysfs_test_0028 - run #0
Test for possible rmmod deadlock using rtnl_lock while writing x ... ok

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/sysfs/sysfs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sysfs/sysfs.sh b/tools/testing/selftests/sysfs/sysfs.sh
index f928635d0e35..4047ac48e764 100755
--- a/tools/testing/selftests/sysfs/sysfs.sh
+++ b/tools/testing/selftests/sysfs/sysfs.sh
@@ -60,8 +60,8 @@ ALL_TESTS="$ALL_TESTS 0023:1:1:test_dev_y:block"
 ALL_TESTS="$ALL_TESTS 0024:1:1:test_dev_x:block"
 ALL_TESTS="$ALL_TESTS 0025:1:1:test_dev_y:block"
 ALL_TESTS="$ALL_TESTS 0026:1:1:test_dev_y:block"
-ALL_TESTS="$ALL_TESTS 0027:1:0:test_dev_x:block" # deadlock test
-ALL_TESTS="$ALL_TESTS 0028:1:0:test_dev_x:block" # deadlock test with rntl_lock
+ALL_TESTS="$ALL_TESTS 0027:1:1:test_dev_x:block" # deadlock test
+ALL_TESTS="$ALL_TESTS 0028:1:1:test_dev_x:block" # deadlock test with rntl_lock
 ALL_TESTS="$ALL_TESTS 0029:1:1:test_dev_x:block" # kernfs race removal of store
 ALL_TESTS="$ALL_TESTS 0030:1:1:test_dev_x:block" # kernfs race removal before mutex
 ALL_TESTS="$ALL_TESTS 0031:1:1:test_dev_x:block" # kernfs race removal after mutex
-- 
2.30.2

