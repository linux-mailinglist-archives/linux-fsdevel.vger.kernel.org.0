Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D08762FBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 10:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjGZIYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 04:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjGZIXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:23:16 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D5728C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:47 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55af0a816e4so3248090a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359046; x=1690963846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIXSYqX84CuSmVFU1GzkCcpfMb+I1xPBZiIvC+Oh4rg=;
        b=Xb1tm6ZvxlWzJvqX93uwzRGpsT6PZkoFfclMBbf+N88CMfcBjpcHzy22/Q5ZUk0yeM
         RV0oqyIVZs7GGUtS6u9+54GAmKmAszOPceUrYzTN/evSZuCOY1j1CwfyHGvPZwK53pU2
         7s9z/roqFedDZiv2JrBeiw4ENhNrUyKYhyjZoyd5ua4VqSKD/QkVWdJTEGiLlwYku4+D
         ziMxOcBUKQ5S4q1OVBLPBKmtZsvIlwQAtRpQ9SeL7B+VSGC0WZ81Bc1dctqe9DXiVAaX
         QPuMR+EtJiiNUa4Ac6SX9im67+cS4XerefidUFH3BFkltVwrclITfqsrZQd/2LB18kzE
         RCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359046; x=1690963846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIXSYqX84CuSmVFU1GzkCcpfMb+I1xPBZiIvC+Oh4rg=;
        b=WfBLFb0GZbar4VE5Dyxb6YNh/TCFqceWlzdWWXzBekOXTmuaO0HxiKXSar2UEB9XQL
         Et4d2MOuLysfXAYsHFes7rlCoHm2HMo/NyaJ/gpxCa2NgJhq9PIrjbR39cAUHxD4o/cU
         ZIyziBT2nR+Tt7vmK0LWBml4qvuZlJyStaUEzjuhUFb5/mrjM6J1LNzKLYwhuLjLX9oi
         vQurIuqT7BtuVa86SWtQ9fMguNYHV0cnhN3Zl7FtRFN4zjJKsse08hIiICTnwIqGgft3
         nwe0fhteYajnJmlcn8eCCyecfRcFMd7Z+pr2rEUDQv2SDtuE6TMfeFDCKIb94ppEc0Gz
         RxEw==
X-Gm-Message-State: ABy/qLbPDW61YpP+vMuzYTAxA3PsMJ7frYRMsLvSV9Ogzfp2f93l4qQM
        M8F5h+1lGiK8iF2OJt//ttVndA==
X-Google-Smtp-Source: APBJJlEHomf/FPMiQ187RwZDxLz38AsGu02tOBeqsit032eLLBERo7jna6rKcRr9i0zDxFPbS5SMig==
X-Received: by 2002:a17:90a:e281:b0:263:5d25:150c with SMTP id d1-20020a17090ae28100b002635d25150cmr974204pjz.29.1690359046624;
        Wed, 26 Jul 2023 01:10:46 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.10.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:46 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 10/11] MAINTAINERS: Add co-maintainer for maple tree
Date:   Wed, 26 Jul 2023 16:09:15 +0800
Message-Id: <20230726080916.17454-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add myself as co-maintainer for maple tree. I would like to assist
Liam R. Howlett in maintaining maple tree. I will continue to contribute
to the development of maple tree in the future.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc71b815791..8cfedd492509 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12526,6 +12526,7 @@ F:	net/mctp/
 
 MAPLE TREE
 M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Peng Zhang <zhangpeng.00@bytedance.com>
 L:	linux-mm@kvack.org
 S:	Supported
 F:	Documentation/core-api/maple_tree.rst
-- 
2.20.1

