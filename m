Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F50F36E3D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 06:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhD2DqU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 23:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236938AbhD2DqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 23:46:19 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97EAC06138B;
        Wed, 28 Apr 2021 20:45:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lr7so15764488pjb.2;
        Wed, 28 Apr 2021 20:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n6WkvByEe9jHaNKcirxDjwO3RlSDD2tbJyA9X2kwaTQ=;
        b=bfPcKpaJTct/b2KwfgS8IybVcnm9hhayC5Pnp6OLWSF5gkgA8MquRdYGp74PdaqoWY
         pfsoqKZe8B13t2VyFkBNxF3U0QO/CMO24ivr8ZUcv9Bk5ME9QqdCj9WW+azt44dzwHNh
         9v6S6S5ZHG2zW3JRKkXdWdqBmNlJpUENkpsTrAXtGN4EBWbNFJRl9nWHCWPLrMOlB6V2
         DvJgsIgdevB674C7FyBgMCc3X3aq9sX1jj0WMhFION1Yqluq13ci8RuQbZmUcjrj8HAz
         KcE37M6cH1+vGKzlD+AHonwhRWJIUx/1JLdrQQFaxU3m/wvKJTDWrYPboYv9jOHWvgpZ
         /2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n6WkvByEe9jHaNKcirxDjwO3RlSDD2tbJyA9X2kwaTQ=;
        b=MO1BMIlk+XNv4Dk/gtJUK//EfmEGF9JrY2SoajcuXwr5yJxSX7C8Yp5XXUZC0lvFec
         I0/9ZEOVeFKq5qeKLWT3N3c3goz7WmWF/LwzX67i84dyOYPx13m5KAPBuGQI4NzNFArN
         LZX5/yGaK9tw238ky2R6zlaDwcCtYXXY7UB0/RdmTDmMZbBHAKY+wiwjwIkJTaUiN3ey
         9V6+XFKb/Eg2pl/2ev1ueXYc8SLhlkDsuCdC7vomZpmmb4RfHBT864Xs6ATS7OgEROFu
         dhJEBePDfUT6YnRB1BSVhR7TNOd9tuckI9I6MwVw/6R6gQKfdW+6PfbV1yjfHpPHyEzO
         6YDQ==
X-Gm-Message-State: AOAM533s1IB45T4TdjoKMXOblWYJfybmpM5U+s7I1sFpuKySFi2jvUaG
        RopxV4UwWSYjCIcHLMt1yew=
X-Google-Smtp-Source: ABdhPJyYGwGA8oBreArmkmwClyXIRL01ti98rbAHl2WUaNM56XVWv7IdnC8nmsb/0qMNVtwyzpMjEw==
X-Received: by 2002:a17:90a:9405:: with SMTP id r5mr7683239pjo.139.1619667932282;
        Wed, 28 Apr 2021 20:45:32 -0700 (PDT)
Received: from localhost (natp-s01-129-78-56-229.gw.usyd.edu.au. [129.78.56.229])
        by smtp.gmail.com with ESMTPSA id x18sm988009pfp.57.2021.04.28.20.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 20:45:31 -0700 (PDT)
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     trivial@kernel.org, Baptiste Lepers <baptiste.lepers@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Tejun Heo <htejun@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] poll: Ignore benign race on pwd->triggered
Date:   Thu, 29 Apr 2021 13:44:11 +1000
Message-Id: <20210429034411.6379-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark data races to pwd->triggered as benign using READ_ONCE and
WRITE_ONCE. These accesses are expected to be racy per comment.

This patch is part of a series of patches aiming at reducing the number
of benign races reported by KCSAN in order to focus future debugging
effort on harmful races.

Reported-by: syzbot+9b3fb64bcc8c1d807595@syzkaller.appspotmail.com
Fixes: 5f820f648c92a ("poll: allow f_op->poll to sleep")
Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 945896d0ac9e..e71b4d1a2606 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -194,7 +194,7 @@ static int __pollwake(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 	 * and is paired with smp_store_mb() in poll_schedule_timeout.
 	 */
 	smp_wmb();
-	pwq->triggered = 1;
+	WRITE_ONCE(pwq->triggered, 1);
 
 	/*
 	 * Perform the default wake up operation using a dummy
@@ -239,7 +239,7 @@ static int poll_schedule_timeout(struct poll_wqueues *pwq, int state,
 	int rc = -EINTR;
 
 	set_current_state(state);
-	if (!pwq->triggered)
+	if (!READ_ONCE(pwq->triggered))
 		rc = schedule_hrtimeout_range(expires, slack, HRTIMER_MODE_ABS);
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1

