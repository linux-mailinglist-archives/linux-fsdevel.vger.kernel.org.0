Return-Path: <linux-fsdevel+bounces-19880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD638CADC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E79821C22106
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DF274C04;
	Tue, 21 May 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dln6Qhhx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d9Q4y6/v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QTGjKMCy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NV+ufc4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F97487BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292747; cv=none; b=C9pPey8jXi0JSmOrYHi92afNTovKJDgxdu6kl4NJ4z3GnGX/3itq7M4fOuJvPxUuU90myFHdW6fyJeleZeXHW8w7qIoGWoKjrbWzRz9fxqqEXhRZymGSxI2oJcDiTka5ftxFHqCmoiBYcj3HHhwgR8Klt/epE53e9A/G9x6LiKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292747; c=relaxed/simple;
	bh=aa6ePN/91P708liDBHJflV43v4SANV6YQ0nA2mXjKcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQcVD5YIABL7liNwG1auGJh/U+Zg8O5R1NqWzAsAR5ORzdJn1mUC4XiCjNVHKbhvIT0adKewcF7nIaKC3gWYiAJJ+8xPxdC4VVQ2Jo13VqPVjYTDkAT0hockdr69BJkVAgnb56oDRD5vub0ODo9XHrh8JeUs2+Xy8+jPB1P2ylE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dln6Qhhx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d9Q4y6/v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QTGjKMCy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NV+ufc4m; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6CA35C103;
	Tue, 21 May 2024 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716292744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECKwUHWeO4MPyXbZeLtDgiv4tfaZ5MhntyNlJrTN0h8=;
	b=dln6Qhhxoezbhm1gb9Hd4/k/LuC0trON++uLtwQMAlpvVjYYGdUvZ7OwT7/eLMAJ7UKAjn
	FSa4JT39p3ybsZ70N49xA/+AgaiYQz5KFneYo0IH5ysOY2HYsE8vqe5BxgBhaVa0AKgAle
	WfYLpj4RmQcUwFl7zK0WwvUQwK18Q6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716292744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECKwUHWeO4MPyXbZeLtDgiv4tfaZ5MhntyNlJrTN0h8=;
	b=d9Q4y6/v+V7/DUcoESvRz2AuCLTJMN6xVFxG33GWLWrXGduQ0mjduPETHy1CidDCmC5Rzw
	Q5evUNdtbnEcJKAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716292742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECKwUHWeO4MPyXbZeLtDgiv4tfaZ5MhntyNlJrTN0h8=;
	b=QTGjKMCyXeCCrXq5k/COeg9/I7DIgkOyujGKLEbyLebRrPjV7r+3MbkJTwujSeCeNOC1ry
	Vddi5kIZeZNWWm2ocLyizCNsv7avGHWT6HFLgApSP6szx9EwnvXuwmXAGegmDokbvn8B2V
	zCMXqxFYN0RwLLVKRnVEtUmIvPFK144=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716292742;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ECKwUHWeO4MPyXbZeLtDgiv4tfaZ5MhntyNlJrTN0h8=;
	b=NV+ufc4mVZDbmTltiMAg0i4+URlNr5TUDob3R1gQSSV83VJkr0PrnbF0I6H/MiCcqTg06J
	sXkxQK44o7O2gfBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD12013A21;
	Tue, 21 May 2024 11:59:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xTgiLoaMTGZXEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 May 2024 11:59:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4AE30A0757; Tue, 21 May 2024 13:58:58 +0200 (CEST)
Date: Tue, 21 May 2024 13:58:58 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fsnotify changes for 6.10-rc1
Message-ID: <20240521115858.mohqrlbzprdisc5i@quack3>
References: <20240520112239.pz35myprqju2gzo6@quack3>
 <CAHk-=whPmdZS5sNE3k4CUYOu79kE88VsfW0hyMBkVE9Wk-UjZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPmdZS5sNE3k4CUYOu79kE88VsfW0hyMBkVE9Wk-UjZw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]

On Mon 20-05-24 12:46:44, Linus Torvalds wrote:
> On Mon, 20 May 2024 at 04:22, Jan Kara <jack@suse.cz> wrote:
> >
> >   * A few small cleanups
> 
> This IS NOT A CLEANUP! It's a huge mistake:
> 
> > Nikita Kiryushin (1):
> >       fanotify: remove unneeded sub-zero check for unsigned value
> 
> The old code did
> 
>     WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
> 
> and that is very legible and very understandable to humans.
> 
> The new code is
> 
>     WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
> 
> and now a human that reads that line needs to go back and check what
> the type of 'len' is to notice that it's unsigned. It is not at all
> clear from the context, and the declaration of 'len' is literally 80
> lines up. Not very close at all, in other words.

So I was hesitating whether to take this or not because I liked the len < 0
check as well. Then I've convinced myself that the impression this check
gives that "if we miscomputed and used more than we should, the
WARN_ON_ONCE() would trigger" is incorrect because of underflow so better
delete it. But now that I've written it down and looked again that
impression is actually correct because the len >= FANOTIFY_EVENT_ALIGN
check will catch that situation instead. Long story short, I agree with
your revert.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

