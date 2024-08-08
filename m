Return-Path: <linux-fsdevel+bounces-25446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C6C94C3CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E81C220E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1B190471;
	Thu,  8 Aug 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KUOvIjL6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lghl0Cpx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yogjdABV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5VkjSRhB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B413D8A3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138482; cv=none; b=OEWzyJJkwca6sDmmGu4hMVCd0fnbN9kxyTtO5w2wNo0Ibt0FI5gVoyLO9ZqFr5/bCXM2pa4kaGLHDqTwX1jCF9pJwm0HpQ2r427aKqzvcsFLgPDPUQJDCz8XIUFPPWQAoqcdxk7JLcNcSRWidHyZTw9RQ+nvSYCq4jfjFUzHYG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138482; c=relaxed/simple;
	bh=0PS0MemkpdUBbVtJllMXr0cGbQUfaf8rNmZcLsnMhvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZQMXbimkHe4kq07mNZ0/kVbBkYOpDFIIamBQIlkElGFrWlbrCjxcPJSOXi0zcFDiyQ81PHaZVDmj6VYVpRoi98TPVtw75P+XU5BEJvlOquee1i2Z6JhtSr7i7hNpHKMIGo8uN97Ly3hus5OofSnIymVXOrdmuu49qq9xWqMqks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KUOvIjL6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lghl0Cpx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yogjdABV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5VkjSRhB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0958A1F7A6;
	Thu,  8 Aug 2024 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723138478; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5PmvDFdAPGIUjp/Wu7NSl72INmdHuySDaPkyheBqzk=;
	b=KUOvIjL6EVlka74FnT4mT/iIUcy+axnSKeFGaGn+CwunrkFZK6CkcgMZFd+djJVgmXIGSa
	s0UYcmJtE2pcUeAm1poIOxAxNdscgex7F7cwTWADuQLQLlbE1Yas5MqIiAd5yAr/UvQyoF
	3gNeLlqkMjgb/dn2uOjH1eLZEke40mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723138478;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5PmvDFdAPGIUjp/Wu7NSl72INmdHuySDaPkyheBqzk=;
	b=Lghl0CpxYiXN/FrO1Weqs2+MozYbbKxlMt9l6lgQsCSu47oJAmyhI0JkwvuzMvJbrxbzfW
	vqtK9ZXwLVo113DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yogjdABV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5VkjSRhB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723138477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5PmvDFdAPGIUjp/Wu7NSl72INmdHuySDaPkyheBqzk=;
	b=yogjdABV8tPXpY2WDhuDrHwbTSupeMZzjmZ9pXgVyt6f/JK18gIMeCIDVLKhJI6FrIT80c
	Rx6qxkxnLlYwrgc+OqJIR+UeqZ7Rea5dUisQPoTB5oVGmkZz0pOy4JPDrX+JasZZOqizMA
	okETpVluEeWa1P6mmnYPK0T6AEusSK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723138477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5PmvDFdAPGIUjp/Wu7NSl72INmdHuySDaPkyheBqzk=;
	b=5VkjSRhBqpZamvE/p85fcpA3NrwEM1TNlC9AecEvGutG1nKgetxaQaFV5y6QoAECluXPiV
	SZByk9YGgZAvCbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E12DA136A2;
	Thu,  8 Aug 2024 17:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YauoNqwBtWZ7QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Aug 2024 17:34:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81BC1A0851; Thu,  8 Aug 2024 19:34:32 +0200 (CEST)
Date: Thu, 8 Aug 2024 19:34:32 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 06/13] fs: Drop unnecessary underscore from _SB_I_
 constants
Message-ID: <20240808173432.bs64kswvkq6qen4z@quack3>
References: <20240807180706.30713-1-jack@suse.cz>
 <20240807183003.23562-6-jack@suse.cz>
 <CAOQ4uxhhzFZy-QBrwhRWubRm75Uw_sx92OZv3gp1bV-MTWwYPA@mail.gmail.com>
 <20240808143505.GB6043@frogsfrogsfrogs>
 <20240808-gegolten-dehnen-3a19a0e67edf@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808-gegolten-dehnen-3a19a0e67edf@brauner>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.cz,vger.kernel.org,fromorbit.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 0958A1F7A6

On Thu 08-08-24 16:50:42, Christian Brauner wrote:
> On Thu, Aug 08, 2024 at 07:35:05AM GMT, Darrick J. Wong wrote:
> > On Thu, Aug 08, 2024 at 01:47:20PM +0200, Amir Goldstein wrote:
> > > On Wed, Aug 7, 2024 at 8:31 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > Now that old constants are gone, remove the unnecessary underscore from
> > > > the new _SB_I_ constants. Pure mechanical replacement, no functional
> > > > changes.
> > > >
> > > 
> > > This is a potential backporting bomb.
> > > It is true that code using the old constant names with new macros
> > > will not build on stable kernels, but I think this is still asking for trouble.
> > > 
> > > Also, it is a bit strange that SB_* flags are bit masks and SB_I_*
> > > flags are bit numbers.
> > > How about leaving the underscore and using  sb_*_iflag() macros to add
> > > the underscore?
> > 
> > Or append _BIT to the new names, as is sometimes done elsewhere in the
> > kernel?
> > 
> > #define SB_I_VERSION_BIT	23
> 
> Yeah, that's better (Fwiw, SB_I_VERSION is confusingly not an
> sb->i_flags. I complained about this when it was added.).
> 
> I don't want to end up with the same confusion that we have for
> __I_NEW/I_NEW and __I_SYNC/I_SYNC which trips me up every so often when
> I read that code.

OK, _BIT suffix sounds nice.

> So t probably wouldn't be the worst if we had:
> 
> #define SB_I_NODEV_BIT 3
> #define SB_I_NODEV BIT(SB_I_NODEV_BIT)
> 
> so filesystems that raise that flag when they're initialized can do:
> 
> sb->i_flags |= SB_I_NODEV;
> 
> and not pointlessly make them do:
> 
> sb->i_flags |= 1 << SB_I_NODEV_BIT;

Well, all sb->i_flags modifications should be using sb_set_iflag() /
sb_clear_iflag(). I know it is unnecessarily more expensive in some cases
but none of those paths is really that performance sensitive. The only
(three) places where we have expression like 1 << SB_I_<foo>_BIT are there
because the flags are also used for fc->s_iflags.

I think that keeping SB_I_NODEV around together with SB_I_NODEV_BIT makes
it easier to write code like sb->i_flags |= val without thinking twice and
the three callsites that would be simplified are not really worth it. But
if someone feels strongly about this, I can live with it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

