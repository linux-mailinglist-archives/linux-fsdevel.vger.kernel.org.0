Return-Path: <linux-fsdevel+bounces-63034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1109BBA9454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B51E1920A6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92376306D50;
	Mon, 29 Sep 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="JhfDL4dB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F682FF660;
	Mon, 29 Sep 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151005; cv=none; b=nOKpuryGdHZ2E80gpDwaySU6t6oclvjjDA43d+W+cVelEJHsKXaFwXCuinv9cXYFsJWLM7X0OIYHp4URThRVzYOuh+4y7YqdzcTqidVLIrG/Fw5sA0Ocj+Y6G6uazwXOGfuXGoggXXz8Q9dT376vtXEByylUo8iHEQleQisIybA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151005; c=relaxed/simple;
	bh=LzTE2ljUy6sSKUOSY1jKKrLU+Kb1e4RxVknuLHxVnGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGjXZRLM6s7HEIaye/V+mBK+MNyUEWtxa52/i+nCHr0/SU7utyGXcgvyts0ywMEZcCT3ptP3HYC/akBUeSnT9Y1/PWwNFTGXujKGp+mnFucJwzEjG6AfabFlqL3z1q2q5rFMTLhc7QhN6xh+2+IxYH6WXfdStueQCk3AAwM+LEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=JhfDL4dB; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4cb1Zv1pWzz9xxB;
	Mon, 29 Sep 2025 15:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759150999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oW89HVD/NELGEy19LkWCG4UoQ2Y1GIYPqdXfZGZvUH4=;
	b=JhfDL4dBAp9qBAfeXJj9DwIFel3FUvsoexptY7Nh2cXl7AMgWc3TG4Iz4PQMCUWzlX21Q9
	DzJvQl8FQUU75A08R+gUh7D539JyQLaazmFENeVjqCIzOE61D70HjIxNeuSsam1bW1eoXT
	32KKiNaimZFTReNrLe961aOtKqYlka4sOxWP7vx3Q3GXSpnL3gY3ruH2jPSvozOT+cb42f
	JKpXjwZWZ7iD2kQcO+q2iwWWHo5cR2wV3Llzor1jC1UsUclZ0Ey4+MV//4xldHziSm6LtY
	loTNu4+jKEoU7QHqeaZMpDJQrR4+D15Rt+sNWOOwK7Dti+pzUh4TLBxRj781FA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 2/2] fs: fuse: rename 'namelen' to 'namesize'
Date: Mon, 29 Sep 2025 15:02:46 +0200
Message-ID: <20250929130246.107478-3-mssola@mssola.com>
In-Reply-To: <20250929130246.107478-1-mssola@mssola.com>
References: <20250929130246.107478-1-mssola@mssola.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By "length of a string" usually the number of non-null chars is
meant (i.e. strlen(str)). So the variable 'namelen' was confusingly
named, whereas 'namesize' refers more to what's being done in
'get_security_context'.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/fuse/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3809e280b157..697be71de5a5 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -471,7 +471,7 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 	u32 total_len = sizeof(*header);
 	int err, nr_ctx = 0;
 	const char *name = NULL;
-	size_t namelen;
+	size_t namesize = 0;
 
 	err = security_dentry_init_security(entry, mode, &entry->d_name,
 					    &name, &lsmctx);
@@ -482,12 +482,12 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 
 	if (lsmctx.len) {
 		nr_ctx = 1;
-		namelen = strlen(name) + 1;
+		namesize = strlen(name) + 1;
 		err = -EIO;
-		if (WARN_ON(namelen > XATTR_NAME_MAX + 1 ||
+		if (WARN_ON(namesize > XATTR_NAME_MAX + 1 ||
 		    lsmctx.len > S32_MAX))
 			goto out_err;
-		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namelen +
+		total_len += FUSE_REC_ALIGN(sizeof(*fctx) + namesize +
 					    lsmctx.len);
 	}
 
@@ -504,8 +504,8 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 		fctx->size = lsmctx.len;
 		ptr += sizeof(*fctx);
 
-		strscpy(ptr, name, namelen);
-		ptr += namelen;
+		strscpy(ptr, name, namesize);
+		ptr += namesize;
 
 		memcpy(ptr, lsmctx.context, lsmctx.len);
 	}
-- 
2.51.0


