Return-Path: <linux-fsdevel+bounces-76704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAicNOvViWnSCAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:41:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 703CB10ED92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89BB3025D3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197DC37754A;
	Mon,  9 Feb 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tt+JCz1k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s+hQOvm3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tt+JCz1k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s+hQOvm3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E8371056
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640835; cv=none; b=nV/zIeAuOp1SW5f+8y4R3CyGbpQ+DYiOU26h0nMFpdDolTTlHNp64lfbh7qKk+BTyAuF3vDmVljRYH0w1Do3BGoRASyDrrPPiW/97VDpazqW1q5zBt1Cyp6KipVGsMP3I2Wxy6oVC0D0Mc2Um3eemFXady3LUOcfetybdmFo7Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640835; c=relaxed/simple;
	bh=yI3u//vBdWx2BaZQ1RAgQvvWBfiBBYiapioydyEgKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqfkS+Hy3ciKjPWfBlCw2tX54hrenN1Xr6I41IwRAv7qm2CYKCWoh1+TA+Z+i4Dba0OmYFMaHT43/4JQD7iwLGu8pmq4rqAcbPVbUepgin5R+qLZRSOb0/MHR1guhobE4/qZ7r3ndcXg+vVKIoEvuNDecTauX4T94+Q2nkpWORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tt+JCz1k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s+hQOvm3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tt+JCz1k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s+hQOvm3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9ED2F3E6EC;
	Mon,  9 Feb 2026 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770640833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Na+HxXIZHLwz0vzGFP/yFenyJnbkM+tOgzY/3G4Grk=;
	b=tt+JCz1kUWhVP+fGqL4G5h0CgRgspFfqWfB+2zIPXPadMnjExdIhd45U9mQdneUzBEwtCd
	TcWsr4lAAVIrW/yJyZTJ6YiXDPaByOBftyV45EYM/5fK586IBotEETf4tp6uz3BN520QMr
	qt1YIXzzoWDAoSeK3+q0hK6/JSqY2xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770640833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Na+HxXIZHLwz0vzGFP/yFenyJnbkM+tOgzY/3G4Grk=;
	b=s+hQOvm3X8XlysacRX6ZKOh87TDwLoNyra1jJtDcgt/VcPJHdSSoN2xnESL4nvJYWcY5BU
	l58kPgC764E74iBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770640833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Na+HxXIZHLwz0vzGFP/yFenyJnbkM+tOgzY/3G4Grk=;
	b=tt+JCz1kUWhVP+fGqL4G5h0CgRgspFfqWfB+2zIPXPadMnjExdIhd45U9mQdneUzBEwtCd
	TcWsr4lAAVIrW/yJyZTJ6YiXDPaByOBftyV45EYM/5fK586IBotEETf4tp6uz3BN520QMr
	qt1YIXzzoWDAoSeK3+q0hK6/JSqY2xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770640833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Na+HxXIZHLwz0vzGFP/yFenyJnbkM+tOgzY/3G4Grk=;
	b=s+hQOvm3X8XlysacRX6ZKOh87TDwLoNyra1jJtDcgt/VcPJHdSSoN2xnESL4nvJYWcY5BU
	l58kPgC764E74iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8961D3EA63;
	Mon,  9 Feb 2026 12:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c+59IcHViWkVWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Feb 2026 12:40:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 46D84A0A4C; Mon,  9 Feb 2026 13:40:25 +0100 (CET)
Date: Mon, 9 Feb 2026 13:40:25 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, Linux NFS list <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] xattr caching
Message-ID: <jejqzlpcrvn256yfultni2twn5nzehvbelw7ukairf5ntdqcs2@j44pqhuze6rq>
References: <CAJfpegu0PrfCemFdimcvDfw6BZ2R5=kaZ=Zrt6U5T37W=mfEAw@mail.gmail.com>
 <z24xrtha2ha4ppxomzcqzdkevgtpoiazwb2aehfocyfqwnhkoe@clrijunqda67>
 <CAJfpegvjEzu_mgDaKgNQcnpES8vNu0d+UniS65UFQMsKcaH55w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvjEzu_mgDaKgNQcnpES8vNu0d+UniS65UFQMsKcaH55w@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76704-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 703CB10ED92
X-Rspamd-Action: no action

On Mon 09-02-26 13:26:54, Miklos Szeredi wrote:
> On Mon, 9 Feb 2026 at 12:28, Jan Kara <jack@suse.cz> wrote:
> 
> > As you write below, accessing xattrs is relatively rare.
> 
> I was referring to large xattrs.   Small (<1k) sized xattrs are quite
> common I think.
> 
> > Also frequently
> > accessed information stored in xattrs (such as ACLs) are generally cached
> > in the layer handling them.
> 
> Yes, that's true of most system.* xattrs.  But user (and trusted)
> xattrs are generally not cached.

Right.

> > Finally, e.g. ext4 ends up caching xattrs in
> > the buffer cache / page cache as any other metadata. So I guess the
> > practical gains from such layer won't be generally big?
> 
> For network fs and userspace fs caching would be a clear win.,
> 
> For local fs I guess it depends on a number of factors.  I'll do an
> xattr benchmark.

I agree and frankly I have no doubts you can speed up xattr fetching with
targetted caching layer even for local fs. Just I don't see a realistic
workload where the gain would matter... But maybe I just lack imagination
:).

> > As I wrote above, I'm just not sure about the load that would measurably
> > benefit from this. Otherwise it sounds as a fine idea.
> 
> I'm not saying all fs should be converted.  But NFS already has an
> xattr cache, and fuse definitely would benefit from one, while tmpfs
> "lives in the cache".  So there'd be at least three users and possibly
> more.

OK, I was under the impression you wanted to convert local filesystems as
well and there I'm not sure about the benefit. Unifying NFS, fuse and tmpfs
would definitely make sense to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

