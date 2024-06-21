Return-Path: <linux-fsdevel+bounces-22122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B86912834
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332471F21929
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094E839856;
	Fri, 21 Jun 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CGgGfbbP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7n7W9uL4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3MwmW0kZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4UclTcqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB358328DB
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jun 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980971; cv=none; b=GlvaQAPJNnJt09Br7ShyqZz6HlQx2ImdyrYJivmbpiZy2+DzNnv+CcQqpKwbtvIpUidSBMfydlZp+Y84PHJWPXKQZpoHLrt1QMMaO8cP7gC+nXWRsuJdFbLfRIP7Ikh7VcXAtKJLdoBBUCmeBtA14rn0l3lZmK/opz6sFZkXGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980971; c=relaxed/simple;
	bh=PGQ9eidZxl5PPmsdmaSvP6Cbz/TS6SEJbHpwpDbqIXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibHv2+eNgfTv1NTKdw+nRvvRX76wfqkFL6Q4T+Qk9S15NguGdkVrM8zvT3Gyv91B0keuEnzZIgC0forUM193oic/mdabQSA2CBBMoYm+bUNbyN/GwuxnP8jMlOZwrKXVK43thD9+GJlMfeCuNjHwk9r8HGVmWD2YcjnrFbwlNqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CGgGfbbP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7n7W9uL4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3MwmW0kZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4UclTcqg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAEC621B22;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqyr0RnJbJELV3zUJDpwC0MLM3pwEIlgqTYPmWwusLQ=;
	b=CGgGfbbPChCd8y/7GSSaz7DZIQCFRDc/9GlzIfI2xEzAkoVYUvUXeB0A9ZZ4GhlFkmLxwt
	azwcxI6OUQMz6UOZaNsDesNsEAb4tf66O98AnAEhB6EjzhrE3TwNyJnf/UULTx8j8JtL6P
	3xK/WuSPVsG7ZQrdgKSxVBn036KwLNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqyr0RnJbJELV3zUJDpwC0MLM3pwEIlgqTYPmWwusLQ=;
	b=7n7W9uL4eF+l3Nr33q++tRL692RiB9kasHXLuo1PymJEWF2LnCFtJnHeLD703ZLlS7egsE
	z/mkViTI+7LBusDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718980966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqyr0RnJbJELV3zUJDpwC0MLM3pwEIlgqTYPmWwusLQ=;
	b=3MwmW0kZcf3W8Pda8g0IoaPQZr0uEX/Lr/SlgxheU9YfeIhUYTRPuO7t/PLkerWMSLRBpD
	UaKzs5mPJU+gV/nU3xAdDTfmMVmlviZY+Itutjfjbw5JEY0vfnsbAWZrM1c2fit2sFYfjS
	v9FXvyqkijagWJgfgsqGYPh3q/KRQY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718980966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqyr0RnJbJELV3zUJDpwC0MLM3pwEIlgqTYPmWwusLQ=;
	b=4UclTcqgE3nwYJ4MQieFWoVYYl6y+aKtT2DdnO0PnaOBmx8HxpEnIliGuludmCiOxYTpMb
	9IF3T0KDC4OrF4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAC5713ABD;
	Fri, 21 Jun 2024 14:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RoBlKWaRdWY1LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 14:42:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 505B6A088C; Fri, 21 Jun 2024 16:42:46 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	Zach O'Keefe <zokeefe@google.com>
Subject: [PATCH 2/2] mm: Avoid overflows in dirty throttling logic
Date: Fri, 21 Jun 2024 16:42:38 +0200
Message-Id: <20240621144246.11148-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621144017.30993-1-jack@suse.cz>
References: <20240621144017.30993-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=jack@suse.cz; h=from:subject; bh=PGQ9eidZxl5PPmsdmaSvP6Cbz/TS6SEJbHpwpDbqIXg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmdZFe1cqxh1W5xSHP5qGjzvsdKdp2/ceQRROd4IDx Z1STypOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnWRXgAKCRCcnaoHP2RA2bh6B/ 4o3zS6c3ozgcIrmDXXjjNGDIosNSTgXsSgX4g9ID690j3es5QwCpDRSmzjA1SffZzkmIPLnQEFUfT6 /toeZ8EzycoWui6oDT9S5dS1K/6xi8fsuW78oshqhRJ09rZzpaoudk4WZmvFitgu3JzNktKpZThGTm eRM3h11/VL6VNyK0DQia1x6YU+cPq1CvJwrZfkaRA73wnN8nSuZf7Wiwwkxyr45LJzIFg4Ssefd2zS jaTOQjWKUWfpZiANeTf4ANaOEu0ZvXhiLOpp1fOUeefDqhkg9vZHbfsw9unh4PEeRdNrAKvuT3FJa/ jogccdAbXvip097M0iREZpEqvawD/h
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The dirty throttling logic is interspersed with assumptions that dirty
limits in PAGE_SIZE units fit into 32-bit (so that various
multiplications fit into 64-bits). If limits end up being larger, we
will hit overflows, possible divisions by 0 etc. Fix these problems by
never allowing so large dirty limits as they have dubious practical
value anyway. For dirty_bytes / dirty_background_bytes interfaces we can
just refuse to set so large limits. For dirty_ratio /
dirty_background_ratio it isn't so simple as the dirty limit is computed
from the amount of available memory which can change due to memory
hotplug etc. So when converting dirty limits from ratios to numbers of
pages, we just don't allow the result to exceed UINT_MAX.

Reported-by: Zach O'Keefe <zokeefe@google.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/page-writeback.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2573e2d504af..8a1c92090129 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -415,13 +415,20 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	else
 		bg_thresh = (bg_ratio * available_memory) / PAGE_SIZE;
 
-	if (bg_thresh >= thresh)
-		bg_thresh = thresh / 2;
 	tsk = current;
 	if (rt_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	if (thresh > UINT_MAX)
+		thresh = UINT_MAX;
+	/* This makes sure bg_thresh is within 32-bits as well */
+	if (bg_thresh >= thresh)
+		bg_thresh = thresh / 2;
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
 
@@ -471,7 +478,11 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	if (rt_task(tsk))
 		dirty += dirty / 4;
 
-	return dirty;
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	return min_t(unsigned long, dirty, UINT_MAX);
 }
 
 /**
@@ -508,10 +519,17 @@ static int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
+	unsigned long old_bytes = dirty_background_bytes;
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
+	if (ret == 0 && write) {
+		if (DIV_ROUND_UP(dirty_background_bytes, PAGE_SIZE) >
+								UINT_MAX) {
+			dirty_background_bytes = old_bytes;
+			return -ERANGE;
+		}
 		dirty_background_ratio = 0;
+	}
 	return ret;
 }
 
@@ -537,6 +555,10 @@ static int dirty_bytes_handler(struct ctl_table *table, int write,
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_bytes != old_bytes) {
+		if (DIV_ROUND_UP(vm_dirty_bytes, PAGE_SIZE) > UINT_MAX) {
+			vm_dirty_bytes = old_bytes;
+			return -ERANGE;
+		}
 		writeback_set_ratelimit();
 		vm_dirty_ratio = 0;
 	}
-- 
2.35.3


