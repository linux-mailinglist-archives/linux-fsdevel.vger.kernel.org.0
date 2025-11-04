Return-Path: <linux-fsdevel+bounces-66894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FECC300C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631C71885718
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A645A32038E;
	Tue,  4 Nov 2025 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcRSaxea";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ad15dwk8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fztRe1yP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zc4ByymI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A5312829
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245737; cv=none; b=NCXrtqU8iEugH0WwdJhgyb8jWoNDrwa/fC87emt9xROmqJfDY87UO5ZAS994NGRMXONJL8S6MnC9kd++ofM4cIczFoy/5mId5wfRCYDyhWtBTvCWvVCgNkuT4JNm1/e5hxdWBIZpG+K1i9TzpOcR0csFD09DH0mT/6zhE/P80Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245737; c=relaxed/simple;
	bh=G/sTx7O0SDqHyHzcyzubTIk9364CWkYN0uaq147S9Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEBEyBe5jYjEcYwsBpxkkjBCPDSxbUegkxCxVDExg7nIWnhlTFNapm8C73QdGS7YMFy/9JqnBIBFt27nL9d+c3x1YxCqvjhMFZY+n0Ec9z6N+3bb4idT39jpTp63G0fzSwO0I7x+7TjXVdST7xSqUfQblofmhdVsy+hVxNzGsfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcRSaxea; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ad15dwk8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fztRe1yP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zc4ByymI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D75EC1F38F;
	Tue,  4 Nov 2025 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762245728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mbBV7EKR7XIpa7raR6m3+hjbsPNugFaSjhyaxM2Wo=;
	b=VcRSaxea/tzynfocC3UtxW6aSdOT8fhPpZG5bBqMrttoPRFSCaiQ/AZmKTWF8bblHnOwKA
	EtS7+fKozS2QQs9RIVEGoX2LN/5db1kzb/IdfaRv33fcnvZJd71yVq5jGf5j3wP/MfDcol
	SuNCEydQz+rXc5ooNY1HSi4duJl8F40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762245728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mbBV7EKR7XIpa7raR6m3+hjbsPNugFaSjhyaxM2Wo=;
	b=Ad15dwk8NTOqviBGFUEBeplwIwczVHvN765ZGZ87KWh+rELcXzs+7EzMTb6WjG9vIjKRP5
	Rz5jceKPP6rwssCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fztRe1yP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zc4ByymI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762245727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mbBV7EKR7XIpa7raR6m3+hjbsPNugFaSjhyaxM2Wo=;
	b=fztRe1yPbvyv2qQjbMNA45urMtK+7I6P8CF5VkGq4uep2erL0TvJy3hBkriiuUKz2CEBup
	k7sp2uo3dyHeLtNZMn1AVzcwZezxiH/RACSKjokEVm/iQIZI+RLUeBrv7labwO9GJnhZAR
	vDbN4n51Zxhov/iB0po1cZUY/iZ5+TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762245727;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0mbBV7EKR7XIpa7raR6m3+hjbsPNugFaSjhyaxM2Wo=;
	b=zc4ByymItlLj/GVz7XTvyj+tm1kbS2IGZO3Lv/P+16FHLkiNSkHSi4Sl61ad9Xi2KzMu1U
	joMSH1dDL2AhOUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD053139A9;
	Tue,  4 Nov 2025 08:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bRAFMl+8CWnUaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 08:42:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 86738A2812; Tue,  4 Nov 2025 09:42:07 +0100 (CET)
Date: Tue, 4 Nov 2025 09:42:07 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH RFC 1/2] fs: do not pass a parameter for
 sync_inodes_one_sb()
Message-ID: <i5ju5ohsvi54bsgfeuoy22tniln2scxwwl77iuluho5ohqn527@ycwgvf4yclwe>
References: <cover.1762142636.git.wqu@suse.com>
 <8079af1c4798cb36887022a8c51547a727c353cf.1762142636.git.wqu@suse.com>
 <aQiXObERFgW3aVcE@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQiXObERFgW3aVcE@infradead.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D75EC1F38F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Mon 03-11-25 03:51:21, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 02:37:28PM +1030, Qu Wenruo wrote:
> > The function sync_inodes_one_sb() will always wait for the writeback,
> > and ignore the optional parameter.
> 
> Indeed.

Yeah, apparently I've broken non-blocking nature of emergency sync without
nobody noticing for 13 years. Which probably means the non-blocking logic
isn't that important ;)...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

