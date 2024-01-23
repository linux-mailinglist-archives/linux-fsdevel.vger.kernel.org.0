Return-Path: <linux-fsdevel+bounces-8586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B383921F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F7C1F2872C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2810F5FDBC;
	Tue, 23 Jan 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mXa43ChT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N0C0RFys";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mXa43ChT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N0C0RFys"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD75F552;
	Tue, 23 Jan 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022472; cv=none; b=j6U3eAxRPzcUVQHM7W+81mJSlrrVHVj0x2XKVvhF8zYBGpmNvKMzR8M4oPkQwvsj9JEHCZK5lInXvEc3jsB6Q5uM4eGMMJ5tbA26ZKbTLqd3kUev1nc4YKDwmITDwiXQWAfeiYoj2mbP3DPOxwGrZJI2KH8hOTtkDIUd+5Ii2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022472; c=relaxed/simple;
	bh=f2f1pE8UJhuR9Ss9U+d24HlY6ZpfM3YozM996mUCqQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeBs2ltk5qx9fzF0mxpDJTqVd+LLIAhnoaJ5WKrWR5MNB4hL6PBF73Ji7UBFw1f8CV8B/tYKemYBFJy7lY4UnphKY0vdyegoQh8d00RxX/XPQi90EfnUXUehhzJumlJhue3PPFBDDtRSZW0R2RFVdCOD9qZJC//i2q8a4s8SH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mXa43ChT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N0C0RFys; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mXa43ChT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N0C0RFys; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2AE113758F;
	Tue, 23 Jan 2024 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706022469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7dfcOvlJPEsnWcPOV2iC3ZhD1Xh52nYXFAobPmE4qg=;
	b=mXa43ChToKwzoaQNmjVWDYDS6UqUA49D04Yle2DVJuix/UEZ/rzLP6xnaMxv2mI1PmEjNl
	EhpL1knc6j4Wv4bF+i/uipoZEmRZREZZ7Ph8Hc61gGGAc9KwSPYQ89/PpPx0VtxcpXURCU
	2JcjJvLPRuUbjQB4+IdnsOemtbqf+Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706022469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7dfcOvlJPEsnWcPOV2iC3ZhD1Xh52nYXFAobPmE4qg=;
	b=N0C0RFysQo8bwmlL5WMfIb6evolDtejJ9dJVIdDiuQlvl5rOlx59OPmCYrwZLFGHwjULAm
	kzs91SBxwT/fIaCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706022469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7dfcOvlJPEsnWcPOV2iC3ZhD1Xh52nYXFAobPmE4qg=;
	b=mXa43ChToKwzoaQNmjVWDYDS6UqUA49D04Yle2DVJuix/UEZ/rzLP6xnaMxv2mI1PmEjNl
	EhpL1knc6j4Wv4bF+i/uipoZEmRZREZZ7Ph8Hc61gGGAc9KwSPYQ89/PpPx0VtxcpXURCU
	2JcjJvLPRuUbjQB4+IdnsOemtbqf+Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706022469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7dfcOvlJPEsnWcPOV2iC3ZhD1Xh52nYXFAobPmE4qg=;
	b=N0C0RFysQo8bwmlL5WMfIb6evolDtejJ9dJVIdDiuQlvl5rOlx59OPmCYrwZLFGHwjULAm
	kzs91SBxwT/fIaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14CB513786;
	Tue, 23 Jan 2024 15:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a/96A0XWr2WUbwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 23 Jan 2024 15:07:49 +0000
Date: Tue, 23 Jan 2024 16:07:48 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: 
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
Subject: Re: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
Message-ID: <jfydrbb277d7ad2ypu5dottiqh4rtzm5ipf72wcjo34mmpvnl7@mjlqomulsq3q>
References: <e5d8cd68-b3f2-4d7b-b323-b13d18199256@nvidia.com>
 <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bh5s6a4fhhlje42bzj2t22k3jpmruzkx234ks4ytuhd62tonzj@zn6h5foaqrof>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.35 / 50.00];
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
	 RCPT_COUNT_TWELVE(0.00)[23];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,lists.infradead.org,kernel.dk,acm.org,toxicpanda.com,gmail.com,javigon.com,intel.com,lst.de,kernel.org,suse.de,opensource.wdc.com,wdc.com,suse.com,redhat.com,grimberg.me,mit.edu,iogearbox.net];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.05)[59.76%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.35

On Wed, Jan 17, 2024 at 09:50:50AM +0100, Daniel Wagner wrote:
> On Tue, Jan 09, 2024 at 06:30:46AM +0000, Chaitanya Kulkarni wrote:
> > For storage track, I would like to propose a session dedicated to
> > blktests. It is a great opportunity for the storage developers to gather
> > and have a discussion about:-
> > 
> > 1. Current status of the blktests framework.
> > 2. Any new/missing features that we want to add in the blktests.
> > 3. Any new kernel features that could be used to make testing easier?
> > 4. DM/MD Testcases.
> > 5. Potentially adding VM support in the blktests.
> 
> I am interested in such a session.

One discussion point I'd like to add is

  - running blktest against real hardare/target

