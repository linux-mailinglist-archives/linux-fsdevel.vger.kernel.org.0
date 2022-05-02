Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F31517381
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 18:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386118AbiEBQEe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 12:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386085AbiEBQEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BB2BC36;
        Mon,  2 May 2022 09:00:52 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so28633158ejn.2;
        Mon, 02 May 2022 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2cuWhtEFDWCw0M1thTdIDK+Lrjn8Xq8oIQYzuIXLNM=;
        b=B/jFc0dgvU4rLIijYcjAYPhNSyAA2XEeti6rqqaqgUKnfqSyNGkSTuJWkVpUMg9DcF
         /5zodbuLQXCoqox6FoS/SrkbczNv8bBAjJlXWj+FoTn4rTFJRSCYE3q/46axoP0dM4LB
         nAba23GcXVj3abmwd8/hYvdxRgM+Q+BEU3gAIHz2XMcvb6wCWtbDt8aj02OO+GdtJJKR
         Y8pFlJU1c24IKo0d5VJaCdfKBliBJczdN3RadPeA/9ANRBAlDU3ZUdxU/GhzXOMZvbFE
         QcBQqCletIqq6ejODIEyTAiuWryeJCZKQhOiq+DC43902jtWzgej6yzsdev8Rw0jb6Dy
         SUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2cuWhtEFDWCw0M1thTdIDK+Lrjn8Xq8oIQYzuIXLNM=;
        b=lVE8m034KXIPz6K78dPwpAzPhMdC+DcKY1x2oJOM1hv2XyJ0F7ZCwqsKBQv7OZ/suG
         yutlHuarNa2QCv9yVgvvTDugMWX/JlNGfhI+jl8eruuDLY3cTUEexYHelYMx2CMHIxXS
         Y+0A8pgxppYl6zMxlqgKmLyQaRsgkQL6AqbreUdwt++Ur7ZoeVqsXuLuKSutlQC0AfU7
         SsjAV/tOmnPDfrcFe42bZj+94MpmKGNX1lMLHKthA+mOY/quaoUvAn5BtAtR98lJFDs3
         uovNBgXNY6dpYlXAYQBjdI2uQldt9Y5fFk2Sct8X15JfJqvfeWa9IYv0cGfls0ucIBo/
         DVLQ==
X-Gm-Message-State: AOAM533FF8XAMeZZWj+e7jvJYB/jtdASUYI+yUPiCvdyiJ7huz6wLwIm
        Ca3f4bfmP0K48l/ja9dji+QEGqWfN+U8vQ==
X-Google-Smtp-Source: ABdhPJz0dt1kxLPq+BE06YzfNnYIREP0oVLmyhYVUHgcj6cjzLLyYPDKuN/mYNLWKy7yfhhiMo051w==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr12175209ejc.516.1651507250708;
        Mon, 02 May 2022 09:00:50 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006f3ef214dd3sm3689996ejl.57.2022.05.02.09.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:00:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 5/8] fs: use new capable_or functionality
Date:   Mon,  2 May 2022 18:00:26 +0200
Message-Id: <20220502160030.131168-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502160030.131168-1-cgzones@googlemail.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
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

Use the new added capable_or function in appropriate cases, where a task
is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9648ac15164a..d91a2bdc837d 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -776,7 +776,7 @@ bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 
 bool pipe_is_unprivileged_user(void)
 {
-	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return !capable_or(CAP_SYS_RESOURCE, CAP_SYS_ADMIN);
 }
 
 struct pipe_inode_info *alloc_pipe_info(void)
-- 
2.36.0

