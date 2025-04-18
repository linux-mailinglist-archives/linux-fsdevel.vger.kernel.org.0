Return-Path: <linux-fsdevel+bounces-46658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D74A93008
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 04:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576BF8A3B60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 02:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6188267B90;
	Fri, 18 Apr 2025 02:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kpdvvT0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from coral.ash.relay.mailchannels.net (coral.ash.relay.mailchannels.net [23.83.222.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42D770E2;
	Fri, 18 Apr 2025 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943894; cv=pass; b=GHkBugaK5Cl441Gw/FhKtJk0/VOeYcpgsZuhsepkLJvFmEz3HgBNbVBBYhBar+UuA0ZVtA+zZirmHz3aynfJXwIyhW048BblyrL+jJ1dyJSJ60VOMnc7rw2m/6QB7Evidf8GpbzsxjjbbUS7L2q1UHU6teqeIHG7UmjJXqLY3sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943894; c=relaxed/simple;
	bh=caXlnD2oHiRYk4Cd+v3z9Gfe8ZSs6QrQWezKNp5Wa0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q/lahEPLE5HWCcbbvi19TSBjHBV6S1tAq4ZZ9hGFnUzTBwaiPBQXpkg4+FBW+Lf5XjN+yd4eOGsZGKH2zcqjl/mErhsxdooDdHdrGCTdAkh0zOUj1TfP/p9nkKeJp4YBzair64B7sdHP0hOAkS922x+h92GfkYuFqMQUPUK43/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kpdvvT0I; arc=pass smtp.client-ip=23.83.222.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6A4B14E3E63;
	Fri, 18 Apr 2025 01:59:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (trex-8.trex.outbound.svc.cluster.local [100.110.156.188])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 0ECC44E3DA7;
	Fri, 18 Apr 2025 01:59:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744941577; a=rsa-sha256;
	cv=none;
	b=9z4NAulcqZEtIT3DSYAMJEEzyHl4OUVDXYUa/u5xxIbUVEx9loFzXyemUYJIxCWwdjYugU
	WVF1FilRhnoPGcGgKkwBwVfepuUU+AqqpF3wAA1KcaG8DZbz/nIgk9g1NTLrx3uW6NYbyn
	+b/V3NaPWumOJic84c6hJowbpt0eGJ+PO5jbunEdw72a2KmiKWXfJ2HOPUtHgjV9irGf6x
	ymgpFhEeG3oIadQhFKeXeJ5C/sirbDB3bfPjKFoV0v16fYNioIpl8r1LN0rvGYNtpr38zT
	P1FzH/j3/aENh8ndcvWFl3cunGnzuk0PdkKns6nGngAdcG9fM2inhua8M0UgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744941577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MabBCGA0m9wa8fg8pahJUNB3mGjC5+Tn6ArLhv/vZP4=;
	b=f90j+YzQ7hjLmbPv83G8gY9IV1ngRf+fEsgixVWiTHTW34CL04W5yZhP5quyBOfr1nG4sz
	WwuXcWe6OJOxnILNXMKEecU/l3HkvNTGImZohFuToUOLb+gLH6XUYJJzPWFgSARgULnusF
	ibDXExRqho6UW5OK1/337w/kviXgddoOO1mzTPCB/X51rWMKAVznGP7z4QcBTzp/GzuRIZ
	pxUH4WR014BcLc5wosFrmtvAbytHTS6lGt8Hh9xXJv8ExN1kCJXrNYSkjIBz1tVHA6fQp5
	rBqYWsMYOWd0/2K9nKxhqyR+L+POmNVJ0fwLtJhTKHUF5MUGqCoeBTlJHtusuQ==
ARC-Authentication-Results: i=1;
	rspamd-7bd9ff6c58-xxcc2;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Chief-Stop: 39defe2a79e53d38_1744941577351_2613637192
X-MC-Loop-Signature: 1744941577351:2941586493
X-MC-Ingress-Time: 1744941577351
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.156.188 (trex/7.0.3);
	Fri, 18 Apr 2025 01:59:37 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4Zdycm1J43zC4;
	Thu, 17 Apr 2025 18:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744941576;
	bh=MabBCGA0m9wa8fg8pahJUNB3mGjC5+Tn6ArLhv/vZP4=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=kpdvvT0Ib2FwXMXNFIsJ1B3ejhEV1qHORy8ifsLmPDuDI2XKOMNKHFP5Rw0CyLl6w
	 rR7V8hLj+GfhGeWq4jzNR3MQZ8cgo84qj8xXYxoeLMTWGMFoKm55+n8ZLsPgH8Aypr
	 wErbSM37TrMzASGozlXONJ4ETYCh+H9xLho51IyRgg7sqopDUKLBRXEkzinUEH0/Eg
	 fqka2BRDE/gaK4M5naK6mkgn/RN+5RRk7FawYGfUHZf1Gy5gbN9i7ubDYRxOs921G3
	 +trPpaHa7x8wUg9nakawBIH5pd3uABIt1rk3+wl80IGVPnZdyuX0hEpjlKqANg5W7O
	 A5iiKcalfiCKw==
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
Date: Thu, 17 Apr 2025 18:59:18 -0700
Message-Id: <20250418015921.132400-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250418015921.132400-1-dave@stgolabs.net>
References: <20250418015921.132400-1-dave@stgolabs.net>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


