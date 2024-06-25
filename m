Return-Path: <linux-fsdevel+bounces-22313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C75916522
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360341F21A62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46714B06B;
	Tue, 25 Jun 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPRQuFTH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LSKvBC6Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CPRQuFTH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LSKvBC6Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F260E14A0AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310754; cv=none; b=C4asBrfc9JTI6xA9S7gFOqJm8xQ0KuxxL9/TbkrIsTeyvmmr6AgtiihoBLY4IEkfQs5iJa/y6LpPF6ClgIce8BiVWO1vNx+QixS5of6LqXtXz0J4dOVoVPSQu/aCGVnyqvDWhuMdWDDrEjzGYchOPxJyG4dKXNv7i1opO15+eQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310754; c=relaxed/simple;
	bh=lEGZ9ceRJWeyyjOzqii5re2SDGP3X5uqvnDqu1Uy374=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxvbbM3yvwiwNzNPrZNaSUGYzUAPg6WuuWDne3rMFKTFI3Y5bRsSCQVc6TSN7y6LPQfHVGkyq1qYAbAXhUUtsC+g3caZNIjYrxrldGwCr2QR1BQ9A1X5hAKyd7IPW5vcpJSzHZYXv5QssuJI2n0QsOSy5+b9ELIH0m/tLrPi2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPRQuFTH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LSKvBC6Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CPRQuFTH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LSKvBC6Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44D7B21A76;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mV9dyLmEXPNThSQksaqyuEvMuZusgKZh1jasd7YbD0=;
	b=CPRQuFTHYwVxIVw+g2eMSlxsPjbggxxUXCQfRNDhD1NlW8q6JLK8+CshOYwk6anmoR3fUl
	fI1wjbJGYN2Y8P24bTasEf3jjhhar0FnMXRlnHgM5D8It4y/VOV3MTGZYxKM6yR3vEEjtQ
	HWweKL5aMgQia8Ifc1QTcjwFPIGBNHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mV9dyLmEXPNThSQksaqyuEvMuZusgKZh1jasd7YbD0=;
	b=LSKvBC6YgkeWCQAEFbdQnz+TjvBIusyCMWFQdOKdssCqrHIdrT1waldL2D1hTjtrGOQ9fI
	NisUhjrFQLpG+0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mV9dyLmEXPNThSQksaqyuEvMuZusgKZh1jasd7YbD0=;
	b=CPRQuFTHYwVxIVw+g2eMSlxsPjbggxxUXCQfRNDhD1NlW8q6JLK8+CshOYwk6anmoR3fUl
	fI1wjbJGYN2Y8P24bTasEf3jjhhar0FnMXRlnHgM5D8It4y/VOV3MTGZYxKM6yR3vEEjtQ
	HWweKL5aMgQia8Ifc1QTcjwFPIGBNHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1mV9dyLmEXPNThSQksaqyuEvMuZusgKZh1jasd7YbD0=;
	b=LSKvBC6YgkeWCQAEFbdQnz+TjvBIusyCMWFQdOKdssCqrHIdrT1waldL2D1hTjtrGOQ9fI
	NisUhjrFQLpG+0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3667A13AD9;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cwcuDZ6ZemZyWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CF449A091A; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/10] filemap: Fix page_cache_next_miss() when no hole found
Date: Tue, 25 Jun 2024 12:18:52 +0200
Message-Id: <20240625101909.12234-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=jack@suse.cz; h=from:subject; bh=lEGZ9ceRJWeyyjOzqii5re2SDGP3X5uqvnDqu1Uy374=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmNR+m8V1id025gA4id7xWJlDI2ShIvOoiMTjnx wFCStsOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZjQAKCRCcnaoHP2RA2ayRB/ 9Vncl9kDets3toPAMTLaVJH0Fp94LwwQ3A3q5pHytHp6I9LoJZ3gp6ZKcPsBivY1Mj5hyKeePMiHML esiIA89Qw5DzBd7UOQ3Nl02fWfbW7Opb3mVqgEM6HSs0DnwJLupoO2QCsv7vK9vTnQijG4iTH4B+nw UwqI3m37d5mrTvjEsJ8GBGqbZspt/gpTntHImQlJkfG1si+upQb4hwjcKDpNfWZfANaVjSzXe2+bom vcZdBrUot3hp5CHlD+zo9p8XDMUJ1E6IVeqIS4FQ9I/NjRwZSgv80DA/ARsF9d+/ZlOkknM4oc2Kza PyzKdZGZQltTyARM56NBoyf7VcK13N
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.10
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.30)[75.00%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]

page_cache_next_miss() should return value outside of the specified
range when no hole is found. However currently it will return the last
index *in* the specified range confusing ondemand_readahead() to think
there's a hole in the searched range and upsetting readahead logic.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 876cc64aadd7..015efc261468 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1752,12 +1752,12 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
-			break;
+			return xas.xa_index;
 		if (xas.xa_index == 0)
-			break;
+			return 0;
 	}
 
-	return xas.xa_index;
+	return index + max_scan;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
-- 
2.35.3


