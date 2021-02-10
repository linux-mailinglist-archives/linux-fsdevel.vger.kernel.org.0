Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C96316CFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 18:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhBJRjX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 12:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhBJRi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:38:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F076AC061574;
        Wed, 10 Feb 2021 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u1JoIW6LvBTUe9TCby8qPaMQDWbpGRBbF1kUIX9zmbE=; b=mDYxJtmkn/FZeISFLmyL+5iuSq
        6UbfRhQ41CXqOiAfcASHKYfjqtRdh9pF3TILKWYtx207ZOsTQGvEgvV50TGcFwcDW0IOhIdE2g6+U
        KPIu0S4xSc5TwYUb07Ds9lvuCqtRU4GJZQdd0Wy82ZRZoXRz+P5jNbl3bwkHvpGOGrlQG9tBUvAd9
        DgPMamiCCDNN0oEnTSyTYPBwo6e77GVR0AQCvunY0dH3Sn+GEjrGL98C4RTbRtZfMS3rEjN8e8LLQ
        TYThVcKi3Mkd8E82NMhB7QqLpt7UOy6AEVXvkgECLmkD/tKBKD9r/znkpasPTzr1Fq1jSPNT0OaeE
        gCzukPjA==;
Received: from [2601:1c0:6280:3f0::cf3b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9tQu-0005tR-RH; Wed, 10 Feb 2021 17:37:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH -next] fs: io_uring: build when CONFIG_NET is disabled
Date:   Wed, 10 Feb 2021 09:37:40 -0800
Message-Id: <20210210173740.22328-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix build errors when CONFIG_NET is not enabled.

Fixes: b268c951abf8 ("io_uring: don't propagate io_comp_state")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/io_uring.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- linux-next-20210210.orig/fs/io_uring.c
+++ linux-next-20210210/fs/io_uring.c
@@ -5145,14 +5145,12 @@ static int io_sendmsg_prep(struct io_kio
 	return -EOPNOTSUPP;
 }
 
-static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags,
-		      struct io_comp_state *cs)
+static int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
 
-static int io_send(struct io_kiocb *req, unsigned int issue_flags,
-		   struct io_comp_state *cs)
+static int io_send(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -5163,14 +5161,12 @@ static int io_recvmsg_prep(struct io_kio
 	return -EOPNOTSUPP;
 }
 
-static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags,
-		      struct io_comp_state *cs)
+static int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
 
-static int io_recv(struct io_kiocb *req, unsigned int issue_flags,
-		   struct io_comp_state *cs)
+static int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -5180,8 +5176,7 @@ static int io_accept_prep(struct io_kioc
 	return -EOPNOTSUPP;
 }
 
-static int io_accept(struct io_kiocb *req, unsigned int issue_flags,
-		     struct io_comp_state *cs)
+static int io_accept(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
@@ -5191,8 +5186,7 @@ static int io_connect_prep(struct io_kio
 	return -EOPNOTSUPP;
 }
 
-static int io_connect(struct io_kiocb *req, unsigned int issue_flags,
-		      struct io_comp_state *cs)
+static int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 {
 	return -EOPNOTSUPP;
 }
