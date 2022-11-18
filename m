Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544DF62F3E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 12:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbiKRLll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 06:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbiKRLlk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:41:40 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E717430;
        Fri, 18 Nov 2022 03:41:39 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668771697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SSD/8D3oxjxNO6XFSWDffwRmka85Uk/caIyP96y7PQk=;
        b=cl/J/kReOmnmtGqxIEY9x/uDHsYTje/wJhEd5YDc6K8CwBGEj6LD9pzQZbOjoQCGEsGRWi
        f7IiCj8XHMiEEILyZt+68o7mpukiEW3cdmLUUyrAGKQ+J0spkkstvwBxUXB1ayhgGbXcWd
        wJKEmJcdgQMEgL1iCzw6hT+PZh41Gd4=
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH v2] namespace: Added pointer check in copy_mnt_ns()
Date:   Fri, 18 Nov 2022 14:41:37 +0300
Message-Id: <20221118114137.128088-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return value of a function 'next_mnt' is dereferenced at
namespace.c:3377 without checking for null,
but it is usually checked for this function

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..06472a110257 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3348,9 +3348,9 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		}
 		p = next_mnt(p, old);
 		q = next_mnt(q, new);
-		if (!q)
+		if (!q || !p)
 			break;
-		while (p->mnt.mnt_root != q->mnt.mnt_root)
+		while (p && (p->mnt.mnt_root != q->mnt.mnt_root))
 			p = next_mnt(p, old);
 	}
 	namespace_unlock();
-- 
2.25.1

