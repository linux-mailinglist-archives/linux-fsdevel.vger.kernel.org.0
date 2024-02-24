Return-Path: <linux-fsdevel+bounces-12636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCE88620FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C56C1B23C8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 00:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC528EC7;
	Sat, 24 Feb 2024 00:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JMNC8ZBC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F8182;
	Sat, 24 Feb 2024 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733228; cv=none; b=gIw1o0NZfQVKpazyYA7bkruQesUGtzBhXQZ3rf3JN95+ohgGWD9JDXV+ji86s4cMKfVc747WK9ITwJjcTLF7J2JCxfSel/iDJFsbZezDFDYjsR1XvxLz9VRnUG/gSBBP3NgoH/N2DnNOwtTsRXW8AL/aEqrCL10GBP0eXpMh9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733228; c=relaxed/simple;
	bh=qiyDaquhNDRAD1bYDTLfWk1m9ilGG/A8+ouVFaiFqpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+u7w/LOJTVtV+6cW7HdNaEFzZQXVsRVosLU759wO6n4nRcdJ/n4XARuuV6hFjfWESJnFGqmS45lqiLEWxy0C6/1tepYIfcCmAeiSkSda9pke9a3YDXHl4lvwOFBRW/OAp/LX8pDzBfnspsWfbKkt9BsivwMnTHcJxLty+KxKwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JMNC8ZBC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RLXEC5G8zhOhURItJOCbBXesZ2wGukLrzFwY7ETSkMI=; b=JMNC8ZBC5npFRya4vizIt421Eo
	ohsVaPKre0JMqxNQ5HzWUFhhQsj5ugPe6sGbwLSr5gwRiQlVAPIRt7y6Ut1VGhCXzeKQPdEXgLhAi
	2frsNgx9A7EtvYTXfxh140Wf6Hxeyb5qEZjTxbcI6O000chegytsaOh9Q/5Le0jFYnI7U2dcJVgyY
	dZSbIqoaBjiODzFG8jyo/3TTl3dZWgSyBQV1ZLkLmSFIgqkcIJfkcx0AVprz5f0vULXIHYDorH26q
	t4MULcYnZ3kcXgZgzig4+LBYkCLINsoOoNmDqY9fz+sPR17dal6kO/0yyuCd8WOMiaWqIpzDxz0Pc
	j9LevlwA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfZE-0000000Bdrq-0xdy;
	Sat, 24 Feb 2024 00:07:00 +0000
Date: Fri, 23 Feb 2024 16:07:00 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Groves <John@groves.net>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
Message-ID: <ZdkzJM6sze-p3EWP@bombadil.infradead.org>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708709155.git.john@groves.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 23, 2024 at 11:41:44AM -0600, John Groves wrote:
> This patch set introduces famfs[1] - a special-purpose fs-dax file system
> for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> CXL-specific in anyway way.
> 
> * Famfs creates a simple access method for storing and sharing data in
>   sharable memory. The memory is exposed and accessed as memory-mappable
>   dax files.
> * Famfs supports multiple hosts mounting the same file system from the
>   same memory (something existing fs-dax file systems don't do).
> * A famfs file system can be created on either a /dev/pmem device in fs-dax
>   mode, or a /dev/dax device in devdax mode (the latter depending on
>   patches 2-6 of this series).
> 
> The famfs kernel file system is part the famfs framework; additional
> components in user space[2] handle metadata and direct the famfs kernel
> module to instantiate files that map to specific memory. The famfs user
> space has documentation and a reasonably thorough test suite.
> 
> The famfs kernel module never accesses the shared memory directly (either
> data or metadata). Because of this, shared memory managed by the famfs
> framework does not create a RAS "blast radius" problem that should be able
> to crash or de-stabilize the kernel. Poison or timeouts in famfs memory
> can be expected to kill apps via SIGBUS and cause mounts to be disabled
> due to memory failure notifications.
> 
> Famfs does not attempt to solve concurrency or coherency problems for apps,
> although it does solve these problems in regard to its own data structures.
> Apps may encounter hard concurrency problems, but there are use cases that
> are imminently useful and uncomplicated from a concurrency perspective:
> serial sharing is one (only one host at a time has access), and read-only
> concurrent sharing is another (all hosts can read-cache without worry).

Can you do me a favor, curious if you can run a test like this:

fio -name=ten-1g-per-thread --nrfiles=10 -bs=2M -ioengine=io_uring                                                                                                                            
-direct=1                                                                                                                                                                                    
--group_reporting=1 --alloc-size=1048576 --filesize=1GiB                                                                                                                                      
--readwrite=write --fallocate=none --numjobs=$(nproc) --create_on_open=1                                                                                                                      
--directory=/mnt 

What do you get for throughput?

The absolute large the system an capacity the better.

  Luis

