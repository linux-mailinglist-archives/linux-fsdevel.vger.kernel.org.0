Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED87C5AACE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbiIBKyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbiIBKyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:54:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382A9C9917
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 03:54:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q3so1663290pjg.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Sep 2022 03:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=KfcOYHlpWUeIQt9wkes3QakVS8YddcaWQ6Bp5getgWzzyA5QFGXOB01D4Byg8lDNNW
         QJg3+kZ6nXoSJBy2v3dhYD1T2kqsSGg5SQiljr0FiaoOuSKdsR7f/X1KTvjGyVHQ+bIC
         O7ISw/1864yQHYOFSpM7dVvue4o8mdxEbkQacl82pj3Ul7D7y2pAcmVL4dJcWuepptl3
         0nGPQwcoFuiQ3GnBeI5ahRZjWWn2SLY8uhs3KHX/7rCbDGiR2l1kSFm+8or5p3kYoAGu
         /AHtra/ixW7Cx6Q/R6PZaQvT8b0cU3bezv/5Lkle8JRQb3GSnRLu1sZWWMxph6Jo3Yt5
         1xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=O+yQHzLlcogmwn8lij5qAyXXhB/Y7aT054LuEFNP2wrkbm77eUslLDJck4knT/PyRM
         9cEQF4xu6H35aEj8xePQ9feDED92Rt5Gu8QZUUd253c4WlWSpc/gEa8bDatVtynO66PA
         CO10GX9F53fzORvr/sBjQhCN9nbYn8WHOHHwCJpCrNaZsLIgFOzbINKRxRyoGmzNFB8E
         8ro7UMfEBlGB04IOQsQgbG8ZGyaL1XTvoNitQbExdGVKYU+FzNFNHOnZ7rSbKpaCdBEK
         dbcYmDuosZalPtHyadTgy5jALSITtZ3fup8sRuozlrKnVXybXyDe8SrkfQUEf+xZ1KiL
         wrDg==
X-Gm-Message-State: ACgBeo1titgrUYwnOhxRUy+6cCnxUTv9MYR1hd9uVdCjIUgMsMOFP2mX
        TBENlvxBuO9Xr+KtiuMacBMT+Q==
X-Google-Smtp-Source: AA6agR5CbDJIoLJsxTWDazQnnhaRRZ4gyoM6tAijLRSZKvM0KW8YTXmAGSJZKg4IxsUEjuUkRPQdzw==
X-Received: by 2002:a17:903:1106:b0:172:9801:cb96 with SMTP id n6-20020a170903110600b001729801cb96mr34926139plh.91.1662116061708;
        Fri, 02 Sep 2022 03:54:21 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id e4-20020a63d944000000b0041b29fd0626sm1128681pgj.88.2022.09.02.03.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 03:54:21 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V2 3/5] erofs: add 'domain_id' prefix when register sysfs
Date:   Fri,  2 Sep 2022 18:53:03 +0800
Message-Id: <20220902105305.79687-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220902105305.79687-1-zhujia.zj@bytedance.com>
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In shared domain mount procedure, add 'domain_id' prefix to register
sysfs entry. Thus we could distinguish mounts that don't use shared
domain.

Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/sysfs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index c1383e508bbe..c0031d7bd817 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -201,12 +201,21 @@ static struct kobject erofs_feat = {
 int erofs_register_sysfs(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	char *name = NULL;
 	int err;
 
+	if (erofs_is_fscache_mode(sb)) {
+		name = kasprintf(GFP_KERNEL, "%s%s%s", sbi->opt.domain_id ?
+				sbi->opt.domain_id : "", sbi->opt.domain_id ? "," : "",
+				sbi->opt.fsid);
+		if (!name)
+			return -ENOMEM;
+	}
 	sbi->s_kobj.kset = &erofs_root;
 	init_completion(&sbi->s_kobj_unregister);
 	err = kobject_init_and_add(&sbi->s_kobj, &erofs_sb_ktype, NULL, "%s",
-			erofs_is_fscache_mode(sb) ? sbi->opt.fsid : sb->s_id);
+			name ? name : sb->s_id);
+	kfree(name);
 	if (err)
 		goto put_sb_kobj;
 	return 0;
-- 
2.20.1

