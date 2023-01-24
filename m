Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9F2678E4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjAXCjL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjAXCjK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C055303F7;
        Mon, 23 Jan 2023 18:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 190226116D;
        Tue, 24 Jan 2023 02:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2AEC4339C;
        Tue, 24 Jan 2023 02:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527948;
        bh=PwWjKgBCrFlHwrWRE5cwXvsrY7AklcLgKZPzMWv8M98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JS6jD+RgGGbUubzXvH6A68+919GJ3rSiQnnhqsc+tyKxmcasyjQTcoGGs2Vf5LJIC
         GvTxhwJvFKg3oEnIsdFQx0xJEONh7r4YAEkjuOrmytD6TrYgNjgvYBDQyQrBVK+so7
         87Nxw/8JkegNoigWo1wiPvVLuO6Ji6g5DZHuOxzWXEaHRHGoR7mRDr1EcYhx3RYyz8
         JhRtODX5+XTlRuJs5jEaBONXZt4a6Hn7rq5GBbHRZlegWqLWv6nRkHwd66O7pkpRFy
         l6KMbbQUvCJ9MWjWFBrHxWNMTEusdLjpaWCwhEV0grRv1xf5B2C7lDCDqk4KxOwQF9
         Weal6JaTo/frA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 01/11] Adjust maximum MSIZE to account for p9 header
Date:   Tue, 24 Jan 2023 02:38:24 +0000
Message-Id: <20230124023834.106339-2-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

