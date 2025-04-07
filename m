Return-Path: <linux-fsdevel+bounces-45885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCEA7E186
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937ED3BD39A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653611D6DB1;
	Mon,  7 Apr 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToxMgYRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2E1C7004;
	Mon,  7 Apr 2025 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035510; cv=none; b=UeDf0ItB7GSouh5yFbp2VW948/RYIYV8CdJ/iVVAVaEA0/h5B6woLYzP6Qn4iEDSJvaYqHPhiraNCM8Qqs831xSg2oIQCWfP250+zuOGMrlm6C7NVqEKud/3IUeC0TvlZbqdgar0BQKxHl7vG8r3Y05j8J8FLJRGG+oFT/uTd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035510; c=relaxed/simple;
	bh=59sWNcTjgZdwjwObEU6f0L2NNY5UxzU/QXOnj0Z2qaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COuHOAJHoNrZwHv5OkPk1XE1SRhrkqJnXSi+qiG7xdMvFfU0bMoPsg2Od+BuFR1eCsbV0XUdAvV7j1LbqO+kR7dIlxQ1KcRjwY5EeDwI6fDjNKkeMkb0kP9F0awz5CNGa8VjJS6956WBXiZlixxw87rkvhvgMAOf7WVUHg4uTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToxMgYRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3992DC4CEDD;
	Mon,  7 Apr 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035510;
	bh=59sWNcTjgZdwjwObEU6f0L2NNY5UxzU/QXOnj0Z2qaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ToxMgYRMd4oK97VdZjMKEwFHs2sSdp/0eJy4nn2ksysNsV1n6ocpPhZd2PgRJtCba
	 am1cz7Re8WuNmVG/kXtqGMw453mflNErnstrx/NNQ2ra1hBhv4X5AiMsZe+TeytDik
	 ZCO1Mo62093bnMp+HzDG6XvlH+b5tlhsT6eWD6iMICLi/jE+twLfymQy5vSjFw61f5
	 qD9LyVYwgBMoqVCEFl6NpnCYnaJ/RHHE/V2tbklsiBcmVw3oBP1oyhriG0HB3gQv0K
	 3TQkhygT5u/taU7TIxHJkhpk+1qyyW94TZbRH0IcLJtzuIr+xI4zIFBFUAPrZPBiYi
	 cQ1Wi+Ho1BA3w==
Date: Mon, 7 Apr 2025 16:18:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5/9] anon_inode: raise SB_I_NODEV and SB_I_NOEXEC
Message-ID: <20250407-bushaltestelle-haltlos-49982774e760@brauner>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-5-53a44c20d44e@kernel.org>
 <znozbhmeuz5sp24ksqsm5vsd4xlbuqfkbf5qwo6djle57gsnks@z274bu2spsxz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <znozbhmeuz5sp24ksqsm5vsd4xlbuqfkbf5qwo6djle57gsnks@z274bu2spsxz>

On Mon, Apr 07, 2025 at 04:07:47PM +0200, Jan Kara wrote:
> On Mon 07-04-25 11:54:19, Christian Brauner wrote:
> > It isn't possible to execute anoymous inodes because they cannot be
> 				^^ anonymous
> 
> > opened in any way after they have been created. This includes execution:
> > 
> > execveat(fd_anon_inode, "", NULL, NULL, AT_EMPTY_PATH)
> > 
> > Anonymous inodes have inode->f_op set to no_open_fops which sets
> > no_open() which returns ENXIO. That means any call to do_dentry_open()
> > which is the endpoint of the do_open_execat() will fail. There's no
> > chance to execute an anonymous inode. Unless a given subsystem overrides
> > it ofc.
> > 
> > Howerver, we should still harden this and raise SB_I_NODEV and
>   ^^^ However
> 
> > SB_I_NOEXEC on the superblock itself so that no one gets any creative
> > ideas.
> 
> ;)

I've told our new AI overloards to sprinkle-in some typos so no one
realizes I've been mostly replaced by a bot.

Or I'm just generally tired so I fat-finger a lot more than usual. :D

> 
> Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza
> 
> > 
> > Cc: <stable@vger.kernel.org> # all LTS kernels
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/anon_inodes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
> > index cb51a90bece0..e51e7d88980a 100644
> > --- a/fs/anon_inodes.c
> > +++ b/fs/anon_inodes.c
> > @@ -86,6 +86,8 @@ static int anon_inodefs_init_fs_context(struct fs_context *fc)
> >  	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
> >  	if (!ctx)
> >  		return -ENOMEM;
> > +	fc->s_iflags |= SB_I_NOEXEC;
> > +	fc->s_iflags |= SB_I_NODEV;
> >  	ctx->dops = &anon_inodefs_dentry_operations;
> >  	return 0;
> >  }
> > 
> > -- 
> > 2.47.2
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

