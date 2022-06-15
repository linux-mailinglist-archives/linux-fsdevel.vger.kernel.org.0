Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1045454CCB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349653AbiFOP0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349650AbiFOP0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:26:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594E13C732;
        Wed, 15 Jun 2022 08:26:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id v1so23895655ejg.13;
        Wed, 15 Jun 2022 08:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4F/tLpmbmUjdLbXnGXq4pBAB6Et74UQHxOQ2aUyA7m4=;
        b=JHmoiqlAyf1dYxYP35NhIu+dOSPN7gOB9yv4WWTSIhzyi05IUx1nbo4ywVEmAClSup
         2OFu1xrcqLSKEd9QfPRoqp1CVx/cCyJCrW9vBK57yUws/htRXKjYtZJ66/VDRSX34XFf
         bVFJpMmL1173CJDylNcw67iRKZMgE+oxZRkgjybLUU3DFTFpPa8I8oUQxcg1wq230HSh
         Qe+88kEcHf55q2F64wTw1iIvjISYn9MFIhrEp7IauG+iWU8tcp60m+EoOqg9/UzAJSMB
         +AYmZ/sok96YpNEuLrYdkdMgpNUDXce19Jqu4bDGeBgeA/4ehMd/aBsYtpHLiGQ+97H2
         R5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4F/tLpmbmUjdLbXnGXq4pBAB6Et74UQHxOQ2aUyA7m4=;
        b=d+K1R0DzjteGYibGq43tCHVZDwDQtbGQH6U/8XPMgG3YbghlV18BmNYjeVe0gbvN37
         3xtJ0eDb19b556iUh6A+U3EZCCIAxvoI9CuDbO1VxduOW3McivYU+DtzLwuD88/zEKTg
         BohIGbzvTYDTSDjJhRe0SFf9g95TJ4FIVS1XYOOCfXXt6IcxKF4iRcRSe8ivZlZeNLXP
         V6a7+eYdEk9rz2ddAe7qvocmtvvaVz5PLJtdZVqt3kyFRFwsr3+bd+3fTJ0oe7PltEy1
         6qjh0bYtrYNDILhvh9mKATePDxvDZb1+mU04IrK87qjPFimKfH6exOA4zYk8mihBb9Aw
         z7SA==
X-Gm-Message-State: AJIora8anqQDOSaEk6pGh7jKkjNMf1r7+6qGvDVwOBKDCxiVW8kA5hpm
        WIkMoJLTmiyv5VtrZ98ooLDfF9SviSEuzQ==
X-Google-Smtp-Source: AGRyM1s+Xm+S5cqHLm8dYnASFxeHOahemB9JyKRhbpBV0LSorhGdjx4Rs5x7X7unE6tijHHY0VjkpQ==
X-Received: by 2002:a17:907:7f14:b0:70c:67d9:7758 with SMTP id qf20-20020a1709077f1400b0070c67d97758mr309134ejc.195.1655306804896;
        Wed, 15 Jun 2022 08:26:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-151-196.77.3.pool.telefonica.de. [77.3.151.196])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d9ce000000b0042bc97322desm9501224eds.43.2022.06.15.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:26:44 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v3 5/8] fs: use new capable_any functionality
Date:   Wed, 15 Jun 2022 17:26:19 +0200
Message-Id: <20220615152623.311223-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615152623.311223-1-cgzones@googlemail.com>
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
   rename to capable_any()
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 74ae9fafd25a..18ab3baeec44 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -776,7 +776,7 @@ bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 
 bool pipe_is_unprivileged_user(void)
 {
-	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
 }
 
 struct pipe_inode_info *alloc_pipe_info(void)
-- 
2.36.1

