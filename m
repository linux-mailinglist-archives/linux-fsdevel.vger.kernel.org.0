Return-Path: <linux-fsdevel+bounces-23453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821DE92C7C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 03:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CA5281BA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719CBB647;
	Wed, 10 Jul 2024 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VcmbvJu3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VcmbvJu3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83A1B86D9;
	Wed, 10 Jul 2024 01:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720573700; cv=none; b=CatPIcDAFF/veRUFLPjM2YAKpr1vSWDKlPHRPUGNApw6IXvHBuXsBy/Nr9VnSYI7IK59JdHXb7kPnGrnIsGIork/10O3rVdjtgstltCYccYv0XGWQM/kPrjET7WNu+qHo4kpvks13rpp8a90+l8KageQSOK5hdqwQ7kQc6EAIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720573700; c=relaxed/simple;
	bh=fOHj/E803+ozJmuoaYvHU7b94m9dP4kr+l/9ANfHwS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=igqPJ/YW+G6qVkC4sI/ZZI5mseDKg3rVVrbNtZfUyLqG0ahaUchSiZqAIa1yF/eA82BIxKwU0kYEeq++/SYyYXwZMOBHNwBSbtcLG3C0qS3nTIhG8s2z+WeGHhxWe27BS9IF0PTQUCnHG5as4XRy9xM6eSGfs7QvFk/peezHa7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VcmbvJu3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VcmbvJu3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0958E1F7D1;
	Wed, 10 Jul 2024 01:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x37no3oT/qmyGyMegZBwccgMqLWt0TBXMu5cGm2nAY=;
	b=VcmbvJu3ZP1+HjwUPCS9Zaq+dKb3jbJkfFpuaEDcQhLVp5fd+jK3EfNFsalfDOthb1FaYd
	z8nu6IxiRPckks0huzFMKShKobStOv9M8R3PfX9OUuBh05Fw52xT+DLzEWzyp8QWO4K6j5
	Igwzvt4m0CReJY6XfzYUwXpdGwy/kRs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VcmbvJu3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1720573697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0x37no3oT/qmyGyMegZBwccgMqLWt0TBXMu5cGm2nAY=;
	b=VcmbvJu3ZP1+HjwUPCS9Zaq+dKb3jbJkfFpuaEDcQhLVp5fd+jK3EfNFsalfDOthb1FaYd
	z8nu6IxiRPckks0huzFMKShKobStOv9M8R3PfX9OUuBh05Fw52xT+DLzEWzyp8QWO4K6j5
	Igwzvt4m0CReJY6XfzYUwXpdGwy/kRs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 932DF1369A;
	Wed, 10 Jul 2024 01:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NQZE//ejWaYTQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 10 Jul 2024 01:08:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] mm: make lru_gen_eviction() to handle folios without memcg info
Date: Wed, 10 Jul 2024 10:37:46 +0930
Message-ID: <e1036b9cc8928be9a7dec150ab3a0317bd7180cf.1720572937.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720572937.git.wqu@suse.com>
References: <cover.1720572937.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0958E1F7D1
X-Spam-Score: -2.99
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.99 / 50.00];
	BAYES_HAM(-1.98)[94.94%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Currently lru_gen_eviction() fully relies on folio_memcg() to grab the
memcg.
It's fine for now as only file folios can enter workingset_eviction().

But for the incoming change which will skip memcg for certain address
space, we will hit folios without an memcg info in the future.

In that case, mem_cgroup_id() would lead to NULL pointer dereference.
Enhance lru_gen_eviction() to handle such situatioin by calling
lruvec_memcg() instead of using folio_memcg() directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mm/workingset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index c22adb93622a..449042d10803 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -253,7 +253,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	hist = lru_hist_from_seq(min_seq);
 	atomic_long_add(delta, &lrugen->evicted[hist][type][tier]);
 
-	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
+	return pack_shadow(mem_cgroup_id(lruvec_memcg(lruvec)), pgdat, token, refs);
 }
 
 /*
-- 
2.45.2


