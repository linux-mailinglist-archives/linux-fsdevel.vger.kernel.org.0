Return-Path: <linux-fsdevel+bounces-35362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA8A9D4375
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 22:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB51283012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 21:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7FA1C1F11;
	Wed, 20 Nov 2024 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XcEBO3Bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609231A3AB1
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 21:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732137614; cv=none; b=HeSOOugAOPg2DJSOA0ncQCUNAclqst3waAMAT0JDmhMpuFR0tPU2NbjbRfsjPVv2EGdAqgD7QhvDVH6TO5YvgfwNqTVRv1NLKEBLW7d32pdtTk+U0W+zbAqXbT2lshXwWaKB1sGxq3eEakWRGrXkyzii+0KMx/ETgCDT6uFo8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732137614; c=relaxed/simple;
	bh=ygHzeKyL0SvAgE6Cj96tfTz7qSOaczxSJ6NVDVZfFmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHj+o5mDYbh2bl8Ir3NgSKLx2GLfHl/Q1IZEyum4+7i3KQPE59puBC617DPVAYT+puk856V+PQmyerOr8tqGDT39IHsBfH9UzRkv3dUol3dudQUjlttoA3sMpXmKgNbzw+8hcVkMQeDGoLSpKqdpRIRL2lKkaeFzH4+7FO2aERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XcEBO3Bz; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 16:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732137610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MK7Yw13rIPAR5mXF8jT4hgAQAmxv6k0/U0gtqc/SGbE=;
	b=XcEBO3BzCSx7AHhL9v/iGMOfgQ/Gkv5yqDMeO5LS0VgHj9PiFQPJbX5bKxpmIwstoRIgF7
	7YTt9ibeyAobYGlgyhKU8hl1BZ+YwYRglYuO6FeIqDsEdGnDkZbVPgsxPPnYZg/fN4UegY
	0Lk8vOwYMtA/cq7HF3t0VDqIg8loWvM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"conduct@kernel.org" <conduct@kernel.org>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
References: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 02:12:12PM -0700, Shuah Khan wrote:
> On 11/20/24 13:34, Kent Overstreet wrote:
> > On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
> > > On 9/2/24 03:51, Kent Overstreet wrote:
> > > > On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > > > > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > > > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > > > > > > [...]
> > > > > > > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > > > > > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > > > > > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > > > > > > something that we can't guarantee won't happen in the wild - we WARN()
> > > > > > > > and try to handle the error as best we can.
> > > > > > > 
> > > > > > > We have discussed that in a different email thread. And I have to say
> > > > > > > that I am not convinced that returning NULL makes a broken code much
> > > > > > > better. Why? Because we can expect that broken NOFAIL users will not have a
> > > > > > > error checking path. Even valid NOFAIL users will not have one because
> > > > > > > they _know_ they do not have a different than retry for ever recovery
> > > > > > > path.
> > > > > > 
> > > > > > You mean where I asked you for a link to the discussion and rationale
> > > > > > you claimed had happened? Still waiting on that
> > > > > 
> > > > > I am not your assistent to be tasked and search through lore archives.
> > > > > Find one if you need that.
> > > > > 
> > > > > Anyway, if you read the email and even tried to understand what is
> > > > > written there rather than immediately started shouting a response then
> > > > > you would have noticed I have put actual arguments here. You are free to
> > > > > disagree with them and lay down your arguments. You have decided to
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > Yeah, enough of this insanity.
> > > > > 
> > > > > so I do not think you are able to do that. Again...
> > > > 
> > > > Michal, if you think crashing processes is an acceptable alternative to
> > > > error handling _you have no business writing kernel code_.
> > > > 
> > > > You have been stridently arguing for one bad idea after another, and
> > > > it's an insult to those of us who do give a shit about writing reliable
> > > > software.
> > > > 
> > > > You're arguing against basic precepts of kernel programming.
> > > > 
> > > > Get your head examined. And get the fuck out of here with this shit.
> > > > 
> > > 
> > > Kent,
> > > 
> > > Using language like this is clearly unacceptable and violates the
> > > Code of Conduct. This type of language doesn't promote respectful
> > > and productive discussions and is detrimental to the health of the
> > > community.
> > > 
> > > You should be well aware that this type of language and personal
> > > attack is a clear violation of the Linux kernel Contributor Covenant
> > > Code of Conduct as outlined in the following:
> > > 
> > > https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> > > 
> > > Refer to the Code of Conduct and refrain from violating the Code of
> > > Conduct in the future.
> > 
> > I believe Michal and I have more or less worked this out privately (and
> > you guys have been copied on that as well).
> 
> Thank you for updating us on the behind the scenes work between you
> and Michal.
> 
> I will make one correction to your statement, "you guys have been copied on
> that as well" - which is inaccurate. You have shared your email exchanges
> with Michal with us to let us know that the issue has been sorted out.

That seems to be what I just said.

> You might have your reasons and concerns about the direction of the code
> and design that pertains to the discussion in this email thread. You might
> have your reasons for expressing your frustration. However, those need to be
> worked out as separate from this Code of Conduct violation.
> 
> In the case of unacceptable behaviors as defined in the Code of Conduct
> document, the process is to work towards restoring productive and
> respectful discussions. It is reasonable to ask for an apology to help
> us get to the goal as soon as possible.
> 
> I urge you once again to apologize for using language that negatively impacts
> productive discussions.

Shuah, I'd be happy to give you that after the discussion I suggested.
Failing that, I urge you to stick to what we agreed to last night.

