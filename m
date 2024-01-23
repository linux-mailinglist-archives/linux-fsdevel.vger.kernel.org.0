Return-Path: <linux-fsdevel+bounces-8603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F278393BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D6A1C2580E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B399460DF8;
	Tue, 23 Jan 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGb543E/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5625FF1F;
	Tue, 23 Jan 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024755; cv=none; b=opLiT7YOXBmYT1cKQmW0NFXQeUZztv4M/Bi/MH8KXZIaTshk3pZMq1+kyUfSu6k6mUwTT10VCQKnJuvJlIDWiwQ6RmBGOAhTB9xxHFF8yvX48PG0LOb7TH/Tn2ZJaphQHs2PmOGMMpOOYreJI1rS05ON8WkfvuqA0fPphSbP0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024755; c=relaxed/simple;
	bh=VTHbfDzFrOVA7xk3KnPk4ZGZEh8IaYb1F6l3jc3cu8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDH4oaYm4UrNpdDQveMk8bN/bgHCG1ibdyqNav0AfRb47Jv4jXCYYvvVFVg6cV8vlc7jprYUB5OXw5ACujXhiTmK7B8nxcpoF7pTrbIQIfK25c67kceSUEMheHIFR/xU5RRM7SE95/mv96ZNSTqxvKAHCyG8J0BpM4pDqq4neFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGb543E/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22544C433C7;
	Tue, 23 Jan 2024 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706024754;
	bh=VTHbfDzFrOVA7xk3KnPk4ZGZEh8IaYb1F6l3jc3cu8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VGb543E/+P6Kxuqmrk/XxB1IjbFgKxaWXDEeLYwEkuz0IJ2H+EA7Qt+BLc82tfDY4
	 8ArXfiV7thf0VLOQvnyadDBXMnEpdNMH/WaM16d6sZjPx3hZ8KRJYBdSX5+Vr8ZQjX
	 mrkVD8/Rr4Yqo4YPyvUobAJ3GuRHLBBAkNMTgE+jsAi8HOon5kIOKBNK2a5j9GNjxH
	 OfQBYLRq5E3LQIH1k2BxJt/+gmDA6iMgpMZIhBQth/KdSPiAMTDYfjKjxCf8657fCN
	 urWzPeZHUHJd7sFEwN0KSc6XOpeZ9j03v/qI42n816qzZxaVC8mKo93wbW0SZd6w9W
	 CsDtf/etp2ZYw==
Date: Tue, 23 Jan 2024 16:45:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Seth Forshee <sforshee@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/9] fuse: basic support for idmapped mounts
Message-ID: <20240123-patentfrei-hausbank-97f018e5c8a4@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240121-pfeffer-erkranken-f32c63956aac@brauner>
 <Za7aaIuQDH92jel+@do-x1extreme>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Za7aaIuQDH92jel+@do-x1extreme>

On Mon, Jan 22, 2024 at 03:13:12PM -0600, Seth Forshee wrote:
> On Sun, Jan 21, 2024 at 06:50:57PM +0100, Christian Brauner wrote:
> > > - We have a small offlist discussion with Christian about adding fs_type->allow_idmap
> > > hook. Christian pointed out that it would be nice to have a superblock flag instead like
> > > SB_I_NOIDMAP and we can set this flag during mount time if we see that the filesystem does not
> > > support idmappings. But, unfortunately, I didn't succeed here because the kernel will
> > > know if the filesystem supports idmapping or not after FUSE_INIT request, but FUSE_INIT request
> > > is being sent at the end of the mounting process, so the mount and superblock will exist and
> > > visible by the userspace in that time. It seems like setting SB_I_NOIDMAP flag, in this
> > > case, is too late as a user may do the trick by creating an idmapped mount while it wasn't
> > > restricted by SB_I_NOIDMAP. Alternatively, we can introduce a "positive" version SB_I_ALLOWIDMAP
> > 
> > I see.
> > 
> > > and a "weak" version of FS_ALLOW_IDMAP like FS_MAY_ALLOW_IDMAP. So if FS_MAY_ALLOW_IDMAP is set,
> > > then SB_I_ALLOWIDMAP has to be set on the superblock to allow the creation of an idmapped mount.
> > > But that's a matter of our discussion.
> > 
> > I dislike making adding a struct super_block method. Because it means that we
> > call into the filesystem from generic mount code and specifically with the
> > namespace semaphore held. If there's ever any network filesystem that e.g.,
> > calls to a hung server it will lockup the whole system. So I'm opposed to
> > calling into the filesystem here at all. It's also ugly because this is really
> > a vfs level change. The only involvement should be whether the filesystem type
> > can actually support this ideally.
> > 
> > I think we should handle this within FUSE. So we allow the creation of idmapped
> > mounts just based on FS_ALLOW_IDMAP. And if the server doesn't support the
> > FUSE_OWNER_UID_GID_EXT then we simply refuse all creation requests originating
> > from an idmapped mount. Either we return EOPNOSUPP or we return EOVERFLOW to
> > indicate that we can't represent the owner correctly because the server is
> > missing the required extension.
> 
> Could fuse just set SB_I_NOIDMAP initially then clear it if the init
> reply indicates idmap support? This is like the "weak" FS_ALLOW_IDMAP
> option without requiring another file_system_type flag.

Would probably works too, yes. I'm just trying to avoid any additional
flag usage. Ideally we'd just do it in FUSE but this way is possibly
also effective. Although it kinda leaks internal FUSE details as in
"SB_I_NOIDMAP" really means "SB_I_INITIALIZED" which I kind of dislike.

