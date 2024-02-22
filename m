Return-Path: <linux-fsdevel+bounces-12435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC485F466
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF1BB2632E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E8238380;
	Thu, 22 Feb 2024 09:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Auj3nCYb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8P71PZvf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Auj3nCYb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8P71PZvf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D8836AED;
	Thu, 22 Feb 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594318; cv=none; b=H+Dd0GUdk+s8cc6c/lON9+iISJT37RAzEy9CGxfC3J0P6Ce9jZDMrh8leV3LCUxfXMK31oGJyP/pBaITZLti00ruIbWxtdXeZvedLKIIKPxrtVZZnWIKl3TSchlb+5QIelNa0omMVvWfrF4k77J+HiarrfDXVPbpOO1nOAtD09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594318; c=relaxed/simple;
	bh=3NC2JFWUwUaKfvx89610bLmkWiiZCuu/S/semy0WzBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dv4+InJNf7lc3qLugZoVz0Num3AcYWjK9JJwdKnm4/y8vUG0YFvDdR+RstAlOmJczz6g+ahhhoaYNE0OKBmsmQb6cRxlGNTwG5az9u2z/kclkS4hjO4Rb9RJe7xp1PLhnW7zHCPtW1OyyG+pVYguROSpzr5M382h0+Qz3SDJcso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Auj3nCYb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8P71PZvf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Auj3nCYb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8P71PZvf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 602DC1F452;
	Thu, 22 Feb 2024 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708594314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=Auj3nCYbyfzn3C+J5lEUtdrxnsnSwqPyxqZBPi7vz5mDYASxc2bmkliMZ9KgLv+1CD2YIP
	fnYssxjk2keTd+MAvjI27G8apoen6uBX2sCBE5XU/QmliXED5GAiFW5BcMY0x34nIVBWQo
	gActl/kAoGwiGer1JyJd9Ou+4yBvYVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708594314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=8P71PZvf2kH7oAeqPBPWGNbtn1aQ42d3yD88rWaBqOoSBLp59C2CpHSdYvAayzxUKzGUPz
	IF+fGimQleP9xDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708594314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=Auj3nCYbyfzn3C+J5lEUtdrxnsnSwqPyxqZBPi7vz5mDYASxc2bmkliMZ9KgLv+1CD2YIP
	fnYssxjk2keTd+MAvjI27G8apoen6uBX2sCBE5XU/QmliXED5GAiFW5BcMY0x34nIVBWQo
	gActl/kAoGwiGer1JyJd9Ou+4yBvYVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708594314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JyST72IAHa1gwE0JzbLVOSJaR7ARzsfKSjPlAFyXYSE=;
	b=8P71PZvf2kH7oAeqPBPWGNbtn1aQ42d3yD88rWaBqOoSBLp59C2CpHSdYvAayzxUKzGUPz
	IF+fGimQleP9xDDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4506313A6B;
	Thu, 22 Feb 2024 09:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id oa75D4oU12XQIQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 09:31:54 +0000
Date: Thu, 22 Feb 2024 10:31:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"linux-fsdevel@vger.kernel.org >> linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, 
	Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, Dan Williams <dan.j.williams@intel.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>, "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.92
X-Spamd-Result: default: False [-0.92 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.12)[66.79%]
X-Spam-Flag: NO

On Wed, Feb 21, 2024 at 10:32:05AM -0800, Luis Chamberlain wrote:
> > One discussion point I'd like to add is
> > 
> >   - running blktest against real hardare/target
> 
> We've resolved this in fstests with canonicalizing device symlinks, and
> through kdevops its possible to even use PCIe passthrough onto a guest
> using dynamic kconfig (ie, specific to the host).
> 
> It should be possible to do that in blktests too, but the dynamic
> kconfig thing is outside of scope, but this is a long winded way of
> suggestin that if we extend blktests to add a canonon-similar device
> function, then since kdevops supports blktests you get that pcie
> passthrough for free too.

I should have been more precise here, I was trying to say supporting
real fabrics targets. blktests already has some logic for PCI targets
with $TEST_DEV but I haven't really looked into this part yet.

