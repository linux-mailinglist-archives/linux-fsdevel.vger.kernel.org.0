Return-Path: <linux-fsdevel+bounces-25444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40894C31F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0281F2176F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CCA190492;
	Thu,  8 Aug 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkYPIoW7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWndcGU4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkYPIoW7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWndcGU4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B4190470
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136272; cv=none; b=u492G4F7PH/2ZbVKRnGIr13S9sF8RDC71feLCFjA2qEKddfGNHLeFRnM3wteZdmqtlNNx+ayPqDpOO9Uf3KSQvomz/U036E9UxvYhYgS74GnOjQyhG2H/a+HKNoojlMG6kFySrlOEx9h2aVgtWegUDhffZCdMSOruSy5bRKeOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136272; c=relaxed/simple;
	bh=AN4bbGXaPGoAkdoWNT5s4r7vEn5yuigAH2Dgin5P77w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5ZjSmvrRyka7Mu+sCUrqfHBwHCXp2iFLKrNs8g+FyniC1V0KvKvwetGdw0Q6KzPzgzFUCpeNmMMUACXetzf7SX7U/XmmHGQtA+fMpjUwrfrefsutlYUo3+eq5mEqj7aP+/UCAH7PeMYkDa10PRlxnNp4gH00A1csxzr1ZRadu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkYPIoW7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWndcGU4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkYPIoW7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWndcGU4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68C6021D58;
	Thu,  8 Aug 2024 16:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723136267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaukEdMzff6NG6Vxs6+B0BgkjdSaFfw7CXlNMZ+T58M=;
	b=EkYPIoW71lgcAeZJn3QgaV6PkHMVoNLntkCl7CWaAimL+Ix6TqgnXFyRGnMm+I1E8MCKVg
	pBUEUZOTjmQBHEEMgs+ietauLKicRojOsefzXtZcOv5teDa3Ro32qAB9ZqIqwethTHb4+B
	SWnfYAHBNfv3TUnN+DJCt9ofJtH9A88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723136267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaukEdMzff6NG6Vxs6+B0BgkjdSaFfw7CXlNMZ+T58M=;
	b=hWndcGU4P6ROGFikOleuKMBT2Yn3tAkwrfCQkbHrwijGnxcdvYJ1hEzgMXDuLee8JEZjOw
	Viq5HyTyjbsIgMDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EkYPIoW7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hWndcGU4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723136267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaukEdMzff6NG6Vxs6+B0BgkjdSaFfw7CXlNMZ+T58M=;
	b=EkYPIoW71lgcAeZJn3QgaV6PkHMVoNLntkCl7CWaAimL+Ix6TqgnXFyRGnMm+I1E8MCKVg
	pBUEUZOTjmQBHEEMgs+ietauLKicRojOsefzXtZcOv5teDa3Ro32qAB9ZqIqwethTHb4+B
	SWnfYAHBNfv3TUnN+DJCt9ofJtH9A88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723136267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZaukEdMzff6NG6Vxs6+B0BgkjdSaFfw7CXlNMZ+T58M=;
	b=hWndcGU4P6ROGFikOleuKMBT2Yn3tAkwrfCQkbHrwijGnxcdvYJ1hEzgMXDuLee8JEZjOw
	Viq5HyTyjbsIgMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4373B13C44;
	Thu,  8 Aug 2024 14:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LbszEPfWtGamBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Aug 2024 14:32:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA0D0A0851; Thu,  8 Aug 2024 16:32:22 +0200 (CEST)
Date: Thu, 8 Aug 2024 16:32:22 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH RFC 0/13] fs: generic filesystem shutdown handling
Message-ID: <20240808143222.4m56qw5jujorqrfv@quack3>
References: <20240807180706.30713-1-jack@suse.cz>
 <ZrQA2/fkHdSReAcv@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQA2/fkHdSReAcv@dread.disaster.area>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: 68C6021D58

On Thu 08-08-24 09:18:51, Dave Chinner wrote:
> On Wed, Aug 07, 2024 at 08:29:45PM +0200, Jan Kara wrote:
> > Hello,
> > 
> > this patch series implements generic handling of filesystem shutdown. The idea
> > is very simple: Have a superblock flag, which when set, will make VFS refuse
> > modifications to the filesystem. The patch series consists of several parts.
> > Patches 1-6 cleanup handling of SB_I_ flags which is currently messy (different
> > flags seem to have different locks protecting them although they are modified
> > by plain stores). Patches 7-12 gradually convert code to be able to handle
> > errors from sb_start_write() / sb_start_pagefault(). Patch 13 then shows how
> > filesystems can use this generic flag. Additionally, we could remove some
> > shutdown checks from within ext4 code and rely on checks in VFS but I didn't
> > want to complicate the series with ext4 specific things.
> 
> Overall this looks good. Two things that I noticed that we should
> nail down before anything else:
> 
> 1. The original definition of a 'shutdown filesystem' (i.e. from the
> XFS origins) is that a shutdown filesystem must *never* do -physical
> IO- after the shutdown is initiated. This is a protection mechanism
> for the underlying storage to prevent potential propagation of
> problems in the storage media once a serious issue has been
> detected. (e.g. suspect physical media can be made worse by
> continually trying to read it.) It also allows the block device to
> go away and we won't try to access issue new IO to it once the
> ->shutdown call has been complete.
> 
> IOWs, XFS implements a "no new IO after shutdown" architecture, and
> this is also largely what ext4 implements as well.

Thanks for sharing this. I wasn't aware that "no new IO after shutdown" is
the goal. I knew this is required for modifications but I wasn't sure how
strict this was for writes.

> However, this isn't what this generic shutdown infrastructure
> implements. It only prevents new user modifications from being
> started - it is effectively a "instant RO" mechanism rather than an
> "instant no more IO" architecture.
> 
> Hence we have an impedence mismatch between existing shutdown
> implementations that currently return -EIO on shutdown for all
> operations (both read and write) and this generic implementation
> which returns -EROFS only for write operations.
> 
> Hence the proposed generic shutdown model doesn't really solve the
> inconsistent shutdown behaviour problem across filesystems - it just
> adds a new inconsistency between existing filesystem shutdown
> implementations and the generic infrastructure.

OK, understood. I also agree it would be good to keep this no-IO semantics
when implementing the generic solution. I'm just pondering how to achieve
that in a maintainable way. For the write path what I've done looks like
the least painful way. For the read path the simplest is probably to still
return whatever is in cache and just do the check + error return somewhere
down in the call stack just before calling into filesystem. It is easy
enough to stop things like ->read_folio, ->readahead, or ->lookup. But how
about things like ->evict_inode or ->release?  They can trigger IO but
allowing inode reclaim on shutdown fs is desirable I'd say. Similarly for
things like ->remount_fs or ->put_super. So avoiding IO from operations
like these would rely on fs implementation anyway.

> 2. On shutdown, this patchset returns -EROFS.
> 
> As per #1, returning -EROFS on shutdown will be a significant change
> of behaviour for some filesystems as they currently return -EIO when
> the filesystem is shut down.
> 
> I don't think -EROFS is right, because existing shutdown behaviour
> also impacts read-only operations and will return -EIO for them,
> too.
> 
> I think the error returned by a shutdown filesystem should always be
> consistent and that really means -EIO needs to be returned rather
> than -EROFS.
> 
> However, given this is new generic infrastructure, we can define a
> new error like -ESHUTDOWN (to reuse an existing errno) or even a
> new errno like -EFSSHUTDOWN for this, document it man pages and then
> convert all the existing filesystem shutdown checks to return this
> error instead of -EIO...

Right, -EROFS isn't really good return value when we refuse also reads. I
think -EIO is fine. -ESHUTDOWN would be ok but the standard message ("Cannot
send after transport endpoint shutdown") whould be IMO confusing to users.
I was also thinking about -EFSCORRUPTED (alias -EUCLEAN) which already has
some precedens in the filesystem space but -EIO is probably better.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

