Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2107ACEE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 05:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjIYD7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Sep 2023 23:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjIYD7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Sep 2023 23:59:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC985109
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:41 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso4652656b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Sep 2023 20:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695614321; x=1696219121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGF6lWn34y725CVIBLiDuCLlZ/D9mfCg2VPUJce9YQs=;
        b=M/v/vjTrVyE+W85fdWa0awcxSStSWeglGcdH015ydpFVQEh4YokywwsZPSRplczS6s
         kZrsuIanxSb1vmhLk6aIFRWc0+NvuYshY7BLiPJ94xHxcm3SHiXR3l84vbUT4jIZgiDz
         kiFYJaP7UcFP5Hf1iseif2xwPz/9hB2j1+oUZX/0QXBQ+3sg0hfwvCMfbchrypuKa9SE
         4Wj+MqmJxuQ5ikjNi4bDoNTaQjDXP5XlfJkPbzdQqhekugZIUBtJiph/PiiJsfgmUN3i
         XwN4nTIiDSETUudLS69n9v+6jRBMk35f3BRE2sdh/mxcKX7b2P4Ef+LDBEbcNoSVjviz
         difg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695614321; x=1696219121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGF6lWn34y725CVIBLiDuCLlZ/D9mfCg2VPUJce9YQs=;
        b=FWs1ruhzVcHzLdEBJG+uF9SQ0w4w1uDXdFCtVXjRWNsBHh6WXXs/zY4TB1yTRhW5vM
         +hGeX9qEALD/9zKibCvBkGEseOzOLsGdjmVR+KTEq0d812DHYkUFWu88omZUy6gLa+mA
         ZANoWaMeBIGYneHN0+f4gLEBsyrRnNvVlv5R0RsXZbj81odISp3j/0MYphEiwGBR6o3A
         EKbCH+SUtSfk9RpbwXfO6D+amfK09YLuoMFwZF3ll9g36Ed17X00Vh0lav3XmBXow5gK
         F2ffoALdbaUOUW245kG8EOf7FeuKvHtSe4yGFW38sETUzreA4e4jxCb/6s1GZHy00oDq
         h6lg==
X-Gm-Message-State: AOJu0Yz0e6LLkhK2zOwTjPdM7rnXZJJZRJ9kXvAvPL97UBivPiU3C5S0
        K1PfmHZrC0/rytBzuHaQmwsuwg==
X-Google-Smtp-Source: AGHT+IHoddrSbePl0h4D+bftYrSW0wEgeAhFg5zR31drbaOxp/x1GgBhKmsKHC902H8CQivLgFilqQ==
X-Received: by 2002:a05:6a00:228a:b0:692:b8b9:f728 with SMTP id f10-20020a056a00228a00b00692b8b9f728mr7716486pfe.30.1695614321440;
        Sun, 24 Sep 2023 20:58:41 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm1-20020a056a002f8100b00679a4b56e41sm7025387pfb.43.2023.09.24.20.58.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 Sep 2023 20:58:40 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 8/9] maple_tree: Preserve the tree attributes when destroying maple tree
Date:   Mon, 25 Sep 2023 11:56:16 +0800
Message-Id: <20230925035617.84767-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
References: <20230925035617.84767-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index ed8847b4f1ff..ad06105f1a54 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6670,7 +6670,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1

