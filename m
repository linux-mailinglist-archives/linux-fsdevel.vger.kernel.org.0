Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3C1D6D98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgEQVrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgEQVra (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:30 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916FEC061A0C
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s8so9561095wrt.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=;
        b=b2OunlJb1CqG4qMvf91CNV+d8tunFadtVS8JCoT8WqCC9BY9AeF54XVDVBqhqjfXF/
         8OPXXY8BQ3dm7EE/i+F4/9JmQtxgkNDL5deNYT17giGKWgdRYlaG3i6daLy5HIsw/PfM
         20vdfTALNGIdNIiamhNH0OdiJmHmrzuDPCcl2Q1mjWwTDMJktm4aF7kdIxdy0DI3mayq
         0K35ZpmTBYtxEJOs63UQgGJfbmZNvtcvtVvm076xjtcI2succM5Q8iou6S3qSQ3C5Vl0
         FjJL13aUg0ZvNStsIAe4mAz1kVDyZ14fOCMqUqqszcwIVyNJAwF8wSko6zY+IN9q/m4/
         GWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OFT0iCFHjK0nh8uePEVriaTeaCB6BcpTAMIRJKLJOK8=;
        b=X9J12JXoXQ3ytspgRDX2BbQEczZMd+ZjYvCbin8UzgGrGsrlmWOcYcRrWH8jmLUeiz
         0wMZ0wyIxoXt5iEinqVN+gpTd34QiAlOv6uSMC1p8fDSxfGbp3DHhy0fMIqZuA5+ucrT
         aHjtPQeTfVLgC2N3zD/+GE7gbrTiRnkGoL3A4zXOYZsq0e05TtqvK0NusNOOzuxJAYw3
         motkp1TBogQbVc2mlcxrmk5Wp6ueo5ZWhFPiKsw8EeQK+ri04eJoxNop2ttLKb1kWFXb
         d4N4nj4Segi/qtxieSOTqYDRP9x5u9S/LIQMsQTWSQ7oflThooinN4z7UxUzLq6ViMOr
         0pcg==
X-Gm-Message-State: AOAM532tDt4NPJr0jWwSqgZBImXD12UtKzEDfZL5KQXTJHXJZVuTd3UI
        78HiVLvzoVJbY22LjWV4z0PkmA==
X-Google-Smtp-Source: ABdhPJzk2oag1WV/Akj3+q9BtXJaV2V1BQcaFlIJ4suSs38gE/ChmFbqJosJ60jwzmp0vo3buD/jog==
X-Received: by 2002:adf:ea90:: with SMTP id s16mr16142123wrm.19.1589752048332;
        Sun, 17 May 2020 14:47:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:27 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 05/10] f2fs: use attach/detach_page_private
Date:   Sun, 17 May 2020 23:47:13 +0200
Message-Id: <20200517214718.468-6-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
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
No change since RFC V3.

RFC V2 -> RFC V3
1. rename clear_page_private to detach_page_private.

RFC -> RFC V2
1. change the name of new functions to attach/clear_page_private.

 fs/f2fs/f2fs.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3574629b75ba..a4d4a947f603 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3128,19 +3128,12 @@ static inline void f2fs_set_page_private(struct page *page,
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

