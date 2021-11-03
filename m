Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CE4444A42
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Nov 2021 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCVeQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Nov 2021 17:34:16 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:61040 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKCVeQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Nov 2021 17:34:16 -0400
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id iNr7mLdh7BazoiNr7mx0f3; Wed, 03 Nov 2021 22:31:38 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Nov 2021 22:31:38 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     bcrl@kvack.org, viro@zeniv.linux.org.uk
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] aio: Save a few cycles in 'lookup_ioctx()'
Date:   Wed,  3 Nov 2021 22:31:35 +0100
Message-Id: <0c3fcdaec33bb12b2367860dfab7ed4224ea000c.1635974999.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
save a few cycles when it is known that the rcu lock is already
taken/released.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 9c81cf611d65..d189ea13e10a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1062,7 +1062,7 @@ static struct kioctx *lookup_ioctx(unsigned long ctx_id)
 	id = array_index_nospec(id, table->nr);
 	ctx = rcu_dereference(table->table[id]);
 	if (ctx && ctx->user_id == ctx_id) {
-		if (percpu_ref_tryget_live(&ctx->users))
+		if (percpu_ref_tryget_live_rcu(&ctx->users))
 			ret = ctx;
 	}
 out:
-- 
2.30.2

