Return-Path: <linux-fsdevel+bounces-59743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603AAB3DB92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABED3A6BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0692EE610;
	Mon,  1 Sep 2025 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2B3IJXuJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wj5HzEii";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0X/wqaGh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i/SKOqLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272FF2EDD4D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 07:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756713327; cv=none; b=kMkiH0GSa7HeobfL1oi2M6LWH8jBDqNo0fX+0FyFtOtcJ0y4X9H7thyPJzfwKZ8FnbzSkghpvAIRFLoIxbiR8eKihxQcZaMDkNi56ecfsrwjNHfjPvf5w2NXJgfLaHZb8nNTfHScbImEWhHGfgjLnhfmqU0+4AA0qYzrTBhZdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756713327; c=relaxed/simple;
	bh=+RwnFKQ/JrHTr2cxoixiySuD7hOGWpfkqGI2TMYj/Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgeMGCgqmeQOePlyEpDQT9LiUMVRutxtt6m5eI212zQQPJoOFOAr+8l8B/NXmklwLMV+ETWNIzzGRZcqWqpqAP/hqX1Lw+p/I8dcw/GY4oV4lHzoX79dCw4iMcp23TfV8M3WsgAkBTtftj17s9v5n+Z0gGCh4JykUsUh6aYT8ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2B3IJXuJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wj5HzEii; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0X/wqaGh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i/SKOqLZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E30E71F38C;
	Mon,  1 Sep 2025 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756713322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABUKxJp+T86WUFFcprlxI51x/AMcLR4PDlibw8xA7eQ=;
	b=2B3IJXuJgm5hOwJ7KunnKUQSib6IoJB8hQHh9Ex7sJBm1wYtGID7+HGaycJXDWwj3IR/kL
	iOX1zCxsCGLab7fSA2TCi31LdvYgEYEuOztRiQRn8P3fjiZAABS5HZwiTHlymeOZ3YmnfM
	/OSnOeMbv/bCjFvOcB5XdDEpc7kiST4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756713322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABUKxJp+T86WUFFcprlxI51x/AMcLR4PDlibw8xA7eQ=;
	b=wj5HzEiiOAevOulX+cypKt9urEvwH6D1wtVdj5xbGMHHsOebhh43SjeGG/0rWt+r0n27WX
	qfZmC0Wp9rFC04DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="0X/wqaGh";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="i/SKOqLZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756713320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABUKxJp+T86WUFFcprlxI51x/AMcLR4PDlibw8xA7eQ=;
	b=0X/wqaGhXQhaijZzH9Pq3750OKimXjVVk5NlCXJtY3zWcYhepsVMDzn0R1Bm6k0VVed2/R
	I2WakCP9T+fwiBTTe7O8K7faNxrg+fjTTlRJmAKqUufZ/BO6N2OOQHbWxYUksBITApC6jy
	7dGBBYWhmUa+ao9po4aZqbJdt6sE1wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756713320;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ABUKxJp+T86WUFFcprlxI51x/AMcLR4PDlibw8xA7eQ=;
	b=i/SKOqLZFaLLAX0XrDMhyD+kjmgrhL+6+91dNaEDIhFu9hzUq9o3AgxuizKHtDk/jk7YMv
	bqaIUBM4X2Zdt6Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEFFD136ED;
	Mon,  1 Sep 2025 07:55:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCCDMmhRtWixTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 07:55:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7378BA099B; Mon,  1 Sep 2025 09:55:20 +0200 (CEST)
Date: Mon, 1 Sep 2025 09:55:20 +0200
From: Jan Kara <jack@suse.cz>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	axboe@kernel.dk, dw@davidwei.uk, brauner@kernel.org, hch@lst.de, 
	martin.petersen@oracle.com, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, Jan Kara <jack@suse.com>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCHv3 0/8] direct-io: even more flexible io vectors
Message-ID: <pcmvk3tb3cre3dao2suskdxjrkk6q5z2olkgbkyqoaxujelokg@34hc5pudk3lt>
References: <20250819164922.640964-1-kbusch@meta.com>
 <87a53ra3mb.fsf@gmail.com>
 <g35u5ugmyldqao7evqfeb3hfcbn3xddvpssawttqzljpigy7u4@k3hehh3grecq>
 <aKx485EMthHfBWef@kbusch-mbp>
 <87cy8ir835.fsf@gmail.com>
 <ua7ib34kk5s6yfthqkgy3m2pnbk33a34g7prezmwl7hfwv6lwq@fljhjaogd6gq>
 <aK8tuTnuHbD8VOyo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK8tuTnuHbD8VOyo@kernel.org>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E30E71F38C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,meta.com,vger.kernel.org,kernel.dk,davidwei.uk,lst.de,oracle.com,zeniv.linux.org.uk,suse.com,redhat.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -2.51

Hi Mike!

On Wed 27-08-25 12:09:29, Mike Snitzer wrote:
> On Wed, Aug 27, 2025 at 05:20:53PM +0200, Jan Kara wrote:
> > On Tue 26-08-25 10:29:58, Ritesh Harjani wrote:
> > > Keith Busch <kbusch@kernel.org> writes:
> > > 
> > > > On Mon, Aug 25, 2025 at 02:07:15PM +0200, Jan Kara wrote:
> > > >> On Fri 22-08-25 18:57:08, Ritesh Harjani wrote:
> > > >> > Keith Busch <kbusch@meta.com> writes:
> > > >> > >
> > > >> > >   - EXT4 falls back to buffered io for writes but not for reads.
> > > >> > 
> > > >> > ++linux-ext4 to get any historical context behind why the difference of
> > > >> > behaviour in reads v/s writes for EXT4 DIO. 
> > > >> 
> > > >> Hum, how did you test? Because in the basic testing I did (with vanilla
> > > >> kernel) I get EINVAL when doing unaligned DIO write in ext4... We should be
> > > >> falling back to buffered IO only if the underlying file itself does not
> > > >> support any kind of direct IO.
> > > >
> > > > Simple test case (dio-offset-test.c) below.
> > > >
> > > > I also ran this on vanilla kernel and got these results:
> > > >
> > > >   # mkfs.ext4 /dev/vda
> > > >   # mount /dev/vda /mnt/ext4/
> > > >   # make dio-offset-test
> > > >   # ./dio-offset-test /mnt/ext4/foobar
> > > >   write: Success
> > > >   read: Invalid argument
> > > >
> > > > I tracked the "write: Success" down to ext4's handling for the "special"
> > > > -ENOTBLK error after ext4_want_directio_fallback() returns "true".
> > > >
> > > 
> > > Right. Ext4 has fallback only for dio writes but not for DIO reads... 
> > > 
> > > buffered
> > > static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
> > > {
> > > 	/* must be a directio to fall back to buffered */
> > > 	if ((flags & (IOMAP_WRITE | IOMAP_DIRECT)) !=
> > > 		    (IOMAP_WRITE | IOMAP_DIRECT))
> > > 		return false;
> > > 
> > >     ...
> > > }
> > > 
> > > So basically the path is ext4_file_[read|write]_iter() -> iomap_dio_rw
> > >     -> iomap_dio_bio_iter() -> return -EINVAL. i.e. from...
> > > 
> > > 
> > > 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
> > > 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > > 		return -EINVAL;
> > > 
> > > EXT4 then fallsback to buffered-io only for writes, but not for reads. 
> > 
> > Right. And the fallback for writes was actually inadvertedly "added" by
> > commit bc264fea0f6f "iomap: support incremental iomap_iter advances". That
> > changed the error handling logic. Previously if iomap_dio_bio_iter()
> > returned EINVAL, it got propagated to userspace regardless of what
> > ->iomap_end() returned. After this commit if ->iomap_end() returns error
> > (which is ENOTBLK in ext4 case), it gets propagated to userspace instead of
> > the error returned by iomap_dio_bio_iter().
> > 
> > Now both the old and new behavior make some sense so I won't argue that the
> > new iomap_iter() behavior is wrong. But I think we should change ext4 back
> > to the old behavior of failing unaligned dio writes instead of them falling
> > back to buffered IO. I think something like the attached patch should do
> > the trick - it makes unaligned dio writes fail again while writes to holes
> > of indirect-block mapped files still correctly fall back to buffered IO.
> > Once fstests run completes, I'll do a proper submission...
> > 
> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> 
> > From ce6da00a09647a03013c3f420c2e7ef7489c3de8 Mon Sep 17 00:00:00 2001
> > From: Jan Kara <jack@suse.cz>
> > Date: Wed, 27 Aug 2025 14:55:19 +0200
> > Subject: [PATCH] ext4: Fail unaligned direct IO write with EINVAL
> > 
> > Commit bc264fea0f6f ("iomap: support incremental iomap_iter advances")
> > changed the error handling logic in iomap_iter(). Previously any error
> > from iomap_dio_bio_iter() got propagated to userspace, after this commit
> > if ->iomap_end returns error, it gets propagated to userspace instead of
> > an error from iomap_dio_bio_iter(). This results in unaligned writes to
> > ext4 to silently fallback to buffered IO instead of erroring out.
> > 
> > Now returning ENOTBLK for DIO writes from ext4_iomap_end() seems
> > unnecessary these days. It is enough to return ENOTBLK from
> > ext4_iomap_begin() when we don't support DIO write for that particular
> > file offset (due to hole).
> 
> Any particular reason for ext4 still returning -ENOTBLK for unaligned
> DIO?

No, that is actually the bug I'm speaking about - ext4 should be returning
EINVAL for unaligned DIO as other filesystems do but after recent iomap
changes it started to return ENOTBLK.

> In my experience XFS returns -EINVAL when failing unaligned DIO (but
> maybe there are edge cases where that isn't always the case?)
> 
> Would be nice to have consistency across filesystems for what is
> returned when failing unaligned DIO.

Agreed although there are various corner cases like files which never
support direct IO - e.g. with data journalling - and thus fallback to
buffered IO happens before any alignment checks. 

> The iomap code returns -ENOTBLK as "the magic error code to fall back
> to buffered I/O".  But that seems only for page cache invalidation
> failure, _not_ for unaligned DIO.
> 
> (Anyway, __iomap_dio_rw's WRITE handling can return -ENOTBLK if page
> cache invalidation fails during DIO write. So it seems higher-level
> code, like I've added to NFS/NFSD to check for unaligned DIO failure,
> should check for both -EINVAL and -ENOTBLK).

I think the idea here is that if page cache invalidation fails we want to
fallback to buffered IO so that we don't cause cache coherency issues and
that's why ENOTBLK is returned.

> ps. ENOTBLK is actually much less easily confused with other random
> uses of EINVAL (EINVAL use is generally way too overloaded, rendering
> it a pretty unhelpful error).  But switching XFS to use ENOTBLK
> instead of EINVAL seems like disruptive interface breakage (I suppose
> same could be said for ext4 if it were to now return EINVAL for
> unaligned DIO, but ext4 flip-flopping on how it handles unaligned DIO
> prompted me to ask these questions now)

Definitely. In this particular case EINVAL for unaligned DIO is there for
ages and there likely is some userspace program somewhere that depends on
it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

