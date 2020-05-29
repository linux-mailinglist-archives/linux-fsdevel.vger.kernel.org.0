Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF591E7126
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438054AbgE2AKg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438050AbgE2AK0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:10:26 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B07C08C5C8;
        Thu, 28 May 2020 17:10:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSbP-00HEZS-80; Fri, 29 May 2020 00:10:23 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] compat sysinfo(2): don't bother with field-by-field copyout
Date:   Fri, 29 May 2020 01:10:21 +0100
Message-Id: <20200529001023.4107547-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529000957.GW23230@ZenIV.linux.org.uk>
References: <20200529000957.GW23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/sys.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..b4a0324a0699 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2634,6 +2634,7 @@ struct compat_sysinfo {
 COMPAT_SYSCALL_DEFINE1(sysinfo, struct compat_sysinfo __user *, info)
 {
 	struct sysinfo s;
+	struct compat_sysinfo s_32;
 
 	do_sysinfo(&s);
 
@@ -2658,23 +2659,23 @@ COMPAT_SYSCALL_DEFINE1(sysinfo, struct compat_sysinfo __user *, info)
 		s.freehigh >>= bitcount;
 	}
 
-	if (!access_ok(info, sizeof(struct compat_sysinfo)) ||
-	    __put_user(s.uptime, &info->uptime) ||
-	    __put_user(s.loads[0], &info->loads[0]) ||
-	    __put_user(s.loads[1], &info->loads[1]) ||
-	    __put_user(s.loads[2], &info->loads[2]) ||
-	    __put_user(s.totalram, &info->totalram) ||
-	    __put_user(s.freeram, &info->freeram) ||
-	    __put_user(s.sharedram, &info->sharedram) ||
-	    __put_user(s.bufferram, &info->bufferram) ||
-	    __put_user(s.totalswap, &info->totalswap) ||
-	    __put_user(s.freeswap, &info->freeswap) ||
-	    __put_user(s.procs, &info->procs) ||
-	    __put_user(s.totalhigh, &info->totalhigh) ||
-	    __put_user(s.freehigh, &info->freehigh) ||
-	    __put_user(s.mem_unit, &info->mem_unit))
+	memset(&s_32, 0, sizeof(s_32));
+	s_32.uptime = s.uptime;
+	s_32.loads[0] = s.loads[0];
+	s_32.loads[1] = s.loads[1];
+	s_32.loads[2] = s.loads[2];
+	s_32.totalram = s.totalram;
+	s_32.freeram = s.freeram;
+	s_32.sharedram = s.sharedram;
+	s_32.bufferram = s.bufferram;
+	s_32.totalswap = s.totalswap;
+	s_32.freeswap = s.freeswap;
+	s_32.procs = s.procs;
+	s_32.totalhigh = s.totalhigh;
+	s_32.freehigh = s.freehigh;
+	s_32.mem_unit = s.mem_unit;
+	if (copy_to_user(info, &s_32, sizeof(s_32)))
 		return -EFAULT;
-
 	return 0;
 }
 #endif /* CONFIG_COMPAT */
-- 
2.11.0

