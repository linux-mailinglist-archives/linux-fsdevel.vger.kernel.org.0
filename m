Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E6605B95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJTJ4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 05:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTJ4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:56:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43AF48;
        Thu, 20 Oct 2022 02:56:24 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso1777069wmb.5;
        Thu, 20 Oct 2022 02:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V799u1OvsFy3rfEiYBMkwUXRRFdL63Meg4qL1Gy+Szw=;
        b=gcD3x1hzQYTUcUyKQ5yQINSy9VGeO+QxvYJbP3bVZrsseQ4Hq0wWRQ6iCaZEYzJOfJ
         oCN95yvunqzlcdaa7BTDHGyBXqN3Cg8i/uDYjpGUAwqCto9X9yxyWUHZLwDJdG5FmZ83
         c9BQr08Z1gep5B1Sb9wS+M3/r/xE8/UrO8gobkPFp9VygNnoPshRT9s5n8SZ4qM0P3qU
         JCT2tFzS3kAFFbOaxWH7Yp3HNRG+JvgCL8HBALQFKwvn9tA2OxXGU1757fHqDkwNARTw
         P2JaqRWBHPGazzm1wGkLnO7xPMUd/NVRKAC9d+ahvvwXrpCwPqhLGQyVSdM/yStmyDiS
         cI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V799u1OvsFy3rfEiYBMkwUXRRFdL63Meg4qL1Gy+Szw=;
        b=2mow69DIeNl2EcRx4Ie3LQeY7YR8Rr4BKh66mvoY5vFw0Qm6wbbI2y83I7xhZ6zU5I
         9bYphNJhN69xfQRpvnNZJtacCL5x4xmnyrRnjuertpE3GLVm+JISTpoMUILlls6KidBo
         95XkxX5agZ4MHtH4dzsmujf+Ip9aDExntgCurZXRT+h5PxPVlG4e9dOYkLcbQ1+NfLRZ
         qYVzwcnkdWTdc5t+xuWjF5CKghAL/XpL0wv8vVKATe6FVslL9jXbxhB6qAeeNxgN900r
         +37RMmb813Ayb6LmyyCx08pmzSnIprJJuhKM47JCwnKManatP+c+zosg6VJ4Jjnqv8qb
         ynRw==
X-Gm-Message-State: ACrzQf3G5FRZoW8Sh1LSdSBZWIxi8FO9SNIISyPoe/7/EpnfDHCMR8tO
        6k8TbpmfC6i+JGsE4pCLAOKKZ45q0g==
X-Google-Smtp-Source: AMsMyM7Hujj1IjiZO30V8UCMmrLinVw+He6y5oyCzTWWvo2+XlZulqjTq++cTFLaOEMxrYLiLovVKA==
X-Received: by 2002:a7b:c398:0:b0:3c7:87f:3b48 with SMTP id s24-20020a7bc398000000b003c7087f3b48mr4134400wmj.65.1666259782655;
        Thu, 20 Oct 2022 02:56:22 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.126])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b003a3442f1229sm2703510wmg.29.2022.10.20.02.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:56:22 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:56:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH -mm] -funsigned-char, namei: delete cast in
 lookup_one_common()
Message-ID: <Y1EbRNxRnZ/42G9x@localhost.localdomain>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1EZuQcO8UoN91cX@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cast to unsigned int doesn't do anything because two comparisons are
a) for equality, and
b) both '/' and '\0' have non-negative values.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2657,7 +2657,7 @@ static int lookup_one_common(struct user_namespace *mnt_userns,
 	}
 
 	while (len--) {
-		unsigned int c = *(const unsigned char *)name++;
+		char c = *name++;
 		if (c == '/' || c == '\0')
 			return -EACCES;
 	}
