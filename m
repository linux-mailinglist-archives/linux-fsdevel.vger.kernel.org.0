Return-Path: <linux-fsdevel+bounces-17329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551AF8AB8E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7FB12819BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F47101DA;
	Sat, 20 Apr 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OAQ7QDzm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F0BE65
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581452; cv=none; b=gFKruss86ycFgNlfPZg8c/kQXMPZaHSS/C0A4Mbk087OcI76oM0WDX9XRgmiEYQcgHEbEPdLzbGD1Jd+2FwfFQvNh3ui16TAfbv1tx81or7luoBKmebaHohwO8oOjwUtMYsU09lyiXcmnAk0i4Tfc28nyPGIHnbP4pFut9YdqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581452; c=relaxed/simple;
	bh=NrpArSDjTXz0rUIvyWB9REeBUpI01g6IboTJmNiDC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPdkFl9tVmwwMARr5aAokXCKGfxfHjvQx7PyWSnRSSmUQVf3+MpyiDVjppZtJU6lx/xV2P7OxEsETXn86AkdfKaRAk+ymmP1s34dlIfCxbVeQuNEuDY0V+NlpfDzOU9gHRapSli8TRpfA6QnTnnjSRzUufMEAlMwl0MGGXiKjxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OAQ7QDzm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xDEyHT7YZIluP2Z1qAqXZa0cLa7iWu0LWV7S69T1mb8=; b=OAQ7QDzmbSM5LbarRwn4fZ4KC4
	zGXfsEYR2nF86TxhZ23O+vbNsdDIANizDQPcQF6Yh+o1Rh82o3AiUVN1Fjo+VwmOTeuZ+uGabwcdC
	Tvji3aiDra8pjJyewFJD38qVL6xA6yvf3MgbL7SemHJH6JxEkeyvuQtnV8KXLJvDsyZxfJWO6mAsH
	nTvMw5Ol0zDeEv8n1E3SsoZN1We4REyHHw3akN7JPp9uX9c8ddMoECxmLjBYxbj9RjfU3ttqXw7nB
	+dIXAdyuMOHy2Gj6gYcoCRwwcGp5apNPPzBdqlf7+PDPbedZyb1VFONqO7eyeea33B19L9LiMMyip
	UaxCXteg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oS-000000095eW-1cwe;
	Sat, 20 Apr 2024 02:50:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH 07/30] befs: Convert befs_symlink_read_folio() to use folio_end_read()
Date: Sat, 20 Apr 2024 03:50:02 +0100
Message-ID: <20240420025029.2166544-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
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


