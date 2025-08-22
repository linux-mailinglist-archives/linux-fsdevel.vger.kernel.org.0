Return-Path: <linux-fsdevel+bounces-58790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF14B317C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EAB56500B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59893287508;
	Fri, 22 Aug 2025 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PseBtBnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A42765ED
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Aug 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755865540; cv=none; b=CTE3VkAWLnvWidGmrHPy5K77giFOX0lkA0UmWoRT74tF/EHEI+1lNPRQIiuVRT7KfLr1kXvyyzlcJA6h2MettCLYtZilB1djg2FclItLJ0WZJ1V9Zxke+6VvNdap5ZYTbvIrIAV+Rj4pUwvRnVVnCQcXh/8rNAjPum4Nf6GaDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755865540; c=relaxed/simple;
	bh=BiVLT7ijqZ0hT6ZphssnYd7Os4gZD4Awt6h1PY2IS2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSQEhQ2poBYHSMQwH7vMHc2Cqvnjt8uXE0+eBnCG8hK1toAW3ZgO0wM3o54snDkOaay4imvk3I8u0cY1F70R1fofUj/kOX0UjL/6NHb249+wdwVJsF54/nP3Rqkw/C9krWs0pQrwyOcALoIT43bpxeM+/d//al0Iuk8PeteEbqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PseBtBnS; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57MCPPEQ031704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755865528; bh=duG5zyv9oNGXQ+s7J0J6ZL+HnHmEFnUBy4998ozC+v4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PseBtBnSD2Um4WHD8uuM6evgozorWxSMTkP0gL/I4PX/Bf77TwgU+AbEXawnThG1E
	 HYPeR57pR8TjM3/brwFQ61sbW9EuusEMAW1QhahKJ29bEyuMfiRsTOgrKFgp66a/gF
	 B5jjAJZ4LT3KTvagu8wQqeBTMXDbvB0VlX26FCPYP2AX+g33QTs5p3bqjqJWB4I7pe
	 EyTdEtXvZzgn7bNVJi3Fr7PXgleHdKiFoJGn7uvq6YUikiuMhylBBCi4fjHgxEx4L6
	 0yzizKf51syEsF3gizuqEs9j3SuQ3Pl1O0G/si6pGMt0X5KtRDCslaM1b599labI2r
	 1vOLcM26S/lbg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id AD7A73FDD76E; Fri, 22 Aug 2025 08:24:24 -0400 (EDT)
Date: Fri, 22 Aug 2025 08:24:24 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Greg KH <greg@kroah.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250822122424.GA34412@macsyma.lan>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
 <20250821203407.GA1284215@mit.edu>
 <940ac5ad8a6b1daa239d748e8f77479a140b050d.camel@HansenPartnership.com>
 <2025082202-lankiness-talisman-3803@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025082202-lankiness-talisman-3803@gregkh>

On Fri, Aug 22, 2025 at 02:03:13PM +0200, Greg KH wrote:
> 
> It's not our job to quell "internet speculation", sorry.  Just because
> we normally work in public for almost everything, doesn't mean that some
> things can't be done in private as well.  And again, just because you
> haven't seen a public decision doesn't mean that there hasn't been one
> made :)

The other thing I'll add here is that the best analogy I can think of
here is that this is a HR / Personnel issue.  These sorts of things,
whether they are a matter of someone not working well with the team
(at which point the manager needs to figure out how to resolve the
issue, and will often need to engage in private mediation /
interventions), or being caught on camera at a Coldplay concert, will
always have private conversations that will never be made part of the
public record --- as it should be, as much as content creators looking
for clickbait might wish otherwise.

Now, if what James is trying to say is that we could have avoided the
whole situation by refusing to allow bcachefs to be included in the
first place, I'm going to have to respectfully disagree with that
proposal as a way to avoid problems in the future.

I'm not sure that the fact that various developer-to-developer
relationships would have degraded to the point that it had by the end
of this whole saga could have been predicted at the point when we were
making the "to include or not to include bcachefs in Linux mainline".
I don't think we could have predicted whether or not a perspective
future maintainer would utterly refuse private offers of coaching from
the beginning.  And I don't think we should proactively refuse to
accept a feature just because someone's inter-personal relationships
are not perfect.

The current baseline is that the media subsystem, networking, or BPF
maintainer's decide what features to accept and who they will accept
pull requests from.  The same us true all the way up the hierarchy
maintainer tree up to Linus.  What is the alternative that we could
use?  That some democratic voting procedure, or some kind of core team
would stick their oar into making this decision?  I'm not sure that
would be an improvement; in fact, IMHO, it will very likely be
significantly worse.

I'm sure that as a result of this whole sitution, maintainers may very
well be more careful before accepting a new feature from a perspective
submaintainer who might be challenged in the teamwork department.  But
I'm not sure trying to codify this would be helpful --- because I
fundamentally disagree with the premise that we can accurately predict
how future stories will end.  Hindsight, after all, is 20/20.

If someone wants to suggest a concrete proposal, perhaps that's
something we can discuss.  But my personal opinion is having an
open-ended discussion of how we could have avoided the messiness of
bcachefs would probably not be a good use of time at the Maintainer's
Summit.

						- Ted

