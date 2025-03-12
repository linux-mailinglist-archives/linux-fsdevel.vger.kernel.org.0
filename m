Return-Path: <linux-fsdevel+bounces-43825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B08A5E1E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64313170154
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD18189913;
	Wed, 12 Mar 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GcWpJ6q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7/kN7EwB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C0Yf4tVX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6jukkAJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019C1CDFD4
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797545; cv=none; b=mz/tX5lmqjXa4PldAU2p9i4OyRY/7vEKjkp0db6XXPzTtCE9geBjpaqMiOG9u7EpXdlzo+dDe3W2rWMOeU0vEQ2WB7b1Eet0U/pTQ+WdItNgsevZFv7RJLgiKKKiIRbojx2bBVKy6nu0+bZ/hdBhsMngOaCOIHvsWUxBPP0uy8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797545; c=relaxed/simple;
	bh=hHSWPkWgBkkw45VQvlFghF9WPlf7mcq+z3gYuFj7zAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efmC+Z6UHbkg2pdWsNcD/ZUC9KeqOXlux5rgFCVOpH/x9L6bleAL5oHWklOEVbNUC9lbZ1PWwI+I/PGUPtNjcst6k/aUZb4FdgiWssm4J4cJQSMi651v8nWteSTMgBHEFZnM6TJFVD0sfSmB0AdCwREo9aJNAzQEPdRaH57Rbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GcWpJ6q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7/kN7EwB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C0Yf4tVX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6jukkAJf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECF541F452;
	Wed, 12 Mar 2025 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741797542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MT868SRc1Rk/LBPHaHsnHdUb3x/9qUWrDJSZBTOPQFc=;
	b=0GcWpJ6qNvL0ZBRYgdoEVQxZuP72DKANi+aNrSW+5QD97NMtNdhHCFoJfFxx4k68O8LNro
	/o+/xV9lGU+amVu7xkZk8cJnfy8v6EGcXS7s2nLeW1P/CtKtsKPGsNbdFMBqT6Sjh+SRm7
	8uuiVY1l2H0nPh+41tKrCWzoGswzWEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741797542;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MT868SRc1Rk/LBPHaHsnHdUb3x/9qUWrDJSZBTOPQFc=;
	b=7/kN7EwBhB90h6wOJvOPUGBeRk+B4VO05YcZ4gEy+gK9MEIUgCy/Q1rDbyBG5WbdvJyYFv
	qjGPriHNF8ITuLCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C0Yf4tVX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6jukkAJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741797541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MT868SRc1Rk/LBPHaHsnHdUb3x/9qUWrDJSZBTOPQFc=;
	b=C0Yf4tVXuNxYyvddKHvy8fjC8qBOSF9QgmAq/hqwtLtRluXO08delR8qEHVfAmVNmC6wPW
	VGfmy/axfJeF9s9ttfuLqnIc6EZAOyXlqBj6H74ikp/gP2OQUulKVb5KBlLcHzmPCF0J9F
	Xt08nHHTNPbTSe+u1VQ15icYr4+2vWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741797541;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MT868SRc1Rk/LBPHaHsnHdUb3x/9qUWrDJSZBTOPQFc=;
	b=6jukkAJf6uuUsZickeDMk9psPWqZGnjcCnKy3DyLZsH+2IDNYgVohNfw3Icwhddxx++F4u
	CIzsS1ZN6zEn98Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAB741377F;
	Wed, 12 Mar 2025 16:39:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UnFfNaW40WcyJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 16:39:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94233A0908; Wed, 12 Mar 2025 17:38:57 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] udf: Fix inode_getblk() return value
Date: Wed, 12 Mar 2025 17:38:47 +0100
Message-ID: <20250312163846.22851-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=jack@suse.cz; h=from:subject; bh=hHSWPkWgBkkw45VQvlFghF9WPlf7mcq+z3gYuFj7zAo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBn0biWsPdx4sFau+lPFzQvAY3kf7iBmJT/dkt4POpe KTfVOLCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ9G4lgAKCRCcnaoHP2RA2Sh3CA DNCVf/NODpaSqC7S1Ca1kkP45OqSapf18MoyO9NX9J+bHvtlXepy1JwoJzthWR6lauQz3JJAH/Rt+M mtU+ne4rr7Bw3ICFfl5X6WGyQKeMS+swgbxjWuO0ETiEjUagGHuyadptdHcXhSnslxoJ5hBtcWjXAK i+bCqxxXecymS8YsGm17CjROPXX79i6pK9mUMSOxYkz6TZFGTmHelHn3ERIeunLTHOegQTaBWSulZ/ YBzwyxIog7YnQe1poCwe5Pu/a9KiFHabTSSuvxjKm1POppBJY7a6+ePkz7qakWwQMvYxT8fsUMvGTZ hIz0OMw8XT0GgCXSEtf7eqZF22+4Q0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECF541F452
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Smatch noticed that inode_getblk() can return 1 on successful mapping of
a block instead of expected 0 after commit b405c1e58b73 ("udf: refactor
udf_next_aext() to handle error"). This could confuse some of the
callers and lead to strange failures (although the one reported by
Smatch in udf_mkdir() is impossible to trigger in practice). Fix the
return value of inode_getblk().

Link: https://lore.kernel.org/all/cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: b405c1e58b73 ("udf: refactor udf_next_aext() to handle error")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 1 +
 1 file changed, 1 insertion(+)

I plan to merge this patch through my tree.

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 70c907fe8af9..4386dd845e40 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -810,6 +810,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
 		}
 		map->oflags = UDF_BLK_MAPPED;
 		map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
+		ret = 0;
 		goto out_free;
 	}
 
-- 
2.43.0


