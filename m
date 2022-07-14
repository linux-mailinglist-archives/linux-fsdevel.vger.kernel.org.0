Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA4575421
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 19:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239470AbiGNRic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 13:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiGNRib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:38:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B59606B6;
        Thu, 14 Jul 2022 10:38:30 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x91so3366433ede.1;
        Thu, 14 Jul 2022 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu2+SIwToyiijVbo49UhP1kKR2aa55foE/D2/YT55Yg=;
        b=IWw5CaMfCXVmaVCS03FgCetqbph2FBq2DUnPT/8+/8GQMunsfmxv0pYinebZmpiuq3
         Y+ZXXUC12JAPvmVqatMBk5t/MzDjcc7+XhpU2CRuLNYH96ZQz86xc/tmUyb+cZ6A5JoK
         IttW1wUcqf3GZ436e7C3CZLqtT9JV84KIUArFqMXyUFqR7tHznpw6QNFf/qvF2l98Yat
         QlulbkF6P9Ltj3XDWaZVAaf8gAKS5aD1NC7gQh6mcBp6MM79Mt0VC9GrVwYvz8cu6dal
         o10N2lLvoGNqST0P9Pg6eB6vketB+wvZtFehLb1VWg5vPSH6FWJGNA1VuQFNeMOWscgG
         DXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yu2+SIwToyiijVbo49UhP1kKR2aa55foE/D2/YT55Yg=;
        b=f4bJ7gFQDJmm0zXMeUJfYzaXkWueEEMU48liDWxfU/rVORO+g9DYWaPBfSIFG/Ofzm
         GRrZWo2HG37FVRTyJTliXC8hDakwC92waKC9dhFPCeLOJm/IgB3KDZand6Wnq2k5MAz2
         oeLL9vxH3t3OjNl/q8Q6c3XTeOu2qWDB7MECxNIo/YfJZL8qChLRVfxeDuD/HkFdH2R1
         YWVBqK4sHiSutSioLvwwJ+FMzmzwI+s/g85mEY3tTYiILzz0Nf7Z2Mvt83jmVyXvNti0
         qn6R1Y8L/ta8KFIi/PKGXLkmoDH3Ob61HAv8jQUStdCSxe15yHQ4Fmg5pVvioLdPkJY1
         g0Xg==
X-Gm-Message-State: AJIora+r1hgBNDuZvRMJNLeA1K5qync+0eD7/zPcCZFaRUNn0ck0tzQs
        YRuA8hZBzuINfyxDn1P454H0VTQm6WA=
X-Google-Smtp-Source: AGRyM1sp11JRsdFgMZcGctJa6r0ts/rppEWWYSPQdRobSA6f2F4IXltHCnp1Q3lsilwqlAoKnBW2aw==
X-Received: by 2002:aa7:dd06:0:b0:43b:247e:3d6c with SMTP id i6-20020aa7dd06000000b0043b247e3d6cmr5120458edv.407.1657820309353;
        Thu, 14 Jul 2022 10:38:29 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0072a55ec6f3bsm942235ejg.165.2022.07.14.10.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 10:38:28 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] posix_acl: Use try_cmpxchg in get_acl
Date:   Thu, 14 Jul 2022 19:38:19 +0200
Message-Id: <20220714173819.13312-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 962d32468eb4..49a13fd4d3cb 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -164,7 +164,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
 	 * Cache the result, but only if our sentinel is still in place.
 	 */
 	posix_acl_dup(acl);
-	if (unlikely(cmpxchg(p, sentinel, acl) != sentinel))
+	if (unlikely(!try_cmpxchg(p, &sentinel, acl)))
 		posix_acl_release(acl);
 	return acl;
 }
-- 
2.35.3

