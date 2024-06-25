Return-Path: <linux-fsdevel+bounces-22307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DA91651C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8E228214B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76514A611;
	Tue, 25 Jun 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1oBWrVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ddLvbEk0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X1oBWrVg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ddLvbEk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0E14A089
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310753; cv=none; b=mpNzxZ5MaxxU7RrioxrbaQN3neRgKfByhElsHgDic0+GSmx9qJo3Poe7tnXHtPoF7xq44veOc5RWT5u0GMPgmFLYDuB4CqBdyrhRloX8/oZL83eaTcUwUKh5QUHzmzUfpmlsRanClpuDL0r1ObFlZr0UdyiRZqzUYnOeiF7SuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310753; c=relaxed/simple;
	bh=m/qJzAdNjRqtXAPnSZNOsBtxQm5ctHdoj1WYBPZKGcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ri8WrdnWPfdfQjyMPeAyPRZu44f9wqc5q90vo7zVObOPw5j9gfbcU/4Wxr4g80nOw5JpFGwEBvlkWNReCOoETNWJTryw5bFndCuuAapLS01SWyMNtnfaz5HrIO6F+Z6++lHPiRjAj0rN8HQpDzKfemsUvb0xzw1seaYzovoRFdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1oBWrVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ddLvbEk0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X1oBWrVg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ddLvbEk0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4314121A74;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GtSP3ENf+Nn0Zjpw67fKdoioBHD9GQRHkIbgNMfAUs=;
	b=X1oBWrVg4xsMpqF+iw4/qzQawWAC3E53h61k9OlLG8EiWFmGMGYqx5rpsH2yKP9EnsNZ/W
	p86Al6f+AiXkDugDZvXYh/RCkFEQiVALRyyoKNMhGwQSmMkib0xFO8BxOsIHTJcPOo/STO
	p/TsyNeT9EaVqNEsCZrkQhiCgiB9NmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GtSP3ENf+Nn0Zjpw67fKdoioBHD9GQRHkIbgNMfAUs=;
	b=ddLvbEk0+zG6pO4x/CX5agTYzeBTfPG+6B/1j9SY6mbfWqNIhzw00lxmbnGW9W8TSucVtd
	hjyjeT+uvehZJLCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X1oBWrVg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ddLvbEk0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GtSP3ENf+Nn0Zjpw67fKdoioBHD9GQRHkIbgNMfAUs=;
	b=X1oBWrVg4xsMpqF+iw4/qzQawWAC3E53h61k9OlLG8EiWFmGMGYqx5rpsH2yKP9EnsNZ/W
	p86Al6f+AiXkDugDZvXYh/RCkFEQiVALRyyoKNMhGwQSmMkib0xFO8BxOsIHTJcPOo/STO
	p/TsyNeT9EaVqNEsCZrkQhiCgiB9NmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GtSP3ENf+Nn0Zjpw67fKdoioBHD9GQRHkIbgNMfAUs=;
	b=ddLvbEk0+zG6pO4x/CX5agTYzeBTfPG+6B/1j9SY6mbfWqNIhzw00lxmbnGW9W8TSucVtd
	hjyjeT+uvehZJLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3313213AD8;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eOd3DJ6ZemZvWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6C2DA091C; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 03/10] readahead: Properly shorten readahead when falling back to do_page_cache_ra()
Date: Tue, 25 Jun 2024 12:18:53 +0200
Message-Id: <20240625101909.12234-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=jack@suse.cz; h=from:subject; bh=m/qJzAdNjRqtXAPnSZNOsBtxQm5ctHdoj1WYBPZKGcs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmNHpSB+XQ/EstcGHqo9zXZBB1e8CwiTXng+TGe fDYhmz6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZjQAKCRCcnaoHP2RA2XGOB/ 41/mS6sUw9L8KFEVMh/gHypoJtCWairiuHE5F2T0SgsKRL+5OTdU8t6rS8Rt0+rM6uHzX90ZGiWa5p 00FN8wTLlDa6vutwd/Sc1Xod1ESJWmLqqiulQ6TvdeAQAkabVbF9tfImx27PE1f+ul5/PGT1eGGGne e9o51jy0+23alb31k15nv0degSjvhPuf+TN/xut37QIU3LJFdV3GMlvPgOaRhgz2qHRbEDZQT5ClXW XW3eVo5umb82WlNwYlD7Ok5rb02xZKGhPkjvtCqyNfKKKNkhttTcer/cK2JR20pXAAtbzXQUSo0szT 14wwSa4lcdVqcVtcRYTgg4aCpA3xOE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.70 / 50.00];
	BAYES_HAM(-1.69)[93.06%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4314121A74
X-Spam-Flag: NO
X-Spam-Score: -1.70
X-Spam-Level: 

When we succeed in creating some folios in page_cache_ra_order() but
then need to fallback to single page folios, we don't shorten the amount
to read passed to do_page_cache_ra() by the amount we've already read.
This then results in reading more and also in placing another readahead
mark in the middle of the readahead window which confuses readahead
code. Fix the problem by properly reducing number of pages to read.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index af0fbd302a38..1c58e0463be1 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -491,7 +491,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-	pgoff_t index = readahead_index(ractl);
+	pgoff_t start = readahead_index(ractl);
+	pgoff_t index = start;
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
 	unsigned int nofs;
@@ -544,7 +545,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	if (!err)
 		return;
 fallback:
-	do_page_cache_ra(ractl, ra->size, ra->async_size);
+	do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
 }
 
 /*
-- 
2.35.3


