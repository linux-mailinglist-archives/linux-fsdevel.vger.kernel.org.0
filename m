Return-Path: <linux-fsdevel+bounces-56437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2DB175B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 19:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBED1C22307
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF2264615;
	Thu, 31 Jul 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq+NX9St"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552901DE4E7;
	Thu, 31 Jul 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983539; cv=none; b=RpAH/+oYPG3VPV7VZtFcUNvhuAU8j7iYSdFUqKY+v3ySaJaHE8F1yIl1dU0Rn3v23bHlNKz78dzDa0JhUEuVxJiYHsJsGScrypup2H1Yl8gIKetkwE+iF4aJLoJc7D0usLAQa3nOzFf3fpdKK9+QQLEzDoCUO4mKBNByKE/7fJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983539; c=relaxed/simple;
	bh=PNvkXf7OS106jn4+imCBnvISQ62wa1QgitNZbGwFm0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnLgBWhHxUkJQxI+Dydd0yUuzEZAjQa50j2VqHgg6fslWh4sgtnDvRc6QiO6jw7AxL946yB3SXJSkElntelDMCqg1yueiANtD8jrWjtwsgdEpM+gn5J3z8hONoIXJ8lxPbk4qZ3gCOdgZdlD62ZPHqSBoMA3KVWl2l1dp260KYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq+NX9St; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE4BC4CEF6;
	Thu, 31 Jul 2025 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753983538;
	bh=PNvkXf7OS106jn4+imCBnvISQ62wa1QgitNZbGwFm0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zq+NX9StgL8hIcpiakj9b5cfqREMxjPbXPHS9h2zb2ufk3LAmm9grkwhuOMFEMKvs
	 H53VlwH3paHB5vDc8bxqIG+aQXxfXwcyjOz6es9aZWwp3FZcWWTGPavaRfIlkNi8sZ
	 4Oczte/vMY+NqusrqgtGOlFzKqhw6H2Z+I531rGvTnibEMOLL80OLtJ4xMuyANEFE0
	 hkRDlZsMV0J/vN0ZSgyNIopZnnmXdyUkFoJYXcYGyBWxfICxCchZCsExvrYNaz9wl0
	 4KFGqNMqeiGWCGGXChYmUQ+1QYrt9eemuH6JBN8JU2OB7BgxjbmqRgONBdGfiyjSgl
	 VbL1U/ZldSmpg==
Date: Thu, 31 Jul 2025 10:38:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250731173858.GE2672029@frogsfrogsfrogs>
References: <8734afp0ct.fsf@igalia.com>
 <20250729233854.GV2672029@frogsfrogsfrogs>
 <20250731130458.GE273706@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731130458.GE273706@mit.edu>

On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> > 
> > Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> > could restart itself.  It's unclear if doing so will actually enable us
> > to clear the condition that caused the failure in the first place, but I
> > suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> > aren't totally crazy.
> 
> I'm trying to understand what the failure scenario is here.  Is this
> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
> is supposed to happen with respect to open files, metadata and data
> modifications which were in transit, etc.?  Sure, fuse2fs could run
> e2fsck -fy, but if there are dirty inode on the system, that's going
> potentally to be out of sync, right?
> 
> What are the recovery semantics that we hope to be able to provide?

<echoing what we said on the ext4 call this morning>

With iomap, most of the dirty state is in the kernel, so I think the new
fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
would initiate GETATTR requests on all the cached inodes to validate
that they still exist; and then resend all the unacknowledged requests
that were pending at the time.  It might be the case that you have to
that in the reverse order; I only know enough about the design of fuse
to suspect that to be true.

Anyhow once those are complete, I think we can resume operations with
the surviving inodes.  The ones that fail the GETATTR revalidation are
fuse_make_bad'd, which effectively revokes them.

All of this of course relies on fuse2fs maintaining as little volatile
state of its own as possible.  I think that means disabling the block
cache in the unix io manager, and if we ever implemented delalloc then
either we'd have to save the reservations somewhere or I guess you could
immediately syncfs the whole filesystem to try to push all the dirty
data to disk before we start allowing new free space allocations for new
changes.

--D

>      	     	      		     	     - Ted
> 

