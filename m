Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0C107A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 13:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfEALxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 07:53:38 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:59086 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfEALxi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 07:53:38 -0400
Received: from chromobil.fritz.box (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id DD74FC02FF6;
        Wed,  1 May 2019 11:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556711617;
        bh=IYMZSjCA6MPuaupKglfpjZ78VHU8AAfUySvLCkhkGuQ=;
        h=From:To:Subject:Date:From;
        b=rxPi7UY3VjIiAO2T3mmkiFDkaSkmJV+W5e3AkhLTOjOy0ym9EyJjyGdS21SyrWasa
         IGySWvAL2uF0F3r2tzqP6TnyebvQfSQIkxHNyEncbZ8hSipeX0adsYCBZIETZZfOoB
         Hj41O6bPdyDPQ9otM9Udun4Od6OCbVSsx1P/FF/Q=
From:   =?UTF-8?q?Stefan=20B=C3=BChler?= <source@stbuehler.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/1] [io_uring] req->error only used for iopoll
Date:   Wed,  1 May 2019 13:53:36 +0200
Message-Id: <20190501115336.13438-1-source@stbuehler.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to set it in io_poll_add; io_poll_complete doesn't use it to set
the result in the CQE.

Signed-off-by: Stefan Bühler <source@stbuehler.de>
---
 fs/io_uring.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6a480f04b0f3..44eb01188838 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -328,7 +328,7 @@ struct io_kiocb {
 #define REQ_F_SEQ_PREV		8	/* sequential with previous */
 #define REQ_F_PREPPED		16	/* prep already done */
 	u64			user_data;
-	u64			error;
+	u64			error;	/* iopoll result from callback */
 
 	struct work_struct	work;
 };
@@ -1426,7 +1426,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		spin_unlock(&poll->head->lock);
 	}
 	if (mask) { /* no async, we'd stolen it */
-		req->error = mangle_poll(mask);
 		ipt.error = 0;
 		io_poll_complete(ctx, req, mask);
 	}
-- 
2.20.1

