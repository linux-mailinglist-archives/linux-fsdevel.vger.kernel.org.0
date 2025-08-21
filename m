Return-Path: <linux-fsdevel+bounces-58688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA9BB30763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195C6646B11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A14313558;
	Thu, 21 Aug 2025 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="d4SF84j6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD4345759
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808467; cv=none; b=qIraXG4/Smxs5Z7Lg6tHJrYRfYa2X4CESFGodVjZECNMrapwSFBmr49FiVYWfXHMafqyb/Z0kW+KZwo1VOOG843mmWxbxqJ7EPwyXMsEsPvatOQDStnrNlHvD0vWq09mB/hfCwV7zlixDX57bXWYR/X9H92oEruhrhs5TVg5Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808467; c=relaxed/simple;
	bh=29HWqsRpgm/L2rT2+jnUODCtvVpLGq1qWh1AROLvPj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVQLURCQwXKUDRAJrM6ZzqMv+eHt4Nux8A7+DvMeb5hnSaowUW624skQmjHONPvalBsooKScqq2xZqq9A1ac/ruBxptKcuyAJRlsHBMhf64H+SbhZmFrIvVNIlBVtnn1J2EuYd/E8VXDR3xLkDpdr6GivB5TLuXucviwGOP5TQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=d4SF84j6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-69.bstnma.fios.verizon.net [173.48.113.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57LKY7O5029200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 16:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1755808449; bh=WJ4tVu5z2VID9C5zAZWHLOKuM4/5q+czdRotkdglyU0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=d4SF84j6GCxn7qI1rIgTYYe5L12VOF1IdreBMIXlPX3B6aQa2EnXd8lO0TagQctrj
	 AvEr7CuywBhjsUZTnwm/yPof21J1GMdQE/a7BhpAOqxegZQ0cZE118niCLB1LJJ4LK
	 dyKaMDHN0LRr1vdt7eH4wTph4cyhBa50jKyW/2xhITWICuKsqBnPW+ISlfFxFNVI+h
	 Ub/erVdanTrQ+JPUz7MP6sHL0C1+9tfQjsltpq36epe8h9gxTB5aeGLO++H2joL3DH
	 KR4bTczUyuC89bZprehb6ajL3VUKll8HlgO2DYnD7e8+mhCfxQfNlsKF0t9uFHICpP
	 XPWQLBnnQ+UTQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 56BD82E00D6; Thu, 21 Aug 2025 16:34:07 -0400 (EDT)
Date: Thu, 21 Aug 2025 16:34:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINER SUMMIT] Adding more formality around feature
 inclusion and ejection
Message-ID: <20250821203407.GA1284215@mit.edu>
References: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0994de40776609928e8e438355a24a54f1ad10.camel@HansenPartnership.com>

On Thu, Aug 21, 2025 at 09:56:15AM +0100, James Bottomley wrote:
> I think the only point of agreement on this topic will be that how
> bcachefs was handled wasn't correct at many levels.  I think this shows
> we need more formality around feature inclusion, including a possible
> probationary period and even things like mentorship and we definitely
> need a formal process that extends beyond Linus for deciding we can no
> longer work with someone any more.

I think we are conflating three different things in this discussion
thread, and it would be helpful if we separated them out.

  1.  What is the process by which a particular feature be included
         or ejected?
  2.  What is the process by which a developer should be excluded
         from the deevlopment community?  And this goes beyond
	 Code of Conduct violations, but in the case of a maintainer,
	 when that person has displayed toxic tendencies which are
	 sufficiently bad that other deevlopersa and maintainers refuse to
	 work with the individual, and when that person has been accused of
	 promoting a toxic environmet which is harming the entire
	 community?
  3.  The question of maintainer mentorship, which is very different
         from (2) as there are a large set of skills which a much broader
	 front including avoiding maintainer burnout, the product management
	 side of being a maintainer (e.g. working with companies to
	 motivate them to invest in a featrue which benefits not only the
	 companies' business interest, but the community as a whole),
	 managing volunteer, etc.

(2) is a very hard problem, and so there is a tendency to focus on
solving problems (1) and (2).  However, using bcachefs and its
maintainera as a motivating case for solutions to address (1) and (3)
very likely going to result in skewing the discussion around the best
ways of addressing (1) and (3).

As far as (2), our baseline way of handling things is quite ad hoc.
At the moment, individual developers will simply refuse to work
someone who is accused of being toxic, by doing things such as:

   (a) using mail filters to redirect e-mail from that person
       to /dev/null,
   (b) telling a higher-level maintainer that because of (a) they
       would appreciate it if any pull requests from that individual
       include changes to their subsystem or sub-subsysttem,
       that those commits should be presumed to be auto-NACK'ed,
       and requesting that the PULL request should be rejected,
   (c) if the behaviour of said person exasperates a higher-level
       maintainer to such an extent that the higher-level maintainer
       refuse to accept patches or pull requests from said
       individual, and
   (d) informing program committees of invite-only workshops and/or
       conferences that if that individual attends, they will refuse
       to attend because of that individual's toxicity.

I will note that (b) and (c) can be appealed to someone higher up on
the maintainer hierarchy, unless that higher-level maintainer is
Linus, at which point there is no higher level authority to take that
appeal, and that (b), (c), and (d) are effectivly a way that
developers and maintainers are effectively saying, "it's either him or
me!", and as someone who has to manage volunteers, if a sufficiently
large number of volunteers are sufficiently p*ssed off that they are
threatening to withdraw, the wise maintainer (or program committee)
should take heed.

Now, the above is inherently very messy.  But fortunately, it's only
happened once in thirty five years, and before we propose to put some
kind of mechanism in place, we need to make sure that the side effects
of that mechanism don't end up making things worse off.

There is the saying that "bad facts make bad law", and the specifics
of this most recent controversy are especially challenging.  I would
urge caution before trying to create a complex set of policies and
mechanim when we've only had one such corner case in over 35 years.

Cheers,

						- Ted

