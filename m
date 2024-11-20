Return-Path: <linux-fsdevel+bounces-35359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C40269D4322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 21:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A05C284082
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 20:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A861BC9EC;
	Wed, 20 Nov 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pnI+EEGl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83419DF9E;
	Wed, 20 Nov 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732134908; cv=none; b=FhnctUomoSyWYqPljs847pZV9uqkM8Yi0rsbtOuQk8b3W3DHj7ljutH4+uoXQfuN6/7vKlKZasokfvr6BjludGHG0oaJiknpuI9BgrG7gawZ+8b3Xui+g6yFcags3Ixg2Ni8wGxDn9mYk3vxVlDr52AosNBIf3pZmOoIB/BhR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732134908; c=relaxed/simple;
	bh=uP+4cHO366V2spfKKNrpgRZGlPEqi3vENjFya9i5q5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCWC8v0dwnBJAHl0drolU4t6qZRl/vzjuRsJ9fJufadDCJLMG6yhOHokDWM8xOzqY9W5P9YwZWEPBVrdlp5DXzq9QAZ2nvLYZbkxXD6ywt6d8CEAvZhK9Lpj1uoV24X5sNXFL6IbnL+BwO2m5+xbZhgjVoVdJcLTzKpr1kfuZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pnI+EEGl; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Nov 2024 15:34:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732134903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mQ+UldOQJ74hVwhBLO/PFZ3KBYaMQ8Efc5gouRStEtk=;
	b=pnI+EEGlgdXuiT/E/nI52ES+/DEYsd/ShG8CrVHdMOp4CbvYsrIznozRFsYRKEkFbFHwen
	nlni0gcGsp7UISAyLpJnog8UEF3vpy8kmcqezi15rH+CmYbMl1CNLMgcYcV6Bo3Ia7ZtGS
	91ZjuEbZEW8q8lkNMpJ80YZ0UMeXYtU=
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
Message-ID: <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
References: <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
 <ZtUFaq3vD+zo0gfC@dread.disaster.area>
 <nawltogcoffous3zv4kd2eerrrwhihbulz7pi2qyfjvslp6g3f@j3qkqftra2qm>
 <ZtV6OwlFRu4ZEuSG@tiehlicka>
 <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Sep 04, 2024 at 12:01:50PM -0600, Shuah Khan wrote:
> On 9/2/24 03:51, Kent Overstreet wrote:
> > On Mon, Sep 02, 2024 at 11:39:41AM GMT, Michal Hocko wrote:
> > > On Mon 02-09-24 04:52:49, Kent Overstreet wrote:
> > > > On Mon, Sep 02, 2024 at 10:41:31AM GMT, Michal Hocko wrote:
> > > > > On Sun 01-09-24 21:35:30, Kent Overstreet wrote:
> > > > > [...]
> > > > > > But I am saying that kmalloc(__GFP_NOFAIL) _should_ fail and return NULL
> > > > > > in the case of bugs, because that's going to be an improvement w.r.t.
> > > > > > system robustness, in exactly the same way we don't use BUG_ON() if it's
> > > > > > something that we can't guarantee won't happen in the wild - we WARN()
> > > > > > and try to handle the error as best we can.
> > > > > 
> > > > > We have discussed that in a different email thread. And I have to say
> > > > > that I am not convinced that returning NULL makes a broken code much
> > > > > better. Why? Because we can expect that broken NOFAIL users will not have a
> > > > > error checking path. Even valid NOFAIL users will not have one because
> > > > > they _know_ they do not have a different than retry for ever recovery
> > > > > path.
> > > > 
> > > > You mean where I asked you for a link to the discussion and rationale
> > > > you claimed had happened? Still waiting on that
> > > 
> > > I am not your assistent to be tasked and search through lore archives.
> > > Find one if you need that.
> > > 
> > > Anyway, if you read the email and even tried to understand what is
> > > written there rather than immediately started shouting a response then
> > > you would have noticed I have put actual arguments here. You are free to
> > > disagree with them and lay down your arguments. You have decided to
> > > 
> > > [...]
> > > 
> > > > Yeah, enough of this insanity.
> > > 
> > > so I do not think you are able to do that. Again...
> > 
> > Michal, if you think crashing processes is an acceptable alternative to
> > error handling _you have no business writing kernel code_.
> > 
> > You have been stridently arguing for one bad idea after another, and
> > it's an insult to those of us who do give a shit about writing reliable
> > software.
> > 
> > You're arguing against basic precepts of kernel programming.
> > 
> > Get your head examined. And get the fuck out of here with this shit.
> > 
> 
> Kent,
> 
> Using language like this is clearly unacceptable and violates the
> Code of Conduct. This type of language doesn't promote respectful
> and productive discussions and is detrimental to the health of the
> community.
> 
> You should be well aware that this type of language and personal
> attack is a clear violation of the Linux kernel Contributor Covenant
> Code of Conduct as outlined in the following:
> 
> https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> 
> Refer to the Code of Conduct and refrain from violating the Code of
> Conduct in the future.

I believe Michal and I have more or less worked this out privately (and
you guys have been copied on that as well).

