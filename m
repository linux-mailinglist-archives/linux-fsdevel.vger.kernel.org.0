Return-Path: <linux-fsdevel+bounces-30845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9002D98EC28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943631C22084
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8F145FE4;
	Thu,  3 Oct 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c55mC8a7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bc58g8Px";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKdg5f9T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4cK16X8d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C113CA8A;
	Thu,  3 Oct 2024 09:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727947081; cv=none; b=CewIXx4QrCFN+WveH00pHYCKmV1PyyACN0OEa2WmIPC45Ovdp8GCJ2E//tYnm9sNjJ2hR/60SjihnSUBG4/Jf3XYdkBWQlBGCy88+aO0s1gi1XwcBJUdSafGgCE88ysPIjp/qrLhymI2oeGOnAM8Ud5bspXU0SdIvgszqTo+S90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727947081; c=relaxed/simple;
	bh=OsX5LvzLfEbbA6tnyO9NNhgDkPy3QtONIGlX3EPocGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izgu4+8iiP/yNHvrnKWMY4v0lYvAXDNw/lgVgPGTDF9PISHQtT56cJ1R6TopZbXUDGi6oYKsSMAnVFQtObYWDBNQgCk2KKL6AvF8itxxD+P5Q8jKBl0hjZypU+ki/lFZeqinbTgexs2mGA43DjaOySHQvXdZMNEbIHqtWxo2Nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c55mC8a7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bc58g8Px; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKdg5f9T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4cK16X8d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EFAA81FDCA;
	Thu,  3 Oct 2024 09:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727947062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6rC28lPlVyJkPEpD0jTearCgkAnHWLvKQEnr4BvZRo=;
	b=c55mC8a7e9eQVrl6WhrH7R5cIA5hiM/gdiub4wz/eOx/fxTr5rfF2uLKq8WwxT+dcX6dY1
	MXDPXhljnmEIHD0NcJ/xymjl/xz/NNtxWqr3YVstXCdXMhzKTibS//9BtS7daVREPoWAZV
	MIkFYjIavdTlIHXlpRV2p/p037RTlas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727947062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6rC28lPlVyJkPEpD0jTearCgkAnHWLvKQEnr4BvZRo=;
	b=Bc58g8PxJyjy7onvsqucX1e7Gj1Y0pHcGomYWucn40ll9tIb4HZjRnkFcEcLTaNqbFqX75
	84KUXcecO54dggCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727947061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6rC28lPlVyJkPEpD0jTearCgkAnHWLvKQEnr4BvZRo=;
	b=LKdg5f9TDyMEBHkqeFh/mHUEPwksCbHNY29XVr6hSG+TSBQVxv3ogapbELTdosu/kL+eJg
	p5nRdnx0E1cOwJuy6SHJt2YVExesmMukjPBX4UjcXaetGImKHDBkGL7B2xOOh8/q7+XOJm
	Hb/kUKPriQt+DhLTUg0H+2tbcgbSefc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727947061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z6rC28lPlVyJkPEpD0jTearCgkAnHWLvKQEnr4BvZRo=;
	b=4cK16X8dZnxiTsbm8Zg9mn7xqpoWELf4AyuaJcx7QlntW0wo6i+GiQU0SRRBQT9BmElY5W
	gY/6bcR1vkpZ8pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E46E8139CE;
	Thu,  3 Oct 2024 09:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qlu+NzVh/mavaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 09:17:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95D63A086F; Thu,  3 Oct 2024 11:17:41 +0200 (CEST)
Date: Thu, 3 Oct 2024 11:17:41 +0200
From: Jan Kara <jack@suse.cz>
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <20241003091741.vmw3muqt5xagjion@quack3>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
 <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
 <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>
 <Zv32Vow1YdYgB8KC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv32Vow1YdYgB8KC@dread.disaster.area>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 03-10-24 11:41:42, Dave Chinner wrote:
> On Wed, Oct 02, 2024 at 07:20:16PM -0400, Kent Overstreet wrote:
> > A couple things that help - we've already determined that the inode LRU
> > can go away for most filesystems,
> 
> We haven't determined that yet. I *think* it is possible, but there
> is a really nasty inode LRU dependencies that has been driven deep
> down into the mm page cache writeback code.  We have to fix that
> awful layering violation before we can get rid of the inode LRU.
> 
> I *think* we can do it by requiring dirty inodes to hold an explicit
> inode reference, thereby keeping the inode pinned in memory whilst
> it is being tracked for writeback. That would also get rid of the
> nasty hacks needed in evict() to wait on writeback to complete on
> unreferenced inodes.
> 
> However, this isn't simple to do, and so getting rid of the inode
> LRU is not going to happen in the near term.

Yeah. I agree the way how writeback protects from inode eviction is not the
prettiest one but the problem with writeback holding normal inode reference
is that then flush worker for the device can end up deleting unlinked
inodes which was causing writeback stalls and generally unexpected lock
ordering issues for some filesystems (already forgot the details). Now this
was more that 12 years ago so maybe we could find a better solution to
those problems these days (e.g. interactions between page writeback and
page reclaim are very different these days) but I just wanted to warn there
may be nasty surprises there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

