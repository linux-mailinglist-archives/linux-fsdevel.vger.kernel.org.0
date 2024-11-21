Return-Path: <linux-fsdevel+bounces-35397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E34F9D4976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 10:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C36F1F21CD4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7196B15573D;
	Thu, 21 Nov 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HiOO3Ibu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43A1C9DD3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179838; cv=none; b=qp6kOOlPvOCNy/41vvalcSRP8CTvmvjEZGUTXErd5PfDpwnnu95s3Vad1hSVGby11S2OtXylAvd5R+XWN14ACzs9lFkrTu2O8TNVMtvSnWa7+0qpvh11EmSOSFoNvbAIwjD6Y6ORdKJx+fZgaA6hSgBUkGUq3zIkuSLvxDhOhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179838; c=relaxed/simple;
	bh=gB3nR5R4h8gsTpxvHF/nfyuNGADmt8PUmyGd/Q0jLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKyEbtH6Kg8gIWa0oQ6gsSHC2CKaCILXg+WnY28gCwfppQN9ZpHz7ikz/AEs3i19pq0S0dSCkDzzTFiVxrtQvNzNnAB+pXaHoJJlg/d8gU29eWpbxxb4P9yAJnrzGsi+DlzUCv2vTQWFnFa0f5nQGfo6pZuxUkiK+xxIEpT93UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HiOO3Ibu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Nov 2024 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732179833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRLw+DGKdwBq59yleVzq1+0cEo5aRODfgmqZBbkpOO8=;
	b=HiOO3Ibumb6pS42WpgNsTAOgm0t1JNKUQXlVy4TDWQpC6qMR5Mu2auqGAp/9UcRs4mpQqg
	BTWLfzZkEJLvYUAnXH3M3QzIZgaLoNBtZfZU53hBdNRFeHRYX2v0Ve7bDDqF0uCtR1qI3I
	NG98hydgjDXFeWfNtktWDltia42/XJ0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, 
	Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "conduct@kernel.org" <conduct@kernel.org>
Subject: Re: review process (was: underalated stuff)
Message-ID: <nfui5woq5n4lc4xggsflvjqr3gmukfzo64ejxrg4o6iq6ud4ju@rctq63kb43wb>
References: <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
 <Zz7yqeI0RatH4ao5@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz7yqeI0RatH4ao5@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 21, 2024 at 09:43:21AM +0100, Michal Hocko wrote:
> On Wed 20-11-24 17:39:09, Kent Overstreet wrote:
> > Michal's (as well as Steve's) behaviour in the memory allocation
> > profiling review process was, in my view, unacceptable (this included
> > such things as crashing our LSF presentation with ideas they'd come up
> > with that morning, and persistent dismissive axegrinding on the list).
> > The project was nearly killed because of his inability to listen to the
> > reasons for a design and being stubbornly stuck on his right to be heard
> > as the maintainer.
> 
> Couple of entry points that might be helful for that.
> https://lore.kernel.org/all/YxBc1xuGbB36f8zC@dhcp22.suse.cz/
> I have expressed my concerns and set expectations to move the
> work forward. I've had couple of back and forth with Suren about
> specifics of overhead assumptions from the stack unwinding IIRC. 
> 
> For the first non-RFC version my feedback was
> https://lore.kernel.org/all/ZFIMaflxeHS3uR%2FA@dhcp22.suse.cz/#t
> not really "maintenance burden only" but a request to show that alternative
> approaches have been explored. It was not particularly helpful that you
> had expected tracing people would implement the feature for you.
> https://lore.kernel.org/all/20230503092128.1a120845@gandalf.local.home/
> Other people have also expressed that this is not completely impossible
> https://lore.kernel.org/all/ZFKNZZwC8EUbOLMv@slm.duckdns.org/
> The rest of the email thread is mostly a combat zone that I have avoided
> participating as much as possible.
> 
> I didn't have any reaction to v2 at all.
> 
> v3 was aiming to be merged and I've stepped up as there was no single
> review at the time https://lore.kernel.org/all/Zctfa2DvmlTYSfe8@tiehlicka/
> 
> I admit that I was really open that I do not like the solution and I've
> said reasons for that. Allocator APIs have always been a large mess of
> macros, static inlines that makes it really far from free to maintain
> and alternative ways should be considered before going that route.
> 
> I was also clear that support by MM people was necessary to get this
> merged. I have explicitly _not_ NAKed the series and backed off for you
> guys to gain that support. 
> 
> So essentially there was a clear outline for you and Sure how to achieve
> that.
> 
> I would really like to hear from other maintainers. Is tnis really
> unacceptable maintainer behavior? I am OK to apologize but the above is
> in line of my understanding of how to ack properly.

I wonder if I was reading too much into what you were saying in the
off-list thread, when I said "argument to authority". Can you tell me if
this might be closer to the mark?

If I read you correctly, when you said you were "voicing your concerns",
I took it as you being pushy because that was the effects: I need you to
take me at my word, because you didn't see everything behind the scenes,
that this did derail and nearly kill the project.

But I should've been taking you at your word, that you just really were
that concerned.

I think the best way I can explain this issue is with an analogy to
parenting: when we're parenting, our first and foremost job isn't really
to make sure there's a roof, shelter, food - that part is easy in
today's world. The main job really is to make sure that people feel
safe, that they can go out and explore the world without being
terrified.

In order to do that, we have to master our own fears, we can't be
projecting them all the time.

Being a maintainer, or any kind of leader, is the exact same thing. My
big lesson on this was watching Andrew, back during the process of
merging MGLRU - I couldn't believe at the time how chill he was about
it. But he understood the process, and he's a master at this.

Part of mastering our fears in a group setting like this is learning to
trust other people.

It's not that your concerns didn't have any validity - but we were
already doing as much as we could to address them, and you didn't show
any trust that we, I especially, knew what we were doing. And that led
to a _lot_ of wasted effort down blind alleys that I already knew
weren't going to work.

I think that may be what this is really about, sometimes you do have to
trust that people know what they're doing; you share your knowledge if
you have knowledge to share, otherwise you have to back off and let
people do their work. Otherwise the whole thing breaks down and no one
can get anything done.

The main thing is I just want to ask yourself if you could have done
anything better in the memory allocation profiling process. I don't need
you to apologize for anything specific, if you can just try to work
better together in the future that's all I need.

