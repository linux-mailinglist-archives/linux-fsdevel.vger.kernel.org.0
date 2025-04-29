Return-Path: <linux-fsdevel+bounces-47634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530DAA18CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 20:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD72981003
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86262512E8;
	Tue, 29 Apr 2025 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zdaNBtlQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXZblfzu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJ+gSA07";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JZy5hU6w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51B2AE96
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949539; cv=none; b=HOnIip+1vXdo6rhvv1s16x5G5UY+x23aE0/3MCuijhlYOufHfSd1ZaSwXgOG5+UuE9IT3GD0zPWWv9MetxStyEguaRody+buGqzYscfXm6WbMGXVsUHqlqsa7lZqO2a+XhnmuKjReKSRjAS0DsrSqBISVz1RhksbDjEvXEBPXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949539; c=relaxed/simple;
	bh=8Nc5nL9c+ckls2EpiubRQ6QidGjLzN+zk3NfRnFpb7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n5l0jQ3FFgNY2KJUy1px/3Vh9/xVYul2xU5Jwi6nU72tsiaJlAn0cySsxwqVdbxkt9Gu9mgLvilYpWOzoAowt1a3Cc4QIwA/KTanzipf0Y+RCqYcVMstarRZxC1yIiZbdQzE8umbaGfUKayrtYhU23hhx/Mu5P0trI37KbjtvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zdaNBtlQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXZblfzu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJ+gSA07; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JZy5hU6w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E92DC2119C;
	Tue, 29 Apr 2025 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745949536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eFPdsJpqbp/DjVdu0ygy1OZB8JCsRf5QcYxR5t6P/yg=;
	b=zdaNBtlQU/tcfPbI9FzodTHJByX+XW3kUxXms90JShAfvYBHGzMjLuVWeqp0r3a4PeUU3O
	xBino2eI0fJKZynnUEb9YFhbmewmiqWjIThPFqoU3R2AVKSKeTwAxFDREEYe3WcU2W0wiH
	0SwqrduODmOIgBqUVnJrGQnOcclJfF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745949536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eFPdsJpqbp/DjVdu0ygy1OZB8JCsRf5QcYxR5t6P/yg=;
	b=bXZblfzuhLW25YrtkEgvFhIN1RB03dza13zv0+aces3IbNo70Y+Ebes3rfUWVMjw7r2VBp
	gnP8M/qdX4SmbGDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zJ+gSA07;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JZy5hU6w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745949535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eFPdsJpqbp/DjVdu0ygy1OZB8JCsRf5QcYxR5t6P/yg=;
	b=zJ+gSA079XM1YLlA7PZJUkcM1aBeYgEQxrJrqJH3hxN9JqfS4zpm8Ya+lQAzK4w/d7IYGn
	+1bfUVYEkfjZLPR/4xA056rD5/kjsMtE6lcZ8DLz+BiOCEhxO7fAMkClAp4wXQYfFEuHDL
	qkJuhOTadgkJBhL9XzjJb8IpwHXVwic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745949535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=eFPdsJpqbp/DjVdu0ygy1OZB8JCsRf5QcYxR5t6P/yg=;
	b=JZy5hU6wxidsVLr2MlnAKN7zQl1V1Y8k/rTvtXMwY4fpxYxsJ0S7ptyYOJOjvCjSbTgrvi
	Qop42W4P5In4jQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C87331340C;
	Tue, 29 Apr 2025 17:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jv+gMF8TEWiROAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 17:58:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 74610A0952; Tue, 29 Apr 2025 19:58:50 +0200 (CEST)
Date: Tue, 29 Apr 2025 19:58:50 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 6.15-rc5
Message-ID: <ft5yy3ybidt6qu6udj6votzl4danrptyfush55ylt5f6qu76pz@saecmj4jv7ez>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: E92DC2119C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.15-rc5

to get a fix for recently merged mount notification support.

Top of the tree is cd188e9ef80f. The full shortlog is:

Amir Goldstein (2):
      fanotify: fix flush of mntns marks
      selftests/fs/mount-notify: test also remove/flush of mntns marks

The diffstat is

 fs/notify/fanotify/fanotify_user.c                 |  7 +--
 include/linux/fsnotify_backend.h                   | 15 ------
 .../filesystems/mount-notify/mount-notify_test.c   | 57 +++++++++++++++++-----
 3 files changed, 47 insertions(+), 32 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

