Return-Path: <linux-fsdevel+bounces-32236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C59A294E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274F2285D44
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5DC1DF97A;
	Thu, 17 Oct 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FluGkwtr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I2enq7ie";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FluGkwtr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="I2enq7ie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A031DF725;
	Thu, 17 Oct 2024 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183426; cv=none; b=uR/ly2/30oLToEFaHO8EzBbWn5CL8o8V4CMrYGeeljv3nCeunP2Os/hpirR6Ex6XfSk9M7q9UKMpB4r0oANdqfg6uuv+3ZXaW8x2aBQ6HaDltl6/GinreiNa44DIFfaXTHL72U2KncrA00RvgzZvlzAjfl5y8cqy6kJRb9oXpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183426; c=relaxed/simple;
	bh=/pQEMDJ0tWR7jUox6Yx2LARbpKT7SWzP+nFAD8Q2vuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTrbkappnuflaY3ZmMkhtAwrJRzzng39AF9EQ5lO9l95iWLYJtjadcjU0JAO0NfItRdHf/DkXth3jMMMVrVwjcs8mzqQuIymH40wgvstMbb+1qDeoa5MZR9rDbuYGfaJnns5wBsQ0k9lKgeri2kvcyUf4+5RqrFlXLyXmyRiz6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FluGkwtr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I2enq7ie; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FluGkwtr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=I2enq7ie; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3638E21BF8;
	Thu, 17 Oct 2024 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729183419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzoLvV5xDvJpzHY2wUEs/zXT/O6qP6LnxqIrn7QVrlY=;
	b=FluGkwtrRKy60QaI1LMHY67ZariTniApGobBoTrbo4a2C/Z1vPWLrSHbhrp76Ldm7sizhg
	HPqXqmgKMEslAYCboQDJW5xHO9aIMv34sB56AvtLJFrgkF1KnDoe5QSISh6a0PwG/gSSX3
	thlnso7Tu38RXlTvNjEjRN038OlKghw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729183419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzoLvV5xDvJpzHY2wUEs/zXT/O6qP6LnxqIrn7QVrlY=;
	b=I2enq7ier/T/vWsGFt0/dEBGVAqWRooRjvoyzdg41lMbRf9lRC6a/Yrn8AzaY9vpvhYBGE
	27Nvha6TKK612iCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729183419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzoLvV5xDvJpzHY2wUEs/zXT/O6qP6LnxqIrn7QVrlY=;
	b=FluGkwtrRKy60QaI1LMHY67ZariTniApGobBoTrbo4a2C/Z1vPWLrSHbhrp76Ldm7sizhg
	HPqXqmgKMEslAYCboQDJW5xHO9aIMv34sB56AvtLJFrgkF1KnDoe5QSISh6a0PwG/gSSX3
	thlnso7Tu38RXlTvNjEjRN038OlKghw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729183419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qzoLvV5xDvJpzHY2wUEs/zXT/O6qP6LnxqIrn7QVrlY=;
	b=I2enq7ier/T/vWsGFt0/dEBGVAqWRooRjvoyzdg41lMbRf9lRC6a/Yrn8AzaY9vpvhYBGE
	27Nvha6TKK612iCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2674F13A42;
	Thu, 17 Oct 2024 16:43:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AvcVCbs+EWf+TgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 17 Oct 2024 16:43:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2CC2A080A; Thu, 17 Oct 2024 18:43:38 +0200 (CEST)
Date: Thu, 17 Oct 2024 18:43:38 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "mic@digikod.net" <mic@digikod.net>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"anna@kernel.org" <anna@kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	"audit@vger.kernel.org" <audit@vger.kernel.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241017164338.kzl7uotdyvhu5wv5@quack3>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241016-mitdenken-bankdaten-afb403982468@brauner>
 <CAHC9VhRd7cRXWYJ7+QpGsQkSyF9MtNGrwnnTMSNf67PQuqOC8A@mail.gmail.com>
 <5bbddc8ba332d81cbea3fce1ca7b0270093b5ee0.camel@hammerspace.com>
 <CAHC9VhQVBAJzOd19TeGtA0iAnmccrQ3-nq16FD7WofhRLgqVzw@mail.gmail.com>
 <ZxEmDbIClGM1F7e6@infradead.org>
 <CAHC9VhTtjTAXdt_mYEFXMRLz+4WN2ZR74ykDqknMFYWaeTNbww@mail.gmail.com>
 <ZxEsX9aAtqN2CbAj@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEsX9aAtqN2CbAj@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 17-10-24 08:25:19, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 11:15:49AM -0400, Paul Moore wrote:
> > Also good to know, thanks.  However, at this point the lack of a clear
> > answer is making me wonder a bit more about inode numbers in the view
> > of VFS developers; do you folks care about inode numbers?
> 
> The VFS itself does not care much about inode numbers.  The Posix API
> does, although btrfs ignores that and seems to get away with that
> (mostly because applications put in btrfs-specific hacks).

Well, btrfs plays tricks with *device* numbers, right? Exactly so that
st_ino + st_dev actually stay unique for each file. Whether it matters for
audit I don't dare to say :). Bcachefs does not care and returns non-unique
inode numbers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

