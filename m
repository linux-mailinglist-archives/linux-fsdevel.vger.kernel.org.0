Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8460D1D6D9B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 May 2020 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgEQVrs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 May 2020 17:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgEQVrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 May 2020 17:47:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8716FC05BD09
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l11so9646772wru.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2020 14:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+wk8eJiuJkTmafHRN2lqlXH3cKLjXM5vs5pMzq94at4=;
        b=CHwAYPWVqx2xG0WKKNwAhXYS8gSUMjSVGqRoSLl/fQTpPWjrKxjaANisJJeMKqhAqz
         7kBLq9hp1zuHV0D6OH6y6TUFPbExeVal77Y/jRJqwickCAIf5kAAS/GZa36ZehDQ9ajh
         8ueNhXfcgUtJf+0Bw2cjv3+nlHsmxR1YXF+dPBVdvI6OXPpdjgGEw7WIhkaXqpx0Tl6u
         tQUrF1G/HpS0bUwOuhbmsWw34ZqLnRg2ST3FxmbS8PyiJgd7uB80CHkG+334Uye0pH6f
         DxZuokIjWM7IGLGQrLRY2vDbgzOyCo75X8Mh23lJEwebdOPhc3Ytt8SM1mkAY1w5TXxf
         Htwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+wk8eJiuJkTmafHRN2lqlXH3cKLjXM5vs5pMzq94at4=;
        b=dP2pibWE94lEAPZHXwYWp1ztYyGi8nAH22kifEdHeUmeH8klGfKzq4/OUJI4MWlLmS
         YjAzSFo9S1Aj5sewHRWcnOQg5HNnKO4WM5XqPh6ykcKq2D/Xs+mZv9hNFKwew+AhCC+p
         4m64CHQ9H+DCj2WVsJc8g3KdGTTdtfhesC1QIkNvL61MAt3xmqLy9tVEgZy8l1qZGxt7
         pDqcqykCQCSMwmJdWkLK0NzIq9mii6t9KUsarq3zTiFCga131Zo1sUz3h4sstAUN7fbw
         1+dACsSsAICUDzzxMkCmYlklZywt4bU6m1sLykYbcUk98Kdo2iNmqVlIMQr/DqWS8H4/
         g3AQ==
X-Gm-Message-State: AOAM533NgmEl0a+oThQ9C5tmjaiCvyk2AXwymbbPqHT0iA8RfgJUMcXZ
        6pLF8tcmmzp6Tie48wu3FdKARQ==
X-Google-Smtp-Source: ABdhPJyyj0MqyHctEZVnb5vi30vD5DWpT0PNj3+q7zNi/6gGxhYA+Upq6iCEPrNBuDtqBUzX0XJwFA==
X-Received: by 2002:adf:aacb:: with SMTP id i11mr16139970wrc.6.1589752050205;
        Sun, 17 May 2020 14:47:30 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:bc3e:92a1:7010:2763])
        by smtp.gmail.com with ESMTPSA id v126sm14441244wmb.4.2020.05.17.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:47:29 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 07/10] ntfs: replace attach_page_buffers with attach_page_private
Date:   Sun, 17 May 2020 23:47:15 +0200
Message-Id: <20200517214718.468-8-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
References: <20200517214718.468-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call the new function since attach_page_buffers will be removed.

Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
No change since RFC V2.

RFC -> RFC V2
1. change the name of new function to attach_page_private.

 fs/ntfs/aops.c | 2 +-
 fs/ntfs/mft.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 554b744f41bf..bb0a43860ad2 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1732,7 +1732,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 				bh = bh->b_this_page;
 			} while (bh);
 			tail->b_this_page = head;
-			attach_page_buffers(page, head);
+			attach_page_private(page, head);
 		} else
 			buffers_to_free = bh;
 	}
diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 3aac5c917afe..fbb9f1bc623d 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -504,7 +504,7 @@ int ntfs_sync_mft_mirror(ntfs_volume *vol, const unsigned long mft_no,
 			bh = bh->b_this_page;
 		} while (bh);
 		tail->b_this_page = head;
-		attach_page_buffers(page, head);
+		attach_page_private(page, head);
 	}
 	bh = head = page_buffers(page);
 	BUG_ON(!bh);
-- 
2.17.1

