Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF5764C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 10:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjG0IVI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjG0ISZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:18:25 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B171C49D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:10:53 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f74a8992so77848b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jul 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445417; x=1691050217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYuXWIGRd3SDQUNwBNnDU/RFUGkEJd0z6ud/pRWhp58=;
        b=T9ifvBS7grSXMXHZ+aFeKzum6pF3H2DhLFdohTJRx7vF7szcBG6tJ5VPINqCVu3pCX
         FmubTvt88b5ysMWaYtFibatbXMnoo6Jib8lbo65gbMoj4iY6HbdoFrEeXgYSqYC9Jqe0
         PGHsLAS4RpAPQjTV72r0GtDUpuZ/ybvTZ9EZC90EXosh65ardfAALzeVYgFduHUdYxNh
         uE3GuwKiv2CyHXolQ3XZqpbE7oSyCW4E0iZzkXVJZoTlkXjievgPAGhg1+Kv8s/E0hIi
         dyIaavdNWwWhQNwuCKJwqWG502/DMJOkmwjObTrka2ckcmNrtUCmvsEGY2FZ9fmQFWZZ
         aE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445417; x=1691050217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYuXWIGRd3SDQUNwBNnDU/RFUGkEJd0z6ud/pRWhp58=;
        b=SoQPKYXjUzj4dgw6pidLHS5CIoTOUSUAEqzNmmcuHYQGsTHZEX/RpjZlwCrwif/m0i
         wcDJ1CtApXi0Knq88L9Uky1OWTJsldx1HqAWi3fCwK4XqWJ6GH29FFaHhPuVuUfdzs8Q
         H8yHK6Y7HnI/ZHLOK59K+eGJc+J34cTcxdsQC27mTTn8WO6Mrv7vS1dMuTpfPrRY7Efd
         woDhe+cf2xZwPvpkyeGZlvzeTEgIFmzglG6QF6ZIyAPUNqOL0CYUoF80dO5VvCCYy+xh
         NQrqKjQeSXdjcVEF44xCofoIo3mpCWC/cRgjDGbEeoyCfTkwT7idTKZ49MWqZWzayoVa
         EO8Q==
X-Gm-Message-State: ABy/qLZTF9kxayhRpYW9UfT6zZ/oBp3KHMqsdPBSf3YXFtsPlSdjOWeV
        LSmzSTqWeIrKw9OcJ4s5WqJSiA==
X-Google-Smtp-Source: APBJJlFP1iLC566NPrkWwKL0iKI9L1P+4s+IlmNKaBmXVe5HE8WAAvDQ5uBELCFt4/l7YPuEeyQdfQ==
X-Received: by 2002:a05:6a21:7882:b0:123:3ec2:360d with SMTP id bf2-20020a056a21788200b001233ec2360dmr5970181pzc.5.1690445417252;
        Thu, 27 Jul 2023 01:10:17 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:10:16 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 22/49] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date:   Thu, 27 Jul 2023 16:04:35 +0800
Message-Id: <20230727080502.77895-23-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 net/sunrpc/auth.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..6b898b1be6f5 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -861,11 +861,7 @@ rpcauth_uptodatecred(struct rpc_task *task)
 		test_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags) != 0;
 }
 
-static struct shrinker rpc_cred_shrinker = {
-	.count_objects = rpcauth_cache_shrink_count,
-	.scan_objects = rpcauth_cache_shrink_scan,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *rpc_cred_shrinker;
 
 int __init rpcauth_init_module(void)
 {
@@ -874,9 +870,16 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker)
 		goto out2;
+
+	rpc_cred_shrinker->count_objects = rpcauth_cache_shrink_count;
+	rpc_cred_shrinker->scan_objects = rpcauth_cache_shrink_scan;
+	rpc_cred_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(rpc_cred_shrinker);
+
 	return 0;
 out2:
 	rpc_destroy_authunix();
@@ -887,5 +890,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2

