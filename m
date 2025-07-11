Return-Path: <linux-fsdevel+bounces-54658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20460B01EF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED6C646A45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A7E2E6122;
	Fri, 11 Jul 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iX1o9G0t";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZczmLcnk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Q0gC33a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zb1CZyGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9333A2E499A
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243633; cv=none; b=pY3B5ew/A5AzQZp6BEL8d3RTATkWd/OUee+C2GOjhDF1AL9/v0EO+GGMXCOL8aPZFd4Q9hg3MEkaQkuxXJM/lGuFkYdG3ptjKF3JtaG2zMPLjB+ZcNOLXGjvakhhOs5OsvmewdjC6Yyx557b/gQdQfx6UatmIIIzYyDnRHWI4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243633; c=relaxed/simple;
	bh=7s+5lhis6FojblF1jV+jgSnHEfFQLJl9si9HXVwN8ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0eTNLNOOac9Thg9oYEvzJ/i6so6Mrc4rCEXsg+dA9TZHEngSDPbHU4y0aCrZvsZiy81tAI7M20FB+2IKwDa9bV4FluW3A9K3x295IzYkcRaH0LPmqu4RWn+YJeqjZmrY8x4G0AAMSfOmWN/TfVx4Eh6QBpsMsaDGnsXkC6C9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iX1o9G0t; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZczmLcnk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Q0gC33a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zb1CZyGS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED3021F451;
	Fri, 11 Jul 2025 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752243630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/iUuBciPB10/GBE/cvyXk+fAHjQFIQzuLxCgcwiNTw=;
	b=iX1o9G0tQdGrIsFeduAag1UKYp0cCjcMneL5vkrGGsPO92IZ2wxRp3jlmkahOOPG6WWUdv
	kphrQqTmuCs0hFXOYtVS/MTvH2l2OLesUm41gQ9wmp2cCzNfPFtwMVQvJjSqo+rsQgFnL2
	AMVwa6gD0pvN07DATLyiZYLUdKljBsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752243630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/iUuBciPB10/GBE/cvyXk+fAHjQFIQzuLxCgcwiNTw=;
	b=ZczmLcnkQK5dNLlNTg8btwaNoh3cOk1Vp66mW8PYqJOkMEfNWn+8CqQJvQTp6bEmbseXU7
	uZsBkQaJmbIzZ5CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752243629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/iUuBciPB10/GBE/cvyXk+fAHjQFIQzuLxCgcwiNTw=;
	b=0Q0gC33a1LGOhCbS2e7YuGBLzHB9x14F4WpfW+gopjwadYEbCJBLsXBX1lrlouwrAzrte8
	Ja2l7L3cX4rIo5fBm9TI3OIj2eDgYJhQcbpHguaCI/kUbudLCh5yRivfoo+5PhBxoWhjQZ
	cz2QUREuEnRdT0PPcT2EjFDPWJ86WlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752243629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D/iUuBciPB10/GBE/cvyXk+fAHjQFIQzuLxCgcwiNTw=;
	b=zb1CZyGS3J1toAy5quPu7DqexLZJc5vm8joEbFL90hWTmpTZCle3U5zFrK6F+5uIBXY376
	tOkCVn3qxUstlVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9000138A5;
	Fri, 11 Jul 2025 14:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qT+vNK0dcWjEUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 14:20:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57DE8A099A; Fri, 11 Jul 2025 16:20:24 +0200 (CEST)
Date: Fri, 11 Jul 2025 16:20:24 +0200
From: Jan Kara <jack@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 1/6] fs: enhance and rename shutdown() callback to
 remove_bdev()
Message-ID: <icnwgogkmgui2kzshst23dujkqdghiwpd62giipxyrbdkyf6bo@lf52wyqpnxn2>
References: <343vlonfhw76mnbjnysejihoxsjyp2kzwvedhjjjml4ccaygbq@72m67s3e2ped>
 <y2rpp6u6pksjrzgxsn5rtcsl2vspffkcbtu6tfzgo7thn7g23p@7quhaixfx5yh>
 <kgolzhhd47x3iqkdrwyzh65ng4mm6cauxdjgiao2otztncyc3f@rskadwaph2l5>
 <5xno4s25lsd2sqq6judn7moorgy2h3konejgassnzlccfa6jsf@ez6ciofy3bwp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5xno4s25lsd2sqq6judn7moorgy2h3konejgassnzlccfa6jsf@ez6ciofy3bwp>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,fromorbit.com,kernel.org,gmx.com,suse.com,vger.kernel.org,zeniv.linux.org.uk,lists.sourceforge.net,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 10-07-25 14:41:18, Kent Overstreet wrote:
> On Thu, Jul 10, 2025 at 03:10:04PM +0200, Jan Kara wrote:
> > On Wed 09-07-25 13:49:12, Kent Overstreet wrote:
> > > On Wed, Jul 09, 2025 at 07:23:07PM +0200, Jan Kara wrote:
> > > > > It also avoids the problem of ->mark_dead events being generated
> > > > > from a context that holds filesystem/vfs locks and then deadlocking
> > > > > waiting for those locks to be released.
> > > > > 
> > > > > IOWs, a multi-device filesystem should really be implementing
> > > > > ->mark_dead itself, and should not be depending on being able to
> > > > > lock the superblock to take an active reference to it.
> > > > > 
> > > > > It should be pretty clear that these are not issues that the generic
> > > > > filesystem ->mark_dead implementation should be trying to
> > > > > handle.....
> > > > 
> > > > Well, IMO every fs implementation needs to do the bdev -> sb transition and
> > > > make sb somehow stable. It may be that grabbing s_umount and active sb
> > > > reference is not what everybody wants but AFAIU btrfs as the second
> > > > multi-device filesystem would be fine with that and for bcachefs this
> > > > doesn't work only because they have special superblock instantiation
> > > > behavior on mount for independent reasons (i.e., not because active ref
> > > > + s_umount would be problematic for them) if I understand Kent right.
> > > > So I'm still not fully convinced each multi-device filesystem should be
> > > > shipping their special method to get from device to stable sb reference.
> > > 
> > > Honestly, the sync_filesystem() call seems bogus.
> > > 
> > > If the block device is truly dead, what's it going to accomplish?
> > 
> > Notice that fs_bdev_mark_dead() calls sync_filesystem() only in case
> > 'surprise' argument is false - meaning this is actually a notification
> > *before* the device is going away. I.e., graceful device hot unplug when
> > you can access the device to clean up as much as possible.
> 
> That doesn't seem to be hooked up to anything?

__del_gendisk()
  if (!test_bit(GD_DEAD, &disk->state))
    blk_report_disk_dead(disk, false);

Is the path which results in "surprise" to be false. I have to admit I
didn't check deeper into drivers whether this is hooked up properly but
del_gendisk() is a standard call to tear down a disk so it would seem so
from the first glance.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

