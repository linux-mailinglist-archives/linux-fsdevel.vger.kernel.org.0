Return-Path: <linux-fsdevel+bounces-56143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6A4B13F91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF4416A122
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33D5275115;
	Mon, 28 Jul 2025 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="20QB3gRp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4G6JHUlr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8FnOVFS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptqXrTPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFE274FCD
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718769; cv=none; b=kUD/oPdfuD3mRQa0VScK2+C/+KtpHVKbN0MI417W2AODsTpBr6wiqCKXFHK56sFVzdGsgUQvnmkXAqIZB8dkCOxfLe+5G/CX+3PQoyyRavkaUIGfCP08Em4mewT9RnVPKwVesDIwYLT9FB1RaIIiD+5F8m8KXh5b0WOcEVHgSa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718769; c=relaxed/simple;
	bh=Y99squC1LzVJTCQTh4K622e+Cu5xruc35J+xfvcqx/c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VxmiGR/MYsjRASDH+eJfoxe85gVUu5xaT6WgbJgoNmruoa62UOXIQILGow1q+AlFE1Ik1VOnyJd8APCA/kH6q//1H2D1w6MXSZg5IG20uZNgOuy4VcyLWR4I82Mmr6dHHkvCE7IVV262cNSE5oXhh/Z8e5l0qBlNk9xChmpeImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=20QB3gRp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4G6JHUlr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8FnOVFS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ptqXrTPM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFEB621279;
	Mon, 28 Jul 2025 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753718766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QWyVFtxuJDoMUG7/lNAigou/ZyMyhjGrZdOUNw8xLt8=;
	b=20QB3gRp53m4TnvFTLd+XW8pqodbRYLmQMG7swQ/IlidcFsGk75fpSjnwsoVtU59i6GC7w
	CbfOW+rn5nJKz8f7/nydhxIXYlYQog9JMaIcWpYJwRTMHRAWbLDYwB9v5HX8B1r/i33NoZ
	LDsnyqiN4dAz7lEO0hK074oxsN0AfDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753718766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QWyVFtxuJDoMUG7/lNAigou/ZyMyhjGrZdOUNw8xLt8=;
	b=4G6JHUlr+cvD2NpECCfU3MLKQwXH7RvvKAevDIzzKrkWuXoUyag4engXRnn9zfE/P7Bq+1
	LEqdUxc2Na4CmcBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753718765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QWyVFtxuJDoMUG7/lNAigou/ZyMyhjGrZdOUNw8xLt8=;
	b=v8FnOVFSuwOeBvAUaLxZzwDjc8mN+mCCEiR9Ajkgga1dWDAaZWXrkXl8iosmkNdJTqOLb6
	Ku2a6YSGMQLo1kPUhOoVr1g1wiqT7qpSXg5tI1ShZWcHrOk84udXMsuF+Xpz1uFWlFSXy5
	Csh0w8YwcHtJH0cBmnbi9rtIFU/wA2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753718765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=QWyVFtxuJDoMUG7/lNAigou/ZyMyhjGrZdOUNw8xLt8=;
	b=ptqXrTPML3Wbw8GTYa8DTzA19SafxmJ/eO0rPfvZ/Jheamit1QkVuAn77lSvR7p1YtBP1m
	gh93ErqHZwRfX0DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D72A11368A;
	Mon, 28 Jul 2025 16:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rxiCNO2fh2ioMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 28 Jul 2025 16:06:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80F62A09E7; Mon, 28 Jul 2025 18:06:05 +0200 (CEST)
Date: Mon, 28 Jul 2025 18:06:05 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] udf and ext2 changes for 6.17-rc1
Message-ID: <j2lhfj46lqjwmykrdpt4qww6flkjajtsssfijvysorpiv7m2h2@ctod32kzsy5y>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.17-rc1

to get a few udf and ext2 fixes and cleanups.

Top of the tree is 1a11201668e8. The full shortlog is:

Christoph Hellwig (1):
      udf: stop using write_cache_pages

Jan Kara (1):
      udf: Verify partition map count

Wei Gao (1):
      ext2: Handle fiemap on empty files to prevent EINVAL

The diffstat is

 fs/ext2/inode.c | 12 +++++++++++-
 fs/udf/inode.c  | 28 ++++++++++++++++------------
 fs/udf/super.c  | 13 +++++++++++--
 3 files changed, 38 insertions(+), 15 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

