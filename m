Return-Path: <linux-fsdevel+bounces-63302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02DBB4690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0463AEA7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C102356C6;
	Thu,  2 Oct 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWD/swVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ET9amXN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWD/swVc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ET9amXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28019D880
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420527; cv=none; b=VXo/Y97iAxy66EI9sK/Hp5MAtoU/tKXvc6rJQ0knIppQMBwU5RMSoKZyC9Ub9P2lkrIIVdDSM9Sb8CVyxSsATEUBehdPY95TAcBhEr7Um9qI8ywU6qmuD2z+7BMkwPs2/k8U8OK9kjy0M6H5GnoEJRdf02fag7LZmCbnPu1LFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420527; c=relaxed/simple;
	bh=AJYH9Ash51Y0f83I/PSNdA1gDSUNCkPIMKbXMeXZaOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UFh8kn+V4bSay+CA957XcKBl1+RHZR9eRbLEi+WyM6Dd8DIkjoLEwdeK8F7TDqp45xb6Q1FyUbc0bgzwf5ipyLCvw0CPasQd/j/nbcA/HKOU2SrAw7XFs7BgBTaQHmLGBDeutJCJxruDZcvwIQKpMP8CYsD47/Xrs9A6jGoJogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWD/swVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ET9amXN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWD/swVc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ET9amXN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9A8E71F745;
	Thu,  2 Oct 2025 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759420522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NLcS48GXIVWUa8WkYuN1HuEW+DYNvi8RrkB1Qj6TDM0=;
	b=IWD/swVc+WJkyWIwZqO1n0GQNJDR4PeECmsmw2MzqSJ/NQW6hsYoWkJ5vsqCxRset+5ZpJ
	zpYh1LieWxieAuJ4nO+b/kBoiKdEE0uAJzw5fqiw7hx61zAHvtMHkMgMTpJK1hUAsCdTr2
	nSsvHXqGNTNb7CFGDe4NWevB5p97ffs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759420522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NLcS48GXIVWUa8WkYuN1HuEW+DYNvi8RrkB1Qj6TDM0=;
	b=1ET9amXNpXIXL6ZxH3c4z9CXIMec7Wky/jZaCw1tnOqZ6t9cT2x1jUSMjT+4j0kdDxDamZ
	mYe9atG//jPn0QBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759420522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NLcS48GXIVWUa8WkYuN1HuEW+DYNvi8RrkB1Qj6TDM0=;
	b=IWD/swVc+WJkyWIwZqO1n0GQNJDR4PeECmsmw2MzqSJ/NQW6hsYoWkJ5vsqCxRset+5ZpJ
	zpYh1LieWxieAuJ4nO+b/kBoiKdEE0uAJzw5fqiw7hx61zAHvtMHkMgMTpJK1hUAsCdTr2
	nSsvHXqGNTNb7CFGDe4NWevB5p97ffs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759420522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NLcS48GXIVWUa8WkYuN1HuEW+DYNvi8RrkB1Qj6TDM0=;
	b=1ET9amXNpXIXL6ZxH3c4z9CXIMec7Wky/jZaCw1tnOqZ6t9cT2x1jUSMjT+4j0kdDxDamZ
	mYe9atG//jPn0QBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F83213A85;
	Thu,  2 Oct 2025 15:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o5egImqg3mg7awAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 15:55:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08B13A0A58; Thu,  2 Oct 2025 17:55:18 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-fsdevel@vger.kernel.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] vfs: Don't leak disconnected dentries on umount
Date: Thu,  2 Oct 2025 17:55:07 +0200
Message-ID: <20251002155506.10755-2-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=jack@suse.cz; h=from:subject; bh=AJYH9Ash51Y0f83I/PSNdA1gDSUNCkPIMKbXMeXZaOM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBo3qBaEGYztI6eut/gwfx55GPogu+MNEM4WYFZy NLEoavW2PyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaN6gWgAKCRCcnaoHP2RA 2fvYCADV6ry0eX8Qk9YfRy/G5lOucaYuxzwlbwe8/WJ72tG6F6l+G2YjH72pQztsSrUbJktYd8w DZc42MlxlOpr24WDr0yAbZgV/Lx6fO5v8/AG7VnEZKj2xYy7vVitoZUTaLnyR/Fh856Tu6J+nBz 85kqWU0MIzHuff/4GLJL1aDOIXpWRgclXM0V3p+2nPVni4HG0N4dMSC5C/VUIbJr5pBuXcb2T1o WLomSYLUvucZWom3ISsOzHInQqp5+BQjxwh59aYOuJZUDAnPpf1jTFJjg1Hk1i7h2/GT6wQrwi5 iwJjDlnj9V4gFuVMxyAga5HFI+1NCGEaadDeBaaSosoKVmC0
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[1d79ebe5383fc016cf07];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ZenIV.linux.org.uk,vger.kernel.org,gmail.com,suse.cz,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,appspotmail.com:email];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -1.30

When user calls open_by_handle_at() on some inode that is not cached, we
will create disconnected dentry for it. If such dentry is a directory,
exportfs_decode_fh_raw() will then try to connect this dentry to the
dentry tree through reconnect_path(). It may happen for various reasons
(such as corrupted fs or race with rename) that the call to
lookup_one_unlocked() in reconnect_one() will fail to find the dentry we
are trying to reconnect and instead create a new dentry under the
parent. Now this dentry will not be marked as disconnected although the
parent still may well be disconnected (at least in case this
inconsistency happened because the fs is corrupted and .. doesn't point
to the real parent directory). This creates inconsistency in
disconnected flags but AFAICS it was mostly harmless. At least until
commit f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
which removed adding of most disconnected dentries to sb->s_anon list.
Thus after this commit cleanup of disconnected dentries implicitely
relies on the fact that dput() will immediately reclaim such dentries.
However when some leaf dentry isn't marked as disconnected, as in the
scenario described above, the reclaim doesn't happen and the dentries
are "leaked". Memory reclaim can eventually reclaim them but otherwise
they stay in memory and if umount comes first, we hit infamous "Busy
inodes after unmount" bug. Make sure all dentries created under a
disconnected parent are marked as disconnected as well.

Reported-by: syzbot+1d79ebe5383fc016cf07@syzkaller.appspotmail.com
Fixes: f1ee616214cb ("VFS: don't keep disconnected dentries on d_anon")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/dcache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 65cc11939654..3ec21f9cedba 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2557,6 +2557,8 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	spin_lock(&parent->d_lock);
 	new->d_parent = dget_dlock(parent);
 	hlist_add_head(&new->d_sib, &parent->d_children);
+	if (parent->d_flags & DCACHE_DISCONNECTED)
+		new->d_flags |= DCACHE_DISCONNECTED;
 	spin_unlock(&parent->d_lock);
 
 retry:
-- 
2.51.0


