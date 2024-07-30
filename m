Return-Path: <linux-fsdevel+bounces-24531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639FB94067B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 06:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB4D4B221EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 04:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D51160796;
	Tue, 30 Jul 2024 04:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DnpyZ5kZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371B157466
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jul 2024 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722313193; cv=none; b=d7bW2YZF0mdED1yGxFARV1/mhk4Fwi77C5LHN8e1tyX6lstDxSIbo/1DPKArnlP/3DSGZCojdYeDxpfeXrYCIYaqVz4XKzCbobZ2x4eZWKcUrQtqCsb6vzIuGrZEekLKvcrbrHPohcc1dlViY3OS8BYcemA25XySG6//spIySnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722313193; c=relaxed/simple;
	bh=Kns3ZGeSTqFnTpU/ZF8meJnWEVdl+U/Oj9h5kwIYMoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+pj0pzS0GJVTCqa6ikQiyKntftmwap4Yry6/ojd1oyM/HeFFvrWU3pI8vmQV7zJ4lVBVUYS+afwjEvLd5rOQHnYfbgea3L2CFkVd2gFAK5fjjp3mTwbzTZFD3Z47Pk+v9Gtgkmk0oy2HQk7ycu48lxOFY+3pVhN3o6Es39cSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DnpyZ5kZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-198.bstnma.fios.verizon.net [173.48.113.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46U4JXNS021300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 00:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1722313176; bh=V4/zon++6XHCcja8lUmfWlJoumx1BPXmJXytiWD2pwE=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DnpyZ5kZndJwPNX+mCCtFMzDrobPMC/3hW0VSNbpEnpNy2ViCgDJVmBEhFpYyeOHd
	 2C0vdfef5sOFtPewK0L3OxMGz1qTzNvCZ1pDvas+7zNXsngZ0iukUuN46ZJGa8SwMt
	 yV141M6uyTlt2DIwkFdiOAkQ8PEyBaBDroz/hACgSmXnSCDBQAcnHGENsXYKfj8qlU
	 t+3yBy5QKZlGU1qjN5NaCD6uizjx8MMJr8KJatCQjbxXl3jW0mrB3EI1Edj6jum8nb
	 goHQrG4+ne6iavOLEyTcq6qu9ID7LCpnpXiGo3cx5TWDknttxt9n6rD77DDN99u7Zv
	 FUV7829w/W26A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8AEA115C032D; Tue, 30 Jul 2024 00:19:33 -0400 (EDT)
Date: Tue, 30 Jul 2024 00:19:33 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Florian Weimer <fweimer@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: Testing if two open descriptors refer to the same inode
Message-ID: <20240730041933.GC719392@mit.edu>
References: <874j88sn4d.fsf@oldenburg.str.redhat.com>
 <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <20240729133601.GA557749@mit.edu>
 <ZqhQnWQSweXgffdD@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqhQnWQSweXgffdD@dread.disaster.area>

On Tue, Jul 30, 2024 at 12:31:57PM +1000, Dave Chinner wrote:
> I don't think you can make such a simplistic delineation, because
> there's more than one issue at play here.
> 
> There are at least two different "is this inode identical"
> use cases that {st_dev,st_ino} is being used for.
> 
> The first, as Florian described, is to determine if two open fds
> refer to the same inode for collision avoidance.
> 
> This works on traditional filesystems like ext4 and XFS, but isn't
> reliable on filesystems with integrated snapshot/subvolume
> functionality.

That's fair, but the first is the problem I think is more important,
because there are existing programs which are depending on
st_dev/st_ino as being a reliable way of detecting uniqueness --- and
if this breas, file data may get corrpted, or the dyanmic linker will
assume that two unrelated shared libraries are actually the same, with
hilarity then ensuing --- because an interface which is guaranteed by
decade of Unix history, and POSIX, is broken by some Linux file
systems.

> The second is that {dev,ino} is being used to disambiguate paths
> that point to hardlinked inodes for the purposes of identifying
> and optimising access and replication of shared (i.e. non-unique)
> file data.
> 
> This works on traditional filesystems like ext4, but fails badly on
> filesystem that support FICLONERANGE (XFS, btrfs, NFS, CIFS,
> bcachefs, etc) because cloned files have unique inodes but
> non-unique data.

That's a problem, yes --- but it's a previously unsolved problem, and
the failure will cause inefficiency, but it doesn't actually cause
data corruption.

It's also a very hard problem, especially if we're considering the
full, general FICLONERANGE interface, where an arbitrary subset of
blocks at one offset, might be cloned at a completely different offset
in a different file, and where a single file might have cloned ranges
from a dozens of other files.  How this information would be
communicated to userspace, so they could copy a directory hierarchy 
without an increased expansion is a hard problem.

Given that we have a simple solution (filehandles) to fix a problem
where false positives causes lost data or core dumps, let's solve the
simple problem and try to get it standardized acrossed operating
systems beyond Linux, and in parallel, we can try to figure out a much
more complicated interface to solve this other problem.

     		 	      	    	 - Ted

