Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8B678E5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjAXCj2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjAXCjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7AF303F7;
        Mon, 23 Jan 2023 18:39:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD3ED61177;
        Tue, 24 Jan 2023 02:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46777C433D2;
        Tue, 24 Jan 2023 02:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527955;
        bh=cW3tqr7Wz1/+iCrGEv007ARmFZP9bjEOtTw2DUtSkXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCNDPsgn5rYYIysfPP/GI4IeZDkKq9eHvFzRdk6iXDCvls8RMDhEG1b+kGMwAo+Gf
         6QNHWfcMXDJHHRu/T+ADRgJPjLSIH3sQ+LYRTGdPWaYwk7IYKYb7IwXDZcazsLitG5
         fv9Ed93a+PSxN7aBDM/QrStAULYP2Y9sTNq3yulvw+jXU6yhkII4AXNDJs0aWCTixm
         0ogH5YxqcdE0ZtL43FAQAtfoDC3mf9eZw2xtpMUmdkosDX52VLtlJrW5jdAxxtq59W
         L9lulG1PzFFDPy4FVYSYJ1T97i8h7BRclPTMigYcgH6M8+Z1n/YWu1GJ7dNLYOMI9R
         047Gvd3Hztlig==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 07/11] Add additional debug flags and open modes
Date:   Tue, 24 Jan 2023 02:38:30 +0000
Message-Id: <20230124023834.106339-8-ericvh@kernel.org>
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

Add some additional debug flags to assist with debugging
cache changes.  Also add some additional open modes so we
can track cache state in fids more directly.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 include/net/9p/9p.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 429adf6be29c..61c20b89becd 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -42,6 +42,8 @@ enum p9_debug_flags {
 	P9_DEBUG_PKT =		(1<<10),
 	P9_DEBUG_FSC =		(1<<11),
 	P9_DEBUG_VPKT =		(1<<12),
+	P9_DEBUG_CACHE =	(1<<13),
+	P9_DEBUG_MMAP =		(1<<14),
 };
 
 #ifdef CONFIG_NET_9P_DEBUG
@@ -213,6 +215,9 @@ enum p9_open_mode_t {
 	P9_ORCLOSE = 0x40,
 	P9_OAPPEND = 0x80,
 	P9_OEXCL = 0x1000,
+	P9L_DIRECT = 0x2000, /* cache disabled */
+	P9L_NOWRITECACHE = 0x4000, /* no write caching  */
+	P9L_LOOSE = 0x8000, /* loose cache */
 };
 
 /**
-- 
2.37.2

