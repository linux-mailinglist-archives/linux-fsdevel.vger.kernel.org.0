Return-Path: <linux-fsdevel+bounces-33901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39A19C04FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 12:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84EE7283AAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC220EA3B;
	Thu,  7 Nov 2024 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIgOqPzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0a1Ggw0y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IIgOqPzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0a1Ggw0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEAD1D95B0;
	Thu,  7 Nov 2024 11:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730980630; cv=none; b=oL0bxyS1tzm1eC4Nh/nNxBMMMz63cel9enSDyEWnauLbhZ3/DWKwKmrM56kLjs1uuTwBBKb61q93bw+enDkpU4UtWkfvk67s6XYJvg1JPB97AiwZBoZKbRJGN9EJ5t8aUcv2tmgbU9NMXkJbfBT8mtO68ys5I/1bktmysUQbEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730980630; c=relaxed/simple;
	bh=udQ/sPdlIykPtOFu2sX60RjE9XvF3n2v5wDLKwVyes8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLKEdhmcJODMcMpKslslcEhZ1gfs5S+269VNdXYWNPHSp4+alOR+ZDsEkPZY5VAemn10VzvqKpd/XFFGBYy00bibrWnQzkfD2uVc/MtZ0KrXR7+C6FeV/fDHWDzeFlz/YN07T5bsZ/uKv/JnHPCZwWP2h2S6nzOr0eR97LjyVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIgOqPzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0a1Ggw0y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IIgOqPzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0a1Ggw0y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70C271F8C1;
	Thu,  7 Nov 2024 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730980626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuj1f2a8c2cwLObYBuFKJ2C8VpfSRgaqfsW1+IrAf04=;
	b=IIgOqPzmqCRwlh/kODBkotVmsdq0twVnthrTx291TIq7M3bC1LrJ0MQPXtrFJmZ4FCbIFT
	eORDTAWap5kW70xq9Bdg1kd9MxFuXhOidsZEgHQJdUgix4ZNR4kv9sB1OFQT4b6M+w7nsy
	G83/1rZ4EM+zMnBr3+42a7lrGuEgVdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730980626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuj1f2a8c2cwLObYBuFKJ2C8VpfSRgaqfsW1+IrAf04=;
	b=0a1Ggw0ypjioKBAWxMGaTpp8fNYa8iaUwvON2ls3jiAzR38iumHn1dGg4oTxq73O9QzjwI
	6XUNN2sDW7qcwtCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IIgOqPzm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0a1Ggw0y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730980626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuj1f2a8c2cwLObYBuFKJ2C8VpfSRgaqfsW1+IrAf04=;
	b=IIgOqPzmqCRwlh/kODBkotVmsdq0twVnthrTx291TIq7M3bC1LrJ0MQPXtrFJmZ4FCbIFT
	eORDTAWap5kW70xq9Bdg1kd9MxFuXhOidsZEgHQJdUgix4ZNR4kv9sB1OFQT4b6M+w7nsy
	G83/1rZ4EM+zMnBr3+42a7lrGuEgVdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730980626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iuj1f2a8c2cwLObYBuFKJ2C8VpfSRgaqfsW1+IrAf04=;
	b=0a1Ggw0ypjioKBAWxMGaTpp8fNYa8iaUwvON2ls3jiAzR38iumHn1dGg4oTxq73O9QzjwI
	6XUNN2sDW7qcwtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 616B9139B3;
	Thu,  7 Nov 2024 11:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /R18FxKrLGdqJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 11:57:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B267A0AF4; Thu,  7 Nov 2024 12:57:02 +0100 (CET)
Date: Thu, 7 Nov 2024 12:57:01 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fs: add the ability for statmount() to report the
 mount devicename
Message-ID: <20241107115701.ueeykzbel22sdr2f@quack3>
References: <20241106-statmount-v2-0-93ba2aad38d1@kernel.org>
 <20241106-statmount-v2-2-93ba2aad38d1@kernel.org>
 <20241107094040.2gcshh466b7zslva@quack3>
 <7554bd2b13330f8b44b23b775dd4d611ad6cdcae.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7554bd2b13330f8b44b23b775dd4d611ad6cdcae.camel@kernel.org>
X-Rspamd-Queue-Id: 70C271F8C1
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 07-11-24 06:15:40, Jeff Layton wrote:
> On Thu, 2024-11-07 at 10:40 +0100, Jan Kara wrote:
> > On Wed 06-11-24 14:53:06, Jeff Layton wrote:
> > > /proc/self/mountinfo displays the devicename for the mount, but
> > > statmount() doesn't yet have a way to return it. Add a new
> > > STATMOUNT_MNT_DEVNAME flag, claim the 32-bit __spare1 field to hold the
> > > offset into the str[] array. STATMOUNT_MNT_DEVNAME will only be set in
> > > the return mask if there is a device string.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > 
> > Just one question below:
> > 
> > > @@ -5078,6 +5091,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
> > >  		if (seq->count == sm->fs_subtype)
> > >  			return 0;
> > >  		break;
> > > +	case STATMOUNT_MNT_DEVNAME:
> > > +		sm->mnt_devname = seq->count;
> > > +		ret = statmount_mnt_devname(s, seq);
> > > +		if (seq->count == sm->mnt_devname)
> > 
> > Why this odd check? Why don't you rather do:
> > 		if (ret)
> > ?
> >
> 
> statmount_mnt_devname() can return without emitting anything to the seq
> if ->show_devname and r->mnt_devname are both NULL. In that case, we
> don't want statmount_string() to return an error, but we also don't
> want to do any further manipulation of the seq. So, the above handles
> either the case where show_devname returned an error and the case where
> there was nothing to emit.
> 
> I did consider having statmount_mnt_devname() return -ENOBUFS if there
> was nothing to emit, and then handle that in the caller, but checking
> to see whether the seq has advanced seemed like a cleaner solution.

OK, but don't we want to emit an empty string - i.e., just \0 character in
case r->mnt_devname is NULL and there's no ->show_devname? Because now we
literaly emit nothing and it's going to be very confusing for userspace to
parse this when this happens in the middle of other strings in the seq.
And emitting \0 is exactly what will happen if we don't do anything special
in STATMOUNT_MNT_DEVNAME case...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

