Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6375B86A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiINKvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 06:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiINKvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:51:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BA762AA4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c198so14500959pfc.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wc6UqN2rBrRPIKRWEZkd/HK/BLX6Fc+iydsV3In6uJs=;
        b=oOrs1LpYB0NxT5AuspZSwCGv3oFKdg6VgFR8OpUnYS8lvjCNyjNb/6jMklnwW1HBGG
         jI/xowxQ77fW1KZdkpQYusZAof47Be5v/T65EGudfxhj6viEnmeUtuyU7h3liWHDO8fE
         lC9lPZZ1gL1c/pG/d08McSFu81TO3OX20KtJu1juI83ho9KOwBhj74EvxOx5tzd9ofwY
         cwm9FABc2VC+ElY//cOiWMCQBVXGAXyigc9SV5QPWg3+AW7sUeHh9/nTxz5nTq+pU+Vv
         Wy4EE34SYw/R4YMCJiD56PdZZharxDBstXYdsBEDc4DM84Rl3fDPFYlpa+TODRsI/wun
         rh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wc6UqN2rBrRPIKRWEZkd/HK/BLX6Fc+iydsV3In6uJs=;
        b=Edk/+OaVSH3iKQ/lozXoqicRXuKCWfsXrxln0YeuBcn9R9UPVrJs5AqKTVpr5UeNKF
         rMb8GJtJB6tSuVELjD+6arbvlsnMlzc8u80tK31nvpFc2zpNi1AOcvVTIdquzDDZJM1e
         f/QokXLP4Ns1sa3Rkf3xP3dsrq+njHI+TaiJyIq64Coih9QCbo7Kyv7UU0AiOTTA4NYz
         cBuqOmSXJBU1LPsElr/nY0UaYWY1+abbwktYMo4N686YnaXu5LDpQLtwtBvAnvYz1Jvp
         TXwCSTU9KWPCq6nmdV/z23DZLy1wVnq9hHaiEf0ohNkU1p26DIaEm8BuB0UwSmmGox4t
         Wasg==
X-Gm-Message-State: ACgBeo0RhO/teBIgHxm2SIUInPPudHXqx89GjkajpIWCOS63omRMbdQn
        DH2SJ4Z8Y+QrnQpBA8MUBlI6SQ==
X-Google-Smtp-Source: AA6agR6IR4Tl5gCLaL9fQ77Ogd5yC58UKWzNowxeQQLx0k6N3fYtgtwq1tRtRPwePR65gLmmmdj8UA==
X-Received: by 2002:a65:6048:0:b0:412:73c7:cca9 with SMTP id a8-20020a656048000000b0041273c7cca9mr32293293pgp.257.1663152654247;
        Wed, 14 Sep 2022 03:50:54 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([2400:8800:1f02:83:4000:0:1:2])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b0016dc2366722sm10537042plg.77.2022.09.14.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:50:53 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V3 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Wed, 14 Sep 2022 18:50:36 +0800
Message-Id: <20220914105041.42970-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220914105041.42970-1-zhujia.zj@bytedance.com>
References: <20220914105041.42970-1-zhujia.zj@bytedance.com>
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

Use kill_anon_super() instead of generic_shutdown_super() since the
mount() in erofs fscache mode uses get_tree_nodev() and associated
anon bdev needs to be freed.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..9716d355a63e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
 	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
+		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-- 
2.20.1

