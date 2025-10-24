Return-Path: <linux-fsdevel+bounces-65551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5089C077AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2282349E36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C693446A7;
	Fri, 24 Oct 2025 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oa5fkt8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956D3451C1;
	Fri, 24 Oct 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325714; cv=none; b=NKnNl4AYldN2dxUAryr5ucS2RGMX+TwU/imvJUqdP/QUldAHypBfEFrBwUJ6FsgdWzKPMFOo1gtXPcg9+VcppUXDfguqabzGvbb/Ggyw/oGD9UPtlqoQ8jpqd2FVGl6IrMduSFFhMb47v3V0uUZbxOQBCWOxpLFQ7OIn2QxumF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325714; c=relaxed/simple;
	bh=eOTJkDhs/Em52J4x9y3W3VKPR/V/IAgsf7iO1KaaTjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAfA7T8q22PMqrcoAidFJ3dycW0lb4H+JrPJVwPi8M0J5mkvjThkbBKvDQSdIb2dBeB06jUwiheJEjg1+QcsmEeqaRjdrBzaYrZRN8rEQ8tqLv1srts2of8U+srx72LenR8pHIeqchaxT/nNCOyDdMb08jqc7nHcDfz5nJrHw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oa5fkt8L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Z3HvvbPPRTxOifAwwzjWTFFR09weUs/ccrBIGBuCxl0=; b=oa5fkt8Li8ZBqJWcALqr950U7L
	WCJMIX6j6ml/MiNCgzW+hpMyUHZesFOYLF0L81Hsqxnd3I9ZptJpVa+dFtSU3GmiFVFrRsv2Mtdsn
	69dXdVUMHct/krn06tjCVuRyxk5fHVEx9pLHI4MMh9RjEcg8CcqPtBizIVm5vbiOVuVKLnrIn6yQZ
	7mwGq590YjlY4kiUJ6iOJTNMLhUiWbvlh8/90PXZyAjVEtlAM+eUzDu/OeEx2aa2ZEHnid0LSbdb8
	n1Ve1InvyI8j7Qi4hrxjhAYjGltxAljp1O5h2WpL4ObJN6z20Z/xIruN4dx9S+Aj59vjt6OgMiZMb
	GZCMuwXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCLH7-00000005zLm-11yQ;
	Fri, 24 Oct 2025 17:08:25 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	gfs2@lists.linux.dev
Subject: [PATCH 06/10] gfs2: Use folio_next_pos()
Date: Fri, 24 Oct 2025 18:08:14 +0100
Message-ID: <20251024170822.1427218-7-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024170822.1427218-1-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one instruction more efficient than open-coding folio_pos() +
folio_size().  It's the equivalent of (x + y) << z rather than
x << z + y << z.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev
---
 fs/gfs2/aops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 47d74afd63ac..d8ba97bad8bb 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -81,8 +81,7 @@ static int gfs2_write_jdata_folio(struct folio *folio,
 	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
 	 */
-	if (folio_pos(folio) < i_size &&
-	    i_size < folio_pos(folio) + folio_size(folio))
+	if (folio_pos(folio) < i_size && i_size < folio_next_pos(folio))
 		folio_zero_segment(folio, offset_in_folio(folio, i_size),
 				folio_size(folio));
 
-- 
2.47.2


