Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06F7197C15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgC3Mhs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50874 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgC3MhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id t128so1345279wma.0;
        Mon, 30 Mar 2020 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ts5vXUGa6M9Ix7l/jt04Pf2FXgkCXY+/E2UqD108cKQ=;
        b=pxyIomrIpX1uLyk4BVT+G639xGIMh/FNDG2MSWLObXyunVFpQ6kqa/FjegVc1YBB/+
         lcRKT13+DA16cTPzoGrEh6RdUwoT1lQlclobu9j962ndxNJwhwNnfJIIf0F32hhUguE/
         u4WdMzgtyXfntDKygG0DvU5S92RxYRS7suuPYnGXg1llVC58eEbTw4rgVseG28vjuPDb
         6mV74xSqfKaydHoBpslOQVX9vAthvsAUOSBaJZyjNtVQNSTs77+7UBLFZukJWcZRn4R6
         E0nqE4sj3nmaBfvg8bhUlXVJkaKe4IrpKSVUhLdgrbRlTLu8/RlyyMUbK8WNogCJKouW
         07Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ts5vXUGa6M9Ix7l/jt04Pf2FXgkCXY+/E2UqD108cKQ=;
        b=r0hmx2fao0h6LsuEGTSivWPLXt0FVfVS6pj4LaiblC0GT9nIP9j0MncsHgR2+5eI51
         VXPoeCfVHkSOiKqci1p4GHum+6R9HVhA69YEffPno/lgocy/ejtvmdE+LJY6umqSpSmV
         ZYEnREmLRveNgF8VZA01viiMZWttrfIrFL3+TgCq1EpPZwDjklnqDxz405ymFyySiOQc
         7lZgDZ8btTPgFDO2dqXUvOMHZNX2eC7fegC8n/ixIu7vAspZAxiJiqFH38z0BgK+t/hV
         j3AkX3Guo6Q00541p3d0pMl/roEkbaDDhj1y/v94wUptGHgE60+limsVjAltRJDkmlNS
         ZX1w==
X-Gm-Message-State: ANhLgQ1rtkLtw+8ymarxjJw2LqlBZKgalk/2ljMdSth/6DFNhnJpZA8T
        BGbj2yizkotlSHyi6qM/S+4=
X-Google-Smtp-Source: ADFU+vumB110DIIq/yWaOVwDzU+J8UzUvYmpJiCR4iyNBAhqx4VoL7pTeHyefWuFuZBm7/E10wIg4A==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr13369369wmb.112.1585571832661;
        Mon, 30 Mar 2020 05:37:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v129sm18359047wmg.1.2020.03.30.05.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:12 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/9] XArray: handle a NULL head by itself
Date:   Mon, 30 Mar 2020 12:36:37 +0000
Message-Id: <20200330123643.17120-4-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200330123643.17120-1-richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a NULL head, xas_expand() return the proper shift directly without
other handling.

Let's take this out to emphasize it is handled specially.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/xarray.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index 6454cf3f5b4c..1a092c87fca5 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -559,9 +559,10 @@ static int xas_expand(struct xa_state *xas, void *head)
 	unsigned int shift = 0;
 	unsigned long max = xas_max(xas);
 
-	if (!head) {
+	if (!head)
 		return roundup(fls_long(max), XA_CHUNK_SHIFT);
-	} else if (xa_is_node(head)) {
+
+	if (xa_is_node(head)) {
 		node = xa_to_node(head);
 		shift = node->shift + XA_CHUNK_SHIFT;
 	}
-- 
2.23.0

