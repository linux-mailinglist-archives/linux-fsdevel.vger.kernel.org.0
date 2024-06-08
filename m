Return-Path: <linux-fsdevel+bounces-21284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 459E9901221
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 16:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E881F214EA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3903B14389B;
	Sat,  8 Jun 2024 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jWztZ6EV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85D1C6A3;
	Sat,  8 Jun 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857849; cv=none; b=tBi++uDH9bOw3PlSzTU3pHIJPZMCclzcsPXiRx4dsX+YyFzA3TN05/seXNOpZFGVNc9ISAo1UX3I9KuN4iulEgJVXzQWI7HwiOiBClSNEb4h6nMiwE19l73lA/XfhQGIpHduK2aUGcdIrg5Fb8tpnHuzmQXc5F7jqUh1QqRbV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857849; c=relaxed/simple;
	bh=lWUI/lLw4K/aku+gQBv6f012sqNodVM7vtKVJcOLBr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duPo3BsLCM2MdNb9NHfL1fJCq6EA9YgC4c++rnUNWoNqWIH5G9OyRSbgN20KHAOSC9/bxBhpS7cungm1fZ/wZtNu3RcOIuOURgn2a9l9LSQ1I9xQeQ2nPc+EmkNzFTKEXq4RA3obMORv82LZk2JBocZDBm2UrG5H/vH3HTWMmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jWztZ6EV; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Fx9Rs04TztVxQFx9hsAXq3; Sat, 08 Jun 2024 16:34:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717857294;
	bh=MxuPvXcFH8FAbiPwG6OxtP6h9EO2lNhJCavfueUtjog=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jWztZ6EVoUlEaMITLyVQXV8Wl8O4L5I8bCtc2ArUUjoekzpq2A2X3UkWKnT/jDAwS
	 XuzKKA3KABulEqqMzUvGPCvbgzdzEGF8BbzWm771khCIGhaHuwmWTQj1fUg/aS8qLq
	 +E51xjytZlntwD6T7ZvfEHocZ/I40zrT+EYKJAd1/cDAoZ2+Ky8gNppX9nQQ/To6k2
	 Ff0Mung6kPU0j8yDTU3xIXRkZ78hdvmoZtGEBkzzOjuwVcpt8j0ZPwIdKlTvSmYYQ6
	 75vhfG/svmw0NBCish3QjmHVTxyIMCum/6bEHOcaKPGwT+dshVyWRW6E2FlhTni9YT
	 GYF8R5lAKr/UQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jun 2024 16:34:54 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND 3/3] proc: Remove usage of the deprecated ida_simple_xx() API
Date: Sat,  8 Jun 2024 16:34:20 +0200
Message-ID: <ae10003feb87d240163d0854de95f09e1f00be7d.1717855701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
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
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
This patch has been sent about 5 months ago [1] and has been A-by just a
few minutes after.

A gentle reminder has been sent 3 months later [2].

However, it has still not reached -next since then in the last 2 months.

So, I've added the R-b tag and I'm adding Andrew Morton in To:, in order to
help in the merge process.

Thanks
CJ

[1]: https://lore.kernel.org/all/f235bd25763bd530ff5508084989f63e020c3606.1705341186.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/24c05525-05f7-48bb-bf74-945cf55d3477@wanadoo.fr/
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
2.45.2


