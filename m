Return-Path: <linux-fsdevel+bounces-14529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F687D4F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EC51C21E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 20:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215720DE0;
	Fri, 15 Mar 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kXfAomrv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF917741
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534732; cv=none; b=VYyCkpnxlGh/n8bRPoAm3fDGKIpJmKtOiyZb4Nk4wRgsxdfZKPTcmPSuprX1jLorY08OyTwZbIXMnZpHabWHynILHMsJdrtOIMlMio6fFlFeV0mn+5p9kxXF/mU6xbRz79ffxnTChMygcObvjrQEdJgUQGCb+ep/aOXcAwBB8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534732; c=relaxed/simple;
	bh=WyqN4TwF4k4aUJcyTPVMdOxH/JjKll+ROWg/w5nXgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWqr5wDhqrYgaICvnPQ/ABfISHPdx2Fu+iLRwy3mZp+nguTKJpO0RSEFc+bUfFH0mIT3GOz6OgkkltaOkGLtyGUVdJD0e8ZnYcIJVYzZzZHkp9gXMPwKGXAgafVWNiAhP360TGkF16UC426YcTdvSxNFG8gkoxKauWM0l4khCzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kXfAomrv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l/wG3gxhjF3qVAJXj3TrQNp36F85eQrRN0r4xWkhOXc=; b=kXfAomrvKkpoFv6JABftJOvgem
	bdZQp7YuNI5ktKx8nYvooS6JEJmBXzZAOgmN+qU/Uf++S8gtg1BcbYdhKLlb5N4C0lkrGPlBtNWmP
	0QOQCBBtXZploMfns+sUvH2obR85/1vK6f1C1reVrZo2Y5arLo/ZYynCpAWL9G+lo4ciy8uU2dOPb
	ESkzlRzYJNgWQV53Oa6jgH7PT3n0M4i/9nouTHvHBGdshIKDzkNponysKCEp2efx598mcc5Vme0YI
	WmOCAcbvGq5m802LbnHwmPSwaoQXEk5qUV3SJT0+JG+PKUOuv7Yh9wjsVqVbqRNPyTiBjF9htXSev
	VjS1DWKw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlEDk-00000001RAB-46Iw;
	Fri, 15 Mar 2024 20:32:04 +0000
Date: Fri, 15 Mar 2024 13:32:04 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Leah Rumancik <leah.rumancik@gmail.com>, ritesh.list@gmail.com,
	David Woodhouse <dwmw2@infradead.org>,
	Sasha Levin <sashal@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem testing
Message-ID: <ZfSwRI4kbn4fnEoO@bombadil.infradead.org>
References: <CACzhbgQakTF_ahv9HokgnwpW69q8M103w1kmhBBi21ZTkmRTEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzhbgQakTF_ahv9HokgnwpW69q8M103w1kmhBBi21ZTkmRTEA@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Mar 14, 2024 at 08:30:28AM -0700, Leah Rumancik wrote:
> Last year we covered the new process for backporting to XFS. There are
> still remaining pain points: establishing a baseline for new branches
> is time consuming,

It's why I think this needs to be automated, the reality is we have
different test runners and we have users of them for different reasons,
and so collaboration on the automation is done within the realms of
each test runner.

We should discuss however things we could share / colaborate on.
I believe the baseline is one of those things we can probably
collaborate on.

We have one for tmpfs and xfs for v6.8-rc2 on kdevops:

https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/expunges/6.8.0-rc2

Through dialog at previous LSFMMs we have discussed perhaps sharing
results, those are also shared:

https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/results/archive

From a kdevops perspective, the experience is this bloats the tree so
I think this should just be a separate tree, and if you have a path that
exists with it, we copy results to it and push.

Could we share beween different test runners? A directory per each test runner?

I realize that some tests may be private too though, but that does not
preclude us from having public shared results.

> testing resources aren't easy to come by for everyone,

A recurring theme over the last maybe 4-5 LSFMMs.

We have to consider this from those who need or want this. Let's be
frank, enterprise distros already have this well figured out. They've
been doing this for years and they have the experinece and resources
to do it, they just put the focus on their kernels.

That begs the question who needs to be doing serious stable / rc release
testing then?  There are two groups:

  a) kernel filesystem maintainers
  b) consumers of stable kernel

Maintainers can only do what they can, sometimes they don't have enough
time to do it all, as Darrick had mentioned a while ago, it is why the only
way to make things work is to split filesystem maintainer taks into chunks
and hope you can find contributors to help. Otherwise maintainer burn out.
I think the testing requirements for filesystem maintainers then should be
divided and we as a community should help with this effort somehow.

How do we do this? Well you are doing development for a filesystem see
if you company can help with this. We're helping to do some changes on XFS
and tmpfs and so are helping with those. We want to automate that and work
with the community on that. XFS is going to take time and we hope to use
tmpfs as a template for that work.

I recommend we ask the same for other contributors: pick any test runner
for the filesystem you are working on and help lead with the testing.
With either people or hardware. Samsung has helped with both, hardware
and resources. Even if our team is not consumers of stable kernels.  We
help with the latest rc relase baseline for XFS and hope that it is
helpful to XFS stable maintainers. Samsung provides a bare metal server
for interested folks too, even if its not for XFS.  We have asked cloud
providers to help and so far only Oracle has come through on OCI. It
proved *very* important for us as we used it for testing on 64 PAGE_SIZE
systems for some of the testing we did.

So I'd like to ask cloud providers if they can consider allowing
filesystem maintainers to leverage cloud credits to help with testing
filesystems. The testers may not be the maintainer themselves, but
perhaps new developers.

I'd also like to ask if this is a topic that should be discussed with
possible LSFMM sponsors?

Those that fall into camp b) should seriously consider how to help
with the above.

> and selecting appropriate patches is also time consuming.

Although the expectation is that each stable kernel developer
should go through each patch, I hope developers realize that this
is becoming an increasingly difficult task. Sometimes entire complete
areas are re-written and what you knew a few months ago is gone.
So developers working on stable backports need all the help they can
get.

At Linux Plumbers 2023 I asked to help Sasha with automation for the
AUTOSEL setup so other any kernel developer could ramp up with it,
upon review some of the old GPUs needed can be purchased at ebay
today for a raesonable price so that we can get any kernel devloper
who really has the need to help with their own setup.

I'd like to ask again: Sasha, can we get this code up and we document
a way so that any kernel developer can bring up and do their own thing
to help get candidate fixes too?

> To avoid the need to establish a baseline, I'm planning on converting to
> a model in which I only run failed tests on the baseline.

I don't quite follow this. How would you know which tests failed if you
don't have the baseline?

> I test with gce-xfstests and am hoping to automate a relaunch of failed tests.

Kent has previously noted how skipping failed tests is a mistake, I
agree now, but it does not preclude the value in a baseline, or finding
one, or sharing one.

After one has a baseline on can simply re-run test against failed tests always.

> Perhaps putting the logic to process the results and form new ./check
> commands could live in fstests-dev in case it is useful for other
> testing infrastructures.

What would the new check command have as arguments?

> As far as patch selection goes, we should
> consider what the end goal looks like XFS backporting. One potential
> option would be to opt-in for AUTOSEL and for patches that cc stable,
> and use bots to automatically check for regressions on queued up
> patches - this would require a lot more automation work to be done and
> would also depend on the timelines of how long patches are queued
> before merged, how long the tests take to run, etc.

Getting to a sweet spot I think would be to get to the point we have
confidence we can get *some* fstsets patches get tested automatically
tested and results displayed through patchwork.

I hope to get there with tmpfs with kdevops as an initial goal.

> As for testing
> resources, we are still looking for employers to sponsor testing,
> ideally in a way that anyone willing to contribute to stable testing
> can easily gain access to resources for quick ramp-up.

I think we should ask stable consumers for this directly thorugh other
outlets, and other than that, then at LSFMM as contributors to
filesystems to help with this.

  Luis

