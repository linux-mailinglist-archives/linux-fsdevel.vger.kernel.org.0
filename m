Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576343FAA96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhH2J5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbhH2J5q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7DC06175F;
        Sun, 29 Aug 2021 02:56:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq28so24556114lfb.7;
        Sun, 29 Aug 2021 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8shmGTwIVEplPrN8NQt30baMk6rR4iI2vVWk35WOzg=;
        b=kwM5zKbAKM118C6fwyVLCkuxwNqazJSWfgelC8iWcm5DOoOTCfwB4ALMe7jnTTqjCY
         pvfCx7bpEsKbdJAFQYr77IAgYMP0icCCm/R09q8qvoj4w/8fnm2/+sy9AoDdsOk7SUB4
         mPfqgIUaZxFR7hRHs33D70oodAhk8EOcPW9CsAUi2xCn5MWXjf8El5KuGZcH6PT5kI5n
         sJgjQg+7jZY/DYKikxGHzec9rXLsYHDHx3UngE6K1d8/31JYTGX5wys4/4O0e8hX1Zrp
         2OQBRBu8kYqFiGrZwTfXGzh10/PlYp3+3Sm/wsEhrYVXB0JDNZ1uK8Z5HjAf7O5Q1+ng
         ZEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8shmGTwIVEplPrN8NQt30baMk6rR4iI2vVWk35WOzg=;
        b=JlPmOjnHHIBHuUDwwAXtUFHebuD/8J8n1di1InJQQ2Lx09uHIOM83lBx+7k2BHq7n6
         tVeqCQN+rtmyQA2B9shY6aUYZ7OxH4kgb7IRZwqP4Y91rdW5YRmV0g2Lfmwi+4PdIGH8
         2zJzdbeOF17Bs+h/Nrl6bnO0es+UjrjofS2nq8UsQIXYUkWOZsF7C28Q5pPESv39acrO
         YTxKyP6DePRTmpzRc+XtfZxs3pCKUoJNIU6gFxdzUv30Z3CFGLGZpmR5kD0++nrPqGWe
         2UKKmwHU7dR1js1DCqzicDVkntJxoeAOsyCkAL8t5+EGOV7VMYlK+DcCvuODUtQ5j7+m
         Moiw==
X-Gm-Message-State: AOAM532IrcFIULqiJGBZp2QVC/AxxmnU476GII3wqvMh2Fj8BQ3BcIq0
        1QLXwQ801raAv5/+/ZFQG9HYNW4lVDQ5eQ==
X-Google-Smtp-Source: ABdhPJxO1OWQY8ATYb0DXxWiYYRIbHkiVdjUF/hA38qAOzv8owmWNGv3D4LPDdKA2eUIEdA/9L0B5Q==
X-Received: by 2002:a05:6512:1153:: with SMTP id m19mr6734923lfg.268.1630231012587;
        Sun, 29 Aug 2021 02:56:52 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:52 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 6/9] fs/ntfs3: Make mount option nohidden more universal
Date:   Sun, 29 Aug 2021 12:56:11 +0300
Message-Id: <20210829095614.50021-7-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we call Opt_nohidden with just keyword hidden, then we can use
hidden/nohidden when mounting. We already use this method for almoust
all other parameters so it is just logical that this will use same
method.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index b2a3f947542b..52e0dc45e060 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -235,7 +235,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("discard",		Opt_discard),
 	fsparam_flag_no("force",		Opt_force),
 	fsparam_flag_no("sparse",		Opt_sparse),
-	fsparam_flag("nohidden",		Opt_nohidden),
+	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_string("nls",			Opt_nls),
@@ -324,7 +324,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		opts->sparse = result.negated ? 0 : 1;
 		break;
 	case Opt_nohidden:
-		opts->nohidden = 1;
+		opts->nohidden = result.negated ? 1 : 0;
 		break;
 	case Opt_acl:
 		if (!result.negated)
-- 
2.25.1

