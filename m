Return-Path: <linux-fsdevel+bounces-8774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7583AD01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 16:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE77F2820F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27077629;
	Wed, 24 Jan 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sHo4E0Ko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="epeZxTDu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sHo4E0Ko";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="epeZxTDu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175C43154
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109423; cv=none; b=KErAJXVwPzt6+eoyrQjybaH7VWXUHM1kPavDQvxcow83G7YM6qPsoUFZw0/uHjILidfgz280jNOg3ONz9rMa5KFI2jiv3oVyVeK/QSTgxlVmKOBvM4lv7DONZbAz3Ia0hTw8kls7QKPTUugJOIDE9mU6fIItrds+Vh2TZK7iJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109423; c=relaxed/simple;
	bh=cjavVpA5TlgigYNfsA61sEqTnULm9JzRePcccI3tpzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dsg7pnRlCnYXYKHy6F7Udvkwojyk3jynY75nifXapoHtGlgfYWq0EFPO2YGzss/Aj7G4OKuklloa06NjlwNqgG0nsvmZDrSL7Ro3PNWfzK0CHsUq0jFb5spxj/Igf8eTSbrFTbREDzoBp+hH67AVMyKIS0BoPHT3ATuCxcFfpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sHo4E0Ko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=epeZxTDu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sHo4E0Ko; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=epeZxTDu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44D9321F7E;
	Wed, 24 Jan 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706109420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmXTEWXg/jmVu3QmZvYE/MXf/h24ACUlF744fyeLq6k=;
	b=sHo4E0KofdEZAzSsFew92MyFRM18xgd/w1jTvr1Syji1dk2Nx1scVj91zDLd9QmUAwAoPk
	kYR7hJ+Y/Fy1XnKqF2tuPyw+bA0TtJW9UbgdsLyy/jBU/i4CGPAptIUrWNCjdWmclR3sRA
	gWfHK8Sd72RwAVRYqTDDiHitxn6+hSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706109420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmXTEWXg/jmVu3QmZvYE/MXf/h24ACUlF744fyeLq6k=;
	b=epeZxTDubsLqNf9gTUWbkiuCAEcrLBCOMuhD1Murht6A6HLFMCeqUP+h3yyhI48mUvEAfe
	P+uri89ES22n1uAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706109420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmXTEWXg/jmVu3QmZvYE/MXf/h24ACUlF744fyeLq6k=;
	b=sHo4E0KofdEZAzSsFew92MyFRM18xgd/w1jTvr1Syji1dk2Nx1scVj91zDLd9QmUAwAoPk
	kYR7hJ+Y/Fy1XnKqF2tuPyw+bA0TtJW9UbgdsLyy/jBU/i4CGPAptIUrWNCjdWmclR3sRA
	gWfHK8Sd72RwAVRYqTDDiHitxn6+hSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706109420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NmXTEWXg/jmVu3QmZvYE/MXf/h24ACUlF744fyeLq6k=;
	b=epeZxTDubsLqNf9gTUWbkiuCAEcrLBCOMuhD1Murht6A6HLFMCeqUP+h3yyhI48mUvEAfe
	P+uri89ES22n1uAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DAA313786;
	Wed, 24 Jan 2024 15:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NWMMD+wpsWVJDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jan 2024 15:17:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08330A0807; Wed, 24 Jan 2024 16:17:00 +0100 (CET)
Date: Wed, 24 Jan 2024 16:16:59 +0100
From: Jan Kara <jack@suse.cz>
To: Carlos Maiolino <cem@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enable support for tmpfs quotas
Message-ID: <20240124151659.cd3f5fcadryxjv7t@quack3>
References: <20240109134651.869887-1-cem@kernel.org>
 <20240109134651.869887-4-cem@kernel.org>
 <gWO_6455WDo9j0nGP5RMvQ8C6kbvXksXMUIN7sy-MEITH9dK6p49_3nU1AqQVqIxP0lk6RA7vMSIkcaT3EMlFw==@protonmail.internalid>
 <20240117175954.jikporwmchenbkrk@quack3>
 <ozwso3vxlqvhncphhxdmqyhtcdjkngdm3zkthhdr2otr2jhbcf@vy57quyazjv5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ozwso3vxlqvhncphhxdmqyhtcdjkngdm3zkthhdr2otr2jhbcf@vy57quyazjv5>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sHo4E0Ko;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=epeZxTDu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.54 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.53)[80.42%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.54
X-Rspamd-Queue-Id: 44D9321F7E
X-Spam-Flag: NO

On Wed 24-01-24 12:42:39, Carlos Maiolino wrote:
> On Wed, Jan 17, 2024 at 06:59:54PM +0100, Jan Kara wrote:
> > On Tue 09-01-24 14:46:05, cem@kernel.org wrote:
> > > diff --git a/quotasys.c b/quotasys.c
> > > index 903816b..1f66302 100644
> > > --- a/quotasys.c
> > > +++ b/quotasys.c
> > > @@ -1384,7 +1390,11 @@ alloc:
> > >  			continue;
> > >  		}
> > >
> > > -		if (!nfs_fstype(mnt->mnt_type)) {
> > > +		/*
> > > +		 * If devname and mnt->mnt_fsname matches, there is no real
> > > +		 * underlyin device, so skip these checks
> > > +		 */
> > > +		if (!nfs_fstype(mnt->mnt_type) && strcmp(devname, mnt->mnt_fsname)) {
> > >  			if (stat(devname, &st) < 0) {	/* Can't stat mounted device? */
> > >  				errstr(_("Cannot stat() mounted device %s: %s\n"), devname, strerror(errno));
> > >  				free((char *)devname);
> > 
> > I'm a bit uneasy about the added check because using device name the same
> > as filesystem name is just a common agreement but not enforced in any way.
> > So perhaps just add an explicit check for tmpfs? Later we can generalize
> > this if there are more filesystems like this...
> 
> What about adding a new tmpfs_fstype() helper, to mimic nfs_fstype, and use it
> here? like:
> 
> if (!nfs_fstype(mnt->mnt_type) && tmpfs_fstype(mnt->mnt_type))) {
> 	/* skipe S_ISBLK && S_ISCHR checks */
> }
> 
> We could open code !strcmp(mnt->mnt_type, MNTTYPE_TMPFS), but it seems to me
> adding a new tmpfs_fstype() helper is easier on the eyes, and also OCFS2 does
> something similar.
> 
> Perhaps that's exactly what you meant as having an explicit check for tmpfs, but
> I'm not really sure?!

Yes, this would be a nice way of doing it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

