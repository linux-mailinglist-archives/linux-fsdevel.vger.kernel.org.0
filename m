Return-Path: <linux-fsdevel+bounces-13132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FB86B8FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 21:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1B82883E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE487443A;
	Wed, 28 Feb 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Hf7KAHht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B27442A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151692; cv=none; b=BgjFt+w25PrJgJPGzsW5nFbgzwFt4UKILpMufCW5E7Ezu/9kINekoxO1rTW+OtrAKgIAAAN6z3XhUe+3WPfuh/eMHr2nUb52IbUtbjVCv49fq3NyyLLIWPAP0KIxPBTKsrV1ya+E+op4U5Ed6aW/GkFfh9jfn51yullmCjbdopA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151692; c=relaxed/simple;
	bh=RnArb3GOWvctmw7HzKHUkf0Eg+Rv20xlWOeCvPw5fww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL9i1oN9bT14q+0Z1pBBKSiyAIhNZ5gZKIYizlTi3Jg4IBLr/FbuUfB5/2E+Fs8aAQTBL4W8vbsBQlA6SBOwUfPvZksJhVatAZ4gByyYxoc8IKJsRWnDI7jCjg1tVMuOHYUm/64CR9g0OdkKLrf7oLNhpwOFS23XcG/62GC6XCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Hf7KAHht; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (c-73-8-226-230.hsd1.il.comcast.net [73.8.226.230])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41SKL4as019146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 15:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1709151667; bh=cgjdDx6fKehdNQxWaNb/qHiXdMwxlGu5vAXf/Nz+i4I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Hf7KAHhtNtaSzNEGskWU2VWPTlInxZNfliMVR74RR8YPJq2f/dmuDFJV91ZGqx63P
	 +b//LyXhRrUT0CedQSjeSr3s9JIPKMxWdoDBLznUvpNioKuAFSnmG3NCAgoDpTAVFw
	 oqGK4E2DKjrarZ/YDlPaLamjhsO78xh6BCdYuajWb76vS4fA6wdDEuBcHLY0bOpyW9
	 3VN80LnMAU/CY7jrHqQJg/GMkiPX6FbwFmqBRtoKdTCGhw0sknD18toFSUMtY2JRmr
	 vMQ6xsyBZObvb1riqSQagD+F9xkNkzOxhC+eHB8auAYnqd4bpfI/hRENrOkZamBWnE
	 Kb81dDqS5vnWg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 015653404B0; Wed, 28 Feb 2024 14:21:03 -0600 (CST)
Date: Wed, 28 Feb 2024 14:21:03 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] untorn buffered writes
Message-ID: <20240228202103.GA177082@mit.edu>
References: <20240228061257.GA106651@mit.edu>
 <CAOQ4uxhZ5KOTdi01C87wYwvB_K=HDYdLy7LHzXnC-C3U_OFEnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhZ5KOTdi01C87wYwvB_K=HDYdLy7LHzXnC-C3U_OFEnQ@mail.gmail.com>

On Wed, Feb 28, 2024 at 01:38:44PM +0200, Amir Goldstein wrote:
> 
> Seems a duplicate of this topic proposed by Luis?
> 
> https://lore.kernel.org/linux-fsdevel/ZdfDxN26VOFaT_Tv@bombadil.infradead.org/

Maybe.  I did see Luis's topic, but it seemed to me to be largely
orthogonal to what I was interested in talking about.  Maybe I'm
missing something, but my observations were largely similar to Dave
Chinner's comments here:

https://lore.kernel.org/r/ZdvXAn1Q%2F+QX5sPQ@dread.disaster.area/

To wit, there are two cases here; either the desired untorn write
granularity is smaller than the large block size, in which case there
really nothing that needs to be done from an API perspective.
Alternatively, if the desired untorn granularity is *larger* than the
large block size, then the API considerations are the same with or
without LBS support.

From the implementation perspective, yes, there is a certain amount of
commonality, but that to me is relatively trivial --- or at least, it
isn't a particular subtle design.  That is, in the writeback code, it
needs to know what the desired write granularity, whether it is
required by the device because the logical sector size is larger than
the page size, or because there is an untorn write granularity
requested by the userspace process doing the writing (in practice,
pretty much always 16k for databases).  In terms of what the writeback
code needs to do, it needs to make sure that gathers up pages
respecting the alignment and required size, and if a page is locked,
we have to wait until it is available, instead of skipping that page
in the case of a non-data-integrity writeback.

As far as tooling/testing is concerned, against, it appears to me that
the requirements of LBA and the desire for untorn writes in units of
granularity larger than the block size are quite orthogonal.  For LBA,
all you need is some kind of synthetic/debug device which has a
logical block size larger than the page size.  This could be done a
number of ways:

    * via the VMM --- e.g., a QEMU block device that has a 64k logical
      sector size.
    * via loop device that exports a larger logical sector size
    * via blktrace (or its ebpf or ftrace) and making sure that size of every
      write request is the right multiple of 512 byte sectors

For testing untorn writes, life is a bit tricker, because not all
writes will be larger than the page size.  For example, we might have
an ext4 file system with a 4k blocksize, so metadata writes to the
inode table, etc., will be in 4k writes.  However, when writing to the
database file, *those* writes need to be in multiples of 16k, with 16k
alignment required, and if a write needs to be broken up it must be at
a 16k boundary.

The tooling for this, which is untorn write specific, and completely
irrelevant for the LBS case, needs to know which parts of the storage
device are assigned to the database file --- and which are not.  If
the database file is not getting deleted or truncated, it's relatively
easy to take a blktrace (or ebpf or ftrace equivalent) and validate
all of the I/O's, after the fact.  The tooling to do this isn't
terribly complicated, would involve using filefrag -v if the file
system is already mounted, and a file system specific tool (i.e.,
debugfs for ext4, or xfs_db for xfs) if the file system is not mounted.

Cheers,

					- Ted

