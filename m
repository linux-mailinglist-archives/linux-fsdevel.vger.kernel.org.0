Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4225BA8E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiIPI77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiIPI74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 04:59:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023013F87
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 01:59:54 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id y11so3486807pjv.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=vFU4rf8Go70F6Q5X1St4eoonyTDWg0bIGM7mlqkuUZSogR+IJq4axzKODFz8sKnu+n
         YXiBN0DBk244rf8gX4Pe+VpbkyIgpV5XBYq6grMrBPmXNl7XOL6g42xvhAltH35m8y3B
         PEze6Qe5vtcJiwsiQ6i0Fwkbc5xrFbMhe51gR3C/M9DiX5e28ek/y5voCR2eiqRCT7Ce
         iy4NsthMJdE38uXD0cSiy17Z+pQWTjcYUK90Wo/KID82AjnQt6nJOgtVLo20QXsl8H8B
         006JBPs9LcPf9RPdCnxagYlGfECHalGz3iZumnvCzQIeX4R3JXpezCdP6mPqHmSmPLV8
         9F9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=hxzumS//DCdguaO5b//uxPA3+sDkxwyVqL9h8fwly/L6iRpBiNaVtneXHpl7s/qCii
         JNX7VM65ohc+TvjhoGgab9Bimcg7y62AePPayKJVAujMznnS8p+7+N5R5BDqIIcvMwOx
         bnfpBPudkFhd5kxUF+OrrW7DBIaV/lAZ/2HO5/LD4ZG9cH9YWTh6COyZtdNDjtxXvyPl
         W2eCuVW7tJmHly6F4ftdakcIN7oRAScek4LDLvY83vo3Uio9NMX+OqS36z2VLYOpKa/h
         SrXokZAdSDRPmQGoLQFR0ECvE0x4y9HPQoKaGV2GVjAG3Qqxva0oq7rK6hNy4t9hEN3W
         CA3A==
X-Gm-Message-State: ACrzQf1y0rIYLvMU7EmqnFZaszF0dbvmD0ztUBC+kn1ZpGfZmK4wRGNP
        uxTHzQGRYZMoY0MToX6p2wXULg==
X-Google-Smtp-Source: AMsMyM6hd0dG/05ihh0iero8Ff6OfWyMy5mKWwGelHEQgvTGQO/e5EafWIcjvBuL0O1Y2ErsLvgxlA==
X-Received: by 2002:a17:902:d70e:b0:178:2d9d:ba7b with SMTP id w14-20020a170902d70e00b001782d9dba7bmr3776799ply.90.1663318794120;
        Fri, 16 Sep 2022 01:59:54 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090a450b00b001fd7fe7d369sm970578pjg.54.2022.09.16.01.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 01:59:53 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V5 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Fri, 16 Sep 2022 16:59:35 +0800
Message-Id: <20220916085940.89392-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220916085940.89392-1-zhujia.zj@bytedance.com>
References: <20220916085940.89392-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use kill_anon_super() instead of generic_shutdown_super() since the
mount() in erofs fscache mode uses get_tree_nodev() and associated
anon bdev needs to be freed.

Fixes: 9c0cc9c729657 ("erofs: add 'fsid' mount option")
Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
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

