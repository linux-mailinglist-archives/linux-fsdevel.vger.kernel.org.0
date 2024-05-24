Return-Path: <linux-fsdevel+bounces-20109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECD8CE521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 14:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3153F1C214AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 12:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B486267;
	Fri, 24 May 2024 12:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lepPuE9q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923DF83CCC;
	Fri, 24 May 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716553124; cv=none; b=awCYFAlhdJYAS4r9laLNuH97PF3SVZ9pB1IgP6QCyWh1wynYgr/83TixPTLGdwUd6lxcqQGDEAsbupYQSfXn5r24V1UlYDyDpEXEMGuq52d/PHNcz21tu6WD8J88UYv5xtfuh2worvXk9haDGQTwaxBTDV1Ffi64Q3WPJ08KTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716553124; c=relaxed/simple;
	bh=7lqilfxHEeNt7OyvbNoz9CUGiZAgzoC5RAd+VQwnTuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PF7d1UR4/wfZd8QcnXpCLv21IVAoKIHwSZW5TxPo36QbThlWWFVzhw+9YPQolBDHJD8LQmXO6qlLfts39KV/aurSV3JIFVMJJxwuRlConacc5VzLIC1B5zti3XHLFSyLgZsk9H26V5CWqAIlivSPRGHgNMjCPfJ9Ns5ZO1nD4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lepPuE9q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vbEsMDh+E9GqojdWiKM6c4copHUEF+ZhaKXyW3Xhetg=; b=lepPuE9qDtPJho7Qxv+ml69iYD
	wqnNO1/3aCN7fNuLsBd8G0XhyWdw4M2ziQxVY5tnpCy2WZKPGpDleB/ZH19zsCAVu8t+zSv5oYHoi
	wS/D2d1niHKRzC1x8CIdC1V99uG9jWbAoGVrMDRCIuBJA3W+qyDKmcpLA/eKI4JV94hQGdH8BQEwl
	KkID2EDDDMlVWh40oHOZBw0NHzL14zga0Bfcy1iYkjcEQ5APE1K53L7MBN2+prAeu78BVaQyqNene
	urU4eZx4ZtLhE1Y6LJebQj+F+ZKBdOgQrM1opPychQlvObh07XyEdMfBmaYetiFOaYu0c4YavDAUh
	Q/AoXQUw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sATsc-00000002eqS-2EiW;
	Fri, 24 May 2024 12:18:38 +0000
Date: Fri, 24 May 2024 13:18:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: brauner@kernel.org, djwong@kernel.org, akpm@linux-foundation.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, jun.li@nxp.com
Subject: Re: [PATCH v5 2/2] iomap: fault in smaller chunks for non-large
 folio mappings
Message-ID: <ZlCFnlXPPUo_0mYX@casper.infradead.org>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
 <20240521114939.2541461-2-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521114939.2541461-2-xu.yang_2@nxp.com>

On Tue, May 21, 2024 at 07:49:39PM +0800, Xu Yang wrote:
> Since commit (5d8edfb900d5 "iomap: Copy larger chunks from userspace"),
> iomap will try to copy in larger chunks than PAGE_SIZE. However, if the
> mapping doesn't support large folio, only one page of maximum 4KB will
> be created and 4KB data will be writen to pagecache each time. Then,
> next 4KB will be handled in next iteration. This will cause potential
> write performance problem.
> 
> If chunk is 2MB, total 512 pages need to be handled finally. During this
> period, fault_in_iov_iter_readable() is called to check iov_iter readable
> validity. Since only 4KB will be handled each time, below address space
> will be checked over and over again:
> 
> start         	end
> -
> buf,    	buf+2MB
> buf+4KB, 	buf+2MB
> buf+8KB, 	buf+2MB
> ...
> buf+2044KB 	buf+2MB
> 
> Obviously the checking size is wrong since only 4KB will be handled each
> time. So this will get a correct chunk to let iomap work well in non-large
> folio case.
> 
> With this change, the write speed will be stable. Tested on ARM64 device.
> 
> Before:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (334 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (278 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (204 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (170 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (150 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (139 MB/s)
> 
> After:
> 
>  - dd if=/dev/zero of=/dev/sda bs=400K  count=10485  (339 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=800K  count=5242   (330 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=1600K count=2621   (332 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=2200K count=1906   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=3000K count=1398   (333 MB/s)
>  - dd if=/dev/zero of=/dev/sda bs=4500K count=932    (333 MB/s)
> 
> Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
> Cc: stable@vger.kernel.org
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

