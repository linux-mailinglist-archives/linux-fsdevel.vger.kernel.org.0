Return-Path: <linux-fsdevel+bounces-38667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C878A0639E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 18:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971D73A1D15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1128E20102E;
	Wed,  8 Jan 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrY5i/88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB11FF1A5;
	Wed,  8 Jan 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358137; cv=none; b=X3io7nlCurQZRThmv3NvrUFj93W+bg2XffUVsrf38qgVh3dES0MJ5hMoqdAsYuZ69i2KZLU3o+7g7zv8iJQbqldoM3+EIVifdJY5SfjKEz9e6fIWo3Zvt88p7cJZ/reHYCkBWvUoFtWMJcoyMWeva/jB+W9ePX2hRHNavRGi8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358137; c=relaxed/simple;
	bh=32pOxZlcUILokTHCOAjxQ+XhQsNVIvJj21fdapehVOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itW12POppM1A5MykcR0XH1CkMAor6aepzXxxcGnavmnoOWWtw1fMfTaWc09VC1QRbzo8IVc5QcAHPqQ6wgoAFfmB+l8NcVhXyQcCIEwRko3zkAkXvm9rWviu54bRXidl1H165o0hZen5CANA3ojFMcWZygSK9TQwyldQ/QZDAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrY5i/88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C5CC4CED3;
	Wed,  8 Jan 2025 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358137;
	bh=32pOxZlcUILokTHCOAjxQ+XhQsNVIvJj21fdapehVOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JrY5i/884uO+sU2FSUyFImbrxuoCfbl12uYXg2Cz/36ZML3ph54qbCn9kDk0zctWp
	 fC+6Ppv6d61MbRfIiENcvv2rZDuuB8wltU16s5uMz1gEc0xdwMR73kMJ/+uns8l4c0
	 UK6DIDuBNzvw76Fmiwa55FS9VFnHdaYQs4URnYr2Z3trQAXSgVg+SZp6W13ZirAmzJ
	 0UHY72RT45+YURbdibRBpUKSCZsvQxtNsipjuptJhyVfmjFgOXiBoAOn8wInFYwnpB
	 zMRyKaUkP/1PYggWtoEg+UstYDbe6rEH18XnPmkGvwM8UpNJZTcLpIhflmQ0c2Yy4A
	 1YWeEFftS0qHQ==
Date: Wed, 8 Jan 2025 09:42:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, cem@kernel.org,
	dchinner@redhat.com, ritesh.list@gmail.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: Re: [PATCH v2 2/7] iomap: Add zero unwritten mappings dio support
Message-ID: <20250108174216.GJ1306365@frogsfrogsfrogs>
References: <20241210125737.786928-3-john.g.garry@oracle.com>
 <20241211234748.GB6678@frogsfrogsfrogs>
 <4d34e14f-6596-483b-86e8-d4b7e44acd9a@oracle.com>
 <20241212204007.GL6678@frogsfrogsfrogs>
 <20241213144740.GA17593@lst.de>
 <20241214005638.GJ6678@frogsfrogsfrogs>
 <20241217070845.GA19358@lst.de>
 <93eecf38-272b-426f-96ec-21939cd3fbc5@oracle.com>
 <20250108012636.GE1306365@frogsfrogsfrogs>
 <332f29ce-4962-496e-ab37-f972c1d4aa12@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <332f29ce-4962-496e-ab37-f972c1d4aa12@oracle.com>

On Wed, Jan 08, 2025 at 11:39:35AM +0000, John Garry wrote:
> On 08/01/2025 01:26, Darrick J. Wong wrote:
> > > > I (vaguely) agree ith that.
> > > > 
> > > > > And only if the file mapping is in the correct state, and the
> > > > > program is willing to*maintain* them in the correct state to get the
> > > > > better performance.
> > > > I kinda agree with that, but the maintain is a bit hard as general
> > > > rule of thumb as file mappings can change behind the applications
> > > > back.  So building interfaces around the concept that there are
> > > > entirely stable mappings seems like a bad idea.
> > > I tend to agree.
> > As long as it's a general rule that file mappings can change even after
> > whatever prep work an application tries to do, we're never going to have
> > an easy time enabling any of these fancy direct-to-storage tricks like
> > cpu loads and stores to pmem, or this block-untorn writes stuff.
> > 
> > > > > I don't want xfs to grow code to write zeroes to
> > > > > mapped blocks just so it can then write-untorn to the same blocks.
> > > > Agreed.
> 
> Any other ideas on how to achieve this then?
> 
> There was the proposal to create a single bio covering mixed mappings, but
> then we had the issue that all the mappings cannot be atomically converted.
> I am not sure if this is really such an issue. I know that RWF_ATOMIC means
> all or nothing, but partially converted extents (from an atomic write) is a
> sort of grey area, as the original unmapped extents had nothing in the first
> place.

The long way -- introducing a file remap log intent item to guarantee
that the ioend processing completes no matter how mixed the mapping
might be.

> > > > 
> > > So if we want to allow large writes over mixed extents, how to handle?
> > > 
> > > Note that some time ago we also discussed that we don't want to have a
> > > single bio covering mixed extents as we cannot atomically convert all
> > > unwritten extents to mapped.
> > Fromhttps://lore.kernel.org/linux-xfs/Z3wbqlfoZjisbe1x@infradead.org/ :
> > 
> > "I think we should wire it up as a new FALLOC_FL_WRITE_ZEROES mode,
> > document very vigorously that it exists to facilitate pure overwrites
> > (specifically that it returns EOPNOTSUPP for always-cow files), and not
> > add more ioctls."
> > 
> > If we added this new fallocate mode to set up written mappings, would it
> > be enough to write in the programming manuals that applications should
> > use it to prepare a file for block-untorn writes?
> 
> Sure, that API extension could be useful in the case that we conclude that
> we don't permit atomic writes over mixed mappings.
> 
> > Perhaps we should
> > change the errno code to EMEDIUMTYPE for the mixed mappings case.
> > 
> > Alternately, maybe we/should/ let programs open a lease-fd on a file
> > range, do their untorn writes through the lease fd, and if another
> > thread does something to break the lease, then the lease fd returns EIO
> > until you close it.
> 
> So do means applications own specific ranges in files for exclusive atomic
> writes? Wouldn't that break what we already support today?

The application would own a lease on a specific range, but it could pass
that fd around.  Also you wouldn't need a lease for a single-fsblock
untorn write.

--D

> Cheers,
> John
> 
> 

