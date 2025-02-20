Return-Path: <linux-fsdevel+bounces-42194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394AA3E8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 00:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A47D7A702E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 23:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4E267B03;
	Thu, 20 Feb 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rrngyKDT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7cAjpZsq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dBnjMwlA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ywLnnzUG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390B1F1934
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095217; cv=none; b=hhuXChZJGwegNQo3bjM7Lq2/6yj4vKRqgI7gvq+pd06TXGUao9bXCuRI5ivDeAcJATbW61A2z3pOPe2IWGTnKubkvdEP5DAWIDPMRCkA+CM5b+lSTAUGpDXboCtiIwt6aqT5ye6feTcxOjb0plNSmBmlAO9HHCSvFXKe5B5Fvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095217; c=relaxed/simple;
	bh=eWd5HI0vsvP8HxPzVasSu9I8QttKgdYd+/RmF+FUhfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAJHiUbA0gV5nBCGllY1Id7GSVBzm7aVtUquMXz+kfT5mb5Lep9Gk6s3OT7WYmSY/9LSHwp+WtQbULsZDTj2kuSS3Ygr0o50xNLZJskz6PFdqC0meqg+LIv63hjgyytSCjbA8HTPf7yZZ5DFuTBZGx+SKIzNciTpItRfNzflKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rrngyKDT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7cAjpZsq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dBnjMwlA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ywLnnzUG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA8BC2118F;
	Thu, 20 Feb 2025 23:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095214; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NKmjAFBT7eSImzI2Bx6YtHkPCpS652+riXhLoV4+ieA=;
	b=rrngyKDTIuVUlFfElLWo7EhzXkEtalhEyykIKpJMYDFXIgHMC40fjWd7PAGLhVU9Q0kGBd
	FInwcvn3bFD97Pkh9vJbEGjgepUrs756C19rVt0qbdeMfolM5/h3OdCGV2688S9WlYFVET
	pwEr+yvuQn8Eiwsq0z4Dx+u0fCjOHrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095214;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NKmjAFBT7eSImzI2Bx6YtHkPCpS652+riXhLoV4+ieA=;
	b=7cAjpZsquc/3J3Xjl/gvkGvsoco+0TIJPIX2X9Uq29Q8/arLiv7r3qTk5CJSKRugXjOB9F
	/l5qQU3ayirmD/AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dBnjMwlA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ywLnnzUG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740095212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NKmjAFBT7eSImzI2Bx6YtHkPCpS652+riXhLoV4+ieA=;
	b=dBnjMwlAct0U3lEFzWEOOKSD+aGq6HdY4tK4XOlKziuZX8ECWwgJ5RlGxjK28sO2a1TfC5
	pu4zrPTuSCYbCuAJm4DEFUeiQ4ft8//oGa5imuR3g33yodtMUcZsUhBErCa9CrNkaCrbwm
	r+UDoSLT4Mi5KMAF8BQla1598Prgwt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740095212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NKmjAFBT7eSImzI2Bx6YtHkPCpS652+riXhLoV4+ieA=;
	b=ywLnnzUGae02JEL6IHG/zhEGMHmegAa7EKCPR2yFjqpGzupyG1sbSTo0V4EboTO/RaUzKp
	w7whJyxUsDr+yxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58C6913301;
	Thu, 20 Feb 2025 23:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 07ZuBOW+t2f+AgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 20 Feb 2025 23:46:45 +0000
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
Subject: [PATCH 0/6] Change ->mkdir() and vfs_mkdir() to return a dentry.
Date: Fri, 21 Feb 2025 10:36:29 +1100
Message-ID: <20250220234630.983190-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA8BC2118F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

I'm posting this to a wider audience now as I think it is close to its final form.
I have not included every fs maintainer explicitly (though this patch touches every writable FS)
but hope that fsdevel will catch enough of those).  I have included the affected clients
of vfs_mkdir: nfsd, smb/server, cachefiles, and the filesystems with non-trivial changes:
nfs, cephfs, hostfs, fuse.

mkdir is unique among object creation interfaces as there can only be
one dentry for an directory inode.  There is a possibilty of races which
could result in the inode created by mkdir already having a dentry when
mkdir comes to attach one.  To cope with this, three users of
vfs_mkdir() sometimes do a lookup to find the correct dentry when the
one that was passed in wasn't used.  This lookup is clumsy and racy.

This patch set changes mkdir interface so that the filesystem can
provide the correct dentry.  Some times this still requires a look-up
which can be racey, but having the filesystem do it limits this to only
when it is absolutely necessary.

So this series changes ->mkdir and vfs_mkdir() to allow a dentry to be
returned, changes a few filesystems to actually return a dentry
sometimes, and changes the callers of vfs_mkdir() to use the returned dentry.

I think it best if this could all land through the VFS tree as ask maitainers of:
 cachefiles nfsd smb/server
 hostfs ceph nfs fuse
to provide a Reviewed-by.

Thanks,
NeilBrown



