Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8070C2486EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHROPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 10:15:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726794AbgHRONs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597760026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5mbAxZDicFpvBlanHGzWhCcTGWd2P55ViK8g3cXeULA=;
        b=QTAppWxQlS3aBHN6EA1tWp9ZpxHPa+ntqHa76RuUlhHnQMy+UJVvoYJ2L9rnOsKdFR1CSy
        AIMu0RMvRE6Z6hbHqlvyBm0VN8E6i2IyGr7xgoXZvECJgdwV/dvLaaP1kZUgy9rplenL/4
        lRMSLHlNsfmC5uKC0YFk4Ay+GiFN5Ak=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-6mICOqzKMdaMEm8QvW9GRA-1; Tue, 18 Aug 2020 10:13:43 -0400
X-MC-Unique: 6mICOqzKMdaMEm8QvW9GRA-1
Received: by mail-qv1-f72.google.com with SMTP id f1so13388178qvx.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 07:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5mbAxZDicFpvBlanHGzWhCcTGWd2P55ViK8g3cXeULA=;
        b=U9Vve7Cad/PV1UeI/uIw4rczhoZY1R6iQrsfEJ/6Zbim3yRIHQn1Yj0jyy46usf5FI
         1MRgmOFlEVSpsN83s85VGTJ7CiP1MZYCPN4qEJfJ/i2x3nQxtW0lcGZFb+DRKoBujhvR
         o1MLUxm7oeG6STplQsxMccL5UkdSqdlY1/t+qCrS6P+iAunpYcHlzgtjGCJQhlXMLUPZ
         5aLVA32Sw1/qfx0zA9TacmrL+euI/fAjatTgkXLakql1WSUbfNF/JKvBuu7u2mM56tHw
         vHcUDnyXoZTBpf6COcOgNB8QIHSshQPMnXBrKOZfJBAA4Pe43GDKsSjyBd8MvnJUv3gd
         aCgw==
X-Gm-Message-State: AOAM532g2LdtjhBpuWQ7c7pnYQukG2L42dwU1/vDF/fYHgRDAT3StS5S
        378ntEnxBEE8vLCx7r03Y5bIAYFfwN3XmfsK4fhytZxbqvYpNGnLo+Se5JVFDo360hB01KOIt2p
        tyQg3avqnqFRsDiwz3dNiOebydg==
X-Received: by 2002:a37:654e:: with SMTP id z75mr17382722qkb.235.1597760022488;
        Tue, 18 Aug 2020 07:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcNERkf07f873dxUZbjCVeW5+bdQ+AxXl1IqnadX9c2qONRAsyr32ogfC81RXvDcda3rufsA==
X-Received: by 2002:a37:654e:: with SMTP id z75mr17382672qkb.235.1597760021867;
        Tue, 18 Aug 2020 07:13:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 22sm20581510qkg.24.2020.08.18.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:13:41 -0700 (PDT)
From:   trix@redhat.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] writeback: clear auto_free in initializaiton
Date:   Tue, 18 Aug 2020 07:13:30 -0700
Message-Id: <20200818141330.29134-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Review fs/fs-writeback.c bdi_split_work_to_wbs
The CONFIG_CGROUP_WRITEBACK version contains this line
	base_work->auto_free = 0;
Which seems like a strange place to set auto_free as
it is not where the rest of base_work is initialized.

In the default version of bdi_split_work_to_wbs, if a
successful malloc happens, base_work is copied and
auto_free is set to 1, else the base_work is
copied to another local valarible and its auto_free
is set to 0.

So move the clearing of auto_free to the
initialization of the local base_work structures.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/fs-writeback.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..fa1106de2ab0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -881,7 +881,6 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		work = &fallback_work;
 		*work = *base_work;
 		work->nr_pages = nr_pages;
-		work->auto_free = 0;
 		work->done = &fallback_work_done;
 
 		wb_queue_work(wb, work);
@@ -1055,10 +1054,8 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 {
 	might_sleep();
 
-	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
-		base_work->auto_free = 0;
+	if (!skip_if_busy || !writeback_in_progress(&bdi->wb))
 		wb_queue_work(&bdi->wb, base_work);
-	}
 }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
@@ -2459,6 +2456,7 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		.done			= &done,
 		.nr_pages		= nr,
 		.reason			= reason,
+		.auto_free		= 0,
 	};
 
 	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
@@ -2538,6 +2536,7 @@ void sync_inodes_sb(struct super_block *sb)
 		.done		= &done,
 		.reason		= WB_REASON_SYNC,
 		.for_sync	= 1,
+		.auto_free	= 0,
 	};
 
 	/*
-- 
2.18.1

