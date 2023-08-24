Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4972578661B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjHXDrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 23:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjHXDqr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 23:46:47 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974061996
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:45:50 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5711d5dac14so204413eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848725; x=1693453525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhxSeDRYp3v7ieIpIfFPT9sZqK0EZ/0i4DDRxkd6a3g=;
        b=jj5EOkZd/1Viu3LIpqnqm+9TO83RfQntyjhfpth1xwPMMqC6IeHfbX02lMDFBj9m4i
         HwTZWXHIfgHNzPBXU+/GXlcEpfMhfZy5bJLefmYCesJViC/+68iG6xd5KwRidLyWJo2c
         eEBhhIGT0YiGdHQSzZe+BuRB0tQmPb1ArPNTjRXRpv6rdjsXFFFVPCyMT9LQb0O6vhjO
         X14FAywAN7vHefaxoyfwydq29V8F/tb3M5k7yl3IMC1b/p7T/xlSVAzbSclwGGOZcBEi
         2UDep6iaZVsbDk0TcVqBKtj26LS1xCeJgHZxHJ9kz4PrRpNyq14TADCeaJlpJuB1QGAS
         NXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848725; x=1693453525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhxSeDRYp3v7ieIpIfFPT9sZqK0EZ/0i4DDRxkd6a3g=;
        b=A5DN2wfS4VoSVA3NOTw6RtthYKON4RHPTlOGuBsfb6gdyomnQpa2O79NfGvs9rrPdx
         C0AAFa+4S+kk/sYBlEfezyESoAaQQHA4KZ8I2HVaaKlwTPOvjkmDHxle+dUYvLE+R9b6
         OnarTthiJprx6HDHnG8w7IpGR3nySHKsDbwOlBf5mD6mjRw/iWUUq60MCYJGIoIB5T28
         +Vp0euZsCI1KAL4Xe3kmnt/ZogvM6pT6S+Soq0LYHes9ixArvxy/+6qE7/4spXErCz91
         9MTplJK/Nbtzi/pUuZP1EbKewas+3Lt5oimgzO5NqChjT7RkS6aLgsYPRUTWl/kdikWd
         eIvA==
X-Gm-Message-State: AOJu0YylS7/X9DO099BB7aJLbqiGl/RRZWj4do+cQQ8/T1s5eeJJis8t
        Qr3Jj9mTJ0dIujoD9pIzVvzPSg==
X-Google-Smtp-Source: AGHT+IFTBK/u0iko9Ps2VqzIjicgN2FMlf6qk5M/LKmT2/X3Ry0MSCtC++/3ldoynFepLPPQv6yobQ==
X-Received: by 2002:a05:6808:152a:b0:3a7:72e2:3262 with SMTP id u42-20020a056808152a00b003a772e23262mr17146531oiw.5.1692848725311;
        Wed, 23 Aug 2023 20:45:25 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:24 -0700 (PDT)
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
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH v5 11/45] nfs: dynamically allocate the nfs-acl shrinker
Date:   Thu, 24 Aug 2023 11:42:30 +0800
Message-Id: <20230824034304.37411-12-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the nfs-acl shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Trond Myklebust <trond.myklebust@hammerspace.com>
CC: Anna Schumaker <anna@kernel.org>
CC: linux-nfs@vger.kernel.org
---
 fs/nfs/super.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 2284f749d892..1b5cd0444dda 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -129,11 +129,7 @@ static void nfs_ssc_unregister_ops(void)
 }
 #endif /* CONFIG_NFS_V4_2 */
 
-static struct shrinker acl_shrinker = {
-	.count_objects	= nfs_access_cache_count,
-	.scan_objects	= nfs_access_cache_scan,
-	.seeks		= DEFAULT_SEEKS,
-};
+static struct shrinker *acl_shrinker;
 
 /*
  * Register the NFS filesystems
@@ -153,9 +149,19 @@ int __init register_nfs_fs(void)
 	ret = nfs_register_sysctl();
 	if (ret < 0)
 		goto error_2;
-	ret = register_shrinker(&acl_shrinker, "nfs-acl");
-	if (ret < 0)
+
+	acl_shrinker = shrinker_alloc(0, "nfs-acl");
+	if (!acl_shrinker) {
+		ret = -ENOMEM;
 		goto error_3;
+	}
+
+	acl_shrinker->count_objects = nfs_access_cache_count;
+	acl_shrinker->scan_objects = nfs_access_cache_scan;
+	acl_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(acl_shrinker);
+
 #ifdef CONFIG_NFS_V4_2
 	nfs_ssc_register_ops();
 #endif
@@ -175,7 +181,7 @@ int __init register_nfs_fs(void)
  */
 void __exit unregister_nfs_fs(void)
 {
-	unregister_shrinker(&acl_shrinker);
+	shrinker_free(acl_shrinker);
 	nfs_unregister_sysctl();
 	unregister_nfs4_fs();
 #ifdef CONFIG_NFS_V4_2
-- 
2.30.2

