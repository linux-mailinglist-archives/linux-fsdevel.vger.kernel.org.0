Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05EB1F2BD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 11:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbfKGKIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 05:08:15 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:37534 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387956AbfKGKIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:08:15 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 757122E1456;
        Thu,  7 Nov 2019 13:08:12 +0300 (MSK)
Received: from myt4-4db2488e778a.qloud-c.yandex.net (myt4-4db2488e778a.qloud-c.yandex.net [2a02:6b8:c00:884:0:640:4db2:488e])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id YimQGnuJHz-8BAG2M7Z;
        Thu, 07 Nov 2019 13:08:12 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1573121292; bh=FDYer/G1exmbZZ33knvedvfovSeH/qFm/xa0qxTLhTo=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=KalwM8vMV2sOHEiZho98t8ZPPTRG+ZwvCY8NSXYkOYxtTLQdLyfwGBKwSfA9G5tvq
         1GlSniaRf6Te2IT5VKt5AHmcp6DNmFWdPIg2EghxZ0aPWqiIcur5WPoxVwAHzcNfm2
         UnFRPeXbnQVfuJ2JEE1R3iziynbewEP6FKTRmICE=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by myt4-4db2488e778a.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gHEmmSgsZi-8BWaFZsn;
        Thu, 07 Nov 2019 13:08:11 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] fs/quota: use unsigned int helper for sysctl fs.quota.*
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Thu, 07 Nov 2019 13:08:11 +0300
Message-ID: <157312129151.3890.6076128127053624123.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Report counters as unsigned, otherwise they turn negative at overflow:

# sysctl fs.quota
fs.quota.allocated_dquots = 22327
fs.quota.cache_hits = -489852115
fs.quota.drops = -487288718
fs.quota.free_dquots = 22083
fs.quota.lookups = -486883485
fs.quota.reads = 22327
fs.quota.syncs = 335064
fs.quota.writes = 3088689

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/quota/dquot.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..606e1e39674b 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2865,7 +2865,7 @@ static int do_proc_dqstats(struct ctl_table *table, int write,
 	/* Update global table */
 	dqstats.stat[type] =
 			percpu_counter_sum_positive(&dqstats.counter[type]);
-	return proc_dointvec(table, write, buffer, lenp, ppos);
+	return proc_douintvec(table, write, buffer, lenp, ppos);
 }
 
 static struct ctl_table fs_dqstats_table[] = {

