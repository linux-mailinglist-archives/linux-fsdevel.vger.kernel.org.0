Return-Path: <linux-fsdevel+bounces-27767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38A7963ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A656E1C21088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856D1311B5;
	Thu, 29 Aug 2024 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="NWdStRSo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6213213E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911542; cv=none; b=WvIHcK8LPtnXwRe2AcxTqpIPCNXdCRTYCMop6u7xxgYH09dfYbhLAA+cbcGuhZwHfw3YMlcakCoDT0RTqofNNNuC3h6YjCjlK20LJe+P6ZOAjcedqVVJK0kYW721QqZRlmE4Z9MQkVhIJgGu3dN5uZ0d0Y9j83QAjpk90pLg4BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911542; c=relaxed/simple;
	bh=pX64lH+o8GNfl3KD9exfN771LspwUMr4sb3yZ8UNPe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlL/0h20fel6wIXio0YacCeTfvudREy4fT6lrLl4WymJF31C8Eo5LchBZ0nUYcdW0UNgPirAFE43UMvzPxd2MOtvt+0KburLSiCK2oengjbFK1t8eQ2L5/wPJf7oCtda10C4vZNxjGHCCYphecuIBP7JHTnPPaQzYVgF8KGhKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=NWdStRSo; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201fba05363so2459095ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 23:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724911539; x=1725516339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kRG8lOrqsJLRRCzxmMBQ+PwNcsiDn1Yig/sh7izq00=;
        b=NWdStRSoTpkvdkxpv6Jp1atvKbaXYEq6EA/FLiA05TlHkNEcv0G4YvldKNpFXHD0ku
         td9z2j+PT5JL1Ssqd6uhTMBVy6pWkmR4Uk0mmuFJvLK05ZjxgwlbJ8/IS25xZKPkpxfM
         71Z7eOpQ5b1F06mD/Ztaj+nxwpYV1u9NSsoloGnqwz9HxSRq2H9/N6BZ3wVyabeqEIRd
         VrpaFQospEQ01l4SZLNd9F0YiVCftyyfwaZESFDGGgu61XxTy8Frr5fNhW7QGgOBGPEz
         Mwaz00mW/9NeSJDI1wdpOoeGJiY52wLrWyord1EkmgUB1YpqP0gD4VjnxXH+kLQk/BvF
         AaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911539; x=1725516339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kRG8lOrqsJLRRCzxmMBQ+PwNcsiDn1Yig/sh7izq00=;
        b=ub4ZLpyCyxZVG4h95x0V0hVDCrH2wVVbq1VCvBncWy5aN+yoIdua0oLaKLGaAxGGdz
         L42i0Pk2zzH8bi55t8mLyPYcYmSyuaI0x1tSnTGPOVLx+/DurRJIq4D6co9k14b4GCVO
         GNS1Noq3CQgFBz79xjO/kwfIK5OBoPtA+ni2/BC0czhlK5EvLmZi7bU8WL0Fy6DeMy7R
         eBnj9u1NxAQvUAggps/wT3Ame1pXJXSIETaO60RvJHiISChDkIKtaltlu4QRr73cZhwB
         IxCMA+Dx/lfdlRUmiBlyAxTDRRP4d3wYc1F5Bd2+tVLo+wWhukbEB6w+RFukU7JFhRyF
         HBFg==
X-Forwarded-Encrypted: i=1; AJvYcCX+voJb+tsQviPhaxDguOiddI8ShAODTtYArgS3a2XY7Jioe+eMQadn/z0c07qIvmMvzOYsp5NP18WgWZ8u@vger.kernel.org
X-Gm-Message-State: AOJu0YydhJqt9eqs9IJunvDFSPJqkELvCQrbbuLUsh5WL9nYIAxffdfl
	sDq0/IEnNO419xxbJ/gv4akCVfpWyI+ieqxWV1xrq0D/DWGsfgBrdsB4QNuqGa8=
X-Google-Smtp-Source: AGHT+IGaG+u4inxY1G70KbmvPwTDLRmf8IKTr8MCGm5Os79HN8/YNFq4Sta+roAK87ufZYdAx621Vw==
X-Received: by 2002:a17:903:35c8:b0:202:232b:2dd8 with SMTP id d9443c01a7336-2050c49f9e7mr24018665ad.55.1724911539457;
        Wed, 28 Aug 2024 23:05:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205155521dbsm4190035ad.258.2024.08.28.23.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:05:39 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjYHo-00GbMJ-1R;
	Thu, 29 Aug 2024 16:05:36 +1000
Date: Thu, 29 Aug 2024 16:05:36 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <ZtAPsMcc3IC1VaAF@dread.disaster.area>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
 <Zs9+mm8bElKJmz65@tissot.1015granger.net>
 <Zs9_l1w0SuJO4ZbO@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs9_l1w0SuJO4ZbO@casper.infradead.org>

On Wed, Aug 28, 2024 at 08:50:47PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 28, 2024 at 03:46:34PM -0400, Chuck Lever wrote:
> > On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> > > There are a few problems I think this can solve.  One is efficient
> > > implementation of NFS READPLUS.
> > 
> > To expand on this, we're talking about the Linux NFS server's
> > implementation of the NFSv4.2 READ_PLUS operation, which is
> > specified here:
> > 
> >   https://www.rfc-editor.org/rfc/rfc7862.html#section-15.10
> > 
> > The READ_PLUS operation can return an array of content segments that
> > include regular data, holes in the file, or data patterns. Knowing
> > how the filesystem stores a file would help NFSD identify where it
> > can return a representation of a hole rather than a string of actual
> > zeroes, for instance.
> 
> Thanks for the reference; I went looking for it and found only the
> draft.
> 
> Another thing this could help with is reducing page cache usage for
> very sparse files.  Today if we attempt to read() or page fault on a
> file hole, we allocate a fresh page of memory and ask the filesystem to
> fill it.  The filesystem notices that it's a hole and calls memset().
> If the VFS knew that the extent was a hole, it could use the shared zero
> page instead.  Don't know how much of a performance win this would be,
> but it might be useful.

Ah. OK. Maybe I see the reason you are asking this question now.

Buffered reads are still based on the old page-cache-first IO
mechanisms and so doing smart stuff with "filesystems things"
are difficult to do.

i.e. readahead allocates folios for the readahead range before it
asks the filesystem to do the readahead IO, it is unaware of how the
file is laid out. Hence it can't do smart things with holes.

And it paints the filesystems into a corner, too, because they can't
modify the set of folios that it needs to fill with data. Hence
the filesystem can't do smart things with holes or unwritten
extents, either.

To solve this, the proposal being made is to lift the filesystem
mapping information up into "the VFS" so that the existing buffered
read code has awareness of the file mapping. That allows this page
cache code to do smarter things. e.g. special case folio
instantiation w.r.t. sparse files (amongst other things).

Have I got that right?

If so, then we've been here before, and we've solve these problems
by inverting the IO path operations. i.e. we do filesystem mapping
operations first, then populate the page cache based on the mapping
being returned.

This is how the iomap buffered write path works, and that's the
reason it supports all the modern filesystem goodies realtively
easily.

The exception to this model in iomap is buffered reads (i.e.
readahead). We still just do what the page cache asks us to do, and
clearly that is now starting to hurt us in the same way the page
cache centric IO model was hurting us for buffered writes a decade
ago.

So, can we invert readahead like we did with buffered writes? That
is, we hand the readahead window that needs to be filled (i.e. a
{mapping, pos, len} tuple) to the filesystem (iomap) which can then
iterate mappings over the readahead range.  iomap_iter_readahead()
can then populate the page cache with appropriately sized folios and
do the IO, or use the zero page when over a hole or unwritten
extent...

Note that optimisations like zero-page-over-holes also need write
path changes. We'd need to change iomap_get_folio() to tell
__filemap_get_folio() to replace zero pages with newly allocated
writeable folios during write operations...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

