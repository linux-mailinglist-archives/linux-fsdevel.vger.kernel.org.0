Return-Path: <linux-fsdevel+bounces-64656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D0BF00F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D4B189ED0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B922EFD9C;
	Mon, 20 Oct 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hysJY61T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yphqrgjp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EpSYi1MA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jrfKw8GG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1B2ED84C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950618; cv=none; b=ApFE3PwjOg8Hjz3w2HH2lXOlSt8Y+d10b9L+zY0kNRm6Cn/SipavdR+1UaQStQMe6x7yp+2LxaZGAz1Uklf2uT7MAnPkmdOprIl1s9UIKAf5JjybZQjQ+7JbybxG2HBdkW+rL/Tnpspn8s5Br8U5tO93DkDm51DmHzqsunp1ibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950618; c=relaxed/simple;
	bh=SQvT/VmAgOnKSszNJm2VTEpH72nC9+Uz2s0uKj8XT6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVUU7uqhFazJRz6BA3hob3dGFfBWjjbU+xheYT2YHxuBzdeUVw+63C8Thv9R7jyg0vI9l2AdIFb42Z0oTuQ8PyllZd25RM+NRS0tT570aN7DVqJFQwDtUAZnvA39eCT3bV/d9vaHD0tqK+s6Be60k/oijsZyNsW3hxRG32/6q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hysJY61T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yphqrgjp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EpSYi1MA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jrfKw8GG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1FDE211C4;
	Mon, 20 Oct 2025 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eKocUC4aWPoU3oJsUDdbKkljgX7L699KQPGrl9Fq+c=;
	b=hysJY61TD2iuyWjQVvb5FPwtn981mOlDkrB441JsmqUX2OVDVI4zg/zCz1S42k7fR1cfpP
	bjgQdVacBY/DmcwZjtCAOnBLZZ+Lr31cLe4Ufk3eOfOK0Rtiyd3v96Lb507KbggzyXLOlm
	5e7L7Fu7xIkXn1ikN81nkjkU6FUsXkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eKocUC4aWPoU3oJsUDdbKkljgX7L699KQPGrl9Fq+c=;
	b=yphqrgjpQ136lF9ZFjK7Fnee0a8FAXTtPw8WkJPvDwNzcE8imxq4sehvIj4b9tDbh4feKY
	aO3kGbnh+JlzUJDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eKocUC4aWPoU3oJsUDdbKkljgX7L699KQPGrl9Fq+c=;
	b=EpSYi1MA5UN0J3n/KeHJ1nJ97rrmcBfsN9lz7pvVhcliLpA+8ReUeiuGGUaRPow5jzxg/Y
	4HM36omUklV/9RZsO5RUPAeHULkeBdHSOYEwFvYDhJH7cSD2XiUWAq9po2Yxaj8Ppo89wU
	8sG89rYgbei04SKZODB079q94d+ALek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0eKocUC4aWPoU3oJsUDdbKkljgX7L699KQPGrl9Fq+c=;
	b=jrfKw8GGk70Lm1J5gwt/b6DyGS0j3iaiNjS9Gyn9IJ8GuAJZ9Kygon57sY3/AdOmIuP1A8
	WS+2ykGKNs+yvsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 272AD13B0B;
	Mon, 20 Oct 2025 08:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HI+HCUH59WhmZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 08:56:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ECD6FA28E4; Thu, 16 Oct 2025 18:21:19 +0200 (CEST)
Date: Thu, 16 Oct 2025 18:21:19 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Aubrey Li <aubrey.li@linux.intel.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>, 
	Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>, 
	Vinicius Gomes <vinicius.gomes@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Chen Yu <yu.c.chen@intel.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
Message-ID: <mze6nnqy2xwwqaz5xpwkthx3x4n6yd5vgbnyateyjlyjefiwde@qclv7inpacqe>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
 <20250922204921.898740570c9a595c75814753@linux-foundation.org>
 <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
 <cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
 <6bcf9dfe-c231-43aa-8b1c-f699330e143c@linux.intel.com>
 <20251011152042.d0061f174dd934711bc1418b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011152042.d0061f174dd934711bc1418b@linux-foundation.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[88];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Sorry for not replying earlier. I wanted make up my mind about this and
other stuff was keeping preempting me...

On Sat 11-10-25 15:20:42, Andrew Morton wrote:
> On Tue, 30 Sep 2025 13:35:43 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> 
> > file_ra_state is considered a performance hint, not a critical correctness
> > field. The race conditions on file's readahead state don't affect the
> > correctness of file I/O because later the page cache mechanisms ensure data
> > consistency, it won't cause wrong data to be read. I think that's why we do
> > not lock file_ra_state today, to avoid performance penalties on this hot path.
> > 
> > That said, this patch didn't make things worse, and it does take a risk but
> > brings the rewards of RocksDB's readseq benchmark.
> 
> So if I may summarize:
> 
> - you've identifed and addressed an issue with concurrent readahead
>   against an fd

Right but let me also note that the patch modifies only
force_page_cache_ra() which is a pretty peculiar function. It's used at two
places:
1) When page_cache_sync_ra() decides it isn't worth to do a proper
readahead and just wants to read that one one.

2) From POSIX_FADV_WILLNEED - I suppose this is Aubrey's case.

As such it seems to be fixing mostly a "don't do it when it hurts" kind of
load from the benchmark than a widely used practical case since I'm not
sure many programs call POSIX_FADV_WILLNEED from many threads in parallel
for the same range.

> - Jan points out that we don't properly handle concurrent access to a
>   file's ra_state.  This is somewhat offtopic, but we should address
>   this sometime anyway.  Then we can address the RocksDB issue later.

The problem I had with the patch is that it adds more racy updates & checks
for the shared ra state so it's kind of difficult to say whether some
workload will not now more often clobber the ra state resulting in poor
readahead behavior. Also as I looked into the patch now another objection I
have is that force_page_cache_ra() previously didn't touch the ra state at
all, it just read the requested pages. After the patch
force_page_cache_ra() will destroy the readahead state completely. This is
definitely something we don't want to do.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

