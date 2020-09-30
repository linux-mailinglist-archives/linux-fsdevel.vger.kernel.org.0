Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F09927F1EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgI3S4p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 14:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgI3S4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:56:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD0EC061755;
        Wed, 30 Sep 2020 11:56:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so546427wmd.5;
        Wed, 30 Sep 2020 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IDr2wAtXJx0+neOn7cIZ0lFnMnpEYiTBO0RQFY8qdSQ=;
        b=b6EwAUV3SBWbRyEjBvMGJI9Yw3atuhQNUSec5P8hjLals34oO9CFdQiRZgnkfJ1wtH
         otRiPul539u1KKN6M8HJSdyooIa5xm8J/l4j/+asjrSuh0ASDjsUiuFpiSH7u//KrGxt
         IpbSs3HbVIOnia45FmBky++0lyy7uRk/7PZucZreLMHDVH4Rlm3hDirzHYzD7eqktHel
         8+y+hEbRp4TReaG6eb8EHhTvFX6w9kEDqW6+/qTvHBZvLX+tGbalBssPYao5opgjTCRW
         hC+XXXhLZGy6pR0MeGqhjgwQvoOPRo+bflcGw1sJFWamnHCtf416BFJ/6rVGmnUMTdGv
         1VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IDr2wAtXJx0+neOn7cIZ0lFnMnpEYiTBO0RQFY8qdSQ=;
        b=ftSnXS4/QEf8b5yJq8Hw76wXt/zU314c/otdScUNCmP9S+vgz22fRF2ugPSiY4/HtI
         Ub2apznYkdjZkLWKrbaUO9rOQVYUY8kSU3n5p1w7/8weNt1DqFSZOvzZ24jZyE3uBe95
         BUN2hd3cBLOObopphgsHsxlWUnc0vZkdjtdBvUDfS4IrmuAGbLF+eBzJtRjlr1UhL4/R
         uojO1geTzZ5GKGaB76wEPReQzZQ89/ETEhoeWjTqTvnnwdgdAVZBNZPiF93eVgz3MABv
         BAA2N3LCDlCmgeJT736Oqs/C/6ggSReMBixFq0V1S8sFlo6lcbXqgAji7HpJqY9UO87R
         51oA==
X-Gm-Message-State: AOAM533zi3C6YuzY27xlm+xIaPPDJU+WIqSBFQ9GKSqUfCk/WHF0Tj8W
        sBc0u3B6pYfytHxxREGtredslbIM8wTsSg==
X-Google-Smtp-Source: ABdhPJz6jU82fHCmCavBCON5X8sKCcNR+NtXto749V07XtSAdZscMEHkP3ri32LD70Ul2sC3h2itBQ==
X-Received: by 2002:a7b:c750:: with SMTP id w16mr4594827wmk.16.1601492162236;
        Wed, 30 Sep 2020 11:56:02 -0700 (PDT)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id u12sm4544040wrt.81.2020.09.30.11.56.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 11:56:01 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-safety@lists.elisa.tech,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] proc: remove a pointless assignment
Date:   Wed, 30 Sep 2020 19:53:59 +0100
Message-Id: <20200930185359.27526-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The variable 'env_start' has only been used for the if condition before
this assignment and is never read after this.
So, remove the assignement.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index aa69c35d904c..238925ff3a80 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -279,7 +279,7 @@ static ssize_t get_mm_cmdline(struct mm_struct *mm, char __user *buf,
 	 * only when it overflows into the environment area.
 	 */
 	if (env_start != arg_end || env_end < env_start)
-		env_start = env_end = arg_end;
+		env_end = arg_end;
 	len = env_end - arg_start;
 
 	/* We're not going to care if "*ppos" has high bits set */
-- 
2.11.0

