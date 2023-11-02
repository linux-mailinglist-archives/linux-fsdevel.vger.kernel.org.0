Return-Path: <linux-fsdevel+bounces-1779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95F47DE9E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 02:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646532819E4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 01:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981110ED;
	Thu,  2 Nov 2023 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hbk10m3j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F910E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 01:09:35 +0000 (UTC)
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A655FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 18:09:30 -0700 (PDT)
Date: Wed, 1 Nov 2023 21:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698887368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NMFkICBeVzAfEfILGEd/mAVjEIeT8Er8QtywEIlpFzc=;
	b=hbk10m3jal5wz6cHkr843gxi21/L5oC86suIGP4xHWk6wjd9Q9BBD/4jqU+F1uKindgEg+
	uUaZteBzjHwS8eHiA6rBfGDhMIU8kxzJJQIrL+igTSo0TA4gFyllRRaaCAdPCq7DFJ3jwd
	qU8G78bpFfLR4fHyM+8+4qzx+0I7JmA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Brian Foster <bfoster@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Kees Cook <keescook@google.com>,
	syzkaller <syzkaller@googlegroups.com>,
	Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH 1/7] bcachefs: Convert to bdev_open_by_path()
Message-ID: <20231102010924.pac3ag4mp6hebsif@moria.home.lan>
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
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 01, 2023 at 03:01:22PM -0400, Brian Foster wrote:
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
> Hi Jan,
> 
> This all seems reasonable to me, but should bcachefs use sb_open_mode()
> somewhere in here to involve use of the restrict writes flag in the
> first place? It looks like bcachefs sort of open codes bits of
> mount_bdev() so it isn't clear the flag would be used anywhere...

Yeah, but that should be a separate patch :)

