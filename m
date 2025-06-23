Return-Path: <linux-fsdevel+bounces-52548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A37AE40CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D76C176E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A73248F7B;
	Mon, 23 Jun 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W5NjTwk1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ofTeHypR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8kmHPIC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0Vkkfnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9491248F6E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682471; cv=none; b=J/g5dQA6NIfrDpUql2uFEnEKwxN+7mRmLW8Gxyih2Ev/SOzj4rXsEwemZfsUs40eRD5sd06N3aoiIQbvr4piEwAYQMqt0D7Hb8Q98YP1bN9qfVsqUh1nnuhAhg0tlvg85Svo7S3Bto0+3UWlHuF/ihgjLjQK7DnwMZN3zmVOs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682471; c=relaxed/simple;
	bh=umxd6BsDK9bqH7B+W+BVKjMcZMEwGgjNN0QozZbDpac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teAmFxm750oEJ8SmB+feRKcRxaMl3HDMG4WF8/btUViUKyTBM67lFJcIocTDannDghwN78m4gyX3VwfzJWJq98kzMCfrXmbqeABUHMTXIfcHs0WdlGAHbc/w59h1Sb9Nv+J5LeZlbA/knZ4uw0jQV9OYBhWNkKRCkwvzsSRRKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W5NjTwk1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ofTeHypR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8kmHPIC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0Vkkfnj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFE171F76B;
	Mon, 23 Jun 2025 12:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750682465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxQzPb4aSTXlZtspBn58ixUsslIjkgDDedKl2aUcB0=;
	b=W5NjTwk1ukmTpSfbiDVuR4IDrR0G1XerF3iRqD5W0lI6ryUzXsIg4dVLvBCH4PenwDElZW
	eXXnMp1gCSys1F7L/MoSgPpE9rxqQYeXff2ej6IHIjjBVrHLO4t++4fuphDmF41ey2kSUD
	WqEWvhD9fzVoZbTyxHgIR6cCW7T9joI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750682465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxQzPb4aSTXlZtspBn58ixUsslIjkgDDedKl2aUcB0=;
	b=ofTeHypRbVr1l0Dhz8rKfoffoEYz7c8Rj/XWmn0qrpn1R4sQNsbqh6bhSHnnVxklMx6DVy
	n7m7R2AgYQDY2HCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=y8kmHPIC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a0Vkkfnj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750682463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxQzPb4aSTXlZtspBn58ixUsslIjkgDDedKl2aUcB0=;
	b=y8kmHPICYfEaXXsP+JQpx294/K5CIchfNQ9I3LK7gLEstorufouavTR2p6hntnrIy9okMU
	yjA4kUapfvTmGENG4slQobrv5Jfwvjbht446vnB19J44vD2sMn8Pbpynsj42rtZmtD7djL
	VlZNqP5ha18l+ZRGvoG3uaGKa5h5zNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750682463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGxQzPb4aSTXlZtspBn58ixUsslIjkgDDedKl2aUcB0=;
	b=a0VkkfnjXIVKbiTr5pnSMiFuTyIqqNPV/WzPOUDO2y8GQd+VH77AGtOjVgbPc6WQF1hPoz
	rj+wdCw8ff4JhnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8FC913485;
	Mon, 23 Jun 2025 12:41:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v4tiNF9LWWhYRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 12:41:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D139A09BE; Mon, 23 Jun 2025 14:41:02 +0200 (CEST)
Date: Mon, 23 Jun 2025 14:41:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/9] exportfs: add FILEID_PIDFS
Message-ID: <lo73q6ovi2m2skguq5ydedz2za4vud747ztwfxwzn33r3do7ia@p7y3sbyrznfi>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
 <20250623-work-pidfs-fhandle-v1-6-75899d67555f@kernel.org>
 <y6yp3ldhmmtl6mzr2arwr5fggzrlffc2pzvqbr7jkabqm5zm3u@6pwl22ctaxkx>
 <20250623-herzrasen-geblickt-9e2befc82298@brauner>
 <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxid1=97dZSZPB_4W5pocoU4cU-7G6WJ_4KQSGobZ_72xA@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EFE171F76B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 23-06-25 14:22:26, Amir Goldstein wrote:
> On Mon, Jun 23, 2025 at 1:58 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 23, 2025 at 01:55:38PM +0200, Jan Kara wrote:
> > > On Mon 23-06-25 11:01:28, Christian Brauner wrote:
> > > > Introduce new pidfs file handle values.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  include/linux/exportfs.h | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > > > index 25c4a5afbd44..45b38a29643f 100644
> > > > --- a/include/linux/exportfs.h
> > > > +++ b/include/linux/exportfs.h
> > > > @@ -99,6 +99,11 @@ enum fid_type {
> > > >      */
> > > >     FILEID_FAT_WITH_PARENT = 0x72,
> > > >
> > > > +   /*
> > > > +    * 64 bit inode number.
> > > > +    */
> > > > +   FILEID_INO64 = 0x80,
> > > > +
> > > >     /*
> > > >      * 64 bit inode number, 32 bit generation number.
> > > >      */
> > > > @@ -131,6 +136,12 @@ enum fid_type {
> > > >      * Filesystems must not use 0xff file ID.
> > > >      */
> > > >     FILEID_INVALID = 0xff,
> > > > +
> > > > +   /* Internal kernel fid types */
> > > > +
> > > > +   /* pidfs fid types */
> > > > +   FILEID_PIDFS_FSTYPE = 0x100,
> > > > +   FILEID_PIDFS = FILEID_PIDFS_FSTYPE | FILEID_INO64,
> > >
> > > What is the point behind having FILEID_INO64 and FILEID_PIDFS separately?
> > > Why not just allocate one value for FILEID_PIDFS and be done with it? Do
> > > you expect some future extensions for pidfs?
> >
> > I wouldn't rule it out, yes. This was also one of Amir's suggestions.
> 
> The idea was to parcel the autonomous fid type to fstype (pidfs)
> which determines which is the fs to decode the autonomous fid
> and a per-fs sub-type like we have today.
> 
> Maybe it is a bit over design, but I don't think this is really limiting us
> going forward, because those constants are not part of the uapi.

OK, I agree these file handles do not survive reboot anyway so we are free
to redefine the encoding in the future. So it is not a big deal (but it
also wouldn't be a big deal to start simple and add some subtyping in the
future when there's actual usecase). But in the current patch set we have
one flag FILEID_IS_AUTONOMOUS which does provide this subtyping and then
this FILEID_PIDFS_FSTYPE which doesn't seem to be about subtyping but about
pidfs expecting some future extensions and wanting to recognize all its
file handle types more easily (without having to enumerate all types like
other filesystems)? My concern is that fh_type space isn't that big and if
every filesystem started to reserve flag-like bits in it, we'd soon run out
of it. So I don't think this is a great precedens although in this
particular case I agree it can be modified in the future if we decide so...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

