Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5DBD638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 03:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633691AbfIYB4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 21:56:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42024 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633689AbfIYB4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 21:56:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id i185so3477294oif.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2019 18:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XF6jmOvtyrBMaqdt7hPfORfmiOBGH0e252B9Q5r9KVc=;
        b=sn99UHj6vmUiCfF9Qt2YuozEa4TDgMGJD/uVFjfTtYh4ZBdfL+L3vsmeWsIyb0s/Zk
         Fol14MrBW5JV9dZoUnG9YTyoj336NdpOjNiZ7wHC7B1QUWn++yotMppCp6AWKoE916/W
         mmJHjzktF6EdtXLr/Mlm8iBJ4rnweuQcgISHw6UfuucYKLhwF2KQAi/6e4qDOVnWLW5y
         6iyyVyot/AsDAl0rNPuMXe395vmBETZnnMu0dsM0DvDI2wnlg84IlRLkLvje45q8FA5X
         TpcM2ecwMpX/fE3CLVZUTGw8miu8l+zU6PcIoa4jikL9XMmSmMCE2QdzQJR8jpnQl+rl
         3eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XF6jmOvtyrBMaqdt7hPfORfmiOBGH0e252B9Q5r9KVc=;
        b=FxDuNWIfZzu9sFp6hgy+onuQ389LmNCSNrywfXccsodB63GuTrmaSfvut4vvPFjiim
         wZu5BB0KFaThOMPqxGmecm3D17JJCvpB/BKCuO9ufc5GYp5q4mexR+1UYNvnAEMTsncL
         4P3twg5tMRkcqrqi2+H3tVzrE+pYTPT7jCXUuH0RZwsT32skZ/oT2z9bbpRFw2Sq6oF8
         0L7l3tScbfM0MGakbqAUmWg4/U4lYsLK2QcQfyQSUwdSpSQy0n+fqHdjDD7UIdivjHr6
         5o08sgukJaLRFROPtdEXXWeWc2Uzvvw3QMZZdWzOhyZ97v384BaMjzZ+/R9OunXD4HJH
         FRoQ==
X-Gm-Message-State: APjAAAXx7qNroulbtO8AZvXuu9hr1MOy6grft3ceIV8oDY4BzddN/ALt
        7CZOMnrrdbqYq9zNsbPKUtiQ17/FdSPOt9drLU4=
X-Google-Smtp-Source: APXvYqwGBbXTEYK5C2Hbguwh+VdqRHGF60tBAQvGahQtP0nrTkCZgjD6jITalyFPVcrsj+IFq2iRNA==
X-Received: by 2002:a05:6808:302:: with SMTP id i2mr2804825oie.176.1569376581500;
        Tue, 24 Sep 2019 18:56:21 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id d69sm1190658oig.32.2019.09.24.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 18:56:20 -0700 (PDT)
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
Subject: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested epoll that in ET mode
Date:   Wed, 25 Sep 2019 09:56:03 +0800
Message-Id: <20190925015603.10939-1-r@hev.cc>
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

We only need to wakeup nested epoll fds if something has been queued to the
overflow list, since the ep_poll() traverses the rdllist during recursive poll
and thus events on the overflow list may not be visible yet.

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
 fs/eventpoll.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..a0c07f6653c6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -704,12 +704,21 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
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
@@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		mutex_unlock(&ep->mtx);
 
 	/* We have to call this outside the lock */
-	if (pwake)
+	if (pwake == 2)
 		ep_poll_safewake(&ep->poll_wait);
 
 	return res;
-- 
2.23.0

