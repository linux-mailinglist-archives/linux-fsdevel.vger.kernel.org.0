Return-Path: <linux-fsdevel+bounces-40362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847A1A229CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 09:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953F13A6FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2671AF0D5;
	Thu, 30 Jan 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xnwpdgmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50A1922D8;
	Thu, 30 Jan 2025 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226754; cv=none; b=YGrvocQUy6h8XVKxeRvnhXWmQ9kBtc3WFeHRzKFc2oTeAN0KbiAEKn4Ky8oQJ1S/zOiKtdZGe79AbnT5hM8K8Z1I1HUd5XZJRpWWb+n74FVmF1SEk7sIRIgnKFjlFPlVkWOR9jBfEiKF/RYODtoDmg3VB0PfwkGcj8CTVa8so/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226754; c=relaxed/simple;
	bh=djFUHlqqBU4Ge326CrqKtMAMUPAMqHeV9r8/sraYo20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqNo/Zb++F8lShBPJ8v+WhVRlmHhzZllKoyA2joMGPD/55c28jv4hgDIbQXVNpGcztD+e2kBdamQUwC5WOqZE9jkSicg/FvHI4MK/PQsWmgsKk5vkoDMaT+XZRiU0VwvLfdVGti81Vm/IMqVXncKpVRE3UxXfW609NmFI4DT9ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xnwpdgmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4FCC4CED3;
	Thu, 30 Jan 2025 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738226754;
	bh=djFUHlqqBU4Ge326CrqKtMAMUPAMqHeV9r8/sraYo20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xnwpdgmH3I+l2oXpAng0G6RWNv1jj5tqt3nT6X3qUUGAxPg6lT9dOIwaCMg3ApTpg
	 Q6udNWxYeJvPfu6vBJFpO489lo5ptBPDXvtaZHV/djU+MhqdYN7HEq4/LrmNzmJN7t
	 lVBBCwt45TVCpqYF8Jq05ZL13hFIsxkXd+tOzQ94=
Date: Thu, 30 Jan 2025 09:45:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morten <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
	linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
Message-ID: <2025013057-lagged-anointer-8b77@gregkh>
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
 <2025012937-unsaddle-movable-4dae@gregkh>
 <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>
 <2025012924-shelter-disk-2fe1@gregkh>
 <9130c4f0-ad6b-4b6f-a395-33c7a6b21cbe@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9130c4f0-ad6b-4b6f-a395-33c7a6b21cbe@oracle.com>

On Wed, Jan 29, 2025 at 11:37:51AM -0500, Chuck Lever wrote:
> On 1/29/25 10:21 AM, Greg Kroah-Hartman wrote:
> > On Wed, Jan 29, 2025 at 10:06:49AM -0500, Chuck Lever wrote:
> > > On 1/29/25 9:50 AM, Greg Kroah-Hartman wrote:
> > > > On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
> > > > > On 1/24/25 2:19 PM, cel@kernel.org wrote:
> > > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > > 
> > > > > > This series backports several upstream fixes to origin/linux-6.6.y
> > > > > > in order to address CVE-2024-46701:
> > > > > > 
> > > > > >      https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> > > > > > 
> > > > > > As applied to origin/linux-6.6.y, this series passes fstests and the
> > > > > > git regression suite.
> > > > > > 
> > > > > > Before officially requesting that stable@ merge this series, I'd
> > > > > > like to provide an opportunity for community review of the backport
> > > > > > patches.
> > > > > > 
> > > > > > You can also find them them in the "nfsd-6.6.y" branch in
> > > > > > 
> > > > > >      https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> > > > > > 
> > > > > > Chuck Lever (10):
> > > > > >      libfs: Re-arrange locking in offset_iterate_dir()
> > > > > >      libfs: Define a minimum directory offset
> > > > > >      libfs: Add simple_offset_empty()
> > > > > >      libfs: Fix simple_offset_rename_exchange()
> > > > > >      libfs: Add simple_offset_rename() API
> > > > > >      shmem: Fix shmem_rename2()
> > > > > >      libfs: Return ENOSPC when the directory offset range is exhausted
> > > > > >      Revert "libfs: Add simple_offset_empty()"
> > > > > >      libfs: Replace simple_offset end-of-directory detection
> > > > > >      libfs: Use d_children list to iterate simple_offset directories
> > > > > > 
> > > > > >     fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
> > > > > >     include/linux/fs.h |   2 +
> > > > > >     mm/shmem.c         |   3 +-
> > > > > >     3 files changed, 134 insertions(+), 48 deletions(-)
> > > > > > 
> > > > > 
> > > > > I've heard no objections or other comments. Greg, Sasha, shall we
> > > > > proceed with merging this patch series into v6.6 ?
> > > > 
> > > > Um, but not all of these are in a released kernel yet, so we can't take
> > > > them all yet.
> > > 
> > > Hi Greg -
> > > 
> > > The new patches are in v6.14 now. I'm asking stable to take these
> > > whenever you are ready. Would that be v6.14-rc1? I can send a reminder
> > > if you like.
> > 
> > Yes, we have to wait until changes are in a -rc release unless there are
> > "real reasons to take it now" :)
> > 
> > > > Also what about 6.12.y and 6.13.y for those commits that
> > > > will be showing up in 6.14-rc1?  We can't have regressions for people
> > > > moving to those releases from 6.6.y, right?
> > > 
> > > The upstream commits have Fixes tags. I assumed that your automation
> > > will find those and apply them to those kernels -- the upstream versions
> > > of these patches I expect will apply cleanly to recent LTS.
> > 
> > "Fixes:" are never guaranteed to show up in stable kernels, they are
> > only a "maybe when we get some spare cycles and get around to it we
> > might do a simple pass to see what works or doesn't."
> > 
> > If you KNOW a change is a bugfix for stable kernels, please mark it as
> > such!  "Fixes:" is NOT how to do that, and never has been.  It's only
> > additional meta-data that helps us out.
> > 
> > So please send us a list of the commits that need to go to 6.12.y and
> > 6.13.y, we have to have that before we could take the 6.6.y changes.
> 
> 903dc9c43a15 ("libfs: Return ENOSPC when the directory offset range is
> exhausted")
> d7bde4f27cee ("Revert "libfs: Add simple_offset_empty()"")
> b662d858131d ("Revert "libfs: fix infinite directory reads for offset dir"")
> 68a3a6500314 ("libfs: Replace simple_offset end-of-directory detection")
> b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset
> directories")

Cool, thanks for the list (and not all were marked with fixes, i.e.
those reverts, I guess we need to start checking for reverts better.  I
have tooling set up for that but not integrated yet...)

I'll just queue them all up now.

greg k-h

