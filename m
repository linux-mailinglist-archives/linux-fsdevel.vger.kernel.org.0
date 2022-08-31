Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9B5A7D64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiHaMc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 08:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiHaMcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:32:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3DD34F8
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so11175554pjc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=a69A5kXxCghZWvwb8YYV75Ozfttgowwd2GDPhnjFzjz+qEazPSR4vukwVjDh7QBPgG
         DsLfR21QtnFhVcOQEysq6Jco6goRw3OWeI6cA9DjxyCyRfdB2zDiWvyPyUcdLZ9EqD5M
         BvK5D6hByMcgaMRQh8s+I8VAX7SBzNISEkj7LjHvVxqShxdTkSOliOrFpfd66IHbD2IR
         j7w1+shnZDMc09iyr44+fiP6fribUX1dqpgfXPeZ1gkiFj2SsRf6i5ZcrElH/Ghz+Ehs
         v9WVDFy4uzKb1PAENyZNriVppdLqadwA31b+PFWbJtON6+TGleh3Evc+QEJhagIG1OpF
         X5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Jk44PJvjdjdt0bhfpwnVqhAy54lOcNkatPLUifUkm78=;
        b=go/cMzJz3FIUxoT0SOf+atuP6vmuxJe3Iao99Dod40Co9TqjiIoQ9PdWsPV4WIGJOx
         D+ZNhl0I55lLcBawQDYeB8QY49URhlik7C4xHDIKVbJlATVklWXREyxWE5Ofaxoz7JUb
         L2hIMLaqVUNIbWkHKCdXyfwaOBaSxZuFJKUbzUu1mFOckhy2p1RC4/19zHhsCo/Te5qs
         CaKg82uCDZt++E+6nx+2GhNDTpsjxfQP+NuBv5v0mtw/NneFYfpuBV3qK/Mcu3EcF4QH
         OgKTTpPAgiv9Z/Wo30kSUXsQ4AaFUZolBMv+JOfE5rN9zAtZlvKeEnFRHH8yEr8GUb4c
         e+sA==
X-Gm-Message-State: ACgBeo0oyq9dAAdinYr5ZgMyzg/UWvMeyIcmr3cfuTZ6boOdaAxQxcSP
        350zBWvhHreTygPOuVC7gubZqA==
X-Google-Smtp-Source: AA6agR5OOzG/6F5Jtqz0Vb/Nb6BOsK8fByctobqC4HoDomtr9xupaeVXSDCFYbQS7FmbcNB0s5JZWw==
X-Received: by 2002:a17:90b:35c3:b0:1fe:10c4:cfb7 with SMTP id nb3-20020a17090b35c300b001fe10c4cfb7mr3056865pjb.60.1661949132226;
        Wed, 31 Aug 2022 05:32:12 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b0016efad0a63csm11769896plf.100.2022.08.31.05.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 05:32:11 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 3/5] erofs: add 'domain_id' prefix when register sysfs
Date:   Wed, 31 Aug 2022 20:31:23 +0800
Message-Id: <20220831123125.68693-4-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220831123125.68693-1-zhujia.zj@bytedance.com>
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

