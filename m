Return-Path: <linux-fsdevel+bounces-42593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6EAA448A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76D317A2D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB719CC34;
	Tue, 25 Feb 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFTZCFEK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78EC198A19;
	Tue, 25 Feb 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504837; cv=none; b=Yr9lKZvM+Ho+Ke2OWWk/wR27DxY4tWKP5YKOO0WILltxQTU6bocgxQnEKAgElhgYM7x7xUefdmrYrAiKXcuHGfOgshfWXZ024O9mMoqevCHjze2ikdLFhQ1lcZbxvAspmqxT89S1YsRMa0kOlNGJFTjDHdO9zVKJZ+2ziOpwBpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504837; c=relaxed/simple;
	bh=HEeE6nVudlw77jbt7B9nhzAlyX66hpjtkyvyw8dcu4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGvCKRyD9OrUEvrefp+TYBZDbHcXOK1o1X/8YTsbsaHz7ilgG88AOGCY4AHs7vK5UWWPG9PeQymz2tkZNekz5R9hMKZMgmknmJwWvDmocoW7ShS1weZaeHmCukT4RGUCfams6dZZkchO3MEqTfDt+BcaCSsMja1eeRW/L+07erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFTZCFEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC74BC4CEDD;
	Tue, 25 Feb 2025 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740504836;
	bh=HEeE6nVudlw77jbt7B9nhzAlyX66hpjtkyvyw8dcu4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFTZCFEKRHiP/y2phEnJ97KO+7eTF1mkzlrKWkYZ2bF/0DUX6jn4qhAA9yrkjOAr1
	 dh/HPY1irq9EhSYrtQIq0OSCdx3e0/yZYGMsFHJ+GsKqA0AFFLuRE/CYCX7KrsjeSD
	 MEWL9JbG2yLb+R6XBbQf+xAwLkreqUlURTACr1uNqPq3KJwjnigCxhOAJXT+FK95p6
	 Y2KVe6xEg780MHOJ+9etKGC7W9ik2Qrksvc5xKMKgjedcQiEnbEVALmyEDu3rs6Ft0
	 eBBjyNwLOYfbikCKczlmQM3nuAf7AeL8HcSRa+eT5vqukS5dbB3ui6g2E86rS3Ftqq
	 h+LHQ1fuORqDg==
Date: Tue, 25 Feb 2025 09:33:56 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 04/11] iomap: Support CoW-based atomic writes
Message-ID: <20250225173356.GD6242@frogsfrogsfrogs>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-5-john.g.garry@oracle.com>
 <20250224195912.GC21808@frogsfrogsfrogs>
 <c3958187-e83e-46a1-a204-87b342583a4a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3958187-e83e-46a1-a204-87b342583a4a@oracle.com>

On Tue, Feb 25, 2025 at 10:19:49AM +0000, John Garry wrote:
> On 24/02/2025 19:59, Darrick J. Wong wrote:
> > > + * ``IOMAP_ATOMIC_COW``: This write is being issued with torn-write
> > > +   protection based on CoW support.
> > I think using "COW" here results in a misnamed flag.  Consider:
> > 
> > "IOMAP_ATOMIC_SW:
> 
> ok, fine
> 
> > This write is being issued with torn-write protection
> > via a software fallback provided by the filesystem."
> 
> I'm not sure that we really need to even mention software fallback. Indeed,
> xfs could just use IOMAP_ATOMIC_SW always when the bdev does not support HW
> offload. Maybe I can mention that typically it can be used as a software
> fallback when HW offload is not possible.

Ok, a software mechanism then.

> > 
> > iomap itself doesn't care*how* the filesystem guarantees that the
> > direct write isn't torn, right?
> 
> Correct. iomap just ensures that for IOMAP_ATOMIC_HW we produce a single bio
> - that's the only check really.
> 
> > The fs' io completion handler has to
> > ensure that the mapping update(s) are either applied fully or discarded
> > fully.
> 
> right
> 
> > 
> > In theory if you had a bunch of physical space mapped to the same
> > file but with different unwritten states, you could gang together all
> > the unwritten extent conversions in a single transaction, which would
> > provide the necessary tearing prevention without the out of place write.
> > Nobody does that right now, but I think that's the only option for ext4.
> 
> ok, maybe. But ext4 still does have bigalloc or opportunity to support
> forcealign (to always use IOMAP_ATOMIC_HW for large untorn writes).

<nod>

--D

> Thanks,
> John
> 
> 
> 
> 

