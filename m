Return-Path: <linux-fsdevel+bounces-59786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71562B3E112
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1A23A3277
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F2310654;
	Mon,  1 Sep 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVn5rTNk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9nykotc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qVn5rTNk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T9nykotc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169352580DE
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724936; cv=none; b=rYTQglO7AtlTgEVMH43wor0xEUJnoyLbg0KScVDpbEEVUxgo2Chv6ORO1rjWZ4ujOAnQBIDGnapN4qrsyotbOcyUVfTh79xFXoPrBk2FCkG4d4JJmw9XeoqzJVVhRD/hUPlcu3B99oZZ8prEshEnGwG4Aglc6wbEGVFXlwBfDfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724936; c=relaxed/simple;
	bh=S+gCwl+5TEBCoo4Zd7PHv0BDHcrf/79qdqbMGOQM5/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+YOPPVspNjr3v7/jrOtLcyDXFeZuqGR+hbJ9YWpRuvf8olUYDD8o4sG5HvH6Sm68gPIrGTie9vRCxk5p+ZAQtP/JyVQo/Pdx7A6+KKo7sHNO82JuRp5N4XA6i4BezTL6jx4YFJ/IPzsbHVWaMNnPOPVox7fzfGy3JffKB9tD3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVn5rTNk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9nykotc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qVn5rTNk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T9nykotc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED341F387;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUqhGh4rTv9B9oitYXxgj0bnq1HlZpXe0FlsUWYvcU4=;
	b=qVn5rTNknZMzGbK67J36RUzRhlsiDWA+viXwVqKrOfKtaTI4zicyHaMAxlgrUQ4uCaxWfa
	Tbb4yNV54DUA4hzpJI/I08NC5DFLzTBnfewN581Pjw/CLKOP0PNyV53H+iez3RDr2jXZVR
	ZRARQzWleXgkhobw/q4He+ndd76vesw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUqhGh4rTv9B9oitYXxgj0bnq1HlZpXe0FlsUWYvcU4=;
	b=T9nykotcgPIf25AlYjhV9Kn46TVsFEW0RtEO+rGJtxgVIz4gsap6jaPtj9ioDJDULv40+z
	Bp1pmk+uCsdhj2Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qVn5rTNk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T9nykotc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUqhGh4rTv9B9oitYXxgj0bnq1HlZpXe0FlsUWYvcU4=;
	b=qVn5rTNknZMzGbK67J36RUzRhlsiDWA+viXwVqKrOfKtaTI4zicyHaMAxlgrUQ4uCaxWfa
	Tbb4yNV54DUA4hzpJI/I08NC5DFLzTBnfewN581Pjw/CLKOP0PNyV53H+iez3RDr2jXZVR
	ZRARQzWleXgkhobw/q4He+ndd76vesw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUqhGh4rTv9B9oitYXxgj0bnq1HlZpXe0FlsUWYvcU4=;
	b=T9nykotcgPIf25AlYjhV9Kn46TVsFEW0RtEO+rGJtxgVIz4gsap6jaPtj9ioDJDULv40+z
	Bp1pmk+uCsdhj2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04BC01378C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l4bYAMV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 00/12] maple_tree: slub sheaves conversion
Date: Mon, 01 Sep 2025 13:08:50 +0200
Message-Id: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJ+tWgC/x3MQQqAIBBG4avErBO0KLCrRAut3xooCwcikO6et
 PwW72USJIbQUGVKuFn4jAWmrmjeXFyheCmmRjedttqow107lGxwN0T1rbdY5t76EKg0V0Lg5/+
 N0/t+V5n/sF8AAAA=
X-Change-ID: 20250901-maple-sheaves-63b9edc69bff
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL5jz3zk9nm44ai14dcppf93zb)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 1ED341F387
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

The previous version of this work was part of the patchset that
introduces slub sheaves, but for practical purposes was split out in v6
[1] while Liam did some further fixups and cleanups to the maple tree
and associated testing implementation, incorporating also patches from
Pedro [2] and then provided to me his branch [3] to include it. It
relies on [1] in the slab/for-next tree so the intent is to include this
in slab/for-next as well. More precisely speaking, patches 2 and 3 will
replace the last two patches of [1].

[1] https://lore.kernel.org/all/20250827-slub-percpu-caches-v6-0-f0f775a3f73f@suse.cz/
[2] https://lore.kernel.org/all/20250812162124.59417-1-pfalcato@suse.de/
[2] https://git.infradead.org/?p=users/jedix/linux-maple.git;a=shortlog;h=refs/heads/sheaves-v6r2_fixes

git version:
https://git.kernel.org/vbabka/l/maple-sheaves-v1

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Liam R. Howlett (8):
      maple_tree: Fix check_bulk_rebalance() test locks
      tools: Add testing support for changes to slab for sheaves
      tools/testing/vma: Implement vm_refcnt reset
      testing/radix-tree/maple: Hack around kfree_rcu not existing
      tools: Add sheaf to slab testing
      maple_tree: Sheaf conversion and testing
      maple_tree: Add single node allocation support to maple state
      maple_tree: Convert forking to use the sheaf interface

Pedro Falcato (2):
      maple_tree: Use kfree_rcu in ma_free_rcu
      maple_tree: Replace mt_free_one() with kfree()

Vlastimil Babka (2):
      maple_tree: use percpu sheaves for maple_node_cache
      tools/testing: include maple-shared.h in maple.c

 include/linux/maple_tree.h          |   6 +-
 lib/maple_tree.c                    | 399 +++++++++--------------------
 lib/test_maple_tree.c               |   8 +
 tools/include/linux/slab.h          | 165 +++++++++++-
 tools/testing/radix-tree/maple.c    | 483 +++---------------------------------
 tools/testing/shared/linux.c        | 120 +++++++--
 tools/testing/shared/maple-shared.h |  11 +
 tools/testing/shared/maple-shim.c   |   7 +
 tools/testing/vma/vma_internal.h    |  98 +-------
 9 files changed, 439 insertions(+), 858 deletions(-)
---
base-commit: 2a2cada7250179353220bea9548acd7e7ed96e48
change-id: 20250901-maple-sheaves-63b9edc69bff

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>


