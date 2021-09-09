Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14F7405841
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbhIINvY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358713AbhIINte (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:49:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE66C04E21B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Sep 2021 04:56:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 196-20020a1c04cd000000b002fa489ffe1fso1246096wme.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Sep 2021 04:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUXPm1uPQN/eRKV644ILtuI0QJYUo/nsZjrGrLTi8OE=;
        b=LppSe0uMFV1IGlyGrhoK1onQeB4vi+iR0TVpJKeVzCy0tD7I55/mk4eoDrWs09c2MT
         yEf/Gru02CpWYhLl3uICcoZjp/sBhZc4RgFjBLLMcw1toDNjEWJX+FzJs/TBRHWjKu3U
         PEytg3Jl0SPgQcsZx61+nVCVUmh9qAwIGTANCwLx+7lHAGIoLqnrZjNkNbYxj5wih6XI
         LDn1RyZ30VZpZ1H9pX/kiXzd5P9ztlVnhVu/Kq0dC9PTGRW1cDTRvduv5YfYnGK5nlPp
         gQfKrNRlF2yU1t959p5IVyS15qJWGhPaj5hwH8EtzXGncq/BNDnk6VEgIOfh87scgnSM
         ThRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUXPm1uPQN/eRKV644ILtuI0QJYUo/nsZjrGrLTi8OE=;
        b=JcLFaZzDH54VztXMSw4FTenxb+JO/pzXgXxH3JlBZQWRZx5josi5h9wmbbgRta33Sl
         jnFkcD6tQy1aP6SThoLH/DYRGwqgOgHlgXl/mlDV1hsw074xGB3k09XUt9I4UJNpxejZ
         Dh6y96XBFd3BtRltwQpnA23UGrFHedmWXicydmV60GqK6i9/p2ZmwcIEAjjJssqgPD3d
         g2GktwtKMYj41bhP9y93FVf/FbMWIUALezrCGC4hG6JvNdWzSZMKx3FdRBczVosyB7u8
         XVdz+vOIfAV1WHQ/J7MRk/XV5VOCc6iRqip81dDAvgzEBcITh1GoW3JSNtDMMPVjH5uB
         obVg==
X-Gm-Message-State: AOAM530voVbJsY4bAKsbxVMt2hXAQUz0E8gnAFT93JaRlToqgVbZSUMm
        Axp+fnInzF1r2yWvyE3wRPQ=
X-Google-Smtp-Source: ABdhPJzcwMK5ECEbGDna13GSxcFfeSUG67k/NpGvlE7onXcJNOsUQM5m2nsBvloiL6ZruOnyLNhHEA==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr2506178wmb.139.1631188604042;
        Thu, 09 Sep 2021 04:56:44 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id s24sm1340753wmh.34.2021.09.09.04.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 04:56:43 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, Murphy Zhou <jencce.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: fix sb_connectors leak
Date:   Thu,  9 Sep 2021 14:56:34 +0300
Message-Id: <20210909115634.1015564-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix a leak in s_fsnotify_connectors counter in case of a race between
concurrent add of new fsnotify mark to an object.

The task that lost the race fails to drop the counter before freeing
the unused connector.

Following umount() hangs in fsnotify_sb_delete()/wait_var_event(),
because s_fsnotify_connectors never drops to zero.

Fixes: ec44610fe2b8 ("fsnotify: count all objects with attached connectors")
Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Linus,

Jan is on vacation for the duration of the merge window and he
asked me to step in for him in case something went wrong, so
of course something went wrong :)

Please apply this fix to a regression in code that was merged for
v5.15-rc1.

I think you will find the fix is obvious and I also verified the
fix with the reproducer provided by Murphy.

For context (and for bragging), the merged code improves the fast
path for workloads that do not involve fsnotify and has reported to
improve performance by 5-10% for some general workloads [1][2].

Thanks,
Amir.

[1] https://lore.kernel.org/lkml/20210831025623.GC4286@xsang-OptiPlex-9020/
[2] https://lore.kernel.org/lkml/20210808143425.GE27482@xsang-OptiPlex-9020/

 fs/notify/mark.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 95006d1d29ab..fa1d99101f89 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -531,6 +531,7 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		/* Someone else created list structure for us */
 		if (inode)
 			fsnotify_put_inode_ref(inode);
+		fsnotify_put_sb_connectors(conn);
 		kmem_cache_free(fsnotify_mark_connector_cachep, conn);
 	}
 
-- 
2.25.1

