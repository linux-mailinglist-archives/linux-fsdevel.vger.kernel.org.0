Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133AA20BE1B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 06:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgF0EXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 00:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgF0EXO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:23:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE2CC03E979
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 21:23:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b16so5501927pfi.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 21:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SV0G30IHWhmtkWYF5OS/Fx89VijF0bJnQi9eDPYK7hw=;
        b=Dj5FG1gIfr9/UshorZLJ13MdmiMtE6RkTZtZnauPerOieRTAH1n03Li9RlcMvt4Kme
         Zb6Zj3jnILxw6SEstZdH9Ylw9ls9VoRQLFp7fIrun48DTARYOPvgZ2gmt0WNnjpsRqgd
         5Rfx9M/1H1KCvKqkMONv41Hmay91lTFim+iuzbBvBcYVqYRnjeTcsRd8Yjl2SF4Y56q+
         pZ/9tgAaqZ61uQSnhcXK4ziWSRPLCIAcPsQWxJJE5jXp+L1mpm+37pFufys6UPdYs/+h
         Zjm6lGAhX6VwOao3qsj/qc8V90b0i6iTu0gW8mHNOp+Yvms+AS+YK2YH/XAdKbsxAuI1
         89mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SV0G30IHWhmtkWYF5OS/Fx89VijF0bJnQi9eDPYK7hw=;
        b=HX0n4F9rJHuDLqpHrkRHiJwy112sU8hvc2RAEveJ1oLPyyrWQfSS38iGbz5gXHJKVJ
         k4PeFJlesamWWc9QQoJX6kuB/7PRgYahuZF1H8HHHKN/Y45CjM6P054cZ3lqt5IfFFwA
         Y/Rezc/c5jJeXVkgYUOtCNKJ84n8wMdQJjnYaZTcwLCR+Qi/OziHG0eOnubyP6oFiq+S
         Jgzg9IB9p8qcJd+H3qgYJ3z8G9/NdOwlTFUxc/Nalq1jc3uBAqdDqjl6gU1CtPryVbb0
         nF3u24YshpgRUVErqXI0I8+g6IKJ41shgmsXZ016Of9hq9mYiSm+OMRa6zk/SjqRDA15
         2JoA==
X-Gm-Message-State: AOAM532/LP2GZrP4Qs8Tfr96Qn4voM74WiQNySTd5ecwfef19fWqvNGz
        VsI0lqEuXuv+EgCTnT0jHW4=
X-Google-Smtp-Source: ABdhPJwoELGqvyICpBGCDTXMeb8KRUORPHttwpMwfra/p0wuXChyjX1JhvV4Jjp/fkaw695egqZjGA==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr1875273pgd.40.1593231793356;
        Fri, 26 Jun 2020 21:23:13 -0700 (PDT)
Received: from paxos.mtv.corp.google.com ([2620:15c:202:201:31a4:f84f:da5f:97b4])
        by smtp.gmail.com with ESMTPSA id i196sm23394481pgc.55.2020.06.26.21.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:23:12 -0700 (PDT)
From:   Lepton Wu <ytht.net@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH v2] coredump: Add %f for executable file name.
Date:   Fri, 26 Jun 2020 21:23:03 -0700
Message-Id: <20200627042303.1216506-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200627040100.1211301-1-ytht.net@gmail.com>
References: <20200627040100.1211301-1-ytht.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The document reads "%e" should be executable file name while actually
it could be changed by things like pr_ctl PR_SET_NAME. We can't really
change the behavior of "%e" for now, so introduce a new "%f" for the
real executable file name.

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  3 ++-
 fs/coredump.c                               | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 83acf5025488..17cd96a54fc4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -164,7 +164,8 @@ core_pattern
 	%s		signal number
 	%t		UNIX time of dump
 	%h		hostname
-	%e		executable filename (may be shortened)
+	%e		executable filename (may be shortened, could be changed by prctl etc)
+	%f      	executable filename
 	%E		executable path
 	%c		maximum size of core file by resource limit RLIMIT_CORE
 	%<OTHER>	both are dropped
diff --git a/fs/coredump.c b/fs/coredump.c
index 7237f07ff6be..76e7c10edfc0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -153,10 +153,10 @@ int cn_esc_printf(struct core_name *cn, const char *fmt, ...)
 	return ret;
 }
 
-static int cn_print_exe_file(struct core_name *cn)
+static int cn_print_exe_file(struct core_name *cn, bool name_only)
 {
 	struct file *exe_file;
-	char *pathbuf, *path;
+	char *pathbuf, *path, *ptr;
 	int ret;
 
 	exe_file = get_mm_exe_file(current->mm);
@@ -175,6 +175,11 @@ static int cn_print_exe_file(struct core_name *cn)
 		goto free_buf;
 	}
 
+	if (name_only) {
+		ptr = strrchr(path, '/');
+		if (ptr)
+			path = ptr + 1;
+	}
 	ret = cn_esc_printf(cn, "%s", path);
 
 free_buf:
@@ -301,12 +306,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 					      utsname()->nodename);
 				up_read(&uts_sem);
 				break;
-			/* executable */
+			/* executable, could be changed by prctl PR_SET_NAME etc */
 			case 'e':
 				err = cn_esc_printf(cn, "%s", current->comm);
 				break;
+			/* file name of executable */
+			case 'f':
+				err = cn_print_exe_file(cn, true);
+				break;
 			case 'E':
-				err = cn_print_exe_file(cn);
+				err = cn_print_exe_file(cn, false);
 				break;
 			/* core limit size */
 			case 'c':
-- 
2.27.0.212.ge8ba1cc988-goog

