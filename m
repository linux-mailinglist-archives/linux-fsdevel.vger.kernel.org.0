Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C25BBBA3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Sep 2022 06:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIREfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Sep 2022 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIREfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Sep 2022 00:35:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1B13F51
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:06 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q9so14816335pgq.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Sep 2022 21:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=eVaRVfx5a2MVEdsHGLTKj56DVEcrAKgua7VGnhGuCRo54sfJnqUIYr+XO+BbkdT1Zb
         91p7t3DNLn1Y10DnRA1xNP7ubPYrptiSSv2pIPQF69SV6FIJgoaI8Edoz6Ve2lI6NGO9
         I/3cXdD8eXFSUYB1836GY6jTk7pDfHZzDePuSyAF07ooCWihJS40cNU+8pY9OP1loa05
         4xK1oEcStoUp7wLXga4FUZZoX4zPkuGym5UVGGI/0YGuwaLJXhOP1nwB7FvQdY5GFOCW
         FdfyQ+JLR2Aj5TNnYdI3QtZcfxS/5ZRWv0lkwl/b1ZQKnvdGNU6XsZZ6dVIkwEPRJdUj
         +Fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vnrn5Lz0Sq4BDA+kMPiBQA0vIKB2GCJKPoPvtdJGVII=;
        b=2tyN/7VCc7mbaJiRhVZBL0fD0tMbM15bTvxiP4H82uIxGJl4LLlLwYLJIfuU5QsXSp
         AnVNBc76UoAhRrJ4Zg3t5aQaCc3BOIAFbfyrmXhStydIh9p9ArQJSgSu+vhfLd8Gj77v
         4HAx5uoOt/iQWdaqixxzJDpR2Ma/WZdcZ8KO6rmum8+/DyHbQrxl1p+eS1vsK9PIDPAV
         T3wey8yRLs0ITBlUep3K4Bvj/xbAllnPk3mcF2wb2Ec+Z709I034OwIJjTiX5YXnFZgv
         UuDwAI/8C3Iduzba7Uqq4TVVfW4fH+KAgq6ZVNNNx773FYGHNwZlpAUe/hjKt9j8oas1
         z7zw==
X-Gm-Message-State: ACrzQf380rhRg8iQWlla8MR3kC/fr++yzDHZhYbBLkUbeFBZUoix4eYq
        pMa13WB1/luoSNuZDTmuQ89djA==
X-Google-Smtp-Source: AMsMyM76iQB6B2cNhDHRqLO41Da7t2u4Ij4woRMn+qQFywM/+pG/hclaTdhS/4IoVJYsYMH7aOEmsw==
X-Received: by 2002:a63:42c7:0:b0:438:e0dc:cc09 with SMTP id p190-20020a6342c7000000b00438e0dccc09mr10797694pga.128.1663475706078;
        Sat, 17 Sep 2022 21:35:06 -0700 (PDT)
Received: from localhost.localdomain ([111.201.134.95])
        by smtp.gmail.com with ESMTPSA id l63-20020a622542000000b0054b5239f7fesm3955248pfl.210.2022.09.17.21.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 21:35:05 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V6 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Sun, 18 Sep 2022 12:34:51 +0800
Message-Id: <20220918043456.147-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220918043456.147-1-zhujia.zj@bytedance.com>
References: <20220918043456.147-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

