Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F443E3907
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Aug 2021 07:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhHHFZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Aug 2021 01:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhHHFZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Aug 2021 01:25:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DDBC061799
        for <linux-fsdevel@vger.kernel.org>; Sat,  7 Aug 2021 22:25:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so29139889pjr.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Aug 2021 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vGbqQ54Jr9nIKu8WIUQho4NBkjHcyNLld7Kfl8vuWUs=;
        b=WVlxOndcWDt3kbOvMIMb+4UwXM7uIa4qlZ0aJhwYEW5ssyYrgGGX1Zn9wgNMof5FBn
         MrIAPJYLa8+kTcVyGBTC5Majz3Yllyklh5GqI8TF6BdRwNc6YjFabb57juf5j2LXJ2E8
         l9dMtqMLLDbRbcjWqAgh8A94vY3JnuPC4doUVWU4wvzJ/+61vO/z8iAGZHMdjmF0FfMj
         u5R6u6TrTJuMyDaRpgECj9Biwov4sVkR4CDZMe2NNSnUzSoml3d5z1p+579suDAd5CMM
         e5miPGC4J/vz0h2skI29sXids/DQJ/Z0JX93rff3ZGkBLEPt/SmTaNeL+ccfGyyFA+3r
         YQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vGbqQ54Jr9nIKu8WIUQho4NBkjHcyNLld7Kfl8vuWUs=;
        b=aZeoMCFwH8t06EdwjR+a/Jz9hfhaQy0gXMXG7J0cRYMCBqAAQ+eFMGFb1qm0v9CD4o
         SJkOpLe0BEk2QwBU9twuvmzb7TgYCjNq3s1a9B1/+e12OS7fTxn2RRBbVa0WGPZ99SEH
         sXxr6vOjBxrgoAa13QiGHOLQ90mibF27WWgz+a+b/cEL9LtEXVxSjzlbmACK3gDRgnc2
         4qiJYRlm+ZAdXk3owxH7HljLkUd6pvyvLPBUPeDtFqPOYQf2x4TjS5zuM6ym3oVpqpjM
         OqISGD/cYuGap5AYlPGdbupoVX0wExJr/K751pObjKjr9RP2D75rK5hrLLNDiSvQURZJ
         o41A==
X-Gm-Message-State: AOAM53239SXRixxgq1Ib7lBcgPBUlOOOsIN5gdt73ev9LtMl9/2XsrNF
        KyUP69AU+MW17nQjkew6T8PzeQ==
X-Google-Smtp-Source: ABdhPJzDBFIETzXIlZHBW+6dK7OUSWurVUXWiaXs7lCmoq0HDGQc3OEV9It4vLUguA5NlEJieGFxeg==
X-Received: by 2002:a17:90a:9b0b:: with SMTP id f11mr18448927pjp.120.1628400317332;
        Sat, 07 Aug 2021 22:25:17 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c29e:146d:490d:33cc])
        by smtp.gmail.com with ESMTPSA id gz12sm17650048pjb.8.2021.08.07.22.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 22:25:16 -0700 (PDT)
Date:   Sun, 8 Aug 2021 15:25:05 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 2/5] kernel/pid.c: implement additional checks upon
 pidfd_create() parameters
Message-ID: <2e9b91c2d529d52a003b8b86c45f866153be9eb5.1628398044.git.repnop@google.com>
References: <cover.1628398044.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1628398044.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By adding the pidfd_create() declaration to linux/pid.h, we
effectively expose this function to the rest of the kernel. In order
to avoid any unintended behavior, or set false expectations upon this
function, ensure that constraints are forced upon each of the passed
parameters. This includes the checking of whether the passed struct
pid is a thread-group leader as pidfd creation is currently limited to
such pid types.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 kernel/pid.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index d3cd95b8b080..efe87db44683 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,6 +559,12 @@ int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
+		return -EINVAL;
+
 	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
 			      flags | O_RDWR | O_CLOEXEC);
 	if (fd < 0)
@@ -598,10 +604,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	if (!p)
 		return -ESRCH;
 
-	if (pid_has_task(p, PIDTYPE_TGID))
-		fd = pidfd_create(p, flags);
-	else
-		fd = -EINVAL;
+	fd = pidfd_create(p, flags);
 
 	put_pid(p);
 	return fd;
-- 
2.32.0.605.g8dce9f2422-goog

/M
