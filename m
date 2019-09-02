Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF750A4ECC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfIBFVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 01:21:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41727 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfIBFVq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:21:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id b13so1705404pfo.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2019 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNHOWN+0Coztu38fB5yaHQpPDHparb+VQPnzTlZJ0JE=;
        b=qGL5ZUYGDLtShp6IGgeoveuGqiflKyRIhYWTwSBVGkQ43dxoV3iFZnW5QpB5+Hlbz5
         ICIVLCdmC8l3ZuZX8aGB3liCE2ieHjV6JDw0I79Z3rvqNjUiT/UaMYm8k+i4teCYOSg/
         lbp9WDH3hamYhncb7TgQhCKbiWZXh7LFKItDjQMUyV/UwUxXTSC+ykctPkZXBumrUmMI
         K4g3fcZHPqbgtiVqXxextA2WLFxgGz3zhaDYiUzgbqKNcAZus7gnXqyJFC0m131RiG8G
         6eL2ypB8E5zAh+1ahaEzu4jBmB5FXpWMaWpPENWnxmKtRwNmuvbLEOC/XDEMrxDApxan
         0NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WNHOWN+0Coztu38fB5yaHQpPDHparb+VQPnzTlZJ0JE=;
        b=dGDZTTY3Nov++mm0OESZurJKv60MiTYn3mzwKdQQLznkgsrJkKE/gVKX9F/DYh0Gh0
         JgpcV3H/Ol/JnjS6w98AEFXAU2+TFGJ2yE2JHgO0elEag0SICZk0schkyUX9//hnU5PL
         +/CzOY+NoKcER1s/2oUWUmsHQ9IK9IRwymuwRtg8OhCAEwwi0+r7PKhOG7A1Je4JT28a
         WNTjSCoADfSa7Y89oKjSegk3LxN9fKXphCIOsxBydzySIoR9wYlGM+Th+cB/23wrNib9
         ebswvKE2FSMvyk5makpHBybqtlXqhtVf+ZxNKwLayncwUOOvFhr3Q/3YIpsyqOqEnAbz
         rthQ==
X-Gm-Message-State: APjAAAWesvaLDTrLYUB+wRmxiXmcXVAUUMsypd4CGmE8jYUc1uXNAi8+
        3/dqS44DegTbWjXiGzlT0KSMIicVmBVqNw==
X-Google-Smtp-Source: APXvYqzSc8PJTNOasSxVo2SAiBObjLCkzFGQxDy5LaUIXeaU2EEHSvJ7j/aHYhbPwwPar2MHcMsIEg==
X-Received: by 2002:a65:6458:: with SMTP id s24mr23405467pgv.158.1567401705371;
        Sun, 01 Sep 2019 22:21:45 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id w207sm14636242pff.93.2019.09.01.22.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 22:21:44 -0700 (PDT)
From:   hev <r@hev.cc>
To:     linux-fsdevel@vger.kernel.org
Cc:     e@80x24.org, Heiher <r@hev.cc>, Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] fs/epoll: fix the edge-triggered mode for nested epoll
Date:   Mon,  2 Sep 2019 13:20:34 +0800
Message-Id: <20190902052034.16423-1-r@hev.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Heiher <r@hev.cc>

The structure of event pools:
 efd[1]: { efd[2] (EPOLLIN) }        efd[0]: { efd[2] (EPOLLIN | EPOLLET) }
               |                                   |
               +-----------------+-----------------+
                                 |
                                 v
                             efd[2]: { sfd[0] (EPOLLIN) }

When sfd[0] to be readable:
 * the epoll_wait(efd[0], ..., 0) should return efd[2]'s events on first call,
   and returns 0 on next calls, because efd[2] is added in edge-triggered mode.
 * the epoll_wait(efd[1], ..., 0) should returns efd[2]'s events on every calls
   until efd[2] is not readable (epoll_wait(efd[2], ...) => 0), because efd[1]
   is added in level-triggered mode.
 * the epoll_wait(efd[2], ..., 0) should returns sfd[0]'s events on every calls
   until sfd[0] is not readable (read(sfd[0], ...) => EAGAIN), because sfd[0]
   is added in level-triggered mode.

Test code:
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>

 int main(int argc, char *argv[])
 {
 	int sfd[2];
 	int efd[3];
 	int nfds;
 	struct epoll_event e;

 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
 		goto out;

 	efd[0] = epoll_create(1);
 	if (efd[0] < 0)
 		goto out;

 	efd[1] = epoll_create(1);
 	if (efd[1] < 0)
 		goto out;

 	efd[2] = epoll_create(1);
 	if (efd[2] < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[2], EPOLL_CTL_ADD, sfd[0], &e) < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, efd[2], &e) < 0)
 		goto out;

 	e.events = EPOLLIN | EPOLLET;
 	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[2], &e) < 0)
 		goto out;

 	if (write(sfd[1], "w", 1) != 1)
 		goto out;

 	nfds = epoll_wait(efd[0], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[0], &e, 1, 0);
 	if (nfds != 0)
 		goto out;

 	nfds = epoll_wait(efd[1], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[1], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[2], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	nfds = epoll_wait(efd[2], &e, 1, 0);
 	if (nfds != 1)
 		goto out;

 	close(efd[2]);
 	close(efd[1]);
 	close(efd[0]);
 	close(sfd[0]);
 	close(sfd[1]);

 	printf("PASS\n");
 	return 0;

 out:
 	printf("FAIL\n");
 	return -1;
 }

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davide Libenzi <davidel@xmailserver.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Wong <e@80x24.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: hev <r@hev.cc>
---
 fs/eventpoll.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d7f1f5011fac..a44cb27c636c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -672,6 +672,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 {
 	__poll_t res;
 	int pwake = 0;
+	int nwake = 0;
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
@@ -685,6 +686,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	if (!ep_locked)
 		mutex_lock_nested(&ep->mtx, depth);
 
+	if (!depth || list_empty(&ep->rdllist))
+		nwake = 1;
+
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -739,7 +743,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	list_splice(&txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
 
-	if (!list_empty(&ep->rdllist)) {
+	if (nwake && !list_empty(&ep->rdllist)) {
 		/*
 		 * Wake up (if active) both the eventpoll wait list and
 		 * the ->poll() wait list (delayed after we release the lock).
-- 
2.23.0

