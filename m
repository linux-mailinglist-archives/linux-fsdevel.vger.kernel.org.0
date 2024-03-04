Return-Path: <linux-fsdevel+bounces-13418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56586F830
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00886280E70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 01:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AE815A4;
	Mon,  4 Mar 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="atb0aJov";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cxZ3s6R/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="atb0aJov";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cxZ3s6R/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C061362
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 01:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709515651; cv=none; b=RGGKI1aooluRd/FeAmZzmm7LxdNKA+i9++3El2FjrNCb6sTwr0ftYoEzzSbUBSl8xbwLfpnyWXM/ggRbU4V6Hb/q+rSN1THlUg9ofs9DDbAn2Y5I56jcEmoyLyhqUUVWTpFKjChkAj4Pm9rh+2fOG2kl/lBirdZqH31dvwh0LjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709515651; c=relaxed/simple;
	bh=EeR9FBAi1tXuafYmzED9zORn7/Zw+DrvzhyFXwSyO7c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=G2eYLqsMhW55E2GeYjMJJzn5ll6z7nCIE8ciXZbvo5v7MmZ5eoC1GprgOhMFOh2lveo7zc2ByMin2TcxHtkoHifs1T2sc7aCiWPJrPAzlNTaX7OdsaJAdKRUUfZjJe/AohLUrjftrAwad4TZKe2bWIFTURyD7OJrBSDPlmQBj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=atb0aJov; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cxZ3s6R/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=atb0aJov; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cxZ3s6R/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27C9D4D36E;
	Mon,  4 Mar 2024 01:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709515647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY73jSbHy5FdrIntQy28JDy9NrIs5O6B8GeLuqNrspw=;
	b=atb0aJov6tcmhbj/DMo/TGs2Q4JyCAEu6Renbj48+2+LWYaq/odCc4t/WSQKZQzx7eLsSy
	zB5lHC+IktKhsQDH7w+oFwRFau0SPL4Aa74ecfGKRR2yEYP2+z0zpLZOV4T9iE16WHYCBJ
	hrXQUjsmPXB5qGY5LKj/jTwS6cAKyIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709515647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY73jSbHy5FdrIntQy28JDy9NrIs5O6B8GeLuqNrspw=;
	b=cxZ3s6R/fLiJHptnYMYF5wueWZ0db8ds9J5KuQA1D56LPUq5gHHl0KU/0Dc6/sluVHK7fS
	j6b9PuBR52R/laDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709515647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY73jSbHy5FdrIntQy28JDy9NrIs5O6B8GeLuqNrspw=;
	b=atb0aJov6tcmhbj/DMo/TGs2Q4JyCAEu6Renbj48+2+LWYaq/odCc4t/WSQKZQzx7eLsSy
	zB5lHC+IktKhsQDH7w+oFwRFau0SPL4Aa74ecfGKRR2yEYP2+z0zpLZOV4T9iE16WHYCBJ
	hrXQUjsmPXB5qGY5LKj/jTwS6cAKyIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709515647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VY73jSbHy5FdrIntQy28JDy9NrIs5O6B8GeLuqNrspw=;
	b=cxZ3s6R/fLiJHptnYMYF5wueWZ0db8ds9J5KuQA1D56LPUq5gHHl0KU/0Dc6/sluVHK7fS
	j6b9PuBR52R/laDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F5841379D;
	Mon,  4 Mar 2024 01:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x/2mAHsj5WVrDAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 01:27:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Kent Overstreet" <kent.overstreet@linux.dev>,
 "Dave Chinner" <david@fromorbit.com>, "Amir Goldstein" <amir73il@gmail.com>,
 paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <ZeUXORziOwkuB-tP@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <ZeFtrzN34cLhjjHK@dread.disaster.area>,
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>,
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>,
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>,
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>,
 <ZeUXORziOwkuB-tP@casper.infradead.org>
Date: Mon, 04 Mar 2024 12:27:19 +1100
Message-id: <170951563963.24797.10928820769529800242@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=atb0aJov;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="cxZ3s6R/"
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,fromorbit.com,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.44%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 27C9D4D36E
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Mon, 04 Mar 2024, Matthew Wilcox wrote:
> On Mon, Mar 04, 2024 at 09:45:48AM +1100, NeilBrown wrote:
> > I have in mind a more explicit statement of how much waiting is
> > acceptable.
> > 
> > GFP_NOFAIL - wait indefinitely
> > GFP_KILLABLE - wait indefinitely unless fatal signal is pending.
> > GFP_RETRY - may retry but deadlock, though unlikely, is possible.  So
> >             don't wait indefinitely.  May abort more quickly if fatal
> >             signal is pending.
> > GFP_NO_RETRY - only try things once.  This may sleep, but will give up
> >             fairly quickly.  Either deadlock is a significant
> >             possibility, or alternate strategy is fairly cheap.
> > GFP_ATOMIC - don't sleep - same as current.
> 
> I don't think these should be GFP flags.  Rather, these should be
> context flags (and indeed, they're mutually exclusive, so this is a
> small integer to represent where we are on the spectrum).  That is
> we want code to do
> 
> void *alloc_foo(void)
> {
> 	return init_foo(kmalloc(256, GFP_MOVABLE));
> }
> 
> void submit_foo(void)
> {
> 	spin_lock(&submit_lock);
> 	flags = memalloc_set_atomic();
> 	__submit_foo(alloc_foo());
> 	memalloc_restore_flags(flags);
> 	spin_unlock(&submit_lock);
> }
> 
> struct foo *prealloc_foo(void)
> {
> 	return alloc_foo();
> }
> 
> ... for various degrees of complexity.  That is, the _location_ of memory
> is allocation site knowledge, but how hard to try is _path_ dependent,
> and not known at the allocation site because it doesn't know what locks
> are held.
> 

I'm not convinced.  While there is a path dependency there is also
location dependency.
The code at the call-site determines what happens in response to
failure.
For GFP_NOFAIL, failure is not possible.  We cannot allow context to
turn NOFAIL into NOSLEEP because context cannot add error handling.

Consider mempool_alloc().  That requests a NORETRY allocation because
there is an easy fall-back.  Is that a location dependency or a path
dependency?  I would say it is location.  Of course a location is just a
very short path so it is a path dependency too - but is that perspective
really helpful?

Certainly I could accept a GFP_WHATEVER which uses NOSLEEP if path
context demands that, and NO_OOM otherwise.

Thanks,
NeilBrown

