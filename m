Return-Path: <linux-fsdevel+bounces-51243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD4AD4D8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 09:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400163A6594
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 07:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54723F41F;
	Wed, 11 Jun 2025 07:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F0SOC0ia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B623AB94
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 07:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628482; cv=none; b=pgrgDC1u9rdmSE8Q7tWY6dxQJGK/rVn+0Qij9X0cWwIG1VYhRMyFD2u3G4IC5v7dT5A6D3Obc1CbXLUbrBEXYG/7ZyI9Cwi0wPEj5lgk9PAVOF67iEpgjrvTivj8aNVDixL2Z0aU8+zOpABw1RqvWawUuIthAPZYpxnP3yKqJ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628482; c=relaxed/simple;
	bh=edFGqKlHXkckaQDiQ83yR3g7Q6Q1vJ1SPIWX1vYOMhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy5P+QBPK0Oa9Lg3VGy823tfsd/3fUZe12Zyv2cQu0EjaHb1fnXbKFF9UQP7TtSRHZhDrzlY3IfqBaMuOr1LrUsQsQqE3idOPZgkwFievqOwFVhdUHeHwe/CAMTnQ2ArTAsU/dQG1ejhozppt5bS3LEIFPnYtL6Q1PeKLP8rUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F0SOC0ia; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GIcOO15mNBhq2sRw8++RZv9gksFyt4apNu9m5nxDRw0=; b=F0SOC0iab18aAEa8S9m2sA5QvP
	uBZ6A357eTdSIPCdWc5eqb8dZOGFqh9yH3QmMM5eLXiuZZspPEvBQJ2R7qXpTsRGxwroRLVGYb/8A
	4w4iVbVjNRP53q40e6I+RZg/jiHI30nttxh19hCq0UCYgnRroFhRlKL/n/RPrtrtng05LwMivcXu+
	2Btq7tAOkmfRmx7Auq9f0TaVCABz7PLkAXnjKcOJ/G2onIpaSpMUfbUYdSB3NVaUUTcelXNKaDwQh
	VDYghJBJyL9/xnmF9rYyCu6KvRUmuOqJuAlG4nJEhrZ043YDKpPgR41uxTTtJ9ds3qOiS/W9bjYrp
	BdSuDvAw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPGIA-0000000HTwg-2f3p;
	Wed, 11 Jun 2025 07:54:38 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	neilb@suse.de,
	torvalds@linux-foundation.org
Subject: [PATCH v2 08/21] correct the set of flags forbidden at d_set_d_op() time
Date: Wed, 11 Jun 2025 08:54:24 +0100
Message-ID: <20250611075437.4166635-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
References: <20250611075023.GJ299672@ZenIV>
 <20250611075437.4166635-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

DCACHE_OP_PRUNE in ->d_flags at the time of d_set_d_op() should've
been treated the same as any other DCACHE_OP_... - we forgot to adjust
that WARN_ON() when DCACHE_OP_PRUNE had been introduced...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f998e26c9cd4..27e6d2f36973 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1839,7 +1839,8 @@ EXPORT_SYMBOL(d_alloc_name);
 
 #define DCACHE_OP_FLAGS \
 	(DCACHE_OP_HASH | DCACHE_OP_COMPARE | DCACHE_OP_REVALIDATE | \
-	 DCACHE_OP_WEAK_REVALIDATE | DCACHE_OP_DELETE | DCACHE_OP_REAL)
+	 DCACHE_OP_WEAK_REVALIDATE | DCACHE_OP_DELETE | DCACHE_OP_PRUNE | \
+	 DCACHE_OP_REAL)
 
 static unsigned int d_op_flags(const struct dentry_operations *op)
 {
-- 
2.39.5


