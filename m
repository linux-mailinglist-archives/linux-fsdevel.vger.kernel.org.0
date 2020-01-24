Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B716147A42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 10:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgAXJSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 04:18:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37702 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgAXJSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:18:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so714661pga.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2020 01:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uoir3FU1IATnUXQrOYdmalxomb8X20fURMYPZxBipaY=;
        b=VobvKElHW8c+ugq9B4n68RMGbkRbcC2SFUIltlHzEGYSmtLvBQZgPl2fpMg56byHPW
         N9xK2GXsqQqaRxpqwZmmQwVYBEofacH9Tc/tt0wzwaFaxHJzauZhEmtHJS8M78rBOWNf
         lNfgCbTXGrW5xE/pjDZ8PilqiD5xawxRBNVVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uoir3FU1IATnUXQrOYdmalxomb8X20fURMYPZxBipaY=;
        b=CAd9y/x+QfSLXBf8EjFGbC5sfrRdPW6oYHzHHOM+BmG9Sg34mLmxIWq71cbzejzVkf
         4stvHGRQ5SW/W/onvu7T/9xWbe/Hwjcw6iTO1humkAThS6vsguNRfZ6LQqxFV//vIXcw
         R4MOhRR/PYNhavZ4YJcA6gc+crotcUxt1mUXfjYZcMTbChHklbJhM/gTK8o7b+U9gg0k
         4LsgxQ7+EqBYgKd8nmOQACTC3CdrWr3+f8WnrWcDPg/SioEW+qJVgE6AP8PW2wQlG1W0
         jprLpgMSLPPCfivQAMPyJEgBhGu0lYLMW8+LA38Qk3CZ77avru4r/qA1UsVhm8JmtKEV
         7lrA==
X-Gm-Message-State: APjAAAWs/YdxzCaefAYVQLfHDci5z2n5nkT7BcK9FzBphENjvM/uBdrx
        MiQ0teunuLoVnCY4CeLX5s6NhQ==
X-Google-Smtp-Source: APXvYqydz/Qdpb5HbTAO2x2OE/gDtHDX0c3YRX9HY+7ZkT0Y8bfZkdkkGtEh723330PPVQixxzaq3Q==
X-Received: by 2002:a63:215f:: with SMTP id s31mr2880124pgm.27.1579857480743;
        Fri, 24 Jan 2020 01:18:00 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id y14sm5459507pfe.147.2020.01.24.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:18:00 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        christian.brauner@ubuntu.com
Subject: [PATCH 2/4] fork: Use newly created pidfd_create_file helper
Date:   Fri, 24 Jan 2020 01:17:41 -0800
Message-Id: <20200124091743.3357-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124091743.3357-1-sargun@sargun.me>
References: <20200124091743.3357-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than duplicating the code to create a pidfd_file in kernel/fork.c,
use the helper in kernel/pid.c.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/fork.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 080809560072..181ab2958cad 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2106,14 +2106,12 @@ static __latent_entropy struct task_struct *copy_process(
 
 		pidfd = retval;
 
-		pidfile = anon_inode_getfile("[pidfd]", &pidfd_fops, pid,
-					      O_RDWR | O_CLOEXEC);
+		pidfile = pidfd_create_file(pid);
 		if (IS_ERR(pidfile)) {
 			put_unused_fd(pidfd);
 			retval = PTR_ERR(pidfile);
 			goto bad_fork_free_pid;
 		}
-		get_pid(pid);	/* held by pidfile now */
 
 		retval = put_user(pidfd, args->pidfd);
 		if (retval)
-- 
2.20.1

