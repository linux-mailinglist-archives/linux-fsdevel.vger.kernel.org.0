Return-Path: <linux-fsdevel+bounces-41015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2644A2A059
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7001418884AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F04D2253E7;
	Thu,  6 Feb 2025 05:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kb77S9c/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TuDkQstM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PwxcEp8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1fkhx17U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2B2236EE;
	Thu,  6 Feb 2025 05:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820860; cv=none; b=uMvtyKEsIGwuVbW4y1SpHXoHp3mL8V7m5AN1uZhTx0eoDBUfcKNqooOXpPc4s8FnQQn2UB4cITvG8M/85gSFrIgFdBrpuM2gMMsvzZI63HZ2TwFmLiUyTQKVD122a7upheo0seytn97ZhJgwNBi5WflIFlZaRiOoydMW8L3A+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820860; c=relaxed/simple;
	bh=i/oHb05z3TPZXb3xfHjmEd5RoH7nMeWAlCEX/lHyz9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CuOBn7TuSfnZ77x1oA2bYa/qLl6h5W1piBuoSK12fJeNH0tkWTlB+yj8pbdK9brdZwHfkbymX8b75xV9ExFjzNmOHNUlTBJKy/xTv/ipScsRrsrhMbTXSHuHbUw1ACBOOLtJz2q/qrYQb0HjTB8JAHs5ZyEF7olUQMtdiDfYdsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kb77S9c/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TuDkQstM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PwxcEp8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1fkhx17U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12D7421108;
	Thu,  6 Feb 2025 05:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRkrNPpQOJiLW6OESPgTO2Ruu6UWEe+cDZW/FJFZUQM=;
	b=kb77S9c/ey3iORTolnGFVLvsIDbEcoEMjSBLkL44w1NQUYUbzzqOjr3eC6rVXYm8WDQJHw
	nDNKlLI3fTajfBXZxtBUC9V91lucrLpjbmV7SNgN/SqGH0G1wfUFWJnc/O1BZh/vm8QG3R
	tcF+zv/6683AQXBm0jEctkGBgWHXyXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRkrNPpQOJiLW6OESPgTO2Ruu6UWEe+cDZW/FJFZUQM=;
	b=TuDkQstMXNgX55WfxYja1BAhIx3hG6QuRuAEvy6ftYcVJYuzrINX3DIRG/IpXqG8yX9QJD
	D3h/2WAf3LQjcXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRkrNPpQOJiLW6OESPgTO2Ruu6UWEe+cDZW/FJFZUQM=;
	b=PwxcEp8LKV/ahuMPFsFdSmKd3gYWPn3gHx0dklWTs1neVgx8rlVg+r2SmUi/StFOEa0WFa
	G0q+N5aQATE+wBYBbdptLwydE9i63W0lWvh3k1TU74jzyJFII73W3ApBgpnNhRO4rEv61I
	/Nizl7yADTUUVmyY85cwJ2/FWgyjLwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820856;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRkrNPpQOJiLW6OESPgTO2Ruu6UWEe+cDZW/FJFZUQM=;
	b=1fkhx17UrgNVS0ExTl7OpqqjH2+s/izFyrbxF4tfBEuO4/OZnmgXgjb5ISwqvRPF167KDa
	DF5D03ROPV03fLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 514D213795;
	Thu,  6 Feb 2025 05:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fWPOAfVMpGfVBwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:47:33 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] VFS: lock dentry for ->revalidate to avoid races with rename etc
Date: Thu,  6 Feb 2025 16:42:50 +1100
Message-ID: <20250206054504.2950516-14-neilb@suse.de>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

When we call ->revalidate we want to be sure we are revalidating the
expected name.  As a shared lock on i_rwsem no longer prevents renames
we need to lock the dentry and ensure it still has the expected name.

So pass parent name to d_revalidate() and be prepared to retry the
lookup if it returns -EAGAIN.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c | 49 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 145ae07f9b8c..3a107d6098be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -957,12 +957,24 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
 }
 
 static inline int d_revalidate(struct inode *dir, const struct qstr *name,
-			       struct dentry *dentry, unsigned int flags)
+			       struct dentry *dentry, unsigned int flags,
+			       struct dentry *base, const struct qstr *last)
 {
-	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
-		return dentry->d_op->d_revalidate(dir, name, dentry, flags);
-	else
+	int status;
+
+	if (!unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
 		return 1;
+
+	if (dentry->d_flags & LOOKUP_RCU) {
+		if (!d_update_trylock(dentry, base, last))
+			return -ECHILD;
+	} else {
+		if (!d_update_lock(dentry, base, last, I_MUTEX_NORMAL))
+			return -EAGAIN;
+	}
+	status = dentry->d_op->d_revalidate(dir, name, dentry, flags);
+	d_update_unlock(dentry);
+	return status;
 }
 
 /**
@@ -1686,13 +1698,18 @@ static struct dentry *lookup_dcache(const struct qstr *name,
 				    struct dentry *dir,
 				    unsigned int flags)
 {
-	struct dentry *dentry = d_lookup(dir, name);
+	struct dentry *dentry;
+again:
+	dentry = d_lookup(dir, name);
 	if (dentry) {
-		int error = d_revalidate(dir->d_inode, name, dentry, flags);
+		int error = d_revalidate(dir->d_inode, name, dentry, flags, dir, name);
 		if (unlikely(error <= 0)) {
 			if (!error)
 				d_invalidate(dentry);
 			dput(dentry);
+			if (error == -EAGAIN)
+				/* raced with rename etc */
+				goto again;
 			return ERR_PTR(error);
 		}
 	}
@@ -1915,6 +1932,7 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 	 * of a false negative due to a concurrent rename, the caller is
 	 * going to fall back to non-racy lookup.
 	 */
+again:
 	if (nd->flags & LOOKUP_RCU) {
 		dentry = __d_lookup_rcu(parent, &nd->last, &nd->next_seq);
 		if (unlikely(!dentry)) {
@@ -1930,7 +1948,7 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		if (read_seqcount_retry(&parent->d_seq, nd->seq))
 			return ERR_PTR(-ECHILD);
 
-		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
+		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags, parent, &nd->last);
 		if (likely(status > 0))
 			return dentry;
 		if (!try_to_unlazy_next(nd, dentry))
@@ -1938,17 +1956,19 @@ static struct dentry *lookup_fast(struct nameidata *nd)
 		if (status == -ECHILD)
 			/* we'd been told to redo it in non-rcu mode */
 			status = d_revalidate(nd->inode, &nd->last,
-					      dentry, nd->flags);
+					      dentry, nd->flags, parent, &nd->last);
 	} else {
 		dentry = __d_lookup(parent, &nd->last);
 		if (unlikely(!dentry))
 			return NULL;
-		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags);
+		status = d_revalidate(nd->inode, &nd->last, dentry, nd->flags, parent, &nd->last);
 	}
 	if (unlikely(status <= 0)) {
 		if (!status)
 			d_invalidate(dentry);
 		dput(dentry);
+		if (status == -EAGAIN)
+			goto again;
 		return ERR_PTR(status);
 	}
 	return dentry;
@@ -1970,7 +1990,7 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 	if (IS_ERR(dentry))
 		return dentry;
 	if (unlikely(!d_in_lookup(dentry))) {
-		int error = d_revalidate(inode, name, dentry, flags);
+		int error = d_revalidate(inode, name, dentry, flags, dir, name);
 		if (unlikely(error <= 0)) {
 			if (!error) {
 				d_invalidate(dentry);
@@ -1978,6 +1998,8 @@ static struct dentry *__lookup_slow(const struct qstr *name,
 				goto again;
 			}
 			dput(dentry);
+			if (error == -EAGAIN)
+				goto again;
 			dentry = ERR_PTR(error);
 		}
 	} else {
@@ -3777,6 +3799,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		return ERR_PTR(-ENOENT);
 
 	file->f_mode &= ~FMODE_CREATED;
+again:
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
 		if (!dentry) {
@@ -3787,9 +3810,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (d_in_lookup(dentry))
 			break;
 
-		error = d_revalidate(dir_inode, &nd->last, dentry, nd->flags);
+		error = d_revalidate(dir_inode, &nd->last, dentry, nd->flags, dir, &nd->last);
 		if (likely(error > 0))
 			break;
+		if (error == -EAGAIN) {
+			dput(dentry);
+			goto again;
+		}
 		if (error)
 			goto out_dput;
 		d_invalidate(dentry);
-- 
2.47.1


