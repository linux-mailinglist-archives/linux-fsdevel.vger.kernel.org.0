Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FADF1C9F63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 01:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEGX5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 19:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727072AbgEGX5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B83EC05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 16:57:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c18so7042251ile.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 16:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9TwK4u8Oz+hIVdTAgPTDuNePQX/j9l3iXT78dNtrMzA=;
        b=GSWVCbnYftAggwrWtoofsSVg5KaUUx2c+wWZgyeyBk1u+bCb7nxD9dpZldsclYDu5C
         nX1TB/LfcQ2XeDdI0qzxstB5mqAimi/zyMyP3HLAMdDhpbNd/70j/59+8IbGuIx9uN8x
         mxnl8V6RelTgjF2xQzdPohrldstjbm0beUwI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9TwK4u8Oz+hIVdTAgPTDuNePQX/j9l3iXT78dNtrMzA=;
        b=YnzkeVhgxYWW4Dgpvfnrnx5jw9nskVuXrrj/r4Wz8p41qkIpoeKOov7+b4A51Qknwo
         R7daHIg491qGpGYa7A2mnQ3dJ4J6xQtSDs7MMv42ku/crEtxvQdcUrVRExYk3aHcGrgv
         OvK3jrCjPPeX/XURSHc0THGWn31fUOFhovt2QMeycP2yR0WhGw8b+yKg93mwp2TdUNWN
         v82Pa4zNpbIVssqsdWc5/OAP4hNrmUwuha/uTsqF1gETArTkGgm2q4ElbYOoO1Qtccbu
         tG3RdSwuF1amw8TILs+SDlcPCV7quksd+im/fPhNLdpZa811F5MMc5/CP/ktLK8RJKF1
         8hqg==
X-Gm-Message-State: AGi0PuarAYwwS4ehESkBEnAoFTzvS/cZ3w3CdJa8WhR/up8lQDyrJ7tW
        lLWeOUithhLofTGDAIV6NQBmFA==
X-Google-Smtp-Source: APiQypJBM1xuTwXEsrDaqEq1u3eTWKXejiZiCER3XjowknHOSmHpGwOENdMMt20RM9A8e6EAv2euKA==
X-Received: by 2002:a92:607:: with SMTP id x7mr15916103ilg.218.1588895835927;
        Thu, 07 May 2020 16:57:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f19sm1369893ioc.9.2020.05.07.16.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 16:57:15 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk, zohar@linux.vnet.ibm.com,
        mcgrof@kernel.org, keescook@chromium.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs: avoid fdput() after failed fdget() in ksys_sync_file_range()
Date:   Thu,  7 May 2020 17:57:09 -0600
Message-Id: <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1588894359.git.skhan@linuxfoundation.org>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
in fd.flags. Fix it anyway since failed fdget() doesn't require
a fdput().

This was introdcued in a commit to add sync_file_range() helper.

Fixes: 22f96b3808c1 ("fs: add sync_file_range() helper")
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 fs/sync.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff010bc5a..faaff835ef12 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -369,10 +369,11 @@ int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 
 	ret = -EBADF;
 	f = fdget(fd);
-	if (f.file)
+	if (f.file) {
 		ret = sync_file_range(f.file, offset, nbytes, flags);
+		fdput(f);
+	}
 
-	fdput(f);
 	return ret;
 }
 
-- 
2.20.1

