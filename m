Return-Path: <linux-fsdevel+bounces-57562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15312B23757
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A456D188D9DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40C32FDC23;
	Tue, 12 Aug 2025 19:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2UeCntq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9326FA77;
	Tue, 12 Aug 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025790; cv=none; b=m9rXZc40Wa+5YDuXE1P3xJ99vqJWtQztk+cywafWKFaXGS26rl7lHdUsK1RBJ8/qvUFo0BpETTpEc02dI1g21yuAN3mAxStdMMeyQ0WvPBk4UenSJ10BPMGVhGppocBzCvMcm7Lu9TiUQW96KEycGMFpOBDuSJ5UZIkv1F1I5vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025790; c=relaxed/simple;
	bh=d54LMYnpPd/sP0dZCdArNEXk6S+lyQEQenidbe/XHOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXUIGhrYNlWQvcuN349UD7tohBkC5Ex/zSnh107b2QNzfzF50CFq/PABWxFqFbkGFO/Z3TktXqXfMICFOYcPWxueDapMlVJHVZ1p7pxPpWe/takBqRqtw5CzOHuR2WvfGwA/iXInGampk8+tSydVIYuNB80NZtVCfoZAFWsanW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2UeCntq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B369AC4CEF0;
	Tue, 12 Aug 2025 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755025789;
	bh=d54LMYnpPd/sP0dZCdArNEXk6S+lyQEQenidbe/XHOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2UeCntqLvT4zk4aI07HYtGEbpQY6LnMMy9ppfswqjIFNnWN8V0hCQPQpUmkewVoa
	 da6mIedsHXP3+40SpRpPfiH+zIjHF6kUuDE7ovpH+83BzQVH+p5nZ2byo95tD4CnCs
	 G0LWelfYmd4xENOvimxlx7S7bF7f5wSN/8xEiTIesur8X5q3MieHOc4Fgyw5ebgKli
	 q66XqzMIwNz4wq0beWeNUt3hcBjcqN+SETltydqmXXOywhJZmQsAlMxezd841Z88Gw
	 szhYL8bgXyjjhiQWD1baK47oJP39kePjGILlouctUjKcvbOFZk1K3DF+L1b6dcomDU
	 AIrKl05RUDIog==
Date: Tue, 12 Aug 2025 12:09:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	david@fromorbit.com, ebiggers@kernel.org
Subject: Re: [PATCH RFC 12/29] fsverity: expose merkle tree geometry to
 callers
Message-ID: <20250812190949.GN7965@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-12-9e5443af0e34@kernel.org>
 <20250811114813.GC8969@lst.de>
 <20250811153822.GK7965@frogsfrogsfrogs>
 <20250812074208.GB18413@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812074208.GB18413@lst.de>

On Tue, Aug 12, 2025 at 09:42:08AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 11, 2025 at 08:38:22AM -0700, Darrick J. Wong wrote:
> > > Just curious, why does xfs need this, but the existing file systems
> > > don't?  That would be some good background information for the commit
> > > message.
> > 
> > Hrmmm... the last time I sent this RFC, online fsck used it to check the
> > validity of the merkle tree xattrs.
> 
> I saw a few users, so it does get used.  But patches exporting something
> should in generaly document what the use case is.
> 
> > > > +	if (!IS_VERITY(inode))
> > > > +		return -ENODATA;
> > > > +
> > > > +	error = ensure_verity_info(inode);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	vi = inode->i_verity_info;
> > > 
> > > Wouldn't it be a better interface to return the verity_ino from
> > > ensure_verity_info (NULL for !IS_VERITY, ERR_PTR for real error)
> > > and then just look at the fields directly?
> > 
> > They're private to fsverity_private.h.
> 
> Indeed.  Is ensure_verity_info ven the right thing here?  I.e.
> should quering the paramters create the info if it wasn't there
> yet?

I think it's usually the case that we're about to access the merkle tree
anyway, so the next step in whatever we're doing would load it for us.

--D

