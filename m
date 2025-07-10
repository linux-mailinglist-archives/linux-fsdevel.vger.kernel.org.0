Return-Path: <linux-fsdevel+bounces-54473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E103FB00081
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6A93B913A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4AA2D8DBC;
	Thu, 10 Jul 2025 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="simNRL2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF779944F
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146845; cv=none; b=IuYa3amOcnBWkcwrkCJmQH5lrllWSHvb/RxPInFlamUZFmq/h3jKZUckP22P9jfcFjKGefv1YM2kW4UIDJqHRKW8RJCnQox0CNzOiWWUVHwCyU/SJhlYPcqlNfmp6zN/wRljrZZ/3Ryj+sXtwkKXwpRGAm03fqeJ6/eJo3ray+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146845; c=relaxed/simple;
	bh=6Q2ZmcMX2iTgIdVdHEK0bNX/WlRY310ceVqTIzLOXGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RM2DJCJz6ol+J7eIlWc2J3LNjA2kmk9As9AbvmPeKrqqk+JK/VePwChX8K16m20LfGKlic1op4s+a9P7NZGMb2vo74Z8xCO/QBY9tJVIXi4Ws0V2V4U05QcBqs6c8kMv6DH86/qA2SMsk/N1XHjqQHDbwe1eMYXdAoDYaKWQKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=simNRL2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07158C4CEE3;
	Thu, 10 Jul 2025 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752146845;
	bh=6Q2ZmcMX2iTgIdVdHEK0bNX/WlRY310ceVqTIzLOXGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=simNRL2aN4rjYy5FWeIz6XJpoVzgaHDtGakH8pj5O3gpn61yF2rw8txkrPY0TOiyx
	 jaL3VyTjmeyLy1OQKfWWtpGhQkdfh8MhZqzybYon5MlQdE/69d2nGFJRp2vewx3snD
	 oKJqmoZQDVqXxBYmW7PV8GzcWiRHKNcXBPHLb7rEjSLTYP/C/zR3gstiJgOieAF82p
	 W3p0GeSNJd9D05gcbXg6AY7S0bcEZaMnvVYGmGEymLsHTKstWBFMeCcKMU7akf2C+Y
	 ufcu6Yy1vnqUTg2dqYQxF4OOGdCbAWjJ6/7614hR5ET62sgQWpKvdo5/sRP7KIFBEh
	 Ged3tQalOjiTA==
Date: Thu, 10 Jul 2025 13:27:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, leo.lilong@huaweicloud.com, 
	miklos@szeredi.hu, leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org, 
	yi.zhang@huawei.com, yangerkun@huawei.com, lonuxli.64@gmail.com
Subject: Re: [PATCH] fuse: show io_uring mount option in /proc/mounts
Message-ID: <20250710-prompt-erging-5771fc6c61bf@brauner>
References: <20250709020229.1425257-1-leo.lilong@huaweicloud.com>
 <b33a4493-1b77-42b5-aac9-b0af0833a131@bsbernd.com>
 <CAJnrk1a+a37BEj_RUASLok7dHyu4nBt7x=bFWA7M3XpCqtUxNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1a+a37BEj_RUASLok7dHyu4nBt7x=bFWA7M3XpCqtUxNA@mail.gmail.com>

On Wed, Jul 09, 2025 at 10:55:31AM -0700, Joanne Koong wrote:
> On Wed, Jul 9, 2025 at 4:24 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> >
> > On 7/9/25 04:02, leo.lilong@huaweicloud.com wrote:
> > > From: Long Li <leo.lilong@huawei.com>
> > >
> > > When mounting a FUSE filesystem with io_uring option and using io_uring
> > > for communication, this option was not shown in /proc/mounts or mount
> > > command output. This made it difficult for users to verify whether
> > > io_uring was being used for communication in their FUSE mounts.
> > >
> > > Add io_uring to the list of mount options displayed in fuse_show_options()
> > > when the fuse-over-io_uring feature is enabled and being used.
> > >
> > > Signed-off-by: Long Li <leo.lilong@huawei.com>
> > > ---
> > >  fs/fuse/inode.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index ecb869e895ab..a6a8cd84fdde 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -913,6 +913,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
> > >                       seq_puts(m, ",default_permissions");
> > >               if (fc->allow_other)
> > >                       seq_puts(m, ",allow_other");
> > > +             if (fc->io_uring)
> > > +                     seq_puts(m, ",io_uring");
> > >               if (fc->max_read != ~0)
> > >                       seq_printf(m, ",max_read=%u", fc->max_read);
> > >               if (sb->s_bdev && sb->s_blocksize != FUSE_DEFAULT_BLKSIZE)
> >
> > I agree with you that is impossible to see, but issue is that io_uring
> > is not a mount option. Maybe we should add a sysfs file?
> >
> 
> Libfuse knows so what about just relaying that information from libfuse?

Yeah, if it's not a mount option we shouldn't actually display it in
mountinfo...

