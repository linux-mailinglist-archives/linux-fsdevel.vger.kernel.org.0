Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6A13D08C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 08:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhGUFjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 01:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhGUFiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 01:38:46 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F3C0613E0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o3-20020a17090a6783b0290173ce472b8aso3391774pjj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 23:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bunlesdSNKjr06kYcClEV6XFYZwdiy+THLPQ9xT7Cks=;
        b=DPXK2g82xRUiHUwSCX5k6uA12m8DcmGuU83WQCHhEHQJGT3nHM3mRwb7ysdaUuKN/c
         H6p54Jff+uJnylYEyAdKvygTuKvPwR/9iRK0mLHxaoDJSGXzOX8u7AJiohgwOpHmcStW
         bE0/aBLha9a757Z810M1Vvu5vgYvMpTRAbFa07D1aCHBkFU6JSsldNEJDys3gLBRcZ9f
         lajuMS53AfJ7HIcd2rWsuDccWmeTBRNffKg+QOxHFQnRIgFaNeyXyFgcFCm4o+4EBOSK
         mPGfAQA/sCQk4X+Q74o58OCSbH+Zz1O0Pp3VFeAFoqJ247C/4AOqjSQWeFC72KOjBrXy
         Vigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bunlesdSNKjr06kYcClEV6XFYZwdiy+THLPQ9xT7Cks=;
        b=iME3oo4JAqEuBCqKRaB4Susg2eFRHH03yBGth0eP08YroNd73wSHYxyj/Q4C6+eOBL
         CIvjvd0Gxxpa0OlvbdVyYUJoxYCZNOEHlgSdtSqy0iTyGjeMjONbqyta2xlJynkUPCcc
         tYNxd97jB3gOlxPGtpRoRqr5PoUE8TTZ7EksTsbCK5WOBt6AwAbP/ipxmsJHB+7+3koq
         BDbE4g1JNG0fDA9qnK2Bj5dQINj+dixygkGgdCMqaOwL91zBadCVpVjX3wbf6SsRZ5YM
         s3irjtbT6/OL6MtPkdEi1Qi0x7GJTXyHYl02oXEhgZkXDkGuBPPqzCWGRFn9inHxI0ct
         FtFQ==
X-Gm-Message-State: AOAM5308woQ7Y0yX9TBFkeUCbl3lc0GbWsE6ctx6rSeC/SQlB1oSFhct
        LCHjLWHHwsptdxB1+7IfiNwYGA==
X-Google-Smtp-Source: ABdhPJz0qXgLs67U9GAOQqbbayT2xYq/KHDls24vT3afWEqbqen9UW1rg0fwmW1TmlpIy/e/QHJSyQ==
X-Received: by 2002:a17:902:8c83:b029:11b:3f49:f88c with SMTP id t3-20020a1709028c83b029011b3f49f88cmr26192858plo.63.1626848288713;
        Tue, 20 Jul 2021 23:18:08 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id y82sm26193265pfb.121.2021.07.20.23.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 23:18:08 -0700 (PDT)
Date:   Wed, 21 Jul 2021 16:17:57 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v3 2/5] kernel/pid.c: implement additional checks upon
 pidfd_create() parameters
Message-ID: <ce0d38ce25490d9e144b5e76573f62eb1d3cf8b3.1626845288.git.repnop@google.com>
References: <cover.1626845287.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1626845287.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

By adding the pidfd_create() declaration to linux/pid.h, we
effectively expose this function to the rest of the kernel. In order
to avoid any unintended behaviour, or set false expectations upon this
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
2.32.0.432.gabb21c7263-goog

/M
