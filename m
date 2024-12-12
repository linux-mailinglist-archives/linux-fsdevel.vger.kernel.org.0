Return-Path: <linux-fsdevel+bounces-37131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266729EDF68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 07:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872251889921
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978BC1E231C;
	Thu, 12 Dec 2024 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlAcmTPb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C776C176AB7;
	Thu, 12 Dec 2024 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984803; cv=none; b=Jxt9/09hRAhun8clXQw+Q0as8ZYtfVsVGdmEWdQ82dIGY9XAJWMZ2iAHW0BWGnEbTadAPVjO+mDz48fY/pmHtKILsZCVOg1hkZr2RuIQlw35HU7lJmGgekL+uw48abf6FrRw00kpoApb57UQR1aeVsZFQEjQJsv8+cE5V/kTISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984803; c=relaxed/simple;
	bh=XQruZGOTyrJdtqFjcbVHpYEPxwAHpb9GbuWvKvlq7/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDLFU37ArrmNyZ70UdwLKhSZdExUcUVpFSX+wsnZcNasy1+z2NiJiU9HLuQa+vIzSBzvGQ1mMyw+GVPyFJZ/czF3TpEYPwMOfcBU0nWuSpwOApP1Y4kYwTS/nKxFdACQ+D0MXKlUxsqU5jV5PdfHStXlT9KVX1V8fHgJ7LClaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlAcmTPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46748C4CECE;
	Thu, 12 Dec 2024 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733984802;
	bh=XQruZGOTyrJdtqFjcbVHpYEPxwAHpb9GbuWvKvlq7/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlAcmTPb8nK8E78bQx3waDJV3UQui5hnqgyO5NNL96V8DfL+BuUAIp4bAwte1kx2E
	 dl+EhoSguJK1ia+UlgNYqR0EdbsNlizneib7Q/xLZoNPgDCSjdoYd4U2LdZiJ/5Hfj
	 jt5FWhfUpkLA1gBlFG/6AaGj2KW0VndCcd+NI+WOzIaztgRER7LN5jo5O8LmAol9jF
	 /rFZkh/7pO0sFbcnMtj0YHesrX+uew8Atw8jDghm+WL+dow2IYn7RhvvqhKEqhh5AK
	 kaLoTht+hlnjjk7JNNAexi6crkqWz+ABungcUo0ZZTuZUfGItnQBzB5QwG6d3iCF3+
	 RQijc0MYNt/eQ==
Date: Wed, 11 Dec 2024 22:26:41 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	bfoster@redhat.com
Subject: Re: [PATCH 14/17] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <20241212062641.GD6678@frogsfrogsfrogs>
References: <20241114152743.2381672-2-axboe@kernel.dk>
 <20241114152743.2381672-16-axboe@kernel.dk>
 <Z1p5my4wynAW_Vc3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1p5my4wynAW_Vc3@infradead.org>

On Wed, Dec 11, 2024 at 09:50:19PM -0800, Christoph Hellwig wrote:
> On Thu, Nov 14, 2024 at 08:25:18AM -0700, Jens Axboe wrote:
> > +	if (iocb->ki_flags & IOCB_UNCACHED)
> > +		iter.flags |= IOMAP_UNCACHED;
> >  
> > -	while ((ret = iomap_iter(&iter, ops)) > 0)
> > +	while ((ret = iomap_iter(&iter, ops)) > 0) {
> > +		if (iocb->ki_flags & IOCB_UNCACHED)
> > +			iter.iomap.flags |= IOMAP_F_UNCACHED;
> 
> iomap.flags and the IOMAP_F_* namespace is used to communicate flags
> from the file system to the iomap core, so this looks wrong.

Not entirely true -- IOMAP_F_SIZE_CHANGED is used to communicate state
from iomap to gfs2, and IOMAP_F_STALE is set/checked only by the iomap
core.  iomap.h even says as much.

Though given that there's a 4-byte gap in struct iomap between flags and
the bdev pointer (at least on 64-bit) maybe we should make a separate
field for these iomap state bits?

> >  	size_t poff = offset_in_folio(folio, pos);
> >  	int error;
> >  
> > +	if (folio_test_uncached(folio))
> > +		wpc->iomap.flags |= IOMAP_F_UNCACHED;
> 
> I guess this is what actually makes it work.  Note that with the iomap
> zoned series I posted yesteday things change a bit here in that the flags
> in the wpc are decouple from the iomap flags, and this would now become
> a wpc only flag as it isn't really a fs to iomap cummunication, but
> based on iomap / page cache state.

Hrmmm I'll go take a second look at that patch in the morning in case a
better idea comes along.

--D

