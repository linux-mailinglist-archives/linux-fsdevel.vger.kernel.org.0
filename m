Return-Path: <linux-fsdevel+bounces-8600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB098392C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF26293954
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265265FEE4;
	Tue, 23 Jan 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YjEJGnb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bluJ3u3w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YjEJGnb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bluJ3u3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA785FDC6
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jan 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023980; cv=none; b=jL9qbj2sGTqGwhL8bcryAsgHrAvfbXvBSgsybBEy5rnMziUzmoX9/8V4glH733PW+VrhekZO5u46mGL1PUs/N6u1ferWgWKBXIhBq0VOu/YOJGlo17NBw4QOOmWdOx9DUOiL57UD7+2wBSK6mjmpWOhymKsCd5EzaQc3qjXuvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023980; c=relaxed/simple;
	bh=rcud75o9Odu9Y2B8NmGQCe7DOyOTs1VuoiONycZRC8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGxeDzCoayuLW7ffmseFoec5HNOaSI3rgT390mv60QEvUr+d37Fr5oxEiNARgemuDA8ZjSKudYWUSHh9MC0N70wSegLtAd2+6cFjw6h3UxjrxuhPdTpCGNzfBph7ghHNBj2FSgYsXT7vh68MZ3F/nFp+y8aMJ9vx2O1a5WnL1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YjEJGnb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bluJ3u3w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YjEJGnb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bluJ3u3w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE9B62234A;
	Tue, 23 Jan 2024 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n9ZQ+lfieOp07NChHPLn0Nl1T3KepbyRYuFNcNECB/o=;
	b=YjEJGnb4ZQq2d+TXUKmdcZvy/QipXPVe8Dy30xqcA6+hDhybdMmQHmYuFXeYBzAX8mn0aw
	SxYdf24g/qGgyDq6fhUaUeIhSh5sQMOAv1xuIFfbFQ6DKhT+Zlaw9gS8CrPTq3b+pUaZvD
	STPtPwLUFlenkn3RiH3AzeousEZJIp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n9ZQ+lfieOp07NChHPLn0Nl1T3KepbyRYuFNcNECB/o=;
	b=bluJ3u3w5hCySNUiLvqGhOGybBX1rg7kj2ta7ReOfbCJWU07aQBBRRFZtwDS51dO8vPfXd
	BZo/u4HhweCGt/Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n9ZQ+lfieOp07NChHPLn0Nl1T3KepbyRYuFNcNECB/o=;
	b=YjEJGnb4ZQq2d+TXUKmdcZvy/QipXPVe8Dy30xqcA6+hDhybdMmQHmYuFXeYBzAX8mn0aw
	SxYdf24g/qGgyDq6fhUaUeIhSh5sQMOAv1xuIFfbFQ6DKhT+Zlaw9gS8CrPTq3b+pUaZvD
	STPtPwLUFlenkn3RiH3AzeousEZJIp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=n9ZQ+lfieOp07NChHPLn0Nl1T3KepbyRYuFNcNECB/o=;
	b=bluJ3u3w5hCySNUiLvqGhOGybBX1rg7kj2ta7ReOfbCJWU07aQBBRRFZtwDS51dO8vPfXd
	BZo/u4HhweCGt/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBE74136A4;
	Tue, 23 Jan 2024 15:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RDzbLSjcr2UueAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:32:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36DF1A0803; Tue, 23 Jan 2024 16:32:56 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2] readahead: Avoid multiple marked readahead pages
Date: Tue, 23 Jan 2024 16:32:54 +0100
Message-Id: <20240123153254.5206-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3877; i=jack@suse.cz; h=from:subject; bh=rcud75o9Odu9Y2B8NmGQCe7DOyOTs1VuoiONycZRC8A=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGFLX3xE9/i6N8dqs1n79As7gQOsvAd2/+R5OsPbgfBe3unz3 uXU3OxmNWRgYORhkxRRZVkde1L42z6hra6iGDMwgViaQKQxcnAIwEWU2DoZJc/XifzU8mOsizJsq8v huj1Z9f6xxcKX64QQunQ3JHg8P7PBS6yir6lrBd9B3Y/aamqYzC3kUDxSbszx94FjpL3KteGNGbI7A Hpk6mYdBj4rFekOX79hhuNqtm2lpxFRNq2WaU7VapwT/rz8zR+O9+nVZZm9tzb8HT8T+1j9zTqOh1r TlXOgWxjaTbdLT2u6f86xeXHAwOuDtj2Qe3dMaguLTP9g9dJ7wJEdywbpK1YbuLOfFbVbKOa6zfgsF fnQIjV06+axD+faEt9sY4h8+CLaPeu1nriisw6PG68lwL33heUfuuUxXFV9sXFU+M+jvSvEfHg4LBb tcPke1BdiYe4ncUjZw/9hxY+8PAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YjEJGnb4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bluJ3u3w
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: CE9B62234A
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

ra_alloc_folio() marks a page that should trigger next round of async
readahead. However it rounds up computed index to the order of page
being allocated. This can however lead to multiple consecutive pages
being marked with readahead flag. Consider situation with index == 1,
mark == 1, order == 0. We insert order 0 page at index 1 and mark it.
Then we bump order to 1, index to 2, mark (still == 1) is rounded up to
2 so page at index 2 is marked as well. Then we bump order to 2, index
is incremented to 4, mark gets rounded to 4 so page at index 4 is marked
as well. The fact that multiple pages get marked within a single
readahead window confuses the readahead logic and results in readahead
window being trimmed back to 1. This situation is triggered in
particular when maximum readahead window size is not a power of two (in
the observed case it was 768 KB) and as a result sequential read
throughput suffers.

Fix the problem by rounding 'mark' down instead of up. Because the index
is naturally aligned to 'order', we are guaranteed 'rounded mark' ==
index iff 'mark' is within the page we are allocating at 'index' and
thus exactly one page is marked with readahead flag as required by the
readahead code and sequential read performance is restored.

This effectively reverts part of commit b9ff43dd2743 ("mm/readahead: Fix
readahead with large folios"). The commit changed the rounding with the
rationale:

"... we were setting the readahead flag on the folio which contains the
last byte read from the block. This is wrong because we will trigger
readahead at the end of the read without waiting to see if a subsequent
read is going to use the pages we just read."

Although this is true, the fact is this was always the case with read
sizes not aligned to folio boundaries and large folios in the page cache
just make the situation more obvious (and frequent). Also for sequential
read workloads it is better to trigger the readahead earlier rather than
later. It is true that the difference in the rounding and thus earlier
triggering of the readahead can result in reading more for semi-random
workloads. However workloads really suffering from this seem to be rare.
In particular I have verified that the workload described in commit
b9ff43dd2743 ("mm/readahead: Fix readahead with large folios") of
reading random 100k blocks from a file like:

[reader]
bs=100k
rw=randread
numjobs=1
size=64g
runtime=60s

is not impacted by the rounding change and achieves ~70MB/s in both
cases.

Fixes: b9ff43dd2743 ("mm/readahead: Fix readahead with large folios")
CC: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes since v1:
  * Fixed one more place where mark rounding was done as well

v1: https://lore.kernel.org/all/20240104085839.21029-1-jack@suse.cz

diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3..1d1a84deb5bc 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -469,7 +469,7 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 
 	if (!folio)
 		return -ENOMEM;
-	mark = round_up(mark, 1UL << order);
+	mark = round_down(mark, 1UL << order);
 	if (index == mark)
 		folio_set_readahead(folio);
 	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
@@ -577,7 +577,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * It's the expected callback index, assume sequential access.
 	 * Ramp up sizes, and push forward the readahead window.
 	 */
-	expected = round_up(ra->start + ra->size - ra->async_size,
+	expected = round_down(ra->start + ra->size - ra->async_size,
 			1UL << order);
 	if (index == expected || index == (ra->start + ra->size)) {
 		ra->start += ra->size;
-- 
2.35.3


