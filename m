Return-Path: <linux-fsdevel+bounces-13946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0595C875A40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3761D1C212F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FF13F430;
	Thu,  7 Mar 2024 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNAfbvZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDD1369A6;
	Thu,  7 Mar 2024 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850384; cv=none; b=V1zmGD3w0TRJsyHzEN3OhQjU3249oYR3DLufgIxaH745POt5ixonzSq7efxUHjYO7l3fcOoe5q+NhgKKtxv1GeB6f1mNZ7zluH7Sl4IXmOCY2NYEckoiLDoD05Tf7vF8zWHkAqE+aE6tVGsdYPSDkJRiR0PvDZ1S01WvavvubrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850384; c=relaxed/simple;
	bh=0QiWJrwvZMl0+K+oRAlQrppQVgwIWJnVntzVwLb0i1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkWFTh8jKY3VWEPMYVIXtg/QtW0lMMiEoxtVOWq0O5itc/1mduXTounkWYehOD8VeeiOcBUmS/TqOq8nAKmcWAU8yr0ppmmPHVkHfzSeLwWB9h0BNQfhO0tIKn7laf+01M43tOnlkVXgNwfuuXbfBJ+smj9VZZL9OGJ2g1EJxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNAfbvZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E31C433C7;
	Thu,  7 Mar 2024 22:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850383;
	bh=0QiWJrwvZMl0+K+oRAlQrppQVgwIWJnVntzVwLb0i1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNAfbvZ8Vu9KDLYWFK6AmwGVE5JwNwf1I9Tm/ckVCiwR2+SlYDat8JShjV8lECMGl
	 FcQ4kt3rBNEXfcjVJNi+6sWifqAqfJs15+TismYlWGpEqwnqD14dY/mNjxqndWVZl1
	 v+Rtgmk0mr7EbTsKf7BsrV0+/HXAOBQB868PXv7O5nqe/qKo4kr8RQ53GFpDBHHDD0
	 C9RkgQGSG/6m2OUOFQfjYkMqSPnotM/tAlc2aVG0n5MMY4kzz6zjeUk+/iE9gGkPow
	 4oTC2Ps+zq7pauo3/j3rS/kbzHdQxnvPNzPU7Mic9QC4wzWU+uuq140FLRcv5npktU
	 8ShAbyMxY4YiQ==
Date: Thu, 7 Mar 2024 14:26:22 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 08/24] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240307222622.GD1799@sol.localdomain>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-10-aalbersh@redhat.com>
 <20240305010805.GF17145@sol.localdomain>
 <20240307215857.GS1927156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307215857.GS1927156@frogsfrogsfrogs>

On Thu, Mar 07, 2024 at 01:58:57PM -0800, Darrick J. Wong wrote:
> > Maybe s_verity_wq?  Or do you anticipate this being used for other purposes too,
> > such as fscrypt?  Note that it's behind CONFIG_FS_VERITY and is allocated by an
> > fsverity_* function, so at least at the moment it doesn't feel very generic.
> 
> Doesn't fscrypt already create its own workqueues?

There's a global workqueue in fs/crypto/ too.  IIRC, it has to be separate from
the fs/verity/ workqueue to avoid deadlocks when a file has both encryption and
verity enabled.  This is because the verity step can involve reading and
decrypting Merkle tree blocks.

The main thing I was wondering was whether there was some plan to use this new
per-sb workqueue as a generic post-read processing queue, as seemed to be
implied by the chosen naming.  If there's no clear plan, it should instead just
be named after what it's actually used for, fsverity.

- Eric

