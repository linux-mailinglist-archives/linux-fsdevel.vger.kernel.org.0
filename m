Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B4473269
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhLMQzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 11:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbhLMQzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:55:38 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA043C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:37 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id d11so6423409pgl.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Dec 2021 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXe8bgxl1OHbTxogH5i2BBaZGpX4qrQFkXaSvSulqmc=;
        b=lr7BUeqzGLtjTNyOL7OBQ1E+iKJIDGjzPGpNFoHZnrOIcICnNc9ZJNADuabwCF3ltW
         bY2WZBfL1PhIDSBPa/egaRsESpHGJ0WBIDLp3wEdIeKU1fG0oqEtzTZrBc3XKVuGOfxB
         I6CBFAgdUI5BFXhBkKSpRTgoK3E+IgT4mpbVdbg6aTCkg40Mwc0ksevcSUg1P5jfXsqy
         Po5Y/kwwA9xWR+DHrzSmEaUoCgHAxF+1AVkJ4rD/InFjKv0nrW7J9dTWeVh2/IFLdS08
         u5vfMI2+GeVjD4KMvjDcdiNm4FrSxl6NRA5+iNA65QgO7GT/aZ+xsB14H6hIhOStTvbk
         +RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXe8bgxl1OHbTxogH5i2BBaZGpX4qrQFkXaSvSulqmc=;
        b=kTWbUs3G9nH7B7dYFeEJ2GC82BTTZD4W1rKNGz2lwTm7Y5ZkKkkVeTGQABJA1lJjld
         Fji6Obys0ARye0fG9wUd8FSolOo7784JDkOZu5BYPxSdy80avIeflW0aAPVVBMIwlylI
         g7HspaBUGfFlNk4wkSnQmyxxTPSQqNQvgu+UMnOH6NUKQpsWYqUegYRO49EZU5HE2rV1
         mj9zTxmNGLv4USwqKZPwE6zVJL12FyVDOsEhBZx876zuDYE9kTe/jbOwBEibm97VGqGI
         SP7d+yejZ1Ww0dmKShYvIjCXUg9Y7MODel+CbNF/kwvlBDLa0qFl8O8QIbXW/8jUNgqu
         tp5Q==
X-Gm-Message-State: AOAM532PU/O6qjju+5GX0VLYs7EVjfn/dRFpeqYXtEOX+XR3siJGTVW9
        nxczyijDBSB6G2VLvH7CNdma6g==
X-Google-Smtp-Source: ABdhPJwI0lyjoBGCY1gPa5+EZEjmMiv/o8W6CmbYFCNjJ6wRglV58ggOz6a8llD/Mww3WTOnfAgPCg==
X-Received: by 2002:a63:7103:: with SMTP id m3mr35645988pgc.376.1639414537543;
        Mon, 13 Dec 2021 08:55:37 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.55.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:55:37 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 09/17] mm: workingset: use xas_set_lru() to pass shadow_nodes
Date:   Tue, 14 Dec 2021 00:53:34 +0800
Message-Id: <20211213165342.74704-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The workingset will add the xa_node to shadow_nodes, so we should use
xas_set_lru() to pass the list_lru which we want to insert xa_node
into to set up the xa_node reclaim context correctly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/swap.h | 5 ++++-
 mm/workingset.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d1ea44b31f19..1ae9d3473c02 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -334,9 +334,12 @@ void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
+extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {				\
-	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {		\
 		xas_set_update(xas, workingset_update_node);		\
+		xas_set_lru(xas, &shadow_nodes);			\
+	}								\
 } while (0)
 
 /* linux/mm/page_alloc.c */
diff --git a/mm/workingset.c b/mm/workingset.c
index 8c03afe1d67c..979c7130c266 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -429,7 +429,7 @@ void workingset_activation(struct folio *folio)
  * point where they would still be useful.
  */
 
-static struct list_lru shadow_nodes;
+struct list_lru shadow_nodes;
 
 void workingset_update_node(struct xa_node *node)
 {
-- 
2.11.0

