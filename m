Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36C221682B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgGGITo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGGITd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:19:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3620C08C5DF
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2020 01:19:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k27so3577828pgm.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2020 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8LzHvhyH79XNraI64aGNs932IW1tYhCTGhfJh2lEVIw=;
        b=d2fuJhBs1yWbjePYoqvJWYZe1SRSJgbjp553u56FFd31yWYbHWdQauk74RXaM6QK5Z
         6wtktQwojSEogkmCtIrko7hYiDkU9vh+r9y+G9YbC23l+ldCh74l7x4YprTb5e1AAhlW
         wDajPTrKHOXyHe/oURDusoQV86iqeDJZ91LRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8LzHvhyH79XNraI64aGNs932IW1tYhCTGhfJh2lEVIw=;
        b=ddDwuMkqSbF0DswzYQ7DxY84tqglcbRNE3bwmbrySogkDD7QXjQOu4Rzs41+A1u6Do
         Ovy4A8Es3l6tEWhEcdWUe1tTbwbfmxzZd9bs0rFcdE/imdr2Kaw3axNJ/0T7KbIrMIZu
         fJqGoGv5W9Dahi8qrp7xQRhFE1uJHp9GfXCw2ICmseg4DpeNHGcSj4OJNLhyEw3WmVX1
         eDb6GUhyiSjEM40MmNRyVgGGXo0eSLWBNNHE1H+9MpfxRoAX6IXvhI+P8P17uw9fE/eg
         i2/z6Swd7qGwHWaxExEqorlxt6IYd64EIgT57OrrQoXBmxHAlnTRySXIZEHVsIhOMias
         9Y+g==
X-Gm-Message-State: AOAM531nRP03puMuLC6/JGVHSuYh8vH3KfEICxZ5IjvXnL5u6/0L7f7X
        Kjt8kMrGjgKe0A2IBxYj0pKWcQ==
X-Google-Smtp-Source: ABdhPJwlmQnAhT5yC6LPH3rR/m0Ap5gtjZUGRRbIWoOIwPOnnsVXMjkjdE7a5NAxP236CA/vqMmsAw==
X-Received: by 2002:a63:2b93:: with SMTP id r141mr43550710pgr.171.1594109973034;
        Tue, 07 Jul 2020 01:19:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s10sm1821622pjl.41.2020.07.07.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 01:19:30 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
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
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/4] firmware_loader: EFI firmware loader must handle pre-allocated buffer
Date:   Tue,  7 Jul 2020 01:19:23 -0700
Message-Id: <20200707081926.3688096-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707081926.3688096-1-keescook@chromium.org>
References: <20200707081926.3688096-1-keescook@chromium.org>
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

