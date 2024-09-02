Return-Path: <linux-fsdevel+bounces-28193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF0967CF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 02:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA48B21189
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 00:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C6E23D2;
	Mon,  2 Sep 2024 00:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XLFWQD9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87C1362
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Sep 2024 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725236594; cv=none; b=itzjmgOCWXzlquDLGjEHOwqnFPyrIxdWeW1xKxoEyIX1XXkm1rNLwrLVTXR0VBzLtuEy75thNtk+G7JcGzhQ4axgT3xOJYuVhSbMObMsE2srQxKEngDCI1NWJEu0xIDu7c1Bq4TYLwNABJ9tSF+kmV2uDkwjwOYr7k7aXGFIsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725236594; c=relaxed/simple;
	bh=ftsChIajtnjiEY4W1EokqCIHqjRaowDhfKBGDOQSvrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJer9XV87op5Or/ycGoYMRZ7ZNel3U5vE5PM81A4wWfmqSB5bldpX9LJYoxJuh2tRY2/BXDslWHOh+9+zRBfdCY9wfc3WQDtP1tg/w8WntEVddkDjYpKwdBpn7zf6qhkymnaBJMPF8gqC0k9BxIMmcFQEahns/qxIUBCVxYdX9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XLFWQD9Y; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2055f630934so6082865ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Sep 2024 17:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1725236592; x=1725841392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhqs0bk6d9S5HsDrmArNIV2Xe+dvZuUuEesqnip3xnw=;
        b=XLFWQD9Y7cVsHRJHpdRI3DQZr6GScA/FBUEVrip+MWhtIyeDOhbUg5sPO92qMAPsCi
         pqsdTJXRKpD+pKG0fcqDBmkvzPCxfYqTCD0q1+jjEyZ0EDWyqPnvxbxaZL/Fa1A3XKgL
         T2SpEH2tY01y5C/fXbFsad0OzklXkv9P2tFmmAjh4ZwsqOXt6NV0uVRZnqB/QH9PTSyu
         snlqxM0Lu8DbGw6xiH+OV3aum0AOeMC05wDGGym8nkEKT/7iNmPSA7ddDOIqkUW9ukEf
         efCoK1BK4M8QOQyqVwLepdMYue5P49fTza08SL4o7KfteUKAXKnkP2++RyF3c6Nxnnjd
         IlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725236592; x=1725841392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhqs0bk6d9S5HsDrmArNIV2Xe+dvZuUuEesqnip3xnw=;
        b=DgYsFqahFc0SCNSMAm+QqHmbdQHGXmxcd8raaSu7bGX/fdMtrL4mXhGcFW2nLFhX6k
         FGl1SaQPDWp/jWvrXUJQGFlay22O1ptgLP0gNV4OGVIvG30WbIn7Zz6TE1AehIsBasvM
         IIOSuKjHMshlRhBCzla+v8bbcTAqduiMCMD68fzuEF23uGRrC45MQXy7W6QFSa/25a09
         bb7d+eGtSM/tpUit0Pd9lNLweeLoTgmewSrvlf91HgfjP3Bjd/P/vecNjHYlMq9Hdrmw
         oNbFV8H3CVXE8g0fNFO58L8YpROwGHK166NkT94em+VzEYausYNQrmOJwThe8pC2MyUB
         lnvw==
X-Forwarded-Encrypted: i=1; AJvYcCXjQp3hrloxCZ9RqPvIOgfizp+HK4M6UFUo1RkwU+bLTJTo404eeqrUvwFlzg0Y63ME+aNQhYNhtNxf6pYE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk3+EEUARQQJbW7eszruDrLS4hdlOcPYUGNNRg/a9vSi/jZESe
	//tt3G+pnQiKMsGZYkEm0HlSiF06Oy1XHgmaxB+b3v/E/tuC/KEfIl0HU9Je/bY=
X-Google-Smtp-Source: AGHT+IFRxrSJ1BBY5OuRyDWH7Zkmz+B6jgDrpNHwq/EefJqvo4wp7Md0fkFcX+xGE4CcKlFaebxTFg==
X-Received: by 2002:a17:903:22c1:b0:205:874d:6a7d with SMTP id d9443c01a7336-205874d6d4fmr4432265ad.12.1725236591522;
        Sun, 01 Sep 2024 17:23:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205456242fesm27156995ad.53.2024.09.01.17.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 17:23:10 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1skuqZ-003S7A-01;
	Mon, 02 Sep 2024 10:23:07 +1000
Date: Mon, 2 Sep 2024 10:23:06 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2 v2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <ZtUFaq3vD+zo0gfC@dread.disaster.area>
References: <20240826085347.1152675-2-mhocko@kernel.org>
 <20240827061543.1235703-1-mhocko@kernel.org>
 <Zs6jFb953AR2Raec@dread.disaster.area>
 <ylycajqc6yx633f4sh5g3mdbco7zrjdc5bg267sox2js6ok4qb@7j7zut5drbyy>
 <ZtBzstXltxowPOhR@dread.disaster.area>
 <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <myb6fw5v2l2byxn4raxlaqozwfdpezdmn3mnacry3y2qxmdxtl@bxbsf4v4qbmg>

On Thu, Aug 29, 2024 at 09:32:52AM -0400, Kent Overstreet wrote:
> On Thu, Aug 29, 2024 at 11:12:18PM GMT, Dave Chinner wrote:
> > On Thu, Aug 29, 2024 at 06:02:32AM -0400, Kent Overstreet wrote:
> > > On Wed, Aug 28, 2024 at 02:09:57PM GMT, Dave Chinner wrote:
> > > > On Tue, Aug 27, 2024 at 08:15:43AM +0200, Michal Hocko
> > > > wrote:
> > > > > From: Michal Hocko <mhocko@suse.com>
> > > > > 
> > > > > bch2_new_inode relies on PF_MEMALLOC_NORECLAIM to try to
> > > > > allocate a new inode to achieve GFP_NOWAIT semantic while
> > > > > holding locks. If this allocation fails it will drop locks
> > > > > and use GFP_NOFS allocation context.
> > > > > 
> > > > > We would like to drop PF_MEMALLOC_NORECLAIM because it is
> > > > > really dangerous to use if the caller doesn't control the
> > > > > full call chain with this flag set. E.g. if any of the
> > > > > function down the chain needed GFP_NOFAIL request the
> > > > > PF_MEMALLOC_NORECLAIM would override this and cause
> > > > > unexpected failure.
> > > > > 
> > > > > While this is not the case in this particular case using
> > > > > the scoped gfp semantic is not really needed bacause we
> > > > > can easily pus the allocation context down the chain
> > > > > without too much clutter.
> > > > > 
> > > > > Acked-by: Christoph Hellwig <hch@lst.de> Signed-off-by:
> > > > > Michal Hocko <mhocko@suse.com>
> > > > 
> > > > Looks good to me.
> > > > 
> > > > Reviewed-by: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Reposting what I wrote in the other thread:
> > 
> > I've read the thread. I've heard what you have had to say. Like
> > several other people, I think your position is just not
> > practical or reasonable.
> > 
> > I don't care about the purity or the safety of the API - the
> > practical result of PF_MEMALLOC_NORECLAIM is that __GFP_NOFAIL
> > allocation can now fail and that will cause unexpected kernel
> > crashes.  Keeping existing code and API semantics working
> > correctly (i.e. regression free) takes precedence over new
> > functionality or API features that people want to introduce.
> > 
> > That's all there is to it. This is not a hill you need to die
> > on.
> 
> And more than that, this is coming from you saying "We didn't have
> to handle memory allocation failures in IRIX, why can't we be like
> IRIX?  All those error paths are a pain to test, why can't we get
> rid of them?"
>
You're not listening, Kent. We are not eliding error paths because
they aren't (or cannot be) tested.

It's a choice between whether a transient error (e.g. ENOMEM) should
be considered a fatal error or not. The architectural choice that
was made for XFS back in the 1990s was that the filesystem should
never fail when transient errors occur. The choice was to wait for
the transient error to go away and then continue on. The rest of the
filesystem was build around these fundamental behavioural choices.

This goes beyond memory allocation - we do it for IO errors, too.
e.g.  metadata writeback keeps trying to write back the metadata
repeatedly on -EIO.  On every EIO from a metadata write, we will
immediately attempt a rewrite without a backoff. If that rewrite
then fails, wei requeue the write for later resubmission. That means
we back off and wait for up to 30s before attempting the next
rewrite. 

Hence -EIO  on async metadata writeback won't fail/shutdown the
filesystem until a (configurable) number of repeated failures occurs
or the filesystem unmounts before the metadata could be written back
successfully.

There's good reason for this "wait for transients to resolve" method
of error handling - go back to the late 1990s and early 2000s and
high-end multi-path FC SAN based storage was well known to have
transient path failures that can take minutes to resolve before a
secondary path takes over. That was the sort of storage environment
XFS was designed to operate in, and those users expected the
filesystem to be extremely tolerant of transient failure conditions.

Hence failing an IO and shutting down the filesystem because there
are transient errors occuring in either the storage or the OS was
absolutely the wrong thing to be doing. It still is the wrong thing
to be doing - we want to wait until the transient error has
progressed to being classified as a permanent error before we take
drastic action like denying service to the filesystem.

Memory allocation failure has always been considered a transient
error by XFS that the OS will resolve in one way or another in a
realtively short period of time. If we're prepared to wait minutes
for IO path failures to resolve, waiting a couple of seconds for
transient low memory situations to resolve isn't a big deal.

Ranting about how we handle errors without understanding the error
model we are working within is not productive. bcachefs has a
different error handling model to almost every other filesystem out
there, but that doesn't mean every other filesystem must work the
same way that bcachefs does.

If changing this transient error handling model was as simple as
detecting an allocation failure and returning -ENOMEM, we would have
done that 20 years ago. But it isn't - the error handling model is
"block until transients resolve" so that the error handling paths
only need to handle fatal errors.

Therein lies the problem - those error handling paths need to be
substantially changed to be able to handle transient errors such as
ENOMEM. We'd need to either be able to back out of a dirty
transaction or restart the transaction in some way rather than
shutting down the filesystem.

Put simply: reclassifying ENOMEM from a "wait for transient to
resolve" handler to a "back out and restart" mechanism like bcachefs
uses requires re-architecting the entire log item architecture for
metadata modification tracking and journal space management.

Even if I knew how to implement this right now, it would require
years worth of engineering effort and resources before it would be
completed and ready for merge. Then it will take years more for all
the existing kernels to cycle out of production.

Further: this "ENOMEM is transient so retry" model has been used
without any significant issues in production systems for mission
critical infrastructure for the past 25+ years. There's a very
strong "if it ain't broke, don't fix it" argument to be made here.
The cost-benefit analysis comes out very strongly on the side of
keeping __GFP_NOFAIL semantics as they currently stand.

> Except that's bullshit; at the very least any dynamically sized
> allocation _definitely_ has to have an error path that's tested, and if
> there's questions about the context a code path might run in, that
> that's another reason.

We know the context we run __GFP_NOFAIL allocations in - transaction
context absolutely requires a task context because we take sleeping
locks, submit and wait on IO, do blocking memory allocation, etc. We
also know the size of the allocations because we've bounds checked
everything before we do an allocation.

Hence this argument of "__GFP_NOFAIL aboslutely requires error
checking because an invalid size or wonrg context might be used"
is completely irrelevant to XFS. If you call into the filesytsem
from an atomic context, you've lost long before we get to memory
allocation because filesystems take sleeping locks....

> GFP_NOFAIL is the problem here, and if it's encouraging this brain
> damaged "why can't we just get rid of error paths?" thinking, then it
> should be removed.
>
> Error paths have to exist, and they have to be tested.

__GFP_NOFAIL is *not the problem*, and we are not "avoiding error
handling".  Backing off, looping and trying again is a valid
mechanism for handling transient failure conditions. Having a flag
that tells the allocator to "backoff, loop and try again" is a
perfectly good way of providing a generic error handling mechanism.

IOWs, Using __GFP_NOFAIL doesn't mean we are "not handling errors";
it simply means we have moved the error handling we were doing
inside the allocator.  And yes, we test the hell out of this error
handling path....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

