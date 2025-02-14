Return-Path: <linux-fsdevel+bounces-41699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A33A35625
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A39D188F195
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861041891AA;
	Fri, 14 Feb 2025 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ETNjGuhC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2dDYfl92";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ETNjGuhC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2dDYfl92"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8C10E3;
	Fri, 14 Feb 2025 05:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510542; cv=none; b=lzyvwR3jxQCgn+/DaoJ3z1yizTVKQLZaRLM/OkmdSgDavG/2gm9+T6gxyYQlcr62jMWepLcxK5T0vlGFpZQpaOUoR2MVS0MsebdaNglbcZhL+53G+I5YnZqftLXG0/ZsgLmc182QwYlZjnPBcyfmE/ug2noHeWW16bnUxiKoQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510542; c=relaxed/simple;
	bh=MxkdJ90Iqh4DQXUeoRo1abFmYX/npagqzlJZFK+UH5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+DHNo7dsk8kR5rx4R1/bDmpv5gHfBg780do+l8qS5pI/aLknWZIqb7C+kjAJgoJ3PFRfMXy0E4m97RcZ8TESUzHskxS/gFirxYbF1VXZmNPFT/MKTxOw1nkNEsRelLdsDT89x5RG2edU8mT+R6cfRi7zrcw6e5QuNF3WXkSoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ETNjGuhC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2dDYfl92; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ETNjGuhC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2dDYfl92; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42FEC21D99;
	Fri, 14 Feb 2025 05:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Se1NJgBRg4wR+l6zjugi1FA3+2X/SshKuOdpcAtFEec=;
	b=ETNjGuhCSQOf0bQx9BC41DgjJNXTyj4Up8iqhDte5n8bpl4Lqqfp2I5hC4ZjiGh2UtaKLQ
	Cnz9P1vTPc9O8DMSTd1Eldoe/qrG+8nB2DaORXeYV/+UqQV9E3eJEHXIEVy2kLGmX9UV0K
	0KOSaR8DzLRzv9lfJj1FSY2LZtkN4Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Se1NJgBRg4wR+l6zjugi1FA3+2X/SshKuOdpcAtFEec=;
	b=2dDYfl92N+/6Zchd6/4cnZgXpZxCa3XdipxxqbpTqPYrYRnkG5lx/3b1NTdYS2xLtGSsd9
	2tB7OV1KCgg0FQDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739510538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Se1NJgBRg4wR+l6zjugi1FA3+2X/SshKuOdpcAtFEec=;
	b=ETNjGuhCSQOf0bQx9BC41DgjJNXTyj4Up8iqhDte5n8bpl4Lqqfp2I5hC4ZjiGh2UtaKLQ
	Cnz9P1vTPc9O8DMSTd1Eldoe/qrG+8nB2DaORXeYV/+UqQV9E3eJEHXIEVy2kLGmX9UV0K
	0KOSaR8DzLRzv9lfJj1FSY2LZtkN4Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739510538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Se1NJgBRg4wR+l6zjugi1FA3+2X/SshKuOdpcAtFEec=;
	b=2dDYfl92N+/6Zchd6/4cnZgXpZxCa3XdipxxqbpTqPYrYRnkG5lx/3b1NTdYS2xLtGSsd9
	2tB7OV1KCgg0FQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DADA2137DB;
	Fri, 14 Feb 2025 05:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7aAIwfTrmcubwAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 14 Feb 2025 05:22:15 +0000
From: NeilBrown <neilb@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3} Change ->mkdir() and vfs_mkdir() to return a dentry
Date: Fri, 14 Feb 2025 16:16:40 +1100
Message-ID: <20250214052204.3105610-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is a small set of patches which are needed before we can make the
locking on directory operations more fine grained.  I think they are
useful even if we don't go that direction.

Some callers of vfs_mkdir() need to operation on the resulting directory
but cannot be guaranteed that the dentry will be hashed and positive on
success - another dentry might have been used.

This patch changes ->mkdir to return a dentry, changes NFS in particular
to return the correct dentry (I believe it is the only filesystem to
possibly not use the given dentry), and changes vfs_mkdir() to return
that dentry, removing the look that a few callers currently need.

I have not Cc: the developers of all the individual filesystems - only
NFS.  I have build-tested all the changes except hostfs.  I can email
them explicitly if/when this is otherwise acceptable.  If anyone sees
this on fs-devel and wants to provide a pre-emptive ack I will collect
those and avoid further posting for those fs.

Thanks,
NeilBrown


