Return-Path: <linux-fsdevel+bounces-41404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C059DA2EE69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 14:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49E21686AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C675231A58;
	Mon, 10 Feb 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gpUQuPGZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0222FF52;
	Mon, 10 Feb 2025 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194502; cv=none; b=qoE2Ugepue4XBAuxYnJ4bfoZoR+O1zXfgAESFVGs4FIQ8LADhy+AK62YhkWFSED7XpunpBwCcHxyxwKaU6r58IxfqBoDKZIpT+Sv2PRW3bXFyBdL340xeuOCeoYtvS1BiJFg790R+owrVVparttAXJUGjIL1RLzQHfFbbjMtpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194502; c=relaxed/simple;
	bh=ATmhb9nW9MjSGidjnsF4t5/t8NVQeEGlTw4KWWgJJ0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k56OJuLb0GcL8pnLvn1t7pH4CUMWKsr3l2zNr9vKFEX1aYu7HPRMx1SaLulpbkZnbehmJYKK+9WxLeyTIa1ZzpTnu4LQh3klZySUG7+f+xCJDu5j9t8iESkemQbQpZHsK+3g9ikeby8Xfppc58+I4AXkAYWsQGRICbrzx2LGJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gpUQuPGZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hkLLwz4FFsmHh0s+2BRr5HbmcKpKIBWVZXDLMNKIqzA=; b=gpUQuPGZORfP33/kdQ7HHHYPvT
	SGRXWL6MROQEYdGLlA45PJPuLQuaGdwAuNsHPDyjMsTmCF2avUw042hKnYpHcUTrLEIqyRXieHsVX
	SdotHRXhCI/qHbaCQuK3zWMPKk/bLojXFGafnADnG0yMVhnTOEuFvmgUfUg7wVT0arFBYLn4039FO
	nXvQkaelEKqbC5Wex7E3OE6+SywbVbwpsO1WAFMGM1O+Zp14iHEmJ9xLPNjmsa6IbD11jmvQ30tJp
	So0tRFwPRsMm73ygrCOz6tQk9Fwq3v7Cta7h0U547O819+FUGrKEwkJEP31k8Fvv5FKjm5uVj/t0Z
	waBoB4Ow==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1thTw5-0000000FvZo-37uD;
	Mon, 10 Feb 2025 13:34:53 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/8] gfs2: Use b_folio in gfs2_log_write_bh()
Date: Mon, 10 Feb 2025 13:34:39 +0000
Message-ID: <20250210133448.3796209-2-willy@infradead.org>
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

We are preparing to remove bh->b_page.  gfs2_log_write() should continue
to operate on pages as some of the memory being logged does not come
from folios, so convert from folio to page in this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/lops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 314ec2a70167..d27f34688ff5 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -359,8 +359,8 @@ static void gfs2_log_write_bh(struct gfs2_sbd *sdp, struct buffer_head *bh)
 
 	dblock = gfs2_log_bmap(sdp->sd_jdesc, sdp->sd_log_flush_head);
 	gfs2_log_incr_head(sdp);
-	gfs2_log_write(sdp, sdp->sd_jdesc, bh->b_page, bh->b_size,
-		       bh_offset(bh), dblock);
+	gfs2_log_write(sdp, sdp->sd_jdesc, folio_page(bh->b_folio, 0),
+			bh->b_size, bh_offset(bh), dblock);
 }
 
 /**
-- 
2.47.2


