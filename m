Return-Path: <linux-fsdevel+bounces-62022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4944CB81D7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 22:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A705876F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05BA2C21CD;
	Wed, 17 Sep 2025 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="Htz7VuoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6B1B3923;
	Wed, 17 Sep 2025 20:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758142564; cv=none; b=k1puzlG2XLalkYXNONUGYDEixC0i5eOGXczLENQbcrc5WZT9iTBUp36AyrSpK7xbm3tprSSvuboIp2BoFuPxZTZrMu6T4tfw8gvlCf5ZJo5EipM1kYCtro575pdKCE5lkLWHUjHiPAyP1pgccJeU0dSdq+p9J9fddCJ09W92jek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758142564; c=relaxed/simple;
	bh=cta2cW3Ob7xFKfgEpbGkHdI7O2ayRzMvo7pSFK9mC9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzvDqK3l7ieQMHArXu+7skAakdsrOlX5GIHNoj4cPg3eel09ZkjHxFKK1/qEyOwE3fwhtLUDJekgkeMPe0xi9llFHvF8aDoXHJcu/DpeqjqzSfwyXFS7j4xAAaKRXNlo51a5fxdrY1AXTjK60poclNXnNi4bznGgErkmbrZ7XC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=Htz7VuoC; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cRrdg0NNkzB01r;
	Wed, 17 Sep 2025 22:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1758142551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Pzot2pDiV/aGKMYv1wLHbjdp+otZxRPtdw6wNcTQzI=;
	b=Htz7VuoC5njBk3t5apw6r4iMJa+Nioqg6RMEA00t0Z1vQQNOkrqlT4brldfd1OqnqrnlCp
	WD8r/KWUt12kVTeiKMWKTog4yK1KhYLvTvEqJDpvBvLaIgXAXp7qdns0YNuhsUeERSgceG
	4IQGk8bPb2gDpcWJnPlAPHCG9fvWMCUShHp84TZ7PV2Whft7mLjMv/CIDaivQCwL4w98pq
	x94RgkRjDegDsQh4zX5a1H4S0UKYxwZoN3bSNyO6i2rIbREaACxrV/sHZdn8rwgOGh+yZu
	4ITBdx5tklOlOMI7b89XQi8lP7H+w3w0iTRLw+qeXSgrGYMy3gO+UUD11EKJpw==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH] fs: fuse: Use strscpy instead of strcpy
Date: Wed, 17 Sep 2025 22:55:33 +0200
Message-ID: <20250917205533.214336-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As pointed out in [1], strcpy() is deprecated in favor of
strscpy().

Furthermore, the length of the name to be copied is well known at this
point since we are going to move the pointer by that much on the next
line. Hence, it's safe to assume 'namelen' for the length of the string
to be copied.

[1] KSPP#88

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5c569c3cb53f..4982efa2c178 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -504,7 +504,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 		fctx->size = lsmctx.len;
 		ptr += sizeof(*fctx);
 
-		strcpy(ptr, name);
+		strscpy(ptr, name, namelen);
 		ptr += namelen;
 
 		memcpy(ptr, lsmctx.context, lsmctx.len);
-- 
2.51.0


