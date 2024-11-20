Return-Path: <linux-fsdevel+bounces-35366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6189D43FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549F81F2288A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521301C75E4;
	Wed, 20 Nov 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kMpmUr7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0F1C4A37
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 22:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142370; cv=none; b=VGkk852U4Vrxf+s0Tb6/nMUEvy8bVUMKeabdwj9DQwAjRjkd50i4yz4oiIuYVzToLMK9IsekLx1Z1B0ZHfAeZHjsAwbPM9MA7xzqWSZZxX/tKyb0GuNEMqPVQlzzBmgxu8+8iKZHOm/OrLWNV2YQF6OzzaRNn5k1YTMyBsdt6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142370; c=relaxed/simple;
	bh=bgMH5E7Vvil8Bv1qxkERoJnxSVcPnJjjrH8D/t7UMqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sL9hUakyGA0MsurfUtYb3dQogFDkcts7YDUP2KTGafHa04ZrhpQsmbcvwVfuS2U4coO6YKD88L+yctjUdVN5gLFz/g+dxDb05b00D6jShDdR7wDVn9cNtOjhCx0ecmPYqmGt4HmxU4I2ajHONOK5d/sTc1HrvDkx5Xe/O5RLEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kMpmUr7t; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 17:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732142359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X2/JeZijvoPKUZZfcLuuRPDgYIeN9xurOmrCA6EJFa8=;
	b=kMpmUr7t4bgG7YPKba5Iuk2UD7FPX2bdqFmQPjWPVckFVFA37h44btxWbCc7DnYPBJUIRy
	6perO+IqUOjNupf7rGj6JWeYjy4cSAVUnDL9dOuu2Lo2iKXhN6/uy9w//9u/eOE0HLMVew
	p0SVw4EFbF7TaYVqOAwJeUB8FycwDxo=
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
Message-ID: <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
References: <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 20, 2024 at 03:21:06PM -0700, Shuah Khan wrote:
> On 11/20/24 14:37, Shuah Khan wrote:
> > On 11/20/24 14:20, Kent Overstreet wrote:
> > > On Wed, Nov 20, 2024 at 02:12:12PM -0700, Shuah Khan wrote:
> > > > On 11/20/24 13:34, Kent Overstreet wrote:
> > > > > On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
> > > > > > On 9/2/24 03:51, Kent Overstreet wrote:
> > > > > > > On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > > > > > > > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > > > > > > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > > > > > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > > > > > > > > > [...]
> > > > > > > > > > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > > > > > > > > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > > > > > > > > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > > > > > > > > > something that we can't guarantee won't happen in the wild - we WARN()
> > > > > > > > > > > and try to handle the error as best we can.
> > > > > > > > > > 
> > > > > > > > > > We have discussed that in a different email thread. And I have to say
> > > > > > > > > > that I am not convinced that returning NULL makes a broken code much
> > > > > > > > > > better. Why? Because we can expect that broken NOFAIL users will not have a
> > > > > > > > > > error checking path. Even valid NOFAIL users will not have one because
> > > > > > > > > > they _know_ they do not have a different than retry for ever recovery
> > > > > > > > > > path.
> > > > > > > > > 
> > > > > > > > > You mean where I asked you for a link to the discussion and rationale
> > > > > > > > > you claimed had happened? Still waiting on that
> > > > > > > > 
> > > > > > > > I am not your assistent to be tasked and search through lore archives.
> > > > > > > > Find one if you need that.
> > > > > > > > 
> > > > > > > > Anyway, if you read the email and even tried to understand what is
> > > > > > > > written there rather than immediately started shouting a response then
> > > > > > > > you would have noticed I have put actual arguments here. You are free to
> > > > > > > > disagree with them and lay down your arguments. You have decided to
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > Yeah, enough of this insanity.
> > > > > > > > 
> > > > > > > > so I do not think you are able to do that. Again...
> > > > > > > 
> > > > > > > Michal, if you think crashing processes is an acceptable alternative to
> > > > > > > error handling _you have no business writing kernel code_.
> > > > > > > 
> > > > > > > You have been stridently arguing for one bad idea after another, and
> > > > > > > it's an insult to those of us who do give a shit about writing reliable
> > > > > > > software.
> > > > > > > 
> > > > > > > You're arguing against basic precepts of kernel programming.
> > > > > > > 
> > > > > > > Get your head examined. And get the fuck out of here with this shit.
> > > > > > > 
> > > > > > 
> > > > > > Kent,
> > > > > > 
> > > > > > Using language like this is clearly unacceptable and violates the
> > > > > > Code of Conduct. This type of language doesn't promote respectful
> > > > > > and productive discussions and is detrimental to the health of the
> > > > > > community.
> > > > > > 
> > > > > > You should be well aware that this type of language and personal
> > > > > > attack is a clear violation of the Linux kernel Contributor Covenant
> > > > > > Code of Conduct as outlined in the following:
> > > > > > 
> > > > > > https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> > > > > > 
> > > > > > Refer to the Code of Conduct and refrain from violating the Code of
> > > > > > Conduct in the future.
> > > > > 
> > > > > I believe Michal and I have more or less worked this out privately (and
> > > > > you guys have been copied on that as well).
> > > > 
> > > > Thank you for updating us on the behind the scenes work between you
> > > > and Michal.
> > > > 
> > > > I will make one correction to your statement, "you guys have been copied on
> > > > that as well" - which is inaccurate. You have shared your email exchanges
> > > > with Michal with us to let us know that the issue has been sorted out.
> > > 
> > > That seems to be what I just said.
> > > 
> > > > You might have your reasons and concerns about the direction of the code
> > > > and design that pertains to the discussion in this email thread. You might
> > > > have your reasons for expressing your frustration. However, those need to be
> > > > worked out as separate from this Code of Conduct violation.
> > > > 
> > > > In the case of unacceptable behaviors as defined in the Code of Conduct
> > > > document, the process is to work towards restoring productive and
> > > > respectful discussions. It is reasonable to ask for an apology to help
> > > > us get to the goal as soon as possible.
> > > > 
> > > > I urge you once again to apologize for using language that negatively impacts
> > > > productive discussions.
> > > 
> > > Shuah, I'd be happy to give you that after the discussion I suggested.
> > > Failing that, I urge you to stick to what we agreed to last night.
> The only thing we agreed upon is that you would respond the thread
> to update your sorting things out with Michal.

...Shall I quote you?

> 
> As for the discussion, I will repeat what I said in our conversation
> that the discussion will be lot more productive after making amends
> with the community. I stand by that assessment.
> 
> I will also repeat what I said that the discussion and debate is
> outside the scope of the current issue the Code of Conduct Committee
> is trying to resolve.
> 
> I didn't pick up on your desire to apologize after the discussion in
> our conversation.
> 
> Are you saying you will be happy to make amends with an apology after
> the discussion and debate?

Look, I just want to be done with this, so let me lay it all out as I
see it, starting from the beginning of where things went off the rails
between myself and Michal:

Michal's (as well as Steve's) behaviour in the memory allocation
profiling review process was, in my view, unacceptable (this included
such things as crashing our LSF presentation with ideas they'd come up
with that morning, and persistent dismissive axegrinding on the list).
The project was nearly killed because of his inability to listen to the
reasons for a design and being stubbornly stuck on his right to be heard
as the maintainer.

In my view, being a good maintainer has a lot more to do with
stewardship and leadership, than stubbornly insisting for - whatever
that was. In any event, that was where I came to the conclusion "I just
cannot work that guy".

Next up, PF_MEMALLOC_NORECLAIM over Michal's nack - I was wrong there, I
only did it because it really seemed to me that Michal was axe grinding
against _anything_ I was posting, but I still shouldn't have and that
was more serious infraction in my view; that sort of thing causes a real
loss of trust, and no I will not do it again.

The subsequent PF_MEMALLOC_NORECLAIM discussion was such a trainwreck
that I don't think I will go into it. Except to say that yes, if it
makes you happy, I shouldn't have used that language and I won't do it
again.

But I do have to call out you, the CoC board's behaviour, and I think
that ony fair since you call out other people's behaviour publically.

Greg's behaviour when he approached me at Plumbers was beyond
unprofessional, and since it wasn't exactly public and you guys have
already heard about it privately I won't repeat exactly what happened,
but it is an issue.

Shuah, you weren't much better.

There were concerns raised in the recent CoC enforcement thread, by
someone with experience in such matters, that your aproach seemed
extremeely heavy handed and I find myself in 100% agreement.

The approach you take is that of a bad HR department: all about image,
no understanding. When tensions arise, it's important get to the bottom
of things, to at least try to take the time to listen with an open mind.
People have real frustrations, and it's amazing what you can learn and
what you can accomplish by having real conversations.

But that's not what you guys do: you say "Ok, if someone's being too
much of an asshole, we'll just be an even bigger asshole!".

No. Cut that out.

I've done the hard work of stepping in and building bridges when
relations have broken down (on quite a large scale), so I'm offended by
what you guys do.

