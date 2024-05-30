Return-Path: <linux-fsdevel+bounces-20573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139A8D53B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3558D1F2566D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64A15B10C;
	Thu, 30 May 2024 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFDsnfoT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ACD158DCF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100480; cv=none; b=Z7YgM+4kUYgELrG7SudF25vtoltwph0CkvJz9x+EeYLvuawE1rUz+0F4mUcxSBeiJtMeHO4h440+9b+y64CEMVFKOHvOQujSpeFBOE2OxEo/Z34uAjqPpZDYfJGZX/CCDU73fnrnCVprRuK0a4be47g6IkHwV7kQ7XeHWcrIRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100480; c=relaxed/simple;
	bh=NrpArSDjTXz0rUIvyWB9REeBUpI01g6IboTJmNiDC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2MmSjB6sCQaOkKL+5+Lg6Q6Pwln9YytlHrkPa/QGSRPEnQNbTtTX0L+Pi/CZAhAY+3HAKfsl7jbGjVrM5HF+VwftoBrsIoQcXSJTB3DR8Oj5RU8aU/dhgrHs32dVlASMLShhIsVjViuiJsOqecdaWdZprfuUv2jCCLCI+KkLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jFDsnfoT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xDEyHT7YZIluP2Z1qAqXZa0cLa7iWu0LWV7S69T1mb8=; b=jFDsnfoTRBttKQHcXXhG3r5avv
	VhgaXe/9ySpRWpwskNFRJhavXC58RAxAKMsYm5iRfwNS/AbGG/1mI0dLHzW63R52hsRUUWlpZGFtx
	/5eRLRl3m+FNt2HViffXlbNU/NN6R4fJAm99M7LOHF4THqDmV3j+9nPwDXEynVgj+F1sKRbut37/5
	JQ4BSA1HUbOexd11mRmhwlt06j4oXUO8yFU9eFBnz57Fu3jM3x5Aok06ewFzfWuv+Yzhiir5V1EI3
	eX0LcNxLRpwu7wNoa57cSVUNap2bAQs25BCrtB1bSc66WM60kXX9jYrMZkl+0xA8vllK7pxm375Jx
	IVRZ8uEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8Ko-0Ija;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH 01/16] befs: Convert befs_symlink_read_folio() to use folio_end_read()
Date: Thu, 30 May 2024 21:20:53 +0100
Message-ID: <20240530202110.2653630-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240530202110.2653630-1-willy@infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is slightly more efficient than separate calls to
folio_mark_uptodate() and folio_unlock(), and it's easier to read.
Get rid of the call to folio_set_error() as nobody will check this flag.

Cc: Luis de Bethencourt <luisbg@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/befs/linuxvfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index d76f406d3b2e..f92f108840f5 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -475,6 +475,7 @@ static int befs_symlink_read_folio(struct file *unused, struct folio *folio)
 	befs_data_stream *data = &befs_ino->i_data.ds;
 	befs_off_t len = data->size;
 	char *link = folio_address(folio);
+	int err = -EIO;
 
 	if (len == 0 || len > PAGE_SIZE) {
 		befs_error(sb, "Long symlink with illegal length");
@@ -487,13 +488,10 @@ static int befs_symlink_read_folio(struct file *unused, struct folio *folio)
 		goto fail;
 	}
 	link[len - 1] = '\0';
-	folio_mark_uptodate(folio);
-	folio_unlock(folio);
-	return 0;
+	err = 0;
 fail:
-	folio_set_error(folio);
-	folio_unlock(folio);
-	return -EIO;
+	folio_end_read(folio, err == 0);
+	return err;
 }
 
 /*
-- 
2.43.0


