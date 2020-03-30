Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D2197C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgC3Mha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32850 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgC3MhU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so21458869wrd.0;
        Mon, 30 Mar 2020 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uvwY2mjZx4a2ESF603boxgCi9vgPxxIp1smdJYBMhpI=;
        b=P+waHsT4gPyPrfBgkFrzTLDl17pX21YfZNyfpeIJ0+82RbQCDTDXUT4X894gOfPIyy
         KgsEHZE23gkNKfp54VvDkTpKW/TJyH87Y4SvLbFwzQblbhCYy5lWB7DTSWCAo9gSpSDn
         /aeu5nIclNKkbEzXZZaVz9m/78tCvgSu0AYBJtxaTVFqSn5z/Y8NurKUqPW09/PIrzbv
         xnLHubi9TNQpUoLwCJCBqiU2/Si0u2sKrwcOEIDDviQtuArbhNh/ILATYhp3vhj4lTf0
         d50iZKaQ/PqU3HMhUaABHUJG5BFQM6bk7rcUolPQLSgXo55gYtCRQHkxI955ryF0MPlA
         w42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uvwY2mjZx4a2ESF603boxgCi9vgPxxIp1smdJYBMhpI=;
        b=k5fAQ5eKHdVCeMF+HwfXp1nRTtF9hi8VJoIgMl6Vk8PtZ00zw13pJoZ8rhMLWun0IU
         3ypkXcDdJYY8w626aDgdNVIMlulHsUiycH83xqBJcpGTi9bkpTM9cXHsgQ2s2GHH/Vxu
         rJyckHcyEQ91PJLyuw19Yb17Vs2iFdzkH9cwUize93Z5nMj2MvbkAchZopTWBnkq1wKf
         RPEJeS9Bi07QT7y7gYyDR9Agt3j63mc0/XN920mZD+hmKQSXh+KBG7HKpdslZVa6+t+w
         TkPA21NYBanhf716AfOlCOrL2o5FWSqYAzL3XXSsAjk4JF3JbAFfCrohbZb/lmHnKqqQ
         mNvw==
X-Gm-Message-State: ANhLgQ3bE1ATeMxdowoSxn0ASg5U5YwHeTQcBXVvxUQZKAvDmuTYkYyQ
        EDd8bHgFCsKl5VLJee8s+oo=
X-Google-Smtp-Source: ADFU+vutsHSSXfCtQVvv6ZL3rgrg0zOW39jq09vDyJ1oGVi+c1M1fM70BR30Dz81EroVHZwcXCC1Dg==
X-Received: by 2002:adf:afdb:: with SMTP id y27mr14908949wrd.208.1585571838534;
        Mon, 30 Mar 2020 05:37:18 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z1sm10092288wrp.90.2020.03.30.05.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:18 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 9/9] XArray: adjust xa_offset till it gets the correct node
Date:   Mon, 30 Mar 2020 12:36:43 +0000
Message-Id: <20200330123643.17120-10-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During xas_create_range(), it will go up the tree for next create.

Currently, during moving up the tree, the xa_offset is adjusted every
thime. This is not necessary. Only the offset for the last one matters.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 01f64a000e14..9546b2b2dce1 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -712,9 +712,10 @@ void xas_create_range(struct xa_state *xas)
 		for (;;) {
 			struct xa_node *node = xas->xa_node;
 			xas->xa_node = xa_parent_locked(xas->xa, node);
-			xas->xa_offset = node->offset - 1;
-			if (node->offset != 0)
+			if (node->offset != 0) {
+				xas->xa_offset = node->offset - 1;
 				break;
+			}
 		}
 	}
 
-- 
2.23.0

