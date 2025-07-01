Return-Path: <linux-fsdevel+bounces-53412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0AAEEE14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FD51BC368F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 06:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE8F218ADC;
	Tue,  1 Jul 2025 06:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6A5FRTF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E718D;
	Tue,  1 Jul 2025 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349777; cv=none; b=UBGmQQYqybCNNjpuKxKhlf0CEeFxpUQeIIS+xHLanwjJph5bvygHSOjnhn5guFV6ETJYXrmR2Ww6xdm8GaEpvCZh41JyTjevL/n34bUBBEsSD0ZP89ATQY/fLL5bj5zieyNqE+SuzAHTEFCfsh0g5Df6ITIZiYxQIbtIJp45Myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349777; c=relaxed/simple;
	bh=NRO0ZafKxXLxbxhPiSS92FhXylIGX5pW2/0C9WkmL6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlcIXc5IFoK72PrIrHjN998QBWhrSmuH69MWzJmzBxFjr1XHtNt5DJ4lryANbCLBhXHJbjWKvKGBUDebtgwelnCpI5aRgLMC9kPlqgdU4l+p3ywHNHFPW8wWRdZTyjgxuWPv4ATtvO3y2Ub0xdkxeDdJ2FhEpk6awqBqowBD/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6A5FRTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454E3C4CEEB;
	Tue,  1 Jul 2025 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751349776;
	bh=NRO0ZafKxXLxbxhPiSS92FhXylIGX5pW2/0C9WkmL6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6A5FRTFfeHlFEC9bYkdUWr+F3MPhl3jeLF3b8XD+cUQ4K/ywx5mYLg6+UcsBhcHg
	 U/xL/lx9AUKBJJXoE7KnCt8VOLmEf2Jx1bmG18AyKBGZmrKBZBRDALbcOju6ix/tMp
	 8xhchss302AE8iTjUD6rW58IBsYcIg7Ta9ScWy5SOG/1BHQq+0fu/Wz3yegb9fgTVd
	 caDUwVl4YerZlEGSLgNMzUf2ItCu2zmTKIuRBN8AWPqcmN6HBmLGDfji809Rbn6rTg
	 ITgl6U+WzKwFjDpsvpXJkfJ5fkcBplUlhyeIq/PFieh4GoSbbMkdo4rT/NtJNg66tD
	 nLM6A6wYsb7Lw==
Date: Mon, 30 Jun 2025 23:02:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Allison Karlitskaya <lis@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250701060255.GG9987@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
 <20250611115629.GL784455@mit.edu>
 <CAOYeF9W8OpAjSS9r_MO5set0ZoUCAnTmG2iB7NXvOiewtnrqLg@mail.gmail.com>
 <1ac7d8ff-a212-4db8-8d01-e06be712c4ed@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac7d8ff-a212-4db8-8d01-e06be712c4ed@bsbernd.com>

On Fri, Jun 20, 2025 at 01:50:20PM +0200, Bernd Schubert wrote:
> 
> 
> On 6/20/25 10:58, Allison Karlitskaya wrote:
> > hi Ted,
> > 
> > Sorry I didn't see this earlier.  I've been travelling.
> > 
> > On Wed, 11 Jun 2025 at 21:25, Theodore Ts'o <tytso@mit.edu> wrote:
> > > This may break the github actions for composefs-rs[1], but I'm going
> > > to assume that they can figure out a way to transition to Fuse3
> > > (hopefully by just using a newer version of Ubuntu, but I suppose it's
> > > possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> > > in any case, I don't think it makes sense to hold back fuse2fs
> > > development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> > > necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> > > they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> > > sound fair to you?
> > 
> > To be honest, with a composefs-rs hat on, I don't care at all about
> > fuse support for ext2/3/4 (although I think it's cool that it exists).
> > We also use fuse in composefs-rs for unrelated reasons, but even there
> > we use the fuser rust crate which has a "pure rust" direct syscall
> > layer that no longer depends on libfuse.  Our use of e2fsprogs is
> > strictly related to building testing images in CI, and for that we
> > only use mkfs.ext4.  There's also no specific reason that we're using
> > old Ubuntu.  I probably just copy-pasted it from another project
> > without paying too much attention.
> 
> 
> From libfuse point of view I'm too happy about that split into different

"too happy"?  I would have thought you would /not/ be too happy about
splits... <confused>

> libraries. Libfuse already right now misses several features because
> they were added to virtiofs, but not to libfuse. I need to find the time
> for it, but I guess it makes sense to add rust support to libfuse (and
> some parts can be entirely rewritten into rust).

Yeah, I noticed a few missing pieces like statx and syncfs support,
which I added to my own libfuse branch (+ fuse2fs).  Eventually I'd like
to get the kernel umount code to flush and wait for all pending fuse
commands, issue a FUSE_SYNCFS and wait for that, and then issue a
FUSE_DESTROY to tell the fuse server to tear itself down and release the
block devices(s) its holding.

--D

> 
> 
> Thanks,
> Bernd
> 

