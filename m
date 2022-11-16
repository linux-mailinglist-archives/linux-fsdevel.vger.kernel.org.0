Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45162B61F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 10:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiKPJNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 04:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiKPJM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:12:59 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9BD2B2;
        Wed, 16 Nov 2022 01:12:57 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668589975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gF8Pma3i+UWto/30oVrb3cq2B8kCqvhNBbFZrZ1f25o=;
        b=oju2c5k3+pYhqmoNaSCAJuiQDpqo6UIsH1GdbaCIKxeI5tNwZhCEHInpzmEySQWWju1YP+
        FvH3syLFFXJR4DuYjUvdnmKONh/OxPqNqlVWBng58RXP/wiFoigVybcvbAOatqq7pkPhrm
        17siYxpKYIvDbG85zwSvxYzoKfyiL/8=
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] namespace: Added pointer check in copy_mnt_ns()
Date:   Wed, 16 Nov 2022 12:12:55 +0300
Message-Id: <20221116091255.84576-1-arefev@swemel.ru>
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
+		while (!p && (p->mnt.mnt_root != q->mnt.mnt_root))
 			p = next_mnt(p, old);
 	}
 	namespace_unlock();
-- 
2.25.1

