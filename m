Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DBE40A855
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhINHpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 03:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbhINHos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:44:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46FC06114E
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m21-20020a17090a859500b00197688449c4so2106178pjn.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fApQjSawapzHDI7Jp4q7DITe6weMtnGEUAy+vh573JU=;
        b=O/YTGwiYTLhGu3zNylBhmY2k93u0Y2lSkjAIbiPoY/8oIBOcqiBADUTbRlE5YvFJwl
         Vlbbl20Xg8XU4SoRDQTXXyoR9HoR/1YQiaUlljHj2RLzCiWbhlzfixlETVxdmSv9NBrY
         Yo+BOXrhCu3/FJDcB/OiPGGNbrtM6fpJZcu+ojHAhgMf86G3l3rVkxTEluvWIaUm7Qf/
         aVn1pueVsj8m9v+lck0AGgSt375rpr4reWCRAzMizfeR3eUH+V+1o2H0krk2tVQ50sfP
         Fl4jk/6dizbKw9AQqRNXVQkGAA1kBRGmXj4ns4KVkB6xx3oyth8aS7GWF1KIvNp+rZO5
         /QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fApQjSawapzHDI7Jp4q7DITe6weMtnGEUAy+vh573JU=;
        b=CQ+WAbBlXMxai6wDmm74P/qsM5IBiRcrqbsOQiMz7VUze1uI7izNMu8Y6e3R9VCQbf
         7XbzqE2po98Sq6WFco8BelEgE0Gs98rEi4RK/3C3qqm74bstY7lQspYPcdmXqzHU1oys
         sugGw3fmVnIMakn4qRwaoAmkIPVuStspyIfw0OJBhkBArlo6blVfKdgk7dB4lZAABx9D
         RDGnvBhmTu69TcadclQ6Uvtflv7tuiFHrxA/XAFOajqnc4zFgF1uG4tJ3pKJvzfJ9sqv
         v2Rf4mHo1Hlgb4ygTezEkQk4vrP1K9snCazSLbxv6PCX0UESiH4VJbJsKjrKyqiUBS6S
         XTSw==
X-Gm-Message-State: AOAM531JyfG+hdVfJ3Uu3VCIi44X3Br9phDkZKDlRZjs7aNgx4ZrtfI6
        OBwdKIZKAD+01kOtA0qxzrru6g==
X-Google-Smtp-Source: ABdhPJzrBqnGxY3/79/0LfCVIeBfsglBsnuRJJkJ4usqld2XpSAua+m0amwjSViNbLpMZ/tWvievxw==
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id w4-20020a1709027b8400b0013b90a7e270mr9343944pll.21.1631605237377;
        Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 64/76] rpc: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:26 +0800
Message-Id: <20210914072938.6440-65-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index ee5336d73fdd..7ed4accc480d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -197,7 +197,7 @@ static struct inode *
 rpc_alloc_inode(struct super_block *sb)
 {
 	struct rpc_inode *rpci;
-	rpci = kmem_cache_alloc(rpc_inode_cachep, GFP_KERNEL);
+	rpci = alloc_inode_sb(sb, rpc_inode_cachep, GFP_KERNEL);
 	if (!rpci)
 		return NULL;
 	return &rpci->vfs_inode;
-- 
2.11.0

