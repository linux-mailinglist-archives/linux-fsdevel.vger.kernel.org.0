Return-Path: <linux-fsdevel+bounces-74504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78CD3B44A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D44E306045F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6901331B800;
	Mon, 19 Jan 2026 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P1EaL9N+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NN0d/1cL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="P1EaL9N+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NN0d/1cL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998CF3115A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842851; cv=none; b=meZNQ8bSjuDvxjQUUXG0kROTGH941l97f8rYw62qvXul/A649V2P76ixSf46AvUtXVUkZn3odraBq4MktZlunqUW+HcKsTHkEU2hEhaSR2z5mi8gjmNPelXAhlffzy96E9izOyYM2aJlLRyd1qTkowFvBLEPXbm/0+RM17Ay6BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842851; c=relaxed/simple;
	bh=p0nqfGbttWWop2KRANZTYeJdhdsOmalKZZNZEABJduM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcazjuMhlQc/1u9JuGzYfkr3BNRjoZdhuxy6XMVvtjo4yWyST0YOsvX6cUl2b5WY48y7YVjgBYNrOG4AykRC7e41ySr9EjdYdy52+LKGjqa41tp3zi2z4xZCBeranAn9uHKg/2GPs+3ARURpbEksEYZr/dHrQAU4Kf0ysFfblfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P1EaL9N+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NN0d/1cL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=P1EaL9N+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NN0d/1cL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEFFD33742;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3/FRamf6ncWB9iL6lsdznUAMEmXYvw1oWXUrVdAJZU=;
	b=P1EaL9N+XUq/5mkPFBP2l16grVQRPbgOiu4lY8V/pzH6It67XewLJ7Il1DvsIohnFnJOH0
	GRt+Pif++tnVcwWUfeY3nyseietW0KZ1sq6ZnkUqqMHkBCKQA6+MCIQ7qTLkRMNUY2Uof5
	QxSmW1MM7ZB4DduBfrkXjDX2HGi9tjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3/FRamf6ncWB9iL6lsdznUAMEmXYvw1oWXUrVdAJZU=;
	b=NN0d/1cL5sV2j6hBMEcpZIfd6alFg8+qannyrkWWBV1jsGoS9IPvPC2gBzTJigI4PskX2Z
	pAV6vKixNz0R8sCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768842848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3/FRamf6ncWB9iL6lsdznUAMEmXYvw1oWXUrVdAJZU=;
	b=P1EaL9N+XUq/5mkPFBP2l16grVQRPbgOiu4lY8V/pzH6It67XewLJ7Il1DvsIohnFnJOH0
	GRt+Pif++tnVcwWUfeY3nyseietW0KZ1sq6ZnkUqqMHkBCKQA6+MCIQ7qTLkRMNUY2Uof5
	QxSmW1MM7ZB4DduBfrkXjDX2HGi9tjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768842848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3/FRamf6ncWB9iL6lsdznUAMEmXYvw1oWXUrVdAJZU=;
	b=NN0d/1cL5sV2j6hBMEcpZIfd6alFg8+qannyrkWWBV1jsGoS9IPvPC2gBzTJigI4PskX2Z
	pAV6vKixNz0R8sCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B40B13EA63;
	Mon, 19 Jan 2026 17:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GhrvK2Bmbml/JQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Jan 2026 17:14:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65F43A0A27; Mon, 19 Jan 2026 18:14:08 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Jakub Acs <acsjakub@amazon.de>
Subject: [PATCH 3/3] fsnotify: Shutdown fsnotify before destroying sb's dcache
Date: Mon, 19 Jan 2026 18:13:40 +0100
Message-ID: <20260119171400.12006-6-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119161505.26187-1-jack@suse.cz>
References: <20260119161505.26187-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=jack@suse.cz; h=from:subject; bh=p0nqfGbttWWop2KRANZTYeJdhdsOmalKZZNZEABJduM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpbmZaa1iLxWRzoE09+2cldd9hrxI8rXMNembxi XS3J1bIt7SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaW5mWgAKCRCcnaoHP2RA 2XWtCADqSS+wWwlJs/L105evyVkrNCCUcyQ40SzlHEMq6RITWeHnp5J/S5ZpkOS+SpOkBwQKI0G ada7Dyr/lHGI/BsaYbzS1A+JebmdhuELguYyK+x9kpol1ywAV+inGMFMkRJCaDa2sANcN9xYlro DsSM+cy/MRWyheNLeBiavi1673UiHm4QDU7O6sfTDVfRgpzgKSWm/sWjkcEbeUXX5tF0DFZFZe7 I8BqLVKRPjRIq/+Hr9s66N49f7H01L9F5Uhxd3RVbUHomZiOI6fCe2NUJ+56TLX9H70gMqzMnAL q6rxgIjhBJ3S7/UlacCz+36fikmm285BINnsOuQoHkv4ps6Q
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,amazon.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Flag: NO

Currently fsnotify_sb_delete() was called after we have evicted
superblock's dcache and inode cache. This was done mainly so that we
iterate as few inodes as possible when removing inode marks. However, as
Jakub reported, this is problematic because for some filesystems
encoding of file handles uses sb->s_root which gets cleared as part of
dcache eviction. And either delayed fsnotify events or reading fdinfo
for fsnotify group with marks on fs being unmounted may trigger encoding
of file handles during unmount. So move shutdown of fsnotify subsystem
before shrinking of dcache.

Reported-by: Jakub Acs <acsjakub@amazon.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 3d85265d1400..9c13e68277dd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -618,6 +618,7 @@ void generic_shutdown_super(struct super_block *sb)
 	const struct super_operations *sop = sb->s_op;
 
 	if (sb->s_root) {
+		fsnotify_sb_delete(sb);
 		shrink_dcache_for_umount(sb);
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
@@ -629,9 +630,8 @@ void generic_shutdown_super(struct super_block *sb)
 
 		/*
 		 * Clean up and evict any inodes that still have references due
-		 * to fsnotify or the security policy.
+		 * to the security policy.
 		 */
-		fsnotify_sb_delete(sb);
 		security_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
-- 
2.51.0


