Return-Path: <linux-fsdevel+bounces-5459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DCB80C68F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A591F21268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C83210E9;
	Mon, 11 Dec 2023 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDCtnqs3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xKBH0Fbz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDCtnqs3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xKBH0Fbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A3791
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 02:30:39 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32D6C22386;
	Mon, 11 Dec 2023 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702290638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8F8Cnn5e8trlXxi50A4a1CipVIOH8lqh/58SLqxhh4=;
	b=rDCtnqs3QSmsS8mq6JBEF5J2rEwClJyOf9IRydGGXneNzQlGVSOLpy3ddzYvDO9LU3oFAs
	wUr/Bl3GUn8JGDngRZP9B9G6bwb7ftnvYv6Nhy8PEqI+YvyKm7zwRc6C5i8QKIvp5EVN2e
	ztWlm4jHSi3RZ7jh0SAHS74/nLauor0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702290638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8F8Cnn5e8trlXxi50A4a1CipVIOH8lqh/58SLqxhh4=;
	b=xKBH0FbztRHTU1pRPuNcO66KW3o9EDtKAX58siq4sdrC1fIQu3bDPjKA3ubOCHjlG0AsNE
	CTIWHfKiHEYHwNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702290638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8F8Cnn5e8trlXxi50A4a1CipVIOH8lqh/58SLqxhh4=;
	b=rDCtnqs3QSmsS8mq6JBEF5J2rEwClJyOf9IRydGGXneNzQlGVSOLpy3ddzYvDO9LU3oFAs
	wUr/Bl3GUn8JGDngRZP9B9G6bwb7ftnvYv6Nhy8PEqI+YvyKm7zwRc6C5i8QKIvp5EVN2e
	ztWlm4jHSi3RZ7jh0SAHS74/nLauor0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702290638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8F8Cnn5e8trlXxi50A4a1CipVIOH8lqh/58SLqxhh4=;
	b=xKBH0FbztRHTU1pRPuNcO66KW3o9EDtKAX58siq4sdrC1fIQu3bDPjKA3ubOCHjlG0AsNE
	CTIWHfKiHEYHwNBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CC5F138FF;
	Mon, 11 Dec 2023 10:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id tFdrBs7kdmVPJQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 11 Dec 2023 10:30:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92B55A07E3; Mon, 11 Dec 2023 11:30:33 +0100 (CET)
Date: Mon, 11 Dec 2023 11:30:33 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] fsnotify: assert that file_start_write() is not held
 in permission hooks
Message-ID: <20231211103033.v52qhc5h7o36fym3@quack3>
References: <20231207123825.4011620-1-amir73il@gmail.com>
 <20231207123825.4011620-4-amir73il@gmail.com>
 <20231208184608.n5fcrkj3peancy3u@quack3>
 <CAOQ4uxgHNBSBenADnMkqZWmb3t2qzfhG-E722-0KJ=Cwzf2UYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgHNBSBenADnMkqZWmb3t2qzfhG-E722-0KJ=Cwzf2UYw@mail.gmail.com>
X-Spam-Level: 
X-Spam-Score: -3.79
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Fri 08-12-23 23:02:35, Amir Goldstein wrote:
> On Fri, Dec 8, 2023 at 8:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 07-12-23 14:38:24, Amir Goldstein wrote:
> > > filesystem may be modified in the context of fanotify permission events
> > > (e.g. by HSM service), so assert that sb freeze protection is not held.
> > >
> > > If the assertion fails, then the following deadlock would be possible:
> > >
> > > CPU0                          CPU1                    CPU2
> > > -------------------------------------------------------------------------
> > > file_start_write()#0
> > > ...
> > >   fsnotify_perm()
> > >     fanotify_get_response() =>        (read event and fill file)
> > >                               ...
> > >                               ...                     freeze_super()
> > >                               ...                       sb_wait_write()
> > >                               ...
> > >                               vfs_write()
> > >                                 file_start_write()#1
> > >
> > > This example demonstrates a use case of an hierarchical storage management
> > > (HSM) service that uses fanotify permission events to fill the content of
> > > a file before access, while a 3rd process starts fsfreeze.
> > >
> > > This creates a circular dependeny:
> > >   file_start_write()#0 => fanotify_get_response =>
> > >     file_start_write()#1 =>
> > >       sb_wait_write() =>
> > >         file_end_write()#0
> > >
> > > Where file_end_write()#0 can never be called and none of the threads can
> > > make progress.
> > >
> > > The assertion is checked for both MAY_READ and MAY_WRITE permission
> > > hooks in preparation for a pre-modify permission event.
> > >
> > > The assertion is not checked for an open permission event, because
> > > do_open() takes mnt_want_write() in O_TRUNC case, meaning that it is not
> > > safe to write to filesystem in the content of an open permission event.
> >                                      ^^^^^ context
> >
> > BTW, isn't this a bit inconvenient? I mean filling file contents on open
> > looks quite natural... Do you plan to fill files only on individual read /
> > write events? I was under the impression simple HSM handlers would be doing
> > it on open.
> >
> 
> Naive HSMs perhaps... The problem with filling on open is that the pattern
> open();fstat();close() is quite common with applications and we found open()
> to be a sub-optimal predicate for near future read().
> 
> Filling the file on first read() access or directory on first
> readdir() access does
> a better job in "swapping in" the correct files.
> A simple HSM would just fill the entire file/dir on the first PRE_ACCESS event.
> that's not any more or less simple than filling it on an OPEN_PERM event.
> 
> Another point that could get lost when reading to above deadlock is that
> filling the file content before open(O_TRUNC) would be really dumb,
> because swap in is costly and you are going to throw away the data.
> If we really wanted to provide HSM with a safe way to fill files on open,
> we would probably need to report the open flags with the open event.
> I actually think that reporting the open flags would be nice even with
> an async open event.

OK, thanks for explanation!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

