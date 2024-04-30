Return-Path: <linux-fsdevel+bounces-18384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDF8B81B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFD2284AC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1F41A38C2;
	Tue, 30 Apr 2024 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="reW6wlvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD88F6E;
	Tue, 30 Apr 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714510897; cv=none; b=SMH2u8jopQ29F4KYJX1i5wSGqbSLTGznLDXHedsLhrVGM2QTd07ApuO9HFLG17Ge5vAAkx9kF76/Ix/LFoEAeIBkkHMH2ek91SYY+yruyuQ0DHoslnuZsx2PZc+XQdQ6yADvR2SMrbzYoFIIrBwjuUHG2Or2732Oq9401W9u/Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714510897; c=relaxed/simple;
	bh=ivAeT8Lh4hTJJoOvGma6HWl1YOPnEPRgEYoTLHjirCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYYWuSrZaJEaFtpSrgy2j69Zx/QX+stECqVK4wC9QZq1zQS7pJxsUpxTGWOPDd4v4g69rBnDG3HN1Uhcea8+KWtnNftux5pnFK0Pn840qNN5lchSIqoZXUsDuuWlHMUsYQS3TAn+tp2WACtLWTtis3RVF3Nl9GKSU6kyXuS2//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=reW6wlvQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yPx7hXYNWdm8HsLrOMtYckL5fyGc+4ZNrlVxqpRmA3c=; b=reW6wlvQ6JU/8Zc/bx4AUuZHpd
	cncMdTPtYZ+Xfbp8fRosXOGkj0Qe9qeZQGSZMwqe9m124aYjJFf2qha0bgADfZvZlMF+9h5am+R9X
	SI2FeiyRXBUZlfCWEgmawzcsJYVKokkbTdUM7ahhc4/+LZGmjbnqT4JYEBUmefACODSkz7wuYJ/Xe
	tlEuP7NYmxbW2dIBZyo8f2Lf32Sr2nxgMeaPADT8wdzIBKZB7ghJjdWhAIQYGhl9+lIgFM5zkVMlv
	yphG0qermw6JDG1nP6dmYZE30taJSP1BodvfnF6p8zJAZxggdc+rPa25lJPDJj0bZAeQPBbTowxjo
	JIZaF9kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1ubD-0000000FZHT-1b7j;
	Tue, 30 Apr 2024 21:01:15 +0000
Date: Tue, 30 Apr 2024 22:01:15 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Groves <John@groves.net>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev, John Groves <jgroves@micron.com>,
	john@jagalactic.com, Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com,
	gregory.price@memverge.com, Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 00/12] Introduce the famfs shared-memory file
 system
Message-ID: <ZjFcG9Q1CegMPj_7@casper.infradead.org>
References: <cover.1714409084.git.john@groves.net>
 <Zi_n15gvA89rGZa_@casper.infradead.org>
 <c3mhc33u4yqhd75xc2ew53iuumg3c2vi3nk3msupt35fj7qkrp@pve6htn64e7c>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3mhc33u4yqhd75xc2ew53iuumg3c2vi3nk3msupt35fj7qkrp@pve6htn64e7c>

On Mon, Apr 29, 2024 at 09:11:52PM -0500, John Groves wrote:
> On 24/04/29 07:32PM, Matthew Wilcox wrote:
> > On Mon, Apr 29, 2024 at 12:04:16PM -0500, John Groves wrote:
> > > This patch set introduces famfs[1] - a special-purpose fs-dax file system
> > > for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> > > CXL-specific in anyway way.
> > > 
> > > * Famfs creates a simple access method for storing and sharing data in
> > >   sharable memory. The memory is exposed and accessed as memory-mappable
> > >   dax files.
> > > * Famfs supports multiple hosts mounting the same file system from the
> > >   same memory (something existing fs-dax file systems don't do).
> > 
> > Yes, but we do already have two filesystems that support shared storage,
> > and are rather more advanced than famfs -- GFS2 and OCFS2.  What are
> > the pros and cons of improving either of those to support DAX rather
> > than starting again with a new filesystem?
> > 
> 
> Thanks for paying attention to this Willy.

Well, don't mistake this for an endorsement!  I remain convinced that
this is a science project, not a product.  I am hugely sceptical of
disaggregated systems, mostly because I've seen so many fail.  And they
rarely attempt to answer the "janitor tripped over the cable" problem,
the "we need to upgrade the firmware on the switch" problem, or a bunch
of other problems I've outlined in the past on this list.

So I am not supportive of any changes you want to make to the core kernel
to support this kind of adventure.  Play in your own sandbox all you
like, but not one line of code change in the core.  Unless it's something
generally beneficial, of course; you mentioned refactoring DAX and that
might be a good thing for everybody.

> * Famfs is not, not, not a general purpose file system.
> * One can think of famfs as a shared memory allocator where allocations can be
>   accessed as files. For certain data analytics work flows (especially 
>   involving Apache Arrow data frames) this is really powerful. Consumers of
>   data frames commonly use mmap(MAP_SHARED), and can benefit from the memory
>   de-duplication of shared memory and don't need any new abstractions.

... and are OK with the extra latency?

> * Famfs is not really a data storage tool. It's more of a shared-memroy 
>   allocation tool that has the benefit of allocations being accesssible 
>   (and memory-mappable) as files. So a lot of software can automatically use 
>   it.
> * Famfs is oriented to dumping sharable data into files and then allowing a
>   scale-out cluster to share it (often read-only) to access a single copy in
>   shared memory.

Depending on the exact workload, I can see this being more efficient
than replicating the data to each member of the cluster.  In other
workloads, it'll be a loss, of course.

> * I'm no expert on GFS2 or OCFS2, but I've been around memory, file systems 
>   and storage since well before the turn of the century...
> * If you had brought up the existing fs-dax file systems, I would have pointed
>   that they use write-back metadata, which does not reconcile with shared
>   access to media - but these file systems do handle that.
> * The shared media file systems are still oriented to block devices that
>   provide durable storage and page-oriented access. CXL DRAM is a character 

I'd say "block oriented" rather than page oriented, but I agree.

>   dax (devdax) device and does not provide durable storage.
> * fs-dax-style memory mapping for volatile cxl memory requires the 
>   dev_dax_iomap portion of this patch set - or something similar. 
> * A scale-out shared media file system presumably requires some commitment to
>   configure and manage some complexity in a distributed environment; whether
>   that should be mandatory for enablement of shared memory is worthy of
>   discussion.
> * Adding memory to the storage tier for GFS2/OCFS2 would add non-persistent
>   media to the storage tier; whether this makes sense would be a topic that
>   GFS2/OCFS2 developers/architects should get involved in if they're 
>   interested.
> 
> Although disaggregated shared memory is not commercially available yet, famfs 
> is being actively tested by multiple companies for several use cases and 
> patterns with real and simulated shared memory. Demonstrations will start to
> surface in the coming weeks & months.

I guess we'll see.  SGI died for a reason.

