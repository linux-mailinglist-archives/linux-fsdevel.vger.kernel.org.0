Return-Path: <linux-fsdevel+bounces-46523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135ADA8AC06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 01:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27787442B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 23:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7812D8DCB;
	Tue, 15 Apr 2025 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gsJGIIgX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fossa.ash.relay.mailchannels.net (fossa.ash.relay.mailchannels.net [23.83.222.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF412D8DC0;
	Tue, 15 Apr 2025 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759377; cv=pass; b=MYD+Evh0JOED39LyP70Z+V36+3VpeH02Rjhz0ufisXGs7P7HmnKxHdTpDZbbfjXnMSCGqLcyQpmjCFLH+harcaOyG4vOUBL6h4mSyIonTE7vX5AD3jvAoxVgQjvoj92py1zvAPsWxerMMYsLML03eF/SkLhwKinkF0/BXFcIGlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759377; c=relaxed/simple;
	bh=5wj7w0EqdqbI4zqcKgQlY4yWeZGmMR0uhyDhMueNQDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0pqvVeyBfzS6wHDRVIrlq2tMAqSOFv3tg4SAambSqOIsblzIn9Hn2sEjjI8xU2o9SLK8ZprhPAWAi5CHSuVvRxw/qqhajObj4FYgdS79zx+vEUTxbire5CuG78EgyIYkQ5n0pawtXkcTAJOfNVQbKk/X1SC41LVeLJoGDKjwo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gsJGIIgX; arc=pass smtp.client-ip=23.83.222.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C64198A4E7A;
	Tue, 15 Apr 2025 23:16:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (100-110-51-113.trex-nlb.outbound.svc.cluster.local [100.110.51.113])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 640B68A431D;
	Tue, 15 Apr 2025 23:16:46 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744759006; a=rsa-sha256;
	cv=none;
	b=tUxKOB/9QTR4sBgW0AOL59SVZqDVbUGCYXi/ZdcJbFwCquc60vPyl4v5/MgSjxEfh/s5Xo
	37HXyyyr4uSDbbo8dnGHMdZmVqr2cPVqTPlOObuwd/+fyyZCTjsAGyUyAr8l0KDByFYLNi
	sGdjbwK2gf/F6bUgSEeDaqRIfx9d7a4+NuldmWGmkLCbWz0eEvw4P56VGup+ARujt/Dudh
	cJ8ohVIwRn6fj+DleN2aJl+hYSjpwelqhB8X0kw2BHfu0jZcCLzOufPIcyOuew47zcLRyi
	joz1+POFN3uqfHQdvtYN9LwF539i156rDL/io/PFsrwPju556nLJ1lWKHwNciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744759006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=hAfviodp/gLLm0eey766/10wm/tzbxHrlsddbZHBKzc=;
	b=DGVz1LUHDl9St4pyJy+nI5psn4jN0Ukq2R4MK2jIWDwgYJwkU4MlPB70GpNrOrUIltcCrM
	p6tRWm59Vcq8cLBDNY7c2WgVpAcRpMuA5+CfYZlKlcvLAfkI9pKS09rj/0wbk6JH4uYxSb
	jD8T3yEgTUWwaF9WCw/1j6CE3jpWjjxO7mHSZLN47pGc6lsxRF8fWiEBWmVLDfIafG67GK
	tokttGQntFin8lZLlckrg2JZAIeCD4j6rDKjZuzS3i0J5w8/ywwtW/4+6S7wbqy4mDm0Sc
	4knIFtMZ7ffeWCzUABJwVZj75eDRhYEGfj84EsZJxZXjEXusWwcNh4hrk60HKg==
ARC-Authentication-Results: i=1;
	rspamd-5dd7f8b4cd-xblgx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Reaction: 238d86ac483882e3_1744759006711_2123665616
X-MC-Loop-Signature: 1744759006711:731362905
X-MC-Ingress-Time: 1744759006711
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.51.113 (trex/7.0.3);
	Tue, 15 Apr 2025 23:16:46 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Zcg5n4Bmfz2Y;
	Tue, 15 Apr 2025 16:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744759006;
	bh=hAfviodp/gLLm0eey766/10wm/tzbxHrlsddbZHBKzc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=gsJGIIgXbbb+ninDu7ElNLHb2/58AluN4DhLdYyx+nMHoc2XjCeUB+oE7NGHsD+zu
	 KQqWHiDOSuQit0E93orTLPZTrLykpXciu7fgaKDZ77mkGTvK6n0BpKUcEHRGEExwsQ
	 OhepBQJ1/QG/Y0fZYxXqy6OgeBtTX0Q523g4+qqQ1XGkwvvYUMHXkPjxHNf1P4giqz
	 Gi9R+CzUqMaaPnr9FB6UBra6imA5whgp7n6pBTYjfj0FP4jZGSIOwytD/6l6817aJS
	 IdTfubhJIRJ3s8GED/Wo+lgcZGu2rqpyJKpSrKTB24JV551cqRcKVwydMZeI6J4eM4
	 B5DWhzjypMxuQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jack@suse.cz,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	brauner@kernel.org
Cc: mcgrof@kernel.org,
	willy@infradead.org,
	hare@suse.de,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 4/7] fs/ocfs2: use sleeping version of __find_get_block()
Date: Tue, 15 Apr 2025 16:16:32 -0700
Message-Id: <20250415231635.83960-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250415231635.83960-1-dave@stgolabs.net>
References: <20250415231635.83960-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a path that allows for blocking as it does IO. Convert
to the new nonatomic flavor to benefit from potential performance
benefits and adapt in the future vs migration such that semantics
are kept.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 fs/ocfs2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index f1b4b3e611cb..c7a9729dc9d0 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1249,7 +1249,7 @@ static int ocfs2_force_read_journal(struct inode *inode)
 		}
 
 		for (i = 0; i < p_blocks; i++, p_blkno++) {
-			bh = __find_get_block(osb->sb->s_bdev, p_blkno,
+			bh = __find_get_block_nonatomic(osb->sb->s_bdev, p_blkno,
 					osb->sb->s_blocksize);
 			/* block not cached. */
 			if (!bh)
-- 
2.39.5


