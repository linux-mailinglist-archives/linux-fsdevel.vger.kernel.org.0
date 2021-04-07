Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0142735753C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355761AbhDGTz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 15:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbhDGTz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:55:28 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8CC06175F;
        Wed,  7 Apr 2021 12:55:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dd20so15107281edb.12;
        Wed, 07 Apr 2021 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TBNRySCI10FxrjiNQBsHSAQLIpLS2uNRCuwmQV6Ng/4=;
        b=PUNm7oipNKrzDTqheuwlgAIXg33l4OCmPsex10//cjvpaoRQuNZkJY3P/q+9OOVfrT
         9nq4cWT48T7G7JY7O/XIkUWQMed8FjRDOJbmL1MsRsj0xIlGNogWiQaFqQrYMiPxSHZf
         mdvL6Bm3QJGk22sFeqrrLL5TjG5S/0t5zdk3ZeDzYxZQ4ETtcOSwTOWGwY0lxNa9TYSh
         s2BI8yWYzRIkWPWlZQTXkiclZhbs5rVCuj/k17AOZE2vPCLpqAs/AcFblX7OjSzW4+cM
         P2pgxUrHy5u14Nn60L7vxQNaAX12s3J+u+tybpMD7Qxk7u841Ryi1roVf6PbhQ1fjPWa
         M+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TBNRySCI10FxrjiNQBsHSAQLIpLS2uNRCuwmQV6Ng/4=;
        b=fZZRiYB3PiDkfffLl8NgsM1SgjjTG1HJa4W0fKi/C8DDFiSd5H8kUFhgF57dmr+ed8
         D72t2TuMHsPUQN33j7OWjogUa5iqjdrJaevsClaptvDNk4EZV3ZZY7/k8wSk/KH0D//k
         6e2uvWTBGFhetZgJT8pXzh8K+VkVjfqGlGdKiQA4QbQY5v5KlKn5s1Oc4FRFRe4VmfRP
         cblgIQewhedB4uowNIfoB243OSJRi+EFjUHeY/ju5DCk7G3UtjWsByD2icf1Rs3j0/yO
         x8IjgU/X5Hi6bcgJstwzQuJMYCw9sB/W4R7/dXAuFx1bN48aOuFJyVMtYocHkC/ltYE8
         TuUA==
X-Gm-Message-State: AOAM533IzE0jXU1aaAE8Hr/JZfE3Ev/43U5yGwP57URKaCFR4vKD8n7e
        FTMMebjXeUN8DANOFdmLlz88xkPvxw==
X-Google-Smtp-Source: ABdhPJwpYJJrO+3bC9FbqXdWVgcLE2mosMuypaqZvvvt6gnWf3IDNgqCojWIi/txPMUNxI9+0yptYg==
X-Received: by 2002:aa7:c0ca:: with SMTP id j10mr4271260edp.291.1617825317121;
        Wed, 07 Apr 2021 12:55:17 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.73])
        by smtp.gmail.com with ESMTPSA id z4sm3377985edb.97.2021.04.07.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:55:16 -0700 (PDT)
Date:   Wed, 7 Apr 2021 22:55:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: smoke test lseek()
Message-ID: <YG4OIhChOrVTPgdN@localhost.localdomain>
References: <20210328221524.ukfuztGsl%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210328221524.ukfuztGsl%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that ->proc_lseek has been made mandatory it would be nice to test
that nothing has been forgotten.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

		May want to fold into
	proc-mandate-proc_lseek-in-struct-proc_ops.patch

 tools/testing/selftests/proc/read.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -14,7 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 // Test
-// 1) read of every file in /proc
+// 1) read and lseek on every file in /proc
 // 2) readlink of every symlink in /proc
 // 3) recursively (1) + (2) for every directory in /proc
 // 4) write to /proc/*/clear_refs and /proc/*/task/*/clear_refs
@@ -45,6 +45,8 @@ static void f_reg(DIR *d, const char *filename)
 	fd = openat(dirfd(d), filename, O_RDONLY|O_NONBLOCK);
 	if (fd == -1)
 		return;
+	/* struct proc_ops::proc_lseek is mandatory if file is seekable. */
+	(void)lseek(fd, 0, SEEK_SET);
 	rv = read(fd, buf, sizeof(buf));
 	assert((0 <= rv && rv <= sizeof(buf)) || rv == -1);
 	close(fd);
