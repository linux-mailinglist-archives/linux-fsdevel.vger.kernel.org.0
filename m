Return-Path: <linux-fsdevel+bounces-28708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A0796D340
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD42B258D6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F5198E90;
	Thu,  5 Sep 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkqZ6EJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8070197A97
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528493; cv=none; b=KH8VoFlsyR1tsZHZ6CwkQfXbj9su3zoDokAR1e+AapyTctX9okvUFcfnrAfEd26DkBfz6z3ocAKC9j+dFDXBpn4dDu5hAgvQpd0EjQnp2I/7SFStv1JMfzfOoCcIKDQwYYHn8jCoimtIYN726oVa+j9flAnLpwHhATt5jOlnqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528493; c=relaxed/simple;
	bh=1gPn3sdl4SM/IP0I1ObZv0pGWv2/cG5Ax1wAcxwqN8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZtaReAU1rD3z6NWxplkfOqloKeFWB1UQ+eVLH9JxoWAPwLk2qywUaoiUsZ65day0MKytGPKHMPuKkEPph4z7vCRNjFvYRYmPQ4N5YpbtUcjo8tPbWGjez8UQjEQF9MCoEFV08iWhflK4XK+BK8Lt6PGbtUDJy8Dlhkvov+8vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkqZ6EJ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFD6C4CEC3;
	Thu,  5 Sep 2024 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725528493;
	bh=1gPn3sdl4SM/IP0I1ObZv0pGWv2/cG5Ax1wAcxwqN8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkqZ6EJ2XzVRVH48+s7ia5PmvPgLjQQo2kyavPX7yxHs45Z7qkg+Z8NVNIxNFaTa3
	 /ayhsP+Tw70aH/Nz/JUsdrGxoMOcL0JBeaOKH0ghdZf5qBffSqt1uhaWV+UOPscqBQ
	 664QNsJ0FZT1VohYCi7EpmZ/hyFsomV6iSsMbp9BDsFkc2bMu0v99ZzOLueEnc0Kn/
	 CC/FInwt2p3SftZ11vB8y0/dYmb4rbTnL/yuB56C371pcySVW+mMZSaSgoqWFx+QeM
	 vueEf2moVTzW8bTlLaZGwur2jPNgFxA4W7HZpXDzhUCKP3EsFK5PlP52Df237ClDl5
	 YW9puCb4IN/ag==
Date: Thu, 5 Sep 2024 11:28:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 14/20] proc: store cookie in private data
Message-ID: <20240905-entgiften-kuhglocken-9cfa51c8c23d@brauner>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-14-6d3e4816aa7b@kernel.org>
 <20240903-zierpflanzen-rohkost-aabf97c6a049@brauner>
 <20240903133548.yr4py524sozrkmq4@quack3>
 <20240903-biografie-antik-5d931826566d@brauner>
 <20240904141607.747jkil4poyynpxz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240904141607.747jkil4poyynpxz@quack3>

On Wed, Sep 04, 2024 at 04:16:07PM GMT, Jan Kara wrote:
> On Tue 03-09-24 16:00:56, Christian Brauner wrote:
> > On Tue, Sep 03, 2024 at 03:35:48PM GMT, Jan Kara wrote:
> > > On Tue 03-09-24 13:34:30, Christian Brauner wrote:
> > > > On Fri, Aug 30, 2024 at 03:04:55PM GMT, Christian Brauner wrote:
> > > > > Store the cookie to detect concurrent seeks on directories in
> > > > > file->private_data.
> > > > > 
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >  fs/proc/base.c | 18 ++++++++++++------
> > > > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > > > > index 72a1acd03675..8a8aab6b9801 100644
> > > > > --- a/fs/proc/base.c
> > > > > +++ b/fs/proc/base.c
> > > > > @@ -3870,12 +3870,12 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> > > > >  	if (!dir_emit_dots(file, ctx))
> > > > >  		return 0;
> > > > >  
> > > > > -	/* f_version caches the tgid value that the last readdir call couldn't
> > > > > -	 * return. lseek aka telldir automagically resets f_version to 0.
> > > > > +	/* We cache the tgid value that the last readdir call couldn't
> > > > > +	 * return and lseek resets it to 0.
> > > > >  	 */
> > > > >  	ns = proc_pid_ns(inode->i_sb);
> > > > > -	tid = (int)file->f_version;
> > > > > -	file->f_version = 0;
> > > > > +	tid = (int)(intptr_t)file->private_data;
> > > > > +	file->private_data = NULL;
> > > > >  	for (task = first_tid(proc_pid(inode), tid, ctx->pos - 2, ns);
> > > > >  	     task;
> > > > >  	     task = next_tid(task), ctx->pos++) {
> > > > > @@ -3890,7 +3890,7 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
> > > > >  				proc_task_instantiate, task, NULL)) {
> > > > >  			/* returning this tgid failed, save it as the first
> > > > >  			 * pid for the next readir call */
> > > > > -			file->f_version = (u64)tid;
> > > > > +			file->private_data = (void *)(intptr_t)tid;
> > > > >  			put_task_struct(task);
> > > > >  			break;
> > > > >  		}
> > > > > @@ -3915,6 +3915,12 @@ static int proc_task_getattr(struct mnt_idmap *idmap,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> > > > > +{
> > > > > +	return generic_llseek_cookie(file, offset, whence,
> > > > > +				     (u64 *)(uintptr_t)&file->private_data);
> > > > 
> > > > Btw, this is fixed in-tree (I did send out an unfixed version):
> > > > 
> > > > static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> > > > {
> > > > 	u64 cookie = 1;
> > > > 	loff_t off;
> > > > 
> > > > 	off = generic_llseek_cookie(file, offset, whence, &cookie);
> > > > 	if (!cookie)
> > > > 		file->private_data = NULL; /* serialized by f_pos_lock */
> > > > 	return off;
> > > > }
> > > 
> > > Ah, midair collision :). This looks better just why don't you store the
> > > cookie unconditionally in file->private_data? This way proc_dir_llseek()
> > > makes assumptions about how generic_llseek_cookie() uses the cookie which
> > > unnecessarily spreads internal VFS knowledge into filesystems...
> > 
> > I tried to avoid an allocation for procfs (I assume that's what you're
> > getting at). That's basically all.
> 
> Yes, I just meant I'd find it safer to have:
> 
> static loff_t proc_dir_llseek(struct file *file, loff_t offset, int whence)
> {
> 	u64 cookie = (u64)file->private_data;
> 	loff_t off;
> 
> 	off = generic_llseek_cookie(file, offset, whence, &cookie);
> 	file->private_data = (void *)cookie; /* serialized by f_pos_lock */
> 	return off;
> }
> 
> So that we don't presume what generic_llseek_cookie() can do with the
> cookie.

I switched to that, thanks!

