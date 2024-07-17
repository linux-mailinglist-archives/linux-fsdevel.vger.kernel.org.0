Return-Path: <linux-fsdevel+bounces-23824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B5933DC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C360284550
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BD7180A71;
	Wed, 17 Jul 2024 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wz/lzI4Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FWAA4kuQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="olB27A5Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HnMME3lk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9512E651;
	Wed, 17 Jul 2024 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721223673; cv=none; b=LHzNaqh/eSarE9gATgQ0anXfJ+Dck6Y7LXi3Cw/G2fddfoABn8ZPDcOJRvFdyor/z0avdiZ3YA8Dn+kqHUfq+gjSxKirmgGEeAo8huytteOE9C6jkIH/pmNkAlHE93Gft7lprdW3wSKk1PMHbHG8HX9Spzd86h54FbMAsEffqus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721223673; c=relaxed/simple;
	bh=uWsgqipubaVz2ga3ZVyeR/e34US0UfAOipB8SJzfcgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZAU6vzYk6FwATp50+XXGyM4+PyHN4AvEF0D2b/fXEZk3CQgWuk5tGD9jN8UdDgs2FQDd9gJ364f6BWjLtQ0GYsGgCiuYGB6TsOUAngQRm/iVE3kfR+HhPVntycjZjkJ8bQSO9PiK/QUih+m9KcH+CA2WcVQBmUCVzxEiMpMjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wz/lzI4Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FWAA4kuQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=olB27A5Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HnMME3lk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA88521B48;
	Wed, 17 Jul 2024 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721223670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pFDwE9LZGYqsqEFXEwcdnLiV47qA2XZLJC6uP3vtUA=;
	b=wz/lzI4Z/YT73R+Yi+2yyk9vCamZhrWiBDLqYUCUc7dRt5A2cQ79xRVtpj+JV1gJq2kGDB
	VB1zcuUOWNkWAwJYf7H7ekpYra5GdTbHVE38DfZQ3D0fZsVr3oj2rwi+F9e/FpBh6OMHTM
	uN0Acq3E2XF/I/XrbMPJYfVEgJP1rdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721223670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pFDwE9LZGYqsqEFXEwcdnLiV47qA2XZLJC6uP3vtUA=;
	b=FWAA4kuQ4fDJCmLO0aYv5zivRiy4XMmfOp6n9pHUzap8oAYfqDfCb7YR1pSAy/6bvbHyx6
	lSPFL4Pxv3E4J7Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721223668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pFDwE9LZGYqsqEFXEwcdnLiV47qA2XZLJC6uP3vtUA=;
	b=olB27A5ZTsaeRgIMV9O1LcxARWzSdfubBBFMIzcH50Hj6V/6eIIdY3BYMe/IgzsBGNXwmv
	wi5bPZBJ1IdTbq9hIQST2bCzXxgPBVJRoxpecA0NNnZ0QI5cZk29aUOWXFzUV9e0XR/FRl
	tmHz/pD8TaufjW77B75dXNCtw4GFVYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721223668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pFDwE9LZGYqsqEFXEwcdnLiV47qA2XZLJC6uP3vtUA=;
	b=HnMME3lkm7V38jpWbl98jN6nQmS/BzUWb47w/gryYYHTXs//MnvYIdKk4FO+UBpxIyztTi
	JWlE8Dctu4tc8OBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0D74136E5;
	Wed, 17 Jul 2024 13:41:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uA3gNvTJl2ZQdgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 13:41:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0618A0987; Wed, 17 Jul 2024 15:41:00 +0200 (CEST)
Date: Wed, 17 Jul 2024 15:41:00 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, Roman Smirnov <r.smirnov@omp.ru>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] fs: buffer: set the expression type to unsigned long in
 folio_create_buffers()
Message-ID: <20240717134100.wvekl66w7j2eatec@quack3>
References: <20240716090105.72179-1-r.smirnov@omp.ru>
 <5002a830-6a66-82fc-19e3-ec1e907eeb49@omp.ru>
 <ZpaW9ebdKyJremzp@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaW9ebdKyJremzp@casper.infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 16-07-24 16:51:17, Matthew Wilcox wrote:
> On Tue, Jul 16, 2024 at 06:41:49PM +0300, Sergey Shtylyov wrote:
> >    And here we'll have at least one potential problem (that you neglected
> > to describe): with 1 << 31, that 1 will land in a sign bit and then, when
> > it's implicitly cast to *unsigned long*, the 32-bit value will be sign-
> > extended to 64-bit on 64-bit arches) and then we'll have an incorrect size
> > (0xffffffff80000000) passed to create_empty_buffers()...
> 
> Tell me more about this block device you have with a 2GB block size ... ?
> 
> (ie note that this is a purely theoretical issue)

Yeah, this just does not make huge amount of sense. Maybe a proper fix
would be to just make blocksize uint? There are a lot of places where
blocksize is actually stored in a 32-bit type...

								Honza

> 
> > > to use 1UL instead.
> > 
> >    Perphas was worth noting that using 1UL saves us 1 movsx instruction on
> > x86_64...
> 
> That is a worthwhile addition to the change log.
> 
> Also, you should cc the person who wrote that code, ie me.
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

