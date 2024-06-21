Return-Path: <linux-fsdevel+bounces-22123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC98912837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AED6B2ABAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B7147A66;
	Fri, 21 Jun 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbbAO5Xa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5oixie8v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DTozfRCy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CaGeatQv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5183612D;
	Fri, 21 Jun 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980971; cv=none; b=mNpqSvY/unM9I1c16cQvlMEyXLKqZKWkyLkOM4vU6xTsHtJL4rQkUPBDFn8XmEcd8q0vzFcTHZoX8bw4QV72VsK4js8lYU37IXf2GYQfyGHIUzUnlhTEwR85jcl/Y3KFt7RKwSWyhDFMmGLNgi1PYBI3UNN+Y7POmpySzUIVTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980971; c=relaxed/simple;
	bh=2B7RZlPuQbbusvMgZX8uhs4dt/JsTyyvm7VxclEoEVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CFgTu8rYm3GOlKaxKqMfBMnerOcRquj/qMonNpqwGltZJ/5NMomQilhVOvwF2OnfZA1uOWFQU4EY7d8UgyGVuGDmxq05vdoYAY+YgA0uRVqPSMHDKI79KhS/kaHrlQiasGzdrJAK0lM3pFfwYnVfBxaFT/9crBt0B9FM1tuL+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbbAO5Xa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5oixie8v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DTozfRCy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CaGeatQv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD67F1FB7C;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wnwoeCLk06XNZEIaVL4PQiNWLWxYtzsDlUjzQ3EeoM=;
	b=cbbAO5XaEHF7u0mLA2KPA47lzCS95DbQaTsnuD8lbv2+Z94MwczJOvA87iVYip/wgDLG6o
	KQwaosXauIhyuxd8ohf5ltR56RCtqT6dk3m4YNdBdORoLhOExewds74cW4/oLIutqO0ikp
	ZXjfBbKVbw/8OS646aINCWl+TiKSSdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wnwoeCLk06XNZEIaVL4PQiNWLWxYtzsDlUjzQ3EeoM=;
	b=5oixie8venznp0uwV6gpQQ5paj5YUMyBzsiePRsIK+wKpGmYnszetqllwNqWCIjFuIfEVc
	CXm9diCewdResMAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DTozfRCy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CaGeatQv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wnwoeCLk06XNZEIaVL4PQiNWLWxYtzsDlUjzQ3EeoM=;
	b=DTozfRCyrKgQxeTtepsCLTVG7kti/QgRiTpJAiQullAIv+Vy/AEiwtlNudq5dcXJx8Geuj
	JFlzIQxlM4tcNf/1PwdbadJ15Q1mBAoRl55Z5LNqXkR5shr2X0PoytgVtC6dLvEbtWi5c2
	i54f80HRESrmdnQjOwNDNFLZv0TZmJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wnwoeCLk06XNZEIaVL4PQiNWLWxYtzsDlUjzQ3EeoM=;
	b=CaGeatQvGygW5icnQVffR8ryOXvI4gRElN8S4ShRO3ujd/K0TIDWz+oH2FX6Yb+vTJMHGp
	PqDP6DN5ULcDA4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B26D313ACE;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJiGK2aRdWY+LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 14:42:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A43BA05A4; Fri, 21 Jun 2024 16:42:46 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Revert "mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again"
Date: Fri, 21 Jun 2024 16:42:37 +0200
Message-Id: <20240621144246.11148-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621144017.30993-1-jack@suse.cz>
References: <20240621144017.30993-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1467; i=jack@suse.cz; h=from:subject; bh=2B7RZlPuQbbusvMgZX8uhs4dt/JsTyyvm7VxclEoEVQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmdZFdpqQS8jQrtWt2zz2j3MNHIilokZb4FhjSsLqt 3LDvNDWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnWRXQAKCRCcnaoHP2RA2ZSgCA CjrEZqhSvAmuxHUHRlk7Pq/3CB445Z9/xxTjMDdbBopDA4vn3/5IzgCpwl7zREo+4cBHx4qNT014lY rtPaAp62RC5ECu5ZztXJDoJupSplX3KQ4WbjGMrGkfVCfZ6PnyI86iAi/XTUrof8siWiVJpcts/UMz 2K3O5rvjCv0bGnJvOS6IcpLXwr1XIS4uifkh/ufmq/+/bpjQdOzTX6iZGjAC7GNdgwCFFQFVH5wDZI c74Mk1yWNlt7OrXaVmTqz+TPAXKZMObIMwug3/AHp6rsw/wEAiWXL6bTHig4SeAaqFo8qI9vGgFvlv siwdOcqFtpJHbYhVjCWE7YTBdTIPDe
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD67F1FB7C
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This reverts commit 9319b647902cbd5cc884ac08a8a6d54ce111fc78.

The commit is broken in several ways. Firstly, the removed (u64) cast
from the multiplication will introduce a multiplication overflow on
32-bit archs if wb_thresh * bg_thresh >= 1<<32 (which is actually common
- the default settings with 4GB of RAM will trigger this). Secondly, the
  div64_u64() is unnecessarily expensive on 32-bit archs. We have
div64_ul() in case we want to be safe & cheap. Thirdly, if dirty
thresholds are larger than 1<<32 pages, then dirty balancing is
going to blow up in many other spectacular ways anyway so trying to fix
one possible overflow is just moot.

CC: stable@vger.kernel.org
Fixes: 9319b647902c ("mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 12c9297ed4a7..2573e2d504af 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1660,7 +1660,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc, dtc->thresh);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
-- 
2.35.3


