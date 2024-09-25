Return-Path: <linux-fsdevel+bounces-30057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA8E985794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 13:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B060F1C23572
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A15884A5E;
	Wed, 25 Sep 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVVtuOHR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWbi3bAX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GVVtuOHR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IWbi3bAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D9A482D8
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262303; cv=none; b=SD5UKAr6QEr6HmliYNfK+zrt+j9Y8KVUculGTbjmuwuFH2qdF80V5Ta7WUa8mj6PM2G0I/HbAwppN/z+q4DwATxChu3FPWE2M80EvlBxeCtbThH9wTkj/JmeXfQ3zUu+JBfLCa4bpsFJOP/B6XrR6pANc7lVJeVHn4BCRA4tw44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262303; c=relaxed/simple;
	bh=E4fCpgjnoprNvRxEJqsKDJ8Z0NF9XOf4pzni94PSKLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N51qLuYoI6VmaQCfmSmUndrzJcaySOnLIeN0teAjBMFkPqpqSJQguoGAdoyroyvPxzW7HLdaYlgKK/OMx7CQ4Jd1ybCKn6C9BC/aoHc8elC9WroKdIHN4cle508rtiKT0xZOXyK896q3GhcQQEMg1fdoBkDovZjkh/iFED243cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVVtuOHR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWbi3bAX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GVVtuOHR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IWbi3bAX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF33821A9B;
	Wed, 25 Sep 2024 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727262298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTuBFDkrrkufJsoS8TZxooJtZUCCC1WcKqkLyBm1JRo=;
	b=GVVtuOHRPFARqxiAxXB/R6bgvu6xxGK9KRkA50aypl8D3FdPq3diB7JwqTNnF4meTVWSp/
	13xFFYU0jzDf6nXOu2Jv7zYBxAFqYm5PS1YwHDWO73er3+nElD1iFqrFgsjsdBTrfYXT/c
	YKBKkA7mkckD/U7y24I0GjErJFaGCqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727262298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTuBFDkrrkufJsoS8TZxooJtZUCCC1WcKqkLyBm1JRo=;
	b=IWbi3bAXQ3jZVR53Q7eLl34CYJxy4AyZ/Ia0+jN4pzCYL2kWScYqglBEd+it6f7HHsAy8c
	gULUrPJJWropxIAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727262298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTuBFDkrrkufJsoS8TZxooJtZUCCC1WcKqkLyBm1JRo=;
	b=GVVtuOHRPFARqxiAxXB/R6bgvu6xxGK9KRkA50aypl8D3FdPq3diB7JwqTNnF4meTVWSp/
	13xFFYU0jzDf6nXOu2Jv7zYBxAFqYm5PS1YwHDWO73er3+nElD1iFqrFgsjsdBTrfYXT/c
	YKBKkA7mkckD/U7y24I0GjErJFaGCqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727262298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTuBFDkrrkufJsoS8TZxooJtZUCCC1WcKqkLyBm1JRo=;
	b=IWbi3bAXQ3jZVR53Q7eLl34CYJxy4AyZ/Ia0+jN4pzCYL2kWScYqglBEd+it6f7HHsAy8c
	gULUrPJJWropxIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C7B713793;
	Wed, 25 Sep 2024 11:04:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r27pJVru82blMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 11:04:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 34BD7A089B; Wed, 25 Sep 2024 13:04:54 +0200 (CEST)
Date: Wed, 25 Sep 2024 13:04:54 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] Fsnotify changes for 6.12-rc1
Message-ID: <20240925110454.ao2kcpfqba6uygnc@quack3>
References: <20240923110348.tbwihs42dxxltabc@quack3>
 <CAHk-=wiE1QQ-_kTKSf4Ur6JEjMtieu7twcLqu_CH4r1daTBiCw@mail.gmail.com>
 <20240923191322.3jbkvwqzxvopt3kb@quack3>
 <CAHk-=whm4QfqzSJvBQFrCi4V5SP_iD=DN0VkxfpXaA02PKCb6Q@mail.gmail.com>
 <20240924092757.lev6mwrmhpcoyjtu@quack3>
 <CAHk-=wgzLHTi7s50-BE7oq_egpDnUqhrba+EKux0NyLvgphsEw@mail.gmail.com>
 <e46d20c8-c201-41fd-93ea-6d5bc1e38c6d@linux.alibaba.com>
 <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wijqCH+9HUkOgwT_f1o4Tp05ACQUFG9YrxLpOVdRoCwpw@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 24-09-24 18:15:51, Linus Torvalds wrote:
> On Tue, 24 Sept 2024 at 17:17, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >
> > Just side note: I think `generic_file_vm_ops` already prepares this
> > feature, so generic_file_mmap users also have fault around behaviors.
> 
> Hmm. Maybe. But it doesn't really change the fundamental issue - the
> code in question seems to be just *random*.
> 
> And I mean that in a very real and very immediate sense: the
> fault-around code and filemap_map_pages() only maps in pages that are
> uptodate, so it literally DEPENDS ON TIMING whether some previous IO
> has completed or not, and thus on whether the page fault is handled by
> the fault-around in filemap_map_pages() or by the filemap_fault()
> code.
> 
> In other words - I think this is all completely broken.
> 
> Put another way: explain to me why random IO timing details should
> matter for the whether we do __filemap_fsnotify_fault() on a page
> fault or not?

I agree that with the fault-around code, there's dependency on IO
completion time. So we can still be generating PRE_ACCESS events while the
data is being loaded from the disk. This was a compromise we ended up with
after quite some discussions about possible solutions. Generally the
options I see for page faults are:

1) Generate PRE_ACCESS event whenever a page is being mapped into page
tables (in fact Josef originally had this in his patch). This would
provide the determinism at the cost of performance (events generated even
for cached pages). If this is OK with you, we can do that but from what I
gather from your previous emails you don't really like this either.

2) We could generate event in filemap_fault() only if we don't find
uptodate folio there. I'm happy to do this if it looks better to you
although I don't think there's a practical difference from the current
state (the same raciness with IO completion applies, just the window is
smaller).

3) We could generate event in filemap_fault() only if we didn't find a
folio in the page cache or we found it, locked it, but it still was not
uptodate. This will make sure we generate the event only if we really need
to pull in the data into the page cache. Doable. The case when we found &
locked a page that's not uptodate in the end will be a bit ugly but not too
bad and this case should be rare. I actually like this option the most I
guess. 

> So no. I'm not taking this pull request. It makes absolutely zero
> sense to me, and I don't think it has sane semantics.  The argument
> that it is already used by people is not an argument.

I mentioned that to show that there's practical interest in this kind of
functionality. I think people involved understand things are pretty much in
flux until they are merged upstream.

> The new fsnotify hooks need to make SENSE - not be in random locations
> that give some kind of random data.

Thanks for feedback. So 1) and 3) from the above options make sense to me
(in the sense that it is relatively easy to explain when events are
generated). I'd prefer 3) for performance reasons so can we settle on that?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

