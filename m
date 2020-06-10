Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31BC1F582F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgFJPtb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFJPt3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id s10so1172047pgm.0;
        Wed, 10 Jun 2020 08:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qSIwN4KZGofFPlUal7btJTGNfkPGbkCJjMaiuCB3kq4=;
        b=idX9HP+xbdH5W0ymKxrXC5TgZruF6m/3aFicOX7DGbsOqw7iARid6WHbe7UFklwcN+
         UTdizeWKK6JQ3BGDKSEoDT8efVyqudWIfDcNi6HYhppjzKka4OBhLSvyUSYj5/sgXg/Z
         2X8VrNRK9AbhalAoYh/rs6LbVw2jNbWyNUldpkGjA1Zdpwpv25VQirAJ1E2yWtJWk+6o
         2mlUnj8fcwp2wDwlLebwkGONyhxKkorTdy3YzbKt83cAw08TnZcvTKXhZNTKRFrld2D1
         UmsIZQwEyBLtWp1nmdVrHDjIAoVEKRAi9uPi90aXUjBpsZF6fH5gOosehGgGCH/vEW4R
         AZYQ==
X-Gm-Message-State: AOAM530jWXWIfpGEOMbrSHH+NLw0fxVgiKvMIHCdWUzrMIi24keGlo7J
        EvBMxk+nUl8vuxtKsq9lS1qppR0e/21v6w==
X-Google-Smtp-Source: ABdhPJzQjKy64D7JAY2b9Df/J8XTTNXeIN4ec7JdMHHdnO0cu4EShFKvEj31fLfQzVASTIHoxJ1AIw==
X-Received: by 2002:a62:4e91:: with SMTP id c139mr3418995pfb.18.1591804167551;
        Wed, 10 Jun 2020 08:49:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 12sm338947pfb.3.2020.06.10.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 606C741C23; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/5] test_kmod: Avoid potential double free in trigger_config_run_type()
Date:   Wed, 10 Jun 2020 15:49:21 +0000
Message-Id: <20200610154923.27510-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

Reset the member "test_fs" of the test configuration after a call
of the function "kfree_const" to a null pointer so that a double
memory release will not be performed.

Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 lib/test_kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kmod.c b/lib/test_kmod.c
index e651c37d56db..eab52770070d 100644
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -745,7 +745,7 @@ static int trigger_config_run_type(struct kmod_test_device *test_dev,
 		break;
 	case TEST_KMOD_FS_TYPE:
 		kfree_const(config->test_fs);
-		config->test_driver = NULL;
+		config->test_fs = NULL;
 		copied = config_copy_test_fs(config, test_str,
 					     strlen(test_str));
 		break;
-- 
2.26.2

