Return-Path: <linux-fsdevel+bounces-12494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A64B85FDDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 17:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09E4B2C1C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C71151CC5;
	Thu, 22 Feb 2024 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1IPtTC1B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5rnFZTL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1IPtTC1B";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s5rnFZTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487591509A7;
	Thu, 22 Feb 2024 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708618596; cv=none; b=EvY6OdLabufg8VGVoSDpHq7FeCGX9vAYbYXeW3rzCqD5Wozt7xTOJwyQVUTt7GcLBI6Hp51dXTyeKsxI4oAz0lx5QEWukPCTfyCGK0FBgd7B4JTMx0IukD9EJNXjuvBM234kMq9ZANOb/YFzNGSkT7ReS1fqfdfbXIgXJJrUx+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708618596; c=relaxed/simple;
	bh=lUjzPL2Rn/vckbm9GFQABCjyaKVvEJJPfyMuWnZrp4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+diUzOTo+kvMGTDfguz88UZQBvB6ZnmQzK4qcfFowo6W33TgiC8/NokWj4bUAGwexD5j1gZZgqxGc15tAHonohzHl5VK6gWHvMWjl6sJwVE7CnfaW2BKJuGAf+mSlk27OX9fFAg2hq0r9xb+wxZl8/jK1Fh88QEt+OckkFu5FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1IPtTC1B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5rnFZTL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1IPtTC1B; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s5rnFZTL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ABE41FB9A;
	Thu, 22 Feb 2024 16:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708618591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=1IPtTC1BlUpNz+Rkqo4Yxv3I+yStxpqoMioqayy1m4KZWUa/XPFfAtd7oBX0vSUu8MlhIn
	fBjyF96Y1tc4QXQNkBOSksngMIJX7o+eSxopjZAqMCOp3DYezazk5qWC31vpDVKN45c7fV
	tMnLvrxcoaK/jfLAWKY1Jp+mk+Yhvyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708618591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=s5rnFZTLttmF3tC9S5WDuuKboJl7/2Sq8PlCDfBYFRpVr1Ts17KrRiwYn3MiCz0ePNSfju
	xhppSBXF+Ym+LmAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708618591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=1IPtTC1BlUpNz+Rkqo4Yxv3I+yStxpqoMioqayy1m4KZWUa/XPFfAtd7oBX0vSUu8MlhIn
	fBjyF96Y1tc4QXQNkBOSksngMIJX7o+eSxopjZAqMCOp3DYezazk5qWC31vpDVKN45c7fV
	tMnLvrxcoaK/jfLAWKY1Jp+mk+Yhvyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708618591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WxAylS37KlSMxqz30UlWrIOlrte9S7xx+OkJa4dyaF4=;
	b=s5rnFZTLttmF3tC9S5WDuuKboJl7/2Sq8PlCDfBYFRpVr1Ts17KrRiwYn3MiCz0ePNSfju
	xhppSBXF+Ym+LmAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CAE613A6B;
	Thu, 22 Feb 2024 16:16:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FXYpCl9z12XIfAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 22 Feb 2024 16:16:31 +0000
Date: Thu, 22 Feb 2024 17:16:30 +0100
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
Message-ID: <6spltrohwisctoeowctyyneyrqolzyvcd3riozbczj2c2o5pcw@lmtrghutbgwx>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
 <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
 <ZdZBpb4vMMVoLfhs@bombadil.infradead.org>
 <g5c3kwbalxru7gykmzdymrzf43fkriofiqtgdgcswbf4hrg65r@wdduaccaswhe>
 <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdduKnjJx3tJsQGY@bombadil.infradead.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[nvidia.com,lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.99%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Thu, Feb 22, 2024 at 07:54:18AM -0800, Luis Chamberlain wrote:
> > I should have been more precise here, I was trying to say supporting
> > real fabrics targets. blktests already has some logic for PCI targets
> > with $TEST_DEV but I haven't really looked into this part yet.
> 
> Do fabric targets have a symlink which remains static?

A pretty typical nvme fabric test is:

setup phase target side:
 - create backing device (file/block)
 - create loopback device
 - create nvme subsystem

setup phase host side:
 - discover
 - connect to the target

test phase
 do something like reading/writing from '/dev/nvmeX'
 or 'nvme id-ctrl /dev/nvmeX', etc.

cleanup phase host side:
 - disconnect from the target

cleanup phase target side:
 - remove nvme subsystem
 - remove loopback device
 - remove backing device

I'd like to make the setup and cleanup target side more flexible. The
host side will not be affected at all by exchanging the current soft
target side (aka nvmet) with something else. This means it's not about
any device links in /dev.

Hope this makes it a bit clearer.

