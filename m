Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1350311854
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBFCfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBFCcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28691C033274;
        Fri,  5 Feb 2021 17:25:47 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v24so12824349lfr.7;
        Fri, 05 Feb 2021 17:25:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OAQ3yX80CT+PWZsMkbbsby+9FcIwY7MvIPOlo3nK144=;
        b=jXKpZcpWWst4BmGxxnTV2rntTCu+YReE3ptmp4wsVMDmPjq3mdmbIOqNiBfvP1F40t
         6CO8122CaHFMkRgcFpTnC+0KR8rnA2pzthxZ6FbKXVxxwAue3EDxtt6pYcGoiNJnXt0z
         Ajo5EvlZJb2gNk2pjDvbH93qMT4cFshCQlRTVOAKGflDBJfioBGGOzvgVYwuxyK9b5lH
         a31SmEIawjDVSvRJkH7RnOKUlNfT+GN6y/YSpMvop4GGDIyL/ug1OA8Zx7K0wNeTWgiZ
         3uBY+w5UZNko9rf4jiFzf5+NEnhpvjdqefgaCklHxTXU2mN2t7JvdQ3dSnb94uvtdg/b
         OHjg==
X-Gm-Message-State: AOAM533BBrprVhZWmcHg5m7jnQjZoZA4MVQszPFpp7O8aKKaAed3WXeF
        T3jNZAd5mghNBBKip1+JqcMdKIWTelk=
X-Google-Smtp-Source: ABdhPJwSrxaDHvFQ2KqpN0/Iz/1gmfklhTKJ65S7WGsWwCRT1efpQ4IcZxhDzsPPHBKdwAysHD51uw==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr7772326wrq.196.1612570429573;
        Fri, 05 Feb 2021 16:13:49 -0800 (PST)
Received: from msft-t490s.teknoraver.net (net-37-182-2-234.cust.vodafonedsl.it. [37.182.2.234])
        by smtp.gmail.com with ESMTPSA id d3sm14566390wrp.79.2021.02.05.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:13:48 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Luca Boccassi <bluca@debian.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 5/5] loop: increment sequence number
Date:   Sat,  6 Feb 2021 01:09:03 +0100
Message-Id: <20210206000903.215028-6-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210206000903.215028-1-mcroce@linux.microsoft.com>
References: <20210206000903.215028-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

On a very loaded system, if there are many events queued up from multiple
attach/detach cycles, it's impossible to match them up with the
LOOP_CONFIGURE or LOOP_SET_FD call, since we don't know where the position
of our own association in the queue is[1].
Not even an empty uevent queue is a reliable indication that we already
received the uevent we were waiting for, since with multi-partition block
devices each partition's event is queued asynchronously and might be
delivered later.

Increment the disk sequence number when setting or changing the backing
file, so the userspace knows which backing file generated the event.

[1] https://github.com/systemd/systemd/issues/17469#issuecomment-762919781

Signed-off-by: Matteo Croce <mcroce@microsoft.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e5ff328f0917..c12b3faae3ab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -734,6 +734,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 		goto out_err;
 
 	/* and ... switch */
+	inc_diskseq(lo->lo_disk);
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
 	lo->lo_backing_file = file;
@@ -1122,6 +1123,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (error)
 		goto out_unlock;
 
+	inc_diskseq(lo->lo_disk);
+
 	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
-- 
2.29.2

