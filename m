Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C9E4103DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhIRFGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 01:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhIRFGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:06:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383EC06175F;
        Fri, 17 Sep 2021 22:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eU0Ovi0loMOt90ZC44OHIOcp0Nb8ys+AmBqPx+DEBFM=; b=EGRNR6XrGcu/Y2nvAt7CVjcqem
        d8ejBdVzVQkuLTb+tpdo/Smw903x9MvFfm/2gItW/7msby9ii/pgTa5xf0SPDjnVXRPyXm2J51q58
        T52goTmkokygeDNOJwPEu79YH2R4gWk8rtbTvumS9ffE9ibqRbl/+Mz1G/vL/sMMXm1+rkkCbGlto
        qPfl2oOV4tj53k99WTBILq+O2vGtMNm8h12a8ELjAhmN0ccVn85dq+a6hkh4KD6J/VFFfmDcpGrIo
        HAtsArgtGtFtbKzMQBxPsuyhvHljGPjSd5f38Wd4Rj9d1M1nhO2t4/Wm9cmzFfqsU6eoEKlowafZJ
        7m6bs+iA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRSWf-00FP4a-8R; Sat, 18 Sep 2021 05:04:33 +0000
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
Subject: [PATCH v7 08/12] fs/sysfs/dir.c: replace S_IRWXU|S_IRUGO|S_IXUGO with 0755 sysfs_create_dir_ns()
Date:   Fri, 17 Sep 2021 22:04:26 -0700
Message-Id: <20210918050430.3671227-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210918050430.3671227-1-mcgrof@kernel.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If one ends up expanding on this line checkpatch will complain that the
combination S_IRWXU|S_IRUGO|S_IXUGO should just be replaced with the
octal 0755. Do that.

This makes no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/sysfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 59dffd5ca517..b6b6796e1616 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -56,8 +56,7 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 
 	kobject_get_ownership(kobj, &uid, &gid);
 
-	kn = kernfs_create_dir_ns(parent, kobject_name(kobj),
-				  S_IRWXU | S_IRUGO | S_IXUGO, uid, gid,
+	kn = kernfs_create_dir_ns(parent, kobject_name(kobj), 0755, uid, gid,
 				  kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
-- 
2.30.2

