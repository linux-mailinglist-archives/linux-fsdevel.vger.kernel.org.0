Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB5224271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgGQRoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgGQRnP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:43:15 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666EC0619D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so6752788pjc.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wrxYLXP2oheEEaGsKNp0stRrknyVueRaJu8i8kSptew=;
        b=Vmebw9xzyFrFLgnwLQyPbu9sUxIvT3iz/LZhlggPZzdK8yi/sNJp1ISZhzAODP/aQq
         DA1aJsmMOF5WM3+KxOc/jJOdCUMwDEegiUHYTk5QHuuuSDkU5ULxP6uWFu0Zgzte/hrz
         inlXJ3TzZ7dygl/RRmbqjrIF3idceAZR9MaU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wrxYLXP2oheEEaGsKNp0stRrknyVueRaJu8i8kSptew=;
        b=CcvxK6x2PMajV5y3yMy2Yra9a0OkJUgZbH9eddQjtDOXWcqKbjL7kWgnriuKEawekI
         z05FPcbkkDgbSSKoktvRckGTj+e8y2o3Gmod5LM9PbVuH0LQZNaIqT8q0IrDVr2Zmeb6
         y+9ER3cOEAxFer+fHTCFcw5eKgQVaa7Tkd0p7eWn41OTaXuDkwT6xIJWqYoIgVCIPWdZ
         0QrdMw46eix5FjZ8m4n5Ru15GtpfWRZnZ9zuVrc+jlYgJshfp4VAqf9NKwjFj2cUAM/E
         NYmEct+cVIO3ZIxYCAXukluzXX9XVifKFax7isuzpxqmfaJUVu7tJtWrQMAxrnNBNL3C
         gg7g==
X-Gm-Message-State: AOAM532/3A1QGLc9TodFhcfWPR7Xq1v1/3AeE62Nh6MyK1kqxg3gaNVa
        JDNW4H4VvSIfRqMRiDStw64TBw==
X-Google-Smtp-Source: ABdhPJwUg0XMxYDUbRjKGsYc4z6GZTjsdq+bfOADQJjU8WjIWVN4iFhFlTSQL5o2BTwLAVb1iIGijw==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr11275946pjv.139.1595007795012;
        Fri, 17 Jul 2020 10:43:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm8187840pfd.133.2020.07.17.10.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 10:43:13 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        James Morris <jmorris@namei.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jessica Yu <jeyu@kernel.org>,
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
Subject: [PATCH 01/13] firmware_loader: EFI firmware loader must handle pre-allocated buffer
Date:   Fri, 17 Jul 2020 10:42:56 -0700
Message-Id: <20200717174309.1164575-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717174309.1164575-1-keescook@chromium.org>
References: <20200717174309.1164575-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The EFI platform firmware fallback would clobber any pre-allocated
buffers. Instead, correctly refuse to reallocate when too small (as
already done in the sysfs fallback), or perform allocation normally
when needed.

Fixes: e4c2c0ff00ec ("firmware: Add new platform fallback mechanism and firm ware_request_platform()")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
To aid in backporting, this change is made before moving
kernel_read_file() to separate header/source files.
---
 drivers/base/firmware_loader/fallback_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index cdd2c9a9f38a..685edb7dd05a 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -25,7 +25,10 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (rc)
 		return rc; /* rc == -ENOENT when the fw was not found */
 
-	fw_priv->data = vmalloc(size);
+	if (fw_priv->data && size > fw_priv->allocated_size)
+		return -ENOMEM;
+	if (!fw_priv->data)
+		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
 		return -ENOMEM;
 
-- 
2.25.1

