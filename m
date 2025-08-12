Return-Path: <linux-fsdevel+bounces-57565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472ACB23902
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2483B7727
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FFD2DE71C;
	Tue, 12 Aug 2025 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jswZA5S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAF21C187;
	Tue, 12 Aug 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026938; cv=none; b=SImpiKgxiP9bIiXETY+YZHW+gm7X+x0AIredANyDX84QQY60fill7p98OA5Kb8GN69xroeCCZY7piZ1q7oX7hWrzYqp057v5hIVPC92WDEtdi2J7lsFBaoQSTp+gY72XW0GhUYKYTINudWfKMPjx/0d0FE51GNXqVNn5S8Bl2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026938; c=relaxed/simple;
	bh=RmKMxHvtucfT9XVmSilfkkitPMsLboGkWPfSdC24ks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv/MPQmD118H5A+2BHI6xSvBRmJkyrn6jf3xCSxOHuCB9jYKODqPENbTDiUFtF5MNNoRuG3DYsO+AY2WbfPsEUeawVxtCZjA7ciTUJvG0eiTgpocuwlSenv/PVUxZD9kR5GmqdGrZLJunwZ8hn82ikwiaTCCX6NvAB3kjrpmjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jswZA5S3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E0AC4CEF0;
	Tue, 12 Aug 2025 19:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755026938;
	bh=RmKMxHvtucfT9XVmSilfkkitPMsLboGkWPfSdC24ks8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jswZA5S3fwK1RCXv7aVUJcFz5bk33POYw2hRgUHf8S44yYJZSFGILwLc4LjuvdnlN
	 uLhluGryK0OlERm99OAQYFlbn+YkxFh1OX1bAvSXGzjqUapOmQUw2x7PzIy26+oqzO
	 CYXaGuEwW85zsiCkRpvlwKKLrSINc9b5lvLXvgJimDsuGV87Inlqmtk/vLsrEyzBBR
	 z88omrrJydEXYCK75f9X0p1eEUdl+D1mc+qQbaBUDYPX0nNMjBiPmdEbIqUOYO/ni6
	 uwddlN/K40fK2kIsVuP9smX+8MXAssCUxwF7Snan0MTHU9mRzvMGP9FuC/HpKOtkdt
	 CYceAnSlvfedA==
Date: Tue, 12 Aug 2025 12:28:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250812192857.GI7942@frogsfrogsfrogs>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
 <87freddbcf.fsf@igalia.com>
 <20250731-diamant-kringeln-7f16e5e96173@brauner>
 <20250731172946.GK2672070@frogsfrogsfrogs>
 <20250804-lesezeichen-kugel-7a8b7053d236@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-lesezeichen-kugel-7a8b7053d236@brauner>

On Mon, Aug 04, 2025 at 10:45:44AM +0200, Christian Brauner wrote:
> On Thu, Jul 31, 2025 at 10:29:46AM -0700, Darrick J. Wong wrote:
> > On Thu, Jul 31, 2025 at 01:33:09PM +0200, Christian Brauner wrote:
> > > On Wed, Jul 30, 2025 at 03:04:00PM +0100, Luis Henriques wrote:
> > > > Hi Darrick,
> > > > 
> > > > On Tue, Jul 29 2025, Darrick J. Wong wrote:
> > > > 
> > > > > On Tue, Jul 29, 2025 at 02:56:02PM +0100, Luis Henriques wrote:
> > > > >> Hi!
> > > > >> 
> > > > >> I know this has been discussed several times in several places, and the
> > > > >> recent(ish) addition of NOTIFY_RESEND is an important step towards being
> > > > >> able to restart a user-space FUSE server.
> > > > >> 
> > > > >> While looking at how to restart a server that uses the libfuse lowlevel
> > > > >> API, I've created an RFC pull request [1] to understand whether adding
> > > > >> support for this operation would be something acceptable in the project.
> > > > >
> > > > > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> > > > > could restart itself.  It's unclear if doing so will actually enable us
> > > > > to clear the condition that caused the failure in the first place, but I
> > > > > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> > > > > aren't totally crazy.
> > > > 
> > > > Maybe my PR lacks a bit of ambition -- it's goal wasn't to have libfuse do
> > > > the restart itself.  Instead, it simply adds some visibility into the
> > > > opaque data structures so that a FUSE server could re-initialise a session
> > > > without having to go through a full remount.
> > > > 
> > > > But sure, there are other things that could be added to the library as
> > > > well.  For example, in my current experiments, the FUSE server needs start
> > > > some sort of "file descriptor server" to keep the fd alive for the
> > > > restart.  This daemon could be optionally provided in libfuse itself,
> > > > which could also be used to store all sorts of blobs needed by the file
> > > > system after recovery is done.
> > > 
> > > Fwiw, for most use-cases you really just want to use systemd's file
> > > descriptor store to persist the /dev/fuse connection:
> > > https://systemd.io/FILE_DESCRIPTOR_STORE/
> > 
> > Very nice!  This is exactly what I was looking for to handle the initial
> > setup, so I'm glad I don't have to go design a protocol around that.
> > 
> > > > 
> > > > >> The PR doesn't do anything sophisticated, it simply hacks into the opaque
> > > > >> libfuse data structures so that a server could set some of the sessions'
> > > > >> fields.
> > > > >> 
> > > > >> So, a FUSE server simply has to save the /dev/fuse file descriptor and
> > > > >> pass it to libfuse while recovering, after a restart or a crash.  The
> > > > >> mentioned NOTIFY_RESEND should be used so that no requests are lost, of
> > > > >> course.  And there are probably other data structures that user-space file
> > > > >> systems will have to keep track as well, so that everything can be
> > > > >> restored.  (The parameters set in the INIT phase, for example.)
> > > > >
> > > > > Yeah, I don't know how that would work in practice.  Would the kernel
> > > > > send back the old connection flags and whatnot via some sort of
> > > > > FUSE_REINIT request, and the fuse server can either decide that it will
> > > > > try to recover, or just bail out?
> > > > 
> > > > That would be an option.  But my current idea would be that the server
> > > > would need to store those somewhere and simply assume they are still OK
> > > 
> > > The fdstore currently allows to associate a name with a file descriptor
> > > in the fdstore. That name would allow you to associate the options with
> > > the fuse connection. However, I would not rule it out that additional
> > > metadata could be attached to file descriptors in the fdstore if that's
> > > something that's needed.
> > 
> > Names are useful, I'd at least want "fusedev", "fsopen", and "device".
> > 
> > If someone passed "journal_dev=/dev/sdaX" to fuse2fs then I'd want it to
> > be able to tell mountfsd "Hey, can you also open /dev/sdaX and put it in
> > the store as 'journal_dev'?" Then it just has to wait until the fd shows
> > up, and it can continue with the mount process.
> > 
> > Though the "device" argument needn't be a path, so to be fully general
> > mountfsd and the fuse server would have to handshake that as well.
> 
> Fwiw, to attach arbitrary metadata to a file descriptor the easiest
> thing to do would be to stash both a (fuse server) file descriptor and
> then also a memfd via memfd_create() that e.g., can contain all the
> server options that you want to store.

<nod> I'll keep that in mind when I get to designing those components.
Thanks for the input!

(I'm still working on stabiling the new fuse4fs server, it's probably
going to be a while yet...)

--D

