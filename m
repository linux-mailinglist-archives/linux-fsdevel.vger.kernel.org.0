Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F94E5F84B8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJHKJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJHKJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103FA19B;
        Sat,  8 Oct 2022 03:09:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so11388911ejd.0;
        Sat, 08 Oct 2022 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUBbOEFW53KqYnQJv0OgmvKNjQw4g+0MWXRaawv7+iQ=;
        b=jRLnIgZeJgeAIfPETbUfVElQeRfUwoEc8v1pTrgHC0xgw7C6ONQ+FJFE0n2d9uoeV0
         E/OgcdtCGBRK/5EBVsnTeARRNCK7pO3CIEjGACj3eAVjiuh6blJ9zV5JLHqlcIusUUgO
         hEJLYl0uN8grRRbaxmiCxJ822afnNJomqfb/QufkWjeIHOuoGkb6Qm/XSwPMKhS3J6++
         3tAvUqn5pU6P07c9UJr/4QUV3J6mX83OUmsfwnRgVfQuJo9io0KpSvnn0pNgB2d3bTP3
         1gwgc5MGKX3Mkg681S6aVWsMRfaSfh67JPPpKwdwgqCvOCkXwIqgzQJ5szc87j7yQBPm
         5Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUBbOEFW53KqYnQJv0OgmvKNjQw4g+0MWXRaawv7+iQ=;
        b=fYUwA3z3NvgUruLgLV4mn1v1zXezm0ad/kUeL5e9wmBQjsMfB1tBjhWfzbXhMOF/4+
         3OPoelf6FqfQtlYo1r6jKDJ7lqgTImANrCYSM6h7zf0F3N4PUdx+JJNqbxZVtZKhu+2b
         UaTguhoDr9Ly020KTS4pB9117CdOVughgw8nVyY/I12Z/GO84SfVEed5knXHScbx0vPb
         waNs2Weu9ztvsVAtpxraHL7HSSrfsxT+/QMaElDp5k9XC3B4uvhlQZcJwYBDvdrydyNp
         7FC78JPRzGg2T77971oLZbX5z1YBiZzmY+thTCtnCoSH+vmZnDBHyKt54Pxbvgov/rvV
         jiPg==
X-Gm-Message-State: ACrzQf0tQiE+lZgex1ctYgj4qs0KhiS151Yru7uyxeUIkfvMO7k5w7sd
        N/v+B7MFsWoWkCZQI1syErJlv0Mr7qY=
X-Google-Smtp-Source: AMsMyM4tMFLBbfK2cQ86s9DSUgDTx93BFsakbl9XwOeVAF4JC2TcZaInKndfbApsKi1wW6i3/gZQ3w==
X-Received: by 2002:a17:906:cc18:b0:78d:8f26:706c with SMTP id ml24-20020a170906cc1800b0078d8f26706cmr3077141ejb.424.1665223781921;
        Sat, 08 Oct 2022 03:09:41 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:41 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v9 03/11] landlock: Document init_layer_masks() helper
Date:   Sat,  8 Oct 2022 12:09:29 +0200
Message-Id: <20221008100935.73706-4-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008100935.73706-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add kernel-doc to the init_layer_masks() function.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/fs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 277868e3c6ce..87fde50eb550 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -297,6 +297,19 @@ get_handled_accesses(const struct landlock_ruleset *const domain)
 	return access_dom & LANDLOCK_MASK_ACCESS_FS;
 }
 
+/**
+ * init_layer_masks - Initialize layer masks from an access request
+ *
+ * Populates @layer_masks such that for each access right in @access_request,
+ * the bits for all the layers are set where this access right is handled.
+ *
+ * @domain: The domain that defines the current restrictions.
+ * @access_request: The requested access rights to check.
+ * @layer_masks: The layer masks to populate.
+ *
+ * Returns: An access mask where each access right bit is set which is handled
+ * in any of the active layers in @domain.
+ */
 static inline access_mask_t
 init_layer_masks(const struct landlock_ruleset *const domain,
 		 const access_mask_t access_request,
-- 
2.38.0

