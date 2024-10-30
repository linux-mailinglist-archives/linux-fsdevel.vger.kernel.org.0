Return-Path: <linux-fsdevel+bounces-33215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB8D9B5965
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 02:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4982C1F23FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBA19342E;
	Wed, 30 Oct 2024 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zfJYJhwj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7b5ZvQJc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G5fqI82z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="etALiVlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24881C3F00
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 01:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252607; cv=none; b=swSdtpIIcxVOS3kO7i2wAv9OgRtOl1AokQOYEAMCrHCywU4XizeLy2cPVvIBVI8mf9Q2NqCsofaWfaKnkJHt5Q+QM/taUD2UZYI6rLP6dfF26w0WwQTl/TFMN2rNTtSZgD+/oVXW+CgvyCC6aNNP8aNYhz0EnfSJB708qSGs9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252607; c=relaxed/simple;
	bh=b5Cd8yUoL+j81e/xXLi7v9YTAIbRnMFJZIIsRi2XPNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fljssZslFJrzN13D/8gJq187x77Eyvb37kUi/QzXGeENmBIo4cqU49NMDNAONgm8AFvl5r7loxD0BOpflRxdCjVPCmHZ3RHWKBO0XmiuFS7/Y/YEkJwDsynRmhU5XHXTAM3t1TlY2BXnW0N1r0mBLsMqUPCh3YASbxMjtAAck3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zfJYJhwj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7b5ZvQJc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G5fqI82z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=etALiVlF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEF2121D54;
	Wed, 30 Oct 2024 01:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730252603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH18nX6WZvWY/8AdvK38I8b1i3xh8QwZ8Kt2xmLr5EM=;
	b=zfJYJhwjq+YJ0payG9tL1EahUNynLbk54WAgDI3fPktigvNRYH/JIm2Bx6BtNTtOqvbQms
	8U9WCf9pFT4RmRv0ZW1OhtqpOs+wxcNU5WgljBcseElWUE+QpiZEYBPu9kCw+tNiNeEM/2
	kwp4MT3VIFHDHMVI99D102yUEVq0tmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730252603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH18nX6WZvWY/8AdvK38I8b1i3xh8QwZ8Kt2xmLr5EM=;
	b=7b5ZvQJc7K0RJiD52yQq47StlQ2sLTq0UfhtacxOrP94h12rGBxq+C/v8qd4SGvEa8jQyI
	fn3oNRLmt3yIu8DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G5fqI82z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=etALiVlF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730252602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH18nX6WZvWY/8AdvK38I8b1i3xh8QwZ8Kt2xmLr5EM=;
	b=G5fqI82zTDy8kgL4XaURRi8HaXgQQbe0pHnmwZHgy7OLVp/3nMy+2uDxgULlV4OufsUUR/
	hnoXWuNy3fKaGyBtdJrK1YZRMgutP+WNOxkvT1dSunE7o29OK9Fkm7sGZLsq1AAmwvU06w
	y4/uIscrIN2D24OFoFCYgNIBAQqfMFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730252602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yH18nX6WZvWY/8AdvK38I8b1i3xh8QwZ8Kt2xmLr5EM=;
	b=etALiVlFmZN2OLo8fXs/nDu4Q6YHGAYpZeFTRj0g696HvxcuxWHdIhAXyU00K3/DNbHnjX
	QeAuE0xXEFBnjuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 869C613721;
	Wed, 30 Oct 2024 01:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3SAZEDmPIWfhLgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 30 Oct 2024 01:43:21 +0000
Date: Wed, 30 Oct 2024 01:42:39 +0000
From: David Disseldorp <ddiss@suse.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] initramfs: avoid filename buffer overrun
Message-ID: <20241030014239.2fb3d4ab.ddiss@suse.de>
In-Reply-To: <20241029183520.GE1350452@ZenIV>
References: <20241029124837.30673-1-ddiss@suse.de>
	<20241029183520.GE1350452@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EEF2121D54
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Tue, 29 Oct 2024 18:35:20 +0000, Al Viro wrote:

> On Tue, Oct 29, 2024 at 12:48:37PM +0000, David Disseldorp wrote:
...
> > +	if (collected[name_len - 1] != '\0') {
> > +		pr_err("Skipping symlink without nulterm: %.*s\n",
> > +		       (int)name_len, collected);  
> 
> I'm not sure pr_err() and continue is a good approach here -
> you'd been given a corrupted image, so there's no point trying
> to do anything further with it.  Have it return 1, at least,
> and preferably use error("buggered symlink") in addition or
> instead of your pr_err().

I was following the name_len > PATH_MAX handling, but failing
immediately makes more sense here. Will change in v2.

> FWIW, it's _not_ about trying to stop an attack - if you get there with
> image contents controlled by attacker, you have already hopelessly lost;
> no buffer overruns are needed.
> 
> It does catch corrupted images, which is the right thing to do, but it's
> not a security issue.

Agreed. I'll rework the commit message to more clearly state that
initramfs image write access is required, at which point all bets are
off.

