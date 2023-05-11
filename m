Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912906FF434
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 16:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238200AbjEKO13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 May 2023 10:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238264AbjEKO0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 May 2023 10:26:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B310A1F;
        Thu, 11 May 2023 07:26:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9619095f479so1394099866b.1;
        Thu, 11 May 2023 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815198; x=1686407198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COA3OKhGOWcRWHzvnj/0MR1RJBS6NTQDYtZ3E92nD9k=;
        b=KprNXu/0rjC72VYIYbLSUyTkcWBQ5X6n2YqUusFCTLphcDoM4whOOylOtBRBO31LJm
         tecL+59ZQHLa98Ej5kve9mTf02PRKA1IDaBFXmLnDhWb34ivlXQmmnAOd1n9dir3vg5k
         TZgccFs5V0k8f1j44UY/WAim3TzSOA/qS+EsOLGyqdxgvuLFge8Yty7M4CnMd1iENzQt
         rcuWf2y/0AA7uls97GtL+ipCeJQVry5uZIEe7WIrWCZls9hLraORJDRSMUER3iLvR9+b
         UE9Kh7Iy2uC8BtGrX7J6Rt3NV+doenwkdkKGoU1ECfMb1gkzfzSHkFXGHudBU1D3QK0M
         FRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815198; x=1686407198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COA3OKhGOWcRWHzvnj/0MR1RJBS6NTQDYtZ3E92nD9k=;
        b=cMXvxIQsHSJBv83Y1WdvFqM8fsu/1xDc0sIzYzBJP8BMbVFy1pN7KiFzMyLAhkRIn1
         MPTxHPumgsq8+F+r01zDQc5Mj1lXFfyLb2mvTyAeeaK04a/kW0mqZpplBlf+cx+xnwY8
         ffBXZToflcaN/uFv8p3xOJYYAxvkIx06E1inG1crz109BTFlgKPUFcw5M4DIvaeI84fH
         YmYEmXZ5/N9SNlEK6tPPROxWJmOOjfL0OvZknm3lFJi3O/YiyN1xCw3J3Dgxq7rX8udG
         24sP2+rOpRObpAgdHvzU6oCiCk328UbU26M8f7ER8+l5fioUd6bq8GvVbdRn3z6kXjfe
         fNjQ==
X-Gm-Message-State: AC+VfDzUotiGoEbHqDvGwhDZXYdJvHaCyAvKnC18kJhoC61ockUgSBDW
        i3FcFVq8SmaI+ooGuRXtyJnzY2BWWsyPSA==
X-Google-Smtp-Source: ACHHUZ6sJPbIyCLKckLKv3SFQ0McukbNDBAqdKo+FHAKYqkmblP9Ut5oOwEfvILuHIVdb7517MXL+w==
X-Received: by 2002:a17:906:5d16:b0:960:f1a6:69df with SMTP id g22-20020a1709065d1600b00960f1a669dfmr23521045ejt.36.1683815198256;
        Thu, 11 May 2023 07:26:38 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v4 6/9] fs: use new capable_any functionality
Date:   Thu, 11 May 2023 16:25:29 +0200
Message-Id: <20230511142535.732324-6-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
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
index ceb17d2dfa19..05c64494d37b 100644
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
2.40.1

