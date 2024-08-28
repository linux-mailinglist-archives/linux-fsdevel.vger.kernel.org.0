Return-Path: <linux-fsdevel+bounces-27634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E17D963100
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC366B2399F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 19:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2F1AAE25;
	Wed, 28 Aug 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WNz6fg9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C21A76A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724873646; cv=none; b=qEQ+eZ774LR6pJr6t69E+PYiUqWScjHg/iGg1A5Au57NgKaHUVWEn4ADcHGbi7KXnjqWKeAiMsuQUDmLcJUwoioA9eaZbT0nbfRcdKfruh6EpelLhVdlAqGf2/HYQM23XodMe/9dPFWHaFSlLLShojJRGN1LiqGwEq1MzM6oN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724873646; c=relaxed/simple;
	bh=8hzsAoFrbePX2ZlOFQyDibxk40h4Rjz/0yRcXOGdZ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jX6ODYankXb2vboTWvO/tnZEhl6z6qfu4Bv8AhTbqSos9/iwwi+ohleFN/EOfz5TousJOvduwEp68krkMAPdrwjteOzuS3MZTgbx9pWAoK38DP0d46BfOw16jUrCSiPqbE521ISwks61DKG0ftQGs0XVdVkKRrzhkBJxrur1SkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WNz6fg9w; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JtbjKTfmM+UP1vEVd8JI6eNQRWwDQaBWwfQUq/ObO2g=; b=WNz6fg9w6KVX9Pb5Lt4oDtdTlG
	5vBFS5iiOp/35SYznabaLGl45x8l/vF4qRGpVs2VpmBYtfreyJeSxegIkv5PbOA0o5QYz2PrlZ+Mt
	GIKoVljTuKAF03OfbGwuttyXuF5Ranp3sA/bL13bUwcjRwz+CmiWav1+aoK4pchEs80fsrSPoYyeR
	FHmbTUk9kdHrGkygro1ll1ISDPvLSkbthMH8R4XZs0UzJFRYUnTwlDn4zpK+5sD1l8Eq0Y5mgAG66
	R1djFUPIQUfqjnHW7F6gisESZSM5V5/059yi0oNi7FS8OFXtM4NiMlrVwTdGsg111l+TpCaIE5lZY
	shZs2xUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sjOQb-00000000xNL-1AFc;
	Wed, 28 Aug 2024 19:34:01 +0000
Date: Wed, 28 Aug 2024 20:34:00 +0100
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: VFS caching of file extents
Message-ID: <Zs97qHI-wA1a53Mm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Today it is the responsibility of each filesystem to maintain the mapping
from file logical addresses to disk blocks (*).  There are various ways
to query that information, eg calling get_block() or using iomap.

What if we pull that information up into the VFS?  Filesystems obviously
_control_ that information, so need to be able to invalidate entries.
And we wouldn't want to store all extents in the VFS all the time, so
would need to have a way to call into the filesystem to populate ranges
of files.  We'd need to decide how to lock/protect that information
-- a per-file lock?  A per-extent lock?  No locking, just a seqcount?
We need a COW bit in the extent which tells the user that this extent
is fine for reading through, but if there's a write to be done then the
filesystem needs to be asked to create a new extent.

There are a few problems I think this can solve.  One is efficient
implementation of NFS READPLUS.  Another is the callback from iomap
to the filesystem when doing buffered writeback.  A third is having a
common implementation of FIEMAP.  I've heard rumours that FUSE would like
something like this, and maybe there are other users that would crop up.

Anyway, this is as far as my thinking has got on this topic for now.
Maybe there's a good idea here, maybe it's all a huge overengineered mess
waiting to happen.  I'm sure other people know this area of filesystems
better than I do.

(*) For block device filesystems.  Obviously network filesystems and
synthetic filesystems don't care and can stop reading now.  Umm, unless
maybe they _want_ to use it, eg maybe there's a sharded thing going on and
the fs wants to store information about each shard in the extent cache?

