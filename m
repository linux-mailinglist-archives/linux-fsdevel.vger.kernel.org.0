Return-Path: <linux-fsdevel+bounces-13973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C43E875CEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBCBC282863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24C32C860;
	Fri,  8 Mar 2024 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPAVmub2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD92C859;
	Fri,  8 Mar 2024 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869981; cv=none; b=LeIH0P36H0Gn2NdDuJ6prNg2ihkBkkiTTMZJBiJZRkVxmxTGVSUGVI0Xl5jXh9SAuX8VNl2sXuA8rmEZfGiqnB/wCxYbmkCSyy097olQ8fN1YiiAKP1LaMI66jCXRL28GJFmDHQfuafvMfSXu4SmBhdNRhRFb9sw+IF9XwnO1CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869981; c=relaxed/simple;
	bh=nf34/oGdd1u2QTp/9MCu/Lp7jigT2VCX6h5YAHnDjYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSMmnzTYgm6r23OFgybousPg/G5WGXvLkbesuCHcfwiF7Z1TQG3IjHJ++FK8vswU063St+cwtoLOd3XUtP40MH7NF6x267l3uEUivY+uP4KeRFzU9/3PeoQWCgAk+YbM5WPxC/gYl40nn0/60vF/KEhRIQPba8773b1wVzJ7B8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPAVmub2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C7DC433C7;
	Fri,  8 Mar 2024 03:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709869980;
	bh=nf34/oGdd1u2QTp/9MCu/Lp7jigT2VCX6h5YAHnDjYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPAVmub29hrokl3KrRtbFqetpIPmYf3LjrwOwBT/M/dw3kCIPaEaeSkfokq6z05wA
	 C7jTDhbMBx0E6ANwgtGh8Fnwr0PGlV/CTQd9GOZeoF4Xy4BeV0EpsE+XbPUphNnY6I
	 yqWH7PRNMs1z71ursx733GcPUl+ncmIjZPmNeWXPX0unpBXuXOgeG6IxYvE2Cmhayv
	 FeDgIVJYbDWjOZsY6Vy0/Wi3YecG9JX/bfuiv4NYRMd879swnYJAPa31BpV0q9GZEG
	 3zFrTVdT+7VokJA0M+XgA/UZFDvnuXrF42/zXxRAi0vphstqTQe7yr+maOgCVtq0vG
	 Um/DG23m9Gw2w==
Date: Thu, 7 Mar 2024 19:53:00 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 08/24] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240308035300.GM1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-10-aalbersh@redhat.com>
 <20240305010805.GF17145@sol.localdomain>
 <20240307215857.GS1927156@frogsfrogsfrogs>
 <20240307222622.GD1799@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307222622.GD1799@sol.localdomain>

On Thu, Mar 07, 2024 at 02:26:22PM -0800, Eric Biggers wrote:
> On Thu, Mar 07, 2024 at 01:58:57PM -0800, Darrick J. Wong wrote:
> > > Maybe s_verity_wq?  Or do you anticipate this being used for other purposes too,
> > > such as fscrypt?  Note that it's behind CONFIG_FS_VERITY and is allocated by an
> > > fsverity_* function, so at least at the moment it doesn't feel very generic.
> > 
> > Doesn't fscrypt already create its own workqueues?
> 
> There's a global workqueue in fs/crypto/ too.  IIRC, it has to be separate from
> the fs/verity/ workqueue to avoid deadlocks when a file has both encryption and
> verity enabled.  This is because the verity step can involve reading and
> decrypting Merkle tree blocks.
> 
> The main thing I was wondering was whether there was some plan to use this new
> per-sb workqueue as a generic post-read processing queue, as seemed to be
> implied by the chosen naming.  If there's no clear plan, it should instead just
> be named after what it's actually used for, fsverity.

My guess is that there's a lot less complexity if each subsystem (crypt,
compression, verity, etc) gets its own workqueues instead of sharing so
that there aren't starvation issues.  It's too bad that's sort of
wasteful, when what we really want is to submit a chain of dependent
work_structs and have the workqueue(s) run that chain on the same cpu if
possible.

--D

> - Eric
> 

