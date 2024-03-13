Return-Path: <linux-fsdevel+bounces-14320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07287B0B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE5CB2BDAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CA664B9;
	Wed, 13 Mar 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BGQuhhMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hUtg0A7J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BGQuhhMt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hUtg0A7J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8165BD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351905; cv=none; b=Zs37ybSoT4wMwKh8qlZfLMDrJlPk9geE16iUTcaWA+71EH4qjt59GTC2VbILWrWkDaQZ1pR9q9VzWiDiHArbKN4llDSEtCbPvzZb+8VhICDCypuaPcwzn0HlAbqxet3itCKW284wOk2Fot+z0ssTWHVItC5UDi9TkqK6XebxDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351905; c=relaxed/simple;
	bh=sA5iiSLftvmBMAgYm2NQtl02swczZPJoD4toBoHZM1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zr1OejNkbHwtKzcfpbfbpr/qT7YA2Vyw39y+gG8fFJMxk4TS5eWOC4ZwPIZygIw75Dltg1kYOaMUg382a6m4v3ntiJQ5jx8TI/XTZucUykmWjrqpTfposTBieGNiwN2RTH5Yiun6N5gBJk4rJa6EEOOH6c3FQ8gai9qwVpLkREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BGQuhhMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hUtg0A7J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BGQuhhMt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hUtg0A7J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 382F321CB4;
	Wed, 13 Mar 2024 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710351900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UG30GaRZ9G94IaWXYL9ovTFsdur3qPMTb2OinevN5bw=;
	b=BGQuhhMtZjv1w1p2FNhGPZWPNSWGd7fQ0+EQ0tI6d+aLDK4WC9YHuw38W9xycoDsX60IAP
	LPkzDNVp01bf2uhjZ6VDVOJZynafcjQYybNndIu0Ra0Z10rITALEJzQW8yiLw0qQqUL+Eb
	sR99EnAvLZpxIlla6CgY8qg8e1oHK00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710351900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UG30GaRZ9G94IaWXYL9ovTFsdur3qPMTb2OinevN5bw=;
	b=hUtg0A7JCCELdG+tRF7Irk8nN6egk09TkHTo1oi6bCggChPqEGCFmvuHCEP75uVhcvbkU7
	hOU0utjZz0yK/PBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710351900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UG30GaRZ9G94IaWXYL9ovTFsdur3qPMTb2OinevN5bw=;
	b=BGQuhhMtZjv1w1p2FNhGPZWPNSWGd7fQ0+EQ0tI6d+aLDK4WC9YHuw38W9xycoDsX60IAP
	LPkzDNVp01bf2uhjZ6VDVOJZynafcjQYybNndIu0Ra0Z10rITALEJzQW8yiLw0qQqUL+Eb
	sR99EnAvLZpxIlla6CgY8qg8e1oHK00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710351900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UG30GaRZ9G94IaWXYL9ovTFsdur3qPMTb2OinevN5bw=;
	b=hUtg0A7JCCELdG+tRF7Irk8nN6egk09TkHTo1oi6bCggChPqEGCFmvuHCEP75uVhcvbkU7
	hOU0utjZz0yK/PBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A25A1397F;
	Wed, 13 Mar 2024 17:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IQhAChzm8WXsJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Mar 2024 17:45:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE4F0A07D9; Wed, 13 Mar 2024 18:44:59 +0100 (CET)
Date: Wed, 13 Mar 2024 18:44:59 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.9-rc1
Message-ID: <20240313174459.vrjqn4g35dxdknfv@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BGQuhhMt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hUtg0A7J
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.58 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.07)[62.02%]
X-Spam-Score: -4.58
X-Rspamd-Queue-Id: 382F321CB4
X-Spam-Flag: NO


  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.9-rc1

to get:
  * fsnotify optimizations to reduce cost of fsnotify when nobody is watching
  * fix longstanding wart that system could not be suspended when some
    process was waiting for response to fanotify permission event
  * some spelling fixes

Top of the tree is 0045fb1bab4e. The full shortlog is:

Amir Goldstein (2):
      fsnotify: optimize the case of no parent watcher
      fsnotify: Add fsnotify_sb_has_watchers() helper

Vicki Pfau (3):
      inotify: Fix misspelling of "writable"
      fsnotify: Fix misspelling of "writable"
      fanotify: Fix misspelling of "writable"

Winston Wen (1):
      fanotify: allow freeze when waiting response for permission events

The diffstat is

 fs/notify/fanotify/fanotify.c    |  6 ++++--
 fs/notify/fsnotify.c             | 28 +++++++++++++++++-----------
 include/linux/fsnotify.h         | 12 +++++++++---
 include/linux/fsnotify_backend.h |  4 ++--
 include/uapi/linux/fanotify.h    |  4 ++--
 include/uapi/linux/inotify.h     |  4 ++--
 6 files changed, 36 insertions(+), 22 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

