Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7769B6F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBRAg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjBRAg2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:36:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF36D251;
        Fri, 17 Feb 2023 16:35:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B308E6209C;
        Sat, 18 Feb 2023 00:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E37C433D2;
        Sat, 18 Feb 2023 00:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680441;
        bh=cW3tqr7Wz1/+iCrGEv007ARmFZP9bjEOtTw2DUtSkXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n66eBIPF5VOPlydJO6o1F9Id9ahHIQmnpN9qb9pfpbH2CclkG8oyade30qFmGYJHc
         IkNEcigIpm9Y/Zk6c0an3pmtrIf93u6e9mKMpaQ7ROqpkAN9p6+TWZxSOoGtn1GEsl
         qMARtGiDDlKjmJOUEqJtvKAjUahxqFbIHqf4kjlDvYueYDzZ5qqygu9fGUe1wobML8
         JaSTrVbi1pGfB2C8zeD9slAWsW39qcybUL1TwF8ZtrKB9WyIS2P9Sr3J0npQgsfUTH
         r2oG9P+csiuyYPLQKnAo0fwOg5jXFwYauD+0V5i7nALf/3S8dUGbE1BFAFyD1ysu5O
         X/SFmxVdZ2vGg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 07/11] 9p: Add additional debug flags and open modes
Date:   Sat, 18 Feb 2023 00:33:19 +0000
Message-Id: <20230218003323.2322580-8-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
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

