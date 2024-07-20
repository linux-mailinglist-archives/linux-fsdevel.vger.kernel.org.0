Return-Path: <linux-fsdevel+bounces-24041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA59381DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 17:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B60E1C21551
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jul 2024 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766371474AE;
	Sat, 20 Jul 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lE0FooT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC8145A1A
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jul 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721490497; cv=none; b=OMvYhYMGh0fM34CnnhJL59r3Fl8w4Hkp3KZGyQB5d4S+v1GV1ofX5vD7AwZR0LOW+z86yDcGAk82DBaeC2ALXJC+nOu51w3Bqhog+yHaXgkQRsnew5A9E9V6upLabVCvPri1trcIl9nsszCyWV30PBP6uPMRBAlLJBiB8PBovAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721490497; c=relaxed/simple;
	bh=hgEXpisTb2le0MriL6RtT7PRkbN6vTef/d/5WpYhM9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH+TRT1UTHDzCWt13DC5kk3SK0Lz9ZZ8HEeBQvl6acfYJMwXNxHVNJBpO9AjSdpiJ7PEVu+j3j7Qcb0paqYq0w0r4HYE9tBnmfyikjqCkgcETYG7nI1Xl8uJwQ3+X9x7/I6xvvClkGTSKw2daMLdmHxWqBcsp/kIGDOI6yuuq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lE0FooT/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721490492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JNyq8DwjmN5WEK/I4PVTxJQ71hpCMep458KtZi3slTY=;
	b=lE0FooT/fu2LaRQfZJA9XisTp9jN2XsVktg2NWMI4qPgm7ehnhZ8EwGH9LRCs8K2C8tgdR
	WOkTzD6XD1nnvhs0CEQVL62+8vImVQjoWzDEEv/XRQ7ahJCNI65+1dIvgN4jCAiZ44Kapc
	U/Enm/Kwk2ETYQoNG9o2+Rx1mk0BOSc=
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: snitzer@kernel.org
X-Envelope-To: mpatocka@redhat.com
X-Envelope-To: dm-devel@lists.linux.dev
Date: Sat, 20 Jul 2024 11:48:09 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev
Subject: mounts failing with -EBUSY on device mapper (was: Re: [GIT PULL]
 bcachefs changes for 6.11)
Message-ID: <xp5nl7zi3k6ddkby4phm4swv2wi43slwtvw5fmve5g3jxtdw7w@ygiltwihp2hv>
References: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
 <CAHk-=wigjHuE2OPyuT6GK66BcQSAukSp0sm8vYvVJeB7+V+ecQ@mail.gmail.com>
 <5ypgzehnp2b3z2e5qfu2ezdtyk4dc4gnlvme54hm77aypl3flj@xlpjs7dbmkwu>
 <CAHk-=wgzMxdCRi9Fqhq2Si+HzyKgWEvMupq=Q-QRQ1xgD_7n=Q@mail.gmail.com>
 <4l32ehljkxjavy3d2lwegx3adec25apko3v355tnlnxhrs43r4@efhplbikcoqs>
 <20240719143001.GA2333818@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719143001.GA2333818@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 19, 2024 at 10:30:01AM GMT, Theodore Ts'o wrote:
> On Thu, Jul 18, 2024 at 06:24:08PM -0400, Kent Overstreet wrote:
> > 
> > I've gotten essentially zero in the way of test feedback from
> > for-next (except from Stephen Rothwell directly, the odd build
> > warning or merge issue, but 0day mostly catches the build stuff
> > before it hits next).
> 
> I am currently running regular testing on the new linux-next's fs-next
> branch.  Things which are still blocking me from announcing it are:
> 
> *) Negotiating with Konstantin about the new lists.linux.dev mailing
>    list.
> 
> *) A few minor bug fixes / robustification improves in the
>    "gce-xfstests watch" --- for example, right now if git fetch fails
>    due to load throttling / anti-DOS protections on git.kernel.org
>    trip the git watcher dies.  Obviously, I need to teach it to do
>    exponential backoff retries, because I'm not going to leave my
>    kernel.org credentials on a VM running in the cloud to bypass the
>    kernel.org DOS protections.  :-)
> 
> As far as bcachefs is concerned, my xfstests-bld infrastructure isn't
> set up to build rust userspace, and Debian has a very ancient bcachefs
> packages --- the latest version in Debian stable and unstable dates
> from November 2022.  So I haven't enabled bcachefs support in
> gce-xfstests and kvm-xfstests yet.  Patches gratefully accepted.  :-)

I can apt install 1.9.1?

But I just discovered, because I had to switch my own testing to the
debian package, that the mount helper wasn't being run previously
(doesn't check /usr/local/sbin); and mounts with the mount helper are
failing with -EBUSY.

Presumably there's a race, since before calling the mount syscall, our
mount helper has to open and close the block device (we have to read the
superblock to check if it's encrypted, we may need to ask for a
passphrase). The delayed_fput stuff that was causing issues with
io_uring - I suspect something similar.

But the plot thickens - all the failing tests are ones that use device
mapper...

