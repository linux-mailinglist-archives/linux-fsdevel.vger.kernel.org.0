Return-Path: <linux-fsdevel+bounces-76941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAcPISt0jGk6ogAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 13:20:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A658212427D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 13:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 242E8300517A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 12:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51395336EE7;
	Wed, 11 Feb 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVIM4KED";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fexetQrx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNVOqzvT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hkkwfk45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B041232694A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812451; cv=none; b=Yc9HkNzzMUghLL+bEphi1JLgF0Iu4Bfir+dbdJv9HTxLbezpP2QDCI/e6/Lw2g65UBa4Ik1UT1jOOSiXGLOBEneRI4Xwld/wI8ayq4vVZFFYV1VzJnfJcF0Uz/najY622RNV+qRPa7oPZtmo3AS61MZE74lfV9HcijMDi2YkiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812451; c=relaxed/simple;
	bh=Dqt4txqw3K1XFEh/jTr5wf3eg7tpm5t6qhHIa1Pjj14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HAVeQqtDpYhyPRErN1oG+ES+9CWxG/zkS8KRnL9EliYpgiJyZX9P6vYbJPptbNie3ADxFl/r8eOSTlyhDMm8CyN325U1x+A8qUyDDLZHDY575wc6fifxlAi/QfPcGzMOpwRwcnYzV2PgsvaRgV4/suSxjbuWoZD+Yb5liQUMBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVIM4KED; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fexetQrx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNVOqzvT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hkkwfk45; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ECCC95BD81;
	Wed, 11 Feb 2026 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770812449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wi6Wn/q8Rl79oCQDtCn1Op5n488Ac14yzWLH2DRQzqU=;
	b=rVIM4KED9JlORbjy4t7yNU1I9FJFIANgQFRtD7kV1gmKrbc+W/Fvo8mYmgsvgAVYg8/RJJ
	KpX08bkrXnzPGH9373wrVu+nrqx+a/6aMP0TX6kHcPHuFUmg2f9aNcYSGlREBxUc+/W++I
	gWvozrZ9cqvUz9VFr7KVsZ2cUuxXaRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770812449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wi6Wn/q8Rl79oCQDtCn1Op5n488Ac14yzWLH2DRQzqU=;
	b=fexetQrxIEBsghnh3FHD5XfCbIqzTpMsAUHhOqqJEQ31MTg6O2o9lPhF7Kr58jkBVcV8jL
	plrpfOPTK8NsL9DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770812448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wi6Wn/q8Rl79oCQDtCn1Op5n488Ac14yzWLH2DRQzqU=;
	b=iNVOqzvTR1OdaY2BfNFyTiS6UH4G8BY2jWzlmFWIg8aXJuVxj3tWAyF/8eW/Rdkgxhm+UY
	fQ14OBdntbMxF7XbYAyrX2sg3oZAl1pkKOf9nDAOd0/Gul/jlZbPHaWEoaH2978WvEYx79
	5Y13/da2FpMRqUawuKnENutzqBJkvQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770812448;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wi6Wn/q8Rl79oCQDtCn1Op5n488Ac14yzWLH2DRQzqU=;
	b=Hkkwfk45sKvWDvjJnyzjZHQCv9tKcHE+iUX8VZ3LnyBiWZo0lKcj4ZxFGSCxWz8BsCqyR7
	MfNI7dAb5agTClCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9C663EA62;
	Wed, 11 Feb 2026 12:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4qwnNSB0jGmdeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Feb 2026 12:20:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94B21A0A4C; Wed, 11 Feb 2026 13:20:40 +0100 (CET)
Date: Wed, 11 Feb 2026 13:20:40 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] quota and isofs fixes for 6.20-rc1
Message-ID: <xpx7drxgrtrzlcazrmqqepfdtognnodyucziepzakx4adm3aau@zwmaecmugo5h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.cz:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-76941-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A658212427D
X-Rspamd-Action: no action

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.20-rc1

to get:
 * a fix for qutactl livelock during filesystem freezing
 * a small improvement for isofs
 * a documentation fix for ext2

Top of the tree is 18a777eee289. The full shortlog is:

Abhishek Bapat (1):
      quota: fix livelock between quotactl and freeze_super

Shawn Landden (1):
      isofs: support full length file names (255 instead of 253)

Ziran Zhang (1):
      doc : fix a broken link in ext2.rst

The diffstat is

 Documentation/filesystems/ext2.rst | 2 +-
 fs/isofs/rock.c                    | 2 +-
 fs/quota/quota.c                   | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

