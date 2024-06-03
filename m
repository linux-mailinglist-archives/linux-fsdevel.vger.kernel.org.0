Return-Path: <linux-fsdevel+bounces-20800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F25A18D7FFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EC81C23722
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72782D6C;
	Mon,  3 Jun 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fVrusnO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DvKDZNoN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fVrusnO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DvKDZNoN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82974107A8;
	Mon,  3 Jun 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410632; cv=none; b=OoDbtXPbxRgIHPk2sT07czLtfKBw23EhcVKRhHHE0ahpYgJRJbx3jPc5LG28jbCm6iu/K5esMAvwgC/qvDS6UEot12koXdSD20hsFuGfXF6R5zEqE6GBnaK3edzOjx7fdQFo+I5m8MJ9gTwGwqDSkO/e8bsKjc16Upd8Rc+ZChY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410632; c=relaxed/simple;
	bh=8qWOa1I4dRA0wwSvjQqmRvvLXU43Y0o1KGD3d+SozDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY69fwR7SBiK0w4QhLKhS3EZgFa0FSvF89IFHRP2u9l/MA/AyfR3HIqDhsCHTa4s6eGzjbMtUqRf4cLSjjR8sMmx7MAG55uDrTDZTamCa8bzM1n10tIb2yD1tMAshT0G7N3dArrVxTieEHf2gM9BT1IgyxqW5NfP5KhQ2AIxAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fVrusnO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DvKDZNoN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fVrusnO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DvKDZNoN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DFA520034;
	Mon,  3 Jun 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717410628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeD93ByCizJOPJifc4qjUJkUjOsezUwSyhkRRSdDXTI=;
	b=fVrusnO7cteskuNXJi2yj0cacsltGC1p0Pp8PEfe/nvMDgCPAdOtEjO7ILMdvWGdn9KWKI
	tuxOHuXQAvpbNQuSS2klTjPrvnVjHN3RmBBkH0HnpJEaKJz2qbKSX+E9B4+udGCtR9dvrF
	PHw7TuLDKFGLCwZyRifY5MBYFKs9/l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717410628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeD93ByCizJOPJifc4qjUJkUjOsezUwSyhkRRSdDXTI=;
	b=DvKDZNoNqfMSQ+/I5NWHq6R5gElN2NQoOmzE91Z70XJZgtUCLvQcP/s6MyRaeyPhuI/4De
	0o0hKauf7I/iPHAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717410628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeD93ByCizJOPJifc4qjUJkUjOsezUwSyhkRRSdDXTI=;
	b=fVrusnO7cteskuNXJi2yj0cacsltGC1p0Pp8PEfe/nvMDgCPAdOtEjO7ILMdvWGdn9KWKI
	tuxOHuXQAvpbNQuSS2klTjPrvnVjHN3RmBBkH0HnpJEaKJz2qbKSX+E9B4+udGCtR9dvrF
	PHw7TuLDKFGLCwZyRifY5MBYFKs9/l8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717410628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeD93ByCizJOPJifc4qjUJkUjOsezUwSyhkRRSdDXTI=;
	b=DvKDZNoNqfMSQ+/I5NWHq6R5gElN2NQoOmzE91Z70XJZgtUCLvQcP/s6MyRaeyPhuI/4De
	0o0hKauf7I/iPHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E41413A93;
	Mon,  3 Jun 2024 10:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id POOkGkSbXWZeFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 10:30:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F12E9A086D; Mon,  3 Jun 2024 12:30:23 +0200 (CEST)
Date: Mon, 3 Jun 2024 12:30:23 +0200
From: Jan Kara <jack@suse.cz>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240603103023.dh2npfl76wbmyvsx@quack3>
References: <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <CAJfpegvznUGTYxxTzB5QQHWtNrCfSkWvGscacfZ67Gn+6XoD8w@mail.gmail.com>
 <20240529.013815-fishy.value.nervous.brutes-FzobWXrzoo2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529.013815-fishy.value.nervous.brutes-FzobWXrzoo2@cyphar.com>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,infradead.org,kernel.org,suse.cz,zeniv.linux.org.uk,oracle.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email]

On Sat 01-06-24 01:12:31, Aleksa Sarai wrote:
> On 2024-05-28, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Tue, 28 May 2024 at 15:24, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Tue, May 28, 2024 at 02:04:16PM +0200, Christian Brauner wrote:
> > > > Can you please explain how opening an fd based on a handle returned from
> > > > name_to_handle_at() and not using a mount file descriptor for
> > > > open_by_handle_at() would work?
> > >
> > > Same as NFS file handles:
> > >
> > > name_to_handle_at returns a handle that includes a file system
> > > identifier.
> > >
> > > open_by_handle_at looks up the superblock based on that identifier.
> > 
> > The open file needs a specific mount, holding the superblock is not sufficient.
> 
> Not to mention that providing a mount fd is what allows for extensions
> like Christian's proposed method of allowing restricted forms of
> open_by_handle_at() to be used by unprivileged users.
> 
> If file handles really are going to end up being the "correct" mechanism
> of referencing inodes by userspace, then future API designs really need
> to stop assuming that the user is capable(CAP_DAC_READ_SEARCH). Being
> able to open any file in any superblock the kernel knows about
> (presumably using a kernel-internal mount if we are getting rid of the
> mount fd) is also capable(CAP_SYS_ADMIN) territory.

Well, but this is already handled - name_to_handle_at() with AT_HANDLE_FID
is completely unpriviledged operation. Unpriviledged userspace can use
fhandle for comparisons with other file handles but that's all it is good
for (similarly as inode number you get from statx(2) but does not have the
problem with inode number uniqueness on btrfs, bcachefs, etc.). I don't
expect unpriviledged userspace to be able to more with the fhandle it got.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

