Return-Path: <linux-fsdevel+bounces-13246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F8386DA88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167A0286779
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45647F73;
	Fri,  1 Mar 2024 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m+qSHgwI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="07MwUXlV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KFTHe4Hz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fEBSCoZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC4C383A5
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266161; cv=none; b=LGOfJT8qiaN+3RNkjVhOFOIgP7LnVm617aPcDdYGmhkQEgncFMgvGQAWF/gOKo4L6J/QIV+rENVxuuQFReXoStu3/vnOrcOHe0BQnXvtAjPh9F+ReIdyRnAtRLVmsy7R9/csbskGjbkLBhVOGxW/+JoOfQoK9wn8TVdbJ/qvglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266161; c=relaxed/simple;
	bh=zUs9gVbWI2SttdbkIfu8tQMRT2O5UEzJARtVl+c4JyY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=COXeAIe7D2dx3+ucR83VIleNizNKXGCbz8ZtTrxYBrSvZ3uMkA1MH+VuwYS14Ntsy4bU34mmVfulwrJQsqwUXF8eHtpsQNeEOmZg+ELmnV5OZ7kpUTVQZP4vTOrTiHU+sSybNAsm3qndcqpzoMI9adO7YnqXLSWp+yksCFhDZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m+qSHgwI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=07MwUXlV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KFTHe4Hz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fEBSCoZn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0AC621F07;
	Fri,  1 Mar 2024 04:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709266157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WDjlbz9MG16LGcrG91DgMR+ALdQG1Bsj7M2alM87yg=;
	b=m+qSHgwIxBaP+0u6YkKNJH2oV4wrKmW1Sd2vYt8a6aVkO3FQSTRojqOd3bCVifGfs89I+n
	TeUcmAKrF97Rz8enSX8JLPuu9qyxwVtxp8FMhRlq2ZTNK/XDCqwZRYRkNhxrM6AheGfUKH
	1FruQGgFe0IVKxDViPd9cwIaAW7lYOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709266157;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WDjlbz9MG16LGcrG91DgMR+ALdQG1Bsj7M2alM87yg=;
	b=07MwUXlVDTZ+dr9Ds51voU+28i23/ot9OHWK1wh8utSchlNMeBgB1TiTAO/bWa2vVnMQo8
	eitU+lmbLwrAPnDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709266156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WDjlbz9MG16LGcrG91DgMR+ALdQG1Bsj7M2alM87yg=;
	b=KFTHe4HzEXaWhlQ5o4Hi4agBrVutdsVh3sgewbYUUFm5OQaEbeOLb6Odp3J47NNQIMu9rh
	YGHvlzTtxkyr+yP0QkR1S7APoHMMiXkriAiGc74gJrSGNpeQcjeYnM8HyLCdYBRsZA0py+
	IWXq9iPymH4QOgCeSIU63vVb8xwhRLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709266156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5WDjlbz9MG16LGcrG91DgMR+ALdQG1Bsj7M2alM87yg=;
	b=fEBSCoZnzOzW6jEeVakiB1p4GLgzzwZkG8DkvOGvQNdTKOOzwqz+y+jDkrBTFM/AD9B+U9
	XuHqkhQy/7X1ZfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2025613AB0;
	Fri,  1 Mar 2024 04:09:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5iltLehU4WW/WAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 01 Mar 2024 04:09:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Kent Overstreet" <kent.overstreet@linux.dev>
Cc: "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Amir Goldstein" <amir73il@gmail.com>,
 paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
In-reply-to: <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>,
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>,
 <Zd-LljY351NCrrCP@casper.infradead.org>,
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>,
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>,
 <ZeFCFGc8Gncpstd8@casper.infradead.org>,
 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>,
 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>,
 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>,
 <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
Date: Fri, 01 Mar 2024 15:09:09 +1100
Message-id: <170926614942.24797.13632376785557689080@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KFTHe4Hz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fEBSCoZn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_CC(0.00)[hansenpartnership.com,infradead.org,gmail.com,kernel.org,lists.linux-foundation.org,kvack.org,vger.kernel.org,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: D0AC621F07
X-Spam-Flag: NO

On Fri, 01 Mar 2024, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 10:52:06PM -0500, Kent Overstreet wrote:
> > On Fri, Mar 01, 2024 at 10:33:59AM +0700, James Bottomley wrote:
> > > On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> > > > Or maybe you just want the syscall to return an error instead of
> > > > blocking for an unbounded amount of time if userspace asks for
> > > > something silly.
> > > 
> > > Warn on allocation above a certain size without MAY_FAIL would seem to
> > > cover all those cases.  If there is a case for requiring instant
> > > allocation, you always have GFP_ATOMIC, and, I suppose, we could even
> > > do a bounded reclaim allocation where it tries for a certain time then
> > > fails.
> > 
> > Then you're baking in this weird constant into all your algorithms that
> > doesn't scale as machine memory sizes and working set sizes increase.
> > 
> > > > Honestly, relying on the OOM killer and saying that because that now
> > > > we don't have to write and test your error paths is a lazy cop out.
> > > 
> > > OOM Killer is the most extreme outcome.  Usually reclaim (hugely
> > > simplified) dumps clean cache first and tries the shrinkers then tries
> > > to write out dirty cache.  Only after that hasn't found anything after
> > > a few iterations will the oom killer get activated
> > 
> > All your caches dumped and the machine grinds to a halt and then a
> > random process gets killed instead of simply _failing the allocation_.
> > 
> > > > The same kind of thinking got us overcommit, where yes we got an
> > > > increase in efficiency, but the cost was that everyone started
> > > > assuming and relying on overcommit, so now it's impossible to run
> > > > without overcommit enabled except in highly controlled environments.
> > > 
> > > That might be true for your use case, but it certainly isn't true for a
> > > cheap hosting cloud using containers: overcommit is where you make your
> > > money, so it's absolutely standard operating procedure.  I wouldn't
> > > call cheap hosting a "highly controlled environment" they're just
> > > making a bet they won't get caught out too often.
> > 
> > Reading comprehension fail. Reread what I wrote.
> > 
> > > > And that means allocation failure as an effective signal is just
> > > > completely busted in userspace. If you want to write code in
> > > > userspace that uses as much memory as is available and no more, you
> > > > _can't_, because system behaviour goes to shit if you have overcommit
> > > > enabled or a bunch of memory gets wasted if overcommit is disabled
> > > > because everyone assumes that's just what you do.
> > > 
> > > OK, this seems to be specific to your use case again, because if you
> > > look at what the major user space processes like web browsers do, they
> > > allocate way over the physical memory available to them for cache and
> > > assume the kernel will take care of it.  Making failure a signal for
> > > being over the working set would cause all these applications to
> > > segfault almost immediately.
> > 
> > Again, reread what I wrote. You're restating what I wrote and completely
> > missing the point.
> > 
> > > > Let's _not_ go that route in the kernel. I have pointy sticks to
> > > > brandish at people who don't want to deal with properly handling
> > > > errors.
> > > 
> > > Error legs are the least exercised and most bug, and therefore exploit,
> > > prone pieces of code in C.  If we can get rid of them, we should.
> > 
> > Fuck no.
> > 
> > Having working error paths is _basic_, and learning how to test your
> > code is also basic. If you can't be bothered to do that you shouldn't be
> > writing kernel code.
> > 
> > We are giving far too much by going down the route of "oh, just kill
> > stuff if we screwed the pooch and overcommitted".
> > 
> > I don't fucking care if it's what the big cloud providers want because
> > it's convenient for them, some of us actually do care about reliability.
> > 
> > By just saying "oh, the OO killer will save us" what you're doing is
> > making it nearly impossible to fully utilize a machine without having
> > stuff randomly killed.
> > 
> 
> And besides all that, as a practical matter you can't just "not have
> erro paths" because, like you said, you'd still have to have a max size
> where you WARN() - and _fail the allocation_ - and you've still got to
> unwind.

No.  You warn and DON'T fail the allocation.  Just like lockdep warns of
possible deadlocks but lets you continue.
These will be found in development (mostly) and changed to use
__GFP_RETRY_MAYFAIL and have appropriate error-handling paths.


> 
> The OOM killer can't kill processes while they're stuck blocking on an
> allocation that will rever return in the kernel.

But it can depopulate the user address space (I think).

NeilBrown


> 
> I think we can safely nip this idea in the bud.
> 
> Test your damn error paths...
> 


