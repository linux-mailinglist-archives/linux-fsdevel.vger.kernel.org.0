Return-Path: <linux-fsdevel+bounces-35914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C839D9A0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 16:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F97716681A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5231D61B7;
	Tue, 26 Nov 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TChG3feU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Sqpc3IL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TChG3feU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Sqpc3IL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A84282F4;
	Tue, 26 Nov 2024 15:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633207; cv=none; b=S/iekmv8tW65qtZR1ogoTZmOpyiNWMJRULojznUaSsizshBq1zbOYVlofOvQ0NmPy0BQrWIFYtVNUWF4kDKS6r5hNaBhoc+etwNKV1W7F89mrO+TSM9H2Xxxc0MN8Rt2HolrFXBuxkAnOE7HZwobPCXxIXWcVJbYX/HUOYRCEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633207; c=relaxed/simple;
	bh=DoiGgy2GMpffChB6xoMC8Rr15TKbfFL7c12ogdkKVuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTTaxvl90C0a9aMsy1PW8W0SknMAKUlhpQU39ZtFRX8YpAKzNrBqXfs2DzqMQeVSDbvc1eEEIo6zGWyA+517CRCckDh1lpwD8w3FV3jd2ymcXynlTFT+TgaSRWnAtCkmfpUBSh6DTELcW8HYwEsIAL38iCfFEy+Te3wCzBtjWWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TChG3feU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Sqpc3IL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TChG3feU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Sqpc3IL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42BE81F74C;
	Tue, 26 Nov 2024 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu/1ga8UiXrMPcTRTq0z7k/C/XRWuMzHOuhMSugtAM=;
	b=TChG3feUYThOQm4JDiUtpNkqC1yV8f6e0mhls/rC9zPb/HGJ5DQEtG8OYc74ZqXbezMlf2
	eWy3ml/5OJq/HiwkNRr1L0aOMvH3zkfBdKsdlTiY6WwwhKPkBYRkHNrqIVNOreGUDr/sXT
	aojfr1VwGKh0ncbqwcsu2Citly6/A34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu/1ga8UiXrMPcTRTq0z7k/C/XRWuMzHOuhMSugtAM=;
	b=3Sqpc3IL5ebxP+hr9y+HcYlkeTFg2RP7wnyJLvAgJTPCTx4Ms8DDJvhqk2C/wB++RuiisF
	sYVGnnm+Rw2KvOBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TChG3feU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3Sqpc3IL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732633203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu/1ga8UiXrMPcTRTq0z7k/C/XRWuMzHOuhMSugtAM=;
	b=TChG3feUYThOQm4JDiUtpNkqC1yV8f6e0mhls/rC9zPb/HGJ5DQEtG8OYc74ZqXbezMlf2
	eWy3ml/5OJq/HiwkNRr1L0aOMvH3zkfBdKsdlTiY6WwwhKPkBYRkHNrqIVNOreGUDr/sXT
	aojfr1VwGKh0ncbqwcsu2Citly6/A34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732633203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jHu/1ga8UiXrMPcTRTq0z7k/C/XRWuMzHOuhMSugtAM=;
	b=3Sqpc3IL5ebxP+hr9y+HcYlkeTFg2RP7wnyJLvAgJTPCTx4Ms8DDJvhqk2C/wB++RuiisF
	sYVGnnm+Rw2KvOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F5813890;
	Tue, 26 Nov 2024 15:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ymBnDXPiRWesAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 15:00:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE02BA08CA; Tue, 26 Nov 2024 16:00:02 +0100 (CET)
Date: Tue, 26 Nov 2024 16:00:02 +0100
From: Jan Kara <jack@suse.cz>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Philippe Troin <phil@fifi.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <20241126150002.o6fbe4yei4fwsehz@quack3>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
 <20241126103719.bvd2umwarh26pmb3@quack3>
 <6777d050-99a2-4f3c-b398-4b4271c427d5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6777d050-99a2-4f3c-b398-4b4271c427d5@gmail.com>
X-Rspamd-Queue-Id: 42BE81F74C
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 26-11-24 13:49:09, Anders Blomdell wrote:
> 
> 
> On 2024-11-26 11:37, Jan Kara wrote:
> > On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
> > > On 2024-11-26 02:48, Philippe Troin wrote:
> > > > On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> > > > > When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> > > > > we got terrible performance (lots of nfs: server x.x.x.x not
> > > > > responding).
> > > > > What triggered this problem was virtual machines with NFS-mounted
> > > > > qcow2 disks
> > > > > that often triggered large readaheads that generates long streaks of
> > > > > disk I/O
> > > > > of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> > > > > area of the
> > > > > machine.
> > > > > 
> > > > > A git bisect gave the following suspect:
> > > > > 
> > > > > git bisect start
> > > > 
> > > > 8< snip >8
> > > > 
> > > > > # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> > > > > readahead: properly shorten readahead when falling back to
> > > > > do_page_cache_ra()
> > > > 
> > > > Thank you for taking the time to bisect, this issue has been bugging
> > > > me, but it's been non-deterministic, and hence hard to bisect.
> > > > 
> > > > I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> > > > slightly different setups:
> > > > 
> > > > (1) On machines mounting NFSv3 shared drives. The symptom here is a
> > > > "nfs server XXX not responding, still trying" that never recovers
> > > > (while the server remains pingable and other NFSv3 volumes from the
> > > > hanging server can be mounted).
> > > > 
> > > > (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> > > > several minutes) on random I/O. These stalls eventually recover.
> > > > 
> > > > I've built a 6.11.10 kernel with
> > > > 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> > > > normal (no more NFS hangs, no more VM stalls).
> > > > 
> > > Some printk debugging, seems to indicate that the problem
> > > is that the entity 'ra->size - (index - start)' goes
> > > negative, which then gets cast to a very large unsigned
> > > 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
> > > bug is still eludes me, though.
> > 
> > Thanks for the report, bisection and debugging! I think I see what's going
> > on. read_pages() can go and reduce ra->size when ->readahead() callback
> > failed to read all folios prepared for reading and apparently that's what
> > happens with NFS and what can lead to negative argument to
> > do_page_cache_ra(). Now at this point I'm of the opinion that updating
> > ra->size / ra->async_size does more harm than good (because those values
> > show *desired* readahead to happen, not exact number of pages read),
> > furthermore it is problematic because ra can be shared by multiple
> > processes and so updates are inherently racy. If we indeed need to store
> > number of read pages, we could do it through ractl which is call-site local
> > and used for communication between readahead generic functions and callers.
> > But I have to do some more history digging and code reading to understand
> > what is using this logic in read_pages().
> > 
> > 								Honza
> Good, look forward to a quick revert, and don't forget to CC GKH, so I
> get kernels recent  that work ASAP.

Well, Greg won't merge any patch until it gets upstream. I've sent the
revert now to Andrew (MM maintainer), once it lands in Linus' tree, Greg
will take it since stable tree is CCed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

