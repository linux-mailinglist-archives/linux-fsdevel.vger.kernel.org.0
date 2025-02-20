Return-Path: <linux-fsdevel+bounces-42197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD9A3E8D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F1019C5A7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3815826A09A;
	Thu, 20 Feb 2025 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FOA9d4pN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CElbpe/k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FOA9d4pN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CElbpe/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7B267B00
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095265; cv=none; b=cmha/23/apiSfzIzXfyfu7EE+CkQusbHIhDwsUB4NspahqEgUiGNAn1lO0xVT24tuA+52nXNmmbb0F6NlQWbXVkm5iC3QBR6lxcuFr4CVLk/TwYRIsXTGKLDu2BSem4cRnoL//VBvgJ1BLBEmlgT05PZjv8RJSci/t3To7rXT1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095265; c=relaxed/simple;
	bh=x2SIt9ND6ULrhwzk9rJ49eRCnjOJLyCayfqwUU5/xnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8QQHUdgkaYJydIHcfPcFF/v653tocd/y1l+xun221QgrqvKQPNy6ozpU+XDeBuj5S6X79NkDRf/hGnSbKxQKf6Y2v9U/x+Avha7i8hTMqbAFovBzzTaR9l/msl+XqluL3P9J7lwVObP3oMCDa0Jmhm6Em6h1xQkieoZHC1yTNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FOA9d4pN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CElbpe/k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FOA9d4pN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CElbpe/k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B70761F390;
	Thu, 20 Feb 2025 23:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoUEZE9gdd4nSK2AHL7We1oeRMUiSMAlbOSJdILwOp4=;
	b=FOA9d4pNDzEP/9E8FSFcKR/sifQe7eWkW1qUq6HxWFui0ud88gxTOyoNuRKrYkcSB+UrfH
	1Zozlc+/fblLw+4jCHXJIwkxYm2hGy2Tzo+FypSxNRHxFhWrIxOpmOmwVZ6Uh1f7svVaCC
	+srBY8b6HJ6pg3d0PnPJXtUpTAq1VHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoUEZE9gdd4nSK2AHL7We1oeRMUiSMAlbOSJdILwOp4=;
	b=CElbpe/kE3VPzDV5a0Sf7TSgt/tH6PQyHjUoUYal00s9LlXgDr8EiDgzeTDK8DA80seRb6
	roA4DZFcZ0+NcsCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FOA9d4pN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="CElbpe/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoUEZE9gdd4nSK2AHL7We1oeRMUiSMAlbOSJdILwOp4=;
	b=FOA9d4pNDzEP/9E8FSFcKR/sifQe7eWkW1qUq6HxWFui0ud88gxTOyoNuRKrYkcSB+UrfH
	1Zozlc+/fblLw+4jCHXJIwkxYm2hGy2Tzo+FypSxNRHxFhWrIxOpmOmwVZ6Uh1f7svVaCC
	+srBY8b6HJ6pg3d0PnPJXtUpTAq1VHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoUEZE9gdd4nSK2AHL7We1oeRMUiSMAlbOSJdILwOp4=;
	b=CElbpe/kE3VPzDV5a0Sf7TSgt/tH6PQyHjUoUYal00s9LlXgDr8EiDgzeTDK8DA80seRb6
	roA4DZFcZ0+NcsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EFE313301;
	Thu, 20 Feb 2025 23:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cwgABhW/t2coAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:47:33 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	netfs@lists.linux.dev
Subject: [PATCH 3/6] ceph: return the correct dentry on mkdir
Date: Fri, 21 Feb 2025 10:36:32 +1100
Message-ID: <20250220234630.983190-4-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220234630.983190-1-neilb@suse.de>
References: <20250220234630.983190-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B70761F390
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn),to_ip_from(RL41gfrsx5ox46amq79i8sk6fy)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

ceph already splices the correct dentry (in splice_dentry()) from the
result of mkdir but does nothing more with it.

Now that ->mkdir can return a dentry, return the correct dentry.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/ceph/dir.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 39e0f240de06..c1a1c168bb27 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1099,6 +1099,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_mds_request *req;
 	struct ceph_acl_sec_ctx as_ctx = {};
+	struct dentry *ret = NULL;
 	int err;
 	int op;
 
@@ -1166,14 +1167,20 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
 out_req:
+	if (!err && req->r_dentry != dentry)
+		/* Some other dentry was spliced in */
+		ret = dget(req->r_dentry);
 	ceph_mdsc_put_request(req);
 out:
 	if (!err)
+		/* Should this use 'ret' ?? */
 		ceph_init_inode_acls(d_inode(dentry), &as_ctx);
 	else
 		d_drop(dentry);
 	ceph_release_acl_sec_ctx(&as_ctx);
-	return ERR_PTR(err);
+	if (err)
+		return ERR_PTR(err);
+	return ret;
 }
 
 static int ceph_link(struct dentry *old_dentry, struct inode *dir,
-- 
2.47.1


