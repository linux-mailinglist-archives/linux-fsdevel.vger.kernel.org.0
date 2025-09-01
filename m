Return-Path: <linux-fsdevel+bounces-59795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF8BB3E126
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126401A81CDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2631AF24;
	Mon,  1 Sep 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKTz6Lov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TTbyuHqB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKTz6Lov";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TTbyuHqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AFA31A57D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724968; cv=none; b=HMWmAbgu35x87ZnaPu/M58rTAnoT7AlKd0Q6F0pSpOqlsxCWtRHiVRutwhLpAhYqxZ/NBulz8Fn8HbUsSR7rQAhBHFBxD0erKrIdZ0g4J5sKqNEJP6X9I87i7tyusFqV1AwApfyOF6qS5+5y14m69pxWzp4zKVUCxy/zRIYzaFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724968; c=relaxed/simple;
	bh=cbYZ4uYu2Ew4je+ZVdv6l5r3Tds6HvQmitLofhje3ds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApSRRnT9uh1BFCIqCammLYFgFWvDAbk9+P0xkJiV1CgmMnwQW4xNVhntH0j44Qx1etST/l8sPYqo8efkUzm1I7Mz9Fl+UQYaZRPRws2NjVSUS0c0svQ6PkjISBxDZMQitDKrI8oXNcvbvtYrZaY2L0vY7vHArx7VhsETF8I2U60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKTz6Lov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TTbyuHqB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKTz6Lov; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TTbyuHqB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C29D62117A;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Orc9L8mxDfBM2P4Cd87ufTnmwdvv431SxJfeIHzvdf8=;
	b=zKTz6Lovr5q/xB/OgJ4lFP4VG791nn9WUZ4LQIxwfrfi3FJ5eKFvtpckPEMVHyiJlozJJ0
	NEr7AAQbfKzzLmTRGT91+4KNRXV/iIVPYlKGqBGBgC6Qy0G2bPvAYN06KOI45+UTIBCGjb
	2O2qZkYl4FlRzIW0t0dVuzSaZGCdzYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Orc9L8mxDfBM2P4Cd87ufTnmwdvv431SxJfeIHzvdf8=;
	b=TTbyuHqBOtS89J5z/MDvzGrGoZgGM8awDt34B0yPMv3zPVL5OtplAWc6UYFAmuFtfwS7OV
	jGC0Ri+QQEJul+CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Orc9L8mxDfBM2P4Cd87ufTnmwdvv431SxJfeIHzvdf8=;
	b=zKTz6Lovr5q/xB/OgJ4lFP4VG791nn9WUZ4LQIxwfrfi3FJ5eKFvtpckPEMVHyiJlozJJ0
	NEr7AAQbfKzzLmTRGT91+4KNRXV/iIVPYlKGqBGBgC6Qy0G2bPvAYN06KOI45+UTIBCGjb
	2O2qZkYl4FlRzIW0t0dVuzSaZGCdzYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Orc9L8mxDfBM2P4Cd87ufTnmwdvv431SxJfeIHzvdf8=;
	b=TTbyuHqBOtS89J5z/MDvzGrGoZgGM8awDt34B0yPMv3zPVL5OtplAWc6UYFAmuFtfwS7OV
	jGC0Ri+QQEJul+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACCE113A7C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JzeKcV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:58 +0200
Subject: [PATCH 08/12] maple_tree: Replace mt_free_one() with kfree()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-8-d6a1166b53f2@suse.cz>
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
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLzz977skxseo48jckwk35q6sc)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

From: Pedro Falcato <pfalcato@suse.de>

kfree() is a little shorter and works with kmem_cache_alloc'd pointers
too. Also lets us remove one more helper.

Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d77e82362f03905040ac61630f92fe9af1e59f98..b361b484cfcaacd99472dd4c2b8de9260b307425 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -181,11 +181,6 @@ static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
 	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
 }
 
-static inline void mt_free_one(struct maple_node *node)
-{
-	kmem_cache_free(maple_node_cache, node);
-}
-
 static inline void mt_free_bulk(size_t size, void __rcu **nodes)
 {
 	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
@@ -5274,7 +5269,7 @@ static void mt_free_walk(struct rcu_head *head)
 	mt_free_bulk(node->slot_len, slots);
 
 free_leaf:
-	mt_free_one(node);
+	kfree(node);
 }
 
 static inline void __rcu **mte_destroy_descend(struct maple_enode **enode,
@@ -5358,7 +5353,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 
 free_leaf:
 	if (free)
-		mt_free_one(node);
+		kfree(node);
 	else
 		mt_clear_meta(mt, node, node->type);
 }
@@ -5585,7 +5580,7 @@ void mas_destroy(struct ma_state *mas)
 			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
 			total -= count;
 		}
-		mt_free_one(ma_mnode_ptr(node));
+		kfree(ma_mnode_ptr(node));
 		total--;
 	}
 
@@ -6635,7 +6630,7 @@ static void mas_dup_free(struct ma_state *mas)
 	}
 
 	node = mte_to_node(mas->node);
-	mt_free_one(node);
+	kfree(node);
 }
 
 /*

-- 
2.51.0


