Return-Path: <linux-fsdevel+bounces-14015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CA5876964
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 18:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F459B22437
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD640873;
	Fri,  8 Mar 2024 17:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gKgJaFyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC528DC3
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918006; cv=none; b=qlsJ0XP8GovJHxJ8GUT4Czc5jwaJ3F37Sh4HXWhxEszjbOLfkkpEtyHIf7XwaJiiWP6e0txVmI48s6YnRdFGNu4q8lgalFCa8bsqV0b6AB0i/kcuSagVgDsBCrc7llSlpxX3OVr3YP+Vyf88nBI/Nwtq0M3Kxc7yxFvJGBar2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918006; c=relaxed/simple;
	bh=7Xu6eZCzCVliCAZZme0wZBJGDCt14tP5UMVuvQ4xw/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKhlI37AT/sjWObMAx2kGLXMMNNzLwgCyy3a7P7aCxjCSDYfXfi57BLuLamfEe4qWcXd6rryYtEDgLbYq92AaAlPD6NpDLcO4TJCVjEVdBjovSrtVjCB/9/KE4/K0moXhi6MEwZsYvFsGyN9ZzNK5rkPu+dLFyp2wuyINx86MGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gKgJaFyU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 8 Mar 2024 12:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709918002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/ZGm97f9Vx3dMv4Q4ZF92Mt8t0Jy8x8fbbYpW0hUz0=;
	b=gKgJaFyUdAaj+GtRl0l7T4brse8kJ+I5o8KpA1mSNxkFfrrXV1QQgh/thdpH4oqfVf4SOv
	UtJw92+UPgU2yOjM4cf2OIrZcQgZ1xK8Af+ReQADA7x8bPLG1aL1wl2eYsjRXDfsRpPD23
	ojLZKJnsNZSjIpgStzoF/6saJH9xdJo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>, linux-fsdevel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <6czkpcm4gxcjik3drcy6eys6lannfk55oowdesem2qr3gfgobw@lblo3vzck43e>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com>
 <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
 <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
 <2uk6u4w7dp4fnd3mrpoqybkiojgibjodgatrordacejlsxxmxz@wg5zymrst2td>
 <20240308165633.GO6184@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308165633.GO6184@frogsfrogsfrogs>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 08, 2024 at 08:56:33AM -0800, Darrick J. Wong wrote:
> On Fri, Mar 08, 2024 at 11:48:31AM -0500, Kent Overstreet wrote:
> > It's a new feature, not a bugfix, this should never get backported. And
> > I the bcachefs maintainer wrote the patch, and I'm submitting it to the
> > VFS maintainer, so if it's fine with him it's fine with me.
> 
> But then how am I supposed to bikeshed the structure of the V2 patchset
> by immediately asking you to recombine the patches and spit out a V3?
> 
> </sarcasm>
> 
> But, seriously, can you update the manpage too?

yeah, where's that at?

> Is stx_subvol a u64
> cookie where userspace mustn't try to read anything into its contents?
> Just like st_ino and st_dev are (supposed) to be?

Actually, that's up for debate. I'm considering having the readdir()
equivalent for walking subvolumes return subvolume IDs, and then there'd
be a separate call to open by ID.

Al's idea was to return open fds to child subvolumes, then userspace can
get the path from /proc; that's also a possibility.

The key thing is that with subvolumes it's actually possible to do an
open_by_id() call with correct security checks on pathwalking - because
we don't have hardlinks so there's no ambiguity.

Or we might do it getdents() style and return the path directly.

But I think userspace is going to want to work with the volume
identifiers directly, which is partly why I'm considering why other
options might be cleaner.

Another thing to consider: where we're going with this is giving
userspace a good efficient interrface for recursive tree traversal of
subvolumes, but it might not be a bad idea to do that for mountpoints as
well - similar problems, similar scalability issues that we might want
to solve eventually.

> Should the XFS data and rt volumes be reported with different stx_vol
> values?

Maybe?

