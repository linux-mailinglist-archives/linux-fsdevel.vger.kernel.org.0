Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3029E1BD246
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgD2Cbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726399AbgD2Cbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:31:38 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079CC03C1AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 19:31:36 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id v6so1024905qkd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WsSQ4el//Y+73KDhxO8BeZ1dCh/HLj2RZlsq36dRgcM=;
        b=UN3MlWNwt95WQYace+eSywTdugcKroUN4Rd4NIhK+DFYyrDN8XkL//M3xB36wTSsv6
         CxaSgj15LnjkemeN+zYX8X989x6bk/g2OIjPhWWm2M28gV94gJklXPGiyptdOYM9EgTm
         8MzkmI90JUtviXhr+Au/1KgR8bR+pp3Xx+3fifJsP/iNaFjalBpc5/Rz1AA3Ym4StixO
         e9O7YpChBZnl+h0Qe6CjS6qzLHuDAegMNWajom+8Z7TPYlEU9sHbnK5iNXL0yOdeEUca
         DplJ4WvwsA074Kv3xkzisUWar4asmsgH5DVpf4KN7Z6mO8xSxAsUV8WmdLTQ/l6snGz3
         E7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WsSQ4el//Y+73KDhxO8BeZ1dCh/HLj2RZlsq36dRgcM=;
        b=PG/XfSbyEWjNSu4KQaw1shMng1dYyOoMkC7B7C3BtQGdHpiUfb8TPGw7fMoQJU52/Q
         K52OdhVcM3PXrUcnFYlWILnlD94Cj/YYEqXaG+UhSdTcumaMlsE+/cUBZ9dmbLLaLMut
         ThCNnoR5TgkKUR+Uu22B8NJo5//k5sPcPvHgk+4HfGtoVyCFMD5P+gNVH/FlKzc/QfWI
         NZChMQnResUDOHHxMVlICZ90YcGI+1dL797tfBOUcklLjU6xVSJOQTQ+x0LmlVWptDVv
         vIfGKlp0SUy0SrEnaxtD6WAh6b7zP4RjucwWTxctVYN7pOLKEahm18Mzuo9Ue2QRmPbr
         ngvw==
X-Gm-Message-State: AGi0PuaP0/Nzl5zG3QG84+LSthz2wcvj1R/rIHUEy+7mRbQzqcJc7nf0
        GJUK419NmacrKarSdMqrzzh7yEioyw==
X-Google-Smtp-Source: APiQypL+uTWlVZWQKpSDFQTh731+sLTLvg0x4UaDIiB+KECbx00T+FVEJZxwGuXSKvn0BGAlyzOjd/5Caw==
X-Received: by 2002:ad4:5a06:: with SMTP id ei6mr23544919qvb.70.1588127495938;
 Tue, 28 Apr 2020 19:31:35 -0700 (PDT)
Date:   Wed, 29 Apr 2020 04:31:04 +0200
Message-Id: <20200429023104.131925-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH] epoll: Fix UAF dentry name access in wakeup source setup
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        NeilBrown <neilb@suse.de>, "Rafael J . Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In ep_create_wakeup_source(), epi->ffd.file is some random file we're
watching with epoll, so it might well be renamed concurrently. And when a
file gets renamed, the buffer containing its name may be freed.

This can be reproduced by racing a task that keeps adding and removing
EPOLLWAKEUP epoll entries for a fifo with another task that keeps renaming
the fifo between two long names if you add an mdelay(200) call directly
before wakeup_source_register(); KASAN then complains:

BUG: KASAN: use-after-free in strlen+0xa/0x40
Read of size 1 at addr ffff888065fda990 by task wakemeup/2375
[...]
Call Trace:
[...]
 strlen+0xa/0x40
 kstrdup+0x1a/0x60
 wakeup_source_create+0x43/0xb0
 wakeup_source_register+0x13/0x60
 ep_create_wakeup_source+0x7f/0xf0
 do_epoll_ctl+0x13d0/0x1880
[...]
 __x64_sys_epoll_ctl+0xc3/0x110
[...]
Allocated by task 2376:
[...]
 __d_alloc+0x323/0x3c0
 d_alloc+0x30/0xf0
 __lookup_hash+0x61/0xc0
 do_renameat2+0x3fa/0x6d0
 __x64_sys_rename+0x3a/0x40
[...]
Freed by task 2379:
[...]
 kfree_rcu_work+0x9b/0x5d0
[...]

Backporting note: This patch depends on commit 49d31c2f389a ("dentry name
snapshots"). Maybe that one should also be backported as a dependency for
pre-v4.13? (Sorry, I wasn't sure how to properly express this as a "Fixes:"
tag.)

Cc: stable@vger.kernel.org
Fixes: 4d7e30d98939 ("epoll: Add a flag, EPOLLWAKEUP, to prevent suspend while epoll events are ready")
Signed-off-by: Jann Horn <jannh@google.com>
---
I'm guessing this will go through akpm's tree?

 fs/eventpoll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c596641a72b0..5052a41670479 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1450,7 +1450,7 @@ static int reverse_path_check(void)
 
 static int ep_create_wakeup_source(struct epitem *epi)
 {
-	const char *name;
+	struct name_snapshot name;
 	struct wakeup_source *ws;
 
 	if (!epi->ep->ws) {
@@ -1459,8 +1459,9 @@ static int ep_create_wakeup_source(struct epitem *epi)
 			return -ENOMEM;
 	}
 
-	name = epi->ffd.file->f_path.dentry->d_name.name;
-	ws = wakeup_source_register(NULL, name);
+	take_dentry_name_snapshot(&name, epi->ffd.file->f_path.dentry);
+	ws = wakeup_source_register(NULL, name.name.name);
+	release_dentry_name_snapshot(&name);
 
 	if (!ws)
 		return -ENOMEM;

base-commit: 96c9a7802af7d500a582d89a8b864584fe878c1b
-- 
2.26.2.303.gf8c07b1a785-goog

