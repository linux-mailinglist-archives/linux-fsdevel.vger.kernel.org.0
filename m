Return-Path: <linux-fsdevel+bounces-50627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E015ACE1B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15ACD3A8768
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8E1A2545;
	Wed,  4 Jun 2025 15:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jq9sFDO+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FDqwOq0l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r74BRPCk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6plmO64f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017741E522
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749051867; cv=none; b=paKk1hQD6b3VmvvWJkLq4vl9WyudptuT9vaYYLKjkPkm9nGqDXpC0Xh7TCFbbjnCxDc3DDRcqG3fgktnkp9S9o9nwZunSUslUOadpU2lR7UFXBTvkw//rvAO6RwHFjzn0/s4CAarXxYDqsuCMQfv2oGP94bwxXe1/CvcWHGqCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749051867; c=relaxed/simple;
	bh=f7lRk+b2SIr/M1jbrfGzBguI5XqViR8QimvPyjso0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwbRl1XvRRuvB6oEDvkCBScVKIz3UW41osLJURuMHS1jmm7UdgWlIIPv6fpW+bigwqSytzSr3+klhe4SoEfu0hQypy39ohhAuUuxMxvikTkrZwc1rCh0IYafzyCefQAnA6CSIpA5uj0pOTz8QtOCC6vE6sSSr3bbHT0y3/YJepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jq9sFDO+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FDqwOq0l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r74BRPCk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6plmO64f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7FBA1FEF2;
	Wed,  4 Jun 2025 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749051864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCC2WWItBuBB5emvqTSf3LdL7WM1Hvu7mLAtMLGblgE=;
	b=Jq9sFDO+OXExv9H/ECrc3/kkj4FEJjvBUv/KUMLSokDTT/tDPCbBehkplqPUEzATPxyt2k
	ZhWaZEB4Vk9YAMSMw1U3sgHguTHD6xy+6NLrX8TqDGW5XPABmnDnbx7kJtSfw3bmDXQMmS
	JT4+rS97ATsiwIayfbWr3lv+n44wPCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749051864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCC2WWItBuBB5emvqTSf3LdL7WM1Hvu7mLAtMLGblgE=;
	b=FDqwOq0lhb+b0Cel/nEtVwKCGhCq4IkCXU9OfHh+mlszveJzsP62aqjmNR5Kjchn7eCb/i
	0kB4asU3ZXg3+MAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r74BRPCk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6plmO64f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749051863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCC2WWItBuBB5emvqTSf3LdL7WM1Hvu7mLAtMLGblgE=;
	b=r74BRPCktuxJVMtT86wnDKlCv9NvFGtd5toUKsd69F7Cl5Ql8P6yxv2f9S429HSCLHCWO0
	yr6b8r6fGdw95ebKYO0Akeomnef1rhkwk8jWl3iu/h8wcQjBlHx2+rudYiyWv2jUSa17aA
	sN7SwfP2Jm0x05b2L0xU9rLXg0v1vpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749051863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FCC2WWItBuBB5emvqTSf3LdL7WM1Hvu7mLAtMLGblgE=;
	b=6plmO64fjxDstv+2auLmT/Tkp0J4X35NypvAXEoohnGzTMJ0E64QMzJ7nZck2xsXqmcK5x
	teWTEy9uyJLB8gAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0C511369A;
	Wed,  4 Jun 2025 15:44:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hskGL9dpQGgxFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Jun 2025 15:44:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E96B1A095C; Wed,  4 Jun 2025 17:44:22 +0200 (CEST)
Date: Wed, 4 Jun 2025 17:44:22 +0200
From: Jan Kara <jack@suse.cz>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luka <luka.2016.cs@gmail.com>
Subject: Re: [Bug] possible deadlock in vfs_rmdir in Linux kernel v6.12
Message-ID: <bfyuxaa7cantq2fvrgizsawyclaciifxub3lortq5oox44vlsd@rxwrvg2avew7>
References: <CALm_T+2FtCDm4R5y-7mGyrY71Ex9G_9guaHCkELyggVfUbs1=w@mail.gmail.com>
 <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
 <CALm_T+3H5axrkgFdpAt23mkUyEbOaPyehAbdXbhgwutpyfMB7w@mail.gmail.com>
 <20250604-quark-gastprofessor-9ac119a48aa1@brauner>
 <20250604-alluring-resourceful-salamander-6561ff@lemur>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604-alluring-resourceful-salamander-6561ff@lemur>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D7FBA1FEF2
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.51
X-Spam-Level: 

On Wed 04-06-25 10:45:49, Konstantin Ryabitsev wrote:
> On Wed, Jun 04, 2025 at 09:45:23AM +0200, Christian Brauner wrote:
> > Konstantin, this looks actively malicious.
> > Can we do something about this list-wise?
> 
> Malicious in what sense? Is it just junk, or is it attempting to have
> maintainers perform some potentially dangerous operation?

Well, useless it is for certain but links like:

Bug Report: https://hastebin.com/share/pihohaniwi.bash

Entire Log: https://hastebin.com/share/orufevoquj.perl

are rather suspicious and suggest there's more in there than just a lack of
knowledge (but now that I've tried the suffixes seem to be automatically
added by some filetype detection logic in the hastebin.com site itself so
more likely this is not malicious after all). FWIW I've downloaded one of
the files through wget and looked into it and it seems to have a reasonable
content and does not seem malicious but it is difficult to be sure in the
maze of HTML and JS...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

