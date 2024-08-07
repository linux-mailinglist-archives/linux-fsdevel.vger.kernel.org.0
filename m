Return-Path: <linux-fsdevel+bounces-25344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45EC94AFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7BF81C21AEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527971442FE;
	Wed,  7 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y6suBkP9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FqWmWCTr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyZQmRVj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qL9AIGV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4BD13FD86
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055410; cv=none; b=FyRu9P6r9zhJlQdprpdNrOoaGCazbi/1VWMdnBxakrfIdo97Czi3oXl/xdkO3IbnyhRgpoRy+L7ZS+6mqHvosvGnzg/cPCCCGVbSMGUSxtu2E5KGhvynTsv5msJ8QTM8AJiA3ofS2AIGQlWlpAR5oyJB0dFy9JQpKX3Rzwxcot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055410; c=relaxed/simple;
	bh=vnTivuYbvkOsdMt+eymjyBgi3CWQtuVU4gGetco1x1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o9J9K141haB7aLUucYkZSMAAMIfmUVNDVI1v1JrdWbw7kShRf2/U64uPrGxsidcfGXm/p1a35VGpmP1Kx57aRW+9o1mo+JX49+glzczW5u4UGyFCkpxKx6MsXqOaoX0cG+CxNj4cwQwAuMQMuYZHbitKBivB86KKLioMEDOQveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y6suBkP9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FqWmWCTr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyZQmRVj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qL9AIGV3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 189071FB9A;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f29OTYnCgSYfzrpoPjh3jY3P4l0tMkF/OXMZ05VfvBI=;
	b=y6suBkP9SpAV54+5HTNEITlZOLe7Xuz1WqMta16zS5P57arSvTi9AOrFSUFyohAw51Tz13
	lz2w2BbifSvbE9YVoH9aEbE/5TYBPcLPKCHI49KBeqlG3aZjcZGz/ZAOjl1JXhDdJUJ9z7
	St35+qLReSOD85JnMHPWr7EdFruJ7mQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f29OTYnCgSYfzrpoPjh3jY3P4l0tMkF/OXMZ05VfvBI=;
	b=FqWmWCTr6TehxkCnfptVKtwx2SlheBF7FQYsqicgp8oNS4MEKC3eo//C3c/+QrTI3qG9+d
	3/HORceXxGUKH2DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WyZQmRVj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qL9AIGV3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f29OTYnCgSYfzrpoPjh3jY3P4l0tMkF/OXMZ05VfvBI=;
	b=WyZQmRVjqIKZlaBVoZAH9l9oPsRP2rI3z57JY+ztKFUHVuOI/gyGaHsA++d6eQiVg0o9Wz
	9BwzrmJq+47zNBXTZLoptVEncM5DPSK26q5R7Yr+4wYQasCl0tGyJ6xK3HW2Pwem+4MlM2
	ruSh9knSZQ8zSY6LPpWQfQMpEze227c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f29OTYnCgSYfzrpoPjh3jY3P4l0tMkF/OXMZ05VfvBI=;
	b=qL9AIGV38xi6MtEfpX0IEt32bGZlGVVltJe8GlbMgT+mokRy20egP6vPTgqFnoQbgo3JxX
	1SQAUFYLHl1YY9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0919213B05;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4pk3Aiy9s2ZoNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9E116A0851; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/13] fs: Convert fs_context use of SB_I_ flags to new constants
Date: Wed,  7 Aug 2024 20:29:47 +0200
Message-Id: <20240807183003.23562-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1526; i=jack@suse.cz; h=from:subject; bh=vnTivuYbvkOsdMt+eymjyBgi3CWQtuVU4gGetco1x1s=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70b+DxOvVMTSkPz+/cJWzQihyLlOohnwIG3SORq o7sQ56aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9GwAKCRCcnaoHP2RA2QQ0B/ wNMYKTyXVaZ/taNdcDr97HtuOF43wbrVlg7Noeo9CBnDkNZA8WgN5cEYV8hI6ArLnX9F41Ce3s0ZVt EJofLJGAimVQkosXLDkmPqjeyQPbbD69cgUTqPUZ5m3AN/RSj+zFGivT3kRlU0y/WEiq3TYGkdx5gN 3kixK2zYgQ/KsIj6VssmR4j4RIm9f+DIFBxPtyqzJWwpqPCOASXop42gU/OUodBgVokqmifKYP8dep 5mSxDnYOmhRqbm6a0LhIffUZOJ0HGHlACooUqm+nX+tFrwTbkvpzr+tjY9wbcpmN8nfD8ZsLmVIabb pLF6wEcH94KIgQWuosOOhPIwPOgb4T
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 189071FB9A
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.01

Convert uses of SB_I_ constants in fc->s_iflags to the new bit
constants. No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c        | 2 +-
 fs/aio.c            | 2 +-
 fs/nfs/fs_context.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c5507b6f63b8..c1ea2aeb93dd 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -373,7 +373,7 @@ static int bd_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, BDEVFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
-	fc->s_iflags |= SB_I_CGROUPWB;
+	fc->s_iflags |= 1 << _SB_I_CGROUPWB;
 	ctx->ops = &bdev_sops;
 	return 0;
 }
diff --git a/fs/aio.c b/fs/aio.c
index 6066f64967b3..63ce0736c3a3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -279,7 +279,7 @@ static int aio_init_fs_context(struct fs_context *fc)
 {
 	if (!init_pseudo(fc, AIO_RING_MAGIC))
 		return -ENOMEM;
-	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= 1 << _SB_I_NOEXEC;
 	return 0;
 }
 
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 6c9f3f6645dd..2fbae7e2b6ce 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1643,7 +1643,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->xprtsec.cert_serial	= TLS_NO_CERT;
 		ctx->xprtsec.privkey_serial	= TLS_NO_PRIVKEY;
 
-		fc->s_iflags		|= SB_I_STABLE_WRITES;
+		fc->s_iflags		|= 1 << _SB_I_STABLE_WRITES;
 	}
 	fc->fs_private = ctx;
 	fc->ops = &nfs_fs_context_ops;
-- 
2.35.3


