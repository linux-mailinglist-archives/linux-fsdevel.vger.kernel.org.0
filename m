Return-Path: <linux-fsdevel+bounces-41819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A257A37AFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 06:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B61690D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAEA188587;
	Mon, 17 Feb 2025 05:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWr+2ALq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nDxygrs5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OWr+2ALq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nDxygrs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D277E15F306
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 05:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770750; cv=none; b=k46Von8kTh9nsvZMZbPyVGaaQ1Vigi1IAjlfNRdSvZ3mlEm9RqovNulJaq7b97lUufnRe8CQmjrSS4U7gczSrQ3sGooTwK6tQsHKssJheR638oTUExvYTR3dpqM4BzAWXuZo2gUdRGd8xooa5LradFJKI7PAtmuuvkxnJTyUog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770750; c=relaxed/simple;
	bh=SYHNLXDvVG3sgWzbfUmSth/Tc9jVLTVXi8QGScMpR8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXdlupH/E41XiLz2tkERHyHMHQJnW1klx2/n170a1eAKonSouVF3Sh1aIRMkbOVkguaA9kNpsQpqNTNKB7Yh4/WgIjvEwWNyGHh3OCVrNEyrZ3JWwXdFXkDSF0QWv57wRy/rNKvfDUs1uuXgdBOV9agWx03o47rkJ0djZiEHMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWr+2ALq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nDxygrs5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OWr+2ALq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nDxygrs5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B90FB21162;
	Mon, 17 Feb 2025 05:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739770746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tZZsXTpi3rKxiGJsgzzGFVN9uF4mR10nrXfgYxEdIfI=;
	b=OWr+2ALqcLzikCQuKZTCAaGgFGGfsDq8YMRqSakF5t6MFFBoqegmCA+ehYGVjwHP3cWErV
	PtRxbZONcK33+uVS7EBjtcoMiabytN1PrXJbgu0B6vDrV9l0ilKJGs5X1ps9k3ji8MICH+
	wWTKP9ZUGGY2rWX/rXzU0eAfvfJvBac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739770746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tZZsXTpi3rKxiGJsgzzGFVN9uF4mR10nrXfgYxEdIfI=;
	b=nDxygrs5X31lE1hRGF+7rVdacdMcT6EPAXaalKG+HNg2tCw6endHVXJDQN0qLOumI5DfdQ
	a3dlEYIyQNgcFBAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OWr+2ALq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nDxygrs5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739770746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tZZsXTpi3rKxiGJsgzzGFVN9uF4mR10nrXfgYxEdIfI=;
	b=OWr+2ALqcLzikCQuKZTCAaGgFGGfsDq8YMRqSakF5t6MFFBoqegmCA+ehYGVjwHP3cWErV
	PtRxbZONcK33+uVS7EBjtcoMiabytN1PrXJbgu0B6vDrV9l0ilKJGs5X1ps9k3ji8MICH+
	wWTKP9ZUGGY2rWX/rXzU0eAfvfJvBac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739770746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tZZsXTpi3rKxiGJsgzzGFVN9uF4mR10nrXfgYxEdIfI=;
	b=nDxygrs5X31lE1hRGF+7rVdacdMcT6EPAXaalKG+HNg2tCw6endHVXJDQN0qLOumI5DfdQ
	a3dlEYIyQNgcFBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E18831363A;
	Mon, 17 Feb 2025 05:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UBf4JHjLsmcydQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 17 Feb 2025 05:39:04 +0000
From: NeilBrown <neilb@suse.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3 RFC v2] change ->mkdir() and vfs_mkdir() to return a dentry
Date: Mon, 17 Feb 2025 16:30:02 +1100
Message-ID: <20250217053727.3368579-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B90FB21162
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Here is a second attempt at this change.  Guided by Al I have handled
other file systems which don't return a hashed positive dentry on success.

It is not always possible to provide a reliable answer.  One example is
that cifs might find, after successfully creating a directory, that the
name now leads to a non-directory (due to a race with another client).
So callers of vfs_mkdir() need to cope with successful mkdir but no
usable dentry.  There is nothing they can do to recover and must
continue gracefully.  This failre mode is detected by the returned
dentry being unhashed.

ORIGINAL DESCRIPTION - updated to reflect changes.

This is a small set of patches which are needed before we can make the
locking on directory operations more fine grained.  I think they are
useful even if we don't go that direction.

Some callers of vfs_mkdir() need to operate on the resulting directory
but cannot be guaranteed that the dentry will be hashed and positive on
success - another dentry might have been used.

This patch changes ->mkdir to return a dentry, changes several
filesystems to return the correct dentry, and changes vfs_mkdir() to
return that dentry, only performing a lookup as a last resort.

I have not Cc: the developers of all the individual filesystems NFS.  I
or kernel-test-robot have build-tested all the changes.  If anyone sees
this on fs-devel and wants to provide a pre-emptive ack I will collect
those and avoid further posting for those fs.

Thanks,
NeilBrown


 [PATCH 1/3] Change inode_operations.mkdir to return struct dentry *
 [PATCH 2/3] nfs: change mkdir inode_operation to return alternate
 [PATCH 3/3] VFS: Change vfs_mkdir() to return the dentry.

