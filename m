Return-Path: <linux-fsdevel+bounces-41403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF1A2EE55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4027A18D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443F230D39;
	Mon, 10 Feb 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xz6jxeKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3722FF58;
	Mon, 10 Feb 2025 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194500; cv=none; b=n2KdRCba2O9748BS/r7ybJgfDglgzJAcJBVordmm32tLlSrszNj7KKDRH0Qmu0BwKFN7qA5PClf6CjAm+1FG94jF6j7VJrHg+BvNm7WlCSMz2yFtQ3zGI28YVK+eJhEQ/USJdaT1yryqWP/qDzhx0+S6jKsRoBtwcQYG1cseZzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194500; c=relaxed/simple;
	bh=6YUF1zzOk5DgkFBUw1J2J/Kvch++VLEn+3f4rK3YDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcDdWw6r7lWqrWRWv5Jm1zpLGZQ9+9XlNj1bssUhcCuxbn1tVBInIOknBrjlIOB44zIxcSmVycVfxqPnVC/3sqAEjqLLIws7u+k/gp26m1EgOBWdb5MVjIArL9dGRNSzpY/5AuU5l23FGLOff3zlSEBajCvpLxG8+cPJANwGeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xz6jxeKF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6XmXVG2+oMaQiX+JohdVsei/y+eNiOuM15IHE+e0PcU=; b=Xz6jxeKFIH9ZE3GMg7YgZKmFyj
	NRLqtPh5iEo+yW7HJJcPN2vQvNry12Ou0NNO3rFHqSjcScZwrp8RMR+qwMT69CQeGa+jhaE4J1VDd
	t8+QJig0btcLvuDSW3CbCPV3j5FIwm7+BiYEY3TAH4r9gNTOKMEXfrTezApBiZ2o3LtfgY25DrK9W
	3iQLRSR82zxCrNxRTMUMpY0W7b/no4ZsIlNsPpmwvHIqjKMYwBolNqub+W0olwWb9unQHFRPfqIza
	8wNRltkyJo4CSX6xV8br/odvQ0e8uphmv0dQ9u4vToOh3b24q4Bn7sLvNOwCCEu2HDzQUFMWtpsCT
	zFuoxb4w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw5-0000000FvZq-3TT6;
	Mon, 10 Feb 2025 13:34:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/8] gfs2: Use b_folio in gfs2_trans_add_meta()
Date: Mon, 10 Feb 2025 13:34:40 +0000
Message-ID: <20250210133448.3796209-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133448.3796209-1-willy@infradead.org>
References: <20250210133448.3796209-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lock bit is maintained on the folio, not on the page.  Saves two
calls to compound_head() as well as removing two references to
bh->b_page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/trans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 192213c7359a..f8ae2c666fd6 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -246,12 +246,12 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 	if (bd == NULL) {
 		gfs2_log_unlock(sdp);
 		unlock_buffer(bh);
-		lock_page(bh->b_page);
+		folio_lock(bh->b_folio);
 		if (bh->b_private == NULL)
 			bd = gfs2_alloc_bufdata(gl, bh);
 		else
 			bd = bh->b_private;
-		unlock_page(bh->b_page);
+		folio_unlock(bh->b_folio);
 		lock_buffer(bh);
 		gfs2_log_lock(sdp);
 	}
-- 
2.47.2


