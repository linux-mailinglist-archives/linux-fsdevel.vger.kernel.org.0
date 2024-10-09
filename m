Return-Path: <linux-fsdevel+bounces-31414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D3F995E80
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 06:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A482A28929D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 04:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FF142E86;
	Wed,  9 Oct 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ePqjztGC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049F137C37
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728447465; cv=none; b=W9f8svGzdEET0CH9ChadyVSZq0lpjXzHqoM2GM74L+0MmBM9BiYPhkjF+PVLo7OXgrvwqDqQHjghwZd/tvP7LdHUNNAOp1W2YEgoEqTZjeeU/RtH7iLRbldGBpRPLvTjLGa2eWwuoEZkxRAxI+Lk9SiDXTghHlgprvUvJL/RvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728447465; c=relaxed/simple;
	bh=RrXe6DklimFgZhHmkQOPQtwb2z7G/EVgyyPTR9aeyDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wke0uEx5h3BYIe0sd7HMuHC/6X1eGKumY5kxxqeIfMP3x3YDn1C+7xme+6BKfwhqCUmQW6oxCszRmBW8ZgLrfRA8VBm3GvPwNDOxseSrw25FjOw0hzn2ftzTdzbgZFy094xOtbix0LGk59aqWKZ6ajPzst5KHimCKQCVxurSF2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ePqjztGC; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 9 Oct 2024 00:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728447461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmUha6NmBXATpud6bD8r/lO+t7OtcRYkqayYgW/HEsM=;
	b=ePqjztGCI/E6efxQ3EOWD3Gnme9CmKvHxUfeziBVce9iaz7yyICXlthWJ6DUCEUGCbdm2F
	LggmfVIW0O/zxMIOUmM+n3sVMqMA0vvyA7ldTo+q6J/j0dCMjxbDvkQaNudD1Op9ReuGec
	hGB6pRTthFrdiyGSciNhNWVPzydhUaE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <kxi6m3gi7xqv52bupvb7iskyk6e3spq6bbhq4il5pmfieacfmf@5iwcnsfkmfq4>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <20241009035139.GB167360@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009035139.GB167360@mit.edu>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 08, 2024 at 10:51:39PM GMT, Theodore Ts'o wrote:
> On Sun, Oct 06, 2024 at 12:33:51AM -0400, Kent Overstreet wrote:
> > 
> > Correct me if I'm wrong, but your system isn't available to the
> > community, and I haven't seen a CI or dashboard for kdevops?
> 
> It's up on github for anyone to download, and I've provided pre-built
> test appliance so people don't have to have downloaded xfstests and
> all of its dependencies and build it from scratch.  (That's been
> automated, of course, but the build infrastructure is setup to use a
> Debian build chroot, and with the precompiled test appliances, you can
> use my test runner on pretty much any Linux distribution; it will even
> work on MacOS if you have qemu built from macports, although for now
> you have to build the kernel on Linux distro using Parallels VM[1].)

How many steps are required, start to finish, to test a git branch and
get the results?

Compare that to my setup, where I give you an account, we set up the
config file that lists tests to run and git branches to test, and then
results show up in the dashboard.

> I'll note that IMHO making testing resources available to the
> community isn't really the bottleneck.  Using cloud resources,
> especially if you spin up the VM's only when you need to run the
> tests, and shut them down once the test is complete, which
> gce-xfstests does, is actually quite cheap.  At retail prices, running
> a dozen ext4 file system configurations against xfstests's "auto"
> group will take about 24 hours of VM time, and including the cost of
> the block devices, costs just under two dollars USD.  Because the
> tests are run in parallel, the total wall clock time to run all of the
> tests is about two and a half hours.  Running the "quick" group on a
> single file system configuration costs pennies.  So the $300 of free
> GCE credits will actually get someone pretty far!

That's the same argument that I've been making - machine resources are
cheap these days.

And using bare metal machines significantly simplifies the backend
(watchdogs, catching full kernel and test output, etc.).

> No, the bottleneck is having someone knowledgeable enough to interpret
> the test results and then finding the root cause of the failures.
> This is one of the reasons why I haven't stressed all that much about
> dashboards.  Dashboards are only useful if the right person(s) is
> looking at them.  That's why I've been much more interested in making
> it stupidly easy to run tests on someone's local resources, e.g.:
> 
>      https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md

Yes, it needs to be trivial to run the same test locally that gets run
by the automated infrastructure, I've got that as well.

But dashboards are important, as well. And the git log based dashboard
I've got drastically reduces time spent manually bisecting.

> In fact, for most people, the entry point that I envision as being
> most interesting is that they download the kvm-xfstests, and following
> the instructions in the quickstart, so they can run "kvm-xfstests
> smoke" before sending me an ext4 patch.  Running the smoke test only
> takes 15 minutes using qemu, and it's much more convenient for them to
> run that on their local machine than to trigger the test on some
> remote machine, whether it's in the cloud or someone's remote test
> server.
> 
> In any case, that's why I haven't been interesting in working with
> your test infrastructure; I have my own, and in my opinion, my
> approach is the better one to make available to the community, and so
> when I have time to improve it, I'd much rather work on
> {kvm,gce,android}-xfstests.

Well, my setup also isn't tied to xfstests, and it's fairly trivial to
wrap all of our other (mm, block) tests.

But like I said before, I don't particularly care which one wins, as
long as we're pushing forward with something.

