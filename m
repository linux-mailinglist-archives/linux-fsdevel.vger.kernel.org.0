Return-Path: <linux-fsdevel+bounces-20457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D128D3BE4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF3B292B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB6184118;
	Wed, 29 May 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcMnwLhA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71371836E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998873; cv=none; b=L+2EBHUw6aXpc6TyD2FKYMqdruzLJJn5R7X4WXzePxAI+nptRHDB/L2+YGT7B7LYlYDzhodkp4BqegxCFtTyOOQF8aIYb1K7j5eXXYkMtv8wtlBVDdKhM1sEPnXONbhPZWrxdMXHzRxQH6aNjvTRgGvFwpbtfdh+ApHHg5Z/gSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998873; c=relaxed/simple;
	bh=E9DNaoOmfthVbSQNM5zSx1ewbDVsnzuDLD8hcnb2gp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJYswZuRpLdFAg2DaSafrL50/VyTeP/Se+E+G+ng1PfUVDBL+K8WO9rS5727irYMG2+ypeKbDJ9vcwfn1oHXZxWiqjFfZYcC/nDI7OupRqKPhOB5gOK0GFVBcdbt+CMIGUiB0BLBPxNpBBAB1d4dA0Pgp+mQZMNxqR9P7hdBJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcMnwLhA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716998869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIXA4id9G2CaRpAXjkEzIwnBt0h+Tpbe5UdX8oSDWlk=;
	b=xcMnwLhAI1ZaHjJfQJolPSG3SR6XQd5C+R63Vp+xElxibh3Jp5gUTavEAijzqbJawBAxWZ
	ifKwmchh4xU5kIzkREMVlLbqTMhkifQjsjDRDBX88ANAGAU6hu7FXId4j+OW7tzq24zA6S
	R/SljvB3b5svAHQf2QSid15P3EHsTeo=
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: viro@zeniv.linux.org.uk
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jack@suse.cz
X-Envelope-To: yuntao.wang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] fs/file: fix the check in find_next_fd()
Date: Thu, 30 May 2024 00:06:56 +0800
Message-ID: <20240529160656.209352-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The maximum possible return value of find_next_zero_bit(fdt->full_fds_bits,
maxbit, bitbit) is maxbit. This return value, multiplied by BITS_PER_LONG,
gives the value of bitbit, which can never be greater than maxfd, it can
only be equal to maxfd at most, so the following check 'if (bitbit > maxfd)'
will never be true.

Moreover, when bitbit equals maxfd, it indicates that there are no unused
fds, and the function can directly return.

Fix this check.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 8076aef9c210..7058901a2154 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -491,7 +491,7 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 	unsigned int bitbit = start / BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit > maxfd)
+	if (bitbit >= maxfd)
 		return maxfd;
 	if (bitbit > start)
 		start = bitbit;
-- 
2.45.1


