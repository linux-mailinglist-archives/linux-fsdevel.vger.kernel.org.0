Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C45653714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 20:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiLUTgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 14:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLUTgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:36:08 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5751269;
        Wed, 21 Dec 2022 11:36:07 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id fc4so39126929ejc.12;
        Wed, 21 Dec 2022 11:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hou+g5LMqLdhP3S9U063kgkc21ScIYSTOPqueDIJ5i0=;
        b=mmusk46HIpgFha6JIaf5MHAN/hLFb8LqiWrfjo8oXGen7aQbi97ZMLKqAiPF/+eAcS
         2oe+CR0Tx4d2eTQsYYglgaKA97AWXIp/YznZJsrHoc7Ato+gAm0qi7du1PrvhETbFbva
         sJLJUlugP9Mj4mDR9Pd8MH5i8A4NSa9Jiy9s3MxV+C7CyRgvPF/OKLYah5u2TMib48N+
         QkhrKqpZHtJbP/F9AxCOHD550vXDorJQGx5FWyE8U3SUIDk4RLyc4t3gUzk6ljS8PwY6
         VBlOUxo5jt0tIwZHQRYHEaYAr1BGPINEKA36tzW7EwKhI5NDXan/x4nydwP/3GRxELCo
         f8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hou+g5LMqLdhP3S9U063kgkc21ScIYSTOPqueDIJ5i0=;
        b=ZAsDq1X3bz0Tv4V32LxqJmyL//DQ09KJmcfIS/hYoUNgptmz07sosTMqugxc/QRVze
         2MgaHKGe7/OMvItvL6wrciTq6nosAbLSSrOSJMBd1IjbzajHEnZGZxsuqWyAnHhjonUK
         jdvmcPCg49uDXZJaagYEcHhTA6rcFaEeHhuDEDvpzky/ShiT8C5fgXtC00bTNVpeAeF4
         +IZYvRbYbut+VJdRaQbC4Rfpv2/GqdLS2XY+0i4ZCVNtY8pe41VEiPgL9JOVvXmjSPLW
         BVVy/QHzgOfMowT88k6tMxtf8WJsNAVKx9tDtB6Qmwj3LHPKYKIv8YtL13A0+Adz88lq
         YGRw==
X-Gm-Message-State: AFqh2krzm5NXjkS2mTqRtqIjCPz1/yEQCPn9EyOaaJeyNxC8gLEpC6XS
        L2YM/dsFOFcjSXZxkc9VOjtz03ITgbpV/Q==
X-Google-Smtp-Source: AMrXdXu/m7JhNC2GO+BzHtrFB5y+jCTiQFMZR053t+ceb0lhMh27OfDAMLhgfbcnqUjoakHZoehevA==
X-Received: by 2002:a17:906:d047:b0:78d:f454:ba46 with SMTP id bo7-20020a170906d04700b0078df454ba46mr2502400ejb.69.1671651365982;
        Wed, 21 Dec 2022 11:36:05 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906c40100b007c0cbdfba04sm7433931ejz.70.2022.12.21.11.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 11:36:05 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] posix_acl: Use try_cmpxchg in get_acl
Date:   Wed, 21 Dec 2022 20:35:40 +0100
Message-Id: <20221221193540.10078-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old
in get_acl. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index d7bc81fc0840..420c689e1bec 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -174,7 +174,7 @@ static struct posix_acl *__get_acl(struct user_namespace *mnt_userns,
 	 * Cache the result, but only if our sentinel is still in place.
 	 */
 	posix_acl_dup(acl);
-	if (unlikely(cmpxchg(p, sentinel, acl) != sentinel))
+	if (unlikely(!try_cmpxchg(p, &sentinel, acl)))
 		posix_acl_release(acl);
 	return acl;
 }
-- 
2.38.1

