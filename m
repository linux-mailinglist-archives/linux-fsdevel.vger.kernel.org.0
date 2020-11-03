Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E772A4567
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgKCMo2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 07:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgKCMo2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:44:28 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5FAC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 04:44:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id o3so13571351pgr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwDp0C7YI6k612GwfI4IM2HXDY84RMHgpYFcSMQpWgA=;
        b=eN3U2ROS4supbV5REMqmzQqVGcgqDgCl2EnQP8V4BJRhjfA/IAuqIK8D1aaBOyOPuH
         QZSg66R4sk1It7k22jIcpUuvhk09J81hxnUGr1Q1AfFEEBJHYElaGxHDjTcnWqmVve0u
         6X8g345zprT8GcXmDoxFMAV8NekajjfkM06S2WiIkNr9qoOPqQ9a9wkCh87vfF53pURS
         tOZnMZkRt7exPMwKZZr4D/8sNcWtjul8lYTERqrdomo1Fz5k4Aw7WELsgVSlv1bV84Dl
         yb51/qPbNlYvHUzYMdox7vEEXb3cyS9Uq2wMC6vquVap8QXeJu6cxtN/UgOzSOw/tBfi
         HUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NwDp0C7YI6k612GwfI4IM2HXDY84RMHgpYFcSMQpWgA=;
        b=YXQ3tUfjWLXRh0KaffmbgEQcAdaKpLDCYRrPJpbKU067An55DTM/Wh8AYRMAJbHlB5
         P6syOZefIYgIYiSDK3SLGhFO/5+mb6owugrBRFwUAWjvgHiKu0fJaN2mirzYT56JaJC7
         lLw9cPkaH2XEQXUwf+nDAdzWkys1obkfHqazuV8LoIDkhL7itLo7xpKuLFnxy281BuRU
         B/ZV9DIf6z4Qs8/0HchQosjpLLuZnyjJimRJHvYypZLFkbYdeUIx17XyE/Dk4tjOt1To
         +PaRiSNWvRrhUMGIkIlp5/zQhQkXANS5NkFCS57NvHkt49FmfSnpZce+Kt/Rg+X7NYO7
         OF9Q==
X-Gm-Message-State: AOAM533xdWA1rZ68aPHUOf2oMWDv60Zwb0LfT+Rh1vTHveaevUu8j9Sf
        6IruAyD/P0u8YhyNGImKbN4=
X-Google-Smtp-Source: ABdhPJwHZ9ijrJh/hRxytIpCrAljWuuvWebttvbku+IGUZjeDpMiNG/KEKvghnD44G+DH57UFN7UzA==
X-Received: by 2002:a62:3687:0:b029:18a:ec6b:6a50 with SMTP id d129-20020a6236870000b029018aec6b6a50mr9425179pfa.58.1604407466020;
        Tue, 03 Nov 2020 04:44:26 -0800 (PST)
Received: from DESKTOP-FCFI5AT.localdomain ([125.131.156.99])
        by smtp.gmail.com with ESMTPSA id x19sm3007928pjk.25.2020.11.03.04.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:44:25 -0800 (PST)
From:   Wonhyuk Yang <vvghjk1234@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Wonhyuk Yang <vvghjk1234@gmail.com>
Subject: [PATCH] fuse: fix panic in __readahead_batch()
Date:   Tue,  3 Nov 2020 21:43:49 +0900
Message-Id: <20201103124349.16722-1-vvghjk1234@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to xarray.h, xas_for_each's entry can be RETRY_ENTRY.
RETRY_ENTRY is defined as 0x402 and accessing that address
results in panic.

BUG: kernel NULL pointer dereference, address: 0000000000000402
kernel: RIP: 0010:fuse_readahead+0x152/0x470 [fuse]
CR2: 0000000000000402

Call Trace:
read_pages+0x83/0x270
page_cache_readahead_unbounded+0x197/0x230
generic_file_buffered_read+0x57a/0xa20
new_sync_read+0x112/0x1a0
vfs_read+0xf8/0x180
ksys_read+0x5f/0xe0
do_syscall_64+0x33/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Wonhyuk Yang <vvghjk1234@gmail.com>
---
 include/linux/pagemap.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c77b7c31b2e4..4c9f29bbdace 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -906,6 +906,12 @@ static inline unsigned int __readahead_batch(struct readahead_control *rac,
 	xas_set(&xas, rac->_index);
 	rcu_read_lock();
 	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
+		if (xas_retry(&xas, page))
+			continue;
+
+		if (!xa_is_value(page))
+			continue;
+
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		array[i++] = page;
-- 
2.25.1

