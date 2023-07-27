Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34474765854
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 18:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjG0QJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjG0QJk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:09:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C5535B6;
        Thu, 27 Jul 2023 09:09:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-317744867a6so1171031f8f.1;
        Thu, 27 Jul 2023 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690474171; x=1691078971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAoR31rZg49NpXbv1aFgdZp7tnqrEIUqJ2I4BIKyoFI=;
        b=j1T1T91u0Wt7PYvcWOx9nbIvMyI6zoLy583NklWtskisxDG9KL3fJfTwmmNkiOw3bJ
         tnLYcvVQyV+4u67jq3ex4ckXTCeg03G2Qs53xAj+IAb0Tr9aaRJQM8lyQQYw6BQ0tfdS
         6Mn7g7nAvK/z+ewCzCvrVFNub0zBF3SCMt9SF0lKiA8Ui6EqBuPkgcy4pKX9YCuwr8qX
         E/QP5Bxckdh6mtb0fjKjHm7n5W+rzTGY8EXWUnnZQhmzFjCu8Y8Rv5s1iL/42W5gWS4N
         Gg1IBflOaK5yTPibm1AEx+fD434IWVt8a/+gIfnKsZifd80VYoqhHpKhZIGHGuVYbPaL
         5i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690474171; x=1691078971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAoR31rZg49NpXbv1aFgdZp7tnqrEIUqJ2I4BIKyoFI=;
        b=i1f+U4h/6S2v2OqFxJTesuajH1gRKMQADCUIuZ5tBsBMOpwdeyfsV2J+AeCJA3pQsN
         il3R/0GTuaoryzCFmZF7rbefHqfvmo+KQXjIfD+j1exLmojbXpT4T/gcsJpg7OiFCgYP
         FbjgjOKljEJScjgCMlNWS3MwhvrAV9lPttrc3Rs1pdnZknpxAjxNXZUZvYNt/yQ0kdQ0
         Ajz5saT24xro2c80PEZPlahqsolHxOXESaBIqV0bo768nWa+P7ieTYVAGwazmHmFoaut
         LtlN9sXqQIiKMs2qNfCOqTLq/lpfXGX12noqMtHqT5q1HZavd7uY7Vb5U6zKST4qYQwk
         HuWA==
X-Gm-Message-State: ABy/qLZoTU1r4M34rjbvniJBDvy4bqEfzmpwqCHdjsi0cevPnEwW9QI6
        fTYhV/aOVUXD8vAklrKAgpIgll58RBJrTg==
X-Google-Smtp-Source: APBJJlFTtTRut05zFYXHOLW7MzbLE4yUtHK46sLKj0VFjTM0SVmnbMOQcM4PXvY4oS1INRovcGZxCA==
X-Received: by 2002:a5d:4292:0:b0:315:9021:6dc3 with SMTP id k18-20020a5d4292000000b0031590216dc3mr2226017wrq.27.1690474171180;
        Thu, 27 Jul 2023 09:09:31 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c3-20020a056000104300b003141e629cb6sm2365898wrx.101.2023.07.27.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 09:09:30 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] radix tree test suite: Fix incorrect allocation size for pthreads
Date:   Thu, 27 Jul 2023 17:09:30 +0100
Message-Id: <20230727160930.632674-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Currently the pthread allocation for each array item is based on the
size of a pthread_t pointer and should be the size of the pthread_t
structure, so the allocation is under-allocating the correct size.
Fix this by using the size of each element in the pthreads array.

Static analysis cppcheck reported:
tools/testing/radix-tree/regression1.c:180:2: warning: Size of pointer
'threads' used instead of size of its data. [pointerSize]

Fixes: 1366c37ed84b ("radix tree test harness")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/radix-tree/regression1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/regression1.c b/tools/testing/radix-tree/regression1.c
index a61c7bcbc72d..63f468bf8245 100644
--- a/tools/testing/radix-tree/regression1.c
+++ b/tools/testing/radix-tree/regression1.c
@@ -177,7 +177,7 @@ void regression1_test(void)
 	nr_threads = 2;
 	pthread_barrier_init(&worker_barrier, NULL, nr_threads);
 
-	threads = malloc(nr_threads * sizeof(pthread_t *));
+	threads = malloc(nr_threads * sizeof(*threads));
 
 	for (i = 0; i < nr_threads; i++) {
 		arg = i;
-- 
2.39.2

