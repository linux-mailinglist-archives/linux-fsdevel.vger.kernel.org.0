Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3D3E7BD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242709AbhHJPMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbhHJPMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EC6C06179B
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b11so10631459wrx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwwhc479nV/dKQaw1w4y0TanGoB6DLZWrBbYsA1C+1k=;
        b=TZ9VOm+rJyIk+JMyWjuqfeLBE08QwHl8gCjbEEOvErEUIR1Jz+sGHehLnj02D2oebO
         s5xlGeh4Upbvj2IhCOBKkFpD8n7++C9HQMbTHDenmLxdyAsPsF5lC6XilVeRKz5eU8eZ
         bWk+GFGfECnUQQrBMKGDqWkERai1qcjCBv7j8nlYylrNMARuTxx3rTo6cOZLuV4cf+7P
         gdt4lkmWWoxHKjC1Nu7Fy+edmZycbHaJOvCL727fZ39Ze7XNDX/49NwQrbXaVy4Hh57Q
         WRBGOsLdmfHnlidGGQUNX0YURY5mLVS8IyWIrZLkyvpEmdvemCc7MXqzTEekHHZEWfSa
         bTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwwhc479nV/dKQaw1w4y0TanGoB6DLZWrBbYsA1C+1k=;
        b=SmPTRxzeubKi51EOuJmA9ZI4PTSe4kkQngFh4LxIDtEtFWZCfBsgnHoNBUr0ZFX3t/
         igfPBYCM3VIzVhGOvammLiI1n0aNcqGq73Q1Y0Xm9Xmr2C2QYEIcft+S6/Dm8f0GFa49
         M3uUwb5VoMqHHhcaJboeOfDFvln30H93hb6sCB5Cx5mzMOSb7LlPQ4u/xPQ3/KSVRk6q
         AFJlsWWxismU98CUaij5fuohA3oyfXeoSqHC3wyLimA0QzprNuS1ZDVEzBa1rn8TSXSD
         0bCZYLCymq8L38HUP6ZveilNnGQGr5VEwAWHQ4BOpJjDNn8f0zlN91OG/5HiRGQA7Zjc
         ME5w==
X-Gm-Message-State: AOAM532WbfGP6Jh+2H6QwCkrVCCx4sw3AD1q93nBGTmxoAAdbM79MMYN
        ckd02pNrHxUQsrt0lD3iZjU=
X-Google-Smtp-Source: ABdhPJy9LjwXSv77blYd7t7Vywp2w73CYJ9rMprwqJufH6sNVhHqoy/QFRVOS0labDjWQN39AoUBsA==
X-Received: by 2002:a5d:53ca:: with SMTP id a10mr31352206wrw.197.1628608344432;
        Tue, 10 Aug 2021 08:12:24 -0700 (PDT)
Received: from localhost.localdomain ([141.226.248.20])
        by smtp.gmail.com with ESMTPSA id k12sm9568920wrd.75.2021.08.10.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:12:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <repnop@google.com>
Subject: [PATCH v2 1/4] fsnotify: replace igrab() with ihold() on attach connector
Date:   Tue, 10 Aug 2021 18:12:17 +0300
Message-Id: <20210810151220.285179-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810151220.285179-1-amir73il@gmail.com>
References: <20210810151220.285179-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must have a reference on inode, so ihold is cheaper.

Reviewed-by: Matthew Bobrowski <repnop@google.com>
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
2.32.0

