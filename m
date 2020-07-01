Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04920210265
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 05:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgGADOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 23:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:14:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C94C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 20:14:52 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so9322580plo.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2020 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/msuGEuNnK0pUHOBEJBw+yRN6xkWwWdMAXSfLeiswI=;
        b=s+hTguoos/RPJNz2Vu42qSy4FWt9EqruTY849zPNAygCUV01gnayixAoenbP8n1quU
         C4fwTVzfewSGpV47XzORGrdHwM/fvb6i1Fzx40MlaXWq2vwSCxbgDaeTnqCGcXwIG5eU
         VEYfaTlYBPB7xccnJYjjStSEluRouw5qO9C6QugGq5Hg8BLLjDk9mxJeZBawMAD4l+Pu
         HP4dFL3mQnhmnbVEpHT281PxEI55SJWBtSlc/pelq8RAInguIjyndAcRnYWGD+BP3au3
         2DVvg5j37RZyjuv5LFvRz78gxQMW7Hjs2yasMzNr9zMGTVBq0FH4CG7kq6Zbeaf5+AwV
         9gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/msuGEuNnK0pUHOBEJBw+yRN6xkWwWdMAXSfLeiswI=;
        b=CsRclnyvy1IbgEYK1Xtm7t4yf/JpLnuac7toquomkcMJewRHzMNUA/KRPVX0EkjX7T
         eHYlt+9+qZwdIgJE8eCu+PkT1/2HOf0/HJNw1xlY3dY17Jht0phCes2cN1nQgSESf0by
         imIJfoP6jUlt+cuvXUNJ7WFJU6pB8ReyhiNbgUgsCwmbVJfylryRhNSSSNwuz2ULCw3f
         GBMrWELtD+3rsP7JcM7DPUnJJQUw534OWZAN1fktoO4Mx4iwg6LifDb04+0P9pqU1uie
         dQCotsqTG0RpDyD2W0Fx38H1WEkwlawljYYMvcRy05rv/4hHaeKqUcXDLanzSzDBU/Nb
         QfnA==
X-Gm-Message-State: AOAM532ICl6F1L2N+15SIYTPiZQfuSu0Trc2vqmOQFsTwxv1WIzjdwgc
        Ql3CKWRZJ68imOhPj1hf6T0FJ/gf
X-Google-Smtp-Source: ABdhPJwAbIT/yKVWudmEJVBOD2j0gNudz1DhZYyBXHKtVlSaKnIFbSQNYZ7a1mcCUbhPaxnjtwhIEg==
X-Received: by 2002:a17:90a:b00e:: with SMTP id x14mr12946445pjq.57.1593573291641;
        Tue, 30 Jun 2020 20:14:51 -0700 (PDT)
Received: from paxos.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe5d:61cb])
        by smtp.gmail.com with ESMTPSA id g21sm3860213pfh.134.2020.06.30.20.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 20:14:49 -0700 (PDT)
From:   Lepton Wu <ytht.net@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH v3] coredump: Add %f for executable filename.
Date:   Tue, 30 Jun 2020 20:14:32 -0700
Message-Id: <20200701031432.2978761-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200630192631.612f79b6226b36630c1429de@linux-foundation.org>
References: <20200630192631.612f79b6226b36630c1429de@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The document reads "%e" should be "executable filename" while actually
it could be changed by things like pr_ctl PR_SET_NAME. People who
uses "%e" in core_pattern get surprising when they find out they get
thread name instead of executable filename. This is either a bug  of
document or a bug of code. Since the behavior of "%e" is there for long
time, it could bring another surprise for users if we "fix" the code.
So we just "fix" the document. And more, for users who really need the
"executable filename" in core_pattern, we introduce a new "%f" for the
real executable filename. We already have "%E" for executable path in
kernel, so just reuse most of its code for the new added "%f" format.

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

