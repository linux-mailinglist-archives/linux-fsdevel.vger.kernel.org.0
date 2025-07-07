Return-Path: <linux-fsdevel+bounces-54140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C003AFB7D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99AE4188465D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201720B1F4;
	Mon,  7 Jul 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuKRCJ50";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bl9Jb3rM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AuKRCJ50";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bl9Jb3rM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C872066DE
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903236; cv=none; b=mIGgdARdle0xqPGjNmlwEkFP99wTSNpQBnb0bvogS3oMKMXvDyj3foObCR2XQ8tRMUcRpycU5oFVjTT9pFXBWuSMt2zeUR4KwDgVajohw7SnTTgT/CtS8WST5YzTe56/l9dM1FM35/alpDxl70xAGmt9R9L/eJ0738tXWg+TGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903236; c=relaxed/simple;
	bh=F/DYWr+BhDkDQBDfkXhc90AXIML+8QihAvqfmHsLlh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWwPWSBBEG1QLN7WaQ9szrQyAOKxVrjRQhgFf3YqqvB7/w94fE4WjbmAGvneyb94OmYH8K37DUA1MyqB75HXjXkIAm54spXCfAuiM33ZtG1mUJv2B08xvVFfVGjXHlxagt0v8VckC+j1EzGl08wEc7hSkNJ4JHGLAaX7k83siGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuKRCJ50; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bl9Jb3rM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AuKRCJ50; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bl9Jb3rM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B320C210ED;
	Mon,  7 Jul 2025 15:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751903232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX29DBgo8xdocmIqtM7JRV4LqGxqs58F+qWxznSEpTI=;
	b=AuKRCJ50I5YGo3CF6bKoWnI8xfVLLSEFDTOa2wcmGEz3gGkUAYCA6QKmVnMQJPMkmuqMYA
	GkvbxkNeN3rTX5LKtZ3lOYE7qeCtb9GhoIlxqPReTJPZJNMDtvWeQhpD0QiTn10iQqBtXS
	ZL/sRomz/ur+E7611UUOibV4KWMKdTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751903232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX29DBgo8xdocmIqtM7JRV4LqGxqs58F+qWxznSEpTI=;
	b=bl9Jb3rMuMHLDaHY4T56CexJ/SfS04eXPV7nQwoip8NbuRgVfOSomJ32DHtrI6VYOc+uyc
	sRzwdXzdoOWT3yDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AuKRCJ50;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bl9Jb3rM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751903232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX29DBgo8xdocmIqtM7JRV4LqGxqs58F+qWxznSEpTI=;
	b=AuKRCJ50I5YGo3CF6bKoWnI8xfVLLSEFDTOa2wcmGEz3gGkUAYCA6QKmVnMQJPMkmuqMYA
	GkvbxkNeN3rTX5LKtZ3lOYE7qeCtb9GhoIlxqPReTJPZJNMDtvWeQhpD0QiTn10iQqBtXS
	ZL/sRomz/ur+E7611UUOibV4KWMKdTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751903232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gX29DBgo8xdocmIqtM7JRV4LqGxqs58F+qWxznSEpTI=;
	b=bl9Jb3rMuMHLDaHY4T56CexJ/SfS04eXPV7nQwoip8NbuRgVfOSomJ32DHtrI6VYOc+uyc
	sRzwdXzdoOWT3yDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637A013A5E;
	Mon,  7 Jul 2025 15:47:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qxg/GADsa2hzSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Jul 2025 15:47:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91FEEA098E; Mon,  7 Jul 2025 17:47:11 +0200 (CEST)
Date: Mon, 7 Jul 2025 17:47:11 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Kundan Kumar <kundanthebest@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Kundan Kumar <kundan.kumar@samsung.com>, jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, willy@infradead.org, mcgrof@kernel.org, 
	clm@meta.com, david@fromorbit.com, amir73il@gmail.com, axboe@kernel.dk, 
	ritesh.list@gmail.com, dave@stgolabs.net, p.raghav@samsung.com, da.gomez@samsung.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com
Subject: Re: [PATCH 00/13] Parallelizing filesystem writeback
Message-ID: <os6aqmbjphkeybbpceftdbfkmgquu6ywp34tx7uvmpqac4c42m@r76tgxypd5jg>
References: <CGME20250529113215epcas5p2edd67e7b129621f386be005fdba53378@epcas5p2.samsung.com>
 <20250529111504.89912-1-kundan.kumar@samsung.com>
 <20250529203708.9afe27783b218ad2d2babb0c@linux-foundation.org>
 <CALYkqXqs+mw3sqJg5X2K4wn8uo8dnr4uU0jcnnSTbKK9F4AiBA@mail.gmail.com>
 <20250702184312.GC9991@frogsfrogsfrogs>
 <20250703130500.GA23864@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703130500.GA23864@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B320C210ED
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLhzk8m8dynxu9bgo74bfqqdh9)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,samsung.com,zeniv.linux.org.uk,suse.cz,szeredi.hu,redhat.com,infradead.org,meta.com,fromorbit.com,kernel.dk,stgolabs.net,lists.sourceforge.net,vger.kernel.org,lists.linux.dev,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spam-Score: -2.51

On Thu 03-07-25 15:05:00, Christoph Hellwig wrote:
> On Wed, Jul 02, 2025 at 11:43:12AM -0700, Darrick J. Wong wrote:
> > > On a spinning disk, random IO bandwidth remains unchanged, while sequential
> > > IO performance declines. However, setting nr_wb_ctx = 1 via configurable
> > > writeback(planned in next version) eliminates the decline.
> > > 
> > > echo 1 > /sys/class/bdi/8:16/nwritebacks
> > > 
> > > We can fetch the device queue's rotational property and allocate BDI with
> > > nr_wb_ctx = 1 for rotational disks. Hope this is a viable solution for
> > > spinning disks?
> > 
> > Sounds good to me, spinning rust isn't known for iops.
> > 
> > Though: What about a raid0 of spinning rust?  Do you see the same
> > declines for sequential IO?
> 
> Well, even for a raid0 multiple I/O streams will degrade performance
> on a disk.  Of course many real life workloads will have multiple
> I/O streams anyway.
> 
> I think the important part is to have:
> 
>  a) sane defaults
>  b) an easy way for the file system and/or user to override the default
> 
> For a) a single thread for rotational is a good default.  For file system
> that driver multiple spindles independently or do compression multiple
> threads might still make sense.
> 
> For b) one big issue is that right now the whole writeback handling is
> per-bdi and not per superblock.  So maybe the first step needs to be
> to move the writeback to the superblock instead of bdi?  If someone
> uses partitions and multiple file systems on spinning rusts these
> days reducing the number of writeback threads isn't really going to
> save their day either.

We have had requests to move writeback infrastructure to be per sb in the
past, mostly so that the filesystem has a better control of the writeback
process (e.g. selection of inodes etc.). After some thought I tend to agree
that today setups where we have multiple filesystems over the same bdi and
end up doing writeback from several of them in parallel should be mostly
limited to desktops / laptops / small servers. And there you usually have
only one main data filesystem - e.g. /home/ - and you don't tend to write
that much to your / filesystem. Although there could be exceptions like
large occasional writes to /tmp, news server updates or similar. Anyway in
these cases I'd expect IO scheduler (BFQ for rotational disks where this
really matters) to still achieve a decent IO locality but it would be good
to verify what the impact is.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

