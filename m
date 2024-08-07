Return-Path: <linux-fsdevel+bounces-25205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E9949CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 02:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3FC1F24565
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 00:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE6BE49;
	Wed,  7 Aug 2024 00:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovDM0GvI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5812F46;
	Wed,  7 Aug 2024 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722990239; cv=none; b=K321l14QRHplk8mGX4KAUbXGjcdvEwZMi/Hw5hv1ByG/iK++ZPKC3lFmtcEs9mSjIjKHIJL67j4Pn+/qNZvDeo43RZvk/IcrT4AGW4FA3q/ZXhBBGpeSEL6UATeyGKh8l22aqheo7BT7tJ+NkR2ObniJGdQizRsOpj3k3ZN7Vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722990239; c=relaxed/simple;
	bh=q9ULJ+X29HEXGtzEQOxWm0YMR6/9uherYEW1V/5HCdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6iemfF1/J3cMcvi13SIArTFWurzzCCWqUKAjPAheGRw0BO2OOLDxot8h1ocYm8SaT9fHO0qc2U5X1WgvS5hQ+/i5Z5KvGBtW70wBIh0BP6vCWl1SiEx6uJRDePKLHDbDf3+FpbUw7crZWO5qEf/XRrrCdnCXgsSC4MGFGWUjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovDM0GvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A83FC32786;
	Wed,  7 Aug 2024 00:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722990239;
	bh=q9ULJ+X29HEXGtzEQOxWm0YMR6/9uherYEW1V/5HCdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovDM0GvIWXizZyHPLhZx0+tmZ7grLGf58T6Fs320xqggVTiKUslWk7UBugUgzTLZa
	 P4MeFEcOGkvK0rWCblW4ZEk0gKgEi37xx9vRpUmSKuA/f6KCVHF1ps8hBg2QCVIA3a
	 yiVC0jJ+EKk0TtWhU8/tfuUO3UZPsf3yZO4XgNRyEZ3hEk04HBS8EuOCZbMIR6fRyB
	 sU+W9+xciqq1U4pUOIiiWtvjoPNieOS0HAKw8vOBEboK634JU45pH1ey6C+eTNSvDl
	 5m5HJeuEsPe2sPtCCmCqohmQvCIAIZmwzPQqbu4HMKK6YgBK52qD+/tFftG6YfyDoE
	 uX8QUdFtc0tZw==
Date: Tue, 6 Aug 2024 17:23:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, chandan.babu@oracle.com,
	dchinner@redhat.com, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v3 03/14] xfs: simplify extent allocation alignment
Message-ID: <20240807002358.GQ623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-4-john.g.garry@oracle.com>
 <20240806185651.GG623936@frogsfrogsfrogs>
 <ZrK3JlJIV5j4h44F@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrK3JlJIV5j4h44F@dread.disaster.area>

On Wed, Aug 07, 2024 at 09:52:06AM +1000, Dave Chinner wrote:
> On Tue, Aug 06, 2024 at 11:56:51AM -0700, Darrick J. Wong wrote:
> > On Thu, Aug 01, 2024 at 04:30:46PM +0000, John Garry wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > We currently align extent allocation to stripe unit or stripe width.
> > > That is specified by an external parameter to the allocation code,
> > > which then manipulates the xfs_alloc_args alignment configuration in
> > > interesting ways.
> > > 
> > > The args->alignment field specifies extent start alignment, but
> > > because we may be attempting non-aligned allocation first there are
> > > also slop variables that allow for those allocation attempts to
> > > account for aligned allocation if they fail.
> > > 
> > > This gets much more complex as we introduce forced allocation
> > > alignment, where extent size hints are used to generate the extent
> > > start alignment. extent size hints currently only affect extent
> > > lengths (via args->prod and args->mod) and so with this change we
> > > will have two different start alignment conditions.
> > > 
> > > Avoid this complexity by always using args->alignment to indicate
> > > extent start alignment, and always using args->prod/mod to indicate
> > > extent length adjustment.
> > > 
> > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > [jpg: fixup alignslop references in xfs_trace.h and xfs_ialloc.c]
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > 
> > Going back to the 6/21 posting[1], what were the answers to the
> > questions I posted?  Did I correctly figure out what alignslop refers
> > to?
> 
> Hard to say.
> 
> alignslop is basically an temporary accounting mechanism used to
> prevent filesystem shutdowns when the AG is near ENOSPC and exact
> BNO allocation is attempted and fails because there isn't an exact
> free space available. This exact bno allocation attempt can dirty
> the AGFL, and before we dirty the transaction *we must guarantee the
> allocation will succeed*. If the allocation fails after we've
> started modifying metadata (for whatever reason) we will cancel a
> dirty transaction and shut down the filesystem.
> 
> Hence the first allocation done from the xfs_bmap_btalloc() context
> needs to account for every block the specific allocation and all the
> failure fallback attempts *may require* before it starts modifying
> metadata. The contiguous exact bno allocation case isn't an aligned
> allocation, but it will be followed by an aligned allocation attempt
> if it fails and so it must take into account the space requirements
> of aligned allocation even though it is not an aligned allocation
> itself.
> 
> args->alignslop allows xfs_alloc_space_available() to take this
> space requirement into account for any allocation that has lesser
> alignment requirements than any subsequent allocation attempt that
> may follow if this specific allocation attempt fails.
> 
> IOWs, args->alignslop is similar to args->minleft and args->total in
> purpose, but it only affects the accounting for this specific
> allocation attempt rather than defining the amount of space
> that needs to remain available at the successful completion of this
> allocation for future allocations within this transaction context.

Oh, okay.  IOWs, "slop" is a means for alloc callers to communicate that
they need to perform an aligned allocation, but that right now they want
to try an exact allocation (with looser alignment) so that they might
get better locality.  However, they don't want the exact allocation scan
to commit to a certain AG unless the aligned allocation will be able to
find an aligned space *somewhere* in that AG if the exact scan fails.
For any other kind of allocation situation, slop should be zero.

If the above statement is correct, could we paste that into the
definition of struct xfs_alloc_arg so that I don't have to recollect all
this the next time I see something involving alignslop?  After which
I'm ok saying:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

