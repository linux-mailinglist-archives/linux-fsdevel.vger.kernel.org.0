Return-Path: <linux-fsdevel+bounces-12154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C1A85BC54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21744B231E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45369968;
	Tue, 20 Feb 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMKPEY0B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deho5djI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMKPEY0B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deho5djI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6C482FA;
	Tue, 20 Feb 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432749; cv=none; b=ZsQr19jZnexN5x3DyFnbCL8DJmYT1HJO1i+5dBIj6XBiTL4/nFrY8EbSV8t62AD5RTvSe1Rt3tyUuA4enXNiDJV7g+qx18khMSbAWi0nrZ+wiho8SuxVpjzkg4aD8bFeGseqxUWe739bb8xaW9cWaM3kqF8gnhTY0Rvj84FR6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432749; c=relaxed/simple;
	bh=v9niZvFxoxDsNa48gJ+crQZJYJbsm2uY1lw8ejLcKjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFm36BaIJgCgwS8oW2X75CJdxDZyWwUCrD+UWdSFnMQLceB/SI6peRN4GF02d8BBX1f/6Ptzrtivpjq4dEfYIoExQy+/1Cm2MQgNFc00EY+c5KhYpKP1MJZuq5A/8hGNyAI4+X3a5/xPGrOPuG82M9NvPMTiFM6CPozzWBn46hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMKPEY0B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deho5djI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMKPEY0B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deho5djI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A835E2207A;
	Tue, 20 Feb 2024 12:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708432745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVPRzXm5b8XqYXERsjzN5otP0G5DHkxP74ScWIa4OZA=;
	b=hMKPEY0BvU4HM/T78Wkf+bOqlpsOlC2pLpwBJFmsw6jjy9PwvBaEW2NdhPRcCd8dY5DmzW
	CazCrehqwpv5dotrWQubx7hL0h37lltDA066/fIkBHLUVLxVeYEkptMevH3y4kUSstybnk
	YnDB4+XRxmglKES2BvQfyKOESnIusIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708432745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVPRzXm5b8XqYXERsjzN5otP0G5DHkxP74ScWIa4OZA=;
	b=deho5djI1FbNMFwU7ToyCHQwCmm7WQpGI9k3Saoold7z7pnrRAZumZIa6ixUmvOUX24Jkd
	FDBaWs1ok/Z/fbBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708432745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVPRzXm5b8XqYXERsjzN5otP0G5DHkxP74ScWIa4OZA=;
	b=hMKPEY0BvU4HM/T78Wkf+bOqlpsOlC2pLpwBJFmsw6jjy9PwvBaEW2NdhPRcCd8dY5DmzW
	CazCrehqwpv5dotrWQubx7hL0h37lltDA066/fIkBHLUVLxVeYEkptMevH3y4kUSstybnk
	YnDB4+XRxmglKES2BvQfyKOESnIusIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708432745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qVPRzXm5b8XqYXERsjzN5otP0G5DHkxP74ScWIa4OZA=;
	b=deho5djI1FbNMFwU7ToyCHQwCmm7WQpGI9k3Saoold7z7pnrRAZumZIa6ixUmvOUX24Jkd
	FDBaWs1ok/Z/fbBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A6001358A;
	Tue, 20 Feb 2024 12:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Od6lJWmd1GVKFgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 20 Feb 2024 12:39:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 486BEA0807; Tue, 20 Feb 2024 13:39:05 +0100 (CET)
Date: Tue, 20 Feb 2024 13:39:05 +0100
From: Jan Kara <jack@suse.cz>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Hugh Dickins <hughd@google.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"dagmcr@gmail.com" <dagmcr@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"willy@infradead.org" <willy@infradead.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 0/9] shmem: fix llseek in hugepages
Message-ID: <20240220123905.qdjn2x3dtryklibl@quack3>
References: <20240209142901.126894-1-da.gomez@samsung.com>
 <CGME20240214194911eucas1p187ae3bc5b2be4e0d2155f9ce792fdf8b@eucas1p1.samsung.com>
 <25i3n46nanffixvzdby6jwxgboi64qnleixz33dposwuwmzj7p@6yvgyakozars>
 <e3602f54-b333-7c8c-0031-6a14b32a3990@google.com>
 <r3ws3x36uaiv6ycuk23nvpe2cn2oyzkk56af2bjlczfzmkfmuv@72otrsbffped>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <r3ws3x36uaiv6ycuk23nvpe2cn2oyzkk56af2bjlczfzmkfmuv@72otrsbffped>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
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
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[google.com,zeniv.linux.org.uk,kernel.org,suse.cz,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,samsung.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[40.24%]
X-Spam-Flag: NO

On Tue 20-02-24 10:26:48, Daniel Gomez wrote:
> On Mon, Feb 19, 2024 at 02:15:47AM -0800, Hugh Dickins wrote:
> I'm uncertain when we may want to be more elastic. In the case of XFS with iomap
> and support for large folios, for instance, we are 'less' elastic than here. So,
> what exactly is the rationale behind wanting shmem to be 'more elastic'?

Well, but if you allocated space in larger chunks - as is the case with
ext4 and bigalloc feature, you will be similarly 'elastic' as tmpfs with
large folio support... So simply the granularity of allocation of
underlying space is what matters here. And for tmpfs the underlying space
happens to be the page cache.

> If we ever move shmem to large folios [1], and we use them in an oportunistic way,
> then we are going to be more elastic in the default path.
> 
> [1] https://lore.kernel.org/all/20230919135536.2165715-1-da.gomez@samsung.com
> 
> In addition, I think that having this block granularity can benefit quota
> support and the reclaim path. For example, in the generic/100 fstest, around
> ~26M of data are reported as 1G of used disk when using tmpfs with huge pages.

And I'd argue this is a desirable thing. If 1G worth of pages is attached
to the inode, then quota should be accounting 1G usage even though you've
written just 26MB of data to the file. Quota is about constraining used
resources, not about "how much did I write to the file".

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

