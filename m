Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F123216568B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 06:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgBTFKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 00:10:30 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33245 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBTFK3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:10:29 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <matthew.ruffell@canonical.com>)
        id 1j4e6W-0001mt-6h
        for linux-fsdevel@vger.kernel.org; Thu, 20 Feb 2020 05:10:28 +0000
Received: by mail-pl1-f197.google.com with SMTP id t17so1565898ply.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 21:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIhfPa7SsfRzn7vx0Oc8RqKMPZYqickShTkap1QavL4=;
        b=DilajcF7oE+h9IzUbtfIq7CDaYaXMHuWrKQlYJ8lVoNxwjHRabYn9YAYMZJC1JYCUV
         HYGBsxQ+sY0hjkVm4PDBROAN0wWEPRlevhXSO1A/ZtVMg9sSLmz0ojDObvZk3r2heraG
         sNMhoveP3u3jJtN1xey39d++R9US1zz5qQyFkGC4EP5xfEEnvM9qRf0q4F1aF/LVMsZS
         UAlzB+vct+2NAINu4qQKv9CJjyY4q3RY01WqAgl4FRfevu/qK2Ty9iCrn68g4/J9IIjZ
         OvFXNT5zE8nviEe3SsBbtDP91oxBHSyU3I1MxpPhxg+GyY3+MUzMZHUHuOT0liXc+Rn5
         GP2A==
X-Gm-Message-State: APjAAAUGM9j4ZnftrjwYo7FekVMLD5MtWknlOEzWZYI9GAYzvnJAQ0po
        F3/Ipg/F8BGX4k4fK+4zZwLGwgFFyYz56LYzgYbGZu4RmdF3Tt/nvmRXhhFHm9pJIOf5rVWbv6U
        xg6NvOsTPUIJiHHAolUM7i1xAy6lCDwo2V+lLr/ctdAE=
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr28782370plr.113.1582175426238;
        Wed, 19 Feb 2020 21:10:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqzd1RYHnc2H+TbYIhh7aaMIbahh+S85LBctIlAD5hV6MW5gQodhvbs9eIVwtEbFUXX7FxfknQ==
X-Received: by 2002:a17:902:aa45:: with SMTP id c5mr28782355plr.113.1582175425973;
        Wed, 19 Feb 2020 21:10:25 -0800 (PST)
Received: from localhost.localdomain (222-154-99-146-fibre.sparkbb.co.nz. [222.154.99.146])
        by smtp.gmail.com with ESMTPSA id p3sm1409714pfg.184.2020.02.19.21.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:10:25 -0800 (PST)
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pabs3@bonedaddy.net
Subject: [PATCH 1/1] coredump: Fix null pointer dereference when kernel.core_pattern is "|"
Date:   Thu, 20 Feb 2020 18:10:15 +1300
Message-Id: <20200220051015.14971-2-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220051015.14971-1-matthew.ruffell@canonical.com>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since 315c692, a null pointer dereference can be triggered when the
kernel.core_pattern string is set to "|", and a user executes a program which
crashes.

This is caused by a subtle change in parameters sent to
call_usermodehelper_exec(), as sub_info->path will be set to cn.corename, which
has not changed from its initial value of '\0'. call_usermodehelper_exec()
will return 0 upon strlen() finding that sub_info->path has zero length.

The fix is to add a length check for cn.corename when we check the return code
from call_usermodehelper_exec(). This restores the expected semantics as seen
before 315c692, with the message "Core dump to | pipe failed" output to dmesg
and the coredump being aborted.

Fixes: 315c692 ("coredump: split pipe command whitespace before expanding template")
Signed-off-by: Matthew Ruffell <matthew.ruffell@canonical.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..ca5976e81d8a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -686,7 +686,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 							  UMH_WAIT_EXEC);
 
 		kfree(helper_argv);
-		if (retval) {
+		if (retval || strlen(cn.corename) == 0) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
 			       cn.corename);
 			goto close_fail;
-- 
2.20.1

