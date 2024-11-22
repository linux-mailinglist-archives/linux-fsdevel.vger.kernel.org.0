Return-Path: <linux-fsdevel+bounces-35610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2C9D6581
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C560160F6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC0518BC13;
	Fri, 22 Nov 2024 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TJjYLcuE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A9176AAE
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732312933; cv=none; b=bNxjDGUvmLcbXRHFMvquKBFpK+/34T8+9WC25bf20NF9Crtk+JQx5QKOm59tiAfB5GTuYJUxQ7GaPVcTUCYUlB109lXlXIRvYFpIdbntzkOf9KkaQZXAhgjLnZj64uEGB6AzVkUDOvgWWCnfLNsW+3LcqyQY4p12GLYX2lPq9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732312933; c=relaxed/simple;
	bh=3GYeIrBV2AhviVYKCufI9HReuGgZ8/tGhXDP17TkM1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSCWBua3qwbsFWPRKE5fn6XSifwmMamoVNmOjMKVW99BcA05Glro/9qZ73e6WfFgQGzRnA/PnlYfCDOov+HbT0+02o7IC7FQW81Qnf0CtfSlfra43DNbbEdZcu1Yg9ssALLGb16JlWI2fWSUHYiyoaIBy/ur62zf2lvxVP2NqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TJjYLcuE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Nov 2024 17:02:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732312927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7GPdysU3+ulwwEZym2gbb4LV2XNAsMZyaMxjoxUdvB0=;
	b=TJjYLcuEehU9rXjjANl641dzAmpdwyRVnPXBAD3hi93j7iO70q+kZM0cRhqXky8BYbwpzs
	vNEt9DhzO6PHrmTnqLmq6uLj7B800wnZRup6/7nRZjkbm6jQV3gSwa6p8+IMuVzdg442sz
	uRH30CxPY04qAHyFUmghkytqv+J0G78=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, maintainers@linux.kernel.org
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <o5tbrrk4r3sxtvk7tjyua5h2qaa3fos7446dkxbjyxjwhp4odd@we5elwaeb7dv>
References: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <6740fc3aabec0_5eb129497@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6740fc3aabec0_5eb129497@dwillia2-xfh.jf.intel.com.notmuch>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 22, 2024 at 01:48:42PM -0800, Dan Williams wrote:
> Kent Overstreet wrote:
> > On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> [..]
> 
> Kent,
> 
> The Code of Conduct Committee received reports about your conduct in
> this email discussion.
> 
> Link to email where the violation took place:
> 
> https://lore.kernel.org/citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk
> 
> Our community works on trust and respect and has agreed to abide by the
> Code of Conduct:
> 
> Reference: https://docs.kernel.org/process/code-of-conduct.html
> 
> The code of Conduct Committee has determined that your written abuse
> of another community member required action on your part to repair the
> damage to the individual and the community. You took insufficient action
> to restore the community's faith in having otherwise productive technical
> discussions without the fear of personal attacks.
> 
> Following the Code of Conduct Interpretation process the TAB has approved
> has approved the following recommendation:
> 
> -- Restrict Kent Overstreet's participation in the kernel development
>    process during the Linux 6.13 kernel development cycle.
> 
>        - Scope: Decline all pull requests from Kent Overstreet during
>          the Linux 6.13 kernel development cycle.

Ok.

Just to be clear on what this is about though, I'm going to post
publically what I wrote Michal back in September.

This is about a CoC board that on the one hand, doesn't wish to follow
its own rules, and on the other - I can't even make sense of.

From kent.overstreet@linux.dev Wed Sep  4 14:22:39 2024
Date: Wed, 4 Sep 2024 14:22:39 -0400
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <5qukfetlxkadrdjp443xlzbyjhw26l3zzgcdlmfkxgbkpkrv65@hobl73hoc5ip>
References: <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtWH3SkiIEed4NDc@tiehlicka>
Status: RO
Content-Length: 4224
Lines: 88

On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > > [...]
> > > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > > something that we can't guarantee won't happen in the wild - we WARN()
> > > > and try to handle the error as best we can.
> > > 
> > > We have discussed that in a different email thread. And I have to say
> > > that I am not convinced that returning NULL makes a broken code much
> > > better. Why? Because we can expect that broken NOFAIL users will not have a
> > > error checking path. Even valid NOFAIL users will not have one because
> > > they _know_ they do not have a different than retry for ever recovery
> > > path. 
> > 
> > You mean where I asked you for a link to the discussion and rationale
> > you claimed had happened? Still waiting on that
> 
> I am not your assistent to be tasked and search through lore archives.
> Find one if you need that.
> 
> Anyway, if you read the email and even tried to understand what is
> written there rather than immediately started shouting a response then
> you would have noticed I have put actual arguments here. You are free to
> disagree with them and lay down your arguments. You have decided to
> 
> [...]
> 
> > Yeah, enough of this insanity.
> 
> so I do not think you are able to do that. Again...

BTW - (after getting emails for three different people about this, heh)

I do want to apologize for things getting this heated the other day, but
I need to also tell you why I reacted the way I did.

Firstly, it's nothing personal: I'm not axe grinding against you
(although you were a major source of frustration for myself and Suren in
the memory allocation profiling discussions, and I hope you can
recognize that as well).

But I do take correctness issues very seriously, and I will get frosty
or genuinely angry if they're being ignored or brushed aside.

The reality as that experience, and to be frank standards of
professionalism, do vary within the kernel community, and I have had
some _outrageous_ fights over things as bad as silent data corruption
bugs (introduced in code I wrote by people who did not CC me, no less;
it was _bad_, and yes it has happened more than once). So - I am _not_
inclined to let things slide, even if it means being the asshole at
times.

Thankfully, most people aren't like that. Dave, Willy, Linus - we can be
shouting at each other, but we still listen, and we know how not to take
it personally and focus on the technical when there's something serious
going on.

Usually when one of us is shouting, you'll find there's a good reason
and some history behind it, even if we also recognize the need to try to
tone things down and not be _too_ much of an asshole. Linus was
reminding me of that yesterday...

So for the record: I'm not trying to roadblock you or anyone else, I'm
just trying to make sure we all have shit that _works_.

And I have been noticing you stepping up in discussions more, and I'd
like to encourage that, if I may. MM has been lacking in strong
technical leadership for a _long_ time - Andrew's great on the process
side, he makes sure things move along, but we haven't had anyone who's
trying to keep everything important in their heads, who's able to point
out to people where their work fits in the larger picture, and there's
been some messy things that have built up over time.

And a word on technical leadership - it doesn't mean being the one who's
"right" all the time, although it does involve a lot of saying "no" to
people. The people who seem the smartest - it's not raw IQ that they've
got (although that helps!), it's the ability to listen and quickly
incorporate other people's ideas without drama or attachment, and the
ability to maintain perspective; notice what people are blocked on,
without getting stuck on it, and think about how it fits into the wider
perspective.

Cheers,
Kent

