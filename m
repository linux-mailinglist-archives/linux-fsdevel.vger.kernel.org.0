Return-Path: <linux-fsdevel+bounces-56323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E7B15E29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 12:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05E13BDEE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EEE2820C6;
	Wed, 30 Jul 2025 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ub84NMA4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qaala2Jg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E7ptiLY2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gEoL0hF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D927A92F
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753871349; cv=none; b=kAkSmlmFHaAXeEnFaUqrWs+32tMQTSiTV+rwHp75VNAu9bjm0cMa8+GbaqQC79eTgPczlsa2wISbfo5LPd3VuGpMoCIHA6aW0u8YO2KFCpWjCqVyGzqpM8CgMAyaV2xIo9e+w0xCtFmaQ5uW/2anfYIAXPTbd0+ilnLPrlo+hdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753871349; c=relaxed/simple;
	bh=lO7YkAhoMX+qzxXhKtt6Kzmf4wUtQ/sEypG2OHMHblU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnB1GG6fT30hIk/zyCPjFoi2P3RcPJgdyKeXHt+rMYsv9GfK5MNzEwPV65a3uw+MYjkHXbqfRtl/6OOf2W75Q9wGtgFeMXzlk/I5OiJxqWdZR4wSYISDyZqsEYI2pAd/cJfliCk2ouy7Kn9DZdcHgdLLSjPTbIhOERtCkT0NioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ub84NMA4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qaala2Jg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E7ptiLY2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gEoL0hF5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF3AD21246;
	Wed, 30 Jul 2025 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753871340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sbC6Uq5aYunWTU8USVVOdmjcJNM1Dt2n1UGLWwQRu+8=;
	b=ub84NMA47RseCfjunnnzV3zEfNtor+YWEe+5S145sG5x5HYl5BSql3N9JlMNF8T4rAmeWt
	j2sVzdr5sajXe/MtlEtloWujysrXpPtVVzNZxLbQ9bb8veUFx6IRvuH+MbUL+xhqd6ygSN
	+ALiSyCZnYFC3xIp5XzJCbnU7cIEhFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753871340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sbC6Uq5aYunWTU8USVVOdmjcJNM1Dt2n1UGLWwQRu+8=;
	b=Qaala2Jg8yjaKT5mp/KNtfn3fA/d09lA7WElo6vWN7wurTieSXrVmELQNagpixSgzeiLPE
	sfg8Ma5WofD1SZDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753871339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sbC6Uq5aYunWTU8USVVOdmjcJNM1Dt2n1UGLWwQRu+8=;
	b=E7ptiLY2u8hMlo/1derQYVC1+Ul9LerWDx5sX+rEoaj2rLDGVBC1OcmHBytHryRwffmRyu
	lqXUpAZYfBHPK7mQKy86uHzBX/MWA1ElAHPJ889PURRUcL/gYa1b+Z9jehl2nzBG7foerw
	/7tCc1aEnFIrWHOBF2x3/+UJNW/tH3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753871339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sbC6Uq5aYunWTU8USVVOdmjcJNM1Dt2n1UGLWwQRu+8=;
	b=gEoL0hF5yZOWd21zLCSzN9WEthatKLWDoAxBh9xa2QrBNDykpAHwEIO3c0TpqKMYk+FAmD
	2rPQ29BG5Te9HlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8A871388B;
	Wed, 30 Jul 2025 10:28:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KkoMLevziWhvfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 10:28:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7277EA094F; Wed, 30 Jul 2025 12:28:59 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iomap: Fix broken data integrity guarantees for O_SYNC writes
Date: Wed, 30 Jul 2025 12:28:41 +0200
Message-ID: <20250730102840.20470-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=jack@suse.cz; h=from:subject; bh=lO7YkAhoMX+qzxXhKtt6Kzmf4wUtQ/sEypG2OHMHblU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoifPYe+pOCTKYAOuLCx+ipNUdUqidRt9KSPJKNZUZ bA5qz16JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaInz2AAKCRCcnaoHP2RA2SlQCA ClZnOwpx0K5w2IalXfFQEEJM9eGybMRcz7gyFWpRp2F4W+Ksmm+V1/FrI8TcGHW8ondSO/TG6Lpuh9 ajQCwlfriZcq6gt0IgSE3vatVzfgnP+JhOnFhUhNPJbUu1aqoWsDdrKFK6nhyMP21ZdXhXkZq4uP+u X5O1n5z0SR+iVXdrXNr3wHewSAUTZOBdM14NXVxyry2FxOx642MLvi3pBZA3/F0FbsXW6+DvhBL4gU sllOI9tWNqztsD6ojSKH2/hKStlrc+2CBZRdLmfyPpLOu5DurYAy6gNdnDGarIrVd7G8jAiTUaOzC4 48+LKZvTGm7bS4b3yEExYM+s+mOZLk
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,oracle.com,gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

Commit d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()") has broken
the logic in iomap_dio_bio_iter() in a way that when the device does
support FUA (or has no writeback cache) and the direct IO happens to
freshly allocated or unwritten extents, we will *not* issue fsync after
completing direct IO O_SYNC / O_DSYNC write because the
IOMAP_DIO_WRITE_THROUGH flag stays mistakenly set. Fix the problem by
clearing IOMAP_DIO_WRITE_THROUGH whenever we do not perform FUA write as
it was originally intended.

CC: John Garry <john.g.garry@oracle.com>
CC: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Fixes: d279c80e0bac ("iomap: inline iomap_dio_bio_opflags()")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/iomap/direct-io.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

BTW, I've spotted this because some performance tests got suspiciously fast
on recent kernels :) Sadly no easy improvement to cherry-pick for me to fix
customer issue I'm chasing...

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f25d4cfea9f..b84f6af2eb4c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -363,14 +363,14 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		if (iomap->flags & IOMAP_F_SHARED)
 			dio->flags |= IOMAP_DIO_COW;
 
-		if (iomap->flags & IOMAP_F_NEW) {
+		if (iomap->flags & IOMAP_F_NEW)
 			need_zeroout = true;
-		} else if (iomap->type == IOMAP_MAPPED) {
-			if (iomap_dio_can_use_fua(iomap, dio))
-				bio_opf |= REQ_FUA;
-			else
-				dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-		}
+		else if (iomap->type == IOMAP_MAPPED &&
+			 iomap_dio_can_use_fua(iomap, dio))
+			bio_opf |= REQ_FUA;
+
+		if (!(bio_opf & REQ_FUA))
+			dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
 
 		/*
 		 * We can only do deferred completion for pure overwrites that
-- 
2.43.0


