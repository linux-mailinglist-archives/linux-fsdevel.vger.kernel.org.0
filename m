Return-Path: <linux-fsdevel+bounces-41014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F724A2A05C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51733A85FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBBB224AE2;
	Thu,  6 Feb 2025 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aIeTf06L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0+9lEa31";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aIeTf06L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0+9lEa31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944C81B59A;
	Thu,  6 Feb 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820849; cv=none; b=Hh7fOmB0pPkZRou3OYkpleOI2bo6JmnHCVGC4FxZ/x649OaPw2dNqojpoAKlH25sRT8t65qcNBxxJqBU5G/lw0FU+IkypYftM3yB/xRc73w/7NOfQ7aeQzRhyZDKzHUM97q20T1zJEwozne1ByksAeE1+Qix8KHwgf3Szy1orwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820849; c=relaxed/simple;
	bh=1stp1MuIyBM3C4v6cuOVBi2Ieq0TFzc6HI42fSPXfu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2XmoTaNgVd5v4KwcFFbnEE6KZvWSu6ip+BzQrBWgtqLBsG4yY4fZ4yB6yAy7Kxelgu0/IHQtYtlS++8H+68MJ4qmDPyjyyutKuWlN2uYvNUEITXTZI0G+KZjoBUaS1EoE1Lb+frCHO0RxTDNKhnKAdVtcoldoIdRbfTtRK+D7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aIeTf06L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0+9lEa31; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aIeTf06L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0+9lEa31; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD3821F381;
	Thu,  6 Feb 2025 05:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OKcyBzOYgr/dhyXLlvhMO4GQauunZVDnxngPVrXFM=;
	b=aIeTf06LtedqZeC5uqSdHgS4xhkfv4UD675jOw/0Ut2LdV5pji3Xa9Q87+Y3JYIoSO60ka
	IalXlVfBlT22RdlLMYZh+1kI6is/yLsmWDoGHwtp/8FrBaNBoLwW/fVWCcB3ae7HdKy9is
	DNKI3TKz+yruY3dQqGuZyMhWkI9AUfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OKcyBzOYgr/dhyXLlvhMO4GQauunZVDnxngPVrXFM=;
	b=0+9lEa31bbT6Q6MZbHVExWA70Vc7hukXpf5MZi3tMH4s6YCANeFOePXoGUdk9F1WD6UHQZ
	185zjvp6zvhNQKDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OKcyBzOYgr/dhyXLlvhMO4GQauunZVDnxngPVrXFM=;
	b=aIeTf06LtedqZeC5uqSdHgS4xhkfv4UD675jOw/0Ut2LdV5pji3Xa9Q87+Y3JYIoSO60ka
	IalXlVfBlT22RdlLMYZh+1kI6is/yLsmWDoGHwtp/8FrBaNBoLwW/fVWCcB3ae7HdKy9is
	DNKI3TKz+yruY3dQqGuZyMhWkI9AUfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OKcyBzOYgr/dhyXLlvhMO4GQauunZVDnxngPVrXFM=;
	b=0+9lEa31bbT6Q6MZbHVExWA70Vc7hukXpf5MZi3tMH4s6YCANeFOePXoGUdk9F1WD6UHQZ
	185zjvp6zvhNQKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 176DD13795;
	Thu,  6 Feb 2025 05:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gp9VL+pMpGfLBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:22 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/19] VFS: enhance d_splice_alias to accommodate shared-lock updates
Date: Thu,  6 Feb 2025 16:42:49 +1100
Message-ID: <20250206054504.2950516-13-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

d_splice_alias() - via __d_unalias() - currently assumes that taking a
shared lock on the parent directory locks against any change to the
parent/name of the dentry.  This will no longer be the case with
shared-lock updates.  We also need a DCACHE_PAR_UPDATE lock on the
dentry.

This patch adds a call to d_update_trylock() to get this lock -if
possible.  This lock ensures that the test on ->d_parent and ->d_name in
d_update_lock() will not be invalidated by the __d_move() in __d_unalias.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/dcache.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index e705696ca57e..fb331596f1b1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3036,13 +3036,17 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
 		goto out_err;
 	m2 = &alias->d_parent->d_inode->i_rwsem;
 out_unalias:
+	if (!d_update_trylock(dentry, NULL, NULL))
+		goto out_err;
 	if (alias->d_op && alias->d_op->d_unalias_trylock &&
 	    !alias->d_op->d_unalias_trylock(alias))
-		goto out_err;
+		goto out_err2;
 	__d_move(alias, dentry, false);
 	if (alias->d_op && alias->d_op->d_unalias_unlock)
 		alias->d_op->d_unalias_unlock(alias);
 	ret = 0;
+out_err2:
+	d_update_unlock(dentry);
 out_err:
 	if (m2)
 		up_read(m2);
@@ -3073,6 +3077,10 @@ static int __d_unalias(struct dentry *dentry, struct dentry *alias)
  * In that case, we know that the inode will be a regular file, and also this
  * will only occur during atomic_open. So we need to check for the dentry
  * being already hashed only in the final case.
+ *
+ * @dentry must have a valid ->d_parent and that directory must be
+ * locked (i_rwsem) either exclusively or shared.  If shared then
+ * @dentry must have %DCACHE_PAR_LOOKUP or %DCACHE_PAR_UPDATE set.
  */
 struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 {
-- 
2.47.1


