Return-Path: <linux-fsdevel+bounces-25041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AF9482FF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 22:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389DB2829AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 20:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F116C69D;
	Mon,  5 Aug 2024 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiDkoiyP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySC0MQbi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NiDkoiyP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ySC0MQbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B116BE31;
	Mon,  5 Aug 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888772; cv=none; b=KUILPEszH6SeDHzTDDCLJJcxaTExTvgPhI2SRSj8nZ3H+saRKVkY6L7UwWyz8zsQKUbSmVxg28/fW1X3NWuzjxHynHSpMFHZOS6iS5JMD8bT8+2VUQelP5V+0P8OJJXWzt1XAbXnxuT2OtuNax5aw444pYRrl4SqyLV3jyoTmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888772; c=relaxed/simple;
	bh=bc+Ge37OciJ6ceD9NmYWedRGy7NN2zirzIPVaej+cAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHVyqnwN9UAG9RXIIVA7bMC9DwFyXKcr8Pk6e5peQuZoOV40I7fh7SZMeJq59CIdgbigWhLKrXKQw+oe7Tx45iysz8NBUaboo0P7txa+SQn0Jlp24rQSTc1Qc4AmIldzOB4w+wmrAtkG2x+tdQbgCclzCEfIh/dPasgYeuGJv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiDkoiyP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySC0MQbi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NiDkoiyP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ySC0MQbi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C763D1FDA4;
	Mon,  5 Aug 2024 20:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722888768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HjfMN5H32rJVjSKTez3olgsVsnE38mEUZL1pTxMglHE=;
	b=NiDkoiyPqvVFgDC8UZeAkSNfrjiKjhAe3v0FRSRbItxrXbje5FXIQV0LUL4CJltSQ5GcQA
	mjdsObAMxs8bIx61+WsIRK6iAyFWOLfq/ubbQ5whmJfEFo1aZyETub/+3fPBUYcDckoVHE
	m9Yen+SvHG+EO0dBIafnb6FLDUFAQY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722888768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HjfMN5H32rJVjSKTez3olgsVsnE38mEUZL1pTxMglHE=;
	b=ySC0MQbi6/dh4NTwtqvL81Su8uUoMVvSQ/eTkz9Uhp2P+b4qBR6qKaEK0HXB1LwlPOiKCj
	myN7qfjnpTWah9Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722888768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HjfMN5H32rJVjSKTez3olgsVsnE38mEUZL1pTxMglHE=;
	b=NiDkoiyPqvVFgDC8UZeAkSNfrjiKjhAe3v0FRSRbItxrXbje5FXIQV0LUL4CJltSQ5GcQA
	mjdsObAMxs8bIx61+WsIRK6iAyFWOLfq/ubbQ5whmJfEFo1aZyETub/+3fPBUYcDckoVHE
	m9Yen+SvHG+EO0dBIafnb6FLDUFAQY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722888768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HjfMN5H32rJVjSKTez3olgsVsnE38mEUZL1pTxMglHE=;
	b=ySC0MQbi6/dh4NTwtqvL81Su8uUoMVvSQ/eTkz9Uhp2P+b4qBR6qKaEK0HXB1LwlPOiKCj
	myN7qfjnpTWah9Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2FFD13254;
	Mon,  5 Aug 2024 20:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OVysK0AysWYCMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 20:12:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 499DBA0663; Mon,  5 Aug 2024 22:12:44 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Ted Tso <tytso@mit.edu>
Cc: <linux-ext4@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: don't set SB_RDONLY after filesystem errors
Date: Mon,  5 Aug 2024 22:12:41 +0200
Message-Id: <20240805201241.27286-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=jack@suse.cz; h=from:subject; bh=bc+Ge37OciJ6ceD9NmYWedRGy7NN2zirzIPVaej+cAQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmsTIyHWKt5UqQTxGyX96VrX6w5fb5mqM3rG218J6w zYAtHIWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrEyMgAKCRCcnaoHP2RA2RvJB/ 97uZrR1qgSWENg48v92iTQn2GpA2ukqOD10zGah31jdBqoL9SCEV5sqQBvCJqfrp5/unXLs8jRS/cq pXtJd/t7ljRD6jKMu5fkC+vC1nzD3i7hn17ngMWM56c3do+Jdg5ElIsnDZEhd5fMR9WOvUwjgrGo/M HBYXjcGAMnuBpLPknG9jbltVBugI0h/02RIEXVjX0/omXGRnKYb7NLqL1b3uZjrSpqMDnUXqFC0XOa oujd2PFhkq8Xiu2vVG/4ZMty5vSOAKvnXUjOiS+gWqg6oBF/XoeuSmui6VgVS47oVuvHHVdASmoMHe 060ErGKf/RYBkE7FRR+D48Xg5TA4T8
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

When the filesystem is mounted with errors=remount-ro, we were setting
SB_RDONLY flag to stop all filesystem modifications. We knew this misses
proper locking (sb->s_umount) and does not go through proper filesystem
remount procedure but it has been the way this worked since early ext2
days and it was good enough for catastrophic situation damage
mitigation. Recently, syzbot has found a way (see link) to trigger
warnings in filesystem freezing because the code got confused by
SB_RDONLY changing under its hands. Since these days we set
EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
stop doing that.

Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Note that this patch introduces fstests failure with generic/459 test because
it assumes that either freezing succeeds or 'ro' is among mount options. But
we fail the freeze with EFSCORRUPTED. This needs fixing in the test but at this
point I'm not sure how exactly.

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a..93c016b186c0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
+	 * modifications. We don't set SB_RDONLY because that requires
+	 * sb->s_umount semaphore and setting it without proper remount
+	 * procedure is confusing code such as freeze_super() leading to
+	 * deadlocks and other problems.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void update_super_work(struct work_struct *work)
-- 
2.35.3


