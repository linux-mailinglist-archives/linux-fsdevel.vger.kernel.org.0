Return-Path: <linux-fsdevel+bounces-37646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E449F4F88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C6D7AA149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F23A1F758B;
	Tue, 17 Dec 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgxMTbsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE451F63C4;
	Tue, 17 Dec 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449651; cv=none; b=ctMDSzvrcAfpRlXaluV5S4Z+5xhDt4HjOASDs3LQrwhppcszEVxXQPG0HowjTXHgSzmRT3uYobiavkd28p0sGMTMPLNs0dsIAEIaieGnDSA1+eDz4NN/HwL+wVG1XNRJaOQJKU9pUqj58UY6xpY0AkPJEqAxSSKeaWLWBCYBgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449651; c=relaxed/simple;
	bh=PBoHMl/vjbrkDJJdW06HoXGpU5J3Rsz5cWS1b6kINrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccMX2tgEKSPD13zkM4OE4F1A6dM9uCM5lUm5eV1XksJ2Fmsv2hfrPY9hPqCNkLDGN+7VKtZCwiaLRg7Aa8Py6HqhyjxXLLlwftwLqaYrhFHajNmH1pIuRrYAWYTQpMnslFJ2eVFLed57wISYu8T/TgowiNfVGm+YpkP5A2K4Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PgxMTbsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88250C4CED6;
	Tue, 17 Dec 2024 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734449651;
	bh=PBoHMl/vjbrkDJJdW06HoXGpU5J3Rsz5cWS1b6kINrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgxMTbsQ+h5iOtpVU533vBud9w8343J2e+egHvICld0hUFr7LqxFtVeYlLphnKieJ
	 N78IZnvUhMe1HsMoT2itUg4Q7eUWthMde7Xa9fG2Tx2SDp3YnYHMNcpXsEYq1zItU+
	 BrU3612buMIwn28Ei1PSJ4/stU+D7LUZN8ad01wg=
Date: Tue, 17 Dec 2024 16:34:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Geffon <bgeffon@google.com>
Cc: "# v4 . 10+" <stable@vger.kernel.org>,
	Xuewen Yan <xuewen.yan@unisoc.com>,
	Christian Brauner <brauner@kernel.org>, jack@suse.cz,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	cmllamas@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	jing.xia@unisoc.com, xuewen.yan94@gmail.com,
	viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org, lizeb@google.com
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <2024121705-unrigged-sanitary-7b19@gregkh>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
 <20241016-kurieren-intellektuell-50bd02f377e4@brauner>
 <ZxAOgj9RWm4NTl9d@google.com>
 <Z1saBPCh_oVzbPQy@google.com>
 <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADyq12y=MGzcvemZTVVGN4yhzr2ihr96OB-Vpg0yvrtrewnFDg@mail.gmail.com>

On Tue, Dec 17, 2024 at 09:30:51AM -0500, Brian Geffon wrote:
> On Thu, Dec 12, 2024 at 12:14 PM Brian Geffon <bgeffon@google.com> wrote:
> >
> > On Wed, Oct 16, 2024 at 03:05:38PM -0400, Brian Geffon wrote:
> > > On Wed, Oct 16, 2024 at 03:10:34PM +0200, Christian Brauner wrote:
> > > > On Fri, 26 Apr 2024 16:05:48 +0800, Xuewen Yan wrote:
> > > > > Now, the epoll only use wake_up() interface to wake up task.
> > > > > However, sometimes, there are epoll users which want to use
> > > > > the synchronous wakeup flag to hint the scheduler, such as
> > > > > Android binder driver.
> > > > > So add a wake_up_sync() define, and use the wake_up_sync()
> > > > > when the sync is true in ep_poll_callback().
> > > > >
> > > > > [...]
> > > >
> > > > Applied to the vfs.misc branch of the vfs/vfs.git tree.
> > > > Patches in the vfs.misc branch should appear in linux-next soon.
> > > >
> > > > Please report any outstanding bugs that were missed during review in a
> > > > new review to the original patch series allowing us to drop it.
> > > >
> > > > It's encouraged to provide Acked-bys and Reviewed-bys even though the
> > > > patch has now been applied. If possible patch trailers will be updated.
> > > >
> > > > Note that commit hashes shown below are subject to change due to rebase,
> > > > trailer updates or similar. If in doubt, please check the listed branch.
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> > > > branch: vfs.misc
> > >
> > > This is a bug that's been present for all of time, so I think we should:
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable@vger.kernel.org
> >
> > This is in as 900bbaae ("epoll: Add synchronous wakeup support for
> > ep_poll_callback"). How do maintainers feel about:
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> 
> Dear stable maintainers, this fixes a bug goes all the way back and
> beyond Linux 2.6.12-rc2. Can you please add this commit to the stable
> releases?
> 
> commit 900bbaae67e980945dec74d36f8afe0de7556d5a upstream.

How is this a bugfix?  It looks like it is just a new feature being
added to epoll, what bug does it "fix"?

confused,

greg k-h

