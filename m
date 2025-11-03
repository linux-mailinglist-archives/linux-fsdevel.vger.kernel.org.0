Return-Path: <linux-fsdevel+bounces-66708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE830C2A03C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 05:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64EC3348117
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 04:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADFE2874E4;
	Mon,  3 Nov 2025 04:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRKwrR/e";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRKwrR/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEB223DDA
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 04:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142865; cv=none; b=QH24mMiCIiD1ZlYWxmFYfPk1ZuoUIIx+oa3jnZlbmWckVsvIT56CSAO2ZqRKI+nraT68Vkijhd5kuS3s9r/RskJtB5xQBQl+60bbbCZ47y6+FApT8lvliUQvJWSwOuMFDnqIyhcNfQVtmjmDLs9hcRcNBaWHOaXF2o3gHex8G/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142865; c=relaxed/simple;
	bh=FyRcaPuRosozwt6Dw4eaMlT4oswh1+hVX3mqIV1JWCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j30sFsMcqxqzMQRSfqWht5DG7qN489wnWB7SO03f6S/2WVyT11TF4/esBylh07oLt7hjophf6r/W+i603PNGrMvFpGWklHur0x0bq17RbTzER2IewSs4eXEPth8wWYk4EemwYpTNfNCJ4fQnImjg5SAq73qCOojbziHniEl/Auw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRKwrR/e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRKwrR/e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 319D221EF7;
	Mon,  3 Nov 2025 04:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZqEgRqQaVT5XeFeSX9syFbviPAF03Ua4FTu79vp20I=;
	b=uRKwrR/e55mbC908QC1pD2LWLp8ghCOVnQxVYPcKJuvGAYoLVAdt9XH1R6Ywpr7DqaItdT
	mtByfs6VcxyRFHEiDdrftSE1Z9m8IeCPj8Aru2iwHBcWijHzueM16YaKTBhFlqlIGCSOif
	OhaSTM+MIGzGG1/9IHD7JLSMwGB+wkY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZqEgRqQaVT5XeFeSX9syFbviPAF03Ua4FTu79vp20I=;
	b=uRKwrR/e55mbC908QC1pD2LWLp8ghCOVnQxVYPcKJuvGAYoLVAdt9XH1R6Ywpr7DqaItdT
	mtByfs6VcxyRFHEiDdrftSE1Z9m8IeCPj8Aru2iwHBcWijHzueM16YaKTBhFlqlIGCSOif
	OhaSTM+MIGzGG1/9IHD7JLSMwGB+wkY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B12D1397D;
	Mon,  3 Nov 2025 04:07:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mG1xC4YqCGnhfAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Nov 2025 04:07:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 1/2] fs: do not pass a parameter for sync_inodes_one_sb()
Date: Mon,  3 Nov 2025 14:37:28 +1030
Message-ID: <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1762142636.git.wqu@suse.com>
References: <cover.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

The function sync_inodes_one_sb() will always wait for the writeback,
and ignore the optional parameter.

Explicitly pass NULL as parameter for the call sites inside
do_sync_work().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 7e26c6f1f2a1..1081cd0e89c7 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -126,10 +126,10 @@ static void do_sync_work(struct work_struct *work)
 	 * Sync twice to reduce the possibility we skipped some inodes / pages
 	 * because they were temporarily locked
 	 */
-	iterate_supers(sync_inodes_one_sb, &nowait);
+	iterate_supers(sync_inodes_one_sb, NULL);
 	iterate_supers(sync_fs_one_sb, &nowait);
 	sync_bdevs(false);
-	iterate_supers(sync_inodes_one_sb, &nowait);
+	iterate_supers(sync_inodes_one_sb, NULL);
 	iterate_supers(sync_fs_one_sb, &nowait);
 	sync_bdevs(false);
 	printk("Emergency Sync complete\n");
-- 
2.51.2


