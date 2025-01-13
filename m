Return-Path: <linux-fsdevel+bounces-39067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E101BA0BF8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A5E188219E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F29B1BD9FB;
	Mon, 13 Jan 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Otpib2ii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920D24022F;
	Mon, 13 Jan 2025 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736791711; cv=none; b=VxdMU1Dvz+AUWWQWefUeMZszM/IWyWzOEDqKnaQXVSofx8DTdAQGdIiI6UG9W5s5qHOnbz4VAeow1B624ZNFk4FvV6np4nWz4Ug7vwNXTZfsp9qOF6eqp7/6w4wdUuXQnG7NK7S4MqcZcfWFtWnUO36ZOQo0AFFpQLpQaiLrLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736791711; c=relaxed/simple;
	bh=TNWH3DetZvdv/vseoGKZk1rXW75jZQ5Mj637t+Wovj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2G5fx8clHFhURdDSbij7IlZ4/rbsooc92OD8kbKQMo3qa6DV0BAIQ/80oOmzMymLu47gIYl56luD+7FPg3+o/X7rEyvISZsEEmMx89Zsasq1gJeHZSY6V0ut7hs9MB5bKxHWXNDt01thsdeFgvl3rXwiOcQtx+OYK05A8NyI5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Otpib2ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A128C4CEE1;
	Mon, 13 Jan 2025 18:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736791711;
	bh=TNWH3DetZvdv/vseoGKZk1rXW75jZQ5Mj637t+Wovj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Otpib2ii0YELblxpk9ih+E2z953/rn6gCGwGMBJr/SV6TCBoCJap7rXQ41GT57LKT
	 df1xtWOE2NskszgNSokTup51eO7YXUui754U45qyK8+NQamEENzT1VPzgSrqp/L8G4
	 jeMocE2g17Jio58DjFlnfPSGz//z+J8TNi9cMk2YO6rLT0E47znndgzvMZGWU3z5Zv
	 q8AeLJZWboEllSKi5afjsQFDRexl1Dcel56+wEESpOghHtCSMF/UTUbPmJ3XfKk1n8
	 OyHUCA95Ibq/0BU5aLg4PBoYN25zCG4qlgnOX8DwiErlu+eVtRLc9rR+ZYwnbL828J
	 6Zb7qAjFKwgZw==
Date: Mon, 13 Jan 2025 10:08:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Kun Hu <huk23@m.fudan.edu.cn>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, jack@suse.cz,
	jlayton@redhat.com, tytso@mit.edu, adilger.kernel@dilger.ca,
	david@fromorbit.com, bfields@redhat.com, viro@zeniv.linux.org.uk,
	christian.brauner@ubuntu.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Bug: INFO_ task hung in lock_two_nondirectories
Message-ID: <20250113180830.GM6156@frogsfrogsfrogs>
References: <42BD15B5-3C6C-437E-BF52-E22E6F200513@m.fudan.edu.cn>
 <20250113-herzhaft-desolat-e4d191b82bdf@brauner>
 <Z4U89Wfyaz2fLbCt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4U89Wfyaz2fLbCt@casper.infradead.org>

On Mon, Jan 13, 2025 at 04:19:01PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 13, 2025 at 03:38:57PM +0100, Christian Brauner wrote:
> > On Sun, Jan 12, 2025 at 06:00:24PM +0800, Kun Hu wrote:
> > > Hello,
> > > 
> > > When using our customized fuzzer tool to fuzz the latest Linux kernel, the following crash (43s)
> > > was triggered.
> > 
> > I think we need to come to an agreement at LSFMM or somewhere else that
> > we will by default ingore but reports from non-syzbot fuzzers. Because
> > we're all wasting time on them.

No need to wait until LSFMM, I already agree with the premise of
deprioritizing/ignoring piles of reports that come in all at once with
very little analysis, an IOCCC-esque reproducer, and no effort on the
part of the reporter to do *anything* about the bug.

While the Google syzbot dashboard has improved remarkably since 2018,
particularly in the past couple of years, thanks to the people who did
that!  It's nice that I can fire off patches at the bot and it'll test
them.  That said, I don't perceive Google management to be funding much
of anyone to solve the problems that their fuzzer uncovers.

This is to say nothing of the people who are coyly running their own
instances of syzbot sans dashboard and expecting me to download random
crap from Google Drive.  Hell no, I don't do that kind of thing in 2025.

> I think it needs to be broader than that to also include "AI generated
> bug reports" (while not excluding AI-translated bug reports); see
> 
> https://daniel.haxx.se/blog/2024/01/02/the-i-in-llm-stands-for-intelligence/
> 
> so really, any "automated bug report" system is out of bounds unless
> previously arranged with the developers who it's supposed to be helping.

Agree.  That's been my stance since syzbot first emerged in 2017-18.

> We need to write that down somewhere in Documentation/process/ so we
> can point misguided people at it.
> 
> We should also talk about how some parts of the kernel are basically
> unmaintained and unused, and that automated testing should be focused
> on parts of the kernel that are actually used.  A report about being
> able to crash a stock configuration of ext4 is more useful than being
> able to crash an unusual configuration of ufs.

Or maybe we should try to make fuse + iouring fast enough that we can
kick all these old legacy drivers out to userspace. ;)

> Distinguishing between warnings, BUG()s and actual crashes would also
> be a useful thing to put in this document.

Yes.  And also state that panic_on_warn=1 is a signal that you wanted
fail(over) fast mode.

--D

