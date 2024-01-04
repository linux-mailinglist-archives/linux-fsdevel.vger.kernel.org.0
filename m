Return-Path: <linux-fsdevel+bounces-7349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E98823E05
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 09:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C1286C81
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04A200CA;
	Thu,  4 Jan 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lkMsM0GC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6iW/ShH9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lkMsM0GC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6iW/ShH9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FA1EA90
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75E071F7F6;
	Thu,  4 Jan 2024 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704358722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR6ap2Hh5Afb3mxfpkpDyaMovj9vOv//LhJyDYEU988=;
	b=lkMsM0GC566Xb7xycDksgRQALZo1t1rRu8SdedVraTDagTAga8B9uIE5xA6kdsxThl9jax
	8Obh91HbRxf65wgS9BbZMINAMPKDLBkCv+Fy64v1D/m8q7M6Ao+ldsEnOztSLjYSF0XMg7
	fk1oRCeE1JqKWp2RV+p0DwKl6HeMxro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704358722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR6ap2Hh5Afb3mxfpkpDyaMovj9vOv//LhJyDYEU988=;
	b=6iW/ShH9ZZX4prWWBpJAmL2/jzEXloPwkIX+KVoaIF9/kjRJ0TV9jrgPmfiv7z+D2cMcJr
	0DsYqFidkKIur3Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704358722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR6ap2Hh5Afb3mxfpkpDyaMovj9vOv//LhJyDYEU988=;
	b=lkMsM0GC566Xb7xycDksgRQALZo1t1rRu8SdedVraTDagTAga8B9uIE5xA6kdsxThl9jax
	8Obh91HbRxf65wgS9BbZMINAMPKDLBkCv+Fy64v1D/m8q7M6Ao+ldsEnOztSLjYSF0XMg7
	fk1oRCeE1JqKWp2RV+p0DwKl6HeMxro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704358722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rR6ap2Hh5Afb3mxfpkpDyaMovj9vOv//LhJyDYEU988=;
	b=6iW/ShH9ZZX4prWWBpJAmL2/jzEXloPwkIX+KVoaIF9/kjRJ0TV9jrgPmfiv7z+D2cMcJr
	0DsYqFidkKIur3Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D0913722;
	Thu,  4 Jan 2024 08:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id foAVGUJzlmWQVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 08:58:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03A58A07EF; Thu,  4 Jan 2024 09:58:41 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	Jan Kara <jack@suse.cz>,
	Guo Xuenan <guoxuenan@huawei.com>
Subject: [PATCH] readahead: Avoid multiple marked readahead pages
Date: Thu,  4 Jan 2024 09:58:39 +0100
Message-Id: <20240104085839.21029-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3264; i=jack@suse.cz; h=from:subject; bh=+UgtsDahSVLdNC5e29UeWUH6z6ypziO0BPHhaCZTopY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBllnM1WAVFvYILan4IAuUJJoJtF8CQZ2zGZPmQSlyM Qe44qAKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZZZzNQAKCRCcnaoHP2RA2RifB/ 4llYzia2TKkEMBhnoCE6IltG0Vd45gb1DVtDgpwZXx3NvwQeKgB6CZxxu+AmLrJhQQPgZayzWOhopb VT3XU1Hz0pubS2KTrFXAMulQbTpaIcp2ydgXw96eu/6ovvoRQTOCJ3PNqLGqD+oHt5OtRuVF6hdYR7 +g0Duvz0pF9wZVYRbmeSMdhdIixv+MY+Ik0uDV5ICm5X2mI6bOCP+LuoqyWvgD0mgFVrqrKArTAJ68 nW69MusTutbenLQiGoKQ0DS4jX2tA3jRnGVJCK8vYxwC51ddhFJFlWMPJce9oZsUjGfYdLlCgSlXur VmQaGXgAfJN6FQ9BpXY4swLqWU2AmI
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: ****
X-Spamd-Bar: ++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lkMsM0GC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="6iW/ShH9"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 4.99
X-Rspamd-Queue-Id: 75E071F7F6
X-Spam-Flag: NO

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
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3..3032fbdce276 100644
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
-- 
2.35.3


