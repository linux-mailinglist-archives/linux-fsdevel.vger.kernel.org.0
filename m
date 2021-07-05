Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E423BC199
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jul 2021 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGEQ0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 12:26:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhGEQ0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 12:26:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 89F591FEBC;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625502208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv+4kF1EjnZ4ZkFyTsjZqCItVDiJyv1dyIx2QGj7x5A=;
        b=Jk+uZMZRyuO5E7XmUGr7nmAFa+HOJ2vclWY+0tu4zpn2/nsrVHtEHN0Qeas3qR6he0EHG+
        iabXTkXR0u7IbOO6gqt0IicSg2H8Y8OvSwtkpbA9nkrtYjnVoEJunqHV89D6ICC4wjyVUI
        4DgUjNLULekvub5isS6/HZ9iBJksSv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625502208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv+4kF1EjnZ4ZkFyTsjZqCItVDiJyv1dyIx2QGj7x5A=;
        b=yWKp67yLcI+A8Sd93PRE85SZhHaz49f3cw8jTQpMJGrYc0jjzDOzDm83IMNtLh7FS35Swd
        QbnQ21TU5Ud0r4BQ==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 6EF7DA3BA6;
        Mon,  5 Jul 2021 16:23:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B00D1F2CC9; Mon,  5 Jul 2021 18:23:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        Michael Stapelberg <stapelberg+linux@google.com>,
        <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/5] writeback: Rename domain_update_bandwidth()
Date:   Mon,  5 Jul 2021 18:23:18 +0200
Message-Id: <20210705162328.28366-4-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210705161610.19406-1-jack@suse.cz>
References: <20210705161610.19406-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; h=from:subject; bh=0nSUpWwlLNaV2zXsteeC9gDIgF5JqOxmX+5IXpCSxWI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg4zH2pgx1MM1pQm+exJQgkQO4+6tQ+oGbjgmG64Hw yrA+ioiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOMx9gAKCRCcnaoHP2RA2YktCA DEiA0n8tcFO9117fPR/3n+TwR7sGjnx37RTamWH3+UhLZ/KFneYWcFp+rETHWRYl0d+vMPvZRPkDhk VbFmMgKOB5jmg/7TmWKyIatgv3Cej8fuKQAPPydBD5JV0tR6bt2+uTS/TXJMOaWDroaWcKemVde9+w tBvmC+NaTFIeXmfBPv5Yhn8aJzUU8WT1WrppaYzCDgQfz8qKEJoO5vgCSib2HSCA5VPne1R/qn4WXn Sph6WrEy7XxUl1BOjh0nw+CToK8k8EKkmL+FIqv/LuvFOG+68vwzfVlXMU0FyKX9NZxcUj1nNKibxN nuP0KMfHEyGcspGeG6Yo04g+P3d9ww
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename domain_update_bandwidth() to domain_update_dirty_limit(). The
original name is a misnomer. The function has nothing to do with a
bandwidth, it updates dirty limits.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 6a99ddca95c0..95abae9eecaf 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1153,8 +1153,8 @@ static void update_dirty_limit(struct dirty_throttle_control *dtc)
 	dom->dirty_limit = limit;
 }
 
-static void domain_update_bandwidth(struct dirty_throttle_control *dtc,
-				    unsigned long now)
+static void domain_update_dirty_limit(struct dirty_throttle_control *dtc,
+				      unsigned long now)
 {
 	struct wb_domain *dom = dtc_dom(dtc);
 
@@ -1351,7 +1351,7 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 	written = percpu_counter_read(&wb->stat[WB_WRITTEN]);
 
 	if (update_ratelimit) {
-		domain_update_bandwidth(gdtc, now);
+		domain_update_dirty_limit(gdtc, now);
 		wb_update_dirty_ratelimit(gdtc, dirtied, elapsed);
 
 		/*
@@ -1359,7 +1359,7 @@ static void __wb_update_bandwidth(struct dirty_throttle_control *gdtc,
 		 * compiler has no way to figure that out.  Help it.
 		 */
 		if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) && mdtc) {
-			domain_update_bandwidth(mdtc, now);
+			domain_update_dirty_limit(mdtc, now);
 			wb_update_dirty_ratelimit(mdtc, dirtied, elapsed);
 		}
 	}
-- 
2.26.2

