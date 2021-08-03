Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78913DF449
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 20:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbhHCSEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhHCSEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:04:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7BBC061764
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 11:04:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c16so26221204wrp.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DpbNU57dwIf0j8e6Vnow4rtXZ0Erpq3Ug+gPGUYekgM=;
        b=MY5QZ0oTxgwZ18rUI4C7T8SLOrpPpSvU3H6AGy76n0IFvLBIX2aX3YnDE2Kpe8hdOw
         ljdHt3msI/aJ8g9do3YLlEvrOhMKv+fOFpscTnKo8NjMTan86QlLyxwDuPPH5UrbX5Dt
         qmxa79Nrp3Xy64FTTeQ+BSv1nl5BmUDiECpgJG27QEAB9Hw++CyqnCPKehQayY8OpSCs
         JZEwCl8ZvenVKtqhExEttQTzF71l8fJsZ5bTWf971UInnR2GPLifMDiaGQW0CcCSpVRh
         VOPaaGV0bOhcLpmwrMXT6UuEU/72kXp6cFhsReN6RsA5w2ZoIvVbRoW8jsgRjzfPe5Kv
         M2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DpbNU57dwIf0j8e6Vnow4rtXZ0Erpq3Ug+gPGUYekgM=;
        b=KdGJ9/J9UZY0XhyD4MnVliPZmfYe1jbYwx06JiQIH+3nJeZGhe5q7R0oignKhnUwLR
         GNzwRa37M+W9Ptno7qwWdv6hX0udE8caQL4Q2TIT+p3sQv4zVaJT9YdOgLgxu0xlj3i4
         2WwTLlA4xImJ7VumPVcHMKT3s4JZrEuov1ApZNyShtlvNWLBKhrA6qATMndzgAXcRym3
         S4Ndd9BoDCyW4CWcTz2N2suziX8HmOuSSQG2Ym6oLpDmNU3IDiz1hD57BmOMLH3eWmit
         fMgT8jT91f5m9KHWPY+kiqzFz4LKF2LpCnX3yGRUdWyt8J32+KWnqQK8RT+I/JnKc9nx
         7Iig==
X-Gm-Message-State: AOAM5306Nrq7N0SxjpiZjXPVoE0fDMDuUGMb/uvvQW6wzN+OajyYlx1J
        dD4/7qpQZrC4NZu1XnNpGso41+BktTU=
X-Google-Smtp-Source: ABdhPJyu32Zb0kAJUt9f2clJ17JJ6Tp8wVUQW4JvcDVdjH2+feaGm29DzDonvnbN1vFgp1k12/guLA==
X-Received: by 2002:a5d:5987:: with SMTP id n7mr8649927wri.260.1628013840652;
        Tue, 03 Aug 2021 11:04:00 -0700 (PDT)
Received: from localhost.localdomain ([185.110.110.213])
        by smtp.gmail.com with ESMTPSA id b14sm15515555wrm.43.2021.08.03.11.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:04:00 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fsnotify: replace igrab() with ihold() on attach connector
Date:   Tue,  3 Aug 2021 21:03:41 +0300
Message-Id: <20210803180344.2398374-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803180344.2398374-1-amir73il@gmail.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must have a reference on inode, so ihold is cheaper.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/mark.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index d32ab349db74..80459db58f63 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -493,8 +493,11 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 		conn->fsid.val[0] = conn->fsid.val[1] = 0;
 		conn->flags = 0;
 	}
-	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
-		inode = igrab(fsnotify_conn_inode(conn));
+	if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
+		inode = fsnotify_conn_inode(conn);
+		ihold(inode);
+	}
+
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
 	 * only initialized structure
-- 
2.25.1

