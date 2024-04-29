Return-Path: <linux-fsdevel+bounces-18194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160CB8B6607
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 01:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B191C21281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 23:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC5284A5E;
	Mon, 29 Apr 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LSh/yfjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5432E405
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 23:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432145; cv=none; b=PZ4bheveAJP7LKywve0GPy8RKV9DaRVt5m6EJHbbPNf5u+WEmIUPGgsWWPqJLkSWTfSvn7JBsyoj3Vhdop9FmstQ8p20hWUUI5zkqRCakhupi37EloL1TQoFGhey3qHW5Q0e2YRqeGYbB7uTl8aci6FZ7W7sWWrAIFFAdb9KI4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432145; c=relaxed/simple;
	bh=AEAH8exKNz4knmfC1O0N+nEgfn40+sZgNmZcwVLQ6QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX3JNCcN7Vi755YNFrkSY1+VfqHcpaJMiinTAyiCSMyHlEpWmRt8NdJgXYIvAPb1ddzZaVJrKK82QEqe12glxw5B8DBv5YzOwLrdyYLrqLDM+NF+XhWiel92XUcDqF5DHvarpcRT80IP2smPF4FJ1otstL+94TWo5zF68409zV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LSh/yfjW; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Apr 2024 19:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714432141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=htYHWFMQsyYauBANgReCo0euuOxBTGJaDScLWDMs8Lg=;
	b=LSh/yfjWBKvTbYn2vCCM1tqRMDPa3kyxLO2NcmHo3Cei764O+x8CJRBPRtXY1eIwOwD2q4
	b3RKdb6QDKzT5XZ1yMFsz4F6yc1unRErKghqhb6TIXlryGBl4pM8LI2yT0Jx66VbG6GHP0
	pburKIChfsZZbBNHQtkK0CLaoqqhGuI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: John Groves <John@groves.net>, Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	John Groves <jgroves@micron.com>, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Randy Dunlap <rdunlap@infradead.org>, Jerome Glisse <jglisse@google.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ravi Shankar <venkataravis@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chandan Babu R <chandanbabu@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Steve French <stfrench@microsoft.com>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Stanislav Fomichev <sdf@google.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 00/12] Introduce the famfs shared-memory file
 system
Message-ID: <bnkdeobpatyunljvujzvwydtixkkj3gfeyvk4pzgndfxo7uc32@y6lk7nplt3uk>
References: <cover.1714409084.git.john@groves.net>
 <Zi_n15gvA89rGZa_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi_n15gvA89rGZa_@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 29, 2024 at 07:32:55PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 29, 2024 at 12:04:16PM -0500, John Groves wrote:
> > This patch set introduces famfs[1] - a special-purpose fs-dax file system
> > for sharable disaggregated or fabric-attached memory (FAM). Famfs is not
> > CXL-specific in anyway way.
> > 
> > * Famfs creates a simple access method for storing and sharing data in
> >   sharable memory. The memory is exposed and accessed as memory-mappable
> >   dax files.
> > * Famfs supports multiple hosts mounting the same file system from the
> >   same memory (something existing fs-dax file systems don't do).
> 
> Yes, but we do already have two filesystems that support shared storage,
> and are rather more advanced than famfs -- GFS2 and OCFS2.  What are
> the pros and cons of improving either of those to support DAX rather
> than starting again with a new filesystem?

I could see a shared memory filesystem as being a completely different
beast than a shared block storage filesystem - and I've never heard
anyone talking about gfs2 or ocfs2 as codebases we particularly liked.

This looks like it might not even be persistent? Does it survive a
reboot? If not, that means it'll be much smaller than a conventional
filesystem.

But yeah, a bit more on where this is headed would be nice.

Another concern is that every filesystem tends to be another huge
monolithic codebase without a lot of code sharing between them - how
much are we going to be adding in the end?

Can we start looking for more code sharing, more library code to factor
out?

Some description of the internal data structures would really help here.

