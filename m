Return-Path: <linux-fsdevel+bounces-48340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77AAADC0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149EF1C20AFC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE2202969;
	Wed,  7 May 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0TtpOiE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQTeTpIf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0TtpOiE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MQTeTpIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB921C6FF5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612035; cv=none; b=AVhOHTidRgzNm2+GXzXCQkUV5Ott5L6uFyQW0iLPb2oKQgEBRFToZpjVpN8XS6pB6ng9g44vbJn7+34kjRgw7cmTJ+mTCGKKzsFXOUZM1dh0h28ydoFeol7nwoFShBQdCqvfZBmryqAmz9fgLt2fcTy5JXyqce9swXCPqtdDBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612035; c=relaxed/simple;
	bh=x6yWmoo6qPjvrZFDG+GfNt4k4ft48EnihqDbNQG/sRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ggBjef6RXfYrzViGj9qREkt+9dPLCF8hWuEYxL2t5e6f02zdQzzLswYvDaGZHGGS3Wim/5KrsfNQc0mf9iJMzpz0vse/i0EX1ZVJzRbzvw0e96MiB7pYP5T5huq2YouVvrXv9kSi4A/0e+QP0g/p/57E3jJXIcpPiQLgdo2JEEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0TtpOiE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQTeTpIf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0TtpOiE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MQTeTpIf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9832118C;
	Wed,  7 May 2025 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746612032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FwFmgELbtw8nVecCPlwuYtq6ecmWR15BEDPQfyNbLfs=;
	b=Z0TtpOiExeSK8uvMJgf90DofLqXv6O0X1hCugvPhDl9CyUCRQ3ShB3KJ2+zhNfeZvqn49f
	PKO6oK89EWkcYMpqR8lxlE9RLNFDLgmJ51B+Yc1OBr83pAha85u1t7BOyEb55cZDef/Qrs
	Xno0KG27PV65Ogvys+Rx7NnKd+g7inI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746612032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FwFmgELbtw8nVecCPlwuYtq6ecmWR15BEDPQfyNbLfs=;
	b=MQTeTpIfNIbXbr/iKzstnMDieizDStceCRPfOxIjZ3PxJLzzrlRaP0BID1htK89yZlaNmC
	shEh5VK65XzZ5QAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Z0TtpOiE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MQTeTpIf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746612032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FwFmgELbtw8nVecCPlwuYtq6ecmWR15BEDPQfyNbLfs=;
	b=Z0TtpOiExeSK8uvMJgf90DofLqXv6O0X1hCugvPhDl9CyUCRQ3ShB3KJ2+zhNfeZvqn49f
	PKO6oK89EWkcYMpqR8lxlE9RLNFDLgmJ51B+Yc1OBr83pAha85u1t7BOyEb55cZDef/Qrs
	Xno0KG27PV65Ogvys+Rx7NnKd+g7inI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746612032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=FwFmgELbtw8nVecCPlwuYtq6ecmWR15BEDPQfyNbLfs=;
	b=MQTeTpIfNIbXbr/iKzstnMDieizDStceCRPfOxIjZ3PxJLzzrlRaP0BID1htK89yZlaNmC
	shEh5VK65XzZ5QAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A56A139D9;
	Wed,  7 May 2025 10:00:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TLxqBkAvG2gdBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 May 2025 10:00:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A43BA09BE; Wed,  7 May 2025 12:00:27 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] udf: Make sure i_lenExtents is uptodate on inode eviction
Date: Wed,  7 May 2025 12:00:17 +0200
Message-ID: <20250507100016.19586-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=jack@suse.cz; h=from:subject; bh=x6yWmoo6qPjvrZFDG+GfNt4k4ft48EnihqDbNQG/sRc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoGy8w2vjrDkNDtqPzj02VjNcYAjCv4Jb4giVzp8mD wNVK4EWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaBsvMAAKCRCcnaoHP2RA2dmSB/ 9JyzYCCk6UJs4Tpt9qRaElodq6U8Ctau9sdTqlr7BaPGQ+lCNXGpRKuk9pB6Q+CaBL6M0jjRJ8Asf8 pWuWFeC4HH2y92rKOREyztNYPEgH1fkFDFY/YoTlDCa2E++R8Gyzf59/iTYuU61doZb5aWe4IrP8Gk aQhwFsrQ7LWuVoIKrBJNAyPJyqybZaw82D4bVETsWdJ0V9sQJkTMwvxIk+0KniFxaBYDtoDsHWYCso v6GhapxDZXsbIWonUKF3+boXBt3/IVQmDzYJw/ACzAZSBv694wy9qdVpuvdLj4gYS0cJd7RuOwwhMj PdsnapKT0GwbK4MzedNRacYUGeLw04
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2A9832118C
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
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[epos.bh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

UDF maintains total length of all extents in i_lenExtents. Generally we
keep extent lengths (and thus i_lenExtents) block aligned because it
makes the file appending logic simpler. However the standard mandates
that the inode size must match the length of all extents and thus we
trim the last extent when closing the file. To catch possible bugs we
also verify that i_lenExtents matches i_size when evicting inode from
memory. Commit b405c1e58b73 ("udf: refactor udf_next_aext() to handle
error") however broke the code updating i_lenExtents and thus
udf_evict_inode() ended up spewing lots of errors about incorrectly
sized extents although the extents were actually sized properly. Fix the
updating of i_lenExtents to silence the errors.

Fixes: b405c1e58b73 ("udf: refactor udf_next_aext() to handle error")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

I plan to merge this fix to my tree.

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 4f33a4a48886..b4071c9cf8c9 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -115,7 +115,7 @@ void udf_truncate_tail_extent(struct inode *inode)
 	}
 	/* This inode entry is in-memory only and thus we don't have to mark
 	 * the inode dirty */
-	if (ret == 0)
+	if (ret >= 0)
 		iinfo->i_lenExtents = inode->i_size;
 	brelse(epos.bh);
 }
-- 
2.43.0


