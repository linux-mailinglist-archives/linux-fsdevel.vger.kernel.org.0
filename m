Return-Path: <linux-fsdevel+bounces-60279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF8B43F6D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A359E17FE01
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF8A1FAC37;
	Thu,  4 Sep 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxRGRHMP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6427450
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756997122; cv=none; b=t6/NKBxomayvybQrs/yF5RXXR93mU442tW9u7Id2sn0jIoGHppOjmj8blIgAoB7r0G34SY9wr6/b592pqaG7xtYTASn6OvP0rXk9uJIj0UOTT+v6Ro3/MLFl6jdIrFwtSp4FyJw/QMx52tcPlyinpwB4FX1YIMaTIqm1i/FiyfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756997122; c=relaxed/simple;
	bh=U0kf5mpW1fx6GWEICwJFcUTQaeO8sCb9xX0G7bidl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbi/UVcf90q0u1ybGf/5C6hmgGc6bP+kJfWvslyRtAqvFjYrALA3oHbGBHGwNPmCa02LPUJK4HUHSKd9L0jCAjf8tUIrawGhQK+U4iFhG6iBHj/dOLPsDs/+IAeojPnuq2o6gcF29DyknSpi3Bqr/LXl7SNTavFZq1qMlnE73uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxRGRHMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E848C4CEF0;
	Thu,  4 Sep 2025 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756997122;
	bh=U0kf5mpW1fx6GWEICwJFcUTQaeO8sCb9xX0G7bidl8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxRGRHMPdPUaTbJGmufZPtv6NatLzmeAeRNj0rkdV9gnWbw7A9pXMqBmd3xgygNL2
	 gnkkEhnbVFk+pZs7iwAEc6UAJMIxj90DwCdM2SrhQ+WqE2wcM1lvjIsiI8sB0AB+9h
	 iAsYuU3S/X4U6FudSFOd22cZVD+1r8bvA/Mb+q/2Quq0u8MyQUByNV+DQN8m6XvwJy
	 se1qUlYRTbCHKznV3ndS6UsgPXwq9y6xyA/ZTZjuA5d9hH2wa6LM4eVS39wtilKq0x
	 zRmK7fHFUSvleSXxU0qradKYIBAAyEJcyiDJ1yolysi7mGrX9D7Bv0zy1obRvQVGzX
	 YaB2uKeHj6f2A==
Date: Thu, 4 Sep 2025 07:45:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
Message-ID: <20250904144521.GY1587915@frogsfrogsfrogs>
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs>
 <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
 <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>

On Thu, Sep 04, 2025 at 04:04:51PM +0200, Miklos Szeredi wrote:
> On Thu, 21 Aug 2025 at 02:53, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> >  #endif /* _FS_FUSE_I_H */
> > diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> > index bbe9ddd8c71696..2389072b734636 100644
> > --- a/fs/fuse/fuse_trace.h
> > +++ b/fs/fuse/fuse_trace.h
> 
> One general thing I'd like to ask is that debugging and tracing be as
> much separated from actual functionality as possible.  Not just on the
> source tree level but on the patch or even patchset level, please.

How would that work in practice for this patch?  One way I can think of
to break up this patch would be:

Patch 1 introduces all the #defines that later get used by the
#define FOO_STRINGS that get passed to __print_symbolic/__print_flags
macros.

Patch 2 defines the tracepoints and ASSERT/BAD_DATA

Patch 3 adds all the new code that actually uses ASSERT/BAD_DATA and
calls trace_fuse_iomap_XXX()

...or would you prefer patch 3 to be code only, and a patch 4 would dump
in all the assertions and tracepoint callsites separately?

For subsequent patches that add new iomap flags (and hence extend
FOO_STRINGS) and tracepoints, should those also go in a separate
pre-patch ahead of the actual code using it?

Or do you prefer the first N patches to include only code and no
debugging stuff at all, with a megapatch at the end to add all that
instrumentation?

(Or would you rather I sorted the diff chunks to put fuse_trace.h at the
very end of each patch, because AFAICT reviewers rarely spend much time
looking at the tracepoints and at least then you don't have to scroll
through that boilerplate to get to the real code...)

Yeah, I know, the ftrace macros are painful to look at and wish there
was a better way to do that.

--D

> Thanks,
> Miklos
> 

