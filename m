Return-Path: <linux-fsdevel+bounces-66707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 607FBC2A039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 05:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB04E2BF7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 04:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B45274669;
	Mon,  3 Nov 2025 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="AJZfsEoK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="C7kNSh91"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A686334
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142857; cv=none; b=LR/XonNtpPu5LjZibeHZvT9ww8a3e+Qxjr/7Bp1lVmawexVu5EBDEcgCdS7JKiIguE4XzmTQ1p6p1oE3oD3ZFnwbgjWmxBCis/tHHkQM/9aeRMkCY7Mt1cg9/8WsycT5nJl/8ItXQF8SqO1Lc2qO8xnje/jivI5gZf8bRaT7fKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142857; c=relaxed/simple;
	bh=yZ2eiZy4PeudqCHmBjPKkWUe7OZi2fiXd7M5EyaSJ84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWHlUnUywk3PI23uSw3IYtjazjRKKbzGAASNZBRuj/XjTkq2jHnrrl0sjVPmHoQlDS2sVvT7sXRuwhuKjP9dWBrwGKxUDB1CKDRE69RDp5jLveePYuri6U7eWfCWaURvQ04v/7vLP9fT7fjdt3X1Nvb8VDeUyqXKbKCIKljCbFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=AJZfsEoK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=C7kNSh91; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC1F821EF3;
	Mon,  3 Nov 2025 04:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2hwU0Gh9IRPYm22lTtuVTtlK8zh8YaxxqmWNNoNPoQ=;
	b=AJZfsEoK6aQ0DVLw1QVUEX8apGp1zu9rOh0oeWEjpWlXMp+lw+XOVLEBqjM6YRrmu862q9
	3fwADV3D8NDrMQh9JIzGSzb5dJ2ih29zKXgXXycRgySewvvt20C2JJ4jlE6qxocCYxr0C4
	KuaU+O9rv83MM91Mq41Dg3GYjq59To8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=C7kNSh91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762142853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=S2hwU0Gh9IRPYm22lTtuVTtlK8zh8YaxxqmWNNoNPoQ=;
	b=C7kNSh91GfquXk75KxVgah5feq95tHM5RyqpAvhbAlU3RL9OkzyVjihuHGXD47PVn0sTzQ
	/QtfCXgHWFSYxUtGZjY+LlPzWzE5Wwuuy0rZoPWIYVh1VY9s1NkCZgarWLQbusp3Dd8ktB
	D6tVUugMLcs4eYTwjVwER5IMl51XVIU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 322271397D;
	Mon,  3 Nov 2025 04:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PDsVOYMqCGnhfAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 03 Nov 2025 04:07:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 0/2] fs: fully sync all fsese even for an emergency sync
Date: Mon,  3 Nov 2025 14:37:27 +1030
Message-ID: <cover.1762142636.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC1F821EF3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

The first patch is a cleanup related to sync_inodes_one_sb() callback.
Since it always wait for the writeback, there is no need to pass any
parameter for it.

The second patch is a fix mostly affecting btrfs, as btrfs requires a
explicit sync_fc() call with wait == 1, to commit its super blocks,
and sync_bdevs() won't cut it at all.

However the current emergency sync never passes wait == 1, it means
btrfs will writeback all dirty data and metadata, but still no super
block update, resulting everything still pointing back to the old
data/metadata.

This lead to a problem where btrfs doesn't seem to do anything during
emergency sync.

The second patch fixes the problem by passing wait == 1 for the second
iteration of sync_fs_one_sb().

[REASON FOR RFC]
I am not sure which way should I fix the bug.

I can definitely put btrfs to ignore the @wait parameter and always do
transaction commit, that will definitely fix the bug, but btrfs will do
two transaction commits for emergency sync.
Which may or may not be a problem for emergency sync itself, but will
definitely cause a lot of unnessary small transactions during regular
sync_fs() calls and degrade the peroformance.

On the other hand, I also didn't see why we can not follow the common
pattern inside emergency_sync(), all other call sites are syncing the fs
first with nowait, then wait.
(E.g. sync_filesyastem() and ksys_sync()).

I know it's an emergency sync thus we don't want to wait, but please
also remember that sync_inodes_one_sb() is always waiting, and I'm
pretty sure we spend most of the time inside sync_inodes_one_sb(), thus
it looks more sane to fix the only exception inside fs/sync.c.

Qu Wenruo (2):
  fs: do not pass a parameter for sync_inodes_one_sb()
  fs: fully sync all fses even for an emergency sync

 fs/sync.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.51.2


