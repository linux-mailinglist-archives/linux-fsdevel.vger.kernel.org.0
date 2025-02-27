Return-Path: <linux-fsdevel+bounces-42736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BDA4718D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 02:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E3D3B6762
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 01:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C4187FE4;
	Thu, 27 Feb 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0smYf138";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ph+gqGLX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0smYf138";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ph+gqGLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C706136351
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620429; cv=none; b=Qc+kungW3bqzlWt8EZPOln91blmhVkBcMv+IM8h5dzBxqX7FbKUt0tPBDn4rKE2Z3GdH0VYStYB6LdD95XtrlV7e3DNxNuxpEBYiWTvhJKXeaGWZhPFkROy2hD88rHtbt2ju4+cLMl6lHyD0mPDBbwZfdHBPV/CHuTH2/JwaFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620429; c=relaxed/simple;
	bh=Go2Tewb8oCKA1oMlkXRsL012P4o628YP/IyJqbqyiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9fiWJvrEiEfxtAVLo9Fj8cL1Uw22UTEkXaO/XKJjX3zSMYCRKz4Kygu8Dn08pt61KXqCNlOH2DPzdKA4gKY3hDoCQ1qEPlnhDaXWqqzz8tvikmSgyhWcFhC3U4jCpRWt57dsrCHfj2o3aq/yOT0GXXeMEH5x4Fgv+Unk8i4d9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0smYf138; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ph+gqGLX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0smYf138; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ph+gqGLX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A591B21188;
	Thu, 27 Feb 2025 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=0smYf138evtmQey7lvWmcSypB90NSA8pg5W/w1cZrilHbcpbS2A3+5ypYLYNuX8sWw4jyN
	AQXecmS00TM2jOWhJnm1CupwJu2MHt3/dOCGHbI/ficuARObyn5J6jaSHTHDs9hajeW3qW
	YUNKeUHoNyh8EOCsgxmh/KjYL6WyZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=ph+gqGLXF9n86ymjIAt7BBlGle/4PObvqqCoK8orUAYdbpoGieLXtFz1akAGyfAXtY3V0l
	WX7TYrRYqj4Ib+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740620425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=0smYf138evtmQey7lvWmcSypB90NSA8pg5W/w1cZrilHbcpbS2A3+5ypYLYNuX8sWw4jyN
	AQXecmS00TM2jOWhJnm1CupwJu2MHt3/dOCGHbI/ficuARObyn5J6jaSHTHDs9hajeW3qW
	YUNKeUHoNyh8EOCsgxmh/KjYL6WyZQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740620425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SWbm5loCzvI/QsJmTpfmwEStE1pMp3YcCFFrGykTpw=;
	b=ph+gqGLXF9n86ymjIAt7BBlGle/4PObvqqCoK8orUAYdbpoGieLXtFz1akAGyfAXtY3V0l
	WX7TYrRYqj4Ib+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96024134A0;
	Thu, 27 Feb 2025 01:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OB1zEoPCv2fhEQAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 27 Feb 2025 01:40:19 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
Date: Thu, 27 Feb 2025 12:32:54 +1100
Message-ID: <20250227013949.536172-3-neilb@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227013949.536172-1-neilb@suse.de>
References: <20250227013949.536172-1-neilb@suse.de>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,szeredi.hu,nod.at,cambridgegreys.com,sipsolutions.net,lists.infradead.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

After handling a mkdir, get the inode for the name and use
d_splice_alias() to store the correct dentry in the dcache.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/hostfs/hostfs_kern.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index ccbb48fe830d..a2c6b9051c5b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -682,14 +682,22 @@ static int hostfs_symlink(struct mnt_idmap *idmap, struct inode *ino,
 static struct dentry *hostfs_mkdir(struct mnt_idmap *idmap, struct inode *ino,
 				   struct dentry *dentry, umode_t mode)
 {
+	struct inode *inode;
 	char *file;
 	int err;
 
 	if ((file = dentry_name(dentry)) == NULL)
 		return ERR_PTR(-ENOMEM);
 	err = do_mkdir(file, mode);
+	if (err) {
+		dentry = ERR_PTR(err);
+	} else {
+		inode = hostfs_iget(dentry->d_sb, file);
+		d_drop(dentry);
+		dentry = d_splice_alias(inode, dentry);
+	}
 	__putname(file);
-	return ERR_PTR(err);
+	return dentry;
 }
 
 static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
-- 
2.48.1


