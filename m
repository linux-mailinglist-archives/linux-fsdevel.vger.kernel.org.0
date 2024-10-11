Return-Path: <linux-fsdevel+bounces-31662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A67999BE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 06:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01815B2479B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 04:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F91F7062;
	Fri, 11 Oct 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="J5gPQkpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3731CC880
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622358; cv=none; b=N2yIM+ZcqZPrFPemkActg2xBpCIBmElsKvCFsR4CetiIeJOQzhgJ0fsANbToBrDSHTh8TE6Nfs6Q8HFasDxyi79Y/dKdlTaoaV5srn4ftnMvarvuVREBCYD26qKippgaU/EpFntx4wKnLAjqCsV2P4UEFOF1QN0TTUKqnj8gw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622358; c=relaxed/simple;
	bh=gJKEMaCF7j40rJuA+SWowr+SGEx8ma8FEhFWzixPLF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ki9tMjxfWIQy+NlHnZJTgWJ+upR5YvomakdQMinvjYqXeICg65GMkEDvSwIDXSVOszDkmFsBd+BWUPAJiSWc8QwEacO3CGqdo1SY82s0i64U3fdF4rAdRX/C1s4l+llUPYCMGQXjLQKVbWwHtyq3A/+xLR3U0S9w+L15QycA6ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=J5gPQkpM; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e30e56ce5so786185b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 21:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728622356; x=1729227156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2QBOM/b0Fo0UFYAX2gq5hQE2uQJb3Jg3RU+ljZaNtg=;
        b=J5gPQkpMGqQKyF7A5T1D1Y1v4T/0IVHy8RM5RJL89I8CKGAFRbUJlW3USaOD/MRWz/
         fpIZZlaBbGOqmoY77yI6GEvvggRAixLohjjHjeEWm+EO+11w2nfG69OyN8feIIx/r2Qe
         wsHRl1y/AZtjNl0m5agBKfCsftY3LWytZOnLLft6bHhcBaJ/r2tlR08dYg/m+n/n7VKT
         M+EfDNKQ/heaS05qrSXyv/tAkl3TooMpJlkijgm7avQuKhHijTNzFQdXq/BoXqHsYHsm
         CuCp+ICGcAYYha5CXIhSFiwQzV769kL0pPG0iUwhh0ZB2q5f+r+QaCgEzgOwbOUxmiIl
         Ccag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728622356; x=1729227156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2QBOM/b0Fo0UFYAX2gq5hQE2uQJb3Jg3RU+ljZaNtg=;
        b=Jic/u/ozbu8UQEx2zeG/JBacIIIOLEgEfxsWR0IfOL7bhIRAquo3DeKfZglpzNEZ+T
         D0jAjQ9DWccgg0kOafecy/CV3sjSmldOhC/QbFxxPO32MLHCyoP7eT5G4Jnaf16dwY8G
         zjIV0sXovXUPq23CGz0FXydh2Agne0kNEh4dpcoKwRnGzIe4oiohpnTkbbwLIdnrSnCV
         jl6JGnrZ+Omgl+SuLgFc4ExYq2BMq4CAQi09i90M0I7bqensLxhZzgBMXsLEdgQAUCVs
         SOHBCHAMxAoXm1xWaPoJ8Q2cwl03BJm7wzrsM5hKoo4tLo3NXx2FmrkIIs73/N/capn1
         GPJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrclEoUCE04txm8nekZkwemIDIpghQE40UwiYUAnJo18R94T5VTJWJMrCRi/ZWwqXoVhCPrkhX4yOGsxmG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy79hcNfNXTsAWzafUWDtvmEeCpwSQN2Ojt+PJSB+FsPYdar/fu
	e84XG2dJ2OBA30YoS7fF/C3ZsZUexbfXEe2ecPln/HzV3JG53YqAcIKpmi4nS2VC1SxhFpzUltk
	n
X-Google-Smtp-Source: AGHT+IFECAoIio7xWFb3LGO5Kvkk7a8zO7qZUelwg7OzymTE4wMxPlG7wLBhF09q8lYE9ZfmJm4RCQ==
X-Received: by 2002:a05:6a00:2d83:b0:71d:fe64:e3fa with SMTP id d2e1a72fcca58-71e3809f9eemr2525025b3a.19.1728622355697;
        Thu, 10 Oct 2024 21:52:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2aa939fdsm1866032b3a.109.2024.10.10.21.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 21:52:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sz7dg-00GmX6-0c;
	Fri, 11 Oct 2024 15:52:32 +1100
Date: Fri, 11 Oct 2024 15:52:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
Message-ID: <ZwivELSTeFI41ubf@dread.disaster.area>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
 <20241007174758.GE21836@frogsfrogsfrogs>
 <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>
 <Zwh0rzp8hpCoF/or@dread.disaster.area>
 <381c349d-2eb7-419f-a2f8-a41ca6a9e9f0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381c349d-2eb7-419f-a2f8-a41ca6a9e9f0@linux.alibaba.com>

[FYI, your email got classified as spam by gmail...]

On Fri, Oct 11, 2024 at 11:28:42AM +0800, Gao Xiang wrote:
> Hi Dave,
> 
> On 2024/10/11 08:43, Dave Chinner wrote:
> > On Thu, Oct 10, 2024 at 02:10:25PM -0400, Goldwyn Rodrigues wrote:
> 
> ...
> 
> > 
> > .... there is specific ordering needed.
> > 
> > For writes, the ordering is:
> > 
> > 	1. pre-write data compression - requires data copy
> > 	2. pre-write data encryption - requires data copy
> > 	3. pre-write data checksums - data read only
> > 	4. write the data
> > 	5. post-write metadata updates
> > 
> > We cannot usefully perform compression after encryption -
> > random data doesn't compress - and the checksum must match what is
> > written to disk, so it has to come after all other transformations
> > have been done.
> > 
> > For reads, the order is:
> > 
> > 	1. read the data
> > 	2. verify the data checksum
> > 	3. decrypt the data - requires data copy
> > 	4. decompress the data - requires data copy
> > 	5. place the plain text data in the page cache
> 
> Just random stuffs for for reference, currently fsverity makes
> markle tree for the plain text,

Well, that is specifically an existing implementation detail -
the fsverity core does not care what data is asked to measure as long
as it is the same data that it is asked to verify.

Hence a filesystem could ask fsverity to measure compressed,
encrypted data, and as long as the filesystem also asks fsverity to
measure the same compressed, encrypted data as it is read from disk
it will work as expected.

We could do this quite easily - hand the compressed data record
to fsverity one fsblock sized chunk at a time, and treat the empty
regions between the end of the compressed record and the offset
of the start of the next compressed record as a hole....

So, yeah, I think that fsverity can be placed at the at the "verify
data on disk" layer successfully rather than at the "verify plain
text" layer without actually impacting on it's functionality.

....
> > Compression is where using xattrs gets interesting - the xattrs can
> > have a fixed "offset" they blong to, but can store variable sized
> > data records for that offset.
> > 
> > If we say we have a 64kB compression block size, we can store the
> > compressed data for a 64k block entirely in a remote xattr even if
> > compression fails (i.e. we can store the raw data, not the expanded
> > "compressed" data). The remote xattr can store any amount of smaller
> > data, and we map the compressed data directly into the page cache at
> > a high offset. Then decompression can run on the high offset pages
> > with the destination being some other page cache offset....
> 
> but compressed data itself can also be multiple reference (reflink
> likewise), so currently EROFS uses a seperate pseudo inode if it
> decides with physical addresses as indexes.

Sure, but handling shared data extents and breaking of shared
mappings on write is not an iomap/page cache problem - that's a
problem the filesystem block mapping operations that iomap calls
need to handle.

EROFS uses a separate pseudo inode so taht it can share page cache
as well as shared blocks on disk. I don't think that compression
changes that at all - the page cache contents for all those blocks
are still going to be identical...

As for the case of shared compressed data extents in XFS, I think
that shared status just needs a shared bit to added to the remote
xattr extent record header. Nothing else will really have to change,
because xattr record overwrites are naturally copy-on-write. Hence
updating a record will always break sharing, and the "shared bit"
simply propagates into the block freeing operation to indicate a
refcount update for the blocks being freed is needed. I don't see
supporting FICLONE on compressed inodes as a major issue.

> > On the write side, compression can be done directly into the high
> > offset page cache range for that 64kb offset range, then we can
> > map that to a remote xattr block and write the xattr. The xattr
> > naturally handles variable size blocks.
> 
> Also different from plain text, each compression fses may keep
> different encoded data forms (e.g. fses could add headers or
> trailers to the on-disk compressed data or add more informations
> to extent metadata) for their own needs.i

Sure, but that's something that the filesystem can add when encoding
the data into the page cache. iomap treats the contents of the page
caceh as entirely opaque - how "transformed" data is encoded in the
destination folios is completely up to the filesystem doing the
transformation. All iomap needs to care about is the offset and
length of the opaque transformed data the filesystem needs to reside
in the cache to perform the transformation.

i.e. The example I gave above for XFS compression doesn't need
metadata in the page cache data because it is held in an externally
indexed xattr btree record. That's an XFS compression implementation
detail, not an iomap concern.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

