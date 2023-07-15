Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2F75470D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jul 2023 08:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGOGbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jul 2023 02:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGOGb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:31:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22752735;
        Fri, 14 Jul 2023 23:31:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3143798f542so2757586f8f.2;
        Fri, 14 Jul 2023 23:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689402684; x=1691994684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyZJHmKPjPkb3yPje1jkcke84M++giH6sd9JvhkMUDA=;
        b=JNrKupWUSD4UlRQAjg3KQ0K170ZTY0PJmQGEcd/S4bLKYnnoSICnkJcH4zi36m92eC
         T8UnItgd2OhTL81upxlcRScPI267F8vzLsM9PD3LOJWHtNDK4SwJ1wbf6dOEGyCDADCw
         /uNBgbf5O3EMUCPiBuP/t034A24yUJhawCuB04/aAi94VNiwildVchZYJt6eh2ebMCyw
         IqQirLNCXjCjoXEcW3ymenrhAUpCSRx5xnUfTuIivodIv9wwbYmCaWeX85BrPBod5gNh
         rTKPyInLEGVkEI7ZL6p2UC8DdGQRO/8IixtqZZUF/Hz/IrJayQg6zxAkhqkAhcOPwxhM
         9unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689402684; x=1691994684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyZJHmKPjPkb3yPje1jkcke84M++giH6sd9JvhkMUDA=;
        b=lrPlmDcTYKYoZS0yKpiiJPvwd385ODTn1EnGEWa1lNCeaUDUDI+GPtTKIpvkHqG9f0
         fdEIuR67VHBS0uWeB/3yZm3QsYxkEjGaxHvSQKgNBBtM0Sc2NTAfj5x9YnEZ68POOoSY
         5IU9fRGkfxwlms3JDkeOZYuEb7rYMkQkHIPSQslt7grOtGUGhkKAfu8X75AW73lK4oLD
         i8OicTHW6bXumLRivw4XnjAU0YbGHHdiy4emqR1WdPqivx8pPHQnuox0PbsWfyy9/GBm
         sR/8sN66YM5VjdWTtItaBYK0vaK72a6JT6qILILXP8qF3edrVmDPzwDRJ19ROgUEgd2p
         0HAw==
X-Gm-Message-State: ABy/qLbjt18AYOkM+Rf8sS+eib2x7btkf7HF2YWYBppBHVswXJQFIqGt
        FQtVOcb/11C5QC3yQXpSgpA=
X-Google-Smtp-Source: APBJJlEkv1S7qZqkQvAOSk8oegQg1BvVfva6Hbl5Y9wxZ71fWjQs+cIeYI/czpJ8jesggpr0pBWjQw==
X-Received: by 2002:a5d:6047:0:b0:314:3ac8:c277 with SMTP id j7-20020a5d6047000000b003143ac8c277mr6368823wrt.9.1689402683846;
        Fri, 14 Jul 2023 23:31:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b003fbe36a4ce6sm2957360wmi.10.2023.07.14.23.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 23:31:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6.1 2/4] xfs: check that per-cpu inodegc workers actually run on that cpu
Date:   Sat, 15 Jul 2023 09:31:12 +0300
Message-Id: <20230715063114.1485841-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715063114.1485841-1-amir73il@gmail.com>
References: <20230715063114.1485841-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Darrick J. Wong" <djwong@kernel.org>

commit b37c4c8339cd394ea6b8b415026603320a185651 upstream.

Now that we've allegedly worked out the problem of the per-cpu inodegc
workers being scheduled on the wrong cpu, let's put in a debugging knob
to let us know if a worker ever gets mis-scheduled again.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_icache.c | 2 ++
 fs/xfs/xfs_mount.h  | 3 +++
 fs/xfs/xfs_super.c  | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 536885f8b8a8..7ce262dcabca 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1848,6 +1848,8 @@ xfs_inodegc_worker(
 	struct llist_node	*node = llist_del_all(&gc->list);
 	struct xfs_inode	*ip, *n;
 
+	ASSERT(gc->cpu == smp_processor_id());
+
 	WRITE_ONCE(gc->items, 0);
 
 	if (!node)
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 8aca2cc173ac..69ddd5319634 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -66,6 +66,9 @@ struct xfs_inodegc {
 	/* approximate count of inodes in the list */
 	unsigned int		items;
 	unsigned int		shrinker_hits;
+#if defined(DEBUG) || defined(XFS_WARN)
+	unsigned int		cpu;
+#endif
 };
 
 /*
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index ee4b429a2f2c..4b179526913f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1084,6 +1084,9 @@ xfs_inodegc_init_percpu(
 
 	for_each_possible_cpu(cpu) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
+#if defined(DEBUG) || defined(XFS_WARN)
+		gc->cpu = cpu;
+#endif
 		init_llist_head(&gc->list);
 		gc->items = 0;
 		INIT_DELAYED_WORK(&gc->work, xfs_inodegc_worker);
-- 
2.34.1

