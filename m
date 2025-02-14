Return-Path: <linux-fsdevel+bounces-41705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E8CA356AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 07:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7705916C7E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1D18C924;
	Fri, 14 Feb 2025 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JjbvjgAY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E93A8D2;
	Fri, 14 Feb 2025 06:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739512843; cv=none; b=KPbXNv2EjtxOAecQursNnFHHjH7j0p9UVsrkOI6y6PNTozG8VxikpStDrSKTO1lFmtZxmMiZRVuHE4Ga/PoF1r/fLaBmSzpVIzuLj4ofMMSoBnHRdcsb3fdI/agKfX4052n6Mh8Gwfhz4mbQvlaUiB+xlpQ5w+/6whb5oefkUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739512843; c=relaxed/simple;
	bh=DaVOiziFXl78B+bxFbLVaWv19NAi05WiDkuJRWtv44I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIOfgSZGt01twsGN2wtrbxWbVXEunzk/tX8lFlTYuql4+DxPT/nHQwDo5k0hfMBqOjoR7W7dSGHBNEVMf2gRaRwJ4ZWg9mScP1b4x3Sji+jw8wKvJ09YAc06if58pAD/TPr42A7e4PZOkd9mlMiCfl3Ws05rckJXbTpupbPQjy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JjbvjgAY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eRVRQY++3vK/5icTHcaDFA7ISU9JfGWdRyZCWVimcOM=; b=JjbvjgAYRd8tiknxh79pm51jF0
	nMG/XH8K6UcLz82uusTQZ/sPgXaBZkQYOypQJI9QPVJ3Ugu7qZuW06sGeP4YDcHuG2GfQwVdaFkJZ
	MM2X95i+4mGarQX3Lry3UwhTBKPHzZifmD1DWBGYs2mRPuADv9zXyoTUtbfFInhu4UDPtVWQyqbwD
	dkKUtmu20cckkyBYRwMirvwNH6IqIV8Yn+5wgBiF2SrZRISLtgUlKE9H1OqWAgO9y48PhRZFiaybF
	uTGi7es882z6GrqfOacevqyz+UtyFeWCGTGybpL1zS4um5EEYkMtyC2Qq/pV+uXQaUx0AGkCxYNF2
	Z1hW4gtg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiokh-0000000DPs0-19Ot;
	Fri, 14 Feb 2025 06:00:39 +0000
Date: Fri, 14 Feb 2025 06:00:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3} Change ->mkdir() and vfs_mkdir() to return a dentry
Message-ID: <20250214060039.GB1977892@ZenIV>
References: <20250214052204.3105610-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214052204.3105610-1-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 14, 2025 at 04:16:40PM +1100, NeilBrown wrote:
> This is a small set of patches which are needed before we can make the
> locking on directory operations more fine grained.  I think they are
> useful even if we don't go that direction.
> 
> Some callers of vfs_mkdir() need to operation on the resulting directory
> but cannot be guaranteed that the dentry will be hashed and positive on
> success - another dentry might have been used.
> 
> This patch changes ->mkdir to return a dentry, changes NFS in particular
> to return the correct dentry (I believe it is the only filesystem to
> possibly not use the given dentry), and changes vfs_mkdir() to return
> that dentry, removing the look that a few callers currently need.
> 
> I have not Cc: the developers of all the individual filesystems - only
> NFS.  I have build-tested all the changes except hostfs.  I can email
> them explicitly if/when this is otherwise acceptable.  If anyone sees
> this on fs-devel and wants to provide a pre-emptive ack I will collect
> those and avoid further posting for those fs.

1) please, don't sprinkle the PTR_ERR_OR_ZERO() shite all over the place.
Almost always the same thing can be done without it and it ends up
being cleaner.  Seriously.

2) I suspect that having method instances return NULL for "just use the
argument" would would be harder to fuck up; basically, the same as for
->lookup() instances.  I'll try to tweak it and see what falls out...

3) I'm pretty sure that NFS is *not* the only filesystem that returns
unhashed negative in some success cases; will need to go over the instances
to verify that, though.

