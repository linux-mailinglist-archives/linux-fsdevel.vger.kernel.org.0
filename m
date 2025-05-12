Return-Path: <linux-fsdevel+bounces-48761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 954DBAB3F40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09396189D234
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CA2254AF7;
	Mon, 12 May 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqR3eJW8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="og9SZLqU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5AxjwAT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yiEimHsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03A23C4FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071211; cv=none; b=urMLjs7X7hppnfU2z11i5a3vjsYbMSrMcDiHgzXx+wB4fITSkOjoHDo9vKgivmaiTGbdeNSbkQwK3fURx05YzE6gqxCaX3h7qyyf6ykPQQOd7Z6v+x/0bsYNyyLyPl5Z7wDfRcLfnUoCmt+PUrIin0LC9vvxMvDOL4zmq+NJCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071211; c=relaxed/simple;
	bh=r//yglxmzlx6+RQNu8+pmUsJoTPf7DXFCrVR2yUdi0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlS36KvFyeg6uUcji6l2AMBgcGB7db2D2VNBNceXNeecluuNvoMZ0XnfiwoW1XXKOJlobkhNLfLyQTpIetAFTxt3oxI00DK3uj0ZKJhLWLOyruU4rsLaGQoLk/hXF7smY+nibLmoVubJpGUSWkvglqmy9oPmoycU8tdPDflMnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqR3eJW8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=og9SZLqU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5AxjwAT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yiEimHsd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 357732117F;
	Mon, 12 May 2025 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYl1jrwNDXmOPi5p2P9O/OvhauybKN2oOHVU51RJia4=;
	b=lqR3eJW8+Sz18ENRLFGuCUz3MnH/ywkD9A+j48tRk0fYhsOC3vEbw/99Fx43aptZwEEOBL
	tLTGbwOpwIbMSxHpq7QL6pHyyMl8W1jbbNEA+CuK0L2KW+Fld/cIZmFIKRrniHUwTy/jz4
	eamRpprwIcoMA2MtCHqrRi8t8YYJ54I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYl1jrwNDXmOPi5p2P9O/OvhauybKN2oOHVU51RJia4=;
	b=og9SZLqU1OzAjWYjmSlB9H1e+Dru08rPCMsATtPsj0TqQp4L8+/i2s4re784l1ZSJdCAjJ
	QragGl501sN4UvBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u5AxjwAT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yiEimHsd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747071207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYl1jrwNDXmOPi5p2P9O/OvhauybKN2oOHVU51RJia4=;
	b=u5AxjwATbqtv5NSBEYYpbkFYuZS1ok1t+q0cZJrF+Xipcm1QuvE5LgQ+lMO7EpgoYgtny7
	qC4dgpR4TS3T8+HxgL/aynHN/TYN2pcaJnglDK5n7mSwMaUXvEVvhprKYqQI8wOFvlTNFE
	qxaRW4NRe2eGUnxHWD7zloPmbA5NcR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747071207;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RYl1jrwNDXmOPi5p2P9O/OvhauybKN2oOHVU51RJia4=;
	b=yiEimHsdmAyNzGnWBuy6+bPfJxHzAsUqoh+lM2p40WNDhx+tt+Qv33nkZA8fwLosaZmDVz
	WVcOHK95rpobUKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28EC1137D2;
	Mon, 12 May 2025 17:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RUbzCecwImiwdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 May 2025 17:33:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84AE8A07C1; Mon, 12 May 2025 19:33:13 +0200 (CEST)
Date: Mon, 12 May 2025 19:33:13 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Max Kellermann <max.kellermann@ionos.com>, jack@suse.cz, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: make several inode lock operations killable
Message-ID: <hzrj5b7x3rvtxt4qgjxdihhi5vjoc5gw3i35pbyopa7ccucizo@q5c42kjlkly3>
References: <20250429094644.3501450-1-max.kellermann@ionos.com>
 <20250429094644.3501450-2-max.kellermann@ionos.com>
 <20250429-anpassen-exkremente-98686d53a021@brauner>
 <CAKPOu+8H11mcMEn5gQYcJs5BhTt8J8Cypz73Vdp_tTHZRXgOKg@mail.gmail.com>
 <20250512-unrat-kapital-2122d3777c5d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-unrat-kapital-2122d3777c5d@brauner>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 357732117F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 12-05-25 11:52:14, Christian Brauner wrote:
> On Tue, Apr 29, 2025 at 01:28:49PM +0200, Max Kellermann wrote:
> > On Tue, Apr 29, 2025 at 1:12 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > --- a/fs/read_write.c
> > > > +++ b/fs/read_write.c
> > > > @@ -332,7 +332,9 @@ loff_t default_llseek(struct file *file, loff_t offset, int whence)
> > > >       struct inode *inode = file_inode(file);
> > > >       loff_t retval;
> > > >
> > > > -     inode_lock(inode);
> > > > +     retval = inode_lock_killable(inode);
> > >
> > > That change doesn't seem so obviously fine to me.
> > 
> > Why do you think so? And how is this different than the other two.
> 
> chown_common() and chmod_common() are very close to the syscall boundary
> so it's very unlikely that we run into weird issues apart from userspace
> regression when they suddenly fail a change for new unexpected reasons.
> 
> But just look at default_llseek():
> 
>     > git grep default_llseek | wc -l
>     461
> 
> That is a lot of stuff and it's not immediately clear how deeply or
> nested they are called. For example from overlayfs in stacked
> callchains. Who knows what strange assumptions some of the callers have
> including the possible return values from that helper.
> 
> > 
> > > Either way I'd like to see this split in three patches and some
> > > reasoning why it's safe and some justification why it's wanted...
> > 
> > Sure I can split this patch, but before I spend the time, I'd like us
> > first to agree that the patch is useful.
> 
> This is difficult to answer. Yes, on the face of it it seems useful to
> be able to kill various operations that sleep on inode lock but who
> knows what implicit guarantees/expectations we're going to break if we
> do it. Maybe @Jan has some thoughts here as well.

So I think having lock killable is useful and generally this should be safe
wrt userspace (the process will get killed before it can notice the
difference anyway). The concern about guarantees / expectations is still
valid for the *kernel* code (which is I think what you meant above). So I
guess some audit of kernel paths that can end up calling ->llseek handler
and whether they are OK with the handler returning EINTR is needed. I
expect this will be fine but I would not bet too much on it :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

