Return-Path: <linux-fsdevel+bounces-35889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682F9D95AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 11:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB448285041
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA81CD210;
	Tue, 26 Nov 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfiP8Yxh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+XCtD2e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rfiP8Yxh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+XCtD2e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642B1B87E1;
	Tue, 26 Nov 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617449; cv=none; b=Vv4Ru3EdGgxfP3PEBE7Dw3bZ9H1y3iZPxLOPDnI9osJUwXf5eqM+LPxJIvaYOTrrUfXxm3tR2pDUbi6gibma8/V6ZGGglmRRpZnrpK/S7AXZWxNWZcYK6j2xzXrFz4HltIx3pZrqaC5XkVlu6HL4me2MoLwx3Y8iHQrTJyxExV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617449; c=relaxed/simple;
	bh=9ThnDP1v7dyLT6f20id/Djbtem9d/7q/+o/s3bWhPfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r96VPjVxFD8flllMTyKV6OC0gmuYjfT8JyKKgprmwXlEPQ1nQG+zyEDwJaPcmJBHQpukPjoRigf1gm+AwcDo0V5kF3iibGnfpx5cd8Sx2+qLS2Ltw1EgtE2wt+MW9ejBSoj7nKmGXUq4qpFd/zC2dz2VzPeVpeYqCMfRyRl5ewA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfiP8Yxh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+XCtD2e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rfiP8Yxh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+XCtD2e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B1F21F45E;
	Tue, 26 Nov 2024 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732617439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdQC6j8zPVleA81o2pdIMBkbwZFyTWol19ahvIa+B20=;
	b=rfiP8YxhK+69HUCUmk7T3SqRPQ8XO+Awe2UviO4G7H4atvkCI2CfZOUJNteet+tz4Iq19W
	JanDkwWnP3Ky7LyyQFLznK8e53/tBOK3zlOdmQpWjS+R2USwOfPw+Br1iTV8Q96YRgegrM
	2RJYYENsME9kIY+u6W5+TqXdg6Zv5ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732617439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdQC6j8zPVleA81o2pdIMBkbwZFyTWol19ahvIa+B20=;
	b=G+XCtD2ebUyOCoetbKyPdjBM0EOVsy/mHtPI2+zaEOjGcok9uSyzqQaO8m3XR8EyNmKekD
	T+b/7U6yQlaimDCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rfiP8Yxh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=G+XCtD2e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732617439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdQC6j8zPVleA81o2pdIMBkbwZFyTWol19ahvIa+B20=;
	b=rfiP8YxhK+69HUCUmk7T3SqRPQ8XO+Awe2UviO4G7H4atvkCI2CfZOUJNteet+tz4Iq19W
	JanDkwWnP3Ky7LyyQFLznK8e53/tBOK3zlOdmQpWjS+R2USwOfPw+Br1iTV8Q96YRgegrM
	2RJYYENsME9kIY+u6W5+TqXdg6Zv5ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732617439;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdQC6j8zPVleA81o2pdIMBkbwZFyTWol19ahvIa+B20=;
	b=G+XCtD2ebUyOCoetbKyPdjBM0EOVsy/mHtPI2+zaEOjGcok9uSyzqQaO8m3XR8EyNmKekD
	T+b/7U6yQlaimDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73C96139AA;
	Tue, 26 Nov 2024 10:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbs9HN+kRWcMKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 10:37:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24CA6A08CA; Tue, 26 Nov 2024 11:37:19 +0100 (CET)
Date: Tue, 26 Nov 2024 11:37:19 +0100
From: Jan Kara <jack@suse.cz>
To: Anders Blomdell <anders.blomdell@gmail.com>
Cc: Philippe Troin <phil@fifi.org>, Jan Kara <jack@suse.cz>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: Regression in NFS probably due to very large amounts of readahead
Message-ID: <20241126103719.bvd2umwarh26pmb3@quack3>
References: <49648605-d800-4859-be49-624bbe60519d@gmail.com>
 <3b1d4265b384424688711a9259f98dec44c77848.camel@fifi.org>
 <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bb8bfe1-5de6-4b5d-af90-ab24848c772b@gmail.com>
X-Rspamd-Queue-Id: 8B1F21F45E
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 26-11-24 09:01:35, Anders Blomdell wrote:
> On 2024-11-26 02:48, Philippe Troin wrote:
> > On Sat, 2024-11-23 at 23:32 +0100, Anders Blomdell wrote:
> > > When we (re)started one of our servers with 6.11.3-200.fc40.x86_64,
> > > we got terrible performance (lots of nfs: server x.x.x.x not
> > > responding).
> > > What triggered this problem was virtual machines with NFS-mounted
> > > qcow2 disks
> > > that often triggered large readaheads that generates long streaks of
> > > disk I/O
> > > of 150-600 MB/s (4 ordinary HDD's) that filled up the buffer/cache
> > > area of the
> > > machine.
> > > 
> > > A git bisect gave the following suspect:
> > > 
> > > git bisect start
> > 
> > 8< snip >8
> > 
> > > # first bad commit: [7c877586da3178974a8a94577b6045a48377ff25]
> > > readahead: properly shorten readahead when falling back to
> > > do_page_cache_ra()
> > 
> > Thank you for taking the time to bisect, this issue has been bugging
> > me, but it's been non-deterministic, and hence hard to bisect.
> > 
> > I'm seeing the same problem on 6.11.10 (and earlier 6.11.x kernels) in
> > slightly different setups:
> > 
> > (1) On machines mounting NFSv3 shared drives. The symptom here is a
> > "nfs server XXX not responding, still trying" that never recovers
> > (while the server remains pingable and other NFSv3 volumes from the
> > hanging server can be mounted).
> > 
> > (2) On VMs running over qemu-kvm, I see very long stalls (can be up to
> > several minutes) on random I/O. These stalls eventually recover.
> > 
> > I've built a 6.11.10 kernel with
> > 7c877586da3178974a8a94577b6045a48377ff25 reverted and I'm back to
> > normal (no more NFS hangs, no more VM stalls).
> > 
> Some printk debugging, seems to indicate that the problem
> is that the entity 'ra->size - (index - start)' goes
> negative, which then gets cast to a very large unsigned
> 'nr_to_read' when calling 'do_page_cache_ra'. Where the true
> bug is still eludes me, though.

Thanks for the report, bisection and debugging! I think I see what's going
on. read_pages() can go and reduce ra->size when ->readahead() callback
failed to read all folios prepared for reading and apparently that's what
happens with NFS and what can lead to negative argument to
do_page_cache_ra(). Now at this point I'm of the opinion that updating
ra->size / ra->async_size does more harm than good (because those values
show *desired* readahead to happen, not exact number of pages read),
furthermore it is problematic because ra can be shared by multiple
processes and so updates are inherently racy. If we indeed need to store
number of read pages, we could do it through ractl which is call-site local
and used for communication between readahead generic functions and callers.
But I have to do some more history digging and code reading to understand
what is using this logic in read_pages().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

