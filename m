Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A425D224234
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGQRnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgGQRn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C89C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so7016188pge.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=UNF+N5tGImRXK7U8tW7Qt2o9FhuhZJSQ7KG3fVlP2CQ6VrEJi7uXvLxkYsb5D3GAbE
         GJmS1WNe9406vs8ug4lR/fhP3HZT3NvzCd6AL6BzxcMsVwi38lSG8yFN/BvHOc+G+SvL
         Vt88Tb179Kyjrl+HpGQoMdwuRxJV4oP68QdHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snum0LDOOmwoCERcfxqLkgilyaEMJiIllHC/Y59Q/IE=;
        b=r+WGdiQqRt7/5HWbEY+0T1y3K+DyPDo5WX1AvGgVxGeIRwYV+lKkMq+xkAbMfi37w3
         yfslv3o621OQpredzCGZkR/vK+ujPPfJjySwO9REr0OX3j4y6M/se1CUP3TK8oH7XgGB
         LKODgqPG7j16bHTMSa+5bfJEDm3ccB02qU1ej1MGX1Yc9+QkKGBX7pVb7flSmuLNfJi/
         v5dllpPbGEDWzYNkat1k3bzz3cAavSI5OU9zTj5Zc0UTKhxmcEmZ4zWETToB5SZ++TdU
         psYmC9IXUmfoUdvqWaqffB7/oVcqo0YM3ILCFzGaL7bqSndxIFiBTdXBIFXqTOyGsYAO
         N11Q==
X-Gm-Message-State: AOAM5304cGqEjjumnvRsaN1qbKDYSx/4//jpSun2GB8yXdYySxKOXU22
        MMeIYiiiB9w3mxNx4HJS1B+mMg==
X-Google-Smtp-Source: ABdhPJxwiYy1pNbGhgekK71siqfw6L7iDLfIXzNjN1uAiDqjIEPDjHUjJYYFf3Ape9IP20AJboNQYg==
X-Received: by 2002:aa7:858c:: with SMTP id w12mr9691555pfn.143.1595007805407;
        Fri, 17 Jul 2020 10:43:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u23sm8311155pgn.26.2020.07.17.10.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        KP Singh <kpsingh@google.com>, Dave Olsthoorn <dave@bewaar.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] module: Call security_kernel_post_load_data()
Date:   Fri, 17 Jul 2020 10:43:06 -0700
Message-Id: <20200717174309.1164575-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d56cb34d9a2f..90a4788dff9d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2967,7 +2967,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2977,11 +2977,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

