Return-Path: <linux-fsdevel+bounces-29120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5999759C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D92AB224A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDE1B2EE5;
	Wed, 11 Sep 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO3lclcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54721B9B5E;
	Wed, 11 Sep 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077111; cv=none; b=DRfrs7RXBigVmAeB5OIC12EnrO+bkqXq/PtIO4G32Ax8UWNfOD4tQsiPvQNdEBmqlgtNQjE8Xy04XVamUb8p469P4Pl4gPD9fv0hCY8j8Q01T0rb++cfeccTcyDLCi8Q9nweWn/Bf4NIZBelZlojVfl4/Du84TEZeuRGiJrQWV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077111; c=relaxed/simple;
	bh=xSswVBibcjDEQg2WwGMuh6ZoWg4FGo7fcgKqXzRLGwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FojKhcyHKvVfLggCkwik/buEbYFiZR2mE/+0Ch+vbwitMw5ru6Kn3HOj4W1H+6XCe1zjtVWQmTtHsath6EVBaIDlJUkHGO2C8BaWnD4dAJC40/h9bO8TMPAy9KXlrze+D6xchsO90s1+Row4FOptmpT4sKYplunU786tLRXlY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO3lclcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F45DC4CEC7;
	Wed, 11 Sep 2024 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726077111;
	bh=xSswVBibcjDEQg2WwGMuh6ZoWg4FGo7fcgKqXzRLGwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eO3lclcNw586T/x/64jQwyQQm8g4y42Lv3qcWsCtsAFyoLHir8zdJQV5T18CTtg64
	 H3O0TOnEtPaMFK0wDRETEhzQhA8la6YP5TQjV54B96h5jLK045bwfscM2BoRXXSrYz
	 FUWTiUAxACz3YrXFncrXO3O+LQovUUYko1EL/ohTKPPOH8BSGLeSKflzKKXjilbrPx
	 w0GNDgg3AGHeqc475rsTO2PpXnNee9z/ppbr4hJuiW4jpZKXM/PUwq1xzi722TcGTr
	 RAOykXYUb9+eugKJsTeB14aQLOlq9Z7PASLGzOJ6mDqA8J5FHA29FbmD62am+QVY9I
	 5WKdDDwRvJCsA==
Date: Wed, 11 Sep 2024 13:51:50 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuHYtiL1PBr6fG3B@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
 <ZuB3l71L_Gu1Xsrn@kernel.org>
 <ZuCasKhlB4-eGyg0@kernel.org>
 <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>
 <ZuDEJukUYv3yVSQM@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuDEJukUYv3yVSQM@kernel.org>

On Tue, Sep 10, 2024 at 06:11:50PM -0400, Mike Snitzer wrote:
> On Tue, Sep 10, 2024 at 04:31:23PM -0400, Anna Schumaker wrote:
> > Hi Mike,
> > 
> > On 9/10/24 3:14 PM, Mike Snitzer wrote:
> > > 
> > > In case it helps, I did just rebase LOCALIO (v16 + 1 fix) ontop of
> > > cel/nfsd-next (v6.11-rc6 based), and I've pushed the result here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
> > 
> > I'm seeing the same hang on generic/525 with your latest branch.
> > 
> > Anna
> 
> Interesting, I just looked at ktest and it shows the regression point
> to be this commit:
>    nfs: implement client support for NFS_LOCALIO_PROGRAM
> 
> See:
> https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next&test=^fs.nfs.fstests.generic.525$
> 
> I think 525 has been like this for a while, really not sure why I
> ignored it... will dig deeper!

I haven't found/fixed this yet but when LOCALIO is used
xfs_file_buffered_read calls filemap_get_pages and filemap_get_pages
livelocks trying to complete.

Here is ftrace of LOCALIO's xfs_file_buffered_read immediately before
filemap_get_pages never returns (note that for debugging I reverted
the workqueue patch.. so the IO is issued in xfs_io context):

=> entry_SYSCALL_64_after_hwframe
          xfs_io-5609    [007] .....   211.831093: xfs_file_buffered_read: dev 8:16 ino 0x84 disize 0x7fffffffffffffff pos 0x7ffffffffffff000 bytecount 0x1000
          xfs_io-5609    [007] ...1.   211.831098: <stack trace>
 => trace_event_raw_event_xfs_file_class
 => xfs_file_buffered_read
 => xfs_file_read_iter
 => nfs_local_doio
 => nfs_initiate_pgio
 => nfs_generic_pg_pgios
 => nfs_pageio_doio
 => nfs_pageio_complete
 => nfs_pageio_complete_read
 => nfs_readahead
 => read_pages
 => page_cache_ra_unbounded
 => page_cache_sync_ra
 => filemap_get_pages
 => filemap_read
 => generic_file_read_iter
 => nfs_file_read
 => vfs_read
 => __x64_sys_pread64
 => x64_sys_call
 => do_syscall_64

Here is the same when testing only against XFS:

 => entry_SYSCALL_64_after_hwframe
          xfs_io-3451    [015] .....  1034.767416: xfs_file_buffered_read: dev 8:16 ino 0x84 disize 0x7fffffffffffffff pos 0x7ffffffffffffffe bytecount 0x1
          xfs_io-3451    [015] ...1.  1034.767418: <stack trace>
 => trace_event_raw_event_xfs_file_class
 => xfs_file_buffered_read
 => xfs_file_read_iter
 => vfs_read
 => __x64_sys_pread64
 => x64_sys_call
 => do_syscall_64

Will keep after this with urgency, just wanted to let you know what I
have found so far...

Thanks,
Mike

