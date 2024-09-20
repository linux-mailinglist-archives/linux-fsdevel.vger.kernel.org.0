Return-Path: <linux-fsdevel+bounces-29730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6C697CFB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 02:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A7B212FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 00:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B4DAD51;
	Fri, 20 Sep 2024 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="AiQ83Kzf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941D279D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Sep 2024 00:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726792970; cv=none; b=PlvMOMJNJtEcjyHHJ3u25z1GJgbvGVEaSmuckWpGB+mv/j9319iuAKeNPppBVzNsMbB7OoXdt2HOIJor27rqdBukqpsj+aQ+2fEIbAz4kCa6EPCXa+3KwwCKQTDKZAz7+CwISZ7Jx6Xl6TrO1CaE7MtsUyyHUyxpTdSmI5oflac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726792970; c=relaxed/simple;
	bh=bFtinnovh5vLEeTLfn+vl7VLXWccvPmWwmSuT2imTuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIcG+hBearrTrsgdP+xevLccOQhO9fJjGfqtGyN9anj4xJb4lWN94d685n4p4NTWGWvhkBKL8WjrPJvOqHJPuIZc+1KDvmdg4mH4L9IF8lV5jKIX6pfbtj2lBmPBzJqCFbaaD/6m4cPhSiROP2c3NX2y9jyOGILkGrkrx2s3S+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=AiQ83Kzf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-717934728adso1085925b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Sep 2024 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1726792967; x=1727397767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MY0JJo/oMJBA3e2NMoLOGcbbcWqLJcvIZ8eNVWQX/cA=;
        b=AiQ83Kzf9N1gm7KNkmChstCLcyEqT+A5c2Z49de4PXeeNQLA1b2IAW53T5aaQH34Ch
         8A6HLJGwuPa9tLCYLT+Hv3dUPYFrckBOm+LOLaUbfHtQJSUp+EoAkMpbv6lgiBgv+GKi
         tU9LsIr/mgi4qu4FHRBA4XU24kXAFynrewyEI19YyDh1nzix0qMSOgEyfo/i7ebt7Fsn
         2oOGrOxuOSyCXtb84iNo+id7lWKT6qfVOcyMI/4dGn6My1inbAXRbsHDoLIzXE7BFGOP
         5kgAwdYGDUrn5rvOJqh66o/ojqBjjqXaDHjTpx7vlfGeXefFFU7abfPqSERD9jfrxGs8
         EP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726792967; x=1727397767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY0JJo/oMJBA3e2NMoLOGcbbcWqLJcvIZ8eNVWQX/cA=;
        b=gAfgS4FpKZ5tT4miGdvh6RIBa6Xo1Im1HtR0JdtKEYVtFhKJ9lGq6wX66C3YBAzLkR
         ss078xbkrm3avsxOX+MyBN+97nkCgOo39dnxMrfx3MTl1IhkSPmLTG2YhfO6J7iOFt4v
         az5CuUn2Qdmqsx+gHas+XrN9YH9W/dAzsq65Tsd6rY7R4wYcE1MDiHVhKBH80UZ+sFNC
         TG/iyWGXE6V1EAMX/CTVHk3GSLNq0FSExRSMaD7tuhjridUq67eZdjIhgS/+4SRi8Ao0
         ubZiS3dsZuIw0EstDZEIFlEgYjsiLNVAiT1UWCBRbmgL9bhxoLoSbhWB9kmdUZuq8Q1q
         eG3w==
X-Forwarded-Encrypted: i=1; AJvYcCU0MF5Vt9JxbEmx+akisHjTwIWurMubqFFFAzxH2E0wVhX52NMNPv5z4KBbpnwSzsT3UZudSx9yQaIGgGUi@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHsfcVZt2X8B6p/SynjzjUf64zJQOWnX8QW5F1jERuGpRoXDV
	csd+CUIwGXwr2hcG8jUysryKuAPYy0ggQci2fPzxo2OaekkgkOETt/PUwvG0frw=
X-Google-Smtp-Source: AGHT+IHMizvNL8DBIqd03kD4SfbFvEUYpBCBHuI9Cu+3ltczYFeIn2YCsCzAG7NR5lgFC6J9qepP8g==
X-Received: by 2002:a05:6a00:80a:b0:718:d96d:34d7 with SMTP id d2e1a72fcca58-7199c96d8a3mr1363999b3a.3.1726792966755;
        Thu, 19 Sep 2024 17:42:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944b7b1a2sm8864982b3a.132.2024.09.19.17.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 17:42:46 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1srRjP-007SbO-2C;
	Fri, 20 Sep 2024 10:42:43 +1000
Date: Fri, 20 Sep 2024 10:42:43 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/12] iomap: zeroing already holds invalidate_lock
Message-ID: <ZuzFA81MEz3/VO+M@dread.disaster.area>
References: <20240910043949.3481298-1-hch@lst.de>
 <20240910043949.3481298-9-hch@lst.de>
 <20240917212935.GE182177@frogsfrogsfrogs>
 <20240918051523.GC31238@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918051523.GC31238@lst.de>

On Wed, Sep 18, 2024 at 07:15:23AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 02:29:35PM -0700, Darrick J. Wong wrote:
> > On Tue, Sep 10, 2024 at 07:39:10AM +0300, Christoph Hellwig wrote:
> > > All callers of iomap_zero_range already hold invalidate_lock, so we can't
> > > take it again in iomap_file_buffered_write_punch_delalloc.
> > > 
> > > Use the passed in flags argument to detect if we're called from a zeroing
> > > operation and don't take the lock again in this case.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/buffered-io.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index 52f285ae4bddcb..3d7e69a542518a 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1188,8 +1188,13 @@ static void iomap_write_delalloc_release(struct inode *inode, loff_t start_byte,
> > >  	 * folios and dirtying them via ->page_mkwrite whilst we walk the
> > >  	 * cache and perform delalloc extent removal. Failing to do this can
> > >  	 * leave dirty pages with no space reservation in the cache.
> > > +	 *
> > > +	 * For zeroing operations the callers already hold invalidate_lock.
> > >  	 */
> > > -	filemap_invalidate_lock(inode->i_mapping);
> > > +	if (flags & IOMAP_ZERO)
> > > +		rwsem_assert_held_write(&inode->i_mapping->invalidate_lock);
> > 
> > Does the other iomap_zero_range user (gfs2) take the invalidate lock?
> > AFAICT it doesn't.  Shouldn't we annotate iomap_zero_range to say that
> > callers have to hold i_rwsem and the invalidate_lock?
> 
> gfs2 does not hold invalidate_lock over iomap_zero_range.  But
> it also does not use iomap_file_buffered_write_punch_delalloc at
> all, which is what requires the lock (and asserts that it is held).

Not a fan of this dichotomy.  It means that filesystems that don't
support IOMAP_DELALLOC don't need to hold the invalidate lock to
zero, but filesystems that do support IOMAP_DELALLOC do need to hold
it.

I'd kinda prefer there be one locking rule for all callers; it makes
it much easy to determine if the callers are doing the right thing
without needing to know if the filesystem is IOMAP_DELALLOC capable
or not. At minimum, it needs to be clearly documented.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

