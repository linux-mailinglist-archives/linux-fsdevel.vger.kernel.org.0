Return-Path: <linux-fsdevel+bounces-39207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC5A1159B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 00:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F6F3A26A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 23:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FF21B8E1;
	Tue, 14 Jan 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvPVAUkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FB420AF6D;
	Tue, 14 Jan 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898210; cv=none; b=jjr7kPtBw7xbUigrGqL6gNeepVNR1RdNj+zSfJ89U+onXi0XMYUJCd5kAFofFAy5JJWH4flmKTDnsj4yo0WpiisaAog1/jWaqItMUI0HRi2Xh54atrxjIaoIFJvYd0aDPb92GRmj1suNXLk5ODQRTnYJiRJVMOTV66iRlquzxMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898210; c=relaxed/simple;
	bh=cZScX6fcoSfywy6Y+mVmT+VskTpcHA+stbUNBFhbfVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW1qHGQLtrEzUVkYWY/5+FQcHqPTLODyT2wuxo9wc6rqp13f9M2+rJYe7oXv4tLq+YarKPvbfjeNRRQqbnvoF0T7D0SEfVV6SZQTc7U74Iv6ER4N7QQkymqXT02d19cZ2m89lWO4bKn1gSKgY3PgFPMXtgCX+4WWqTPhLXPk690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvPVAUkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10829C4CEDD;
	Tue, 14 Jan 2025 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736898210;
	bh=cZScX6fcoSfywy6Y+mVmT+VskTpcHA+stbUNBFhbfVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvPVAUkRpTqbvmShjZbOKSmaIP6ofopqUmDqluYI7J+9/ZMUwhvGsNzaMQCuzzcAj
	 SMKN3UyQrtLW/DCR1room859ksz465Byl5IKEY11loVNxlA3hY/28OkR08H1z5Ho4n
	 CxaB/rg0xs9ZtMEjBGM4ME/+oJ5SVk3VU77mFr1g3XPTu0ijp7NfpJv8ZdnkNfRk3H
	 BTOv2TBM6mklHUjNhYIfSkcj5TKYweb/NfwywU0p7OCRnVAb+642GPIBuxXWvCFMoI
	 jUaOY6QlasV+5wuheWb7xiBDkF4IyHNkicHUz/ERkz+EFlUHeLZ+2IITDYqXz1LOVJ
	 opjtUPT+rGUVg==
Date: Tue, 14 Jan 2025 15:43:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Kun Hu <huk23@m.fudan.edu.cn>,
	Andrey Konovalov <andreyknvl@gmail.com>, jack@suse.cz,
	jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	david@fromorbit.com, viro@zeniv.linux.org.uk, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250114234329.GB3557553@frogsfrogsfrogs>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <20250113-herzhaft-desolat-e4d191b82bdf@brauner>
 <Z4U89Wfyaz2fLbCt@casper.infradead.org>
 <20250113180830.GM6156@frogsfrogsfrogs>
 <CACT4Y+YVy3OqiG=HD4TcERCHqS7XrNUwMgJtjM-HLC_-kA5rdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YVy3OqiG=HD4TcERCHqS7XrNUwMgJtjM-HLC_-kA5rdw@mail.gmail.com>

On Tue, Jan 14, 2025 at 10:15:28AM +0100, Dmitry Vyukov wrote:
> On Mon, 13 Jan 2025 at 19:08, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jan 13, 2025 at 04:19:01PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 13, 2025 at 03:38:57PM +0100, Christian Brauner wrote:
> > > > On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> > > > > Hello,
> > > > >
> > > > > When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> > > > > was triggered.
> > > >
> > > > I think we need to come to an agreement at LSFMM or somewhere else that
> > > > we will by default ingore but reports from non-syzbot fuzzers. Because
> > > > we're all wasting time on them.
> >
> > No need to wait until LSFMM, I already agree with the premise of
> > deprioritizing/ignoring piles of reports that come in all at once with
> > very little analysis, an IOCCC-esque reproducer, and no effort on the
> > part of the reporter to do *anything* about the bug.
> >
> > While the Google syzbot dashboard has improved remarkably since 2018,
> > particularly in the past couple of years, thanks to the people who did
> > that!
> 
> And, thanks, Darrick!
> Most credit goes to Aleksandr Nogikh, who worked on improvements in
> the past years.
> We don't always have cycles to implement everything immediately, but
> we are listening.

You're welcome, and to both of you, thank you for all the improvements
over the last 8-9 years. :)

--D

> >  It's nice that I can fire off patches at the bot and it'll test
> > them.  That said, I don't perceive Google management to be funding much
> > of anyone to solve the problems that their fuzzer uncovers.
> >
> > This is to say nothing of the people who are coyly running their own
> > instances of syzbot sans dashboard and expecting me to download random
> > crap from Google Drive.  Hell no, I don't do that kind of thing in 2025.
> >
> > > I think it needs to be broader than that to also include "AI generated
> > > bug reports" (while not excluding AI-translated bug reports); see
> > >
> > > https://daniel.haxx.se/blog/2024/01/02/the-i-in-llm-stands-for-intelligence/
> > >
> > > so really, any "automated bug report" system is out of bounds unless
> > > previously arranged with the developers who it's supposed to be helping.
> >
> > Agree.  That's been my stance since syzbot first emerged in 2017-18.
> >
> > > We need to write that down somewhere in Documentation/process/ so we
> > > can point misguided people at it.
> > >
> > > We should also talk about how some parts of the kernel are basically
> > > unmaintained and unused, and that automated testing should be focused
> > > on parts of the kernel that are actually used.  A report about being
> > > able to crash a stock configuration of ext4 is more useful than being
> > > able to crash an unusual configuration of ufs.
> >
> > Or maybe we should try to make fuse + iouring fast enough that we can
> > kick all these old legacy drivers out to userspace. ;)
> >
> > > Distinguishing between warnings, BUG()s and actual crashes would also
> > > be a useful thing to put in this document.
> >
> > Yes.  And also state that panic_on_warn=1 is a signal that you wanted
> > fail(over) fast mode.
> >
> > --D

