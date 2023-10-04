Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161FB7B7E0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbjJDLTj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 07:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjJDLTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:19:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090AA6;
        Wed,  4 Oct 2023 04:19:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3247d69ed2cso1979923f8f.0;
        Wed, 04 Oct 2023 04:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696418374; x=1697023174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kf65/yVeNmyfkA4lS1pa8yQ0o4/BpEGkDZRgGsIHS3U=;
        b=R15xLWN6GjHcO9jTCsl53ZZB3fKJ9UQ6Vcb70YIu7rfvArk6poxv2OM7FEnlVEzVQh
         s2qAk6acFv1gmuV06eExFHxuxlMqR1AAAU46sKzdgor0pJuk1IN87OfuoMj+hdXuSUwv
         CTmkDVIv9p8t27xeCIjigD6AG1tCnRlnAhmO5fM4UPHQq/e294g6m0oFlyUlXxZGFjws
         K4QnZ8EmISZ30lE2LQcNOvKq4rEQ6C8Tqlje0+FD72OnZGIjPE+RnMq6c+Ag1MtkGm3T
         D3xRVM7VOBgJP5Ep21icx5iYCLx6fMvls0zuW6Zs9K9b3f7KqGHZkDm5nIxj8zJFl65H
         uawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418374; x=1697023174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kf65/yVeNmyfkA4lS1pa8yQ0o4/BpEGkDZRgGsIHS3U=;
        b=Rra/HK/Y3atdHjwDyv41QiikENaqRmraQUbaPQyfzYVLHmHihWwe8N2Sutb+cAUYTn
         PMUQBwT9ppypnLFAvAO3Ih/e+Xw9xiVYJqy3emDSMJ6McOoz8kSWgYccbAwCiGANDDkM
         G34N2U6B8tnDxPLU2WgJSBWP6P95g9EuVQdG17xCUDYqthgVQfDSDjAjgxdYD8jhnc6Q
         /C/E+fIw3YQVbyi3rgERLd8MTr7Ei6nlr0ukuDaWHh+T3fPouJ3727f1u1AxrU3b0mFy
         2qdDnLk6nFmmS4118I85NUsr9IH+NaH2eovncGl+zsy9lCUDt0gmI4dEXsjQ0cu9NKXW
         VJIw==
X-Gm-Message-State: AOJu0YxNgU01VhmcTBLPguGyqC11nJ24c80vnEHPJKXE6l2AE1dYNvbU
        i1PAfC/suqJUnt8IjcqePNk=
X-Google-Smtp-Source: AGHT+IHmTUcZ7mM33uNUbLKb56C+w5MA0UCGPTVksvmyVHoDcFNO+Fk7Slzn+L+w5t3llCzqu5EQmA==
X-Received: by 2002:adf:fe88:0:b0:319:f9d6:a769 with SMTP id l8-20020adffe88000000b00319f9d6a769mr1981989wrr.45.1696418373766;
        Wed, 04 Oct 2023 04:19:33 -0700 (PDT)
Received: from f.. (cst-prg-67-191.cust.vodafone.cz. [46.135.67.191])
        by smtp.gmail.com with ESMTPSA id o16-20020adfead0000000b003266ece0fe2sm3761527wrn.98.2023.10.04.04.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:19:33 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 1/2] vfs: predict the error in retry_estale as unlikely
Date:   Wed,  4 Oct 2023 13:19:15 +0200
Message-Id: <20231004111916.728135-2-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004111916.728135-1-mjguzik@gmail.com>
References: <20231004111916.728135-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/namei.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/namei.h b/include/linux/namei.h
index 1463cbda4888..689b16f3031b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -112,7 +112,7 @@ static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
 static inline bool
 retry_estale(const long error, const unsigned int flags)
 {
-	return error == -ESTALE && !(flags & LOOKUP_REVAL);
+	return unlikely(error == -ESTALE && !(flags & LOOKUP_REVAL));
 }
 
 #endif /* _LINUX_NAMEI_H */
-- 
2.39.2

