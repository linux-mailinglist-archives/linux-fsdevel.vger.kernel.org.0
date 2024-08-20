Return-Path: <linux-fsdevel+bounces-26408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4E95905D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 00:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9221C2216F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 22:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E5C1BE238;
	Tue, 20 Aug 2024 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JTDwi95G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbRW5H1T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E+dQBrmU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V8oHX71P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7129D19;
	Tue, 20 Aug 2024 22:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724192164; cv=none; b=t1kBdFTB7X7OtwUC0urXtkTKh4PaF4+O3bLt9npCzpCUaZKvnJF5f/yTVX0cEdh7k6w/PkDjhnaZtXIbTpC/24x4tJZ4HDiFlgWtqKV01FV6lCIH8Rixdy/KK/H+lNkmyPyUynEgqCB5gm71YYh4zP4bgsTfDzSvlPNkoH63q0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724192164; c=relaxed/simple;
	bh=xkny2TNAwXgAJM+V3pqXVwQ6tG479eGlCTbXjgQ54ys=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=efyTVG10OBvhEmdZTc8/d1YCGNrrBrWj11rGfrKl9auXri2Kny4DLQN6VqxmidjlCSDNHQVDplI+lWT0UnBomOjErJsmL+1Z34XgoN9DGkA1ovz0WQuqq3VokIlsZfng6BnyqEHAntUQM/pJP/tsN3fPPEx+CDzd05vDYjueHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JTDwi95G; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbRW5H1T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E+dQBrmU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V8oHX71P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF1621FD4B;
	Tue, 20 Aug 2024 22:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724192158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6OsG0kvR+6DSslimwhBgoFra0p0jbTOvG12ygRSKGY=;
	b=JTDwi95GZAZbfaqUEmMS0cQ+uZ3p6vz+O1ywWSPpc9s1EpNdmHw8ZUICNecNwliyt1Mlxv
	u0iIRS77tOq2wHw1OQPehVntQxsGh52mRBDDj2gLy3ZZwU56xsn3Ya9PP6MK37hXObEYTp
	QXgBP4GHBn4HGeQiHC70pOTaGKknjuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724192158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6OsG0kvR+6DSslimwhBgoFra0p0jbTOvG12ygRSKGY=;
	b=kbRW5H1TRcJ9UVl9KwFQP+E4XfmORnJnX7VIeY3HYtqC9FiYCdmnaoVxFYbUoYqooCCAOM
	XFtSZYdsoRcRI6Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724192157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6OsG0kvR+6DSslimwhBgoFra0p0jbTOvG12ygRSKGY=;
	b=E+dQBrmUnu0TpXoI+XQ7DlLGPug0aWGCqnWdrbQhdtbFPHbavigAB4zBi4iKis80iCR0yB
	Qdq8ZVBuOsByPv+ySNMZtsNIhP88z+hBYvOKxA0NEGEzBReJvOEeQqMKNIAuQ1uQ8LHqlA
	UyqDgBySZYjKsf0/2/xIbYnO0s/+2PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724192157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q6OsG0kvR+6DSslimwhBgoFra0p0jbTOvG12ygRSKGY=;
	b=V8oHX71PGi+qMvLEe8npzf7p34vpPu6Zsxyl9otxLi5pSVy6uF5zcOCvck8CXjAvB9/bZy
	R3b680enoBJoHCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB40C13770;
	Tue, 20 Aug 2024 22:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6JLI5sVxWbbIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 20 Aug 2024 22:15:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: "Ingo Molnar" <mingo@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
In-reply-to:
 <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
References:
 <>, <CAHk-=whxS9qM36w5jmf-F32LSC=+m3opufAdgfOBCoTDaS1_Ag@mail.gmail.com>
Date: Wed, 21 Aug 2024 08:15:44 +1000
Message-id: <172419214486.6062.12815120063228775100@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Wed, 21 Aug 2024, Linus Torvalds wrote:
> On Tue, 20 Aug 2024 at 14:47, NeilBrown <neilb@suse.de> wrote:
> >
> > I can definitely get behind the idea has having a few more helpers and
> > using them more widely.  But unless we get rid of wake_up_bit(), people
> > will still use and some will use it wrongly.
> 
> I do not believe this is a valid argument.
> 
> "We have interfaces that somebody can use wrongly" is a fact of life,
> not an argument.

The argument is more like "we have interfaces that are often used
wrongly and the resulting bugs are hard to find through testing because
they don't affect the more popular architectures".

> 
> The whole "wake_up_bit()" is a very special thing, and dammit, if
> people don't know the rules, then they shouldn't be using it.
> 
> Anybody using that interface *ALREADY* has to have some model of
> atomicity for the actual bit they are changing. And yes, they can get
> that wrong too.
> 
> The only way to actually make it a simple interface is to do the bit
> operation and the wakeup together. Which is why I think that
> interfaces like clear_bit_and_wake() or set_bit_and_wake() are fine,
> because at that point you actually have a valid rule for the whole
> operation.
> 
> But wake_up_bit() on its own ALREADY depends on the user doing the
> right thing for the bit itself. Putting a memory barrier in it will
> only *HIDE* incompetence, it won't be fixing it.
> 
> So no. Don't add interfaces that hide the problem.

Ok, thanks.  I'll focus my efforts on helper functions.

NeilBrown


> 
>                   Linus
> 


