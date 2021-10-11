Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4D428DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhJKNSh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 09:18:37 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:38548
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235144AbhJKNSg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 09:18:36 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A1E9B3FE74;
        Mon, 11 Oct 2021 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633958195;
        bh=wW4bvzsFetfuCZAv7VsHtna8WYq4agNGYBzGaBuz88c=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=I9DAsOaLvXHx5K/S+7EeZNw5reVK9tO5kWqNKzhaEMO/3i/DXQvvaEDS8sDlu2Lr/
         WkOE8T1hSbHJPTOcLjQRBNFs1hVScTWDOpic5hiJOcukBcbNoKZnKLMSgKMuaC5uaG
         QR16PcZHS55MxtLmJ4zWGMdb079TZ4J9/QlgN5E4/7y5giXN1hlKoNCRSF7KVz5vaQ
         xWoahxI8D6j06aZhBb6n8fweqa77FxYlFqAF1GqF4fUqNXSmazBWJLl6yqmSjBT/0l
         FmLPy/YBt4E7YAxQQthgxrcoAN7tulm+mrvSe3HRdLbxz+1sOeUar1naAeg+wgu6l2
         OppeZDaPgh3Hg==
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] coredump: Remove redundant initialization of variable core_waiters
Date:   Mon, 11 Oct 2021 14:16:35 +0100
Message-Id: <20211011131635.30852-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable core_waiters is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and can
be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a6b3c196cdef..2f79f8f7bd56 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -390,7 +390,7 @@ static int zap_threads(struct task_struct *tsk,
 static int coredump_wait(int exit_code, struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
-	int core_waiters = -EBUSY;
+	int core_waiters;
 
 	init_completion(&core_state->startup);
 	core_state->dumper.task = tsk;
-- 
2.32.0

