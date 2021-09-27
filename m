Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA7241990A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhI0Qjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbhI0Qju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D97EC06176F;
        Mon, 27 Sep 2021 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=REleVeJdVPAjpr9HeQ2cRfmfpLS6DlhRbk/XlbxpQOE=; b=dqepaPYL6bp8zEij/tVtym0vr+
        BKG0l1LWPsNfX29/PF5lo/AnI3A/GDsWdLUoNvBjgi5Kqtf30uXBp6+IXUSTEymBs0lB9wAd7zOaL
        e4DFp0COrY/kaYUGnXTVi90R/qEuEr7bQTOzjVRqzXvgLJNb2eVDr/BHRfo+2QMd5TvnGRHjDYvsQ
        7asB7n7joJaP5vkkugcFcx/4iX3UDj3qWQwx9MAXvSRhrSL3gLgNA60/PuK/qYcGXmBJuZWZhGK+l
        ceTwkz9zSIgEi+Ku5IziTpsCc/5WnMU2hLJ82bLMcrTutdEeRgS9PulAoNDPStxu/Mw2Zl4Mgy5Xl
        JnXTrw6w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtdn-003OSi-5V; Mon, 27 Sep 2021 16:38:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/12] test_sysfs: enable deadlock tests by default
Date:   Mon, 27 Sep 2021 09:38:03 -0700
Message-Id: <20210927163805.808907-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927163805.808907-1-mcgrof@kernel.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
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

