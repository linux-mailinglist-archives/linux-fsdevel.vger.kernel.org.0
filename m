Return-Path: <linux-fsdevel+bounces-55649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC1B0D3F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C4F3AC342
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 07:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F1E28A716;
	Tue, 22 Jul 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Orj0930B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hh+fW+uU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Orj0930B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hh+fW+uU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADD15442A
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170767; cv=none; b=MwbzOVNA3ADenbtLzZCJASFrTOm+HfMbLOKgZtvrsQ6P7q8Wb24tJ/RX7av89/9oooOey0u/eBLMLIAiphjTA1vqVvoG/GW0EX0CLcCynJFmVpje7dEkJ9uBlW4c46TOb87RkvDLQr7DUeW9PXQmZgdRmXiRGES/2Kta6IHzwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170767; c=relaxed/simple;
	bh=1T/lmmjBJt+PQAc1sNQ1vBL7XQsJRV1RtsPazTXylGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhKLkOYZjnbz/THu69X1pcwJG0td7fPudjpSs1QJYoM3Xl7N6ZDx/gvIhUboC7jpTqDFfKHsPQRM3kRJ/0XNXmTKBzK53qt8AV3/LMj3/YXMDn3Eznqpr/OBti/t52cWkviMEyOroudEeqxpEz0vJhoRMYeJx6IHUDg00scXRnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Orj0930B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hh+fW+uU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Orj0930B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hh+fW+uU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9620D21896;
	Tue, 22 Jul 2025 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753170763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QAYfuWhONPnnck5jobquUqn8oJ3+6Ym89WXeJq3V6A=;
	b=Orj0930Bw65KfwIWds65tun2sb2LzzggIt14qtRzSTNFLx3xhhm5iRXBx3d3/aRSk7Yisk
	bNkI716ugp3ks+JeURmY8y/gIGtCBmg0zaTLbDcP25Ir27Ejd5t2FmPWGdRBiWONngH9BO
	CkGeoaj0Ulnv+cRxfj4dJacZsupF1hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753170763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QAYfuWhONPnnck5jobquUqn8oJ3+6Ym89WXeJq3V6A=;
	b=hh+fW+uUzJX3LiVWD8jCmONnok3vVO7nh/oLFdOw+GQepxhhyKko9c7saNWhs+T5mItaaa
	V/3+SwBI1fiIg0Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753170763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QAYfuWhONPnnck5jobquUqn8oJ3+6Ym89WXeJq3V6A=;
	b=Orj0930Bw65KfwIWds65tun2sb2LzzggIt14qtRzSTNFLx3xhhm5iRXBx3d3/aRSk7Yisk
	bNkI716ugp3ks+JeURmY8y/gIGtCBmg0zaTLbDcP25Ir27Ejd5t2FmPWGdRBiWONngH9BO
	CkGeoaj0Ulnv+cRxfj4dJacZsupF1hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753170763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QAYfuWhONPnnck5jobquUqn8oJ3+6Ym89WXeJq3V6A=;
	b=hh+fW+uUzJX3LiVWD8jCmONnok3vVO7nh/oLFdOw+GQepxhhyKko9c7saNWhs+T5mItaaa
	V/3+SwBI1fiIg0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E7013A32;
	Tue, 22 Jul 2025 07:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id syRmIUtDf2gdAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Jul 2025 07:52:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0045AA0884; Tue, 22 Jul 2025 09:52:42 +0200 (CEST)
Date: Tue, 22 Jul 2025 09:52:42 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <fhppu2rnsykr5obrib3btw7wemislq36wufnbl67salvoguaof@kkxaosrv3oho>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250718160414.GC1574@quark>
 <20250721061411.GA28632@lst.de>
 <20250721235552.GB85006@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721235552.GB85006@quark>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 21-07-25 16:55:52, Eric Biggers wrote:
> On Mon, Jul 21, 2025 at 08:14:11AM +0200, Christoph Hellwig wrote:
> > On Fri, Jul 18, 2025 at 09:04:14AM -0700, Eric Biggers wrote:
> > > If done properly, fixing this would be great.  I've tried to minimize
> > > the overhead of CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY when those
> > > features are not actually being used at runtime.  The struct inode
> > > fields are the main case where we still don't do a good job at that.
> > 
> > Can you take a look if my idea of not allocating the verity data for
> > all inodes but just those where verity is enabled and then looking that
> > up using a rhashtable makes any sense?
> > 
> 
> I wrote a prototype that puts the fsverity_info structs in an
> rhashtable, keyed by the ownening 'struct inode *'.  It passes the
> 'verity' group of xfstests on ext4.  However, I'm working on checking
> how bad the performance and code size overhead is, and whether my
> implementation is actually correct in all cases.  Unfortunately, the
> rhashtable API and implementation is kind of a mess, and it seems it's
> often not as efficient as it should be.
> 
> I suppose an XArray would be the main alternative.  But XArray needs
> 'unsigned long' indices, and it doesn't work efficiently when they are
> pointers.  (And i_ino won't do, since i_ino isn't unique.)

As Christoph wrote I don't think XArray is a good alternative. The memory
overhead is big for sparsely populated key space and that also increases the
lookup overhead which is O(log N) to start with. Rhashtable should have
O(1) lookup which is what we are most interested in. So if xarray is faster
than rhashtable, rhashtable is doing something seriously wrong.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

