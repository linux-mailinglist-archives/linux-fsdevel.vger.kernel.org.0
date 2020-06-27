Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675FA20BE06
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgF0EBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 00:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgF0EBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 00:01:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9724C03E979
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 21:01:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so5321024pfu.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 21:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuWNfB9J5cKofNh6e32vZrw9c4lUQhO5mRpQex4fbT0=;
        b=fcWusuvpvJ9/LngHXlbOMA6vDdeGevQfnKNHs6Z9Q7WEJypLI0b58xoVXZQOk/Qdea
         Qwy0HC/qfxv3qAaITbFkjWOEa6Txc/br5fo/Q3Err8U1bGOsHL5TXx7W+q5euwWzcfnF
         TX6QHOFGzivxf9Lva25iHzK6dRUBncvTfX9QyTMKMMezbMf5V5yKKLOKC7LXDMoHi3yt
         LSNHG4T2esM3dcqa0pLzDX9crrNCPbRixehCYpGx9cdSMcJfV0xQ77DN9mOBMn7FZG+D
         siOLw4nAFfjkon5EAEll2fTR5YqNhEKTwiayuObb+/kzakKVAKrb3NjnySW4A5Y86aGk
         mTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuWNfB9J5cKofNh6e32vZrw9c4lUQhO5mRpQex4fbT0=;
        b=NrtAgPcf8lJ9Tmfxx4e/1Fc1xoCq/74+y3fFEmPtm/U+x0riFrcGkb4mUsN9eeeu46
         mn77+hrcL1NhZFycCbkxV1faplut49dgHVvbyKkH7YAL7MoJACkpMBHw8w3uMi8o/ROs
         A9qvEekx9k0eh/fHHwvF4pXTiXeJ8Czfdf8T2Jdr618+jpz3Ubooig2ROHsOF+ZdluQG
         mQm1VeeLVphgO+3dUM5S5VyoP1Ugg04n38ZIiUOWGKpxWKD9JyhhT40bbAZA4ZxrRwvf
         X9N3lfi2e9qxhwf7gmcuHfdS/o+qeRdKBRMC4W9paFV0URCCOdZ/G+0gvOBZrSPxxHB1
         FYhg==
X-Gm-Message-State: AOAM532cl/3ZNcTE/usssiK7cxAzKphvFQlU181OFmwVMNGZr2Gl25Mb
        MxIelnw+BidzL56SKeXi2bDxPkWW
X-Google-Smtp-Source: ABdhPJyiyyFbYodKOrBdnp1Mq064sO0x/gV+Im2zjARfYqnAkoWtUiZwEQ8pkJ5kZvq0Q7FzgvxasQ==
X-Received: by 2002:a65:594b:: with SMTP id g11mr1834460pgu.168.1593230470985;
        Fri, 26 Jun 2020 21:01:10 -0700 (PDT)
Received: from paxos.mtv.corp.google.com ([2620:15c:202:201:31a4:f84f:da5f:97b4])
        by smtp.gmail.com with ESMTPSA id b71sm17654777pfb.125.2020.06.26.21.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 21:01:09 -0700 (PDT)
From:   Lepton Wu <ytht.net@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH] coredump: Add %f for executable file name.
Date:   Fri, 26 Jun 2020 21:01:00 -0700
Message-Id: <20200627040100.1211301-1-ytht.net@gmail.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
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
 Documentation/admin-guide/sysctl/kernel.rst |  2 ++
 fs/coredump.c                               | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 83acf5025488..f2994cdbd57f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -165,6 +165,8 @@ core_pattern
 	%t		UNIX time of dump
 	%h		hostname
 	%e		executable filename (may be shortened)
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

