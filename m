Return-Path: <linux-fsdevel+bounces-63033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E918BA9451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C330F1920BF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 13:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702E306B2F;
	Mon, 29 Sep 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="xhVVaT+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5823064B6;
	Mon, 29 Sep 2025 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151003; cv=none; b=oArNoJnrWiHS8JyZGqNoiCOV01HDxVvz9qgw/zbltIduUhjuu4JTy6/osZ7KpFp2Nc83xSJUqikeG3bNt96b7khDYClV03gedr9vyCbbDJq9DPp9rrTEc32NV3WVY4ZdwFOX1z2fKV1mVKVl21jQRr5KU5zmo6upqAB0DfltoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151003; c=relaxed/simple;
	bh=9cLDL6BDcxUeD8ygBxAXsuqW9GRVqGLr/6YpVc8G2uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnK/cfsLpZdS7LGbAMYStRpf57N/+Nwg8LRfbFuyjpLblRhNnw6SOMdOpHHfqaMRvCFGSJ9Qa8EeX7Zc31oY/SKlKL4+WD1yyTdz6n+JPa+IodZKcpJejz2ffdJwaXkex3EctZ2AYDWExSQpb38FxbWQgo2b2weEk0u6+JnQqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=xhVVaT+R; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cb1Zl37bFzB0X9;
	Mon, 29 Sep 2025 15:03:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759150991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwpAyD98eu112r2uszaUbSY+ysvo4GOF6cgMlDwrpJY=;
	b=xhVVaT+Rr9Ch3T2J9BYF4kC2GNRzy2Oswzppdx8FjFQfEEc095r9D6l6O0KC5cDnZu3May
	3KmQoeIGaOWN2oB+xQN0n6TF6FM18xpTrshXzFgAmkID5wDsf+mKrg5MEmnZAA4CQzTRZe
	jq7u4lyK1dIT15sI6B30T4DePyH7HDV/alx9nIiSleEVSRWIBpZCwVsA7JSLPO0VtFlsqL
	JxXt+rh31a8L6iju0OdKoatr9X/3lgntCTEvbAGvNAt+wrtbTdT4O9SUXd/7Gflirkn/2z
	4DJjnZqpx4NJVB1ZgXp0qzwOJ2v37rR43J2YxFc559XiHr7RVSlxwVQ1Z3PFYA==
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
To: linux-fsdevel@vger.kernel.org
Cc: miklos@szeredi.hu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mssola@mssola.com>
Subject: [PATCH v2 1/2] fs: fuse: Use strscpy instead of strcpy
Date: Mon, 29 Sep 2025 15:02:45 +0200
Message-ID: <20250929130246.107478-2-mssola@mssola.com>
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

As pointed out in [1], strcpy() is deprecated in favor of
strscpy().

Furthermore, the length of the name to be copied is well known at this
point since we are going to move the pointer by that much on the next
line. Hence, it's safe to assume 'namelen' for the length of the string
to be copied.

[1] https://github.com/KSPP/linux/issues/88

Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a1..3809e280b157 100644
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


