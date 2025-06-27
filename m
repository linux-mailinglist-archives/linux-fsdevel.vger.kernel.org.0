Return-Path: <linux-fsdevel+bounces-53154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5FAEB0AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7141C22EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 07:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A388E229B15;
	Fri, 27 Jun 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FbbeNE/T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kty7AgHZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2fJ8jZ9U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hpagzk4S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644742264BF
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751010925; cv=none; b=KLrnY4sOH3zWbxhfK3G7TWhrWY4ZrCCTtPK203UeV5OAwV5qBvlkgtzGbKsN2CLG81tSDkCp9L1XldKcezMH+26K+qLqrKO677KczkibSop1Up1daAmt6gVR+EVKCeG2nYRXeurP8mqnZlyhgz0vY5iHnapsE9w+j65r+hn58D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751010925; c=relaxed/simple;
	bh=W43fmgGb+2NzyqFCSS0630HfRedK2fz7xXA7ehGegzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+EVdC/9abP4diUa1e8BBygs+FGwgKv/C6sHV8sSLJ8tgSIVNcGdaVN0kGzj6KmQCKX7PWARis5/6hYClVkcHHial632uiC2sd8BAR/c3z7/046errl+vnRD7FBTcnEAvZTp/+P5dMtJkyMsof/nmh34bEm1toFWPEYCulAMhTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FbbeNE/T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kty7AgHZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2fJ8jZ9U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hpagzk4S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A5C021174;
	Fri, 27 Jun 2025 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751010921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptecp9XDD5qXUjm1CHcOI25++V3ZYV625LMiuMqRD10=;
	b=FbbeNE/TjNlk4A5o+6fTzCVPxDsccqxkglkAUwvwXESso0vOSRA93wslhbMWSdcgx2I9A1
	FxsYl8peLk6l5FlB8AleHM4sdaXJe+cEOsXjVgIMGRYviXwc03H/7rf2+6l1NPsoASQO8Z
	wzfkH8nr4OzuWShSLrvWP5nrRCOcpbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751010921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptecp9XDD5qXUjm1CHcOI25++V3ZYV625LMiuMqRD10=;
	b=Kty7AgHZB6YBFhZcKRw2mTyW6CJChk6RVH9k5j8RNgF+vqOqoDBVsN3ynKtce9dk3L4P2Z
	9VKCowIUIdiFr1CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751010920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptecp9XDD5qXUjm1CHcOI25++V3ZYV625LMiuMqRD10=;
	b=2fJ8jZ9UnZlpBq7wdYctaRSdNpHrqZzHhjN/Plxy+wxWVUpw93g2jWHdviq1K8Z9WZkhjb
	tL7jzDF3f1yKYcyY69EhbD6WS85W5KiM1KDVbp62R7ZM9CBX94CmJISxLdgPi6korVp0S2
	k5TJhnCTONmdTMdl3bJVHLNGlUr3awU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751010920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ptecp9XDD5qXUjm1CHcOI25++V3ZYV625LMiuMqRD10=;
	b=Hpagzk4Sk2vJIqYpZVOghUpIQqL6dR5KUuMdCT2yVko6zVkWWutCvArYyCSpKT1jNDVWP9
	c0nvjxBxvkOKNUDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5894713786;
	Fri, 27 Jun 2025 07:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IbGcFWhOXmgIUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Jun 2025 07:55:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D996FA099D; Fri, 27 Jun 2025 09:55:19 +0200 (CEST)
Date: Fri, 27 Jun 2025 09:55:19 +0200
From: Jan Kara <jack@suse.cz>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Kuan-Ying Lee <kuan-ying.lee@canonical.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Etienne Buira <etienne.buira@free.fr>, 
	Antonio Quartulli <antonio@mandelbit.com>, Illia Ostapyshyn <illia@yshyn.com>, 
	"open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>, "open list:PER-CPU MEMORY ALLOCATOR" <linux-mm@kvack.org>, 
	"open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>, "open list:KASAN" <kasan-dev@googlegroups.com>, 
	"open list:MAPLE TREE" <maple-tree@lists.infradead.org>, "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>, 
	"open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their
 relevant subsystems
Message-ID: <iup2plrwgkxlnywm3imd2ctkbqzkckn4t3ho56kq4y4ykgzvbk@cefy6hl7yu6c>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
 <fynmrmsglw4liexcb37ykutf724lh7zbibilcjpysbmvgtkmes@mtjrfkve4av7>
 <c66deb8f-774e-4981-accf-4f507943e08c@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c66deb8f-774e-4981-accf-4f507943e08c@broadcom.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[free.fr,gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLb9dmf7wrehepajhg9kqn5udf)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,siemens.com,kernel.org,baylibre.com,gentwo.org,linuxfoundation.org,suse.com,goodmis.org,linutronix.de,chromium.org,linaro.org,gmail.com,google.com,arm.com,linux-foundation.org,samsung.com,linux.dev,zeniv.linux.org.uk,suse.cz,infradead.org,canonical.com,linux.ibm.com,free.fr,mandelbit.com,yshyn.com,kvack.org,googlegroups.com,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu 26-06-25 09:39:36, Florian Fainelli wrote:
> On 6/26/25 09:17, Liam R. Howlett wrote:
> > * Florian Fainelli <florian.fainelli@broadcom.com> [250625 19:13]:
> > > Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
> > > that provide OS awareness for debuggers and allows for debugging of a
> > > variety of data structures (lists, timers, radix tree, mapletree, etc.)
> > > as well as subsystems (clocks, devices, classes, busses, etc.).
> > > 
> > > These scripts are typically maintained in isolation from the subsystem
> > > that they parse the data structures and symbols of, which can lead to
> > > people playing catch up with fixing bugs or updating the script to work
> > > with updates made to the internal APIs/objects etc. Here are some
> > > recents examples:
> > > 
> > > https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
> > > https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
> > > https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/
> > > 
> > > This patch series is intentionally split such that each subsystem
> > > maintainer can decide whether to accept the extra
> > > review/maintenance/guidance that can be offered when GDB scripts are
> > > being updated or added.
> > 
> > I don't see why you think it was okay to propose this in the way you
> > have gone about it.  Looking at the mailing list, you've been around for
> > a while.
> 
> This should probably have been posted as RFC rather than PATCH, but as I
> indicate in the cover letter this is broken down to allow maintainers like
> yourself to accept/reject
> 
> > 
> > The file you are telling me about seems to be extremely new and I needed
> > to pull akpm/mm-new to discover where it came from.. because you never
> > Cc'ed me on the file you are asking me to own.
> 
> Yes, that file is very new indeed, and my bad for not copying you on it.
> 
> I was not planning on burning an entire day worth of work to transition the
> GDB scripts dumping the interrupt tree away from a radix tree to a maple
> tree. All of which happens with the author of that conversion having
> absolutely no idea that broke anything in the tree because very few people
> know about the Python GDB scripts that Linux has. It is not pleasant to be
> playing catch when it would have take maybe an extra couple hours for
> someone intimately familiar with the maple tree to come up with a suitable
> implementation replacement for mtree_load().
> 
> So having done it felt like there is a maintenance void that needs to be
> filled, hence this patch set.

I can see that it takes a lot of time to do a major update of a gdb
debugging script after some refactoring like this. OTOH mandating some gdb
scripts update is adding non-trivial amount of work to changes that are
already hard enough to do as is. And the obvious question is what is the
value? I've personally never used these gdb scripts and never felt a strong
need for something like that. People have various debugging aids (like BPF
scripts, gdb scripts, there's crash tool and drgn, and many more) lying
around.  I'm personally of an opinion that it is not a responsibility of
the person doing refactoring to make life easier for them or even fixing
them and I don't think that the fact that some debug aid is under
scripts/gdb/ directory is making it more special. So at least as far as I'm
concerned (VFS, fsnotify and other filesystem related stuff) I don't plan
on requiring updates to gdb scripts from people doing changes or otherwise
actively maintain them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

