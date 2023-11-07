Return-Path: <linux-fsdevel+bounces-2264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5207E429D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046B2817F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C19328C6;
	Tue,  7 Nov 2023 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfUvP+Uy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC11328AC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 15:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F77C433C7;
	Tue,  7 Nov 2023 15:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699369308;
	bh=fNdCq73OPIDu1gbkn2+5MFgD39/2qGsdNHmcv8pj5CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfUvP+Uydw6edXkpF086jpCYKNVRRG89Z93VsZtev7RORUYyd8Tk23bIcJZsrGxpG
	 qb1vXhworoaJtuzkx3N/7l1AFED0c04BWvF2dO+4ikH92lWvCSOPPUpDUR4xnKdQ+D
	 /6TN0uMv3+ZEf6GrJz+jRws6UKmieizHk4BoXd7qYwj134L75iFaICodP+jwaOgpnX
	 /ev98JlLTqGjGiSwRgzx9nj9Ujr312nikDFUxo+7wQUmYwKb+44LOB+eTJ6LM2vad6
	 uI5lDpHbVJtFOUQWOugoGhJ/J09GQZVvJoKGOtDABIpFeU10E1SbMOIzO6BU0a96qS
	 uocgIUGr320+w==
Date: Tue, 7 Nov 2023 16:01:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: make s_count atomic_t
Message-ID: <20231107-ersehen-zuerst-b184c0f91d85@brauner>
References: <20231027-neurologie-miterleben-a8c52a745463@brauner>
 <20231103081907.GD16854@lst.de>
 <20231106180831.GU1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106180831.GU1957730@ZenIV>

On Mon, Nov 06, 2023 at 06:08:31PM +0000, Al Viro wrote:
> On Fri, Nov 03, 2023 at 09:19:08AM +0100, Christoph Hellwig wrote:
> > Same feeling as Jan here - this looks fine to me, but I wonder if there's
> > much of a need.  Maybe run it past Al if he has any opinion?
> 
> [resurfaces from dcache stuff]
> 
> TBH, I'd rather see documentation of struct super_block life cycle
> rules written up, just to see what ends up being too ugly to document ;-/
> I have old notes on that stuff, but they are pretty much invalidated by
> the rework that happened this summer...

So I can write up an even more detailed document but
Documentation/filesystems/porting.rst upstream summarizes what has been
done in some detail.

> I don't hate making ->s_count atomic, but short of real evidence that
> sb_lock gets serious contention, I don't see much point either way.

Doesn't really matter enough imho.

> 
> PS: Re dcache - I've a growing branch with a bunch of massage in that area,
> plus the local attempt at documentation that will go there.  How are we
> going to manage the trees?  The coming cycle I'm probably back to normal
> amount of activity; the summer had been a fucking nightmare, but the things
> have settled down by now...  <looks> at least 5 topical branches, just
> going by what I've got at the moment.

One option is that I pull dcache branches from you and merge them into
vfs.all. I can also send them to Linus but I understand if you prefer to
do this yourself.

The other options is that you just do what you do in your tree and we'll
just deal with merge conflicts in next.

Fwiw, I haven't applied a lot of dcache stuff or taken patches of yours
you've Cced me on recently because I wasn't sure whether that was what
you wanted. I'm happy to pick them up ofc.

