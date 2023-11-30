Return-Path: <linux-fsdevel+bounces-4471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973CB7FF9D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CD51C20C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258C95A0EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGyY+201"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635054663;
	Thu, 30 Nov 2023 17:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7446CC433C8;
	Thu, 30 Nov 2023 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701366481;
	bh=yk0CFq+fj2z6BPkd1TPF0km0dFD73GE0enLmVTNjNRY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kGyY+201BVutbfJu40sh8+8SyxUmnTdpSFnMVW+YeHGKeRcPyQql0YEwsUKINMB+6
	 lHWlv1SDUk0L9P3oxxrIOKJ+p6iiKqPBnWqdAzOBoUw1jaBNlL1/jBOH4nqul+39IQ
	 lFQ7hbiJJqkdR4rKj3bzdX5OoS7ziQNBsugwVm0RjSsmOpTGvpjfqIvue898VeGmye
	 1Wa6BTgi4EoIOng4Tmmpxz5JwrGU7eBusLblUq4h1jBp7i/XRmOLcv5sfxpXTE01A+
	 NsYUhEMgI/PJQFh04OVrBtCjsT1vxcNGh0kkhOf0UZPsZZBIgv8rmMpakcMClacGPn
	 aeip/snr+0bEQ==
Message-ID: <2fd83daa77c6cf0825fd8ebc33f5dd2c5370bc5a.camel@kernel.org>
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,  linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-nfs@vger.kernel.org
Date: Thu, 30 Nov 2023 12:47:58 -0500
In-Reply-To: <ZWdE/7bNvxcsY3ae@tissot.1015granger.net>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
	 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
	 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
	 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
	 <170121362397.7109.17858114692838122621@noble.neil.brown.name>
	 <ZWdE/7bNvxcsY3ae@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-29 at 09:04 -0500, Chuck Lever wrote:
> On Wed, Nov 29, 2023 at 10:20:23AM +1100, NeilBrown wrote:
> > On Wed, 29 Nov 2023, Christian Brauner wrote:
> > > [Reusing the trimmed Cc]
> > >=20
> > > On Tue, Nov 28, 2023 at 11:16:06AM +1100, NeilBrown wrote:
> > > > On Tue, 28 Nov 2023, Chuck Lever wrote:
> > > > > On Tue, Nov 28, 2023 at 09:05:21AM +1100, NeilBrown wrote:
> > > > > >=20
> > > > > > I have evidence from a customer site of 256 nfsd threads adding=
 files to
> > > > > > delayed_fput_lists nearly twice as fast they are retired by a s=
ingle
> > > > > > work-queue thread running delayed_fput().  As you might imagine=
 this
> > > > > > does not end well (20 million files in the queue at the time a =
snapshot
> > > > > > was taken for analysis).
> > > > > >=20
> > > > > > While this might point to a problem with the filesystem not han=
dling the
> > > > > > final close efficiently, such problems should only hurt through=
put, not
> > > > > > lead to memory exhaustion.
> > > > >=20
> > > > > I have this patch queued for v6.8:
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/com=
mit/?h=3Dnfsd-next&id=3Dc42661ffa58acfeaf73b932dec1e6f04ce8a98c0
> > > > >=20
> > > >=20
> > > > Thanks....
> > > > I think that change is good, but I don't think it addresses the pro=
blem
> > > > mentioned in the description, and it is not directly relevant to th=
e
> > > > problem I saw ... though it is complicated.
> > > >=20
> > > > The problem "workqueue ...  hogged cpu..." probably means that
> > > > nfsd_file_dispose_list() needs a cond_resched() call in the loop.
> > > > That will stop it from hogging the CPU whether it is tied to one CP=
U or
> > > > free to roam.
> > > >=20
> > > > Also that work is calling filp_close() which primarily calls
> > > > filp_flush().
> > > > It also calls fput() but that does minimal work.  If there is much =
work
> > > > to do then that is offloaded to another work-item.  *That* is the
> > > > workitem that I had problems with.
> > > >=20
> > > > The problem I saw was with an older kernel which didn't have the nf=
sd
> > > > file cache and so probably is calling filp_close more often.  So ma=
ybe
> > > > my patch isn't so important now.  Particularly as nfsd now isn't cl=
osing
> > > > most files in-task but instead offloads that to another task.  So t=
he
> > > > final fput will not be handled by the nfsd task either.
> > > >=20
> > > > But I think there is room for improvement.  Gathering lots of files
> > > > together into a list and closing them sequentially is not going to =
be as
> > > > efficient as closing them in parallel.
> > > >=20
> > > > >=20
> > > > > > For normal threads, the thread that closes the file also calls =
the
> > > > > > final fput so there is natural rate limiting preventing excessi=
ve growth
> > > > > > in the list of delayed fputs.  For kernel threads, and particul=
arly for
> > > > > > nfsd, delayed in the final fput do not impose any throttling to=
 prevent
> > > > > > the thread from closing more files.
> > > > >=20
> > > > > I don't think we want to block nfsd threads waiting for files to
> > > > > close. Won't that be a potential denial of service?
> > > >=20
> > > > Not as much as the denial of service caused by memory exhaustion du=
e to
> > > > an indefinitely growing list of files waiting to be closed by a sin=
gle
> > > > thread of workqueue.
> > >=20
> > > It seems less likely that you run into memory exhausting than a DOS
> > > because nfsd() is busy closing fds. Especially because you default to
> > > single nfsd thread afaict.
> >=20
> > An nfsd thread would not end up being busy closing fds any more than it
> > can already be busy reading data or busy syncing out changes or busying
> > renaming a file.
> > Which it is say: of course it can be busy doing this, but doing this so=
rt
> > of thing is its whole purpose in life.
> >=20
> > If an nfsd thread only completes the close that it initiated the close
> > on (which is what I am currently proposing) then there would be at most
> > one, or maybe 2, fds to close after handling each request.
>=20
> Closing files more aggressively would seem to entirely defeat the
> purpose of the file cache, which is to avoid the overhead of opens
> and closes on frequently-used files.
>=20
> And usually Linux prefers to let the workload consume as many free
> resources as possible before it applies back pressure or cache
> eviction.
>=20
> IMO the first step should be removing head-of-queue blocking from
> the file cache's background closing mechanism. That might be enough
> to avoid forming a backlog in most cases.
>=20
>=20

That's not quite what task_work does. Neil's patch wouldn't result in
closes happening more aggressively. It would just make it so that we
don't queue the delayed part of the fput process to a workqueue like we
do today.

Instead, the nfsd threads would have to clean that part up themselves,
like syscalls do before returning to userland. I think that idea makes
sense overall since that mirrors what we already do in userland.

In the event that all of the nfsd threads are tied up in slow task_work
jobs...tough luck. That at least makes it more of a self-limiting
problem since RPCs will start being queueing, rather than allowing dead
files to just pile onto the list.


> > > > For NFSv3 it is more complex.  On the kernel where I saw a problem =
the
> > > > filp_close happen after each READ or WRITE (though I think the cust=
omer
> > > > was using NFSv4...).  With the file cache there is no thread that i=
s
> > > > obviously responsible for the close.
> > > > To get the sort of throttling that I think is need, we could possib=
ly
> > > > have each "nfsd_open" check if there are pending closes, and to wai=
t for
> > > > some small amount of progress.
> > > >=20
> > > > But don't think it is reasonable for the nfsd threads to take none =
of
> > > > the burden of closing files as that can result in imbalance.
> > >=20
> > > It feels that this really needs to be tested under a similar workload=
 in
> > > question to see whether this is a viable solution.
> >=20
> > Creating that workload might be a challenge.  I know it involved
> > accessing 10s of millions of files with a server that was somewhat
> > memory constrained.  I don't know anything about the access pattern.
> >=20
> > Certainly I'll try to reproduce something similar by inserting delays i=
n
> > suitable places.  This will help exercise the code, but won't really
> > replicate the actual workload.
>=20
> It's likely that the fundamental bottleneck is writeback during
> close.
>=20

--=20
Jeff Layton <jlayton@kernel.org>

