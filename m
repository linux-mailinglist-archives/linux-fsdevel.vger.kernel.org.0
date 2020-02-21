Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6353168208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBUPmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 10:42:22 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37495 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgBUPmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d1xiBHabr0cI0nVkv2W8qe7S3hdWOCkmluHZNS5Fdjo=;
        b=LQyBJ4J1NTEk80WtxtbOOS250EOJUSGrdk9/V/MFOxMHoZfQEx6h2JvLEaBI3gZpVcoAbv
        236SoT0QJolujSRa1JjScas/J52yCBQ6+X4+tZM2pk0s8EE5qIruTB+/11B0NBdQIRn6gu
        iaTr/DHwUpoEMd6Le9iBV6evEPfcxKo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-cYxCRCb1MXyGsfs_ymV5DQ-1; Fri, 21 Feb 2020 10:42:19 -0500
X-MC-Unique: cYxCRCb1MXyGsfs_ymV5DQ-1
Received: by mail-wr1-f72.google.com with SMTP id r1so1176640wrc.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 07:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d1xiBHabr0cI0nVkv2W8qe7S3hdWOCkmluHZNS5Fdjo=;
        b=n8DTFMcx0oCnqjvAkkqz/Tg8xS3LZ40m56UVW3B0/7pO0hJ39Pa5m1X4Mo9c0hcLGH
         awnXixzOJKpGRorzbxwxZXYaU//66UTAVSGDG2pUjWuYzNmAAbqMptTm/tYimUWw5WNM
         hm8YLaFRUxPc+VVoNqb1gqZHOoGLQi/jT7Bkp+w7/pDED1rTygyQXw2tx1hEaEAQrTLV
         WdVFemVH2RqInoFwjJR59WdHpVdrJjrkgWONdrNEAeWsIPIHxWgqabo7XhCwPD1FPE8+
         6QIddFhJD7q84/d6QDl5x/y5D7QzRBgTut5uiEKlJVgbJfrgustUeyhmyL3yrqIokdFS
         4p4A==
X-Gm-Message-State: APjAAAVfa/MhGSDZzIWt/u3ca2hqnFJllqXDT2GQ4MfRsLmyIOhNMhbi
        HEGDvggE6dGJumoYw28nPjTaXxvVnw4wMVRmzjjPnFCBmKJhBDv1bcwD4SNOs0xGbuaKW6RZIiH
        iwQpv2AaGo1glmQCOR5Ro50A8Hw==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4665158wmk.34.1582299738380;
        Fri, 21 Feb 2020 07:42:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzSWhT4n2jDvp8FWxa5PtF0QnBD+5CXqoCnpF/WyJoVcrZZSoX+kB/LMcPcy2QzVI9BPmha7Q==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4665132wmk.34.1582299738067;
        Fri, 21 Feb 2020 07:42:18 -0800 (PST)
Received: from steredhat.redhat.com (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id c9sm4238078wme.41.2020.02.21.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:42:17 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>, io-uring@vger.kernel.org
Subject: [PATCH] io_uring: prevent sq_thread from spinning when it should stop
Date:   Fri, 21 Feb 2020 16:42:16 +0100
Message-Id: <20200221154216.206367-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch drops 'cur_mm' before calling cond_resched(), to prevent
the sq_thread from spinning even when the user process is finished.

Before this patch, if the user process ended without closing the
io_uring fd, the sq_thread continues to spin until the
'sq_thread_idle' timeout ends.

In the worst case where the 'sq_thread_idle' parameter is bigger than
INT_MAX, the sq_thread will spin forever.

Fixes: 6c271ce2f1d5 ("io_uring: add submission polling")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Hi Jens,
I'm also sending a test to liburing for this case.

Cheers,
Stefano
---
 fs/io_uring.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5a826017ebb8..f902f77964ef 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -5138,6 +5138,18 @@ static int io_sq_thread(void *data)
 		 * to enter the kernel to reap and flush events.
 		 */
 		if (!to_submit || ret == -EBUSY) {
+			/*
+			 * Drop cur_mm before scheduling, we can't hold it for
+			 * long periods (or over schedule()). Do this before
+			 * adding ourselves to the waitqueue, as the unuse/drop
+			 * may sleep.
+			 */
+			if (cur_mm) {
+				unuse_mm(cur_mm);
+				mmput(cur_mm);
+				cur_mm = NULL;
+			}
+
 			/*
 			 * We're polling. If we're within the defined idle
 			 * period, then let us spin without work before going
@@ -5152,18 +5164,6 @@ static int io_sq_thread(void *data)
 				continue;
 			}
 
-			/*
-			 * Drop cur_mm before scheduling, we can't hold it for
-			 * long periods (or over schedule()). Do this before
-			 * adding ourselves to the waitqueue, as the unuse/drop
-			 * may sleep.
-			 */
-			if (cur_mm) {
-				unuse_mm(cur_mm);
-				mmput(cur_mm);
-				cur_mm = NULL;
-			}
-
 			prepare_to_wait(&ctx->sqo_wait, &wait,
 						TASK_INTERRUPTIBLE);
 
-- 
2.24.1

