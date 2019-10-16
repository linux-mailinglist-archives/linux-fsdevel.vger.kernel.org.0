Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B736D905D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 14:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389174AbfJPMGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 08:06:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43840 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfJPMGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so14587638pfo.10;
        Wed, 16 Oct 2019 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/ejZ8luhiq32Fwxo+jf6eQC8OVPoBMz2IzbQt/xaAA=;
        b=SUCyKZEidz5mY5dNAF8kYaxNE0d953d/z5Y+P6bimQ1GUiJqMaucGYydUrqJfmfs9N
         Dy0R2rENqFpCAmHrqlOV06LXIqjkeip2vBwW2L3ZUxJ442i9aF6LmOq1n/5r1kt2OptZ
         HaTLaL3SQ6LxB3RRrMqLr6mJwuLnbvTuvH9tAO1fWsEjNAynuDt8zwLm0/g6ELSaMWiM
         8+9KKwWptOEzJHZWd2nZWwpLRz2b7B5LSXeKczoPJbA9TOzMknzv4rbzjpS8ufge/qEO
         KqKDkPmjNbc2o7RQqtziTF7n9cvFonRxUcvY+LFmCmgpfHv1IYmZk0qn4sPDO700rBvD
         eFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E/ejZ8luhiq32Fwxo+jf6eQC8OVPoBMz2IzbQt/xaAA=;
        b=bL/tU69V9Kid/ZtTgYktJLh4VVA1JtaCpAyOkGX0bqkaEhw07wb3iNHDBqs2IaeSQJ
         uUbeqAxuvog7iJejyEUIu7a82hTopoiM+hWgX/LzNar3mYn0MxX5JtR3zi0RmAeGBaDg
         2lBe0YM9ljUiwWcdQcObAdsmlEjpFwxksgIrNWQiay6ed97kgaD4lcmFtDe2dJmMZ/Qh
         g2k7cOhlmBzGvogFiLdMZPjSFE6iRB1pKJRyjpJqVFIRJCn6eSlrjVnJgzd4PVmDWsYJ
         gLtI6AVyyQPWUp5BNH4W4CL+JCoOwwe5tKg3nhe75HVHiJ3xCxsl2WbAZlqxyzkIekwn
         4EHg==
X-Gm-Message-State: APjAAAWVy/omk41FG7uSumSPgq98U7+OjuHDMXVkyiRcl/CKVrG/RLt1
        6iDqigkMr1MAoyWUUPBIIYmMzmzISPw=
X-Google-Smtp-Source: APXvYqyoRxGa81TfoUX8kNLcYZPWvYryL8FQqh6aE4uFGKG1P0EYMxn6wAXx/g3JAdUHh5ZaAyoR2Q==
X-Received: by 2002:a63:eb08:: with SMTP id t8mr6895885pgh.49.1571227590148;
        Wed, 16 Oct 2019 05:06:30 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id u7sm25259270pfn.61.2019.10.16.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 05:06:29 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/2] hfsplus: add a check for hfs_bnode_find
Date:   Wed, 16 Oct 2019 20:06:20 +0800
Message-Id: <20191016120621.304-1-hslester96@gmail.com>
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
 fs/hfsplus/brec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..22bada8288c4 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -434,6 +434,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
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

