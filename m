Return-Path: <linux-fsdevel+bounces-59790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EEEB3E11B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA53D3A59C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB23128D5;
	Mon,  1 Sep 2025 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AaRMkOJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5uB/8aw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AaRMkOJh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F5uB/8aw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE83112C6
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724949; cv=none; b=kTCl93XrEzigq10g2Ce6FSynGYGWTE4GmXI8QJUpUfe21VyDyKpK8t4viOZQ2BHhOI4b2c7Ikqe2xYpcKYzuauomMvBHcQ1GjS+lxlgp46gzYCVwKBB1RMOxntbuFeG14WbmC7U7EhRU22g6WstqV55GlrHOVF4DdA+N0TNAfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724949; c=relaxed/simple;
	bh=atq+CHH4zhDPyoWu6Y++rUXCbmBzjqspFCyejAZKp4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmxMvqbUmiENPOXThxw+9oYOhmPryF0Yv3M4/F6eIdEyq33rNSxAYeA89r6UXDEIRQme0+oT93dxNiUttFS6U/l739Shw6vDdZb5t/snPsG2EQopa5tQ81g+EnBkGT951llqSyISWs2ZQlGuTLdFrTRdJ/iySYM/U+7DCQqmtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AaRMkOJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5uB/8aw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AaRMkOJh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F5uB/8aw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82CC821172;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJhUfBeZeLxh7W8CevHKP2oQFWa3IdvgSf/9qDFU160=;
	b=AaRMkOJhu2G5Ls8tX/3MWoxgZt1PtPRcguBY8N//JqYZ4b5ssCrQ7CkrPGE8M2fnw3cYIE
	AcogPqeQ9eZ93prsKeyYgkmeNJ0ObBj4A401051acjh2Be5ftir19Mas7UUVzUxkrBW5zY
	EGA6Uc7Lu4NsmcTI7+JnpTP/EhpfR10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJhUfBeZeLxh7W8CevHKP2oQFWa3IdvgSf/9qDFU160=;
	b=F5uB/8aw/r1QgzBsKcDoocYUNgdj+8Tn+5/lLVpwTQ7Cz4iLT3gcTLOiW25VF5wn8P+QFp
	9Ta5H7PcmlpRDZAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AaRMkOJh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="F5uB/8aw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756724933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJhUfBeZeLxh7W8CevHKP2oQFWa3IdvgSf/9qDFU160=;
	b=AaRMkOJhu2G5Ls8tX/3MWoxgZt1PtPRcguBY8N//JqYZ4b5ssCrQ7CkrPGE8M2fnw3cYIE
	AcogPqeQ9eZ93prsKeyYgkmeNJ0ObBj4A401051acjh2Be5ftir19Mas7UUVzUxkrBW5zY
	EGA6Uc7Lu4NsmcTI7+JnpTP/EhpfR10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756724933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJhUfBeZeLxh7W8CevHKP2oQFWa3IdvgSf/9qDFU160=;
	b=F5uB/8aw/r1QgzBsKcDoocYUNgdj+8Tn+5/lLVpwTQ7Cz4iLT3gcTLOiW25VF5wn8P+QFp
	9Ta5H7PcmlpRDZAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DDDC13ABA;
	Mon,  1 Sep 2025 11:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOeZFsV+tWjtDgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 01 Sep 2025 11:08:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 01 Sep 2025 13:08:54 +0200
Subject: [PATCH 04/12] tools/testing: include maple-shared.h in maple.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-maple-sheaves-v1-4-d6a1166b53f2@suse.cz>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 82CC821172
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

There's code duplication and we are about to add more functionality in
maple-shared.h that we will need in userspace maple test to be
available.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/radix-tree/maple.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index 159d5307b30a4b37e6cf2941848b8718e1b891d9..18db97a916f039bf72046c3ec3e7faffaeb5b755 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -8,14 +8,6 @@
  * difficult to handle in kernel tests.
  */
 
-#define CONFIG_DEBUG_MAPLE_TREE
-#define CONFIG_MAPLE_SEARCH
-#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
-#include "test.h"
-#include <stdlib.h>
-#include <time.h>
-#include <linux/init.h>
-
 #define module_init(x)
 #define module_exit(x)
 #define MODULE_AUTHOR(x)
@@ -23,6 +15,9 @@
 #define MODULE_LICENSE(x)
 #define dump_stack()	assert(0)
 
+#include "maple-shared.h"
+#include "test.h"
+
 #include "../../../lib/maple_tree.c"
 #include "../../../lib/test_maple_tree.c"
 

-- 
2.51.0


