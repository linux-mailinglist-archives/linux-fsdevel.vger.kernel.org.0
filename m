Return-Path: <linux-fsdevel+bounces-63428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F2FBB88A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 04:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B5719E74A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832D720DD48;
	Sat,  4 Oct 2025 02:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="qMsrJk/Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368892AE77
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Oct 2025 02:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759546398; cv=none; b=SViv62Jmejx30snt0r/5cgRe0w7MjNvcQ3i1aMf4lB4Njsyb1LFqzw432KRSbFegmdH6onmfJLMNykxryGhhrMSrp9kYLEwLNIXP5SXcPv4SYBf4hQyhlFm8C24kvotEMrjyG5CKcfKVuUerXCvRVw18Hk7rKxOH0mQ6UdcE/1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759546398; c=relaxed/simple;
	bh=yeC3KsfD2nh9bIyCmrT85tDHKKNrI2mGOS5OAW6L31s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbUpnMCPpEvRTaVxEXUg66twaApP2KDAEdbRpUi8+g1oV2XgSID7R05QGO5oFr3HQGtMYogRE/D1sFvXYov2f/O+eKa/2EGp/QZuT0updYssijMhnwoIlADR7pqOAj84Z5zstwESVmh09TOooNoTzenDxyrbH0Y44kaYnbmDQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=qMsrJk/Y; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-49-45-174.bstnma.fios.verizon.net [108.49.45.174])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5942ql3i023854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 Oct 2025 22:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759546376; bh=RO5kDuu2G5eNwHxj6/FPijVwvswe7D2xQUzS2yP8aWw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=qMsrJk/Y9eKB5norApw1qpR6Gd2pszhb1oXeY2yd3+Qr4yHADfLBnz0V5PDu3G7nb
	 sxptLnSOg5br2RBzaMt4rhh73k6T4lg+jpJVesik7u6Xs7rT//tKB88nPca+57GvKq
	 ilw2FUO3wNSZZbfpWsPGJMmyfBhLshTv3mgrNaFZpH5uGz99TVJ/86h4gm9XUz6T1j
	 qrElW1NRkLIRV6NbIv8ucbHTIQbuohmRMSKCwFGpvDX7O8AlEl82Tg2c3U3B+aCBpR
	 9FdZdVcsdHM/MO96dchXUj7hHDlfIul6aBhRBiN3TvmJhSDyxX7ZWsqkgszGgLDvkd
	 lfLg1o1rKfMOg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id BCDB52E00D9; Fri, 03 Oct 2025 22:52:47 -0400 (EDT)
Date: Fri, 3 Oct 2025 22:52:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Francesco Mazzoli <f@mazzo.li>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Bernd Schubert <bernd.schubert@fastmail.fm>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Mainlining the kernel module for TernFS, a distributed filesystem
Message-ID: <20251004025247.GD386127@mit.edu>
References: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
 <CAOQ4uxi_Pas-kd+WUG0NFtFZHkvJn=vgp4TCr0bptCaFpCzDyw@mail.gmail.com>
 <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34918add-4215-4bd3-b51f-9e47157501a3@app.fastmail.com>

On Fri, Oct 03, 2025 at 04:01:56PM +0100, Francesco Mazzoli wrote:
> 
> > A codebase code with only one major user is a red flag.
> > I am sure that you and your colleagues are very talented,
> > but if your employer decides to cut down on upstreaming budget,
> > the kernel maintainers would be left with an effectively orphaned filesystem.

I'd go further than that.  Expanding your user base is definitely a
good thing, but I'd go further than that; see if you can expand your
developer community so that some of your users are finding enough
value that they are willing to contribute to the development of the
your file system.  Perhaps there are some use cases which aren't
important to you, so it's not something that you can justifying
pursuing, but perhaps it would be high value for some other company
with a similar, but not identical, use case?

To do that, some recommendations:

*) Have good developer's documentation; not just how to start using
   it, but how to get started understanding the code base.  That is,
   things like the layout of the code base, how to debug problems,
   etc.  I see that you have documentation on how to run regression
   tests, which is great.

*) At the moment, it looks like your primary focus for the client is
   the Ubuntu LTS kernel.  That makes sense, but if you are are going
   for upstream inclusion, it might be useful to have a version of the
   codebase which is sync'ed to the upstream kernel, and then having an
   adaption layer which allows the code to be compiled as a module on
   distribution kernels.
   
*) If you have a list of simple starter projects that you could hand
   off to someone who is intersted, that would be useful.  (For
   example, one such starter project might be adding dkms support for
   other distributions beyond Ubuntu, which might be useful for other
   potential users.  Do you have a desire for more tests?  In general,
   in my experience, most projects always could use more testing.)

Looking the documentation, here are some notes:

* "We don't expect new directories to be created often, and files (or
  directories) to be moved between directories often."  I *think*
  "don't expect" binds to both parts of the conjuction.  So can you
  confirm that whatw as meant is "... nor do we expect that files
  (or directries) to be moved frequently."

* If that's true, it means that you *do* expect that files and
  directories can be moved around.  What are the consistency
  expectations when a file is renamed/moved?  I assume that since
  clients might be scattered across the world, there is some period
  where different clients might have different views.  Is there some
  kind of guarantee about when the eventual consistency will
  definitely be resolved?

* In the description of the filesystem data or metadata, there is no
  mention of whether there are checksums at rest or not.  Given the
  requirements that there be protections against hard disk bitrot, I
  assume there would be -- but what is the granularity?  Every 4092
  bytes (as in GFS)?   Every 1M?   Every 4M?   Are the checksums verified
  on the server when the data is read?  Or by the client?   Or both?
  What is the recovery path if the checksum doesn't verify?

* Some of the above are about the protocol, and that would be good to
  document.  What if any are the authentication and authorization
  checking that gets done?  Are there any cryptographic protection for
  either encryption or data integrity?  I've seen some companies who
  consider their LLM to highly proprietary, to the extent that they
  want to use confidential compute VM's.  Or if you are using the file
  system for training data, the training data might have PII.

> These are all good questions, and while we have not profiled the
> FUSE driver extensively...

There has been some really interesting work that that Darrick Wong has
been doing using the low-level fuse API.  The low-level FUSE is Linux
only, but using that with fs-iomap patches, Darrick has managed to get
basically get equivalent performance for direct and buffered I/O
comparing the native ext4 file system driver with his patched fuse2fs
and low-level fuse fs-iomap implementation.  His goal was to provide
better security for untrusted containers that want to mount images
that might be carefully, maiciously trusted, but it does demonstrate
that you aren't particularly worried about metadata-heavy workloads,
and are primarily concerend about data plane performance, uisng the
low-level (linux-only) FUSE interface might work well for you.

> There are some specific things that would be difficult today. For
> instance FUSE does not expose `d_revalidate`, which means that
> dentries would be dropped needlessly in cases where we know they can
> be left in place.

I belive the low-level FUSE interface does expose dentry revalidation.


> parts of a file is unreadable, and in that case we'd have had to
> fall back to a non-passthrough version.

Ah, you are using erasure codes; what was the design considerations of
using RS as opposed to having multiple copies of data blocks.  Or do
you support both?

This would be great to document --- or maybe you might want to
consider creating a "Design and Implementation of TernFS" paper and
submitting to a conference like FAST.  :-)

Cheers,

						- Ted
						

