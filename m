Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D944B54AD0D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351069AbiFNJOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 05:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242195AbiFNJOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:14:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D083ED27;
        Tue, 14 Jun 2022 02:14:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z17so8046278pff.7;
        Tue, 14 Jun 2022 02:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gJFBaDNeDWHqIuYxMoyid973bHu6eCZFeTplZbLAlQM=;
        b=nmCAJ0Vo8mpyqfk4PFkmzbVcuyHTf4vtw4VqhEUALeYAh52fkNxCYqfgww0nQ91U4j
         vEFvYksb8QRlDqeUDYKoTlUA0wT0T4hIjuj9At+GZxIvof0yNFr1KPAh3dcVHjPPoRCW
         SJcCk+Hd/EmcKFG3R0ia94GaB2b0rOxjcCAIcnKuUWzLacrt3+u/Vn1HORMD4bg7QLcb
         JZ06SSNEB1PYrzwnPdyCHOucYy7Hz2M47XnGjR4y04X+p89Zksw8gXPA7bj74j+aD9VC
         8tgnUOL0qjkl0VPjhphGKdQLxGq733KrIbq7LmnP5AhS+DjrGSC246r1JWDlcXwtTwcu
         5eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gJFBaDNeDWHqIuYxMoyid973bHu6eCZFeTplZbLAlQM=;
        b=MlAY7HSmYnlhei1uFSUQEPzY5mnYVqbq7Ww3qrSuvbpMg009z0B/RfoEddx9l14pEd
         8mcVb4JCKCwQ4FpE8LvPYfHZivD/KOInWuZ5Dcfn1ZgsgTmvgX6KtBbeouNYupZpDjCK
         ryTKQ9+HudalXL241U8VPxs5XjxhV+4lJjkrG0ULUbM3Cw3D8zhnGFVio9lh4j7GZOqh
         6of5eZ0QmaoHxYnH4SpyheHoCyvVpji+/NLgJzyKvUk87aTJ/QSCkUZtqWx6e3/UDS15
         ln+uMebo8KSCojUUGdqR2GDwddR/lmEO82gg/oP77EkHxM7LkVboYzsDm+URADBq0dvT
         66yQ==
X-Gm-Message-State: AOAM533Vh5/rdmvgM9DhRW11Q2shuMeitsBuE2PBdecp+cWHUQ9XFebl
        mcdJp/PVZrGL9S+dMOS/Ff/oPlZWpg==
X-Google-Smtp-Source: ABdhPJxOEf+NYlo6q+Xkfe6D29qF4mZoOxHYr5+J4iChhXrHGM5voG0sVDT6xWcdd8XVr4UoAxj+CQ==
X-Received: by 2002:a63:6a4a:0:b0:3fd:4f3a:3f0f with SMTP id f71-20020a636a4a000000b003fd4f3a3f0fmr3689529pgc.625.1655198081656;
        Tue, 14 Jun 2022 02:14:41 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id s3-20020a170903200300b001678e9670d8sm6657721pla.2.2022.06.14.02.14.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2022 02:14:41 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     djwong@kernel.org, hch@infradead.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] iomap: set did_zero to true when zeroing successfully
Date:   Tue, 14 Jun 2022 17:14:22 +0800
Message-Id: <1655198062-13288-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

It is unnecessary to check and set did_zero value in while() loop,
we can set did_zero to true only when zeroing successfully at last.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 fs/dax.c               | 4 ++--
 fs/iomap/buffered-io.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4155a6107fa1..649ff51c9a26 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1088,10 +1088,10 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		pos += size;
 		length -= size;
 		written += size;
-		if (did_zero)
-			*did_zero = true;
 	} while (length > 0);
 
+	if (did_zero)
+		*did_zero = true;
 	return written;
 }
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d2a9f699e17e..1cadb24a1498 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -917,10 +917,10 @@ static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		pos += bytes;
 		length -= bytes;
 		written += bytes;
-		if (did_zero)
-			*did_zero = true;
 	} while (length > 0);
 
+	if (did_zero)
+		*did_zero = true;
 	return written;
 }
 
-- 
2.27.0

