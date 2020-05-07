Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F941C9D9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEGVo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgEGVoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:24 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1446C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nv1so5915734ejb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMtexH+KHYg8WWtN7UTgX6eHTynYLEIBFReri4mWFCc=;
        b=C+aZyE0ItmHGIBdvm5jWSFvyCmt2e6ZkOwlIWvu8b0H63W29ve2rOZlf8y+8y+gmld
         ZjG9Y4WWIGb+goXnokiWHdrsMqES5X7JaSrEV/fhpzmey1WTqsjlyk0dSmog8gabW9mV
         UifUcMmnYPlLhVxtwEmS61HoE/D4xiiq4QlqcisbD0nY3ghcTLtx9KUsW/ApbVwG1XCL
         ujtW37cAyL8CrSDZL+CIJvPXUHwNEt+up9VJjMd9AVr3Bfbx7+OXhE/qvfAsmb6BvPFi
         5D+Cv0iQNc/unewS64ruKoLL/NcwnOkWm8MpSRK5TxKVUIEp9V/+mR5uDMaRX7qMEtU2
         Xnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMtexH+KHYg8WWtN7UTgX6eHTynYLEIBFReri4mWFCc=;
        b=b98iOSEtmBmM19M2HVFgNQKVnok9VOLypkN0SAvBSXPSpgTLaI52QIiGLRijZyjz5H
         QtqnB5WSqFCWySVnApBAuQq36br760DbY4tWQhl+K+EIgfEAv90DbAPtC7B/+CBFwgFR
         M9zvQdSyzjnciLbLmyVltxDTqWwHpOfRFH9jRvO/RtcDrVMuu/HcZFXZp76i3FnS6Hjw
         O3YGBNZ43O0tcI2JgN5rwzA1ooTVj1/cEsDbYa/wjUJ6/pcLYKUwZukTcYR7X+89jQZF
         Z0NsHpvFNPQCfAakV4oPuYB8EsejcDb5qFXMhfImZ12sE7VkEXBEhRUoJ7c3u3Idufrh
         etPQ==
X-Gm-Message-State: AGi0PuZo50AGw/f7KldvrrD6wwqz9VVXk5PMGIsTcCsrHePMTMwkwwDn
        j7lyveA2AjuMf30a7r36HrJLNaZR8Zj2vQ==
X-Google-Smtp-Source: APiQypIlXXZdUeLWAD5u56J3xlbgzi0w5YqlZnrUpLQfikzSZE7i3StNg5L+SIQQChqhUCbofsEzFg==
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr14610196ejq.190.1588887862357;
        Thu, 07 May 2020 14:44:22 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:21 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [RFC PATCH V3 05/10] f2fs: use attach/detach_page_private
Date:   Thu,  7 May 2020 23:43:55 +0200
Message-Id: <20200507214400.15785-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the new pair function is introduced, we can call them to clean the
code in f2fs.h.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ba470d5687fe..6920d1a88289 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3051,19 +3051,12 @@ static inline void f2fs_set_page_private(struct page *page,
 	if (PagePrivate(page))
 		return;
 
-	get_page(page);
-	SetPagePrivate(page);
-	set_page_private(page, data);
+	attach_page_private(page, (void *)data);
 }
 
 static inline void f2fs_clear_page_private(struct page *page)
 {
-	if (!PagePrivate(page))
-		return;
-
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
-	f2fs_put_page(page, 0);
+	detach_page_private(page);
 }
 
 /*
-- 
2.17.1

