Return-Path: <linux-fsdevel+bounces-33558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30499B9E2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 10:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FD01C218DB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1C3165F16;
	Sat,  2 Nov 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mDjWcPGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AE315A856;
	Sat,  2 Nov 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539522; cv=none; b=KSSLOGg+8/vibKKjz6pijOjLueGcqL7aMDJ3/tYXgN6DklSArJGVElI6yjt8T8SwHC94UY5E4M4Tx4eGHq5HzF+xPnQLcRu9JcRnsV0L2WUbSgrJrT3CiIjorlKH6YMZ727mpRaBaTmUMXo0uLgzl84nnSVUd6O1kbhe+kv7Pps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539522; c=relaxed/simple;
	bh=xFcOfOlnBAmZ1ouPT3PdXVy1XSEuzkRieAToIoF+dmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9ksJ/TrM7qa5m6LDVLlZi4vugAgZw2EnI8eg4nvxNAHk79gFdgNrU8Lzvzepsh5BV4uZDUK7neB6iBAk+mRzCochZGwqYL/eHp7wb7rucsN/mmhM9pgpQIW9YvkUq3eGJWAzlNE01jnULAYRkxOasnoihzlEb3hZmqAED31ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mDjWcPGK; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 7ANftLM9g0BU07ANftAu4d; Sat, 02 Nov 2024 10:25:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730539517;
	bh=DIxqU9y3ZKraAtE/x5LoAuiso/aNBNvfgUhvN7CYOys=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mDjWcPGKbwJsbtIUTzyHl8Ds1bZZxz8XaeFzkCFPKIcfgOu0ivOOPj41Cj5b2NSKM
	 DU6rEiexeUPBrg/yGlZdwprj/0i64ApDIaYQj/lKjE3gWV3mjtELo1+pWrE8gkZwrB
	 yitgCg7mIxmrRGKep3xPNF7SL8qp+L962dYobQj90PM/1/4RIyvuYSstr6Qw/ygOht
	 0bgPGXv6BFy12QTaiVZCjFNIDbv6GU5kFzEqGU7qlaeE1K78fpHab+lsRXZfbBS1qf
	 yePoHUUzN4O8saUesswPJLKuHf8W0qhznKtsoUtfaSxzvC8IHwYHEYSruBG+KCtvzB
	 SQXgY4R0G+8pg==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 02 Nov 2024 10:25:17 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] fs: binfmt: Fix a typo
Date: Sat,  2 Nov 2024 10:25:04 +0100
Message-ID: <34b8c52b67934b293a67558a9a486aea7ba08951.1730539498.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A 't' is missing in "binfm_misc".
Add it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/binfmt_misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 31660d8cc2c6..df6a229b5e62 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -998,7 +998,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 		/*
 		 * If it turns out that most user namespaces actually want to
 		 * register their own binary type handler and therefore all
-		 * create their own separate binfm_misc mounts we should
+		 * create their own separate binfmt_misc mounts we should
 		 * consider turning this into a kmem cache.
 		 */
 		misc = kzalloc(sizeof(struct binfmt_misc), GFP_KERNEL);
-- 
2.47.0


