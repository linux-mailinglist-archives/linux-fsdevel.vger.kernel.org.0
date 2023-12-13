Return-Path: <linux-fsdevel+bounces-5826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AA8810DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B32819BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141BC219E1;
	Wed, 13 Dec 2023 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2f5royT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5420B09;
	Wed, 13 Dec 2023 09:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B3C433C8;
	Wed, 13 Dec 2023 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702460880;
	bh=/2XnRbM+FMJzFmLkus7NkavvrG8oovlJcjYFtNIjlcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2f5royTKRAhL34GpK4IwQTXQE6t1/0VUkrm+Cmw/scjfAqPOjMps3ph4BS/yOFnq
	 IfTnd082pZ5f5efgTeGkXf152lU/uzJXpwbhNV5WzZmtgDDbj9Jj0T/zKaLhYJAHwM
	 iTph0425D9jf+xbZzP/Xy6godNA+cRmhqHY6MOS++s1SNB9of2EgHCpnTVFp+4sb2N
	 8fCCw+mDMlVxyhlD+srihz+uee5Df6ikb9K78dBGxHxlykMRlxEIiHuDiDcrDfJvqF
	 NOwSYc5iWGH26FYpNIm2Hd/Cpmh1gU3Rws0ZWy88qbPPrs91s4tpt71jruknkavyVs
	 KMwW7N3X8llew==
Date: Wed, 13 Dec 2023 10:47:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>
References: <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <170241761429.12910.13323799451396212981@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170241761429.12910.13323799451396212981@noble.neil.brown.name>

On Wed, Dec 13, 2023 at 08:46:54AM +1100, NeilBrown wrote:
> On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> > On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > 
> > > Other poeple have been finding ways to contribute to the technical
> > > discussion; just calling things "ugly and broken" does not.
> > 
> > Kent, calm down please.  We call things "ugly and broken" all the
> > time.  That's just an opinion, you are free to argue it, and no need
> > to take it personally.
> 
> But maybe we shouldn't.  Maybe we should focus on saying what, exactly,
> is unpleasant to look at and way.  Or what exactly causes poor
> funcationality.

I said it's "ugly" and I doubted it's value. I didn't call it "broken".
And I've been supportive of the other parts. Yet everyone seems fine
with having this spiral out of control to the point where I'm being
called a dick.

You hade a privat discussion on the bcachefs mailing list and it seems
you expected to show up here with a complete interface that we just all
pick up and merge even though this is a multi-year longstanding
argument.

I've been supportive of both the subvol addition to statx and the
STATX_* flag to indicate a subvolume root. Yet somehow you're all
extremely focussed on me disliking this flag.

> "ugly" and "broken" are not particularly useful words in a technical
> discussion.  I understand people want to use them, but they really need
> to be backed up with details.  It is details that matter.

I did say that I don't see the value. And it's perfectly ok for you to
reiterate why it provides value. Your whole discussion has been private
on some other mailing list without the relevant maintainers Cced.

