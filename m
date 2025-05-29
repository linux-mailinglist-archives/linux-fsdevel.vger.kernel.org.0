Return-Path: <linux-fsdevel+bounces-50075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B83AC7FF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E76A189EEEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887EF22B8B8;
	Thu, 29 May 2025 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CW0WPlpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g28WrHRP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CW0WPlpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g28WrHRP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2917A31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530872; cv=none; b=n+ux1o42tLXp5HQqoMIu6xOo0tJ70Wla5zT5ksgKRo321dQdbVxQOq+A3Hf05yzq4RiM2F1SIs84pguiqR4IVuz2Hg2Zr8uaDa9S0wuTcwV/+tjLzya11zvoFApFJV9Uwg8Eejub/ahCd76YCUMe0NU+j7VTIJ5g4Sgtb5km2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530872; c=relaxed/simple;
	bh=UItVDtl4xUGrFlwPKWmINB5sw+WmsUHfY0KjW2uM0co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V5bbIJf4CBLAeS1VIExkgrvAOe2uVPZChso44g2jmnOQmVO1Iq6h7+FEA2PCa/AdvT3HnXNLT8Q42xFq333zmnkH/KtW01JZwYB9YhYJ/66Pey3Ufx2TBmUZgEfNtXvJklqlFvJgGHPOMzB6ITz/PN8kApY+TSD+hq9N/CaxfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CW0WPlpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g28WrHRP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CW0WPlpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g28WrHRP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA1F921905;
	Thu, 29 May 2025 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+uxCeWg13A7G+Vs4mCKHkxVrl4cZgNPxX62purNS7c=;
	b=CW0WPlpJkKAcUR/xi/4TsFsB9ptrduPAqgUBP/OVxgDqVN0z4caRYMnanueqsqHgAUQOsp
	/uMrRxA5enuz8OfI7zY0y/62Gu4v4BK7crwdIkNyPfuTIIS8FxXOMXm/qgx4nQKxWMUJhc
	f+qLwbR0hZwAjqUj7gyRSQo7oMzPkSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+uxCeWg13A7G+Vs4mCKHkxVrl4cZgNPxX62purNS7c=;
	b=g28WrHRPvPWys2E00NTRemEqiUDmoOPaW9rNb4TOK/qq7d5ugtCdb2XQxoJhH4fPLRa+56
	bTJnqPwdR6bZGkBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CW0WPlpJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g28WrHRP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+uxCeWg13A7G+Vs4mCKHkxVrl4cZgNPxX62purNS7c=;
	b=CW0WPlpJkKAcUR/xi/4TsFsB9ptrduPAqgUBP/OVxgDqVN0z4caRYMnanueqsqHgAUQOsp
	/uMrRxA5enuz8OfI7zY0y/62Gu4v4BK7crwdIkNyPfuTIIS8FxXOMXm/qgx4nQKxWMUJhc
	f+qLwbR0hZwAjqUj7gyRSQo7oMzPkSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8+uxCeWg13A7G+Vs4mCKHkxVrl4cZgNPxX62purNS7c=;
	b=g28WrHRPvPWys2E00NTRemEqiUDmoOPaW9rNb4TOK/qq7d5ugtCdb2XQxoJhH4fPLRa+56
	bTJnqPwdR6bZGkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3552136E0;
	Thu, 29 May 2025 15:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wRKtL7R2OGigTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 15:01:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D90DA09B5; Thu, 29 May 2025 17:01:08 +0200 (CEST)
Date: Thu, 29 May 2025 17:01:08 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2 and isofs changes for 6.16-rc1
Message-ID: <ovi7jizxdqmr35quwevkzwiltahrewq5mrpmhnfe65gllynqod@ji6zewdluxyx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DA1F921905
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.16-rc1

to get:
  * isofs fix of handling of particularly formatted Rock Ridge timestamps
  * Add deprecation notice about support of DAX in ext2 filesystem driver

Top of the tree is d5a2693f93e4. The full shortlog is:

Jan Kara (1):
      ext2: Deprecate DAX

Jonas 'Sortie' Termansen (1):
      isofs: fix Y2038 and Y2156 issues in Rock Ridge TF entry

The diffstat is

 fs/ext2/super.c  |  3 ++-
 fs/isofs/inode.c |  7 +++++--
 fs/isofs/isofs.h |  4 +++-
 fs/isofs/rock.c  | 40 +++++++++++++++++++++++-----------------
 fs/isofs/rock.h  |  6 +-----
 fs/isofs/util.c  | 49 ++++++++++++++++++++++++++++++++-----------------
 6 files changed, 66 insertions(+), 43 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

