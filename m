Return-Path: <linux-fsdevel+bounces-32263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 727639A2ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 22:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE67B21C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 20:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FF92281EE;
	Thu, 17 Oct 2024 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="THj0SaVX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeTo40iK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07942281D9;
	Thu, 17 Oct 2024 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197502; cv=none; b=PBHKJwUa/JnzkIOBv0eNj5/GN3nRIYElb9LASq8duWK62Shq9i0cEZMWFURY64kP80WLoKlbQsmWMVgTTEqdwOmpcUpd82eW+tf7BUUqtc9OZM4D11PlnpizuGWop4TQ1d9daJMv2sAHW87bWh/HGzkzl5YgtTiv3o89Wv/vsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197502; c=relaxed/simple;
	bh=YuW+XtVKsPQPY8woEj2EXHtU+L0DD9GEK9zl/6iptTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPgBo1IP1WE/yhSptE+2oUQGA5kgpgCTN2wfUutZb3lDJ9ueuy3WnXLMXGjT27bkTiZNsfJdHiBPC/1oeS9Qat7ADtKrGN2JNclwrdGQc/pErgEPeONSxAAHI33KhsrQhIQt8NBNx5WsGVwZDrc4C5nsrkyBUKsKkEy1h61+sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=THj0SaVX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeTo40iK; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F23FD114016A;
	Thu, 17 Oct 2024 16:38:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 17 Oct 2024 16:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1729197498; x=1729283898; bh=qto/GT0HoX
	k1tj2IzlxYMkHo58TNLRqQ9QyZleoivb8=; b=THj0SaVXGdS/4PZXbPbCmflPXY
	vCDQQodb/x8pnX1QgEMxHQgklrXeDpCqVuWh0KnU3z3VRc/vv96A9K7q79Osx3hi
	krqcMmB64h/RD49pYO5YJvavyUrEo5i7fOE2UffX7OW2FVzYj4J5s0YLPAdWfFDx
	jzEd5Q3fMlG3d8CF9R5pxXOyBE4PCANt2X5guWC1617Y/HuSj0E2KMmnH4oXcxRh
	8sZkVCJuXkdFXo60f6DoQDlXpJ1sPeIlqY4wGwMIyDEeqPhkZbse52qdVJWcekM1
	VPOSATud+4aWemaO3EbBed2TIEJzxH+aA0WV0S5ALTDN+MVFrCJd9ZthkaGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729197498; x=1729283898; bh=qto/GT0HoXk1tj2IzlxYMkHo58TN
	LRqQ9QyZleoivb8=; b=eeTo40iK0JRaW3XGdDv+XFsCho+d2VJmfkM3Qf+dG6sH
	DvG4WmkqIHIjjmENZymz7RbJIJxD58/epvIFg9vdF/eWuG+SQKZgfF6cpkPndlhK
	rfhCxFX9RE5y1Oa/kN7ZsIXsl7rjqQK3F29IJ4+OTH+YvJmpa6uVBqeGb9R3+C8J
	IeglPUQaEozGS6wUfhWgDm4qSHNoq3XCU1z6LP5jOlLwaUw6NWIvQ6W2fiG1jmBC
	m7J4rKVH4hmuf6lNm8fEOowr759zAX/P95D+kwmQNUlAmCiTAQGs7Cc7o7LBcqxm
	3T6UVQMaJTzIz7dO8v6w5TSDAOKVdxclb7/QEKjB7Q==
X-ME-Sender: <xms:uXURZ7obkQO9HElk4m0Y42Ik9Qs7hlkGw-qaGHx68EfNx25nxsBFgg>
    <xme:uXURZ1oGIAcc2-UTixpyLmNoo6NOiUqF7TzP8Wxw4ytqV4RInIQe2GmbTWWgObf-4
    ISzf0s30PUTIaOUXrY>
X-ME-Received: <xmr:uXURZ4Por6z0uUfMbEXq1ZKV6oVZOfTkmPTduIIlzzOObLonlNCXXUY3WBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhord
    hpihiiiigrqeenucggtffrrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieef
    udelgeejuddtfeffteeklefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigrpdhnsggprhgt
    phhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgvvghssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopeiisgihshiivghksehinhdrfigrfidrphhlpdhr
    tghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhope
    hvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsghrrghu
    nhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:unURZ-4dc8mo-70QPG8ELPBbMIBFKagZRNBRmjk_WHRkobs5QYrfvA>
    <xmx:unURZ65Wk2qi_gKcoWHH_aLs2npLMx1kaJp8uXEo8osA1ZIy-nzRzQ>
    <xmx:unURZ2jY6g1S9yKFSj6xt4EWukLIejAMFOuPMwyuIKKMVxJUShg-UA>
    <xmx:unURZ84l6Q2BS-hgh4jYkHnP3SHw0t12lwEebuBBb2qfewbjabf9TA>
    <xmx:unURZ5SfZHtNAvbqpVwicQZuTgN-jjqJW9Sf70hqOyJ9oXDUbbYWF9xS>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 16:38:15 -0400 (EDT)
Date: Thu, 17 Oct 2024 14:38:13 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <kees@kernel.org>
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZxF1te/scxC/uOIr@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
 <ZwaWG/ult2P7HR5A@tycho.pizza>
 <202410141403.D8B6671@keescook>
 <ZxEgg+CEnvIHJJ4q@tycho.pizza>
 <202410170840.8E974776@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410170840.8E974776@keescook>

On Thu, Oct 17, 2024 at 08:47:03AM -0700, Kees Cook wrote:
> On Thu, Oct 17, 2024 at 08:34:43AM -0600, Tycho Andersen wrote:
> > On Mon, Oct 14, 2024 at 02:13:32PM -0700, Kees Cook wrote:
> > > On Wed, Oct 09, 2024 at 08:41:31AM -0600, Tycho Andersen wrote:
> > > > +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> > > > +{
> > > > +	const char __user *p = get_user_arg_ptr(argv, 0);
> > > > +
> > > > +	/*
> > > > +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> > > > +	 * => "" for comm.
> > > > +	 */
> > > > +	if (!p) {
> > > > +		bprm->argv0 = kstrdup("", GFP_KERNEL);
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> > > > +	if (bprm->argv0)
> > > > +		return 0;
> > > > +
> > > > +	return -EFAULT;
> > > > +}
> > > 
> > > I'd rather this logic got done in copy_strings() and to avoid duplicating
> > > a copy for all exec users. I think it should be possible to just do
> > > this, to find the __user char *:
> > > 
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 77364806b48d..e12fd706f577 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -642,6 +642,8 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
> > >  				goto out;
> > >  			}
> > >  		}
> > > +		if (argc == 0)
> > > +			bprm->argv0 = str;
> > >  	}
> > >  	ret = 0;
> > >  out:
> > 
> > Isn't str here a __user? We want a kernel string for setting comm, so
> > I guess kaddr+offset? But that's not mapped any more...
> 
> Yes, but it'll be valid __user addr in the new process. (IIUC)

Yes, it's valid, but we need a kernel pointer for __set_task_comm().

> > > Once we get to begin_new_exec(), only if we need to do the work (fdpath
> > > set), then we can do the strndup_user() instead of making every exec
> > > hold a copy regardless of whether it will be needed.
> > 
> > What happens if that allocation fails? begin_new_exec() says it is the
> > point of no return, so we would just swallow the exec? Or have
> > mysteriously inconsistent behavior?
> 
> If we can't alloc a string in begin_new_exec() we're going to have much
> later problems, so yeah, I'm fine with it failing there.

Ok, cool. But with your notes below, the allocation will still be
before begin_new_execexit(), just only in the cases where we actually
need it, hopefully that's okay.

> > +static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
> > +{
> > +	const char __user *p = get_user_arg_ptr(argv, 0);
> 
> To keep this const but not call get_user_arg_ptr() before the fdpath
> check, how about externalizing it. See further below...
> 
> > +
> > +	/*
> > +	 * If this isn't an execveat(), we don't need to fix up the command.
> > +	 */
> > +	if (!bprm->fdpath)
> > +		return 0;
> > +
> > +	/*
> > +	 * In keeping with the logic in do_execveat_common(), we say p == NULL
> > +	 * => "" for comm.
> > +	 */
> > +	if (!p) {
> > +		bprm->argv0 = kstrdup("", GFP_KERNEL);
> 
> Do we want an empty argv0, though? Shouldn't an empty fall back to
> fdpath?

Yes, sounds good.

> > +		return 0;
> > +	}
> > +
> > +	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
> > +	if (bprm->argv0)
> > +		return 0;
> > +
> > +	return -EFAULT;
> > +}
> > +
> >  static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
> >  {
> >  	struct linux_binprm *bprm;
> > @@ -1975,6 +2011,10 @@ static int do_execveat_common(int fd, struct filename *filename,
> >  		goto out_ret;
> >  	}
> >  
> > +	retval = bprm_add_fixup_comm(bprm, argv);
> > +	if (retval != 0)
> > +		goto out_free;
> 
> How about:
> 
> 	if (unlikely(bprm->fdpath)) {
> 		retval = bprm_add_fixup_comm(bprm, argv);
> 		if (retval != 0)
> 			goto out_free;
> 	}
> 
> with the fdpath removed from bprm_add_fixup_comm()?

Yep, this is much clearer, thanks. I will respin with these as a Real
Patch.

Tycho

