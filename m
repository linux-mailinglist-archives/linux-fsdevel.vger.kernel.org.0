Return-Path: <linux-fsdevel+bounces-59314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFEB37310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4E87C762B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8426D4EB;
	Tue, 26 Aug 2025 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3oaZziH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911531A554
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236715; cv=none; b=IuKAvZPLFLdwjxlR3Ze9bJWzSic5AKrhS2MPv2VKWUeZbVQzm7yQgm8HjrewTQc6Uuo5oaeJRZEVpbFLzcUfFgf1DLBhemdmuvtUq6O+sM0X8rOSuNqhH6n3mmMepDV50oRpcgLv52uK0KokAJ1i9YO/Vs1pP32xUYgTUq3U5Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236715; c=relaxed/simple;
	bh=3qQL6geLhwed5SWtK+Mxsup3JlZ1KJwy6IamdT5lQTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr27+oA1pZjgjyXlU7X1bxG/4QwlvDE8WUZlZg07aLDt3u5M7TmxCimfUZixoyTakVdPGvBGn47KWHXToHqnf3kh4nwn4HAxSj7C19l4CZ7TX9IWoDQGeHV1D3a9jYkabIOvWF4ZhEVT2WepfEF2qmeKQCOJ01TWXFNYg8TU9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3oaZziH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79171C4CEF1;
	Tue, 26 Aug 2025 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756236715;
	bh=3qQL6geLhwed5SWtK+Mxsup3JlZ1KJwy6IamdT5lQTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3oaZziHB49gFoCBxl5ImEwHJi/8B95jqb/CDuZUyBzE4fdK0b+C2TSC5bPhephvH
	 7G7dnG3EuXkoG5EAnPPlh3ZXqZczps1uFCKTZ2PtixxTQbnm0VV9SbhxklZetcLWk2
	 rJRHXNhMWx0U9Db+4FaW1pO/R9ZxRdjv1cgwf2/zhwTbdn6LkNJ+QcpLpkaAXMj3jD
	 Y1aib3n3z9H36owsR2wj67lNPnMIJxUhXsldzDVCDzS755MwF1QbUTxbx+0snWB0gS
	 kkuQ5hGoPL/0/UkMYivuw4Engm85cWad+U5MLZieaJzGgIA1kT0HFDSPU4zudg00ET
	 mHxr2/3k1hGdQ==
Date: Tue, 26 Aug 2025 12:31:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: synarete@gmail.com, Bernd Schubert <bernd@bsbernd.com>,
	miklos@szeredi.hu, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] fuse: enable FUSE_SYNCFS for all servers
Message-ID: <20250826193154.GE19809@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708692.15537.2841393845132319610.stgit@frogsfrogsfrogs>
 <CAJnrk1Z3JpJM-hO7Hw9_KUN26PHLnoYdiw1BBNMTfwPGJKFiZQ@mail.gmail.com>
 <20250821222811.GQ7981@frogsfrogsfrogs>
 <851a012d-3f92-4f9d-8fa5-a57ce0ff9acc@bsbernd.com>
 <CAL_uBtfa-+oG9zd-eJmTAyfL-usqe+AXv15usunYdL1LvCHeoA@mail.gmail.com>
 <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aoZbfRGk+uhWsgq2q+0+GR2kCLpvNJUwV4YRj4089SEg@mail.gmail.com>

On Fri, Aug 22, 2025 at 10:21:44AM -0700, Joanne Koong wrote:
> On Fri, Aug 22, 2025 at 4:32 AM Shachar Sharon <synarete@gmail.com> wrote:
> >
> > To the best of my understanding, there are two code paths which may
> > yield FUSE_SYNCFS: one from user-space syscall syncfs(2) and the other
> > from within the kernel itself. Unfortunately, there is no way to
> > distinguish between the two at sb->s_op->sync_fs level, and the DoS
> > argument refers to the second (kernel) case. If we could somehow
> > propagate this info all the way down to the fuse layer then I see no
> > reason for preventing (non-privileged) user-space programs from
> > calling syncfs(2) over FUSE mounted file-systems.
> 
> I interpreted the DoS comment as referring to the scenario where a
> userspace program calls generic sync()  and if an untrusted fuse
> server deliberately hangs on servicing that request then it'll hang
> sync forever. I think if this only affected the syncfs() syscall then
> it wouldn't be a problem since the caller is directly invoking it on a
> fuse fd, but if it affects generic sync() that seems like a big issue
> to me. Or at least that's my understanding of the code with
> ksys_sync() -> iterate_supers(sync_fs_one_sb, &wait).

<shrug> I think you can already DoS sync() (and by extension any other
place in the kernel where we try to flush out all filesystems in one go)
by dropping a FUSE_SETATTR call on the floor, because that's how we
flush dirty inodes to disk?  Or by doing the same for an FUSE_FSYNC
call?

--D

> Thanks,
> Joanne
> >
> >
> > Please correct me if I am wrong with my analysis.
> >
> >
> > - Shachar.
> >
> > On Fri, Aug 22, 2025 at 1:57 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> > >
> > >
> > >
> > > On 8/22/25 00:28, Darrick J. Wong wrote:
> > > > On Thu, Aug 21, 2025 at 03:18:11PM -0700, Joanne Koong wrote:
> > > >> On Wed, Aug 20, 2025 at 5:52 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >>>
> > > >>> From: Darrick J. Wong <djwong@kernel.org>
> > > >>>
> > > >>> Turn on syncfs for all fuse servers so that the ones in the know can
> > > >>> flush cached intermediate data and logs to disk.
> > > >>>
> > > >>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > >>> ---
> > > >>>  fs/fuse/inode.c |    1 +
> > > >>>  1 file changed, 1 insertion(+)
> > > >>>
> > > >>>
> > > >>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > >>> index 463879830ecf34..b05510799f93e1 100644
> > > >>> --- a/fs/fuse/inode.c
> > > >>> +++ b/fs/fuse/inode.c
> > > >>> @@ -1814,6 +1814,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> > > >>>                 if (!sb_set_blocksize(sb, ctx->blksize))
> > > >>>                         goto err;
> > > >>>  #endif
> > > >>> +               fc->sync_fs = 1;
> > > >>
> > > >> AFAICT, this enables syncfs only for fuseblk servers. Is this what you
> > > >> intended?
> > > >
> > > > I meant to say for all fuseblk servers, but TBH I can't see why you
> > > > wouldn't want to enable it for non-fuseblk servers too?
> > > >
> > > > (Maybe I was being overly cautious ;))
> > >
> > > Just checked, the initial commit message has
> > >
> > >
> > > <quote 2d82ab251ef0f6e7716279b04e9b5a01a86ca530>
> > > Note that such an operation allows the file server to DoS sync(). Since a
> > > typical FUSE file server is an untrusted piece of software running in
> > > userspace, this is disabled by default. Only enable it with virtiofs for
> > > now since virtiofsd is supposedly trusted by the guest kernel.
> > > </quote>
> > >
> > >
> > > With that we could at least enable for all privileged servers? And for
> > > non-privileged this could be an async?
> > >
> > >
> > > Thanks,
> > > Bernd
> > >
> > >
> > >
> 

