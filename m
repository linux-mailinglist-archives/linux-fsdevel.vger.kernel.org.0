Return-Path: <linux-fsdevel+bounces-25002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2109479E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F741C2032B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC288158A03;
	Mon,  5 Aug 2024 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kriIqqh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD15157492
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 10:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853808; cv=none; b=DsC/CKw/wg/xS6h0cxJarLT+G34BKcYaqO5H6ztnS9d9jDWj5EiiyQZEy+6z+3dPMBdU78hbj+EJtIAy3SrhF77zMrcOB5qYKg43A/w7+TShSn/DC/cOSACGETw6d4LEtSVN5+1MmL90pjIwD+Nzxg1ME/gw19ke0cMdXgo1Wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853808; c=relaxed/simple;
	bh=WM4jDsNl88icLtOhSZc2z02eEcUwms+W5Nt3XUgfBA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOmr1kqzavg6eEKPimzP4vdAO4HLgaCEZwch+kXN7l4IyVLGiiDNoSfjBxBQ8Hy4IIMDlS7zhFPB/tp5ecLy0zfQT5lwtF48gsAbSBl9M+CRdsPb0hhAFn/s3DKVebrgHb2xvHHNNddlRcUlfvAT/MTELGlB0yR/7B4XUusrBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kriIqqh2; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id auyPsh8Id6NRTauybsps9S; Mon, 05 Aug 2024 12:30:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722853805;
	bh=SUPvmmO6LqCQ5AJ+3l+Xza8HDESgMwZoQBA6LVUiG6Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kriIqqh2bjejAkv2YmddnEc0Y4ilI3Oz9+o896mHu/UmgG34i37XlCUGmgJBCJKY+
	 7Nx1UNUqr3mKPSgDFgAzj0KALd2FGAv9NWF16moXTKyZ24nytpJD1ZZ2yv5rieCf20
	 BSyRL5QCZ5i1BDZ1wwBc6XITuqwkPKziCioYcsxpHfXffY+cObAvFgYrlche/TVshv
	 kKkgnTILIeJlvPEKTJkuDvXXovt90EOd9WLtU1qAvjgLUCRFfWK5NyPCPJIBdGnk74
	 d8NYE2cKJhkVFYmDemegMJnJ+AuVEzjhZnFx8m6xs4jgUZ5y2NnPJfJOcRTDTaZrVY
	 owXjzL7fktMkA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 05 Aug 2024 12:30:05 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srinivas.kandagatla@linaro.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/3] nvmem: Update a comment related to struct nvmem_config
Date: Mon,  5 Aug 2024 12:29:49 +0200
Message-ID: <10fd5b4afb1a43f4c4665fe4f362e671a729b37f.1722853349.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
References: <cover.1722853349.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update a comment to match the function used in nvmem_register().
ida_simple_get() was replaced by ida_alloc() in commit 1eb51d6a4fce
("nvmem: switch to simpler IDA interface")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
  - No chnages

v1: https://lore.kernel.org/all/032b8035bd1f2dcc13ffc781c8348d9fbdf9e3b2.1713606957.git.christophe.jaillet@wanadoo.fr/
---
 include/linux/nvmem-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 3ebeaa0ded00..9a5f262d20f5 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -103,7 +103,7 @@ struct nvmem_cell_info {
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
- * generated with ida_simple_get() and provided id field is ignored.
+ * generated with ida_alloc() and provided id field is ignored.
  *
  * Note: Specifying name and setting id to -1 implies a unique device
  * whose name is provided as-is (kept unaltered).
-- 
2.45.2


