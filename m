Return-Path: <linux-fsdevel+bounces-1798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB57DEF46
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 10:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E55B1C20E6C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 09:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3B8125C3;
	Thu,  2 Nov 2023 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qutiQvaG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UQreemB+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EA6FA5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 09:55:56 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F47813E;
	Thu,  2 Nov 2023 02:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D752F21878;
	Thu,  2 Nov 2023 09:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698918950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5pRlUTGfYRuroKFEMEmJ57hIq3rhMsknidCix2gKl0=;
	b=qutiQvaGsOQab0v2di7F+0A+4UnE3dlg1s6Dc8JWqH82ej9F/Hscve/EuDIIa9YGfCeh5D
	g0zoi/ItgT+6HSryTvGRO4kSMrPZnTGeu6CX4/NAzyUULW0QjxoyATW2kYdWghdm546x0q
	E8dx9htPDLSjzAXbZjaWb6ICvTui8BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698918950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5pRlUTGfYRuroKFEMEmJ57hIq3rhMsknidCix2gKl0=;
	b=UQreemB+E0uLx6UT+sZKc/0hHY0LMusZa0aq/V9EuW9VGPv+CBxgXLrad9ABB5R6QZEBhv
	l5G+GZ++ekve+qBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE12E138EC;
	Thu,  2 Nov 2023 09:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id A59fLiZyQ2UoeAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 02 Nov 2023 09:55:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36F76A06E3; Thu,  2 Nov 2023 10:55:50 +0100 (CET)
Date: Thu, 2 Nov 2023 10:55:50 +0100
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 1/7] bcachefs: Convert to bdev_open_by_path()
Message-ID: <20231102095550.5hofpgzwbzx4ewqx@quack3>
References: <20231101173542.23597-1-jack@suse.cz>
 <20231101174325.10596-1-jack@suse.cz>
 <ZUKggpzckTAKkyMl@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUKggpzckTAKkyMl@bfoster>

Hi Brian,

On Wed 01-11-23 15:01:22, Brian Foster wrote:
> On Wed, Nov 01, 2023 at 06:43:06PM +0100, Jan Kara wrote:
> > Convert bcachefs to use bdev_open_by_path() and pass the handle around.
> > 
> > CC: Kent Overstreet <kent.overstreet@linux.dev>
> > CC: Brian Foster <bfoster@redhat.com>
> > CC: linux-bcachefs@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/bcachefs/super-io.c    | 19 ++++++++++---------
> >  fs/bcachefs/super_types.h |  1 +
> >  2 files changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
> > index 332d41e1c0a3..01a32c41a540 100644
> > --- a/fs/bcachefs/super-io.c
> > +++ b/fs/bcachefs/super-io.c
> ...
> > @@ -685,21 +685,22 @@ int bch2_read_super(const char *path, struct bch_opts *opts,
> >  	if (!opt_get(*opts, nochanges))
> >  		sb->mode |= BLK_OPEN_WRITE;
> >  
> > -	sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > -	if (IS_ERR(sb->bdev) &&
> > -	    PTR_ERR(sb->bdev) == -EACCES &&
> > +	sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > +	if (IS_ERR(sb->bdev_handle) &&
> > +	    PTR_ERR(sb->bdev_handle) == -EACCES &&
> >  	    opt_get(*opts, read_only)) {
> >  		sb->mode &= ~BLK_OPEN_WRITE;
> >  
> > -		sb->bdev = blkdev_get_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > -		if (!IS_ERR(sb->bdev))
> > +		sb->bdev_handle = bdev_open_by_path(path, sb->mode, sb->holder, &bch2_sb_handle_bdev_ops);
> > +		if (!IS_ERR(sb->bdev_handle))
> >  			opt_set(*opts, nochanges, true);
> >  	}
> >  
> > -	if (IS_ERR(sb->bdev)) {
> > -		ret = PTR_ERR(sb->bdev);
> > +	if (IS_ERR(sb->bdev_handle)) {
> > +		ret = PTR_ERR(sb->bdev_handle);
> >  		goto out;
> >  	}
> > +	sb->bdev = sb->bdev_handle->bdev;
> >  
> >  	ret = bch2_sb_realloc(sb, 0);
> >  	if (ret) {
> 
> This all seems reasonable to me, but should bcachefs use sb_open_mode()
> somewhere in here to involve use of the restrict writes flag in the
> first place? It looks like bcachefs sort of open codes bits of
> mount_bdev() so it isn't clear the flag would be used anywhere...

Yes, so AFAICS bcachefs will not get the write restriction from the changes
in the generic code. Using sb_open_mode() in bcachefs would fix that but
given the 'noexcl' and 'nochanges' mount options it will not be completely
seamless anyway. I guess once the generic changes are in, bcachefs can
decide how exactly it wants to set the BLK_OPEN_RESTRICT_WRITES flag. Or if
you already have an opinion, we can just add the patch to this series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

