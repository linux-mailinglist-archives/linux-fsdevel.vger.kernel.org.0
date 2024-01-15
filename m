Return-Path: <linux-fsdevel+bounces-7956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97382DEA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 975E1B21328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8218048;
	Mon, 15 Jan 2024 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="OPEg1FsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60118045
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id PR9Xr0TyYx8edPR9Xryrz3; Mon, 15 Jan 2024 18:53:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705341223;
	bh=YQ342wzKG8l+HvEf+kwqJXG/SRijPi9FKSwNRrk06AQ=;
	h=From:To:Cc:Subject:Date;
	b=OPEg1FsTJjzZGTiT1H6UWm7uJzM+eOAIJVSnhT9wY+QhMSg6uv9EFGHOW5g5EsPc2
	 eSFbY4YFUv/zgOJyNDV6d50kRAbA1lEMr2r+QsLgYUCL6Ou3jZYmLI+OPrZtQw7emZ
	 QG4oV1vSEFN2A5FhQsCjF+eNK/30biNwKSOevKYdI2f3IcF7UIHPrBSDVywARfopC1
	 mJTcnV6wRiCnTrFOL9FuWhvtwq9qicA/6pqcosV80fm/4cnON4oEPzSOZ9Xom0aiWa
	 eq2+yZENB+yQ7b+3wfVMN20bjKi0cvp5bEUScvjliGMkVgKrE8JZDLVaQzxXwVWGav
	 IsHMoBV32/++Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Jan 2024 18:53:43 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: 
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 15 Jan 2024 18:53:37 +0100
Message-ID: <f235bd25763bd530ff5508084989f63e020c3606.1705341186.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/proc/generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 775ce0bcf08c..c02f1e63f82d 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -202,8 +202,8 @@ int proc_alloc_inum(unsigned int *inum)
 {
 	int i;
 
-	i = ida_simple_get(&proc_inum_ida, 0, UINT_MAX - PROC_DYNAMIC_FIRST + 1,
-			   GFP_KERNEL);
+	i = ida_alloc_max(&proc_inum_ida, UINT_MAX - PROC_DYNAMIC_FIRST,
+			  GFP_KERNEL);
 	if (i < 0)
 		return i;
 
@@ -213,7 +213,7 @@ int proc_alloc_inum(unsigned int *inum)
 
 void proc_free_inum(unsigned int inum)
 {
-	ida_simple_remove(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
+	ida_free(&proc_inum_ida, inum - PROC_DYNAMIC_FIRST);
 }
 
 static int proc_misc_d_revalidate(struct dentry *dentry, unsigned int flags)
-- 
2.43.0


