Return-Path: <linux-fsdevel+bounces-39781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69114A18032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 15:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270FE18834AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3779C1F3D5A;
	Tue, 21 Jan 2025 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yUUpil+9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZSnh1cw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fSJK+ILC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMY9CG6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C441F192A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470667; cv=none; b=iildglp+lEfdh+3e6F461N3LM/jhftvmNveCDLfftlPZ5uu05daMYWcz4r1qU6kYPj0arn8qZj4YCMy2oCdXxJFm5qfRDWn+PqIouZyFQKij4LAJp9iq2oMB2d4CVL1+qO+w2m7XFB3HCNT6kwS5NUEAj+O1ltPRv48krxBKsfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470667; c=relaxed/simple;
	bh=Y/W/wC+aSTN6X5jKPps/0LXDDXJUgzf6Cg6uCMxw4iU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jC/SNQv6xWv3WYGufgi15siudAgx1rufgov4xr8XLXmRA8N8fkC6qdmtir0Z+MmpW2kvmwji5DsR11EvRogLlspDstQzZgcf8O5l8K81g47thVzGEYFJ7LVz5cMBrPsCB6Dh/oAANL0fqNh3snxXsQIpnveItXudNj8cNR0m0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yUUpil+9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZSnh1cw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fSJK+ILC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMY9CG6k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBA171F385;
	Tue, 21 Jan 2025 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737470664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g9edaOSvyXwNbr7/0DoRTsZlNZ/Sjqk85Ja4kGqKt5c=;
	b=yUUpil+9VluCJPyO0lp2QDjKYywuDejQ/Dz4BZk/z1Q6yTbDjp5b5cUQjtMvTnOLpWuyr9
	AfJeVGOZcmKu4qCijEaNTMwhgB5eTGMuy2TSaWr8dljldHU5v+dJM723blZLK2N6LgqGAk
	hgSflbhNQl5USz2azmqCbfTWkngYfa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737470664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g9edaOSvyXwNbr7/0DoRTsZlNZ/Sjqk85Ja4kGqKt5c=;
	b=sZSnh1cwdKe7ukm7/mUhTAyz2TBId4+zB0HF2vA7B4NSGkgq6+WbyQNEmgPeuFgawLl9a8
	tw5hnC6fnBw9XBDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fSJK+ILC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hMY9CG6k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737470663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g9edaOSvyXwNbr7/0DoRTsZlNZ/Sjqk85Ja4kGqKt5c=;
	b=fSJK+ILCgv5NMbXNdYFx+f/Gtx8SpA8uBqDCRvW1rDETQNAkeDr7OIiLVax4ND52NfFY8O
	Ir/uEa02hlXVKKe/xfO3npU7uvpTXddEyI0yzY206fiKnVbKwB4p5hSderHgr4iwOezzZi
	IQDBu8IkmhoqHH93HlrikLTE9D8m5YE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737470663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=g9edaOSvyXwNbr7/0DoRTsZlNZ/Sjqk85Ja4kGqKt5c=;
	b=hMY9CG6kfjSYlzROnhkpn3w02ftqM1SOSkx4RTmZXytddZRR2LcnbyAas3Ij8Bi2vq5894
	690LcDv8OG+EQmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE4AC1387C;
	Tue, 21 Jan 2025 14:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FQ4WMseyj2f1XwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 14:44:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D59EA0889; Tue, 21 Jan 2025 15:44:08 +0100 (CET)
Date: Tue, 21 Jan 2025 15:44:08 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify cleanup for 6.14-rc1
Message-ID: <iriegksewmptjm4skpp2qdzkvfwlszxnqsl5potoscmzhhm6io@qgj5gxixbip6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: DBA171F385
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc1

to get small inotify strcpy() cleanup.

Top of the tree is b8f2688258f8. The full shortlog is:

Kees Cook (1):
      inotify: Use strscpy() for event->name copies

The diffstat is

 fs/notify/inotify/inotify_fsnotify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

