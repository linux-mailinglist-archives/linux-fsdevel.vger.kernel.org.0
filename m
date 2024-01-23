Return-Path: <linux-fsdevel+bounces-8588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF3839292
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886901C258A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A177A5FF0C;
	Tue, 23 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlSuF+Ls";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Di/3X+3e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlSuF+Ls";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Di/3X+3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF325FDAF;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=HY/BaVuIklNh7adhQWyGCsnylBqJNkTJoxmFG4u4mqINReHtFpfvgyzr2m/PnZEFGNBLWchSh4eZAekP650fLHA8fEIsgLqyRGKM+GCvnlDRCzJ0b86JnC4V0QSoKKd1MRNXpl8bBO7cwGahmHl+p3hUk4pPKll1rv56d/sMq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=njkZ7eQ3hNkN3oQBJ9/Q5jandzQ7F3U57UqHwYTh0NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AEHiBYpn9tmK5/C8oxOAdVgWIHjJHWsaOnhq3RUsfENH5j3I/mi4foqkPZ3po6MuWgLcIgM/NRdTjGPrBVN7XTwA3HtSVujg2lqQvKaNpKwCozpQNnFW32GjBvDdrLrfxSY5khuLNPqLClho2PuLc/Of2Cofd30Bz0V1wlT7GsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlSuF+Ls; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Di/3X+3e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlSuF+Ls; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Di/3X+3e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 732F91FD55;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/XNthL/uLGWWNEYcTeLr3Oy1DGRnIPkZ9IP8zvk5gw=;
	b=LlSuF+LsXCHxYwkNqetvkSeSkV73+GPk2yNRGM2mI5JJg6FGUVwHvniIFmKb57vUu972+d
	rHsGykynzX8GcACzvOYj6M8+yTp67M927YEO/OerNd8Q2Z8xn6wnOj4VKcaZcmjHS5759X
	7ECvMlY4G/NXm0QfpH0rbIXgQV89i3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/XNthL/uLGWWNEYcTeLr3Oy1DGRnIPkZ9IP8zvk5gw=;
	b=Di/3X+3ecOvAQa4/7ZEr3uySkmaDba6QEwU4+oNeJy9zG4rQTFFm6WpjfqoANtnAgadYN5
	dIlKLNMa+042+VBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/XNthL/uLGWWNEYcTeLr3Oy1DGRnIPkZ9IP8zvk5gw=;
	b=LlSuF+LsXCHxYwkNqetvkSeSkV73+GPk2yNRGM2mI5JJg6FGUVwHvniIFmKb57vUu972+d
	rHsGykynzX8GcACzvOYj6M8+yTp67M927YEO/OerNd8Q2Z8xn6wnOj4VKcaZcmjHS5759X
	7ECvMlY4G/NXm0QfpH0rbIXgQV89i3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/XNthL/uLGWWNEYcTeLr3Oy1DGRnIPkZ9IP8zvk5gw=;
	b=Di/3X+3ecOvAQa4/7ZEr3uySkmaDba6QEwU4+oNeJy9zG4rQTFFm6WpjfqoANtnAgadYN5
	dIlKLNMa+042+VBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 618FD136A4;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9bkpGGXar2WVdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E32E6A0807; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/9] udf: Avoid GFP_NOFS allocation in udf_load_pvoldesc()
Date: Tue, 23 Jan 2024 16:25:02 +0100
Message-Id: <20240123152520.4294-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=jack@suse.cz; h=from:subject; bh=njkZ7eQ3hNkN3oQBJ9/Q5jandzQ7F3U57UqHwYTh0NM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pOrrM4JvYZiIEsp4gI3GM0vKSMH/HU9au+Q4Oi Ib0PoUuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aTgAKCRCcnaoHP2RA2Se2CA C0/3CQ/IPIsZ58ucQL1ugn4ajrLdfz4LjYbqL7HoTn+t7Wbmb1apV237JZ37a4GP3W63a8ZHW0DiWe d9YESyEiUgqv3jaWRLxCjIvBxCekmaE1lQ3GoZjLAlWYNl0Sv+3OJVCMZIwaQuJhrMSONPEcSaD/36 uSXG80CRY8PZOx4MxL841TAXnNOWJAZWZKDMpa4L13IPXV17IUkW/tOhmLrJHK4EHQxEeCdvW5GBl4 rjKbnznWeCb+TuqLf63xNL7z5/NpqRFM6ctJFEAniMMxXyFSKh4putuCeFA38Us+8ECxtvX6D0crut WOOlw1R53FEkxwtKt4+BpB+v0fja6B
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LlSuF+Ls;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Di/3X+3e"
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 732F91FD55
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

udf_load_pvoldesc() is called only during mount when it is safe to
enter fs reclaim (we hold only s_umount semaphore). Change GFP_NOFS to
GFP_KERNEL allocation.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..0a15ea436fc2 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -864,7 +864,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 	int ret;
 	struct timestamp *ts;
 
-	outstr = kmalloc(128, GFP_NOFS);
+	outstr = kmalloc(128, GFP_KERNEL);
 	if (!outstr)
 		return -ENOMEM;
 
-- 
2.35.3


