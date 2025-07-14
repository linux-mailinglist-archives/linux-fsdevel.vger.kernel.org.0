Return-Path: <linux-fsdevel+bounces-54820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70599B03922
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162E3AD20E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80294242D9E;
	Mon, 14 Jul 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PDLqApQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-72.smtpout.orange.fr [80.12.242.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625AA242D76
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752481096; cv=none; b=RwYswQ/F2eu7p59V0toV93lE6Bqqtx6+uYT49SPtm1pkc/9H5YlEVpgI+7uHF2pA/c0oE+D7tkQ5uZ6CcItrt9LVnpxsiu94T7KMQ3YgnSUqxj6jNBMNLc0exLvz2cn7MeAfrgn4iHQnpfLsENFlqk4h/bVSErZMB8hhFt3NVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752481096; c=relaxed/simple;
	bh=MTkjP0sgoJwf5LDnn764LkXu/9c2IEJFkUb/5sFDdfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzwkDU7FR/fYKNJs6gcu0sIuIKWEoxSsz9SeezTCQ1q5xVa0F6XdQDanHo/DCBsxSNpvPy8JdgtanbvAHtypPpEXwkYWTRLnjDWN0kPNtshxo9xU6lvInOEV0/aBPgLl1WGrifaUFe/sRGcImPA0YdfaQxkTjw4M26GbMXNP1EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PDLqApQk; arc=none smtp.client-ip=80.12.242.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id bENfuHN2LILtwbEO6uVIq6; Mon, 14 Jul 2025 10:18:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752481094;
	bh=z3kT5dZJgpTnox9ypOuVPPZtOj3DHFcBoSAL9W8ASSQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PDLqApQkWB9P63Sz/bCJqYzOnru8j7BOyR3HrIvJUE2XAlzFHzeSrlulbPrv0MwSV
	 Z+uWeMTcr8E0C2zhdrgCHoMd9ukrmUhaxqnwj5yh4TzuokSFH5yfbkJmV5SJlWRk1z
	 6rI0qgugFJjyaa68tJvrh8Tm7uKfWJq60gSUCyH00IjpTZmOKBgNldqE4F16Nf7ysH
	 YznT/qPppWoPUEYCqHDQ6zHCvl5GvjchreuwpBPwvzuO4fHcy7z7NUnV5nXoNvKIGf
	 iTcopKfEOgNBtq112iofMeGRJCyI2F6rYiglwtUlG6hNUWsfkD17DncbB3o+RY6hPQ
	 sP44I1DCBRz9A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 14 Jul 2025 10:18:14 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: willy@infradead.org,
	srini@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 3/3] nvmem: Update a comment related to struct nvmem_config
Date: Mon, 14 Jul 2025 10:17:10 +0200
Message-ID: <27a9dec93a9f79140b11a77df38b1b45bd342e09.1752480043.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
References: <cover.1752480043.git.christophe.jaillet@wanadoo.fr>
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
Changes in v3:
  - No changes

v2: https://lore.kernel.org/all/10fd5b4afb1a43f4c4665fe4f362e671a729b37f.1722853349.git.christophe.jaillet@wanadoo.fr/

Changes in v2:
  - No changes

v1: https://lore.kernel.org/all/032b8035bd1f2dcc13ffc781c8348d9fbdf9e3b2.1713606957.git.christophe.jaillet@wanadoo.fr/
---
 include/linux/nvmem-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 615a560d9edb..f3b13da78aac 100644
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
2.50.1


