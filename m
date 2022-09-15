Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8363A5B9B22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIOMml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 08:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiIOMme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74114094
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id y11so732351pjv.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=et8SUZfoNeMLnBl0MYEBpYeDFeu37dGfFrRRjQ3AaSxd8mtSowHWfpGGv23g3PclEl
         rgBoVJGjypKu0gzrIGPI32O/YAaVP3IBo2CqI3GwpG50VYJCT/VLn/PefDTSP4ScGOeV
         8gw76ga6vh3F0wTgV/EJQOyXCnDggxUUWVUSahI18DNxw3/pIw+4CYWKjOJdgx/RcVFw
         njw6xSqeSSHJlZIjWtf+8vvHJiTjTyOwuj4vJOpIU8M+1LOlig0Mc60vsGYkEYADlGgJ
         BIzUJSej46PeT0PMCaFJFwlU4nASJaiHY5B42BznFYhPOAqMqaQK1C5O2MQk/8bS78i6
         RbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=bpzsdu7NjYzNTlZiWA3HxSwsPyqrVB1cyYTJ0QxDsDqrLgAq1I7TYR/7Eb3Xkzstq+
         lKn0Ctqg0VXOVZ2+z6esJVLV7tr96iZDuy8aasFYsHZC8hb2Z2UlwpzuSaoUVZfrgoOT
         sTtd0sxIA3Jw6jEp4VqxFnZfWYTyGJFk/iCN8BKQIvAiDXEdu6GH4wefoYOtREdm15qy
         Yz78+fw/akN4XwCUYwcMVUgp1MNeSvin9WbobG0M8lRyPXC+8NZdwp+COmUK3AYSD4Eh
         j7O5IqiijKXoPpp7/0dsYUVqCq00cMU9C8hkdkWVGXK4DHPYB/vOJuV2tFiszuMAjjqU
         Ux5g==
X-Gm-Message-State: ACrzQf3uodgApg6neXqtg/0Pa10cFNPyQj9+IqZv+/0xIIOcEpT/Bv+M
        7o/4vkKVylSwxGXIZ7h6M3CE+g==
X-Google-Smtp-Source: AMsMyM6L9o52U6lZPoVzHgkmu9KCrPUsx4XZmvaJZ+/KCAxjWxbWhbI2BTZHjNqBttWAXeWa68I2HQ==
X-Received: by 2002:a17:90a:db8b:b0:203:1de7:eaaf with SMTP id h11-20020a17090adb8b00b002031de7eaafmr8232679pjv.168.1663245752797;
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Thu, 15 Sep 2022 20:42:08 +0800
Message-Id: <20220915124213.25767-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
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

