Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2690B69B724
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBRAs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBRAs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:48:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DFF53EC8;
        Fri, 17 Feb 2023 16:48:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 99FFFCE2D11;
        Sat, 18 Feb 2023 00:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A3FC433EF;
        Sat, 18 Feb 2023 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680434;
        bh=PwWjKgBCrFlHwrWRE5cwXvsrY7AklcLgKZPzMWv8M98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoiSvOjVFdldq06YEWUWJ5d6yYyCFmNKfK/nQJ1caAuYFBSe7ItFqXHlKS9KpiDJb
         MSsdsh4qjW9ARIQiNRph5Oo4iG0l1JDWo7qyb67VWywhZy7Dywf1a7xANo3+otCeum
         GJ9XzUoh9k+IeI7+mGixH2//iLtq8jT8swpMNuKcsuSABU0n7xrejOOIThxQV3L8iI
         MSdh9sPUNQS7hNH8DRYKMfA+gocsbqWcCxOCX5k/OPtHxLqSW3D4lpZgHvTTDFNx08
         tqSwZFSqXIshydzqltmUOmhWXj+UD5dqeCchUFrIMIE3GNcsjsq41AlA5uz+B1MiwH
         FuDUdno65CPvg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 01/11] net/9p: Adjust maximum MSIZE to account for p9 header
Date:   Sat, 18 Feb 2023 00:33:13 +0000
Message-Id: <20230218003323.2322580-2-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maximum p9 header size to MSIZE to make sure we can
have page aligned data.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 net/9p/client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 622ec6a586ee..6c2a768a6ab1 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -28,7 +28,11 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/9p.h>
 
-#define DEFAULT_MSIZE (128 * 1024)
+/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
+ * room for write (16 extra) or read (11 extra) operands.
+ */
+
+#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
 
 /* Client Option Parsing (code inspired by NFS code)
  *  - a little lazy - parse all client options
-- 
2.37.2

