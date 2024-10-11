Return-Path: <linux-fsdevel+bounces-31653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48562999837
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 02:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EAFB2417A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 00:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F38BE8;
	Fri, 11 Oct 2024 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ZV1YF843"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062826FB0
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607413; cv=none; b=ehM6nZT3K8y/ft4otHn5YSTNl9JeeDeg7+3faiGtcdleZmNmj5znYioEGFogNnm81N7sTgGij1mhxBqn0xopQQL95vJ/aEjxfKcpp4U5poS1SxjSlJH0r6Gw0oEZ1lisFi4r24jZ1k8NABgOoi8vCJkV45/XICiPvT2L1bJHKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607413; c=relaxed/simple;
	bh=jYWIO/Kxoxf8Rx+qM6g1i9Z8IIFgza97yWxl7e4M00U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdvYQZzfUTxxSAf2Xt2qO0/JRr6ktLnURD7i1LoMAV9/izTm3uHrxOwDTGr4QUy3qO2I3wAfg2g51dWwgD8Agv0LGTfWavoGRQ7cQ7zzOVoZDy3McyMVejV0C6W+IIwdlQBhdUQFDjGPr/P01+zQeI6qnRsooyGnrq59G4jN+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ZV1YF843; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c544d345cso10998935ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 17:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728607411; x=1729212211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiOyMBxa/33SDWmb3tUybVzmcM0K7t0Zhy9VnlGY/bk=;
        b=ZV1YF843pugoB85Js3ZnXlNlU2mPogIc3YRpKpzbJ9+TrKLnu8Spvz0Uh0B2htpQpH
         onxIGOazX1uEKqzKeW9qAEEy4cy5iaElgWzMVqPDMVKpetSuHxCbvj9hWE5nXFpv6PIS
         +xs34Kv2xdR/SYc12rhLDiMyLQsxnlzLe/Ii6WqQffGnTcdtATKvgsSEIKjdAe/2GoP5
         IXeAwFfhheL3rMNHsVRcqkxvz8OSxdoQerl0BtGNax2Cae3O5ih/syOM37pzUVVamPVg
         pIa5sSXPPnnpCdVWevf/T6uSCSy73uWkXvrPsMbsO2QKLxCNnHeoYGo0MKeOEYap0Utc
         juoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728607411; x=1729212211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiOyMBxa/33SDWmb3tUybVzmcM0K7t0Zhy9VnlGY/bk=;
        b=RdEyrdRskmZFvzRSKmJ32WuicI0QuPYRukxcgG6vHEo0fSt1MOMxawK08JdxZ/1U5D
         YcSaBd6V79cTHn3lss/6ZSnUArLQjZ3WE2dKtBLmunpeMlIb08BuYLAqbfyOC5WDvpo4
         cCJCJB+uxF5zAHbloQDFS1v9MvTSxjyTwdNoPjKGkBDxudLrlnVYoEuHHjUYkJXVNoYR
         nKeZv4MyV4Nr/N/8OQjcLm/cruMyOSrMNKw8xwBjqqBrkRTpWBXLcv+hs6R1BaGnB5Dj
         7y0CYi5ytiX3Q0fnId0Cqg8uCCqJ4N1rq1rMQLdqHI5kKDYuy3AyQzkX7qirFQhSPNKi
         phSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZQhuz/i2ke9+hi7s5SL8yhKPTITeV68YfmUreCPOkGUGj3j2ngMcpgf0q85olbn83h4i0GyT476nj7gPw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qN1frmUFT3wbpup9dSTNUseR6o8jh9JfdYyIoONktXAsYLjc
	3snSDlilpl5YBqaHr9G4Vcp9EMdA5WfpxvovAZoh6vmEfnri3T3NtBJ3JbrJCB0=
X-Google-Smtp-Source: AGHT+IH6KzSoyKjA32xEMRiIKm9VgMQM2PtPAxkRvwSOXUxg+nrq8NCJOHhWoi6xDsEJJLwr7bSqkQ==
X-Received: by 2002:a17:902:d2c8:b0:20b:a73b:3f5 with SMTP id d9443c01a7336-20ca0399c9amr17198785ad.14.1728607411093;
        Thu, 10 Oct 2024 17:43:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-209-182.pa.vic.optusnet.com.au. [49.186.209.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc13394sm14941465ad.108.2024.10.10.17.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:43:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sz3kd-00Ghbb-1S;
	Fri, 11 Oct 2024 11:43:27 +1100
Date: Fri, 11 Oct 2024 11:43:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/12] iomap: Introduce read_inline() function hook
Message-ID: <Zwh0rzp8hpCoF/or@dread.disaster.area>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <8147ae0a45b9851eacad4e8f5a71b7997c23bdd0.1728071257.git.rgoldwyn@suse.com>
 <ZwCk3eROTMDsZql1@casper.infradead.org>
 <20241007174758.GE21836@frogsfrogsfrogs>
 <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kplkze6blu5pmojn6ikv65qdsccyuxg4yexgkrmldv5stn2mr4@w6zj7ug63f3f>

On Thu, Oct 10, 2024 at 02:10:25PM -0400, Goldwyn Rodrigues wrote:
> On 10:47 07/10, Darrick J. Wong wrote:
> > On Sat, Oct 05, 2024 at 03:30:53AM +0100, Matthew Wilcox wrote:
> > > On Fri, Oct 04, 2024 at 04:04:33PM -0400, Goldwyn Rodrigues wrote:
> > > > Introduce read_inline() function hook for reading inline extents. This
> > > > is performed for filesystems such as btrfs which may compress the data
> > > > in the inline extents.
> > 
> > Why don't you set iomap->inline_data to the uncompressed buffer, let
> > readahead copy it to the pagecache, and free it in ->iomap_end?
> 
> This will increase the number of copies. BTRFS uncompresses directly
> into pagecache. Yes, this is an option but at the cost of efficiency.

Is that such a problem? The process of decompression means the data
is already hot in cache, so there isn't a huge extra penalty for
moving this inline data a second time...

> > > This feels like an attempt to work around "iomap doesn't support
> > > compressed extents" by keeping the decompression in the filesystem,
> > > instead of extending iomap to support compressed extents itself.
> > > I'd certainly prefer iomap to support compressed extents, but maybe I'm
> > > in a minority here.
> > 
> > I'm not an expert on fs compression, but I get the impression that most
> > filesystems handle reads by allocating some folios, reading off the disk
> > into those folios, and decompressing into the pagecache folios.  It
> > might be kind of amusing to try to hoist that into the vfs/iomap at some
> > point, but I think the next problem you'd run into is that fscrypt has
> > similar requirements, since it's also a data transformation step.
> > fsverity I think is less complicated because it only needs to read the
> > pagecache contents at the very end to check it against the merkle tree.
> > 
> > That, I think, is why this btrfs iomap port want to override submit_bio,
> > right?  So that it can allocate a separate set of folios, create a
> > second bio around that, submit the second bio, decode what it read off
> > the disk into the folios of the first bio, then "complete" the first bio
> > so that iomap only has to update the pagecache state and doesn't have to
> > know about the encoding magic?
> 
> Yes, but that is not the only reason. BTRFS also calculates and checks
> block checksums for data read during bio completions.

This is no different to doing fsverity checks at read BIO io
completion. We should be using the same mechanism in iomap for
fsverity IO completion verification as filesystems do for data
checksum verification because, conceptually speaking, they are the
same operation.

> > And then, having established that beachhead, porting btrfs fscrypt is
> > a simple matter of adding more transformation steps to the ioend
> > processing of the second bio (aka the one that actually calls the disk),
> > right?  And I think all that processing stuff is more or less already in
> > place for the existing read path, so it should be trivial (ha!) to
> > call it in an iomap context instead of straight from btrfs.
> > iomap_folio_state notwithstanding, of course.
> > 
> > Hmm.  I'll have to give some thought to what would the ideal iomap data
> > transformation pipeline look like?
> 
> The order of transformation would make all the difference, and I am not
> sure if everyone involved can come to a conclusion that all
> transformations should be done in a particular decided order.

I think there is only one viable order of data transformations
to/from disk. That's because....

> FWIW, checksums are performed on what is read/written on disk. So
> for writes, compression happens before checksums.

.... there is specific ordering needed.

For writes, the ordering is:

	1. pre-write data compression - requires data copy
	2. pre-write data encryption - requires data copy
	3. pre-write data checksums - data read only
	4. write the data
	5. post-write metadata updates

We cannot usefully perform compression after encryption -
random data doesn't compress - and the checksum must match what is
written to disk, so it has to come after all other transformations
have been done.

For reads, the order is:

	1. read the data
	2. verify the data checksum
	3. decrypt the data - requires data copy
	4. decompress the data - requires data copy
	5. place the plain text data in the page cache

To do 1) we need memory buffers allocated, 2) runs directly out of
them. If no other transformations are required, then we can read the
data directly into the folios in the page cache.

However, if we have to decrypt and/or decompress the data, then
we need multiple sets of bounce buffers - one of the data being
read and one of the decrypted data. The data can be decompressed
directly into the page cache.

If there is no compression, the decryption should be done directly
into the page cache.

If there is nor decryption or compression, then the read IO should
be done directly into the page cache and the checksum verification
done by reading out of the page cache.

IOWs, each step of the data read path needs to have "buffer" that
is a set of folios that may or may not be the final page cache
location.

The other consideration here is we may want to be able to cache
these data transformation layers when we are doing rapid RMW
operations. e.g. on encrypted data, a RMW will need to allocate
two sets of bounce buffers - one for the read, another for the
write. If the encrypted data is also hosted in the page cache (at
some high offset beyond EOF) then we don't need to allocate the
bounce buffer during write....

> > Though I already have a sneaking suspicion that will morph into "If I
> > wanted to add {crypt,verity,compression} to xfs how would I do that?" ->
> > "How would I design a pipeine to handle all three to avoid bouncing
> > pages between workqueue threads like ext4 does?" -> "Oh gosh now I have
> > a totally different design than any of the existing implementations." ->
> > "Well, crumbs. :("

I've actually been thinking about how to do data CRCs, encryption
and compression with XFS through iomap. I've even started writing a
design doc, based on feedback from the first fsverity implementation
attempt.

Andrey and I are essentially working towards a "direct mapped remote
xattr" model for fsverity merkle tree data. fsverity reads and
writes are marshalled through the page cache at a filesystem
determined offset beyond EOF (same model as ext4, et al), but the
data is mapped into remote xattr blocks. This requires fixing the
mistake of putting metadata headers into xattr remote blocks by
moving the CRC to the remote xattr name structure such that remote
xattrs only contain data again.

The read/write ops that are passed to iomap for such IO are fsverity
implementation specific that understand that the high offset is to
be mapped directly to a filesystem block sized remote xattr extent
and the IO is done directly on that block. The remote xattr block
CRC can be retreived when it is mapped and validated on read IO
completion by the iomap code before passing the data to fsverity.

The reason for doing using xattrs in this way is that it provides a
generic mechanism for storing multiple sets of optional data related
and/or size-transformed data within a file and within the single
page caceh address space the inode provides.

For example, it allows XFS to implement native data checksums. For
this, we need to store 2 x 32bit CRCs per filesystem block. i.e. we
need the old CRC and the new CRC so we can write/log the CRC update
before we write the data, and if we crash before the data hits the
disk we still know what the original CRC was and so can validate
that the filesystem block contains entirely either the old or the
new data when it is next read. i.e. one of the two CRC values should
always be valid.

By using direct mapping into the page cache for CRCs, we don't need
to continually refetch the checksum data. It gets read in once, and
a large read will continue to pull CRC data from the cached folio as
we walk through the data we read from disk.  We can fetch the CRC
data concurrently with the data itself, and IO completion processing
doesn't signalled until both have been brought into cache.

For writes, we can calculate the new CRCs sequentially and flush the
cached CRC page but to the xattr when we reach the end of it. The
data write bio that was built as we CRC'd the data can then be
flushed once the xattr data has reached stable storage. There's a
bit more latency to writeback operations here, but nothing is ever
free...

Compression is where using xattrs gets interesting - the xattrs can
have a fixed "offset" they blong to, but can store variable sized
data records for that offset.

If we say we have a 64kB compression block size, we can store the
compressed data for a 64k block entirely in a remote xattr even if
compression fails (i.e. we can store the raw data, not the expanded
"compressed" data). The remote xattr can store any amount of smaller
data, and we map the compressed data directly into the page cache at
a high offset. Then decompression can run on the high offset pages
with the destination being some other page cache offset....

On the write side, compression can be done directly into the high
offset page cache range for that 64kb offset range, then we can
map that to a remote xattr block and write the xattr. The xattr
naturally handles variable size blocks.

If we overwrite the compressed data (e.g. a 4kB RMW cycle in a 64kB
block), then we essentially overwrite the compressed data in the
page cache at writeback, extending the folio set for that record
if it grows. Then on flush of the compressed record, we atomically
replace the remote xattr we already have so we are guaranteed that
we'll see either the old or the new compressed data at that point in
time. The new remote xattr block is CRC'd by the xattr code, so if
we are using compression-only, we don't actually need separate
on-disk data CRC xattrs...

Encryption/decryption doesn't require alternate data storage, so
that just requires reading the encrypted data into a high page cache
offset. However, if we are compressing then encrypting, then after
the encryption step we'd need to store it via the compression
method, not the uncompressed method. Hence there are some
implementation details needed to be worked through here.

-----

Overall, I'm looking an iomap mechanism that stages every part of
the transformation stack in the page cache itself. We have address
space to burn because we don't support file sizes larger than 8EiB.
That leaves a full 8EiB of address space available for hosting
non-user-visible ephemeral IO path data states.

How to break up that address space for different data transformation
uses is an open question. Files with transformed data would be
limited to the size of the address space reserved by iomap for
transformed data, so we want it to be large.

XFS can't use more than 2^32 -extents- for xattrs on an inode at
this point in time. That means >4 billion alternate data records can
be stored, not that 256TB is the maximum offset that can be
supported.

Hence I'm tending towards at least 1PB per alternate address
range, which would limit encrypted and/or compressed files to this
size. That leaves over 8000 alternate address ranges iomap can
support, but I suspect that we'll want fewer, larger ranges in
preference to more, smaller ranges....

> > I'll start that by asking: Hey btrfs developers, what do you like and
> > hate about the current way that btrfs handles fscrypt, compression, and
> > fsverity?  Assuming that you can set all three on a file, right?

I'm definitely assuming that all 3 can be set at once, as well as
low level filesystem data CRCs underneath all the layered "VFS"
stuff.

However, what layers we actually need at any point in time can be
malleable. For XFS, compression would naturally be CRC'd by the
xattr storage so it wouldn't need that layer at all. If fsverity is
enabled and fs admin tooling understands fsverity, then we probably
don't need fs checksums for fsverity files.

so there definitely needs to be some flexibility in the stack to
allow filesystems to elide transformation layers that are
redundant...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

