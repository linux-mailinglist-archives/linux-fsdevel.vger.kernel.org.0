Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0310419931
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhI0Qj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhI0Qju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC865C061769;
        Mon, 27 Sep 2021 09:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=eU0Ovi0loMOt90ZC44OHIOcp0Nb8ys+AmBqPx+DEBFM=; b=GsS9HvltW5b+gvYUG5G3adNm79
        pDtREe5oBj1NNdVDByWZ/dKMjoElmStOnpGYNPjOMk41IbI6riEvPYoc6BZR64QqmK85DW+YcFxrd
        /d0RRGPSoKE33r9dXyEALYQWMbBMxPvjwCOcd76T+NY3mIN65aMZuJa/2H9whLBuvtRSPEJ2NbuLU
        nk4YFPpM+9TK+wH20xPZYm+A5iCz3K7yrOur1rzezm2Tnoh8n+MYJ8f81z9Xv1vZyjYaQcSTfkcc9
        mg58n58JDTJF/YWILcRKZsCz54x4WVa8eIgCwBPm4YsWaFA69CvPoy/heEwbLnIiaa/azUgtwPn5u
        oUBH3A6g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtdm-003OSR-Vw; Mon, 27 Sep 2021 16:38:07 +0000
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
Subject: [PATCH v8 08/12] fs/sysfs/dir.c: replace S_IRWXU|S_IRUGO|S_IXUGO with 0755 sysfs_create_dir_ns()
Date:   Mon, 27 Sep 2021 09:38:01 -0700
Message-Id: <20210927163805.808907-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927163805.808907-1-mcgrof@kernel.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
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

