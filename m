Return-Path: <linux-fsdevel+bounces-35971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7FF9DA686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 12:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AE281D1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FA1E2616;
	Wed, 27 Nov 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p8bQSUHT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6QzlK35";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p8bQSUHT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A6QzlK35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B461E0DED;
	Wed, 27 Nov 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705623; cv=none; b=N80dn4JbPjXFzTAmwFDGYGi67DZKM5sTz2bQ1nJ8StG6T+x+d6jAM8y2TC65dWKCnHlLuX9fK2SNIw5FjCKHz4MfvtpMFn6CfBEHJgrF0lwEiaHoQMOVzvVfSzn27Qw5o5vjRee78Quevo55TSopnFue2tHtCQiHLdOQF4+sK7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705623; c=relaxed/simple;
	bh=nsTnpCU5lza/RRF6svKMS0tHdUP03m9UTECrIonLoPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSkeU9OfMUt3pGjQy3Tu9wNAZq8zQqacOkjNJeYS25AM+ugPxK8dfygqkYdk/SBs4BZ0M2UxYTo9yScN7wR8DFOccfD3W87c5+7JCS6AqBiSV3AOUjToPv+O7uDdx5fESCk+HNOkhpQRyDj6MEd3mK/WGV1RrjhLedKLnMUxJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p8bQSUHT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6QzlK35; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p8bQSUHT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A6QzlK35; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DCAC1F786;
	Wed, 27 Nov 2024 11:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732705614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve5bO8Xk7Mdrs4etTh9swfc19BKNL9zCNHLtpjsUTFc=;
	b=p8bQSUHTiWn0ntOSRJlScU0Y19NQdFqyVvSnTjYkPUFbSbXa84sBQr1A++WXGv8NqwuNv7
	Uv8Tu4bAhSvjqJS1aPqaa9tjJdYTBrh05zizZNuVVnuFwm0khP5TBFOTxpmDqrWT1RyyQ6
	7AkavAsc5Zz5U4vPxB5TjZWUiuGyPr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732705614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve5bO8Xk7Mdrs4etTh9swfc19BKNL9zCNHLtpjsUTFc=;
	b=A6QzlK35pDqkrXs+xGX1Dgc+aZox97lM3/2YXSKsXJeYg5wX9oGp90z8E3LoX/LazwHrS8
	WLYc/Yx/4DFZsYDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732705614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve5bO8Xk7Mdrs4etTh9swfc19BKNL9zCNHLtpjsUTFc=;
	b=p8bQSUHTiWn0ntOSRJlScU0Y19NQdFqyVvSnTjYkPUFbSbXa84sBQr1A++WXGv8NqwuNv7
	Uv8Tu4bAhSvjqJS1aPqaa9tjJdYTBrh05zizZNuVVnuFwm0khP5TBFOTxpmDqrWT1RyyQ6
	7AkavAsc5Zz5U4vPxB5TjZWUiuGyPr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732705614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ve5bO8Xk7Mdrs4etTh9swfc19BKNL9zCNHLtpjsUTFc=;
	b=A6QzlK35pDqkrXs+xGX1Dgc+aZox97lM3/2YXSKsXJeYg5wX9oGp90z8E3LoX/LazwHrS8
	WLYc/Yx/4DFZsYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5686213941;
	Wed, 27 Nov 2024 11:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3cYFU79RmfSWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Nov 2024 11:06:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EBEF6A08D6; Wed, 27 Nov 2024 12:06:49 +0100 (CET)
Date: Wed, 27 Nov 2024 12:06:49 +0100
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neilb@suse.de>
Cc: Jan Kara <jack@suse.cz>, Anders Blomdell <anders.blomdell@gmail.com>,
	Philippe Troin <phil@fifi.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	netfs@lists.linux.dev
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <20241127110649.yg2k4s3fzohb2pgg@quack3>
References: <>
 <20241126150613.a4b57y2qmolapsuc@quack3>
 <173269663098.1734440.13407516531783940860@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173269663098.1734440.13407516531783940860@noble.neil.brown.name>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,fifi.org,infradead.org,linux-foundation.org,vger.kernel.org,kvack.org,redhat.com,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

Added David Howells to CC since this seems to be mostly netfs related.

On Wed 27-11-24 19:37:10, NeilBrown wrote:
> On Wed, 27 Nov 2024, Jan Kara wrote:
> > On Tue 26-11-24 11:37:19, Jan Kara wrote:
> > > On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
> > > > On 2024-11-26 02:48, Philippe Troin wrote:
> > > > > On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> > > > > > When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> > > > > > we got terrible performance (lots of nfs: server x.x.x.x not
> > > > > > responding).
> > > > > > What triggered this problem was virtual machines with NFS-mounted
> > > > > > qcow2 disks
> > > > > > that often triggered large readaheads that generates long streaks of
> > > > > > disk I/O
> > > > > > of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> > > > > > area of the
> > > > > > machine.
> > > > > > 
> > > > > > A git bisect gave the following suspect:
> > > > > > 
> > > > > > git bisect start
> > > > > 
> > > > > 8< snip >8
> > > > > 
> > > > > > # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> > > > > > readahead: properly shorten readahead when falling back to
> > > > > > do_page_cache_ra()
> > > > > 
> > > > > Thank you for taking the time to bisect, this issue has been bugging
> > > > > me, but it's been non-deterministic, and hence hard to bisect.
> > > > > 
> > > > > I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> > > > > slightly different setups:
> > > > > 
> > > > > (1) On machines mounting NFSv3 shared drives. The symptom here is a
> > > > > "nfs server XXX not responding, still trying" that never recovers
> > > > > (while the server remains pingable and other NFSv3 volumes from the
> > > > > hanging server can be mounted).
> > > > > 
> > > > > (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> > > > > several minutes) on random I/O. These stalls eventually recover.
> > > > > 
> > > > > I've built a 6.11.10 kernel with
> > > > > 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> > > > > normal (no more NFS hangs, no more VM stalls).
> > > > > 
> > > > Some printk debugging, seems to indicate that the problem
> > > > is that the entity 'ra->size - (index - start)' goes
> > > > negative, which then gets cast to a very large unsigned
> > > > 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
> > > > bug is still eludes me, though.
> > > 
> > > Thanks for the report, bisection and debugging! I think I see what's going
> > > on. read_pages() can go and reduce ra->size when ->readahead() callback
> > > failed to read all folios prepared for reading and apparently that's what
> > > happens with NFS and what can lead to negative argument to
> > > do_page_cache_ra(). Now at this point I'm of the opinion that updating
> > > ra->size / ra->async_size does more harm than good (because those values
> > > show *desired* readahead to happen, not exact number of pages read),
> > > furthermore it is problematic because ra can be shared by multiple
> > > processes and so updates are inherently racy. If we indeed need to store
> > > number of read pages, we could do it through ractl which is call-site local
> > > and used for communication between readahead generic functions and callers.
> > > But I have to do some more history digging and code reading to understand
> > > what is using this logic in read_pages().
> > 
> > Hum, checking the history the update of ra->size has been added by Neil two
> > years ago in 9fd472af84ab ("mm: improve cleanup when ->readpages doesn't
> > process all pages"). Neil, the changelog seems as there was some real
> > motivation behind updating of ra->size in read_pages(). What was it? Now I
> > somewhat disagree with reducing ra->size in read_pages() because it seems
> > like a wrong place to do that and if we do need something like that,
> > readahead window sizing logic should rather be changed to take that into
> > account? But it all depends on what was the real rationale behind reducing
> > ra->size in read_pages()...
> > 
> 
> I cannot tell you much more than what the commit itself says.
> If there are any pages still in the rac, then we didn't try read-ahead
> and shouldn't pretend that we did. Else the numbers will be wrong.
> 
> I think the important part of the patch was the
> delete_from_page_cache().
> Leaving pages in the page cache which we didn't try to read will cause
> a future read-ahead to skip those pages and they can only be read
> synchronously.

Yes, I agree with the delete_from_page_cache() part (although it seems as a
bit of an band aid but I guess KISS principle wins here).

> But maybe you are right that ra, being shared, shouldn't be modified
> like this.

OK, I was wondering whether this ra update isn't some way how NFS tries to
stear optimal readahead size for it. It would be weird but possible. If
this was mostly a theoretical concert, then I'd be for dropping the ra
update in read_pages(). I did a small excursion to nfs_readahead() and
that function itself seems to read all the pages unless there's some error
like ENOMEM. But before doing this nfs_readahead() does:

        ret = nfs_netfs_readahead(ractl);
        if (!ret)
                goto out;                    

And that is more interesting because if the inode has netfs cache, we will
do netfs_readahead(ractl) and return 0. So whatever netfs_readahead() reads
is the final result. And that function actually seems to read only
PAGEVEC_SIZE folios (because that's what fits in its request structure) and
aborts. 

Now unless you have fscache in tmpfs or you have really large folios in the
page cache, reading PAGEVEC_SIZE folios can be too small to get decent
performance. But that's somewhat besides the point of this thread. The fact
is that netfs can indeed read very few folios from the readahead it was
asked to do. The question is how the generic readahead code should handle
such case. Either we could say that such behavior is not really supported
(besides error recovery where performance is not an issue) and fix netfs to
try harder to submit all the folios generic code asked it to read. Or we
can say generic readahead code needs to accommodate such behavior in a
performant way but then the readahead limitation should be communicated in
advance so that we avoid creating tons of folios only to discard them a
while later. I guess the decision depends on how practical is the "try to
read all folios" solution for netfs... What do you think guys?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

