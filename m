Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE07786626
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbjHXDrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjHXDrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:47:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6B310F3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:27 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a8586813cfso655542b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848786; x=1693453586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqY1sW48iQ+/RBGCoAIbrC2fRJNneg9gualmoKm4Jhk=;
        b=N0bEBg41B2iY9D35KYwN2/tcoHlZC6rvdfxQ8MjWAAVsJrbSe5QQ1AloOksBp+VCG5
         ovzTjRjVhwYuCbijaYbBr/NoEX2DBF86HPD3n/LRoilc3AMqFdIYMudsb9GeM0FF8+WD
         vfzr6oFXwaOrFRMP37o0w+E2VaPjRYmk8vIEBd08PbPCV3/5qCp0ZssMbZGvzPANUGFF
         l6D1M4RhmrFVV9Agr9KolhbMLgXrKCLvdCdLgkrxKJwEQ6ETcv90MZzzfe8Jv4mnChvc
         gVqnqZEKx20VOlCNLIRQDT+wJCga0Y5MKoKyPRqMPQvG3t3uAT+WeS34pYjowcn6IWJ/
         hSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848786; x=1693453586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqY1sW48iQ+/RBGCoAIbrC2fRJNneg9gualmoKm4Jhk=;
        b=H8+jnfssvif5LHuc2hMXD32i1zFW7j8A4YzTL49Swrb2gDvxJ6BwYJG/aGSKQ3LZDG
         xQdAS0fu+cEtUhF/E+WyzgDwbuYUg0yDqvNh8xNKmNaYQCuVFNv1zArWsLXMsb7FUtGL
         T8zhhBRexZ1GFFOjiqXvJYdU2W2PzTzLcwU3UgMhjoaA+QHx0+hybw8lmhxaWVwSFcbC
         6FLOKGBRaM18Bv/LPrY+R98Xc/NubnXEa/6b/i3jm/dIq1uNyzJUzoNvwMJKyvfp4upS
         fzO9OTSxhLJEwcsfkatDpyhbVICtb+kjQI90+Z4Je18XwS52kpfX9jliEPZg+NDlapHg
         Kg8w==
X-Gm-Message-State: AOJu0YyaCYy9Au5WsDU5/a3tAZrPJ7DLE+WslLr6CFW6x3Wn+ZOOeqPU
        yYl3epwmYtUnL9izvzG73K3FEA==
X-Google-Smtp-Source: AGHT+IFDAy5Zu8VOU9YTeKJefKe6vLUB7EXbKU3yEeM/VZ53vwtmd2t8ca1mHqoiwq14ODWnet2Fmw==
X-Received: by 2002:a05:6808:180a:b0:3a7:8e1b:9d4f with SMTP id bh10-20020a056808180a00b003a78e1b9d4fmr16975412oib.3.1692848786259;
        Wed, 23 Aug 2023 20:46:26 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:46:25 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v5 18/45] sunrpc: dynamically allocate the sunrpc_cred shrinker
Date:   Thu, 24 Aug 2023 11:42:37 +0800
Message-Id: <20230824034304.37411-19-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use new APIs to dynamically allocate the sunrpc_cred shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: linux-nfs@vger.kernel.org
CC: netdev@vger.kernel.org
---
 net/sunrpc/auth.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 2f16f9d17966..0cc52e39f859 100644
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
@@ -874,9 +870,18 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
-	if (err < 0)
+	rpc_cred_shrinker = shrinker_alloc(0, "sunrpc_cred");
+	if (!rpc_cred_shrinker) {
+		err = -ENOMEM;
 		goto out2;
+	}
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
@@ -887,5 +892,5 @@ int __init rpcauth_init_module(void)
 void rpcauth_remove_module(void)
 {
 	rpc_destroy_authunix();
-	unregister_shrinker(&rpc_cred_shrinker);
+	shrinker_free(rpc_cred_shrinker);
 }
-- 
2.30.2

