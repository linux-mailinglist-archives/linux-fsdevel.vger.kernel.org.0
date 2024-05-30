Return-Path: <linux-fsdevel+bounces-20577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2F8D53BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 22:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726D1B24FBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6416516B745;
	Thu, 30 May 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r1PiQqPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5B7158DD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100481; cv=none; b=DVhCtJ7CucEDx2FdVQd4V74NpjBSo9wYo6CUlqypK0NdoBSsah9EbLIvQ1i7NynDEYqeOOtJ2t2VI/8eKl7sGWjLjsyb4k3h7BI+AA6xEK/SFmQOzh6yo7u2APIe/50dLNbkPFx/oIm9eE6dzfURSuTIrr2EiH5ma4hMQ7odpuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100481; c=relaxed/simple;
	bh=9Wl7Or5G3IkXqEPcsD85gLYq/lgOOE3G7+fWToxy6xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsmiZ7EaZQgC3llAeQ/HDVCURBVb7sGuXuqg+QANmMzQbAzlwca1VrB08T2prdFY8KJpIbc0LwNxGRk00jMiSCOc7ySfDZ1PD4XkP89vzMqy6N/GF1INx/nkNK22sdvPnTBBYHC10qxIJrMXUWqrckAIW8wJgvWQ4NgxgjFvfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r1PiQqPg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lfQiTKH6qz2CerAT9IefP0Uh9+x805gtJN1XTCu7aP0=; b=r1PiQqPg62PY95U+/K34oIx2FO
	Ix6/vX7nDEgPH4eSKE7HpGyja2S34ZtMNS1RoYEAyBWQjGj8v4Jz+B1RFIuW01S6FWyHRKgbk9aM0
	Fqq8Nouub+yZzxecV80ftXTvDAlUpaH5wzeVRvQTeDvclw7MQ2TktztCZjTYtbFksiHua5UGsjpSv
	CgMRrmmEogta6zsrHi+3z8p8HtUT8vgtfEgDLHNz7tRzp9zzN+eZ8vWNfNd0FXvoVE1e0qaEXAJVG
	wK76z6EinY+c7xoAidiy+Vz9EweSdpW9q/7mUD6B1yrXkjgvp/OSjaYZkUuCASJz4vH29h6HC0DJ6
	Ao860Aww==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCmGz-0000000B8Kr-0exd;
	Thu, 30 May 2024 20:21:17 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu
Subject: [PATCH 02/16] coda: Convert coda_symlink_filler() to use folio_end_read()
Date: Thu, 30 May 2024 21:20:54 +0100
Message-ID: <20240530202110.2653630-3-willy@infradead.org>
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

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/coda/symlink.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index ccdbec388091..40f84d014524 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -31,15 +31,7 @@ static int coda_symlink_filler(struct file *file, struct folio *folio)
 	cii = ITOC(inode);
 
 	error = venus_readlink(inode->i_sb, &cii->c_fid, p, &len);
-	if (error)
-		goto fail;
-	folio_mark_uptodate(folio);
-	folio_unlock(folio);
-	return 0;
-
-fail:
-	folio_set_error(folio);
-	folio_unlock(folio);
+	folio_end_read(folio, error == 0);
 	return error;
 }
 
-- 
2.43.0


