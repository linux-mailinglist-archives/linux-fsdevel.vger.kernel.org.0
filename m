Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B518823D150
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 21:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHET6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 15:58:38 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:60586 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgHEQmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:19 -0400
X-Greylist: delayed 4094 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 12:42:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QTs20Y2uQb75JxoibU
        08BQmlRKaNqO3ksWubKbOLAMk=; b=XdEhO1lYn70aHJn7bKkRt5gQFR/zOndikH
        dnrY/5tS8TJBqf9VAde3cKoSDLEvLpG2QoYTEfmDpJnSOymC7FfHdKzJU3bmYTC1
        FVefq/mXxXuqR1p9+4SoFxen0bHthfSqJ/4Nf0mtcSprnTcNwnSxd4GuWRoMKY35
        /2fGAmJjQ=
Received: from 192.168.137.129 (unknown [112.10.84.202])
        by smtp7 (Coremail) with SMTP id DsmowADXTEK3tSpfUXVBIA--.57772S3;
        Wed, 05 Aug 2020 21:35:53 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: use wait_for_completion_io() when waiting for completion of io
Date:   Wed,  5 Aug 2020 09:35:51 -0400
Message-Id: <1596634551-27526-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowADXTEK3tSpfUXVBIA--.57772S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur1xKF48Ww1rtF1DCw4rKrg_yoWkCrc_Gr
        18tF18uayUXFWDKw1jkrZ3t3s0939rC3Z5WanxWF97Gay3GasxCr1Dtwn0vFySg342qF15
        Wws8CFW7trnrCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0loGPUUUUU==
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbi5hl3pFpD-Dx3VQAAsX
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When waiting for the completion of io, we need account iowait time. As
wait_for_completion() calls schedule_timeout(), which doesn't account
iowait time. While wait_for_completion_io() calls io_schedule_timeout(),
which will account iowait time.

So using wait_for_completion_io() instead of wait_for_completion()
when waiting for completion of io before exit_aio and io_destroy.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/aio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 91e7cc4..498b8a0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -892,7 +892,7 @@ void exit_aio(struct mm_struct *mm)
 
 	if (!atomic_sub_and_test(skipped, &wait.count)) {
 		/* Wait until all IO for the context are done. */
-		wait_for_completion(&wait.comp);
+		wait_for_completion_io(&wait.comp);
 	}
 
 	RCU_INIT_POINTER(mm->ioctx_table, NULL);
@@ -1400,7 +1400,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 		 * is destroyed.
 		 */
 		if (!ret)
-			wait_for_completion(&wait.comp);
+			wait_for_completion_io(&wait.comp);
 
 		return ret;
 	}
-- 
1.8.3.1

