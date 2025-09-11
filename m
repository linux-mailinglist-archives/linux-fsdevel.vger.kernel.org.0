Return-Path: <linux-fsdevel+bounces-60972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79164B53E0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 23:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA84C3B0690
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 21:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CA52DEA97;
	Thu, 11 Sep 2025 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv6ATzwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F812D24A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 21:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627128; cv=none; b=uJJ4g+t6Cequoknmc1xP6rKjxfUlP3G0upkUfzyAUbEq4M0MGkzy3Go5yreMg2jeZ7Vc9sjtC9SR+rTuwCbWB6vvZTrcr7sekoNqRXNL7jlq+azo8gdqvUVKosIoXUsaq1jT3I9wFNtiQyMMBL1vtdvwMfgWeGcSwpdB/N1A3K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627128; c=relaxed/simple;
	bh=F0iC5yU0IO0nkwitEBWUh1GHX0/yLbE3Uh2bGqACZmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfrMx9smyKzhrs1n2C1pJggB/S8d8cmET2gc+A5Llk8TVejjV2w8JoQ7Re4JU/yn7yYiTMYj90jKvAor9TyzNoSEssjaduv46e2WnWSqNCyGan+B6lLxID104Opk5Dr8ecySJ0WxjS4oRCVWxmymJL37CBX3C+8gKnXqbuOEWv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv6ATzwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6628C4CEF0;
	Thu, 11 Sep 2025 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757627127;
	bh=F0iC5yU0IO0nkwitEBWUh1GHX0/yLbE3Uh2bGqACZmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv6ATzwVX6lgWeCbkioh1GlxHRW+3pDVrinF/8mER9yM39BzJLThe9k3tuV49fI6D
	 WSo4WK/hjdXyRZdlU4q5Y/+iZSKjNOxVgXRCyF7fGbwOqJL3hKj3Z0Wbf11vBBqkss
	 +nFL5RIw7fXHxW2EpcTdbG62BTjWswZ9/sWktRItxLeuwXLN2yO3GJyyl05Bgee2Wy
	 MFRN6mcMdLjtHghDFyl/9gX+hopbmYmKdo40r4QJPPqHpdnBAe3YSGX0SvGu1UnXU3
	 7KZluvHRTgN1q8yd/8dT4ehA1Yzudcb+j5aLNfYwZtC/Vd2sSv2uS6bsMT3PSqW487
	 we4nFXBthkQTw==
Date: Thu, 11 Sep 2025 14:45:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
Message-ID: <20250911214527.GG1587915@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
 <20250904144521.GY1587915@frogsfrogsfrogs>
 <CAJfpeguoMuRH3Q4QEiBLHkWPghFH+XVVUuRWBa3FCkORoFdXGQ@mail.gmail.com>
 <20250905015029.GC1587915@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905015029.GC1587915@frogsfrogsfrogs>

On Thu, Sep 04, 2025 at 06:50:29PM -0700, Darrick J. Wong wrote:
> On Thu, Sep 04, 2025 at 05:17:13PM +0200, Miklos Szeredi wrote:
> > On Thu, 4 Sept 2025 at 16:45, Darrick J. Wong <djwong@kernel.org> wrote:
> > 
> > > Or do you prefer the first N patches to include only code and no
> > > debugging stuff at all, with a megapatch at the end to add all that
> > > instrumentation?
> > 
> > It doesn't have to be a megapatch, could be a nicely broken up series.
> > But separate from the main patchset, if possible.
> 
> I'll give it a try.

Hi Miklos!

I gave it a try for V5 and the results were ... not fun.

I. Moving all the tracepoint definitions to come before the beginning of
code changes breaks compilation in three critical ways:

 (a) The tracepoints take as arguments pointers to structs that only get
     defined later in the patchset.

 (b) Tracepoints that extract data from those structs cannot do so
     because (obviously) they are not actually defined yet.

 (b) The flag constants to strings decoding mechanism requires those
     constants to be defined.

II. I fixed /that/ by moving the tracepoint definitions to come after
the all code change, but that brings its own problems:

 (1) Now I have to move all the callsites from the code patches to this
     new patch at the end.

 (2) I've found that oftentimes, if I need to change one of the code
     patches to fix a bug, there will be a merge conflict in the
     tracepoint patch at the end because some whitespace moved, etc.
     That's annoying to have to fix up every time I make a change, the
     suggested conflict resolution puts the trace_() call in completely
     the wrong place because well, textually it looked right.

 (3) If I change a structure in a code patch, I'm not going to find out
     if it breaks the tracepoint until I get to that megapatch.  In the
     good case I can just fix the tracepoint, but in the bad case I have
     to go all the way back to the code patch to fix that, then rebase
     everything back to the tracepoint patch.  Right now, that kind of
     breakage is immediately obvious when building each code patch.

III. A middle ground that I devised is to have a patch N that adds code,
and patch N+1 adds the tracepoints.  That avoids most of the problems of
the first two approaches, but now there are twice as many patches, e.g.:

 * fuse: implement direct IO with iomap
 * fuse: add tracepoints for implement direct IO with iomap

Coming from XFS, I encountered a lot of friction from some reviewers for
putting too many things in a single patch, and from other reviewers for
sending too many patches once I split things up.  I'd like to avoid that
here.

So I think the third approach is the way to go, but I'd like your input
before I commit to a particular approach.  Just to be clear, I'm trying
to avoid landing any of this in 6.18 (aka presumed 2025 LTS), so there's
plenty of time.

--D

