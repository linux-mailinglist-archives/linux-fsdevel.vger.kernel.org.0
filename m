Return-Path: <linux-fsdevel+bounces-24163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0DE93A9F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 01:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86306B22CB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3B5149C4E;
	Tue, 23 Jul 2024 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tcNFVcAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kTSVUIQn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tcNFVcAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kTSVUIQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0A813BAD5;
	Tue, 23 Jul 2024 23:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721778026; cv=none; b=ghZSZ55BMfOWCGlNhOpy9CZKU2zQQenxilDXmfX6BEL+nE8csObx4dHm07yiIW4z25IxqFTsaaIhX2itKhKBZYXtCCXZRe7pO/lLb9QoZ+42elvOtLNCNVXxKAoRIPyVwCKIa3gFgoXZcgBDQCYGNk9JEK+5TLoN2mDKpsaElsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721778026; c=relaxed/simple;
	bh=aiL1tdNlbxb2FPdKtq4ALnrnQksh3SDTEgIbOSuG7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2cjWiEnALfsN0Y2uFjtoAsI0dqFTo7wHtWadjfhKRbRFs8W9B8wPIwRIMnIkN0Ki9KGG82v7vUI9suVCB//WBWz3EeI5mdJZ1pr5DBF5LCQbOeRpMNihAyZjtw6ecwEJX/U/peS9hNEt8npFlQlZxD5UGbqXNeq8O4hCIiknfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tcNFVcAA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kTSVUIQn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tcNFVcAA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kTSVUIQn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B02B1F454;
	Tue, 23 Jul 2024 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721778022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ArXyy6Y1aI8VUmUq1KNgxA/8y4ypMHJfB8d6uWbO8bU=;
	b=tcNFVcAAu9gzDEenTyWh77FxxVUoS73I/Crihx8REfg2h+pqPK77YXY3PP6V4PfWgolbEG
	caNaHkPIOeyh3Ydu1Pcxeq6NPXvJG9PI75U5FJ3dhnqktWUFY+heIQWlTB1VeTz1GIPLsh
	6Ygaygc8DwrDABBIRaKhMA37zayojL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721778022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ArXyy6Y1aI8VUmUq1KNgxA/8y4ypMHJfB8d6uWbO8bU=;
	b=kTSVUIQnugnqtxR/CaIhLxGpF7qP1dDQvQ1Fqdj2fSUeZgMwzwTsL5tcbvUbGe+Cm6cJCW
	AeiIOxVkbyxz1fCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tcNFVcAA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kTSVUIQn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721778022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ArXyy6Y1aI8VUmUq1KNgxA/8y4ypMHJfB8d6uWbO8bU=;
	b=tcNFVcAAu9gzDEenTyWh77FxxVUoS73I/Crihx8REfg2h+pqPK77YXY3PP6V4PfWgolbEG
	caNaHkPIOeyh3Ydu1Pcxeq6NPXvJG9PI75U5FJ3dhnqktWUFY+heIQWlTB1VeTz1GIPLsh
	6Ygaygc8DwrDABBIRaKhMA37zayojL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721778022;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ArXyy6Y1aI8VUmUq1KNgxA/8y4ypMHJfB8d6uWbO8bU=;
	b=kTSVUIQnugnqtxR/CaIhLxGpF7qP1dDQvQ1Fqdj2fSUeZgMwzwTsL5tcbvUbGe+Cm6cJCW
	AeiIOxVkbyxz1fCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F3351377F;
	Tue, 23 Jul 2024 23:40:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X+TsBGY/oGYVVwAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 23 Jul 2024 23:40:22 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] trivial unicode patches for 6.11
Date: Tue, 23 Jul 2024 19:40:12 -0400
Message-ID: <87bk2nsmn7.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B02B1F454
X-Spam-Score: -4.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]


The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.11

for you to fetch changes up to 68318904a7758e11f16fa9d202a6df60f896e71a:

  unicode: add MODULE_DESCRIPTION() macros (2024-06-20 19:30:02 -0400)

----------------------------------------------------------------
Two small fixes to silent the compiler and static analyzers tools from
Ben Dooks and Jeff Johnson.

----------------------------------------------------------------
Ben Dooks (1):
      unicode: make utf8 test count static

Jeff Johnson (1):
      unicode: add MODULE_DESCRIPTION() macros

 fs/unicode/mkutf8data.c       | 1 +
 fs/unicode/utf8-selftest.c    | 5 +++--
 fs/unicode/utf8data.c_shipped | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)


-- 
Gabriel Krisman Bertazi

