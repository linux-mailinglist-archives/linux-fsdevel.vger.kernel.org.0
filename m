Return-Path: <linux-fsdevel+bounces-5710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DBA80F110
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6DAB2151C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8A77F2D;
	Tue, 12 Dec 2023 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUlTsjcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E123C77F22;
	Tue, 12 Dec 2023 15:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3D1C433C8;
	Tue, 12 Dec 2023 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702394954;
	bh=Feas20i9P/s3jCszwKNAizfzzf8i+57Nc1CSbvIQYEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUlTsjcMtB+wywXN6Ctxl1+KdYM7WweClmYwS+aCvqk1MhqPomyBP6zDzLtc2MmhA
	 41+BQzONS+wF+dT07GlZAJPqoqEazB6RJRFLsOl2PJWozapxtfwVnpahh6N+lPSnke
	 w3ihSSVKtVHYA1iSIlfZjJGJTU7/hPg6eO8u+ui0wyDdEb8hBm5dBEK0wXPIXM4nc+
	 F4SVmyion4GEtniov5UmPDUmp9tf1t9Hm0aYqdBIA7VkhTuS8C0EvuBY8v2t/P+FiU
	 ZMLPH5bzqRo0rGwXEqwjGqSbJHA0LB/C4bKWuw5tIgTHOKQ0I+GRksQ5g4/4MZXdUc
	 JpZsnJ0DjkyvA==
Date: Tue, 12 Dec 2023 16:29:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
	NeilBrown <neilb@suse.de>, Donald Buczek <buczek@molgen.mpg.de>,
	linux-bcachefs@vger.kernel.org,
	Stefan Krueger <stefan.krueger@aei.mpg.de>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Subject: Re: file handle in statx (was: Re: How to cope with subvolumes and
 snapshots on muti-user systems?)
Message-ID: <20231212-neudefinition-hingucken-785061b73237@brauner>
References: <20231208200247.we3zrwmnkwy5ibbz@moria.home.lan>
 <170233460764.12910.276163802059260666@noble.neil.brown.name>
 <20231211233231.oiazgkqs7yahruuw@moria.home.lan>
 <170233878712.12910.112528191448334241@noble.neil.brown.name>
 <20231212000515.4fesfyobdlzjlwra@moria.home.lan>
 <170234279139.12910.809452786055101337@noble.neil.brown.name>
 <ZXf1WCrw4TPc5y7d@dread.disaster.area>
 <CAOQ4uxiQcOk1Kw1JX4602vjuWNfL=b_A3uB1FJFaHQbEX6OOMA@mail.gmail.com>
 <20231212-impfung-linden-6f973f2ade19@brauner>
 <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212151631.wi7rgawmp3uig6cl@moria.home.lan>

On Tue, Dec 12, 2023 at 10:16:31AM -0500, Kent Overstreet wrote:
> On Tue, Dec 12, 2023 at 09:56:45AM +0100, Christian Brauner wrote:
> > On Tue, Dec 12, 2023 at 08:32:55AM +0200, Amir Goldstein wrote:
> > > > >  STATX_ATTR_INUM_NOT_UNIQUE - it is possible that two files have the
> > > > >                               same inode number
> > 
> > This is just ugly with questionable value. A constant reminder of how
> > broken this is. Exposing the subvolume id also makes this somewhat redundant.
> 
> Oh hell no. We finally get a reasonably productive discussion and I wake
> up to you calling things ugly and broken, with no reason or
> justification or any response to the justification that's already been
> given?
> 
> Christain, that's not how we do things. Let's not turn what was a
> productive discussion into a trainwreck, OK?

That's a major aggressive tone for no good reason. And probably not a
good way to convince anyone. I'm also not sure why you're taking a
dislike of this flag as a personal affront.

