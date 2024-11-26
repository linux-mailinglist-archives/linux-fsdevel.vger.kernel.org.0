Return-Path: <linux-fsdevel+bounces-35916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F5D9D9A28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5786A282B26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F01D63E9;
	Tue, 26 Nov 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyZF2pJ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="01JgX4tr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HyZF2pJ8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="01JgX4tr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F851D63C9;
	Tue, 26 Nov 2024 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633578; cv=none; b=Xh3K8rCxP15uCo3HxKbvvGedFKC+GRuiEaWDPeTfnIVelo/Wbo/CQK96v/FF3j16nK55LrZ0p5WVJFU+ODQa1muti+YsM6UGPIZzYvWzbFSRVA12Fe651vIkHi68JkO0NDvugdfU7eJz575ER/rL/lkfZThAfHPqEolGgd0c3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633578; c=relaxed/simple;
	bh=d4EdCWOYSpcJGfSHosjzNM2Bb9Ur0uc2muOhBPpTyZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3ysdZmLDZE+5pcCF9ilNi7GBCcHTyHVQIfpkiKyv7O/SyWSyTPSe+VvflzfJ38fxCgEDJz2sVy86c9A/V2QkniWHEvPat350OqWy5DPbXxVNCsd+IEH8aJykjn/mKToFSEz5lFyeUlkuYVxdH5+e5DlIle8ud+vmYXWNb0fGk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyZF2pJ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=01JgX4tr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HyZF2pJ8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=01JgX4tr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A87621170;
	Tue, 26 Nov 2024 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WC+RV5XxHoTaNHixzjyTfL7/6NAbrCIXiFN286SXR5M=;
	b=HyZF2pJ8z82qfdrkKDwXLNMWnqxueAVQbN8agZantfhA78SUv72ZNTn8y/Ss9fhovfBj4a
	eTK2702HWqxh/jOxFkvfe4K0GIV6blWS1b8XddOu9d4r57qdIdoj9S6GxSg6EHDKguRuRf
	Btuw7uu+qOr5CR9G0Cb9vlrTrhb5MvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WC+RV5XxHoTaNHixzjyTfL7/6NAbrCIXiFN286SXR5M=;
	b=01JgX4tr2v4KbW7ChJ+qGclNIpDdMoZR5SigniMqlbmQk9xSgaThONJVwO+jN1o0La6pbr
	HwgbPcE9qpWN5dAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WC+RV5XxHoTaNHixzjyTfL7/6NAbrCIXiFN286SXR5M=;
	b=HyZF2pJ8z82qfdrkKDwXLNMWnqxueAVQbN8agZantfhA78SUv72ZNTn8y/Ss9fhovfBj4a
	eTK2702HWqxh/jOxFkvfe4K0GIV6blWS1b8XddOu9d4r57qdIdoj9S6GxSg6EHDKguRuRf
	Btuw7uu+qOr5CR9G0Cb9vlrTrhb5MvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WC+RV5XxHoTaNHixzjyTfL7/6NAbrCIXiFN286SXR5M=;
	b=01JgX4tr2v4KbW7ChJ+qGclNIpDdMoZR5SigniMqlbmQk9xSgaThONJVwO+jN1o0La6pbr
	HwgbPcE9qpWN5dAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 180FA13890;
	Tue, 26 Nov 2024 15:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WtZ0BebjRWeaBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 15:06:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B01C0A08CA; Tue, 26 Nov 2024 16:06:13 +0100 (CET)
Date: Tue, 26 Nov 2024 16:06:13 +0100
From: Jan Kara <jack@suse.cz>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Philippe Troin <phil@fifi.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, NeilBrown <neilb@suse.de>
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <20241126150613.a4b57y2qmolapsuc@quack3>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126103719.bvd2umwarh26pmb3@quack3>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 26-11-24 11:37:19, Jan Kara wrote:
> On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
> > On 2024-11-26 02:48, Philippe Troin wrote:
> > > On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> > > > When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> > > > we got terrible performance (lots of nfs: server x.x.x.x not
> > > > responding).
> > > > What triggered this problem was virtual machines with NFS-mounted
> > > > qcow2 disks
> > > > that often triggered large readaheads that generates long streaks of
> > > > disk I/O
> > > > of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> > > > area of the
> > > > machine.
> > > > 
> > > > A git bisect gave the following suspect:
> > > > 
> > > > git bisect start
> > > 
> > > 8< snip >8
> > > 
> > > > # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> > > > readahead: properly shorten readahead when falling back to
> > > > do_page_cache_ra()
> > > 
> > > Thank you for taking the time to bisect, this issue has been bugging
> > > me, but it's been non-deterministic, and hence hard to bisect.
> > > 
> > > I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> > > slightly different setups:
> > > 
> > > (1) On machines mounting NFSv3 shared drives. The symptom here is a
> > > "nfs server XXX not responding, still trying" that never recovers
> > > (while the server remains pingable and other NFSv3 volumes from the
> > > hanging server can be mounted).
> > > 
> > > (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> > > several minutes) on random I/O. These stalls eventually recover.
> > > 
> > > I've built a 6.11.10 kernel with
> > > 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> > > normal (no more NFS hangs, no more VM stalls).
> > > 
> > Some printk debugging, seems to indicate that the problem
> > is that the entity 'ra->size - (index - start)' goes
> > negative, which then gets cast to a very large unsigned
> > 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
> > bug is still eludes me, though.
> 
> Thanks for the report, bisection and debugging! I think I see what's going
> on. read_pages() can go and reduce ra->size when ->readahead() callback
> failed to read all folios prepared for reading and apparently that's what
> happens with NFS and what can lead to negative argument to
> do_page_cache_ra(). Now at this point I'm of the opinion that updating
> ra->size / ra->async_size does more harm than good (because those values
> show *desired* readahead to happen, not exact number of pages read),
> furthermore it is problematic because ra can be shared by multiple
> processes and so updates are inherently racy. If we indeed need to store
> number of read pages, we could do it through ractl which is call-site local
> and used for communication between readahead generic functions and callers.
> But I have to do some more history digging and code reading to understand
> what is using this logic in read_pages().

Hum, checking the history the update of ra->size has been added by Neil two
years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
process all pages"). Neil, the changelog seems as there was some real
motivation behind updating of ra->size in read_pages(). What was it? Now I
somewhat disagree with reducing ra->size in read_pages() because it seems
like a wrong place to do that and if we do need something like that,
readahead window sizing logic should rather be changed to take that into
account? But it all depends on what was the real rationale behind reducing
ra->size in read_pages()...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

