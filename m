Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5042B463E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 06:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfIQEN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 00:13:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38715 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfIQEN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:13:58 -0400
Received: by mail-io1-f65.google.com with SMTP id k5so4331493iol.5;
        Mon, 16 Sep 2019 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mKSutXVXFJVFeIrF2mqPJc1lPwXCrqVX1oSLABSaf5A=;
        b=NgvLGz5Hnf5mzXPg7PjPnV8FTlwK8nDlRxX9W5tfOTR9KNhnPmwUS8rMYmuld3EbKw
         iRj8oc6tMmKM33wDZnzblBDg5R7rq2WXEnmnYga5vITfLN3qy8R6vxlIfOzP5xht69t4
         Ir7hZs/mOTxFlIRWL5IBk36uH+CWCFDsxMJ8Y/p9mNdKnEjwwiXkqVmXvwJ2dFUyb9np
         Fw4Utqst8Nfa5urz1tLFMR3rZMrsz3NcD1weNQ+tmJiHIKDv6djGxbQ0olPqirlNcw7w
         5x3eGTcbPmo8mEzjX4CBlKuIQjn45uoOAR7ayPjZtW1JpwHEJ1BGbX/uQJ7zl1q84cWn
         OdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mKSutXVXFJVFeIrF2mqPJc1lPwXCrqVX1oSLABSaf5A=;
        b=KeaiX8fkp6aTgnqOm0r6ACcNBpJ35F8GJIxkxsPzATXzAU//c55t11O2Rg5H96hWlU
         ZaF46Vgs4N6DanPH2lNOen1yC7oUwmTLDI0cMvyBY1qw3IMtlg+cy5BDMSDzdjjxd7zi
         TnWW5gve8q7hCqaMrAsobZJQc88SRJJTO2LgyMNJoBcJcyDv/2sJyjJtI+vuS+gU/Fvr
         oBlU5hnWgb+2ew+aeu1+m4rQEiun3utlVus/KSGR26ZunfJughzhb4a8CLm2XM4/t+Ke
         BXL2X7/zYieRtU9Q04iV5qjVoZ6Q2hVViOP6xqK4pIRdqIy6yQx5CsLOQbPKS/sNmKD+
         UQzQ==
X-Gm-Message-State: APjAAAWymXOFSv6cPxJRTZX1h7fEfgFswlxlhfI3NzX5dOIaMzX/3s2a
        Wpt9EJIxpdrvb/D1QWYIIjo=
X-Google-Smtp-Source: APXvYqwRr+KV+QQpDj2NqB5U8WJodj8KBiwh46OBNDCM+7TzJwEuqWgFeuES9DQ82W+G0wpubpK2TA==
X-Received: by 2002:a02:ac07:: with SMTP id a7mr1921200jao.117.1568693637846;
        Mon, 16 Sep 2019 21:13:57 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id q18sm1545364ion.3.2019.09.16.21.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 21:13:57 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/affs: release memory if affs_init_bitmap fails
Date:   Mon, 16 Sep 2019 23:13:42 -0500
Message-Id: <20190917041346.4802-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In affs_init_bitmap, on error handling path we may release the allocated
memory.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 fs/affs/bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
index 5ba9ef2742f6..745ed2cc4b51 100644
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -347,6 +347,7 @@ int affs_init_bitmap(struct super_block *sb, int *flags)
 out:
 	affs_brelse(bh);
 	affs_brelse(bmap_bh);
+	kfree(sbi->s_bitmap);
 	return res;
 }
 
-- 
2.17.1

