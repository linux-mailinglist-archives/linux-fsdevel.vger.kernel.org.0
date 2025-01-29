Return-Path: <linux-fsdevel+bounces-40301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3FA22020
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48E91887CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52C1D9346;
	Wed, 29 Jan 2025 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q0ThmZH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28818C31;
	Wed, 29 Jan 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164162; cv=none; b=T8dTM9L92qtMLnpJi1P2HwbSIHW9VfjmZ5d1oeuOPv6ZdZ+KQ6c/8/Khw1bqzfhB5fQNR/wY+TDyxJSuKXMncg2k5ChrLE3W5/YknnDQNgfovhMuJkMG0e5ydn8IfIWsZ61hIINZrP5Pxk8WGBFWo8K9LGowJJokzPyHp/5n6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164162; c=relaxed/simple;
	bh=W9dHuoTdFYXu+PKWif1J3OrOzUOQQwZdx1Lx7v42wR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czTgEVXUQDxgsygD3NTkixI9WafUlSaSwSth5x3WhpMJM1afNGt3HW5lCwV/nWjHVRvIUUtNnk0l/N0kkd7A+pQ2vrkhZI+zvs3mhlqK3NkOh+OD+5O+D/PDBQ3KVkFH8j7SfEPIaqCotSxvt2Uf4IV6IWLeQLTGNqArx84I5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q0ThmZH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FBEC4CED1;
	Wed, 29 Jan 2025 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738164161;
	bh=W9dHuoTdFYXu+PKWif1J3OrOzUOQQwZdx1Lx7v42wR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0ThmZH1gimMOmTXmE3JT3PsFZ0+D7UxMz6812H8KkNOayXJF2kwafcCeZCdcWKl1
	 AY5KPXKhqhOILq6yRiACWBQVBQJ2zUMXcHou+f06hj8jHwVVAcvXU2KXWfTx4lGmBx
	 sXV09hdNTdfcVyyqrRp1+mggEwE566pslBMEtmmM=
Date: Wed, 29 Jan 2025 16:21:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
Message-ID: <2025012924-shelter-disk-2fe1@gregkh>
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
 <2025012937-unsaddle-movable-4dae@gregkh>
 <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>

On Wed, Jan 29, 2025 at 10:06:49AM -0500, Chuck Lever wrote:
> On 1/29/25 9:50 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
> > > On 1/24/25 2:19 PM, cel@kernel.org wrote:
> > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > 
> > > > This series backports several upstream fixes to origin/linux-6.6.y
> > > > in order to address CVE-2024-46701:
> > > > 
> > > >     https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> > > > 
> > > > As applied to origin/linux-6.6.y, this series passes fstests and the
> > > > git regression suite.
> > > > 
> > > > Before officially requesting that stable@ merge this series, I'd
> > > > like to provide an opportunity for community review of the backport
> > > > patches.
> > > > 
> > > > You can also find them them in the "nfsd-6.6.y" branch in
> > > > 
> > > >     https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > > > 
> > > > Chuck Lever (10):
> > > >     libfs: Re-arrange locking in offset_iterate_dir()
> > > >     libfs: Define a minimum directory offset
> > > >     libfs: Add simple_offset_empty()
> > > >     libfs: Fix simple_offset_rename_exchange()
> > > >     libfs: Add simple_offset_rename() API
> > > >     shmem: Fix shmem_rename2()
> > > >     libfs: Return ENOSPC when the directory offset range is exhausted
> > > >     Revert "libfs: Add simple_offset_empty()"
> > > >     libfs: Replace simple_offset end-of-directory detection
> > > >     libfs: Use d_children list to iterate simple_offset directories
> > > > 
> > > >    fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
> > > >    include/linux/fs.h |   2 +
> > > >    mm/shmem.c         |   3 +-
> > > >    3 files changed, 134 insertions(+), 48 deletions(-)
> > > > 
> > > 
> > > I've heard no objections or other comments. Greg, Sasha, shall we
> > > proceed with merging this patch series into v6.6 ?
> > 
> > Um, but not all of these are in a released kernel yet, so we can't take
> > them all yet.
> 
> Hi Greg -
> 
> The new patches are in v6.14 now. I'm asking stable to take these
> whenever you are ready. Would that be v6.14-rc1? I can send a reminder
> if you like.

Yes, we have to wait until changes are in a -rc release unless there are
"real reasons to take it now" :)

> > Also what about 6.12.y and 6.13.y for those commits that
> > will be showing up in 6.14-rc1?  We can't have regressions for people
> > moving to those releases from 6.6.y, right?
> 
> The upstream commits have Fixes tags. I assumed that your automation
> will find those and apply them to those kernels -- the upstream versions
> of these patches I expect will apply cleanly to recent LTS.

"Fixes:" are never guaranteed to show up in stable kernels, they are
only a "maybe when we get some spare cycles and get around to it we
might do a simple pass to see what works or doesn't."

If you KNOW a change is a bugfix for stable kernels, please mark it as
such!  "Fixes:" is NOT how to do that, and never has been.  It's only
additional meta-data that helps us out.

So please send us a list of the commits that need to go to 6.12.y and
6.13.y, we have to have that before we could take the 6.6.y changes.

thanks,

greg k-h

