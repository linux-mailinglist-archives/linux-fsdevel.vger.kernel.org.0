Return-Path: <linux-fsdevel+bounces-42196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE303A3E8D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431DF3BF310
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF87268C78;
	Thu, 20 Feb 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fAnJmkUi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8wyPm5Ha";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fAnJmkUi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8wyPm5Ha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40242267B79
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095243; cv=none; b=LLn4XZSKLRtYerDf+bUf6dSqWDdY/0q55/7y6wNN/oHfIPX7dsS5iay5T5FJU4j4E7gffGedQEA+zpig6XAJMaAqMiUvGHrMSUjB4bEVjZ0Eb4t9L8Q/aH/Y+ycLqL6BKjtFglxrZihMqOoATMgdoav+v93ANdYt2eb3aqhhtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095243; c=relaxed/simple;
	bh=w8j9NCIPMxa9VdEOwDdQGiCk3OEfujoYyM5nNBepi3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey7/V0h/kXor+otUmuYlPZ69cb6dIYiwbE3yIe9SDFstMafj61zPyqJo9Czx7Nr85k8lNR+cfOqXZmqnYyw8+3Twmmaum7kPw6KxnRCgyVk97VkeAHT7BqLLz6ER7oDOmU35sr0mIt5Es1mfCFNwgU7XRrslqlAASentJUgu/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fAnJmkUi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8wyPm5Ha; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fAnJmkUi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8wyPm5Ha; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47B6C21193;
	Thu, 20 Feb 2025 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=fAnJmkUiRBLf9T8Gc6/VkmKEIvWQU98UxDilOFtsaIq6ALZLsXpC71p5TiFfY/wDLlGE6U
	9KhDZYIVRqEHv70nB6mSUWJFRAY4vpG/XTYV9LYkzKhaOl9j0AS2Ptj7+T1NUCePgAr+C2
	k5wn/0mncmYgpwWXZJcpmvEl0rOxS/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=8wyPm5HalY3T2xTNgJwrL9khVs8CjsoixgSP9yNucBoog4ot4uNU1F18b0KbeNwzZU8vVb
	iSEQjbpZo05SfJCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=fAnJmkUiRBLf9T8Gc6/VkmKEIvWQU98UxDilOFtsaIq6ALZLsXpC71p5TiFfY/wDLlGE6U
	9KhDZYIVRqEHv70nB6mSUWJFRAY4vpG/XTYV9LYkzKhaOl9j0AS2Ptj7+T1NUCePgAr+C2
	k5wn/0mncmYgpwWXZJcpmvEl0rOxS/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K365lrHE4tT4tHcA+ZRmIzk529KAE57axlSUnXIkK90=;
	b=8wyPm5HalY3T2xTNgJwrL9khVs8CjsoixgSP9yNucBoog4ot4uNU1F18b0KbeNwzZU8vVb
	iSEQjbpZo05SfJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2B3913301;
	Thu, 20 Feb 2025 23:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MWYQJv++t2cbAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:47:11 +0000
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
Subject: [PATCH 2/6] hostfs: store inode in dentry after mkdir if possible.
Date: Fri, 21 Feb 2025 10:36:31 +1100
Message-ID: <20250220234630.983190-3-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.960];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,szeredi.hu,redhat.com,gmail.com,nod.at,cambridgegreys.com,sipsolutions.net,oracle.com,talpey.com,chromium.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.79
X-Spam-Flag: NO

After handling a mkdir, get the inode for the name and use
d_splice_alias() to store the correct dentry in the dcache.

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
2.47.1


