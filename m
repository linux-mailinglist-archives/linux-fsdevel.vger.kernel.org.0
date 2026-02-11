Return-Path: <linux-fsdevel+bounces-76937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPGIJiZtjGlmngAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:51:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7323123F64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD6EE300516E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5C330C606;
	Wed, 11 Feb 2026 11:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQWLralM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v4nUOF6i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQWLralM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v4nUOF6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02930EF86
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810656; cv=none; b=LPARyS0kYpGXuQBMHVXu1aDVMg4hffaPZP5xvHZR7hKx9uRJtkjOeorb3wq3bunesXyHtJo3g/de9Zy9I4rRJaI1MwJ7H1iH2MZPe2YoLg90fIahD5yX/mdYsI3UJszDivvhI3mj1kAGgSneuOjsVglWKmy4vDjXoXZ+FK2oo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810656; c=relaxed/simple;
	bh=YaAwCxBeWYkOUghHCsX/3S5ZqJJx4qPZ8ruPMRcmDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f1sFxC7u3LsanLTjRxR0KApB/8mJvyDL5OTUr6iXwYKI9d6CMWRA510Br/uOo+nQQlXZfSlXwaoSkXBjQjKpX+F/mrCJZuXOgLCOCSxKv4mliLXi1ndva5LfwD6X4aYfSiFtT3vg/bO/oTYzTsrfsUqH6hM5rlmkmhLhrIAknbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQWLralM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v4nUOF6i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQWLralM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v4nUOF6i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 904875BCC6;
	Wed, 11 Feb 2026 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770810653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MIkMrld6sqBD4vHcBDLpHHGMllBPgSwjupGXHeNuA3c=;
	b=DQWLralM9xCj/pju1OVdOL8ZbYij/QNzfmyjUzQlHHmTuklwcYKAVQgiwVUB3vinQ462Q/
	OYP0Vu0GfH5GESr2xbQV3W5Ko6GUFhSpRnEUaPjCUpG0Rw3/CUYEM9k7cqCwhZL8Fb6nRT
	pC7TUpYGyDsjqcWXxIcmC7PUlqHrYyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770810653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MIkMrld6sqBD4vHcBDLpHHGMllBPgSwjupGXHeNuA3c=;
	b=v4nUOF6ixkOUQt31Ss5RslAoxIc/EeGVBuL5dtjKY3gBDwzhX8znHZ4rZroogKSOlOL3xx
	8qaJfzmHbnLzl5Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770810653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MIkMrld6sqBD4vHcBDLpHHGMllBPgSwjupGXHeNuA3c=;
	b=DQWLralM9xCj/pju1OVdOL8ZbYij/QNzfmyjUzQlHHmTuklwcYKAVQgiwVUB3vinQ462Q/
	OYP0Vu0GfH5GESr2xbQV3W5Ko6GUFhSpRnEUaPjCUpG0Rw3/CUYEM9k7cqCwhZL8Fb6nRT
	pC7TUpYGyDsjqcWXxIcmC7PUlqHrYyA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770810653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=MIkMrld6sqBD4vHcBDLpHHGMllBPgSwjupGXHeNuA3c=;
	b=v4nUOF6ixkOUQt31Ss5RslAoxIc/EeGVBuL5dtjKY3gBDwzhX8znHZ4rZroogKSOlOL3xx
	8qaJfzmHbnLzl5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DB9B3EA62;
	Wed, 11 Feb 2026 11:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FymrHh1tjGlpIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Feb 2026 11:50:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48A9BA0A4C; Wed, 11 Feb 2026 12:50:49 +0100 (CET)
Date: Wed, 11 Feb 2026 12:50:49 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.20-rc1 (or 7.0-rc1?)
Message-ID: <ydxny54jcyo6e2gfnanvdyp3k56orif4gfedumhbf6s2ocges5@m6nvf4awu7vv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76937-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A7323123F64
X-Rspamd-Action: no action

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.20-rc1

to get:
* a set of fixes to shutdown fsnotify subsystem before invalidating dcache
  thus addressing some nasty possible races.

Top of the tree is 74bd284537b3. The full shortlog is:

Jan Kara (3):
      fsnotify: Track inode connectors for a superblock
      fsnotify: Use connector list for destroying inode marks
      fsnotify: Shutdown fsnotify before destroying sb's dcache

The diffstat is

 fs/notify/fsnotify.c             |  69 ++------------------
 fs/notify/fsnotify.h             |   5 +-
 fs/notify/mark.c                 | 137 ++++++++++++++++++++++++++++++++++++---
 fs/super.c                       |   4 +-
 include/linux/fsnotify_backend.h |   5 +-
 5 files changed, 144 insertions(+), 76 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

