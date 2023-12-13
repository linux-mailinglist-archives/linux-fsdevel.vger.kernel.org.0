Return-Path: <linux-fsdevel+bounces-5828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD830810DD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B521F21197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC72233C;
	Wed, 13 Dec 2023 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNOUKLgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FB21A11;
	Wed, 13 Dec 2023 10:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B64C433C8;
	Wed, 13 Dec 2023 10:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702461882;
	bh=QePzytgeWK2qtS6DLN65UyMUVQEzwecQEMcPzyfNYKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nNOUKLgFqtvPk21lH7EZBiY7Sn4duKc8ZPMXNWPruXX2pO1TuZruRir3qTL15aw+/
	 y+dd4pl5+AstqxQLdlQGQbvEyJmL+WfJDz4xzSJ6sDoET/AinXvZIB3FVYYSIXH2tb
	 eDI00INHKVonEN35A2g2JW0Xu10Qu2kGMMLBL9bhH1k4ob07NwstvGQRWq+S7BUfJo
	 ok8fVKKCCnkkf4wTXmMlkTV8m4UsKG2GcnIdpDcI0QT3WzBHF1plErG6EAhKAQb84K
	 6XKJN6aFeOUCkcQ0lb/hO8ffmZ7ulkfNRFabXGprGfqNzHbummIRS5StNwGfnJCA3e
	 3CfzkVIbSB0HA==
Date: Wed, 13 Dec 2023 11:04:36 +0100
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
Message-ID: <20231213-rammen-vorgreifen-1515308def06@brauner>
References: <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
 <20231212-neudefinition-hingucken-785061b73237@brauner>
 <20231212153542.kl2fbzrabhr6kai5@moria.home.lan>
 <CAJfpegsKsbdtUHUPnu3huCiPXwX46eKYSUbLXiWqH23GinXo7w@mail.gmail.com>
 <170241761429.12910.13323799451396212981@noble.neil.brown.name>
 <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213-umgearbeitet-erdboden-c2fd5409034d@brauner>

On Wed, Dec 13, 2023 at 10:48:01AM +0100, Christian Brauner wrote:
> On Wed, Dec 13, 2023 at 08:46:54AM +1100, NeilBrown wrote:
> > On Wed, 13 Dec 2023, Miklos Szeredi wrote:
> > > On Tue, 12 Dec 2023 at 16:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > 
> > > > Other poeple have been finding ways to contribute to the technical
> > > > discussion; just calling things "ugly and broken" does not.
> > > 
> > > Kent, calm down please.  We call things "ugly and broken" all the
> > > time.  That's just an opinion, you are free to argue it, and no need
> > > to take it personally.
> > 
> > But maybe we shouldn't.  Maybe we should focus on saying what, exactly,
> > is unpleasant to look at and way.  Or what exactly causes poor
> > funcationality.
> 
> I said it's "ugly" and I doubted it's value. I didn't call it "broken".

I see where you took that from. To be clear, what I meant by broken is
the device number switching that btrfs has been doing which has caused
so much pain already and is at least partially responsible for this
endless long discussion. I didn't mean "broken" as in the flag is
broken. I acknowledge that I failed to make that clearer.

