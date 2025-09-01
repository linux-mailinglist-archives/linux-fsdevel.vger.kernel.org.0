Return-Path: <linux-fsdevel+bounces-59788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E66B8B3E117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C141A818C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955D830FC2A;
	Mon,  1 Sep 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXEC2JSP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tLWW5Zdr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JXEC2JSP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tLWW5Zdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE73112DF
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724943; cv=none; b=N0JunEI7UN5ISACRR3FeGKsYasc+VrDuzp+DC4yvmlZ39Yqx8EyjDrACi8dGF7c3GOzpxf3NUcnQkj0jyfxBifVIKwr+UQsTybMh9QrVzYF91i9JLhuyv+T25LceRniyYcP3635kjMftjwJpPafGLFZu3eJto2IVCteYusg3Huc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724943; c=relaxed/simple;
	bh=UlGxvACdv155XrFFrWk0ecsws481oUU4TIOFXFk1vIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUZFRdSe7HIpuwBrW82I0C5Q/eXcYG6fFMGdYBH4mAhxv7S4Nyhj6zzAUgE6dBloLWkXE1gg3qeFASrwz1qLoH6ZwbiN5Opu+dudFNYLSdE66bN1t4x0cvyIgLgtU+v7kTs+WGbo6wzNn1SbTMwDPZySs2ZOiuYc+K4eVEfn47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXEC2JSP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tLWW5Zdr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JXEC2JSP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tLWW5Zdr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6468321170;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KRBIhNrsFaoYAcvZ0YP3W0XTTeCHuYd9glX8HrySn4=;
	b=JXEC2JSPbAhghivVpT57oMvEpSklUDeXYRyjnFw0yUL2Adv/0jqVqXd2LWyEmhUOcI4tih
	ZMQbFVXtHX0pF+8GRqc3eqZxtij3l+T7pVjwLQz/NMQHpjXgV+cCY03UrogQ1HnMuCbGT5
	/5h+ITU1KJDdjzwLJBK7VPpbCCmOYSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KRBIhNrsFaoYAcvZ0YP3W0XTTeCHuYd9glX8HrySn4=;
	b=tLWW5ZdrYhhfSA1+rqSGfXbeA1LfUrViBljw5vxy5N1FPEKGTU2x0WFIZNtd1pwF6R0Vti
	I5BJONZ3T2iTqDBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JXEC2JSP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tLWW5Zdr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KRBIhNrsFaoYAcvZ0YP3W0XTTeCHuYd9glX8HrySn4=;
	b=JXEC2JSPbAhghivVpT57oMvEpSklUDeXYRyjnFw0yUL2Adv/0jqVqXd2LWyEmhUOcI4tih
	ZMQbFVXtHX0pF+8GRqc3eqZxtij3l+T7pVjwLQz/NMQHpjXgV+cCY03UrogQ1HnMuCbGT5
	/5h+ITU1KJDdjzwLJBK7VPpbCCmOYSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0KRBIhNrsFaoYAcvZ0YP3W0XTTeCHuYd9glX8HrySn4=;
	b=tLWW5ZdrYhhfSA1+rqSGfXbeA1LfUrViBljw5vxy5N1FPEKGTU2x0WFIZNtd1pwF6R0Vti
	I5BJONZ3T2iTqDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A2C013A7C;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMHJEcV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:53 +0200
Subject: [PATCH 03/12] maple_tree: use percpu sheaves for maple_node_cache
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-3-d6a1166b53f2@suse.cz>
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
X-Rspamd-Queue-Id: 6468321170
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

Setup the maple_node_cache with percpu sheaves of size 32 to hopefully
improve its performance. Note this will not immediately take advantage
of sheaf batching of kfree_rcu() operations due to the maple tree using
call_rcu with custom callbacks. The followup changes to maple tree will
change that and also make use of the prefilled sheaves functionality.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 lib/maple_tree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b4ee2d29d7a962ca374467d0533185f2db3d35ff..a0db6bdc63793b8bbd544e246391d99e880dede3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6302,9 +6302,14 @@ bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 
 void __init maple_tree_init(void)
 {
+	struct kmem_cache_args args = {
+		.align  = sizeof(struct maple_node),
+		.sheaf_capacity = 32,
+	};
+
 	maple_node_cache = kmem_cache_create("maple_node",
-			sizeof(struct maple_node), sizeof(struct maple_node),
-			SLAB_PANIC, NULL);
+			sizeof(struct maple_node), &args,
+			SLAB_PANIC);
 }
 
 /**

-- 
2.51.0


