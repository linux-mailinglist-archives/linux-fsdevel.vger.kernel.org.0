Return-Path: <linux-fsdevel+bounces-25549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959B94D48F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 18:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C3B2827A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A071990CD;
	Fri,  9 Aug 2024 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lmsar3BG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB4168B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Aug 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220559; cv=none; b=Haw4dy4vpq+3bACoblyfO93e0fcoB0vZObjMCsTeX4yxhmMqH9akclWNyWlCFVjcgKQsok7/9GxKjEm9UHbUJKJyKZeiZ/MuIeA2ccaxYYjqWy/ZlsRrTAVPzYfpDwXrWIsEidHhb52f9qb+o8Svwq91UY2Me9ta2mQjYBKCGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220559; c=relaxed/simple;
	bh=jRe2oXexqSximhCJ6OwueABMYyYWI0m1cYd/J7KV/Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXUVn3d1M2lFNcbePM77OKxp9StgPrwPNhReM4ue60kBQfFh+gfQuSvZS9abecQemU0feXgBnGQXs3SRBWGWkiB8PUypbUyM8RPyxd0Skwv7yaegftbf8O38vuYz/4ClZXadoyVJdWa8JvFVWbOLXTqufvE+BKdhh9wR5J9fjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lmsar3BG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xdLLmXTXY3NIVPPwRtex6MS+2C4N31oP3hOM1qLCR8g=; b=lmsar3BGC9iJXw98yAlsBrbvHj
	1A1fxanF8yimpxVY5rcoJLzrLjpH/s9i/bUvjD+Yhy7i5t5Eeh8zJC7XJW5Dhw5vTU3OdeLHp3xVP
	p30kbnK6ky6g8CMi7HdHKY4RkcfXLdnmWwFfpvTEkiHO/soXyuTn98oajGjCdK/NODVOtG7Yoll64
	w35FRTha0oWibFLZO3SyW3LbYzJ8dYutw+p7bqimiC21PN8qe1MZqJWGCDx1G8xCF+BzhxIqJL5SI
	x7oJSbxHX++NVPRzDgElZn3NHmXo1kXEoY28Xb72R2dsIIXjiiUJ19XmMMBlH9n9f/mcUh75oXRfd
	CwqqAHnA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scSNq-0000000Apoh-0bVM;
	Fri, 09 Aug 2024 16:22:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] fuse: remove call to SetPageError
Date: Fri,  9 Aug 2024 17:22:18 +0100
Message-ID: <20240809162221.2582364-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

part one

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce4157640..4bf452d5ba9d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -939,8 +939,6 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 
 		if (!err)
 			SetPageUptodate(page);
-		else
-			SetPageError(page);
 		unlock_page(page);
 		put_page(page);
 	}
-- 
2.43.0


