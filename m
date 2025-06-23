Return-Path: <linux-fsdevel+bounces-52528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F032AE3D84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA743A4E58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C823C390;
	Mon, 23 Jun 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzvyvfIp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJiMGwXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gzvyvfIp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BJiMGwXc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62251F2BAD
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676237; cv=none; b=Gd4cwslilaNh/QjcZ4R2zSPuH62i2OH2Qtbjz2xxcpwKJ3zzZ6V2LJZAxN1xOpsr64l6ALmJTx3ogPABbGcuG8Dz7mKiotqtFIZzBVAqZfDTNIDpES306BYlQTAp7w0DXQOUuAEl+TT9VlGoGuyiqzntgK7G4FEuXLO5eZMjHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676237; c=relaxed/simple;
	bh=RKWyiSUBekTwNtDR2zYZYFr3yu25BsQI5ea5CE4V6GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bENNWq7iMfxVOIa2jXMIqUcBy2AHkmsHJzIT0gEkd3+F5D502hwNPFlCjbZ+FmF8z14/5QoMKLWD3nFisMFsdMGHI40Fvuf9CwOFXeayA8bRsddsKCrIFByneZpOYWY67/AS+55ypKp2wWb4dmhrouf195gzo1IhDKZOuykt6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzvyvfIp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJiMGwXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gzvyvfIp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BJiMGwXc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 28B491F454;
	Mon, 23 Jun 2025 10:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750676234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gu2zbmxV6GhdRCAd6U6ZxMVpT5s/UNDui+fbzYumCc=;
	b=gzvyvfIpjNkzQ0QXLGJlnKTmGaki9Q3AwacPg9F6PysfZ+kxCc5vMVe2lYk2bxa83XFuSf
	EBTNFFKja55WNwzwFVBoi4UkOHX7OG47AlFltuOicZJutIzK7md0Pj2pIXmv4yC9WFAOMx
	cg0dpPlsDo4jJkoOaPWqynk/G6S77qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750676234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gu2zbmxV6GhdRCAd6U6ZxMVpT5s/UNDui+fbzYumCc=;
	b=BJiMGwXcZzLHJVWRfdGBcFx2mGpxftm1m0D31BfLmDcyq9oqoafKXbmsg07mD3a6ZUN9hH
	ifzxBDMi7KG4+vCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750676234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gu2zbmxV6GhdRCAd6U6ZxMVpT5s/UNDui+fbzYumCc=;
	b=gzvyvfIpjNkzQ0QXLGJlnKTmGaki9Q3AwacPg9F6PysfZ+kxCc5vMVe2lYk2bxa83XFuSf
	EBTNFFKja55WNwzwFVBoi4UkOHX7OG47AlFltuOicZJutIzK7md0Pj2pIXmv4yC9WFAOMx
	cg0dpPlsDo4jJkoOaPWqynk/G6S77qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750676234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gu2zbmxV6GhdRCAd6U6ZxMVpT5s/UNDui+fbzYumCc=;
	b=BJiMGwXcZzLHJVWRfdGBcFx2mGpxftm1m0D31BfLmDcyq9oqoafKXbmsg07mD3a6ZUN9hH
	ifzxBDMi7KG4+vCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE2B13AC9;
	Mon, 23 Jun 2025 10:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZRiFBwozWWjrJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Jun 2025 10:57:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0CEAA2A00; Mon, 23 Jun 2025 12:57:13 +0200 (CEST)
Date: Mon, 23 Jun 2025 12:57:13 +0200
From: Jan Kara <jack@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
Message-ID: <asdmf7hg5j4xv6b3stnp6lb2374ptab6mehl3rheystfvgatrz@2nmrmzq3pdht>
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
 <1882d73e-b287-4c73-abcf-52e10b43edea@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1882d73e-b287-4c73-abcf-52e10b43edea@gmx.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon 23-06-25 15:04:51, Qu Wenruo wrote:
> 在 2025/6/23 14:45, Christoph Hellwig 写道:
> > On Fri, Jun 20, 2025 at 05:36:52PM +0200, Jan Kara wrote:
> > > On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
> > > > Currently we already have the super_operations::shutdown() callback,
> > > > which is called when the block device of a filesystem is marked dead.
> > > > 
> > > > However this is mostly for single(ish) block device filesystems.
> > > > 
> > > > For multi-device filesystems, they may afford a missing device, thus may
> > > > continue work without fully shutdown the filesystem.
> > > > 
> > > > So add a new super_operation::shutdown_bdev() callback, for mutli-device
> > > > filesystems like btrfs and bcachefs.
> > > > 
> > > > For now the only user is fs_holder_ops::mark_dead(), which will call
> > > > shutdown_bdev() if supported.
> > > > If not supported then fallback to the original shutdown() callback.
> > > > 
> > > > Btrfs is going to add the usage of shutdown_bdev() soon.
> > > > 
> > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > 
> > > Thanks for the patch. I think that we could actually add 'bdev' that
> > > triggered shutdown among arguments ->shutdown takes instead of introducing
> > > a new handler.
> > 
> > I don't really think that's a good idea as-is.  The current ->shutdown
> > callback is called ->shutdown because it is expected to shut the file
> > system down.  That's why I suggested to Qu to add a new devloss callback,
> > to describe that a device is lost.  In a file system with built-in
> > redundancy that is not a shutdown.  So Qu, please add a devloss
> > callback.  And maybe if we have no other good use for the shutdown
> > callback we can remove it in favor of the devloss one.  But having
> > something named shutdown take the block device and not always shutting
> > the file system down is highly confusing.
> 
> OK, I got the point of the name "devloss" now, didn't notice the naming
> itself is important at that timing.
> 
> And in fact a new callback is much easier on me, no need to modify the code
> of other fses.
> 
> @Jan, would this be acceptable for a new devloss() callback instead?

OK, now I understand the rationale better as well. Yes, devloss() callback
makes sense to me. It just looked weird to have two types shutdown
callback. And yes, eventually we might provide a generic handler for
devloss callback that will just shut the filesystem down and then we can
remove the shutdown callback but that can happen later.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

