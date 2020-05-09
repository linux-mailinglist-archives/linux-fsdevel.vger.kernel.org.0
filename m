Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1292E1CBCD2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 05:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgEIDLL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 23:11:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34061 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgEIDLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 23:11:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id f6so1805981pgm.1;
        Fri, 08 May 2020 20:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9qeuwlCWo2bLV/HUmko4UIQJaKMhP6Ukx+rQSkan8Y=;
        b=Xh2TeYTU1KbK4Y4PWoictCESWP3xVyfBcMd4MIkYYu8sttjEmhm+kphT/DFaAcmrzI
         mETsaIk/IX0VI80t/6Dk+FH5SHeUWPQTIoV035z4uddn9lz+Uj46vqPArAJzCSh/yqnk
         wsniio8+J6uLLiNnyUnVyL1DBbi3VR9ix16mPR6eKwf82PgZcVbAlC2XxV6E7CAWbXfx
         0tuZEW0ZL1XznDYuwQoMR4DXb0g1PiV/g7DJ+0MeZpaNwhu7jwQ+udqZqCS7py4c87Q5
         05+coDJSf0dJVd2qjIsnsbvCDLXPhHRiVkqUz4uSfHJZPzPwGVceaHdARTOnGlAYe+7h
         gulA==
X-Gm-Message-State: AGi0PuaxwHaNjpMwFa0Ts/B1DBbWovOc4fkBQ8aX7B+aZKztHnzHKxcY
        KIx1xQQXQIEwkveZL21AVlA=
X-Google-Smtp-Source: APiQypJ4gDoO4Ls5NVzNOvJO5nVpKEkSKJtyC67OMRsCvPXltLPj+Zy6NxHNyPn2f7uJc5uyHsOujA==
X-Received: by 2002:a62:144b:: with SMTP id 72mr6234440pfu.246.1588993867590;
        Fri, 08 May 2020 20:11:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v9sm3508964pju.3.2020.05.08.20.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 20:11:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1484E41D95; Sat,  9 May 2020 03:11:00 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 5/5] loop: be paranoid on exit and prevent new additions / removals
Date:   Sat,  9 May 2020 03:10:58 +0000
Message-Id: <20200509031058.8239-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509031058.8239-1-mcgrof@kernel.org>
References: <20200509031058.8239-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Be pedantic on removal as well and hold the mutex.
This should prevent uses of addition while we exit.

I cannot trigger an issue with this though, this is
just a fix done through code inspection.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 14372df0f354..54fbcbd930de 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2333,6 +2333,8 @@ static void __exit loop_exit(void)
 
 	range = max_loop ? max_loop << part_shift : 1UL << MINORBITS;
 
+	mutex_lock(&loop_ctl_mutex);
+
 	idr_for_each(&loop_index_idr, &loop_exit_cb, NULL);
 	idr_destroy(&loop_index_idr);
 
@@ -2340,6 +2342,8 @@ static void __exit loop_exit(void)
 	unregister_blkdev(LOOP_MAJOR, "loop");
 
 	misc_deregister(&loop_misc);
+
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 module_init(loop_init);
-- 
2.25.1

