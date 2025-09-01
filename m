Return-Path: <linux-fsdevel+bounces-59787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE5B3E113
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C065A3A4867
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B948310783;
	Mon,  1 Sep 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I+plZ7C/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8/V7o8t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I+plZ7C/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J8/V7o8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8130ACFA
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724936; cv=none; b=ZpviKqqAhbZEjOnKL4+oaoJa8mlvGVBHWqv3c3AyROwXwNCsK1BalUkVV1uSdhN9vw6c8R4DrU1c5t76rdbc8ppxc+uAFL5orbSS3S5HzHDCvhX9XDjhSoGCnwk4IbuhBznpH8bFJMtMVdP4cLpfgOfc6uj3mUYy4D8FQ9gnP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724936; c=relaxed/simple;
	bh=k7o7Y+ypSzp3fzPsE3Nbit72mtC/H91CKcAZSwdt9Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0hsQC5LhdoiHhqDLT3+RQEKF4u5nX6ndOR9fBkpCZ9zLpR0C1ioAX7uiQeGMbxTKLCB43hRYWGLS6y+1rXDfojWF8tnD3fxVzHKv1IGoM6oM6osL/o+nilLFGd2NYOUn5G4URpKvxk74dD68CjJdnAZsicnnUdxixvaQoe1j2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I+plZ7C/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8/V7o8t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I+plZ7C/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J8/V7o8t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 383BC2116F;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feUOntQoitUe7mPlmKZms9YiTw8kD3bBDWarz0bQ+B8=;
	b=I+plZ7C/i7j6SSn1V9IG+u3eTFEI5fgncxBLiuSBgfdbPBCnbjQakhASgZmVp8xFeOyarH
	llVba0qnmEKgXbsyKEGI5gM5xAqIPvyXpeatWEj8xf7d46rgiu0pi+i+GduQfNcd24JWqG
	dCnvXrVGi8AwAG0SwMa2LF3u3rIbPdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feUOntQoitUe7mPlmKZms9YiTw8kD3bBDWarz0bQ+B8=;
	b=J8/V7o8t0IKnVXn2OPDaVq7LyzGdfd6XpoMhRzdwYsDgYMgSe00do2GgU6OP8MHnrMUlq5
	5ZnHlczdBI4bT9AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="I+plZ7C/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="J8/V7o8t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feUOntQoitUe7mPlmKZms9YiTw8kD3bBDWarz0bQ+B8=;
	b=I+plZ7C/i7j6SSn1V9IG+u3eTFEI5fgncxBLiuSBgfdbPBCnbjQakhASgZmVp8xFeOyarH
	llVba0qnmEKgXbsyKEGI5gM5xAqIPvyXpeatWEj8xf7d46rgiu0pi+i+GduQfNcd24JWqG
	dCnvXrVGi8AwAG0SwMa2LF3u3rIbPdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feUOntQoitUe7mPlmKZms9YiTw8kD3bBDWarz0bQ+B8=;
	b=J8/V7o8t0IKnVXn2OPDaVq7LyzGdfd6XpoMhRzdwYsDgYMgSe00do2GgU6OP8MHnrMUlq5
	5ZnHlczdBI4bT9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CCCD13A31;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kHi+BsV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:51 +0200
Subject: [PATCH 01/12] maple_tree: Fix check_bulk_rebalance() test locks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-1-d6a1166b53f2@suse.cz>
References: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
In-Reply-To: <20250901-maple-sheaves-v1-0-d6a1166b53f2@suse.cz>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Matthew Wilcox <willy@infradead.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
 Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.2
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 383BC2116F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	RCPT_COUNT_TWELVE(0.00)[13];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

The check_bulk_rebalance() test was not correctly locking the tree which
caused issues with the sheaves testing in later patches.  Adding the
missing locks fixed the issue.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 172700fb7784d29f9403003b4484a5ebd7aa316b..159d5307b30a4b37e6cf2941848b8718e1b891d9 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -36465,6 +36465,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
 
 	build_full_tree(mt, 0, 2);
 
+	mas_lock(&mas);
 	/* erase every entry in the tree */
 	do {
 		/* set up bulk store mode */
@@ -36474,6 +36475,7 @@ static inline void check_bulk_rebalance(struct maple_tree *mt)
 	} while (mas_prev(&mas, 0) != NULL);
 
 	mas_destroy(&mas);
+	mas_unlock(&mas);
 }
 
 void farmer_tests(void)

-- 
2.51.0


