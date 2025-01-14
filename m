Return-Path: <linux-fsdevel+bounces-39139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017EA10843
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703DB3A85F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9D136E21;
	Tue, 14 Jan 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecWS653C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ln5OSU9T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ecWS653C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ln5OSU9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFD130A73;
	Tue, 14 Jan 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863122; cv=none; b=CXvO9KfF0JYkKwJurVwYGl0Jf416BeSFjnW79suMFg4OpbfsHswgvJ0S0JCA1NExywaK5PF6lLl8sYsejEUvarqocMupHl0rMZLLjkktwLQZK3h0gU7+BqLCwiZ3PJgtwsLWTGkmAqCcKeUMFCTZrRZYRQOaYIQQeHlVlgAvS2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863122; c=relaxed/simple;
	bh=IGqkx4X7wa7i3kT6/5gv42mXQHNtanOIbEAM/Y0DgCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYLOPmRYQZ6h+F1H8MERKhKUi262aeZsUGKeNvreMyOuOMAj0RxF36liTAhh6C4tz2l6mlmg1O42yNrn0QGu+eyn6+TmjVvekieKoA9jnkGvUT4O4QpZ/mb0tsUr3rJWClHOrB6pwmAM7ATjYV8yxM0HlTOQPq5zBxO55mKztP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecWS653C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ln5OSU9T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ecWS653C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ln5OSU9T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E4B42117B;
	Tue, 14 Jan 2025 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736863118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrrC1Ay1frUFzvKXOzH8OW8eOdadzQMCqSZhD6SX44=;
	b=ecWS653CiFEb2Rq3v9zlzFbpKhV6CSzEIQ+kl2PikhdhaDu7JT3xtTOMFRdkXwI6MBDm6o
	DTFM7bKj7uedvd7DCw2z5BPYe1oWljGS9zQZPQI41zcmj07Bt9m1BUxvEJEMb2k4XbGIyf
	Ct29Y9sMWJhRlUmNjwYqxhjfaSMXVhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736863118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrrC1Ay1frUFzvKXOzH8OW8eOdadzQMCqSZhD6SX44=;
	b=ln5OSU9T7DlL2t4sqI98YnV6Y7Q2Ic7tU6wHZQfQDzBwVOxaNeKKT3e93M6erKmgo7dPAZ
	1zhKH0kFFp2K2nCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ecWS653C;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ln5OSU9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736863118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrrC1Ay1frUFzvKXOzH8OW8eOdadzQMCqSZhD6SX44=;
	b=ecWS653CiFEb2Rq3v9zlzFbpKhV6CSzEIQ+kl2PikhdhaDu7JT3xtTOMFRdkXwI6MBDm6o
	DTFM7bKj7uedvd7DCw2z5BPYe1oWljGS9zQZPQI41zcmj07Bt9m1BUxvEJEMb2k4XbGIyf
	Ct29Y9sMWJhRlUmNjwYqxhjfaSMXVhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736863118;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrrC1Ay1frUFzvKXOzH8OW8eOdadzQMCqSZhD6SX44=;
	b=ln5OSU9T7DlL2t4sqI98YnV6Y7Q2Ic7tU6wHZQfQDzBwVOxaNeKKT3e93M6erKmgo7dPAZ
	1zhKH0kFFp2K2nCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BBD2139CB;
	Tue, 14 Jan 2025 13:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rSItCo5thme7VAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jan 2025 13:58:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF308A08CD; Tue, 14 Jan 2025 14:58:37 +0100 (CET)
Date: Tue, 14 Jan 2025 14:58:37 +0100
From: Jan Kara <jack@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Jan Kara <jack@suse.cz>, 
	Kun Hu <huk23@m.fudan.edu.cn>, jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca, 
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk, 
	christian.brauner@ubuntu.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, brauner@kernel.org, linux-bcachefs@vger.kernel.org, 
	syzkaller@googlegroups.com
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <435wi7dfddjqhn5yxuw34tww2gyr4x2oeh3s25htuwl7cwggza@zuyzyrha7qk6>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <gwgec4tknjmjel4e37myyichugheuba3sy7cxkdqqj2raaglf5@n7uttxolimpa>
 <ftg6ukiq5secljpfloximhor2mjvda7qssydeqky4zcv4dpxxw@jadua4pcalva>
 <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZtHUhXpETW+x8FpNbvN=xtKGZ1sBUQDr3TtKM+=7-xcg@mail.gmail.com>
X-Rspamd-Queue-Id: 3E4B42117B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 14-01-25 10:07:03, Dmitry Vyukov wrote:
> I also don't fully understand the value of "we also reported X bugs to
> the upstream kernel" for research papers. There is little correlation
> with the quality/novelty of research.

Since I was working in academia in the (distant) pass, let me share my
(slightly educated) guess: In the paper you're supposed to show practical
applicability and relevance of the improvement you propose. It doesn't have
to be really useful but it has to sound useful enough to convince paper
reviewer. I suppose in the fuzzer area this "practical applicability" part
boils down how many bugs were reported...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

