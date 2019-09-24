Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE3D0BCA30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441351AbfIXO1Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 10:27:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38761 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437260AbfIXO1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 10:27:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so1428330pgi.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 07:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiNQUQrqa3fbXUV8cnQlzIVFySFIQp5N/0FZBBuHxEA=;
        b=gD4dPEuKD/+LElxHZN8h68oXFPDiKdW+AhlUhmY+zyv9fjYTukj04Zu3uqJl7KJgnp
         Xv3sNVW1jea85A59x2jYkv6l5D7J8owGhsX2/ACGAYS5umfnhJKS5Om6LhNO0FVKfaY5
         OZrdVHrBy3Rk8trpBCZy2yFR7MRvtWDgKiWJ0/Zxhz5VVuPX5pWqhxCXYyW8BoiVYoqO
         7y9QJwChBPy+X2CbA+1Y8MfjcbqUsHuO7xQdOqWERxJ8Z+jdkCjEjZJWHsOphJ/OHQJW
         sLpYkSdQFvc1Wu+2L5DT2zWBbXDolKYIbAClTxi5TTvOs1ThEJ/mELP6M8Q2Khcy2HT8
         vxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LiNQUQrqa3fbXUV8cnQlzIVFySFIQp5N/0FZBBuHxEA=;
        b=lxmuTwZmC+B5pOVe7mY+QvuD3f7sEzcuVziowNoh+CeJL+dEeGQBDyMtY3Hz/6VWrY
         jGGSXF71qOUXe/mdSC087Y1fV+27jeka04YlMo0yY3llsRD1UydpZM8pUF7+kQ0D4UBY
         pOeFy7zsZpIrM3Kv4eZnOtDDuEdOmznC5MnbDkrHu60H/gm1EXKLbrtSx5mYvlNJRnaS
         mPHsKiaWufXI+Qy7hjcO7CWoSOfTstzZfgQcw0Cb73YMyIgNIsVAQTUvw6mracg4uOtR
         klT6IBx0F374irI3zcBt6JQxEEt4dlTh5i7RJmGoYZ+R7o6MFWHZii27lPeUEyfwUsek
         /dSQ==
X-Gm-Message-State: APjAAAVYmN0HfCDGnvJOneatIjmhqR1GLrgXuamsmJY61FdypeGcAe09
        JyIjCoOX4SF/iAa7fQVBiEMDKCG+SdkTtgVGEZs=
X-Google-Smtp-Source: APXvYqwZ6GcKAx6HHF73Ivr+bSuowV6itiK/y+AW0WRGHaZHXfYhtau0WjQWtjj0Wu9DObDwpaEvjQ==
X-Received: by 2002:a63:e907:: with SMTP id i7mr3403513pgh.84.1569335234815;
        Tue, 24 Sep 2019 07:27:14 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id h14sm2449039pfo.15.2019.09.24.07.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 07:27:13 -0700 (PDT)
From:   hev <r@hev.cc>
To:     linux-fsdevel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3] fs/epoll: Remove unnecessary wakeups of nested epoll that in ET mode
Date:   Tue, 24 Sep 2019 22:26:54 +0800
Message-Id: <20190924142654.5742-1-r@hev.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Heiher <r@hev.cc>

Take the case where we have:

        t0
         | (ew)
        e0
         | (et)
        e1
         | (lt)
        s0

t0: thread 0
e0: epoll fd 0
e1: epoll fd 1
s0: socket fd 0
ew: epoll_wait
et: edge-trigger
lt: level-trigger

When s0 fires an event, e1 catches the event, and then e0 catches an event from
e1. After this, There is a thread t0 do epoll_wait() many times on e0, it should
only get one event in total, because e1 is a dded to e0 in edge-triggered mode.

This patch only allows wakeup(&ep->poll_wait) in ep_scan_ready_list if one of
the conditions is met:

 1. depth == 0.
 2. There have event is added to ep->ovflist during processing.

Test code:
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>

 int main(int argc, char *argv[])
 {
 	int sfd[2];
 	int efd[2];
 	struct epoll_event e;

 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
 		goto out;

 	efd[0] = epoll_create(1);
 	if (efd[0] < 0)
 		goto out;

 	efd[1] = epoll_create(1);
 	if (efd[1] < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
 		goto out;

 	e.events = EPOLLIN | EPOLLET;
 	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
 		goto out;

 	if (write(sfd[1], "w", 1) != 1)
 		goto out;

 	if (epoll_wait(efd[0], &e, 1, 0) != 1)
 		goto out;

 	if (epoll_wait(efd[0], &e, 1, 0) != 0)
 		goto out;

 	close(efd[0]);
 	close(efd[1]);
 	close(sfd[0]);
 	close(sfd[1]);

 	return 0;

 out:
 	return -1;
 }

More tests:
 https://github.com/heiher/epoll-wakeup

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
 fs/eventpoll.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..a05249400901 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -685,6 +685,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	if (!ep_locked)
 		mutex_lock_nested(&ep->mtx, depth);
 
+	if (!depth || list_empty_careful(&ep->rdllist))
+		pwake++;
+
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -704,12 +707,21 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	res = (*sproc)(ep, &txlist, priv);
 
 	write_lock_irq(&ep->lock);
+	nepi = READ_ONCE(ep->ovflist);
+	/*
+	 * We only need to wakeup nested epoll fds if something has been queued
+	 * to the overflow list, since the ep_poll() traverses the rdllist
+	 * during recursive poll and thus events on the overflow list may not be
+	 * visible yet.
+	 */
+	if (nepi != NULL)
+		pwake++;
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
 	 * We re-insert them inside the main ready-list here.
 	 */
-	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
+	for (; (epi = nepi) != NULL;
 	     nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
 		/*
 		 * We need to check if the item is already in the list.
@@ -755,7 +767,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		mutex_unlock(&ep->mtx);
 
 	/* We have to call this outside the lock */
-	if (pwake)
+	if (pwake == 2)
 		ep_poll_safewake(&ep->poll_wait);
 
 	return res;
-- 
2.23.0

