Return-Path: <linux-fsdevel+bounces-66750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE68C2B73D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D86BB4FB5A4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BEC26CE33;
	Mon,  3 Nov 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dzdCuqVO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4rXZTUC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G0y8QvxQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vgu7/4Zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03627E04C
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169306; cv=none; b=H6P9d6yAIH1dKTjJhybVgVvtD/CtVFSJ1PMHk/gU6C6pxw3wk/+TQtmdPCK7wbZguLiSxcNLsWGapaa8rcvKu401VPkoVSlK3od0W2F23xM9aNTz/Vuuvh99jtIkCIPq4sxm+xFA0FacpzB0dOQTv2H4yKrAG45qGi99CCIdHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169306; c=relaxed/simple;
	bh=clekFM+Rni6jPLM41ubLk5o1m+QsTetrFgKlWZuHCtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeKzFH42+K0fyBQe9j6GczbKTodkCJLoBBmzZ8AF5Y3gdSY7A+FB7avTEGyyW5wRi4otTgQSKt+jAtR9u5VnEeUyPcpLj0cPEFoKImAxSmmxokBZ3YuNwj9WxA6BlzjCeDNrNhUQ/1cIYyEHmaKdXjMZfdblU8sGIxpvVautNJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dzdCuqVO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4rXZTUC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G0y8QvxQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vgu7/4Zn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E14E1F7B5;
	Mon,  3 Nov 2025 11:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0nMLISfTlDpC9mF/ux777mG7wY5ioiVj6t4+zB8BN0=;
	b=dzdCuqVOVgp0qb+Knfv1xWKe48zo9X/646d0NWUHwehAgoEcL2JMYCwWGshyrg0dK/yrlZ
	xxWHW6I1NqiaA7hAWZzRQ4h0K06dFvRsTcUniR97X+SfYQqaQKAW2qI+K2AP2InuCaab+4
	2bPWLaM6wlgijpLqURLzajNJUmx3LS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0nMLISfTlDpC9mF/ux777mG7wY5ioiVj6t4+zB8BN0=;
	b=h4rXZTUCjKyjo+6Cg9Um5bzH+pVj84K4N2VDoGIHoSMjTclzfHIZp4pzLwYqsg6Xfw2EmF
	fHplovR32NJVjjAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0nMLISfTlDpC9mF/ux777mG7wY5ioiVj6t4+zB8BN0=;
	b=G0y8QvxQRj4fyiNDUY1shJmIQqtRJERW0oFZLQ0CLe6NKlRQhkHtjdN7TFe2Y5tu9wzfP6
	OfZASXoCOtQpt+jWxiDN/00em7psK9494KaKMjRh4kFEhd5ysOWFdh/Cs0AV2DsaJ1ZNER
	2V6LbW1CkBTWtePCkEWgCebDennpHXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M0nMLISfTlDpC9mF/ux777mG7wY5ioiVj6t4+zB8BN0=;
	b=Vgu7/4ZnWHk6VlXwt1HMbIV31YlNUewE4bvBCJWHI2GtGaghyOqEnHhamCAFqHBklrG10t
	JOgnVZul6Rh9QDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E28FD1364F;
	Mon,  3 Nov 2025 11:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQNAN9WRCGmhIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:28:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32FB2A2812; Mon,  3 Nov 2025 12:28:21 +0100 (CET)
Date: Mon, 3 Nov 2025 12:28:21 +0100
From: Jan Kara <jack@suse.cz>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-man@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Jan Kara <jack@suse.cz>, 
	"G. Branden Robinson" <branden@debian.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <tkh3cbnxbixmeuprlfrpfbzm5l6y6ne3i424wswd7ymspuu6as@h2hzgun5moff>
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
 <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
 <20251031152531.GP6174@frogsfrogsfrogs>
 <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rg6xzjm5vw2j5ercxiihm2pdedc4brdslngiih6eknvod66oqk@tz3gue33a7fe>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sun 02-11-25 22:17:06, Alejandro Colomar wrote:
> Hi Darrick,
> 
> On Fri, Oct 31, 2025 at 08:25:31AM -0700, Darrick J. Wong wrote:
> > On Fri, Oct 31, 2025 at 11:44:14AM +0100, Alejandro Colomar wrote:
> > > Suggested-by: Pali Rohár <pali@kernel.org>
> > > Co-authored-by: Pali Rohár <pali@kernel.org>
> > > Co-authored-by: Jan Kara <jack@suse.cz>
> > > Cc: "G. Branden Robinson" <branden@debian.org>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > > ---
> > > 
> > > Hi Jan,
> > > 
> > > I've put your suggestions into the patch.  I've also removed the
> > > sentence about POSIX, as Pali discussed with Branden.
> > > 
> > > At the bottom of the email is the range-diff against the previous
> > > version.
> > > 
> > > 
> > > Have a lovely day!
> > > Alex
> > > 
> > >  man/man3/readdir.3      | 19 ++++++++++++++++++-
> > >  man/man3type/stat.3type | 20 +++++++++++++++++++-
> > >  2 files changed, 37 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
> > > index e1c7d2a6a..220643795 100644
> > > --- a/man/man3/readdir.3
> > > +++ b/man/man3/readdir.3
> > > @@ -58,7 +58,24 @@ .SH DESCRIPTION
> > >  structure are as follows:
> > >  .TP
> > >  .I .d_ino
> > > -This is the inode number of the file.
> > > +This is the inode number of the file
> > > +in the filesystem containing
> > > +the directory on which
> > > +.BR readdir ()
> > > +was called.
> > > +If the directory entry is the mount point,
> > 
> > nitpicking english:
> > 
> > "...is a mount point," ?
> 
> I think you're right.  Unless Jan and Pali meant something more
> specific.  Jan, Pali, can you please confirm?

Yes, Darrick is right :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

