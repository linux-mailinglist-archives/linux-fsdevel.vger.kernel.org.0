Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A68441959
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 11:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhKAKGs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 06:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhKAKGk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:06:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A0C0431A2
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Nov 2021 02:38:03 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id n8so513901plf.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Nov 2021 02:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBWzc0+NeQrbSJTD0O+NF+bRzjwkf+Is1EvNPBX7xt8=;
        b=RwzEvxArdInduzZ6igkyKQ/QBTZwwyGw7XuiLzSe40gMmLLxHUdJGH/jCTleTIrY1S
         bMpq7HCwmcANkwRkyVBn1E9WpsAhRuJXiLoo8mmfYUc0iXGz5lwie1ggBZnex8HOV7eo
         vZdX+gDsd2wX7Wavvn9gpwK/ZohTm/ECMYGv83i9dRn5CgYwMNhNU0k7QoKqkh6A4ksI
         BpvRS1TN/uWF6KG0X1ZVmo0D0nWDKUdwkZcbhKJtuB+7fVY0PpnEMfMU0CHCJVk37z/P
         m+Ol9odxQ43Z/3D6jvvqsaufk9mbHTBSdXhDzXTVM2zDkWCmm1qaDbyZYlrbuDQFEQmk
         0UuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBWzc0+NeQrbSJTD0O+NF+bRzjwkf+Is1EvNPBX7xt8=;
        b=3yMP7ze7tVCCEDf6RpME1eUE4Cbu5LCAYElFo5pw26xdZ9bgmPmYA855wak27TnjLT
         mA3dkDhPYc3qiqSV7CrbuysBlgeJvHoKwOd8xP9IXaqlq6GV6KOEA4Hv7tl4NnuJC2G3
         wqyB7uEbj/3uVprK81tL2OCPMAwIBpDhCoR7vjTn2y7A2/1dibckfzDR6mg/snTEhPGJ
         umdYVzgmK/J6qlTWI23Wr0al4ZEx8YHKXCz1m6aEPmhCrPtgKUhBWeadP9Irqh3PRVd2
         43q2gCYSlxo+Gp229/sbXbf/5mXQhzcYJxETa4WNcRB63rMMUnCvb0vPanYjyg7De1d3
         YuPg==
X-Gm-Message-State: AOAM530KQWCHkwuSMnM+1PH3/q9M1ycF+OiZVK1uEu/J7yCgZ3zv6YrD
        7OfAfgFgNsUXu3xWc5yKltuNjQ==
X-Google-Smtp-Source: ABdhPJwTAwrmnnDj1l0O33Z6nCqsusIv0u3rVHJPs8TeMvnO7edJm01vLTyKbQJgdLdeCQeGuEn49Q==
X-Received: by 2002:a17:902:a60f:b0:141:8996:3fe with SMTP id u15-20020a170902a60f00b00141899603femr23287198plq.71.1635759482972;
        Mon, 01 Nov 2021 02:38:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id p16sm15738259pfh.97.2021.11.01.02.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 02:38:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/4] fs: proc: store PDE()->data into inode->i_private
Date:   Mon,  1 Nov 2021 17:35:15 +0800
Message-Id: <20211101093518.86845-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211101093518.86845-1-songmuchun@bytedance.com>
References: <20211101093518.86845-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PDE_DATA(inode) is introduced to get user private data and hide the
layout of struct proc_dir_entry. The inode->i_private is used to do
the same thing as well. Save a copy of user private data to inode->
i_private when proc inode is allocated. This means the user also can
get their private data by inode->i_private.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 599eb724ff2d..f84355c5a36d 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -650,6 +650,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 		return NULL;
 	}
 
+	inode->i_private = de->data;
 	inode->i_ino = de->low_ino;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	PROC_I(inode)->pde = de;
-- 
2.11.0

