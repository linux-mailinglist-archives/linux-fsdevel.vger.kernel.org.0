Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A5ED905A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388884AbfJPMGH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:06:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34825 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPMGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so14186805pgl.2;
        Wed, 16 Oct 2019 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jNaNShiI2I6Epz/fP6Kwqg1Cac8i8suAY9lIczv7Gs=;
        b=DrMihC/YNPMZaZlwqdxITQYc4J2/0Y41fb755yLUcpMH8e81DF14Jjvgs5JSMyCJfZ
         t/Ge37Fc9UX86EDpa+kVTwrF89emEkN+h/CEio6iV3YpHbHqVR4YK3tv4IkLUOvB5054
         VVegltUoKMl005GZ+2trrMuhlFDj42n2i7bGNZdaXXqL/XfB5UXltIpDngfd+C1cTYpX
         kS/yd+GQNMo7WpLnd4oED4/nQgPlm+leiwsz6r/2MGQjPq0/S2Im/XZHxaUVff0TmB43
         9JH3r5x4AokS+InrGmnH9VkfKI/S8QHtHP4dbk2nCaku/OgDYAq8r8XGuw/EsBHvaWvg
         YZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jNaNShiI2I6Epz/fP6Kwqg1Cac8i8suAY9lIczv7Gs=;
        b=FW9D6lTjK4h7e4+dmZPW0tT1DaBWnqsFuDkalV6UiD1aoHj/M8TG/iyPFlcjAjRR/w
         C2A9ZqpN4nvB/hFwWjuuhdblIOLCTTVf8EtFSUHBsof1hPhm5zUZ4QWSLRYoH4+nBoYz
         P85ufJuRNh4233W10i7XhQmf9rPGKlD3+a8CU7pWOT274whaiHoU5nhxXzU71lW5hp38
         GnD41wWzaSH6XHLffeph57NNSAT87oIw5mL+R+CWZK5ZC4f6nfHjfwdTo/nNB5uWvqc9
         YYi7C5/Bv/ShJHbqbFQctXrK3jwPlBEEuEKWMY/Et0jxrTw+Ma5e3uBfDmhqDFaOb9G0
         +aJA==
X-Gm-Message-State: APjAAAVS81T16mkx5T30cht2x7Q92o4HePtvydXlB/edGktsFuaX6ckZ
        zGEqjyH/eXEHyzcbVNPkzKoTg3B9RAw=
X-Google-Smtp-Source: APXvYqzuqZOlKd8MJTLgI6hxhMNkC16AYYjpSnjEj2JcqRXEYCeN3WAeASnlXrXbLcsVCNaK1+K9iA==
X-Received: by 2002:a62:7689:: with SMTP id r131mr29202492pfc.68.1571227565968;
        Wed, 16 Oct 2019 05:06:05 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id y7sm27271266pfn.142.2019.10.16.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:06:05 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 1/2] hfs: add a check for hfs_bnode_find
Date:   Wed, 16 Oct 2019 20:05:56 +0800
Message-Id: <20191016120556.32664-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hfs_brec_update_parent misses a check for hfs_bnode_find and may miss
the failure.
Add a check for it like what is done in again.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 fs/hfs/brec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..e6af05a4cd1b 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -430,6 +430,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			new_node->parent = tree->root;
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
+		if (IS_ERR(fd->bnode))
+			return PTR_ERR(fd->bnode);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key, 14);
 		cnid = cpu_to_be32(new_node->this);
-- 
2.20.1

