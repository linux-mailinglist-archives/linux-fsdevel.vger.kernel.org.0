Return-Path: <linux-fsdevel+bounces-57388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D327B210F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2E517BDBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1BD2E283B;
	Mon, 11 Aug 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KW2ngy4V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8E2E11B9;
	Mon, 11 Aug 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927000; cv=none; b=OKun/KkQXSrHQg/lJqvadPyuIsWtVu213qpoturwRRBCKEUm/rWugD4eZHEEIP+arZGJbOEnAhgDvms9u3Nc0Bs/8Sub/txlC31qABj5oy8oLSlMhmwbnbc3cdFhXj3SmVqoGPKPel4g6TE3mVnUKOJlc28Qmst00XhyFaDJxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927000; c=relaxed/simple;
	bh=RQzvlWFhLJK/TNniy6z4Pz1w9gjP9baEr2ufUIUHESg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5X47i0DdJNd/mdJtAIFBVzjj2BTJDk15xKZKKP3UX6vsXXUAG4nTjN1ICwKEVz++2f0/AgVJtiC4ulUHY4yLV5SdYmjl0RYjMd9p+1bGV+Mu/aXXpj6Y4A6EroaWfh5KMEQbzW9Qu/bbAEwkTqtwqKXCJQ67xwHNevjnC3mlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KW2ngy4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F25C4CEED;
	Mon, 11 Aug 2025 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926999;
	bh=RQzvlWFhLJK/TNniy6z4Pz1w9gjP9baEr2ufUIUHESg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KW2ngy4VBIOueyDH7dAowxbvouJ2nK/vzcpd7xl1Kbq18a8M5FOAjlXWSW6iqtHff
	 Gk7Kp/xI+ayMJwwp37XvDEbgVOjBG1GWTz8HbY0g3XJ4UgTCmTH82cAg+T1uExfvDe
	 2abd4zCWVOGC8NWD7P2ynqZJegHIDL2sig0qFt743cZuQ2TpOz64hE2fe+jBov63IL
	 z24dd5ot9Avoie2EUvkp8e4FE8LQI8e1hrCpvi4e5Gn7L82v/T20yra7kdAoW/bN6F
	 RqSmzdTrG8N2GBGSGDXV/aaRuMVin128RPnH9EF666wsUjH/xfEdxpX3DXAomKi7PX
	 prG5zMJPDSFDg==
Date: Mon, 11 Aug 2025 08:43:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Luis Henriques <luis@igalia.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250811154319.GA7942@frogsfrogsfrogs>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu>
 <20250731173858.GE2672029@frogsfrogsfrogs>
 <8734abgxfl.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734abgxfl.fsf@igalia.com>

On Fri, Aug 01, 2025 at 11:15:26AM +0100, Luis Henriques wrote:
> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> 
> > On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >> > 
> >> > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> >> > could restart itself.  It's unclear if doing so will actually enable us
> >> > to clear the condition that caused the failure in the first place, but I
> >> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> >> > aren't totally crazy.
> >> 
> >> I'm trying to understand what the failure scenario is here.  Is this
> >> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
> >> is supposed to happen with respect to open files, metadata and data
> >> modifications which were in transit, etc.?  Sure, fuse2fs could run
> >> e2fsck -fy, but if there are dirty inode on the system, that's going
> >> potentally to be out of sync, right?
> >> 
> >> What are the recovery semantics that we hope to be able to provide?
> >
> > <echoing what we said on the ext4 call this morning>
> >
> > With iomap, most of the dirty state is in the kernel, so I think the new
> > fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
> > would initiate GETATTR requests on all the cached inodes to validate
> > that they still exist; and then resend all the unacknowledged requests
> > that were pending at the time.  It might be the case that you have to
> > that in the reverse order; I only know enough about the design of fuse
> > to suspect that to be true.
> >
> > Anyhow once those are complete, I think we can resume operations with
> > the surviving inodes.  The ones that fail the GETATTR revalidation are
> > fuse_make_bad'd, which effectively revokes them.
> 
> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
> but probably GETATTR is a better option.
> 
> So, are you currently working on any of this?  Are you implementing this
> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
> look at fuse2fs too.

Nope, right now I'm concentrating on making sure the fuse/iomap IO path
works reliably; and converting fuse2fs to be a lowlevel fuse server.
Eliminating all the path walking stuff that the highlevel fuse library
does reduces the fstests runtime from 7.9 to 3.5h, and turning on iomap
cuts that to 2.2h.

--D

> Cheers,
> -- 
> Luís
> 
> > All of this of course relies on fuse2fs maintaining as little volatile
> > state of its own as possible.  I think that means disabling the block
> > cache in the unix io manager, and if we ever implemented delalloc then
> > either we'd have to save the reservations somewhere or I guess you could
> > immediately syncfs the whole filesystem to try to push all the dirty
> > data to disk before we start allowing new free space allocations for new
> > changes.
> >
> > --D
> >
> >>      	     	      		     	     - Ted
> >> 
> 

